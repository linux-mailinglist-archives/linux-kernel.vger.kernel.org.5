Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9C97F0B97
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 06:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjKTFbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 00:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTFbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 00:31:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AD7D8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 21:31:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2E3C433D9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700458302;
        bh=1HCXqGJ6ZcQ5roM42J7RYsG2FK1b3wyTgpAEboIgJzQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UaoYNlRzyIugLZng/SrmTERrWhDTm06T0kBvHPARO3bdxonthfjVD7UnooClmF4uh
         0x/qnZ3ZKN2Q3PEIB9GhnHrhkTC5cNLxw8FxnzyZPjjACxBxRhROaQIDyz8GS0ijFX
         gKwhElXcrSdxnNOPpMAwDzihaZ9wt/Rbg+//yigy9Ns54aeortl3rn4Imo9DzKVxaJ
         JJdkq7swFGNqJwEtw9eKgIVZSwmxzzSMjMxGFoy7GKne98RQSBXuL/lDamCDIeoKNt
         P3RIAx8jstLTRL3qAka5M4B7ieedVN8TSjlB8ixc7cTOG5pIm1nbRVOAubamJZvbfn
         u6tgSfxJt726Q==
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so3474783a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 21:31:42 -0800 (PST)
X-Gm-Message-State: AOJu0Yxq8b4lxUukMYe5522XoKl3QcS9wj44cuacIPlgOgOwpDLgnaGg
        Bo3GSBOj1bCvDG3NMnibZNhTIo01rJ0hmZg062Ehdw==
X-Google-Smtp-Source: AGHT+IF+XyiqZDNFegJbF4H2atN+mxdh7CHnI7jFVewEGcVXqFUXIuHD8DirvFwkqD5rEH5aJzxSTDVTBFKyfU6tZQw=
X-Received: by 2002:a17:90b:1a8a:b0:27d:f711:112e with SMTP id
 ng10-20020a17090b1a8a00b0027df711112emr8007586pjb.45.1700458301569; Sun, 19
 Nov 2023 21:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com> <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Sun, 19 Nov 2023 21:31:30 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPs=O7dKQYWAyM5N1UPyCkEmaCb9REHmNvAi7o4tPbMDg@mail.gmail.com>
Message-ID: <CAF8kJuPs=O7dKQYWAyM5N1UPyCkEmaCb9REHmNvAi7o4tPbMDg@mail.gmail.com>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two scenarios
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 7:20=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chriscli@google.com> writes:
>
> > On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > That will cancel the batching effect on the swap slot free, making the
> > common case for  swapping  faults take longer to complete, righ?
> > If I recall correctly, the uncharge is the expensive part of the swap
> > slot free operation.
> > I just want to figure out what we are trading off against. This is not
> > one side wins all situations.
>
> Per my understanding, we don't batch memcg uncharging in
> swap_entry_free() now.  Although it's possible and may improve
> performance.

swap_entry_free() does not do batching, it is at the caller level.

I just checked. The batching is done in free_swap_slot() is still
using swap slot cache and batching.
It uses swapcache_free_entries() to batch free the swap_slots. That is
where the uncharge happens per my understanding.

Chris
