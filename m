Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FFD792AE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbjIEQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345019AbjIED7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:59:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB68CC7;
        Mon,  4 Sep 2023 20:59:34 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3853sfPW009537;
        Tue, 5 Sep 2023 03:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DlB/h95H8PSpLnGU6Uh0gB9WzCZMkNJ1tji39nkc8dg=;
 b=mruYRtCT0lvlfbUAZEQ5RWpdHel4dd1qXDacks+HdWfuYzw+6QYHhk6Zd5Fs4fCtTxb3
 qsk1Zcbicf4AOjfImX+uGr/q74ZSoEibXduDsxA4lkBA+O93vA1j1Logi3Zwdpre3Rei
 tw5mTRMGXlvqjCFq9XSeatkTQIU8RUqI9vvvSJRL0BtcL0nbv7QAmFozNvHHG+a9NyP9
 N83ohEH+yYLnm87r0Ai/5bSGTjaqAHglknZsLhAyG5++CIOhWycHxxC3g4lN6ECaiLWb
 O3m5s3MGSJ7CiCOBHlyV2AMHNRamLDzINNigGJyJxKD6311fNsqNms7Amm4DqjxvysTI lQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swtyng6dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 03:59:08 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3853x7bv032552
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 03:59:07 GMT
Received: from [10.110.10.71] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 4 Sep
 2023 20:59:04 -0700
Message-ID: <df61af06-a43e-05c5-66e8-5a68b08ff14b@quicinc.com>
Date:   Mon, 4 Sep 2023 20:59:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
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
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230904212324.GA2568@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AVkS3XEfbtSZ0V9EW8ogUAkua9Jpdv6n
X-Proofpoint-ORIG-GUID: AVkS3XEfbtSZ0V9EW8ogUAkua9Jpdv6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_02,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0
 mlxlogscore=702 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309050033
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2023 2:23 PM, Peter Zijlstra wrote:
> On Wed, Aug 30, 2023 at 10:42:39AM -0700, Elliot Berman wrote:
> 
>> Avoid the spurious wakeups by saving the state of TASK_FREEZABLE tasks.
>> If the task was running before entering TASK_FROZEN state
>> (__refrigerator()) or if the task received a wake up for the saved
>> state, then the task is woken on thaw. saved_state from PREEMPT_RT locks
>> can be re-used because freezer would not stomp on the rtlock wait flow:
>> TASK_RTLOCK_WAIT isn't considered freezable.
> 
> You don't actually assert that anywhere I think, so the moment someone
> makes that happen you crash and burn.
> 

I can certainly add an assertion on the freezer side.

> Also:
> 
>> -#ifdef CONFIG_PREEMPT_RT
>> +#if IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_FREEZER)
> 
> That makes wakeup more horrible for everyone :/

I don't think the hot wakeup path is significantly impacted because the 
added checks come after the hot path is already not taken.

wait_task_inactive() is impacted in the case of contention on pi_lock, 
but I don't think that is part of any hot path.

I'll run some further tests on my end to be sure about the wake up 
latency. Are there any benchmarks/tests you like for measuring the hot 
path? I can run those as well.

Thanks,
Elliot
