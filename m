Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79E7EDB62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjKPGAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjKPGAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:00:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DBB1A8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:00:32 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG3m9u9031688;
        Thu, 16 Nov 2023 06:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4RUl4sy6K/1DgzRhv01u8hafszHwGqxmAcX/EgXwkro=;
 b=CJZdVpVlx2zod3bnYkTlNWJqsHSHYfY5xeD96BSPjt4mHw6ogO/7gLYsqkq0IGfVqewS
 cKNQmhzVYxddoMLHSA0QNPklMyYmMLB29SocVuB7zNcdGOoeET1ebjY32Ch0nbnJCcQ1
 KvOdoHVPb/v5cKRZ+muP31C6lzu3Q3w3rXLRVzeQatoEQpE3tc5Y7nFqXyhtwD0r/xe4
 jgSc132yFUyuqNmIH1Xec5X1LeQljG8uQRo5y0uJXN/z66vy0iC5k0tftSrr8pU7vp/Q
 gF2Vcag2pXjWDcvF32gW/QOdxivfVT+UGPFeP972SOUKi9IyYTP1MID2BG4B8D5Hq9tl Vw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud6ecgrpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 06:00:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG60JON009028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 06:00:19 GMT
Received: from [10.216.59.111] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 22:00:07 -0800
Message-ID: <d531e69c-f0b4-f857-657f-48d981db3923@quicinc.com>
Date:   Thu, 16 Nov 2023 11:30:04 +0530
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
 <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
 <ZVTRKTi2QCoMiv50@tiehlicka>
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <ZVTRKTi2QCoMiv50@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FbcWDlCEUs_vcDK-G8m6qmzP3zEpVgNb
X-Proofpoint-ORIG-GUID: FbcWDlCEUs_vcDK-G8m6qmzP3zEpVgNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_03,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=847 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160044
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal.

On 11/15/2023 7:39 PM, Michal Hocko wrote:
>> Also If you have any comments on [PATCH V2 2/3] mm: page_alloc: correct
>> high atomic reserve calculations will help me.
> I do not have a strong opinion on that one to be honest. I am not even
> sure that reserving a full page block (4MB) on small systems as
> presented is really a good use of memory.

May be other way to look at that patch is comment is really not being
reflected in the code. It says, " Limit the number reserved to 1
pageblock or roughly 1% of a zone.", but the current code is making it 2
pageblocks. So, for 4M block size, it is > 1%.

A second patch, that I will post, like not reserving the high atomic
page blocks on small systems -- But how to define the meaning of small
systems is not sure. Instead will let the system administrators chose
this through either:
a) command line param, high_atomic_reserves=off, on by default --
Another knob, so admins may really not like this?
b) CONFIG_HIGH_ATOMIC_RESERVES, which if not defined, will not reserve.

Please lmk If you have any more suggestions here?

Also, I am thinking to request Andrew to pick [PATCH V2 1/3] patch and
take these discussions separately in a separate thread.

Thanks,
Charan
