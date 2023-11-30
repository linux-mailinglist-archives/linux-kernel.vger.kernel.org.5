Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AEE7FFE9C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjK3WnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjK3WnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:43:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E15133;
        Thu, 30 Nov 2023 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701384201; x=1732920201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ul6wDHt3NtaWD+zCoELgS9GAvRpyrDS6easDGhJqmco=;
  b=boGAoV3cmGpgzUFfrBKozh46zGrw4qN6Mfwka0TGGCg4c40p8vQb2696
   K09919cJy9yvodQhrXlRrxTn0AmsSXgiZAJCMPHH4h+4uaZ0q/tCOW1Lm
   2xruReaKNsWRnsVtMH5UdorJjc4a09oWrkRmnbQGzM+HsM0dYF7/y2K/1
   cZnWAiaKSi0dzYrFjYHq1ZPg1MgbsVCZlTMKb0hs6EcYiyJHmy16oM6Fb
   B1uws/ifkieEywnoa0O7T3V7MpwY+UPgYi4XkIqb7qRrx4ZZxKfWq2W3N
   /3FgO9BINSCh2j/G/0wH2WC+FuSaVMxHLuMtMf315zKNrdDUrd8otJ3Dn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="378432541"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="378432541"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 14:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="835555500"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="835555500"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 14:43:20 -0800
Date:   Thu, 30 Nov 2023 14:43:19 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fam Zheng <fam@euphon.net>, Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v12 7/8] x86/resctrl: Sub NUMA Cluster detection and
 enable
Message-ID: <ZWkQBwwtSae4nGgH@agluck-desk3>
References: <20231109230915.73600-1-tony.luck@intel.com>
 <20231130003418.89964-1-tony.luck@intel.com>
 <20231130003418.89964-8-tony.luck@intel.com>
 <ZWjOBw0Ygyw226Cc@dell>
 <ZWj3NdI/qLNOgyg0@agluck-desk3>
 <1c1a16a5-f235-4179-9d0f-1556e11d9c11@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1a16a5-f235-4179-9d0f-1556e11d9c11@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:47:10PM -0800, Reinette Chatre wrote:
> Hi Tony,
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index 3293ab4c58b0..85f8a1b3feaf 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -1056,12 +1056,13 @@ static __init int snc_get_config(void)
> >  	unsigned long *node_caches;
> >  	int mem_only_nodes = 0;
> >  	int cpu, node, ret;
> > +	int cache_id;
> >  	int num_l3_caches;
> 
> Please do maintain reverse fir order.

Fixed.

> 
> >  
> >  	if (!x86_match_cpu(snc_cpu_ids))
> >  		return 1;
> 
> I understand and welcome this change as motivated by robustness. Apart
> from that, with this being a model specific feature for this particular
> group of systems, it it not clear to me in which scenarios this could
> run on a system where a present CPU does not have access to L3 cache.

Agreed that on these systems there should always be an L3 cache. Should
I drop the check for "-1"?

> >  
> > -	node_caches = bitmap_zalloc(nr_node_ids, GFP_KERNEL);
> > +	node_caches = bitmap_zalloc(num_online_cpus(), GFP_KERNEL);
> 
> Please do take care to take new bitmap size into account in all
> places. From what I can tell there is a later bitmap_weight() call that
> still uses nr_node_ids as size.

Oops. I was also using num_online_cpus() before cpus_read_lock(), so
things could theoretically change before the bitmap_weight() call.
I switched to using num_present_cpus() in both places.

> >  	if (!node_caches)
> >  		return 1;
> >  
> > @@ -1072,10 +1073,13 @@ static __init int snc_get_config(void)
> >  
> >  	for_each_node(node) {
> >  		cpu = cpumask_first(cpumask_of_node(node));
> > -		if (cpu < nr_cpu_ids)
> > -			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> > -		else
> > +		if (cpu < nr_cpu_ids) {
> > +			cache_id = get_cpu_cacheinfo_id(cpu, 3);
> > +			if (cache_id != -1)
> > +				set_bit(cache_id, node_caches);
> > +		} else {
> >  			mem_only_nodes++;
> > +		}
> >  	}
> >  	cpus_read_unlock();
> >  
> 
> Could this code be made even more robust by checking the computed
> snc_nodes_per_l3_cache against the limited actually possible values?
> Forcing it to 1 if something went wrong?

Added a couple of extra sanity checks. See updated incremental patch
below.

-Tony


diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 3293ab4c58b0..3684c6bf8224 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -1057,11 +1057,12 @@ static __init int snc_get_config(void)
 	int mem_only_nodes = 0;
 	int cpu, node, ret;
 	int num_l3_caches;
+	int cache_id;
 
 	if (!x86_match_cpu(snc_cpu_ids))
 		return 1;
 
-	node_caches = bitmap_zalloc(nr_node_ids, GFP_KERNEL);
+	node_caches = bitmap_zalloc(num_present_cpus(), GFP_KERNEL);
 	if (!node_caches)
 		return 1;
 
@@ -1072,23 +1073,39 @@ static __init int snc_get_config(void)
 
 	for_each_node(node) {
 		cpu = cpumask_first(cpumask_of_node(node));
-		if (cpu < nr_cpu_ids)
-			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
-		else
+		if (cpu < nr_cpu_ids) {
+			cache_id = get_cpu_cacheinfo_id(cpu, 3);
+			if (cache_id != -1)
+				set_bit(cache_id, node_caches);
+		} else {
 			mem_only_nodes++;
+		}
 	}
 	cpus_read_unlock();
 
-	num_l3_caches = bitmap_weight(node_caches, nr_node_ids);
+	num_l3_caches = bitmap_weight(node_caches, num_present_cpus());
 	kfree(node_caches);
 
 	if (!num_l3_caches)
 		return 1;
 
+	/* sanity check #1: Number of CPU nodes must be multiple of num_l3_caches */
+	if ((nr_node_ids - mem_only_nodes) % num_l3_caches)
+		return 1;
+
 	ret = (nr_node_ids - mem_only_nodes) / num_l3_caches;
 
-	if (ret > 1)
+	/* sanity check #2: Only valid results are 1, 2, 4 */
+	switch (ret) {
+	case 1:
+		break;
+	case 2:
+	case 4:
 		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_NODE;
+		break;
+	default:
+		return 1;
+	}
 
 	return ret;
 }
-- 
2.41.0

