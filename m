Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79937992BD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbjIHXRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345016AbjIHXRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:17:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CFE133;
        Fri,  8 Sep 2023 16:17:27 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388MOjGL009159;
        Fri, 8 Sep 2023 23:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DL3tO0A2K+28Tvl9trFsdpNrg0tjg3RpyaixrWVLLC8=;
 b=FxG4TEuBmorcZWU+hDDzLii3OHyNrHuOrzdXfeIm4+FgaomSLd6ttgv3fsoFSPA3Z8rz
 z4ti7h5m7H/AVOTbZMUCjvGbgSDGMmK3bPZXX5PbNcK/KIRdhfIOFfIMtvJk+sp3bWZ6
 BSwgPC07PNewa92gzd6Tx8Gs9FfhcPcVtQfkvJpA4yqehXQlTiJVc+n1xI5H14U30XpX
 N2UzTnd+CX9qQ1OkuW6deKdublW4q7EoEHWGUzGzWMYc/tdgQ5Cwe/+wtQDD+t5HRxy2
 0eZktNp289ziHlL/FDnm61m0yqH5rEEnzHYfr8K/CHKOIPNE5owmOHSy+PHNw9coQ0ao xQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t023wsk83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 23:17:14 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388NHDFG006689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 23:17:13 GMT
Received: from [10.110.34.180] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 16:17:09 -0700
Message-ID: <8b917006-2c77-0b36-060a-76a1ca04d2e0@quicinc.com>
Date:   Fri, 8 Sep 2023 16:17:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] freezer,sched: Use saved_state to reduce some spurious
 wakeups
Content-Language: en-US
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
 <4c5b5a0b-6d78-878e-7e66-e08e83e6e1c8@quicinc.com>
 <20230908220804.GA29218@noisy.programming.kicks-ass.net>
 <783c60ef-5341-7893-e9e8-2b1b249f89c9@quicinc.com>
 <20230908224829.GA32012@noisy.programming.kicks-ass.net>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230908224829.GA32012@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JsY2LYP_CGaiZCx5q4X-b1D1sS1BTaOO
X-Proofpoint-ORIG-GUID: JsY2LYP_CGaiZCx5q4X-b1D1sS1BTaOO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080212
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 3:48 PM, Peter Zijlstra wrote:
> On Fri, Sep 08, 2023 at 03:30:43PM -0700, Elliot Berman wrote:
>>
>>
>> On 9/8/2023 3:08 PM, Peter Zijlstra wrote:
>>> On Fri, Sep 08, 2023 at 01:08:07PM -0700, Elliot Berman wrote:
>>>
>>>>> Perhaps we should start off by doing the below, instead of making it
>>>>> more complicated instead. I suppose you're right about the overhead, but
>>>>> run a hackbench just to make sure or something.
>>>>>
>>>>
>>>> I ran perf bench sched message -g 40 -l 40 with the v3 patch [1]. After 60
>>>> iterations each, I don't see a significant difference on my arm64 platform:
>>>> both samples ~normal and ~eq variance w/t-test p-value: 0.79.
>>>>
>>>> We also ran typical high level benchmarks for our SoCs (antutu,
>>>> geekbench, et. al) and didn't see any regressions there.
>>>
>>> So if you would've made this 2 patches, the first removing the ifdef,
>>> then the changelog for that patch would be a good place to mention it
>>> doesn't measurably regress things.
>>
>> No problem, easily done.
>>
>>> As a bonus, it then makes your other changes smaller too ;-)
>>
>> Did you mean that each commit is smaller but overall delta is the same
>> or something else? 
> 
> That.
> 
>> I still wanted to update comments on saved_state in
>> kernel/sched/core.c as it gives good explanation of what is going on. I
>> have split the commit but want to make sure I make the changes you were
>> thinking :-)
> 
> well, it's nearly 1am, I'm not thinking very much :-) Changing those
> comments seems fine when you add the freezer thing.

I was wondering what time zone you are in, I saw your previous replies
are early in my morning. I think you are giving Greg a run for his money
with responses at all hours :-) 

I sent v4 with the changes split:
https://lore.kernel.org/all/20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com/
