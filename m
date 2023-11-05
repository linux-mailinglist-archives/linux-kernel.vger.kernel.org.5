Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780F47E1368
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 13:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjKEMz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 07:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEMzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 07:55:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE6BDE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 04:55:22 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A5Cix0A014641;
        Sun, 5 Nov 2023 12:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8i5tn46KEI/5G3fVJypRas8+siCYTKCKkxGxN88a+hw=;
 b=VlIV8tmJOJgkvvDGmXHTVQAe7Zv+12cM7H1IYGqbmmCRZ8MgZwAGzOSQZKfEXWQ80JTS
 oO08+/1CbVgkUKoCKBJ8Kzrco/0MK0+3nfGnz0vmSGcP2yZes5rncaP90YbUB7/lEluT
 jqwim8hYoaI6AAvB+BcWeIM/+JQUe3hkA9E/lhpxGAFJZWWpHIOqvvrVNxYL+iopS0ll
 oPN0UU/8rq3424rbOUxPA8fvuspdilMIw4KWyP8JsHIoJsffEzspUp064TZy/eArHcm0
 2JB6HyjVU7TWiGjUQOQBbpxYJ9qO4rFqnNnLAffvZfaD4GPxXTj8PlX9o30Jd7uVRXKq fQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5exhsxku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Nov 2023 12:55:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A5CtALq026698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Nov 2023 12:55:10 GMT
Received: from [10.216.52.187] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 5 Nov
 2023 04:55:06 -0800
Message-ID: <507ca004-67e0-e969-529a-c97deb33f6f0@quicinc.com>
Date:   Sun, 5 Nov 2023 18:25:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
To:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <mhocko@suse.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <hannes@cmpxchg.org>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XpjOLRZcW_bN2G5vMA8IBrRswjdtp0NN
X-Proofpoint-GUID: XpjOLRZcW_bN2G5vMA8IBrRswjdtp0NN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-05_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxlogscore=465
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311050112
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this is supposed to be PATCH V2 in place of V3. Not sure If I
have to resend it as V2 again.

On 11/5/2023 6:20 PM, Charan Teja Kalla wrote:
> pcp lists are drained from __alloc_pages_direct_reclaim(), only if some
> progress is made in the attempt.
> 
> struct page *__alloc_pages_direct_reclaim() {
>     .....
>    *did_some_progress = __perform_reclaim(gfp_mask, order, ac);
>    if (unlikely(!(*did_some_progress)))
>       goto out;
> retry:
>     page = get_page_from_freelist();
>     if (!page && !drained) {
>         drain_all_pages(NULL);
>         drained = true;
>         goto retry;
>     }
> out:
> }
> 
> After the above, allocation attempt can fallback to
> should_reclaim_retry() to decide reclaim retries. If it too return
> false, allocation request will simply fallback to oom kill path without
> even attempting the draining of the pcp pages that might help the
> allocation attempt to succeed.
> 
> VM system running with ~50MB of memory shown the below stats during OOM
> kill:
> Normal free:760kB boost:0kB min:768kB low:960kB high:1152kB
> reserved_highatomic:0KB managed:49152kB free_pcp:460kB
> 
> Though in such system state OOM kill is imminent, but the current kill
> could have been delayed if the pcp is drained as pcp + free is even
> above the high watermark.
> 
> Fix this missing drain of pcp list in should_reclaim_retry() along with
> unreserving the high atomic page blocks, like it is done in
> __alloc_pages_direct_reclaim().
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  mm/page_alloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b91c99e..8eee292 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3857,8 +3857,10 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  		cond_resched();
>  out:
>  	/* Before OOM, exhaust highatomic_reserve */
> -	if (!ret)
> -		return unreserve_highatomic_pageblock(ac, true);
> +	if (!ret) {
> +		ret =  unreserve_highatomic_pageblock(ac, true);
> +		drain_all_pages(NULL);
> +	}
>  
>  	return ret;
>  }
