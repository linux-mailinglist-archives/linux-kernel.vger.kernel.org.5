Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6031E7DC7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbjJaHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343823AbjJaHyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:54:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646AB129
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:54:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V5Hk8N015183;
        Tue, 31 Oct 2023 07:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=nJTUnRTpbFY6bf2SOeqkwUAGzVKp03Eymn6YEB6D8mY=;
 b=Ilgmz83UueDuSnACNkvPsuVpHaGv+gXZlfGO5Qvs7f71y9fRzNcgJb6wXUttKIaOV5+8
 d4ol5Px4e8gtRgvZus9UFpOoy4BK/ZWAWh/4syEoBDozoTGpF3V2EQE+UZfKkz62IPXQ
 8A/cbjGA+U+8bWtdLrFqz+DkJqD+y0cWdSF6I1WG0B7Fqm64n5hkvWSP53vaTlgEZq5f
 i3s17Y/T4xPKYLch1b4KGb5QTJtv0eqwiLj2w62ZrsPqqn0LBKhPMTGpXLn5fWLoqzR1
 oGzRASZNtuTG2L2LwwSIrZwGyHNavHihqEaUOuMs0E8oROICE/osl6bcLgc2DzzcTEJr QA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2at12fc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:54:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V7rvkr004502
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:53:57 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 31 Oct 2023 00:53:54 -0700
Date:   Tue, 31 Oct 2023 13:23:51 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
CC:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <mhocko@suse.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: unreserve highatomic page blocks before
 oom
Message-ID: <ee278bf6-6ed1-4928-a2e5-76ef90f2fab7@quicinc.com>
References: <1698669590-3193-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1698669590-3193-1-git-send-email-quic_charante@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1IA_lDv0LlpbLQMLSbGowYRHNZfsnmC_
X-Proofpoint-GUID: 1IA_lDv0LlpbLQMLSbGowYRHNZfsnmC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 06:09:50PM +0530, Charan Teja Kalla wrote:
> __alloc_pages_direct_reclaim() is called from slowpath allocation where
> high atomic reserves can be unreserved after there is a progress in
> reclaim and yet no suitable page is found. Later should_reclaim_retry()
> gets called from slow path allocation to decide if the reclaim needs to
> be retried before OOM kill path is taken.
> 
> should_reclaim_retry() checks the available(reclaimable + free pages)
> memory against the min wmark levels of a zone and returns:
> a)  true, if it is above the min wmark so that slow path allocation will
> do the reclaim retries.
> b) false, thus slowpath allocation takes oom kill path.
> 
> should_reclaim_retry() can also unreserves the high atomic reserves
> **but only after all the reclaim retries are exhausted.**
> 
> In a case where there are almost none reclaimable memory and free pages
> contains mostly the high atomic reserves but allocation context can't
> use these high atomic reserves, makes the available memory below min
> wmark levels hence false is returned from should_reclaim_retry() leading
> the allocation request to take OOM kill path. This is an early oom kill
> because high atomic reserves are holding lot of free memory and 
> unreserving of them is not attempted.
> 
> (early)OOM is encountered on a machine in the below state(excerpt from
> the oom kill logs):
> [  295.998653] Normal free:7728kB boost:0kB min:804kB low:1004kB
> high:1204kB reserved_highatomic:8192KB active_anon:4kB inactive_anon:0kB
> active_file:24kB inactive_file:24kB unevictable:1220kB writepending:0kB
> present:70732kB managed:49224kB mlocked:0kB bounce:0kB free_pcp:688kB
> local_pcp:492kB free_cma:0kB
> [  295.998656] lowmem_reserve[]: 0 32
> [  295.998659] Normal: 508*4kB (UMEH) 241*8kB (UMEH) 143*16kB (UMEH)
> 33*32kB (UH) 7*64kB (UH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
> 0*4096kB = 7752kB
> 
> Per above log, the free memory of ~7MB exist in the high atomic
> reserves is not freed up before falling back to oom kill path.
> 
> This fix includes unreserving these atomic reserves in the OOM path
> before going for a kill. The side effect of unreserving in oom kill path
> is that these free pages are checked against the high wmark. If
> unreserved from should_reclaim_retry()/__alloc_pages_direct_reclaim(),
> they are checked against the min wmark levels.
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Thanks for the detailed commit description. Really helpful in
understanding the problem you are fixing.

> ---
>  mm/page_alloc.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 95546f3..2a2536d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3281,6 +3281,8 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  		.order = order,
>  	};
>  	struct page *page;
> +	struct zone *zone;
> +	struct zoneref *z;
>  
>  	*did_some_progress = 0;
>  
> @@ -3295,6 +3297,16 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  	}
>  
>  	/*
> +	 * If should_reclaim_retry() encounters a state where:
> +	 * reclaimable + free doesn't satisfy the wmark levels,
> +	 * it can directly jump to OOM without even unreserving
> +	 * the highatomic page blocks. Try them for once here
> +	 * before jumping to OOM.
> +	 */
> +retry:
> +	unreserve_highatomic_pageblock(ac, true);
> +

Not possible to fix this in should_reclaim_retry()? 

> +	/*
>  	 * Go through the zonelist yet one more time, keep very high watermark
>  	 * here, this is only to catch a parallel oom killing, we must fail if
>  	 * we're still under heavy pressure. But make sure that this reclaim
> @@ -3307,6 +3319,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  	if (page)
>  		goto out;
>  
> +	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->highest_zoneidx,
> +								ac->nodemask) {
> +		if (zone->nr_reserved_highatomic > 0)
> +			goto retry;
> +	}
> +
>  	/* Coredumps can quickly deplete all memory reserves */
>  	if (current->flags & PF_DUMPCORE)
>  		goto out;
