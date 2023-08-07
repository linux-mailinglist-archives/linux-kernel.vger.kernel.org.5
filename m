Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C93B772BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjHGQ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjHGQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:56:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FDA1FC7;
        Mon,  7 Aug 2023 09:56:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKMlH5c02z6HJf6;
        Tue,  8 Aug 2023 00:50:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 17:55:47 +0100
Date:   Mon, 7 Aug 2023 17:55:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Huang Ying <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RESEND 2/4] acpi, hmat: refactor
 hmat_register_target_initiators()
Message-ID: <20230807175546.00001566@Huawei.com>
In-Reply-To: <20230721012932.190742-3-ying.huang@intel.com>
References: <20230721012932.190742-1-ying.huang@intel.com>
        <20230721012932.190742-3-ying.huang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 09:29:30 +0800
Huang Ying <ying.huang@intel.com> wrote:

> Previously, in hmat_register_target_initiators(), the performance
> attributes are calculated and the corresponding sysfs links and files
> are created too.  Which is called during memory onlining.
> 
> But now, to calculate the abstract distance of a memory target before
> memory onlining, we need to calculate the performance attributes for
> a memory target without creating sysfs links and files.
> 
> To do that, hmat_register_target_initiators() is refactored to make it
> possible to calculate performance attributes separately.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>

Unfortunately I don't think I still have the tables I used to test the
generic initiator and won't get time to generate them all again in
next few weeks.  So just a superficial review for now.
I 'think' the cleanup looks good but the original code was rather fiddly
so I'm not 100% sure nothing is missed.

One comment inline on the fact the list is now sorted twice.


> ---
>  drivers/acpi/numa/hmat.c | 81 +++++++++++++++-------------------------
>  1 file changed, 30 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index bba268ecd802..2dee0098f1a9 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -582,28 +582,25 @@ static int initiators_to_nodemask(unsigned long *p_nodes)
>  	return 0;
>  }
>  
> -static void hmat_register_target_initiators(struct memory_target *target)
> +static void hmat_update_target_attrs(struct memory_target *target,
> +				     unsigned long *p_nodes, int access)
>  {
> -	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
>  	struct memory_initiator *initiator;
> -	unsigned int mem_nid, cpu_nid;
> +	unsigned int cpu_nid;
>  	struct memory_locality *loc = NULL;
>  	u32 best = 0;
> -	bool access0done = false;
>  	int i;
>  
> -	mem_nid = pxm_to_node(target->memory_pxm);
> +	bitmap_zero(p_nodes, MAX_NUMNODES);
>  	/*
> -	 * If the Address Range Structure provides a local processor pxm, link
> +	 * If the Address Range Structure provides a local processor pxm, set
>  	 * only that one. Otherwise, find the best performance attributes and
> -	 * register all initiators that match.
> +	 * collect all initiators that match.
>  	 */
>  	if (target->processor_pxm != PXM_INVAL) {
>  		cpu_nid = pxm_to_node(target->processor_pxm);
> -		register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
> -		access0done = true;
> -		if (node_state(cpu_nid, N_CPU)) {
> -			register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
> +		if (access == 0 || node_state(cpu_nid, N_CPU)) {
> +			set_bit(target->processor_pxm, p_nodes);
>  			return;
>  		}
>  	}
> @@ -617,47 +614,10 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  	 * We'll also use the sorting to prime the candidate nodes with known
>  	 * initiators.
>  	 */
> -	bitmap_zero(p_nodes, MAX_NUMNODES);
>  	list_sort(NULL, &initiators, initiator_cmp);
>  	if (initiators_to_nodemask(p_nodes) < 0)
>  		return;

One result of this refactor is that a few things run twice, that previously only ran once
like this list_sort()
Not necessarily a problem though as probably fairly cheap.

>  
> -	if (!access0done) {
> -		for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
> -			loc = localities_types[i];
> -			if (!loc)
> -				continue;
> -
> -			best = 0;
> -			list_for_each_entry(initiator, &initiators, node) {
> -				u32 value;
> -
> -				if (!test_bit(initiator->processor_pxm, p_nodes))
> -					continue;
> -
> -				value = hmat_initiator_perf(target, initiator,
> -							    loc->hmat_loc);
> -				if (hmat_update_best(loc->hmat_loc->data_type, value, &best))
> -					bitmap_clear(p_nodes, 0, initiator->processor_pxm);
> -				if (value != best)
> -					clear_bit(initiator->processor_pxm, p_nodes);
> -			}
> -			if (best)
> -				hmat_update_target_access(target, loc->hmat_loc->data_type,
> -							  best, 0);
> -		}
> -
> -		for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
> -			cpu_nid = pxm_to_node(i);
> -			register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
> -		}
> -	}
> -
> -	/* Access 1 ignores Generic Initiators */
> -	bitmap_zero(p_nodes, MAX_NUMNODES);
> -	if (initiators_to_nodemask(p_nodes) < 0)
> -		return;
> -
>  	for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
>  		loc = localities_types[i];
>  		if (!loc)
> @@ -667,7 +627,7 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  		list_for_each_entry(initiator, &initiators, node) {
>  			u32 value;
>  
> -			if (!initiator->has_cpu) {
> +			if (access == 1 && !initiator->has_cpu) {
>  				clear_bit(initiator->processor_pxm, p_nodes);
>  				continue;
>  			}
> @@ -681,14 +641,33 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  				clear_bit(initiator->processor_pxm, p_nodes);
>  		}
>  		if (best)
> -			hmat_update_target_access(target, loc->hmat_loc->data_type, best, 1);
> +			hmat_update_target_access(target, loc->hmat_loc->data_type, best, access);
>  	}
> +}
> +
> +static void __hmat_register_target_initiators(struct memory_target *target,
> +					      unsigned long *p_nodes,
> +					      int access)
> +{
> +	unsigned int mem_nid, cpu_nid;
> +	int i;
> +
> +	mem_nid = pxm_to_node(target->memory_pxm);
> +	hmat_update_target_attrs(target, p_nodes, access);
>  	for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
>  		cpu_nid = pxm_to_node(i);
> -		register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
> +		register_memory_node_under_compute_node(mem_nid, cpu_nid, access);
>  	}
>  }
>  
> +static void hmat_register_target_initiators(struct memory_target *target)
> +{
> +	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
> +
> +	__hmat_register_target_initiators(target, p_nodes, 0);
> +	__hmat_register_target_initiators(target, p_nodes, 1);
> +}
> +
>  static void hmat_register_target_cache(struct memory_target *target)
>  {
>  	unsigned mem_nid = pxm_to_node(target->memory_pxm);

