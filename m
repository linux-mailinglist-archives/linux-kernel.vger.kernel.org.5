Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64C7990D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbjIHUIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjIHUIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:08:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CDE8E;
        Fri,  8 Sep 2023 13:08:26 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388JbMkm015827;
        Fri, 8 Sep 2023 20:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3g0wiWokxH84iUDQxDUA+fgjCRDmHlts0VO6oh/nPJw=;
 b=bQKDBobesCQ5HcUlmtKbBpTkpu6GLwNhBMp6C/Xrfo2QLkbHBO3XZS+tUxa8V6QC5ffk
 tBilgi6zzlnltisCcfpimTUK3eApuU+Gyk+hl8k4Y+jfRZhweqjp12BfOjtcb3Bd0v7d
 6i9naNJk1LPwKxbscj37yz/MXjaFdzGyO9ZoDxn3YxaNzb6sOOkWAPzzrbtk52A8x3u5
 3jP1LD0ElhN52sQYaa799mwv7lQrsvJUhmdZLfVIG3YgnWeQkOdWi7EOI3877lg1B29n
 qsfXqKwSb2Gew2oRjAikRiu5Y8zbbxNul25OWfxygg1VmyOezhTDJHiUVzbZtXjL6hDb +g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syfj1bpfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 20:08:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388K8FER012410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 20:08:15 GMT
Received: from [10.110.34.180] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 13:08:08 -0700
Message-ID: <4c5b5a0b-6d78-878e-7e66-e08e83e6e1c8@quicinc.com>
Date:   Fri, 8 Sep 2023 13:08:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v2] freezer,sched: Use saved_state to reduce some spurious
 wakeups
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        "Prakash Viswalingam" <quic_prakashv@quicinc.com>
References: <20230830-avoid-spurious-freezer-wakeups-v2-1-8877245cdbdc@quicinc.com>
 <20230904212324.GA2568@noisy.programming.kicks-ass.net>
 <df61af06-a43e-05c5-66e8-5a68b08ff14b@quicinc.com>
 <20230907094651.GB16872@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20230907094651.GB16872@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Evy-VqpaKkFrUSZOuiDN7IzCFLKpoAWg
X-Proofpoint-ORIG-GUID: Evy-VqpaKkFrUSZOuiDN7IzCFLKpoAWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=856 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080182
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2023 2:46 AM, Peter Zijlstra wrote:
> On Mon, Sep 04, 2023 at 08:59:03PM -0700, Elliot Berman wrote:
>>
>>
>> On 9/4/2023 2:23 PM, Peter Zijlstra wrote:
>>> On Wed, Aug 30, 2023 at 10:42:39AM -0700, Elliot Berman wrote:
>>>
>>>> Avoid the spurious wakeups by saving the state of TASK_FREEZABLE tasks.
>>>> If the task was running before entering TASK_FROZEN state
>>>> (__refrigerator()) or if the task received a wake up for the saved
>>>> state, then the task is woken on thaw. saved_state from PREEMPT_RT locks
>>>> can be re-used because freezer would not stomp on the rtlock wait flow:
>>>> TASK_RTLOCK_WAIT isn't considered freezable.
>>>
>>> You don't actually assert that anywhere I think, so the moment someone
>>> makes that happen you crash and burn.
>>>
>>
>> I can certainly add an assertion on the freezer side.
> 
> I think the assertion we have in ttwu_state_match() might be sufficient.
> 

That assertion checks that you only try to wake up with only
TASK_RTLOCK_WAIT and no other bits. I think it is probably good to also
have assertions that check that TASK_RTLOCK_WAIT and TASK_FROZEN are
exclusive bits and. I can add these assertions (a separate patch?), but
I think those checks would impact the hot path to do the extra tests.

>>> Also:
>>>
>>>> -#ifdef CONFIG_PREEMPT_RT
>>>> +#if IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_FREEZER)
>>>
>>> That makes wakeup more horrible for everyone :/
>>
>> I don't think the hot wakeup path is significantly impacted because the
>> added checks come after the hot path is already not taken.
> 
> Perhaps we should start off by doing the below, instead of making it
> more complicated instead. I suppose you're right about the overhead, but
> run a hackbench just to make sure or something.
> 

I ran perf bench sched message -g 40 -l 40 with the v3 patch [1]. After 60
iterations each, I don't see a significant difference on my arm64 platform:
both samples ~normal and ~eq variance w/t-test p-value: 0.79.

We also ran typical high level benchmarks for our SoCs (antutu,
geekbench, et. al) and didn't see any regressions there.

[1]: https://lore.kernel.org/all/20230908-avoid-spurious-freezer-wakeups-v3-1-d49821fda04d@quicinc.com/

Thanks,
Elliot
