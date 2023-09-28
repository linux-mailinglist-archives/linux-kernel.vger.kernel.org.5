Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8127B223D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjI1QZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjI1QZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:25:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0AAEB;
        Thu, 28 Sep 2023 09:25:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SFfLq1015805;
        Thu, 28 Sep 2023 16:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dvWWXdVXiGWDkgySuet7W6R6F3UF6xZSLY4i8jRlvQw=;
 b=JgCKJs7XQcEwcC8ZZ0h3BYHmwikscgfyeQDjb4kRQWlFzdVFmoOWBlmfbMsT23MWgJKd
 yoUSx5quzHOBGJHVA/bFSYYTZnhUz5EBuqcka9xq3oSafWH7sP7t59miUmnSXqz94C45
 i74iRjN14i3kYHtCre4mAICsJg/C+GHMMJSURVcayygqOky9tx+W6ODAs/SrxxsGSjYR
 sby8+7f0PEiRUqy6gD/m6dwWcYJ4H4/fyIvQb5v+W8NuDPoMUFrPm1NsnubSbJyotboE
 iYL7jQLMDl/GgVetwvlfFkgBKsJgDjr5lp2FBhSV0KccEDR3yUsCPmKt32Zh0dZuFpGY DA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td8wdrp6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 16:25:00 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SGOxeI002522
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 16:24:59 GMT
Received: from [10.110.102.158] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 28 Sep
 2023 09:24:56 -0700
Message-ID: <a0456690-1917-4d82-877a-f23d871049b5@quicinc.com>
Date:   Thu, 28 Sep 2023 09:24:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Avoid spurious freezer wakeups
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Carlos Llamas <cmllamas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        "Prakash Viswalingam" <quic_prakashv@quicinc.com>
References: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
 <ZRMEHb3_0Ku1UuK_@google.com>
 <20230926200238.GB13828@noisy.programming.kicks-ass.net>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230926200238.GB13828@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: voW2hM9_I6oH-E1B9Ahh6aw547ZEEFqW
X-Proofpoint-GUID: voW2hM9_I6oH-E1B9Ahh6aw547ZEEFqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=784 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 9/26/2023 1:02 PM, Peter Zijlstra wrote:
> On Tue, Sep 26, 2023 at 04:17:33PM +0000, Carlos Llamas wrote:
>> On Fri, Sep 08, 2023 at 03:49:14PM -0700, Elliot Berman wrote:
>>> After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
>>> tasks that transition directly from TASK_FREEZABLE to TASK_FROZEN  are
>>> always woken up on the thaw path. Prior to that commit, tasks could ask
>>> freezer to consider them "frozen enough" via freezer_do_not_count(). The
>>> commit replaced freezer_do_not_count() with a TASK_FREEZABLE state which
>>> allows freezer to immediately mark the task as TASK_FROZEN without
>>> waking up the task.  This is efficient for the suspend path, but on the
>>> thaw path, the task is always woken up even if the task didn't need to
>>> wake up and goes back to its TASK_(UN)INTERRUPTIBLE state. Although
>>> these tasks are capable of handling of the wakeup, we can observe a
>>> power/perf impact from the extra wakeup.
>>
>> This issue is hurting the performance of our stable 6.1 releases. Does
>> it make sense to backport these patches into stable branches once they
>> land in mainline? I would assume we want to fix the perf regression
>> there too?
> 
> Note that these patches are in tip/sched/core, slated for the next merge
> window.

Can the changes be scheduled for the next 6.6-rc? I'd like to get the
changes backported to stable sooner since we observed the regression on
real systems.

Thanks,
Elliot
