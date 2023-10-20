Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35407D10A9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377439AbjJTNmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377427AbjJTNmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:42:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCD91A4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D9rd6xU5yePrQDC58eLZuz7RrgdD7489xcK5C3D27Ew=; b=mhfhZQzLLz/qRtNyEeyYmpv2La
        ZJlHInop52voq0ZEMb97JM0EhVl41RtI9/OLfK0vU0IJdwKsVi7WMjKU3dj/AWiR02nKb8nuAVKbq
        /nCocBD8VdrzHcaETYQ+JCHAPtBw6/JTfudWLNNAPz06Cf7ZvtcezuwDiWDDPjbYZmEDZMy7CTvMD
        Kla7buaEqoFiiHV9fnMR+8utj7mP3XEGv8nOypvu6035mN5FfYfIH2HJZrf/GgS2Soil2KIhhLX9I
        AJSuZRSAOBgDAgAXuc/v3ZWlNXpZjHs4fyOIzkivtiIGrUPOJFekdBUWME6x4XR4VP2Tje+sPSMMe
        evIoi2Pg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtpko-00DQQf-Vj; Fri, 20 Oct 2023 13:41:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F512300392; Fri, 20 Oct 2023 15:41:30 +0200 (CEST)
Date:   Fri, 20 Oct 2023 15:41:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        gautham.shenoy@amd.com, mgorman@suse.de, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        kprateek.nayak@amd.com, wuyun.abel@bytedance.com
Subject: Re: [PATCH v11 2/3] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <20231020134130.GC33965@noisy.programming.kicks-ass.net>
References: <20231019033323.54147-1-yangyicong@huawei.com>
 <20231019033323.54147-3-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019033323.54147-3-yangyicong@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 11:33:22AM +0800, Yicong Yang wrote:

> @@ -7349,8 +7373,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	 */
>  	if (prev != target && cpus_share_cache(prev, target) &&
>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> -	    asym_fits_cpu(task_util, util_min, util_max, prev))
> -		return prev;
> +	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
> +		if (!static_branch_unlikely(&sched_cluster_active))
> +			return prev;
> +
> +		if (cpus_share_resources(prev, target))
> +			return prev;
> +	}
>  
>  	/*
>  	 * Allow a per-cpu kthread to stack with the wakee if the
> @@ -7377,7 +7406,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
>  	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
>  	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
> -		return recent_used_cpu;
> +		if (!static_branch_unlikely(&sched_cluster_active))
> +			return recent_used_cpu;
> +
> +		if (cpus_share_resources(recent_used_cpu, target))
> +			return recent_used_cpu;
>  	}
>  
>  	/*

I've changed those like so:


--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7420,10 +7420,9 @@ static int select_idle_sibling(struct ta
 	if (prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
-		if (!static_branch_unlikely(&sched_cluster_active))
-			return prev;
 
-		if (cpus_share_resources(prev, target))
+		if (!static_branch_unlikely(&sched_cluster_active) ||
+		    cpus_share_resources(prev, target))
 			return prev;
 	}
 
@@ -7452,11 +7451,11 @@ static int select_idle_sibling(struct ta
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
-		if (!static_branch_unlikely(&sched_cluster_active))
-			return recent_used_cpu;
 
-		if (cpus_share_resources(recent_used_cpu, target))
+		if (!static_branch_unlikely(&sched_cluster_active) ||
+		    cpus_share_resources(recent_used_cpu, target))
 			return recent_used_cpu;
+
 	}
 
 	/*
