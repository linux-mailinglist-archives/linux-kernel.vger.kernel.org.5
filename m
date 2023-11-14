Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5507EB502
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjKNQhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjKNQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:37:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3763911B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:37:26 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEBnQ5u023142;
        Tue, 14 Nov 2023 16:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=d6d5JnrLOKkFEuf60AdLIKgO17UAPgEEpTlWOXKblBg=;
 b=NFay2uXCvt68y4IzADt2uVsaIymByaz75bRV+PKWQyIWBTpEUX6X6JV729DKFKDiULJu
 IXGsR6MJs9t1I6JbsUU2n4ynZwCdtgYePAkEW7o8AoZRiGaduKw2mAL4i7Qs0Rtfspj2
 gHYV1/lmnv8QSV4pQXWr6MGASXz1GleHlxozPpS7NYlZYtqPDrazskMZdPymj4DlFnP3
 bLvEs4lmmfS8mRB5hdYIf+BiOFbwJJ4uJDO46WKqKDbrXIEKGGcPwo9yVIRdz/hY4ryB
 I/GJCo5nTjP03WiUmaOM4wvw7/SWG98gSeCGpH6CTCqlxuwN/A9l/QycD6+Dd8X1XKq7 NQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubge83e97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 16:37:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AEGapVi020575
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 16:36:51 GMT
Received: from [10.216.14.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 14 Nov
 2023 08:36:48 -0800
Message-ID: <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
Date:   Tue, 14 Nov 2023 22:06:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <david@redhat.com>, <vbabka@suse.cz>, <hannes@cmpxchg.org>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka>
 <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
 <ZVNQdQKQAMjgOK9y@tiehlicka>
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <ZVNQdQKQAMjgOK9y@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xVsz0shT-lRtTgj7AzInukagZ6kFVODX
X-Proofpoint-GUID: xVsz0shT-lRtTgj7AzInukagZ6kFVODX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_16,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxlogscore=447
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140127
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal!!

On 11/14/2023 4:18 PM, Michal Hocko wrote:
>> At least in my particular stress test case it just delayed the OOM as i
>> can see that at the time of OOM kill, there are no free pcp pages. My
>> understanding of the OOM is that it should be the last resort and only
>> after doing the enough reclaim retries. CMIW here.
> Yes it is a last resort but it is a heuristic as well. So the real
> questoin is whether this makes any practical difference outside of
> artificial workloads. I do not see anything particularly worrying to
> drain the pcp cache but it should be noted that this won't be 100%
> either as racing freeing of memory will end up on pcp lists first.

Okay, I don't have any practical scenario where this helped me in
avoiding the OOM.  Will comeback If I ever encounter this issue in
practical scenario.

Also If you have any comments on [PATCH V2 2/3] mm: page_alloc: correct
high atomic reserve calculations will help me.

Thanks.
