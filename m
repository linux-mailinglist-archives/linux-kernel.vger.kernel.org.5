Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A374F7EFC22
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjKQXbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKQXbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:31:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56FE10C6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:30:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F75C43391
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700263859;
        bh=MxCPYy5kUatJTIY6M2Tqvw3A922+W1+I5g1OrUTLUO8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=asqiPxQIPrmTKcFb8pFg6OTUo/VlrKDTv0k4mwF/U38B/Qhz9T+gHOV/rgc9bvZfV
         FYWt8aFZU7t2oHZuKsFOP0cGW/rfUrPNzpw2ohV9Y6PfRT0iaO1fCm4FIrVO08GiqA
         G91/wxXARjVSD4D130HSIM7q2ee1yX4IQDLZDgdQwUuwEd9NJnR7uqQ0SgyG714NlG
         iHR1blO44GTlFcbHIFI0fxTFfCU5yolRNUAzEjLC6MIANX6TInhXj8aD/shzAIPk5W
         zrt4aBNmIfkf0L4hDYsVgboP31Q2xDBMX8IvBGso2F3Bvt6pN0400j+sp1NxYop40g
         cz7rfPHBqfHZg==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-280109daaaaso2006217a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:30:59 -0800 (PST)
X-Gm-Message-State: AOJu0Yxxgk1tfSauiFnHsaS8zxdvIxZFMaivkAaShkA3+ABvIZ79hMCn
        Kp7jToz5bBT6+qOJdD0XpFjR3LF247gq3S2/bE4oXw==
X-Google-Smtp-Source: AGHT+IH14rVOorJ2If+Q8StwAgr2E5ZyK0X9DJUDaw+12/QWtAJqRjHW7fLRWVsjOJOEAv8KuVta1MvKZednfTklLeQ=
X-Received: by 2002:a17:90a:e7c3:b0:280:99f0:4234 with SMTP id
 kb3-20020a17090ae7c300b0028099f04234mr1017570pjb.7.1700263858601; Fri, 17 Nov
 2023 15:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com> <CAJD7tkahj=QkNj1PBfzGRcDyrpE-n5Dbav7VVOVsAFR4vtx9LA@mail.gmail.com>
In-Reply-To: <CAJD7tkahj=QkNj1PBfzGRcDyrpE-n5Dbav7VVOVsAFR4vtx9LA@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Fri, 17 Nov 2023 15:30:47 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNAfzkisG3ukYNuWY6CDSKQ7J6bb0xwFpnSHi0wv3mJWg@mail.gmail.com>
Message-ID: <CAF8kJuNAfzkisG3ukYNuWY6CDSKQ7J6bb0xwFpnSHi0wv3mJWg@mail.gmail.com>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two scenarios
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ying <ying.huang@intel.com>
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

On Thu, Nov 16, 2023 at 12:46=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Thu, Nov 16, 2023 at 12:30=E2=80=AFPM Chris Li <chriscli@google.com> w=
rote:
> >
> > On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > >
> > > Not bypassing the swap slot cache, just make the callbacks to
> > > invalidate the zswap entry, do memg uncharging, etc when the slot is
> > > no longer used and is entering the swap slot cache (i.e. when
> > > free_swap_slot() is called), instead of when draining the swap slot
> > > cache (i.e. when swap_range_free() is called). For all parts of MM
> > > outside of swap, the swap entry is freed when free_swap_slot() is
> > > called. We don't free it immediately because of caching, but this
> > > should be transparent to other parts of MM (e.g. zswap, memcg, etc).
> >
> > That will cancel the batching effect on the swap slot free, making the
> > common case for  swapping  faults take longer to complete, righ?
> > If I recall correctly, the uncharge is the expensive part of the swap
> > slot free operation.
> > I just want to figure out what we are trading off against. This is not
> > one side wins all situations.
>
> Interesting. Maybe we can just move the zswap_invalidate() call to
> save memory early, and leave the memcg uncharge call to be batched?
> IIUC we already do some version of this internally at Google.

I would like to see the patch so I can reason about it better.
Do you have the link for the patch you are talking about?
I can also look up the Google internal one if you have a commit hash.

One thing I would like to find out is whether the behavior of  reusing
swap slots without page writing has been changed.
e.g. Previously if the swap slot can be page out again without
writing/compression again, if the page is not dirty. If we change that
behavior, I would like to understand the trade off better.

Chris
