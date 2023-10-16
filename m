Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7C7CA580
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJPKeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjJPKeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:34:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777B7D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:34:15 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39G9RDmp022773;
        Mon, 16 Oct 2023 10:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=0c9HvcEms58O6pS9JXIo0Zneu0vFijGqeEIgGfqR/7c=;
 b=LHRXmYXbmXfsD4t9UhcwhQnvMhHHQPmRw6AXTqh6qV+LS3ceXCBpKb2nT4yTkAGnfpp5
 qdIJUjaCCkZeleMkyBYaUZg85Mo+oW0lYdVPYXcN5QYuSPC55MUcNAwrlwlvCKY0Wo0r
 yu2mxmdnR+jrzqnR2/FYYhoCezXQG9nP8k45gP8pZxI5jcpJNACRwxZ7lBp3vEBibIJc
 Myf+QuSS4VClN1xUNXsj1IyCOHOZ58faSs3cIsrOjjKrd9zscsZiPcQnlb/3nJ90RdXl
 ihlfTNaAjY+aDuL89A8rSGe75i3ntoxhBCAy+3N7YT3KPeZG2DvgkyneNUI5fLupAcmu fw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqm9f3qh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 10:33:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39GAXp09018965
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 10:33:51 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 16 Oct 2023 03:33:47 -0700
Date:   Mon, 16 Oct 2023 16:03:44 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
CC:     <akpm@linux-foundation.org>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <mgorman@techsingularity.net>, <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
Message-ID: <e1102c1b-1773-4e59-8a70-00a7deff2bde@quicinc.com>
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ql8e5Y0TOr-tQYkUMxOr7-9mxiUKyAoL
X-Proofpoint-ORIG-GUID: ql8e5Y0TOr-tQYkUMxOr7-9mxiUKyAoL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310160092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 06:34:27PM +0530, Charan Teja Kalla wrote:
> The below race is observed on a PFN which falls into the device memory
> region with the system memory configuration where PFN's are such that
> [ZONE_NORMAL ZONE_DEVICE  ZONE_NORMAL]. Since normal zone start and
> end pfn contains the device memory PFN's as well, the compaction
> triggered will try on the device memory PFN's too though they end up in
> NOP(because pfn_to_online_page() returns NULL for ZONE_DEVICE memory
> sections). When from other core, the section mappings are being removed
> for the ZONE_DEVICE region, that the PFN in question belongs to,
> on which compaction is currently being operated is resulting into the
> kernel crash with CONFIG_SPASEMEM_VMEMAP enabled.
> 
> compact_zone()			memunmap_pages
> -------------			---------------
> __pageblock_pfn_to_page
>    ......
>  (a)pfn_valid():
>      valid_section()//return true
> 			      (b)__remove_pages()->
> 				  sparse_remove_section()->
> 				    section_deactivate():
> 				    [Free the array ms->usage and set
> 				     ms->usage = NULL]
>      pfn_section_valid()
>      [Access ms->usage which
>      is NULL]
> 
> NOTE: From the above it can be said that the race is reduced to between
> the pfn_valid()/pfn_section_valid() and the section deactivate with
> SPASEMEM_VMEMAP enabled.
> 
> The commit b943f045a9af("mm/sparse: fix kernel crash with
> pfn_section_valid check") tried to address the same problem by clearing
> the SECTION_HAS_MEM_MAP with the expectation of valid_section() returns
> false thus ms->usage is not accessed.
> 
> Fix this issue by the below steps:
> a) Clear SECTION_HAS_MEM_MAP before freeing the ->usage.
> b) RCU protected read side critical section will either return NULL when
> SECTION_HAS_MEM_MAP is cleared or can successfully access ->usage.
> c) Synchronize the rcu on the write side and free the ->usage. No
> attempt will be made to access ->usage after this as the
> SECTION_HAS_MEM_MAP is cleared thus valid_section() return false.
> 
> Since the section_deactivate() is a rare operation and will come in the
> hot remove path, impact of synchronize_rcu() should be negligble.

struct mem_section_usage has other field like pageblock_flags. Do we
need to protect its readers with RCU? Also can we annotate usage field
in struct mem_section with __rcu and use RCU accessors like
rcu_dereference() while using memsection::usage field?

> 
> Fixes: f46edbd1b151 ("mm/sparsemem: add helpers track active portions of a section at boot")
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  include/linux/mmzone.h | 11 +++++++++--
>  mm/sparse.c            | 14 ++++++++------
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 4106fbc..c877396 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1987,6 +1987,7 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>  static inline int pfn_valid(unsigned long pfn)
>  {
>  	struct mem_section *ms;
> +	int ret;
>  
>  	/*
>  	 * Ensure the upper PAGE_SHIFT bits are clear in the
> @@ -2000,13 +2001,19 @@ static inline int pfn_valid(unsigned long pfn)
>  	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>  		return 0;
>  	ms = __pfn_to_section(pfn);
> -	if (!valid_section(ms))
> +	rcu_read_lock();
> +	if (!valid_section(ms)) {
> +		rcu_read_unlock();
>  		return 0;
> +	}
>  	/*
>  	 * Traditionally early sections always returned pfn_valid() for
>  	 * the entire section-sized span.
>  	 */
> -	return early_section(ms) || pfn_section_valid(ms, pfn);
> +	ret = early_section(ms) || pfn_section_valid(ms, pfn);
> +	rcu_read_unlock();
> +
> +	return ret;
>  }
>  #endif
>  
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 77d91e5..ca7dbe1 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -792,6 +792,13 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		unsigned long section_nr = pfn_to_section_nr(pfn);
>  
>  		/*
> +		 * Mark the section invalid so that valid_section()
> +		 * return false. This prevents code from dereferencing
> +		 * ms->usage array.
> +		 */
> +		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
> +

This trick may not be needed if we add proper NULL checks around ms->usage. We are anyway
introducing a new rule this check needs to be done under RCU lock, so why not revisit it?

> +		/*
>  		 * When removing an early section, the usage map is kept (as the
>  		 * usage maps of other sections fall into the same page). It
>  		 * will be re-used when re-adding the section - which is then no
> @@ -799,16 +806,11 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		 * was allocated during boot.
>  		 */
>  		if (!PageReserved(virt_to_page(ms->usage))) {
> +			synchronize_rcu();
>  			kfree(ms->usage);
>  			ms->usage = NULL;
>  		}

If we add NULL checks around ms->usage, this becomes

tmp = rcu_replace_pointer(ms->usage, NULL, hotplug_locked());
syncrhonize_rcu();
kfree(tmp);

btw, Do we come here with any global locks? if yes, synchronize_rcu() can add delays in releasing
the lock. In that case we may have to go for async RCU free.

>  		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> -		/*
> -		 * Mark the section invalid so that valid_section()
> -		 * return false. This prevents code from dereferencing
> -		 * ms->usage array.
> -		 */
> -		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
>  	}
>  
>  	/*
> 

Thanks,
Pavan
