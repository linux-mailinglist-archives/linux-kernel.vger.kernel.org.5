Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790017F0BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 06:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjKTFwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 00:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTFwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 00:52:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCA5C5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 21:52:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D111C43391
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700459532;
        bh=E9ujdWu0JkGB4tMSSGQ3StztKVc8mtmrd8/ujNEDyM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IKm20+6aNU+9zmsyjxbzhJ8v/v6iuMU4T5yewPrRS6d8F/f11vTn+9mZJDnA/Egs/
         C2oxO1RqQCidkeHQZhOATAO5styFoWTJlOCIZUbCxOPyNJJdTxj7c4ceW2NJPHVBiQ
         UFFQSvpjYbr106i4hx+io3+bwlt7kkA/g3yPBdhw6yzWlbrJsbveGhV+EoAXBk3frl
         XJ/P6XDjdqTlpOMPuejNCc5u+h2ZHWAf3jSRBSHt7Yyt1gPKY1rtC6d1KRgAUDEjJF
         MkWyBq1Tg+6RRCgfIO96OjdpEyJ2CTasJ1TpxKSdAemB3Nv/K2gBk+RkzYE5opGJ+r
         W2jhKZy+zRS5g==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2802b744e52so3408920a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 21:52:12 -0800 (PST)
X-Gm-Message-State: AOJu0YxFpJtRMyitQFqdVnPNTxGm6fH4hDEqjlYGQoFOOY/2mWjEubX6
        36jt1dXUdTDJP6kl8FhROg8ECIS6OUZIbqr++7OqRA==
X-Google-Smtp-Source: AGHT+IE3qF+oceFmrIg2tp0+GlshfobpGrvJFpdBGakK0Urr/+KVJvWIUpUNnZuclGspy1xHAxMCD0Zq2eW5kgqs3W4=
X-Received: by 2002:a17:90b:3b82:b0:281:d84:a97e with SMTP id
 pc2-20020a17090b3b8200b002810d84a97emr9133820pjb.2.1700459531497; Sun, 19 Nov
 2023 21:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
 <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuPs=O7dKQYWAyM5N1UPyCkEmaCb9REHmNvAi7o4tPbMDg@mail.gmail.com>
 <87v89xasq0.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v89xasq0.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Sun, 19 Nov 2023 21:51:59 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMB8VOvUUssgULnBZnnA00tdW9itXKqwvxReynV1Q6K_Q@mail.gmail.com>
Message-ID: <CAF8kJuMB8VOvUUssgULnBZnnA00tdW9itXKqwvxReynV1Q6K_Q@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 9:41=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Sun, Nov 19, 2023 at 7:20=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
>
> Per my understanding, memcg uncharging happens in
>
> swapcache_free_entries()
>   swap_entry_free()
>     mem_cgroup_uncharge_swap()
>
> The swap entries are uncharged one-by-one, not

Yes. That matches my understanding as well.
I think I am using the term "batching" very loosely. My bad and thanks
for the clarification.

I am referring to the fact that in most cases, the free_swap_slot()
does not perform uncharge.
It is grouped together with other entries to uncharge together inside
swapcache_free_entries(). Yes, the uncharge itself is done by a for
loop page by page. No batching in the for loop. BTW, Not all uncharges
can be batched, because they can come from different memcg.

Chris
