Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6822798544
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjIHJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjIHJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:58:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917541FE2;
        Fri,  8 Sep 2023 02:57:47 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3888rxXm030324;
        Fri, 8 Sep 2023 09:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=g6E1uvOuQCi2OZoTUr53OG1yjc1f9s1Fj+FJRjxyJnQ=;
 b=QpaMCp8K/spMEBQIXObrjO3Z9lvnm86sPbqAMQ5W4t9D3xmobG/ZiVOWoXI3i9z9XzXf
 H8ds28YeIknHu5vByjSzqI6TTCX5wyDALiKeiHRXwFxFMpp+hp1HKgDXMlOtOumaxpA8
 V2TyfoQvWC2S/Po4NbntyuiacCT9fMaJIxPj9ZJZVAxhywvrX0XyQWrDjBw+wm64ciyB
 VLuqiwsXDdo76hxhNeffcuLV908ydcHJSaH2sfFyfNTWVwjD/mkPIfukkYVJTOZp+1bc
 s2u1C6L1N88rwM5tkF5cHPFB96dGAIPwvt98/Zg8O+NkHAzhF8B+5k5nZwUL40O0zMxg EA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy50dbf0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 09:55:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3889talv012077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 09:55:36 GMT
Received: from hu-atulpant-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 8 Sep 2023 02:55:31 -0700
Date:   Fri, 8 Sep 2023 15:25:27 +0530
From:   Atul Kumar Pant <quic_atulpant@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ashayj@quicinc.com>, <quic_rgottimu@quicinc.com>,
        <quic_shashim@quicinc.com>
Subject: Re: Prevent RT-throttling for idle-injection threads
Message-ID: <20230908095527.GA2475625@hu-atulpant-hyd.qualcomm.com>
References: <20230808112523.2788452-1-quic_atulpant@quicinc.com>
 <20230811111719.17f9965a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811111719.17f9965a@gandalf.local.home>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zB7ceIkDHyoSfW5x4_HQ0CCkv6HCm9jb
X-Proofpoint-GUID: zB7ceIkDHyoSfW5x4_HQ0CCkv6HCm9jb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 11:17:19AM -0400, Steven Rostedt wrote:
> On Tue,  8 Aug 2023 16:55:23 +0530
> Atul Pant <quic_atulpant@quicinc.com> wrote:
> 
> > Hi all,
> > We are trying to implement a solution for thermal mitigation by using
> > idle injection on CPUs. However we face some limitations with the current
> > idle-inject framework. As per our need, we want to start injecting idle
> > cycles on a CPU for indefinite time (until the temperature/power of the
> > CPU falls below a threshold). This will help to keep the hot CPUs in the
> > sleep state until we see improvement in temperature/power. If we set the
> > idle duration to a large value or have an idle-injection ratio of 100%,
> > then the idle-inject RT thread suffers from RT throttling. This results
> > in the CPU exiting from the sleep state and consuming some power.
> > 
> > The above situation can be avoided, if we can prevent RT throttling on
> > the injected CPU. With the currently available sysctl parameters,
> > sched_rt_runtime_us and sched_rt_period_us, we can prevent RT throttling
> > by either setting sched_rt_runtime_us equal to sched_rt_period_us or,
> > setting sched_rt_runtime_us to -1. Since these parameters are system
> > wide, so it will affect the RT tasks on non idle-injected CPUs as well.
> > To overcome this, will it be feasible to have these two parameters on a
> > per CPU basis? This will allow to selectively disable RT throttling on
> > idle-injected CPUs.
> 
> I wonder if the deadline scheduler that Daniel is working on would help in this case?

		Are you referring to this thread regarding SCHED_DEADLINE server?
		https://lore.kernel.org/all/cover.1686239016.git.bristot@kernel.org/T/#u

> 
> -- Steve
> 
