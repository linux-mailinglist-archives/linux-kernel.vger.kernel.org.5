Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655837CA265
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjJPIt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjJPItX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:49:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9A2DE;
        Mon, 16 Oct 2023 01:49:21 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39G7p7GH020067;
        Mon, 16 Oct 2023 08:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sifPsxCDn4LKFjq3zQSutNGMmtzyW892LXiRq2gikAk=;
 b=ormlZ5sE1TuPDGINSyatOVS1KPTFMyKy3ZR2VUbwU8Rwy4IsYJQfblPedjKIWNujpHId
 xkBszs/ZP3Me7jev2ZODBNqLjwzNjOkTy76komnN8g0CD7EZegjYbO3xPSFzObElaQ+R
 IMmJH/9M0DrsC89minDyw4r4t1iq8JTICt3YZsKyQHuvm6x8TtQPX1g1oG56BToXs21B
 0lZI1eXIijVk5v+qTsdlsQJCVtgQBW2GuTVR577mYvv4dMONn1V7J4Ey4ClLKDc5j4Pc
 FV4tGIYSRV8bEB4JZVkwTla2w0U9apQNx38S1FF2u39fqmR3xDQUM+feungwaZTJv3pG 8Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqj0hkhae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 08:49:14 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39G8nDAs029099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 08:49:13 GMT
Received: from [10.253.8.47] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 16 Oct
 2023 01:49:11 -0700
Message-ID: <10f05b5a-8046-4884-b375-007a14248e00@quicinc.com>
Date:   Mon, 16 Oct 2023 16:49:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] bus: mhi: host: Take irqsave lock after TRE is
 generated
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>, Hemant Kumar <quic_hemantk@quicinc.com>,
        "Lazarus Motha" <quic_lmotha@quicinc.com>
References: <1694594861-12691-1-git-send-email-quic_qianyu@quicinc.com>
 <1694594861-12691-3-git-send-email-quic_qianyu@quicinc.com>
 <e40a1dca-f23e-af32-320e-bf66a894bc6c@quicinc.com>
 <a82e188e-2d0e-7c0f-de54-79bbc4b6957b@quicinc.com>
 <6b396b1a-58a7-bf7c-f644-f1bf298a31e0@quicinc.com>
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <6b396b1a-58a7-bf7c-f644-f1bf298a31e0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jHtNlzqMbUmjkR8VBhuqH0hLk0LNKICW
X-Proofpoint-GUID: jHtNlzqMbUmjkR8VBhuqH0hLk0LNKICW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_02,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 mlxlogscore=766 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/29/2023 11:25 PM, Jeffrey Hugo wrote:
> On 9/24/2023 10:08 PM, Qiang Yu wrote:
>>
>> On 9/22/2023 10:50 PM, Jeffrey Hugo wrote:
>>> On 9/13/2023 2:47 AM, Qiang Yu wrote:
>>>> From: Hemant Kumar <quic_hemantk@quicinc.com>
>>>>
>>>> Take irqsave lock after TRE is generated to avoid deadlock due to core
>>>> getting interrupts enabled as local_bh_enable must not be called with
>>>> irqs disabled based on upstream patch.
>>>
>>> Where is local_bh_enable() being called?  What patch?  What is 
>>> upstream of the codebase you submitted this to?  Why is it safe to 
>>> call mhi_gen_tre() without the lock?
>>
>> This patch is to fix the issue included by  "[PATCH v2 1/2] bus: mhi: 
>> host: Add spinlock to protect WP access when queueing TREs". In that 
>> patch, we add write_lock_bh/write_unlock_bh in mhi_gen_tre().
>>
>> However, before mhi_gen_tre() is invoked, mhi_cntrl->pm_lock is 
>> getted, line 1125, and it is a spin lock. So it becomes we want to 
>> get and release bh lock after spin lock. __local_bh_enable_ip is 
>> called as part of write_unlock_bh
>>
>> and local_bh_enable. When CONFIG_TRACE_IRQFLAGS is enabled, irq will 
>> be enabled once __local_bh_enable_ip is called. The commit message is 
>> not clear and confusing, will change it in [patch v3].
>>
>
> In addition to clarifying the commit message, I recommend looking at 
> adding this to the other patch.  It seems very odd to review a series 
> where one patch introduces a known issue, and a following patch 
> corrects that issue.  It would be better to not introduce the issue in 
> the first place.
OK, will squash two patches into one patch after we achieve an agreement.
