Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49F37DCDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbjJaNOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbjJaNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:14:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F76ED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:14:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VC1bG0020481;
        Tue, 31 Oct 2023 13:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FFN8MO2SByMCG1VWE0WnyVW7hy5Fd5ffBJH86/KHafw=;
 b=nobcN6uo5EwTzr8tLJQw4/XcnmEr1U0ZCm0MbaK9L9CSl4qw1b+t7Q6n6HqGa/UG8wZI
 rfga0mT4AiRmYwg5sblnrAhHIfvo0+m+GQBVvH0Po8wxBLEU3sXoQdIhdwErYppa4xEm
 Uqn+icfzs9uHs7j9fY+6lFmhFkEkpxA6H4LhrDDmLJdY40ldBCkKRc2ROvtSBl0zDa2W
 qCO7nGpyUkZEURCTPud4yjFf6ioiQRU17EGcEzMAmYiLJiwpRHX1MtZocQJpwl/w8G8f
 OIAxPIWU3aWkZg3H4vDa/iZe4hudLiggGzwGsQZrwiYoaZaLAEQIv+v6HrAm722zTyuF 3Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2chyk50h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 13:14:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39VDE13r012590
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 13:14:01 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 06:13:58 -0700
Message-ID: <2a0d2dd8-562c-fec7-e3ac-0bd955643e16@quicinc.com>
Date:   Tue, 31 Oct 2023 18:43:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm: page_alloc: unreserve highatomic page blocks before
 oom
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <david@redhat.com>, <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <1698669590-3193-1-git-send-email-quic_charante@quicinc.com>
 <gtya2g2pdbsonelny6vpfwj5vsxdrzhi6wzkpcrke33mr3q2hf@j4ramnjmfx52>
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <gtya2g2pdbsonelny6vpfwj5vsxdrzhi6wzkpcrke33mr3q2hf@j4ramnjmfx52>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V00cAp50veuoZviQ86wMotv1d1L1osdL
X-Proofpoint-GUID: V00cAp50veuoZviQ86wMotv1d1L1osdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310105
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal/Pavan!!

On 10/31/2023 1:44 PM, Michal Hocko wrote:
> On Mon 30-10-23 18:09:50, Charan Teja Kalla wrote:
>> __alloc_pages_direct_reclaim() is called from slowpath allocation where
>> high atomic reserves can be unreserved after there is a progress in
>> reclaim and yet no suitable page is found. Later should_reclaim_retry()
>> gets called from slow path allocation to decide if the reclaim needs to
>> be retried before OOM kill path is taken.
>>
>> should_reclaim_retry() checks the available(reclaimable + free pages)
>> memory against the min wmark levels of a zone and returns:
>> a)  true, if it is above the min wmark so that slow path allocation will
>> do the reclaim retries.
>> b) false, thus slowpath allocation takes oom kill path.
>>
>> should_reclaim_retry() can also unreserves the high atomic reserves
>> **but only after all the reclaim retries are exhausted.**
>>
>> In a case where there are almost none reclaimable memory and free pages
>> contains mostly the high atomic reserves but allocation context can't
>> use these high atomic reserves, makes the available memory below min
>> wmark levels hence false is returned from should_reclaim_retry() leading
>> the allocation request to take OOM kill path. This is an early oom kill
>> because high atomic reserves are holding lot of free memory and 
>> unreserving of them is not attempted.
> 
> OK, I see. So we do not release those reserved pages because OOM hits
> too early. 
> 
>> (early)OOM is encountered on a machine in the below state(excerpt from
>> the oom kill logs):
>> [  295.998653] Normal free:7728kB boost:0kB min:804kB low:1004kB
>> high:1204kB reserved_highatomic:8192KB active_anon:4kB inactive_anon:0kB
>> active_file:24kB inactive_file:24kB unevictable:1220kB writepending:0kB
>> present:70732kB managed:49224kB mlocked:0kB bounce:0kB free_pcp:688kB
>> local_pcp:492kB free_cma:0kB
>> [  295.998656] lowmem_reserve[]: 0 32
>> [  295.998659] Normal: 508*4kB (UMEH) 241*8kB (UMEH) 143*16kB (UMEH)
>> 33*32kB (UH) 7*64kB (UH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
>> 0*4096kB = 7752kB
> 
> OK, this is quite interesting as well. The system is really tiny and 8MB
> of reserved memory is indeed really high. How come those reservations
> have grown that high?

Actually it is a VM running on the Linux kernel.

Regarding the reservations, I think it is because of the 'max_managed '
calculations in the below:
static void reserve_highatomic_pageblock(struct page *page, ....) {
    ....
  /*
   * Limit the number reserved to 1 pageblock or roughly 1% of a zone.
   * Check is race-prone but harmless.
   */
    max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;

    if (zone->nr_reserved_highatomic >= max_managed)
            goto out;

    zone->nr_reserved_highatomic += pageblock_nr_pages;
    set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
    move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
out:
}

Since we are always appending the 1% of zone managed pages count to
pageblock_nr_pages, the minimum it is turning into 2 pageblocks as the
'nr_reserved_highatomic' is incremented/decremented in pageblock size
granules.

And for my case the 8M out of ~50M is turned out to be 16%, which is high.

If the below looks fine to you, I can raise this as a separate change:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2a2536d..41441ced 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1886,7 +1886,9 @@ static void reserve_highatomic_pageblock(struct
page *page, struct zone *zone)
         * Limit the number reserved to 1 pageblock or roughly 1% of a zone.
         * Check is race-prone but harmless.
         */
-       max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;
+       max_managed = max_t(unsigned long,
+                       ALIGN(zone_managed_pages(zone) / 100,
pageblock_nr_pages),
+                       pageblock_nr_pages);
        if (zone->nr_reserved_highatomic >= max_managed)
                return;

>>
>> Per above log, the free memory of ~7MB exist in the high atomic
>> reserves is not freed up before falling back to oom kill path.
>>
>> This fix includes unreserving these atomic reserves in the OOM path
>> before going for a kill. The side effect of unreserving in oom kill path
>> is that these free pages are checked against the high wmark. If
>> unreserved from should_reclaim_retry()/__alloc_pages_direct_reclaim(),
>> they are checked against the min wmark levels.
> 
> I do not like the fix much TBH. I think the logic should live in

yeah, This code looks way too cleaner to me. Let me know If I can raise
V2 with the below, suggested-by you.

I think another thing system is missing here is draining the pcp lists.
min:804kB low:1004kB high:1204kB free_pcp:688kB

IIUC, the drain pages is being called in reclaim path as below. In this
case, when did_some_progress  = 0, it is also skipping the pcp drain.
struct page *__alloc_pages_direct_reclaim() {
    .....
   *did_some_progress = __perform_reclaim(gfp_mask, order, ac);
   if (unlikely(!(*did_some_progress)))
      goto out;
retry:
    page = get_page_from_freelist();
    if (!page && !drained) {
        drain_all_pages(NULL);
        drained = true;
        goto retry;
    }
out:
}

so, how about the extending the below code from you for this case.
Assuming that did_some_progress > 0 means the draining perhaps already
done in __alloc_pages_direct_reclaim() thus:
out:
   if (!ret) {
       ret = unreserve_highatomic_pageblock(ac, true);
       drain_all_pages(NULL);
   }
   return ret;

Please suggest If the above doesn't make sense. If Looks good, I will
raise a separate patch for this condition.
> should_reclaim_retry. One way to approach it is to unreserve at the end
> of the function, something like this:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 95546f376302..d04e14adf2c5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3813,10 +3813,8 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  	 * Make sure we converge to OOM if we cannot make any progress
>  	 * several times in the row.
>  	 */
> -	if (*no_progress_loops > MAX_RECLAIM_RETRIES) {
> -		/* Before OOM, exhaust highatomic_reserve */
> -		return unreserve_highatomic_pageblock(ac, true);
> -	}
> +	if (*no_progress_loops > MAX_RECLAIM_RETRIES)
> +		goto out;
>  
>  	/*
>  	 * Keep reclaiming pages while there is a chance this will lead
> @@ -3859,6 +3857,12 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  		schedule_timeout_uninterruptible(1);
>  	else
>  		cond_resched();
> +
> +out:
> +	/* Before OOM, exhaust highatomic_reserve */
> +	if (!ret)
> +		return unreserve_highatomic_pageblock(ac, true);
> +
>  	return ret;
>  }
>  
