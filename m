Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4607DDCD9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbjKAGqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343549AbjKAGqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:46:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDDDF3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 23:46:42 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A14Ah9B008173;
        Wed, 1 Nov 2023 06:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=y2AlFEEAUlA+fej7FTEDaUzdAYQm3qmmErQYLmE3Ci8=;
 b=RVEQg6L7a5QuCSxVLak8JrXaLvuwEilStWJYdwPVjXHkh0Ra67eBAszGIV7C2RT7cQMe
 w9L/UFsf5tRpOX4J47I1m8Dbgc7KGd8A+RoPGY+bU0ELde7oN8E61ZOX7X2/CuWNdvG8
 jrdPWdZdvqXliZFcL16jjVnNxqw0pR1fvGRoCfgPdJ5qvkdCAApWBq3aAAQqHpZFNR6+
 5Ttr4Lzkx4iva1P6IjC1Eb6+VR8K1KmUAVDWnPXZDZks/noEkVseeWOVs7X11CK7UY8R
 3Fc7AiKjKy3Yp9HxOOe3qeujrn/wi70tv6lsFOLe+l7Xjk9akxi1NiL4oF9CiwsRRkmv IA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2y5nu8v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 06:46:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A16kRJK011658
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 06:46:27 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 31 Oct 2023 23:46:24 -0700
Date:   Wed, 1 Nov 2023 12:16:21 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
CC:     Michal Hocko <mhocko@suse.com>, <akpm@linux-foundation.org>,
        <mgorman@techsingularity.net>, <david@redhat.com>,
        <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: unreserve highatomic page blocks before
 oom
Message-ID: <37c58833-1953-42c3-98c6-ee0ac75508ce@quicinc.com>
References: <1698669590-3193-1-git-send-email-quic_charante@quicinc.com>
 <gtya2g2pdbsonelny6vpfwj5vsxdrzhi6wzkpcrke33mr3q2hf@j4ramnjmfx52>
 <2a0d2dd8-562c-fec7-e3ac-0bd955643e16@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2a0d2dd8-562c-fec7-e3ac-0bd955643e16@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 23keue43PXrnFQXR2ZdDa_a37dhg5xGh
X-Proofpoint-ORIG-GUID: 23keue43PXrnFQXR2ZdDa_a37dhg5xGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_03,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=385
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 06:43:55PM +0530, Charan Teja Kalla wrote:
> >> (early)OOM is encountered on a machine in the below state(excerpt from
> >> the oom kill logs):
> >> [  295.998653] Normal free:7728kB boost:0kB min:804kB low:1004kB
> >> high:1204kB reserved_highatomic:8192KB active_anon:4kB inactive_anon:0kB
> >> active_file:24kB inactive_file:24kB unevictable:1220kB writepending:0kB
> >> present:70732kB managed:49224kB mlocked:0kB bounce:0kB free_pcp:688kB
> >> local_pcp:492kB free_cma:0kB
> >> [  295.998656] lowmem_reserve[]: 0 32
> >> [  295.998659] Normal: 508*4kB (UMEH) 241*8kB (UMEH) 143*16kB (UMEH)
> >> 33*32kB (UH) 7*64kB (UH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
> >> 0*4096kB = 7752kB
> > 
> > OK, this is quite interesting as well. The system is really tiny and 8MB
> > of reserved memory is indeed really high. How come those reservations
> > have grown that high?
> 
> Actually it is a VM running on the Linux kernel.
> 
> Regarding the reservations, I think it is because of the 'max_managed '
> calculations in the below:
> static void reserve_highatomic_pageblock(struct page *page, ....) {
>     ....
>   /*
>    * Limit the number reserved to 1 pageblock or roughly 1% of a zone.
>    * Check is race-prone but harmless.
>    */
>     max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;
> 
>     if (zone->nr_reserved_highatomic >= max_managed)
>             goto out;
> 
>     zone->nr_reserved_highatomic += pageblock_nr_pages;
>     set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
>     move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
> out:
> }
> 
> Since we are always appending the 1% of zone managed pages count to
> pageblock_nr_pages, the minimum it is turning into 2 pageblocks as the
> 'nr_reserved_highatomic' is incremented/decremented in pageblock size
> granules.
> 
> And for my case the 8M out of ~50M is turned out to be 16%, which is high.
> 
> If the below looks fine to you, I can raise this as a separate change:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2a2536d..41441ced 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1886,7 +1886,9 @@ static void reserve_highatomic_pageblock(struct
> page *page, struct zone *zone)
>          * Limit the number reserved to 1 pageblock or roughly 1% of a zone.
>          * Check is race-prone but harmless.
>          */
> -       max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;
> +       max_managed = max_t(unsigned long,
> +                       ALIGN(zone_managed_pages(zone) / 100,
> pageblock_nr_pages),
> +                       pageblock_nr_pages);
>         if (zone->nr_reserved_highatomic >= max_managed)
>                 return;
> 

ALIGN() rounds up the value, so max_t() is not needed here. If you had
used ALIGN_DOWN() then max_t() can be used to keep atleast
pageblock_nr_pages pages.


> >>
> >> Per above log, the free memory of ~7MB exist in the high atomic
> >> reserves is not freed up before falling back to oom kill path.
> >>
> >> This fix includes unreserving these atomic reserves in the OOM path
> >> before going for a kill. The side effect of unreserving in oom kill path
> >> is that these free pages are checked against the high wmark. If
> >> unreserved from should_reclaim_retry()/__alloc_pages_direct_reclaim(),
> >> they are checked against the min wmark levels.
> > 
> > I do not like the fix much TBH. I think the logic should live in
> 
> yeah, This code looks way too cleaner to me. Let me know If I can raise
> V2 with the below, suggested-by you.
> 

Also, add below Fixes tag if it makes sense.

Fixes: 04c8716f7b00 ("mm: try to exhaust highatomic reserve before the OOM")

Thanks,
Pavan
