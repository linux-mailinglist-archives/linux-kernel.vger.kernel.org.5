Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551E37AE0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjIYVgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjIYVgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:36:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52202CE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 14:36:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A892C433C9;
        Mon, 25 Sep 2023 21:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695677784;
        bh=u4uv3DNKD0E0OuUaQU04JetZHmO/2pYOxTl9tE5dGww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=le9+MgwVi4N5+F9Uv4AIUXziNl8bJUB2zWxVlerYDjUSun6niHz+jfuQGiyaNWoeK
         DlMrAy4Q5GHkT0m1pXLRmYnUDgyPb05BFYzqcuKGzmjGqkXdkBLzhqNwyRqNL+UwSF
         p6j0/T8qHCktMPqRJTJFC1GT7s2TAY5C9EpXDjKgN1Ku7gjFNtG4bjRV8NBPYhroKP
         Ths1gi4tx/fezjOqNtev/2cUrbEBbb0TMU0DeamRZ3bpgpuLd+QwhEDTBcPPp2MNKN
         pZL+o3SZOhQMk749fH/hQ+i9Z9FpoNIGoCwKUSRJIg1i3v+CIB2QQg0OTOpPAo3RzJ
         Pf1PGmOl0Femw==
From:   SeongJae Park <sj@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     rostedt@goodmis.org, tjmercier@google.com, yuzhao@google.com,
        kaleshsingh@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH v3] vmscan: add trace events for lru_gen
Date:   Mon, 25 Sep 2023 21:36:19 +0000
Message-Id: <20230925213619.263131-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230924142343.23924-1-jaewon31.kim@samsung.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 24 Sep 2023 23:23:43 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:

> As the legacy lru provides, the lru_gen needs some trace events for
> debugging.
> 
> This commit introduces 2 trace events.
>   trace_mm_vmscan_lru_gen_scan
>   trace_mm_vmscan_lru_gen_evict
> 
> Each event is similar to the following legacy events.
>   trace_mm_vmscan_lru_isolate,
>   trace_mm_vmscan_lru_shrink_[in]active
> 
> Here's an example
>   mm_vmscan_lru_gen_scan: isolate_mode=0 classzone=1 order=9 nr_requested=4096 nr_scanned=431 nr_skipped=0 nr_taken=55 lru=anon
>   mm_vmscan_lru_gen_evict: nid=0 nr_reclaimed=42 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=13 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2 flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
>   mm_vmscan_lru_gen_scan: isolate_mode=0 classzone=1 order=9 nr_requested=4096 nr_scanned=66 nr_skipped=0 nr_taken=64 lru=file
>   mm_vmscan_lru_gen_evict: nid=0 nr_reclaimed=62 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=2 nr_ref_keep=0 nr_unmap_fail=0 priority=2 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
> 
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
> ---
> v3: change printk format
> v2: use condition and make it aligned
> v1: introduce trace events
> ---
>  include/trace/events/mmflags.h |  5 ++
>  include/trace/events/vmscan.h  | 98 ++++++++++++++++++++++++++++++++++
>  mm/vmscan.c                    | 17 ++++--
>  3 files changed, 115 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 1478b9dd05fa..44e9b38f83e7 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -274,6 +274,10 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
>  		EM (LRU_ACTIVE_FILE, "active_file") \
>  		EMe(LRU_UNEVICTABLE, "unevictable")
>  
> +#define LRU_GEN_NAMES		\
> +		EM (LRU_GEN_ANON, "anon") \
> +		EMe(LRU_GEN_FILE, "file")
> +

I found this patchset makes build fails when !CONFIG_LRU_GEN, like below:

    In file included from /linux/include/trace/trace_events.h:27,
                     from /linux/include/trace/define_trace.h:102,
                     from /linux/include/trace/events/oom.h:195,
                     from /linux/mm/oom_kill.c:53:
    /linux/include/trace/events/mmflags.h:278:7: error: ‘LRU_GEN_ANON’ undeclared here (not in a function); did you mean ‘LRU_GEN_PGOFF’?
      278 |   EM (LRU_GEN_ANON, "anon") \
          |       ^~~~~~~~~~~~

Maybe some config checks are needed?


Thanks,
SJ

[...]
