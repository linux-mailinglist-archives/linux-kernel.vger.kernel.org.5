Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2758D7AF63F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 00:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjIZWSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 18:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjIZWP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:15:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B70423128;
        Tue, 26 Sep 2023 15:05:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QLs9jb012012;
        Tue, 26 Sep 2023 22:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PKb/D0HqamWxi3Wj4ngvJzC8qkJDnebrZ+o4mvzqv1s=;
 b=p6d1x0TQkx3wzOuyLL7onb4u6LtHYEyn58xaDH3eS1aUpaDUsCbNKDwzQPiZeyzoJYOA
 oUDklgXR5Ihtz6bX2D0bOsAf0wWfm5FlYytvmoSmCg6XhPcft7YWhVLY2uva3jdO6tJY
 ldY+w8pRI36mlun8k4uvucDoqmy5blVkHjl2oY+9cgn5fnyMnrn42Z5elGaJwhovMwPv
 YoOVL5V5dyJ6oFK28j5hkUkxP7r51RXHN5+O90Ma43OTqQNVYw1f3tb1X45lnVNrY4MZ
 4qB4dq2GCme6pGC8Q5fVhOEdwwWh661OtPaSLr9Ra2W0zzHM4byK2DLeFWPToYRm70+I 0w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbgfv37v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 22:04:49 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38QM4miu006581
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 22:04:48 GMT
Received: from [10.110.53.84] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 26 Sep
 2023 15:04:45 -0700
Message-ID: <7db6eaee-af6d-492a-bc7c-23c6aa6bbdf8@quicinc.com>
Date:   Tue, 26 Sep 2023 15:04:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Avoid spurious freezer wakeups
To:     Carlos Llamas <cmllamas@google.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        "Prakash Viswalingam" <quic_prakashv@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
References: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
 <ZRMEHb3_0Ku1UuK_@google.com>
 <20230926200238.GB13828@noisy.programming.kicks-ass.net>
 <ZRNFeXZ4tRbT7ws6@google.com>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <ZRNFeXZ4tRbT7ws6@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xtoe0jaJDYGL5l2tozlam7dUcuC-zwrx
X-Proofpoint-ORIG-GUID: xtoe0jaJDYGL5l2tozlam7dUcuC-zwrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=793 mlxscore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2023 1:56 PM, Carlos Llamas wrote:
> On Tue, Sep 26, 2023 at 10:02:38PM +0200, Peter Zijlstra wrote:
>> On Tue, Sep 26, 2023 at 04:17:33PM +0000, Carlos Llamas wrote:
>>>
>>> This issue is hurting the performance of our stable 6.1 releases. Does
>>> it make sense to backport these patches into stable branches once they
>>> land in mainline? I would assume we want to fix the perf regression
>>> there too?
>>
>> Note that these patches are in tip/sched/core, slated for the next merge
>> window.
> 
> We can wait, no problem. I just wanted to make sure we also patch stable
> if needed. Elliot, would you be able to send a backport of your patches
> to stable once they land in mainline on the next merge window?

Yep, happy to send it. There's a trivial conflict to resolve w/older
kernels not having the new guard(...)(...) macros.

> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org
> 
> --
> Carlos Llamas
