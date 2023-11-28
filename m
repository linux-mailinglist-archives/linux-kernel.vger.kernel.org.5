Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890E37FC280
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345755AbjK1Rde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjK1Rdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:33:33 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1485ACA;
        Tue, 28 Nov 2023 09:33:38 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASEukOl012283;
        Tue, 28 Nov 2023 17:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iBm5UrlwT+RdZamDA3hr2gOJjYMmpF+A+Ru9UXUTXPE=;
 b=LL+yYcCpdZRujo7owbg2TYSq6GMolkdoGUC1H13sGVi03WdS47AePeJYjkhyt3wCQzL2
 pM8j9soDUGxvHOlMSuSpOmIddwmm8D0Wb3+J1jab62GqhT6Xb3x7Rz5N6yg9AYEwDDqh
 MfrjABYPDM6D42MOKTPdtxlakahhx/DoiIvMiZ0splYSidRB/+/XwDQprzBa9YvTW78p
 5lZiq3KG+C6U93WjyNMh4FXioh3TOADZbWUupz3N572GwCfZibqh5Mtl/pF+P+c4Xarc
 IfJ9YeNgcixp5t3DNNpAYj+HfppGt6XsPHgEfwIpT/4fbMb1kqCHFr8V+d/cBVoTuKyY 1A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unjdtgfq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 17:33:26 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ASHXPMd021527
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 17:33:25 GMT
Received: from [10.110.114.100] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 09:33:25 -0800
Message-ID: <8be8ab72-0670-4821-b235-1f8e4ea170b2@quicinc.com>
Date:   Tue, 28 Nov 2023 11:33:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] freezer,sched: do not restore saved_state of a thawed
 task
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, "Ingo Molnar" <mingo@kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Abhijeet Dharmapurikar <quic_adharmap@quicinc.com>
References: <20231120-freezer-state-multiple-thaws-v1-0-f2e1dd7ce5a2@quicinc.com>
 <a86228f5-c1ae-4afe-87bd-5144633a9601@quicinc.com>
 <20231128173119.GC3818@noisy.programming.kicks-ass.net>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20231128173119.GC3818@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xsBc_mpHuBkHKJwTNRh5WGS6awHkTJEe
X-Proofpoint-ORIG-GUID: xsBc_mpHuBkHKJwTNRh5WGS6awHkTJEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_18,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=647
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2023 11:31 AM, Peter Zijlstra wrote:
> On Tue, Nov 28, 2023 at 05:12:00PM +0800, Aiqun(Maria) Yu wrote:
>> On 11/21/2023 1:36 AM, Elliot Berman wrote:
>>> This series applies couple fixes to commit 8f0eed4a78a8 ("freezer,sched:
>>> Use saved_state to reduce some spurious wakeups") which was found while
>>> testing with legacy cgroup freezer. My original testing was only with
>>> system-wide freezer. We found that thaw_task could be called on a task
>>> which was already frozen. Prior to commit 8f0eed4a78a8 ("freezer,sched:
>>> Use saved_state to reduce some spurious wakeups"), this wasn't an issue
>>> as kernel would try to wake up TASK_FROZEN, which wouldn't match the
>>> thawed task state, and no harm done to task. After commit 8f0eed4a78a8
>>> ("freezer,sched: Use saved_state to reduce some spurious wakeups"), it
>>> was possible to overwrite the state of thawed task.
>>>
>>> To: Rafael J. Wysocki <rafael@kernel.org>
>>> To: Pavel Machek <pavel@ucw.cz>
>>> To: Ingo Molnar <mingo@kernel.org>
>>> To: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Cc:  <linux-arm-msm@vger.kernel.org>
>>> Cc: Pavan Kondeti <quic_pkondeti@quicinc.com>
>>> Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
>>> Cc:  <linux-pm@vger.kernel.org>
>>> Cc:  <linux-kernel@vger.kernel.org>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> Shall we add Fixed tag and Cc: stable@vger.kernel.org ?
>> Since it is fixing a stable user thread hung issue.
> 
> If you want this routed through urgent, then yes.

Fixes tag is added to https://lore.kernel.org/all/20231120-freezer-state-multiple-thaws-v1-1-f2e1dd7ce5a2@quicinc.com/

Is CC'ing stable what triggers routing through urgent?

Thanks,
Elliot
