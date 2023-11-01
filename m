Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5E7DDCE0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345130AbjKAGxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjKAGxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:53:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF926A6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 23:53:45 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A15TNEC012804;
        Wed, 1 Nov 2023 06:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vkUEf9qIvi0SMDctvwk2B4fTr2MBK+8AfABz9dTKu/8=;
 b=QChlah4+6tT+ib6JEADUjJ5yqmpB1MxuS+DqnO7YNxspRxlv1s78I2RX0lGOnSELa3WH
 YYEC4dEV/pwRXRyMzzT5H2rF08mGXz60Nb9cXhu8EeLJ+0/sF2ztF4PGFZLdwBYRl973
 RbO6UKtJBLpfFxxaNGtO8x8wPyQIuWubGIUr7llTZZ7eoiEgY83S/IIUgjmx1oGV5SCL
 BQartnJiB29h/J83uNwki1bchIdIG1+2Jci26xznwcghdMvuT+uEqod8X1nJnr016S2n
 sclc92pggOwhpeynCisU1Dtq4FRL5EhH9UEazLv0atLhlOz/HSwIPiz4zYsu5bG5S/6i sw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3382jdb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 06:53:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A16rUW5019280
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 06:53:30 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 23:53:27 -0700
Message-ID: <ca6093e6-fc85-9ce8-71a1-77d8996c9fd6@quicinc.com>
Date:   Wed, 1 Nov 2023 12:23:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm: page_alloc: unreserve highatomic page blocks before
 oom
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Michal Hocko <mhocko@suse.com>, <akpm@linux-foundation.org>,
        <mgorman@techsingularity.net>, <david@redhat.com>,
        <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <1698669590-3193-1-git-send-email-quic_charante@quicinc.com>
 <gtya2g2pdbsonelny6vpfwj5vsxdrzhi6wzkpcrke33mr3q2hf@j4ramnjmfx52>
 <2a0d2dd8-562c-fec7-e3ac-0bd955643e16@quicinc.com>
 <37c58833-1953-42c3-98c6-ee0ac75508ce@quicinc.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <37c58833-1953-42c3-98c6-ee0ac75508ce@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QFFtBJcqKPNIL5bxjw0mLNMw8tK7eo3r
X-Proofpoint-ORIG-GUID: QFFtBJcqKPNIL5bxjw0mLNMw8tK7eo3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_03,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 mlxlogscore=575 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010057
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2023 12:16 PM, Pavan Kondeti wrote:
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 2a2536d..41441ced 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1886,7 +1886,9 @@ static void reserve_highatomic_pageblock(struct
>> page *page, struct zone *zone)
>>          * Limit the number reserved to 1 pageblock or roughly 1% of a zone.
>>          * Check is race-prone but harmless.
>>          */
>> -       max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;
>> +       max_managed = max_t(unsigned long,
>> +                       ALIGN(zone_managed_pages(zone) / 100,
>> pageblock_nr_pages),
>> +                       pageblock_nr_pages);
>>         if (zone->nr_reserved_highatomic >= max_managed)
>>                 return;
>>
> ALIGN() rounds up the value, so max_t() is not needed here. If you had
> used ALIGN_DOWN() then max_t() can be used to keep atleast
> pageblock_nr_pages pages.
> 
Yeah, just ALIGN() enough here.
> 
> Also, add below Fixes tag if it makes sense.
> 
> Fixes: 04c8716f7b00 ("mm: try to exhaust highatomic reserve before the OOM")
I should be adding this.
