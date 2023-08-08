Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603A3773CA9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjHHQIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHHQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:06:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA8172AB;
        Tue,  8 Aug 2023 08:45:55 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378AFccE010043;
        Tue, 8 Aug 2023 11:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=u3HXPtQ5KaYyQ0asw28vxjJ1QX+J/JkvsuRQkSzfVxg=;
 b=GY3IFXFGsSQV7hkJfZiGOmuKi+HuYQuTJh1aJBSoKgjho3il9aVJkwYEe4IUu28m8zvT
 5QZ9qv+KtAsdBKrwJur/x9SqGjnNLAzuuWYO6FsBdHCi69DgjUE1r6ihoUJ5Buf+WHk2
 EtzETFN88woM6v1CZSIIgnrb9eQiH6IToT8HqGBPCuZF2HhOu6586BK5ED9BwlNLP/s+
 R0vijk/UVOMKm0BR2cnJPG1c2Qdqevi7v/hljOgCvtVK7mwq8219ujbFESiULkUfSTpv
 qzaVWHhYiCOz3IMTXUc9FyEdARy3Clh4OzOSwUMciY7s14obCKA92xkt4eXpHj95JG8F Zg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3saxbbtm7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 11:25:31 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 378BPRgu023077;
        Tue, 8 Aug 2023 11:25:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s9fgkb0tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 11:25:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 378BPRgl023071;
        Tue, 8 Aug 2023 11:25:27 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-atulpant-hyd.qualcomm.com [10.213.109.143])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 378BPQDJ023070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 11:25:27 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3869597)
        id 5958220F76; Tue,  8 Aug 2023 16:55:26 +0530 (+0530)
From:   Atul Pant <quic_atulpant@quicinc.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     Atul Pant <quic_atulpant@quicinc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ashayj@quicinc.com,
        quic_rgottimu@quicinc.com, quic_shashim@quicinc.com
Subject: Prevent RT-throttling for idle-injection threads
Date:   Tue,  8 Aug 2023 16:55:23 +0530
Message-Id: <20230808112523.2788452-1-quic_atulpant@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aUYgilCuChag0pinbOGjaSfk7kdsi_NH
X-Proofpoint-GUID: aUYgilCuChag0pinbOGjaSfk7kdsi_NH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_09,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=913 bulkscore=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080101
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
We are trying to implement a solution for thermal mitigation by using idle injection on CPUs. However we face some limitations with the current idle-inject framework.
As per our need, we want to start injecting idle cycles on a CPU for indefinite time (until the temperature/power of the CPU falls below a threshold). This will help
to keep the hot CPUs in the sleep state until we see improvement in temperature/power. If we set the idle duration to a large value or have an idle-injection ratio of 100%,
then the idle-inject RT thread suffers from RT throttling. This results in the CPU exiting from the sleep state and consuming some power.

The above situation can be avoided, if we can prevent RT throttling on the injected CPU. With the currently available sysctl parameters, sched_rt_runtime_us and sched_rt_period_us,
we can prevent RT throttling by either setting sched_rt_runtime_us equal to sched_rt_period_us or, setting sched_rt_runtime_us to -1. Since these parameters are system wide,
so it will affect the RT tasks on non idle-injected CPUs as well. To overcome this, will it be feasible to have these two parameters on a per CPU basis? This will allow to selectively
disable RT throttling on idle-injected CPUs.


Thanks & Regards
Atul
