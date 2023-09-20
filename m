Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BF27A869B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjITOcI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Sep 2023 10:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjITOcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:32:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7B9D3;
        Wed, 20 Sep 2023 07:32:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90317C433C7;
        Wed, 20 Sep 2023 14:31:58 +0000 (UTC)
Date:   Wed, 20 Sep 2023 10:32:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
Cc:     "yuzhao@google.com" <yuzhao@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "kaleshsingh@google.com" <kaleshsingh@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: (2) [PATCH] vmscan: add trace events for lru_gen
Message-ID: <20230920103233.145ac387@gandalf.local.home>
In-Reply-To: <20230920074948epcms1p82d18c2f4d6a0b5699d50fc419b9ba9fe@epcms1p8>
References: <20230919095927.5a964094@gandalf.local.home>
        <20230919025216.1878-1-jaewon31.kim@samsung.com>
        <CGME20230919025012epcas1p2c2c57a34eea3299ef3bb643f4cbddf0b@epcms1p8>
        <20230920074948epcms1p82d18c2f4d6a0b5699d50fc419b9ba9fe@epcms1p8>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 16:49:48 +0900
김재원 <jaewon31.kim@samsung.com> wrote:

> Great. Thank you for your comment.
> 
> For the putting the struct scan_control *sc inside the trace,
> I couldn't do that because struct scan_control is defined in mm/vmscan.c.
> I think I should not move it to a seperate header file.

Well if you ever decide to do so, one thing to do is to move the
trace/events/vmscan.h into mm/ as trace_vmscan.h so that it would have
access to local header files. Then all you need to do is to move the
struct scan_control into a local mm/X.h header file.

> 
> As you may expect, I just made this by copying the existing
> trace_mm_vmscan_lru_isolate and trace_mm_vmscan_lru_shrink_inactive
> 
> I've tried to change like this.
> Would this be good for you?

The below looks fine to me. Thanks.

-- Steve

> 
> 
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -327,7 +327,7 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>                 __print_symbolic(__entry->lru, LRU_NAMES))
>  );
>  
> -TRACE_EVENT(mm_vmscan_lru_gen_scan,
> +TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
>         TP_PROTO(int highest_zoneidx,
>                 int order,
>                 unsigned long nr_requested,
> @@ -339,6 +339,8 @@ TRACE_EVENT(mm_vmscan_lru_gen_scan,
>  
>         TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, isolate_mode, lru),
>  
> +       TP_CONDITION(nr_scanned),
> +
>         TP_STRUCT__entry(
>                 __field(int, highest_zoneidx)
>                 __field(int, order)
> @@ -494,7 +496,6 @@ TRACE_EVENT(mm_vmscan_lru_gen_evict,
>         TP_ARGS(nid, nr_reclaimed, stat, priority, file),
>  
>         TP_STRUCT__entry(
> -               __field(int, nid)
>                 __field(unsigned long, nr_reclaimed)
>                 __field(unsigned long, nr_dirty)
>                 __field(unsigned long, nr_writeback)
> @@ -504,6 +505,7 @@ TRACE_EVENT(mm_vmscan_lru_gen_evict,
>                 __field(unsigned int, nr_activate1)
>                 __field(unsigned long, nr_ref_keep)
>                 __field(unsigned long, nr_unmap_fail)
> +               __field(int, nid)
>                 __field(int, priority)
>                 __field(int, reclaim_flags)
>         ),
> 
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5131,10 +5131,9 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>         __count_memcg_events(memcg, PGREFILL, sorted);
>         __count_vm_events(PGSCAN_ANON + type, isolated);
>  
> -       if (scanned)
> -               trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order,
> -                               MAX_LRU_BATCH, scanned, skipped, isolated,
> -                               sc->may_unmap ? 0 : ISOLATE_UNMAPPED, type);
> +       trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
> +                       scanned, skipped, isolated,
> +                       sc->may_unmap ? 0 : ISOLATE_UNMAPPED, type);
> 
> 
> 
> >
