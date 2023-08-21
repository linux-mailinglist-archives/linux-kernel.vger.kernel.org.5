Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C48782131
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjHUBaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjHUBaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:30:19 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B639C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:30:16 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 37L1U5A4082532;
        Mon, 21 Aug 2023 09:30:05 +0800 (+08)
        (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Mon, 21 Aug 2023 09:30:02 +0800
Date:   Mon, 21 Aug 2023 09:29:58 +0800
From:   Leo Liang <ycliang@andestech.com>
To:     <chengming.zhou@linux.dev>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <zhouchengming@bytedance.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Fix cfs_rq_is_decayed() on !SMP
Message-ID: <ZOK92_xLVsMmIEDE@swlinux02>
References: <ZN87UsqkWcFLDxea@swlinux02>
 <20230818132148.2237811-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230818132148.2237811-1-chengming.zhou@linux.dev>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 37L1U5A4082532
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chengming,

On Fri, Aug 18, 2023 at 09:21:48PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We don't need to maintain per-queue leaf_cfs_rq_list on !SMP, since
> it's used for cfs_rq load tracking & balance on SMP.
> 
> But sched debug interface use it to print per-cfs_rq stats, which
> maybe better to change to use walk_tg_tree_from() instead.
> 
> This patch just fix the !SMP version cfs_rq_is_decayed(), so the
> per-queue leaf_cfs_rq_list is also maintained correctly on !SMP,
> to fix the warning in assert_list_leaf_cfs_rq().
> 
> Fixes: 0a00a354644e ("sched/fair: Delete useless condition in tg_unthrottle_up()")
> Reported-by: Leo Liang <ycliang@andestech.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the quick patch!

Tested-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Best regards,
Leo
