Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31321790A47
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 01:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjIBXpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 19:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjIBXpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 19:45:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C0CDA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 16:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE314B80881
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 23:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D62C433C8;
        Sat,  2 Sep 2023 23:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1693698295;
        bh=jpQSr96KlatRbZ8R/nic2I0f6SFBUT8Y98to5zAR+1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s9cn8/uDfxsYsG3KDfiHQ0DbmNta7Y9fCJjPjIoznSkzIZO14QACY/dnlFMillS4z
         vKRqKxUSRuv08Tt9BbOImh/ZcjLmsrV2bcgmyU2zL6P/h9z9uAGY1ntz1YstCSqf6Q
         Ov3fbVmBxeuZH4xMZGAjgJYTXLayY7isCSUgd2ww=
Date:   Sat, 2 Sep 2023 16:44:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "liwenyu01@bilibili.com" <liwenyu01@bilibili.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangyun@bilibili.com" <wangyun@bilibili.com>
Subject: Re: [PATCH RFC] delayacct: add memory reclaim delay in
 get_page_from_freelist
Message-Id: <20230902164454.30dda58820ced683849b45cb@linux-foundation.org>
In-Reply-To: <SH0PR01MB0587E4A7886C9642CCF1F8DBC1E5A@SH0PR01MB0587.CHNPR01.prod.partner.outlook.cn>
References: <SH0PR01MB058780B26AB21BEB8E76B6BBC11CA@SH0PR01MB0587.CHNPR01.prod.partner.outlook.cn>
        <SH0PR01MB0587E4A7886C9642CCF1F8DBC1E5A@SH0PR01MB0587.CHNPR01.prod.partner.outlook.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 07:26:20 +0000 "liwenyu01@bilibili.com" <liwenyu01@bilibili.com> wrote:

> reclaim of the task in do_try_to_free_pages(). In systems with NUMA
> open, some tasks occasionally experience slower response times, but the
> total count of reclaim does not increase, using ftrace can show that
> node_reclaim has occurred.
> 
> The memory reclaim occurring in get_page_from_freelist() is also due to
> heavy memory load. To get the impact of tasks in memory reclaim, this
> patch adds the statistics of the memory reclaim delay statistics for
> __node_reclaim().
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -8010,6 +8010,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
> 
>         cond_resched();
>         psi_memstall_enter(&pflags);
> +       delayacct_freepages_start();
>         fs_reclaim_acquire(sc.gfp_mask);
>         /*
>          * We need to be able to allocate from the reserves for RECLAIM_UNMAP
> @@ -8032,6 +8033,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>         memalloc_noreclaim_restore(noreclaim_flag);
>         fs_reclaim_release(sc.gfp_mask);
>         psi_memstall_leave(&pflags);
> +       delayacct_freepages_end();
> 
>         trace_mm_vmscan_node_reclaim_end(sc.nr_reclaimed);

__node_reclaim() calls shrink_node() which at some point will call
do_try_to_free_pages() (yes?), which calls delayacct_freepages_start().

So we're effectively nesting calls to delayacct_freepages_start(),
which isn't designed for that?
