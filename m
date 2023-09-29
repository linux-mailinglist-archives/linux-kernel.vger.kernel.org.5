Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619017B36C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjI2P0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjI2P0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:26:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CA61B1;
        Fri, 29 Sep 2023 08:25:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TBmo2G028042;
        Fri, 29 Sep 2023 15:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3oFoRsKuZ0yvUhR/+q/pXBjxRc8RbVvYILT+FHFUT7o=;
 b=YdNzMYyPm9lVvk2l9vvY0leIbD5S9kKfn9UShQrsW9OX1ZKREw1UZG3KWCXIA6k2j2Lw
 CMMJQoLf3C9Ouj9Fe6L+0dZ1fXul0/NYczopIlS18xTq8dZuGZaGUfmJXWFXCLvjK/ed
 YCZvatCJO6RN2VUIT6cujyc2Y+qo8q6K5j2Mmq0RpiRUFl7iKXtsd/uuGgur+iWDJoMP
 b4b6tXoW9EjCisJkIgd3+B996g68FQCIjHNLy0QrGthj1BG6UZ0wOZu7DXTiWJurIUPu
 EzOh1xuLf6NU6gGCou37Zi+M1UyxrygMx/KdARnW71pwCZoiUfqRfUHxfQkXe7nJo7Dt hw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdx17gn1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 15:25:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38TFPqhD031689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 15:25:52 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 29 Sep
 2023 08:25:51 -0700
Message-ID: <6b396b1a-58a7-bf7c-f644-f1bf298a31e0@quicinc.com>
Date:   Fri, 29 Sep 2023 09:25:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 2/2] bus: mhi: host: Take irqsave lock after TRE is
 generated
Content-Language: en-US
To:     Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>, Hemant Kumar <quic_hemantk@quicinc.com>,
        "Lazarus Motha" <quic_lmotha@quicinc.com>
References: <1694594861-12691-1-git-send-email-quic_qianyu@quicinc.com>
 <1694594861-12691-3-git-send-email-quic_qianyu@quicinc.com>
 <e40a1dca-f23e-af32-320e-bf66a894bc6c@quicinc.com>
 <a82e188e-2d0e-7c0f-de54-79bbc4b6957b@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <a82e188e-2d0e-7c0f-de54-79bbc4b6957b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K8GoSBAu3pTw1WrIYUByudBQ_EFNujoF
X-Proofpoint-ORIG-GUID: K8GoSBAu3pTw1WrIYUByudBQ_EFNujoF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_13,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=764 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290133
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/2023 10:08 PM, Qiang Yu wrote:
> 
> On 9/22/2023 10:50 PM, Jeffrey Hugo wrote:
>> On 9/13/2023 2:47 AM, Qiang Yu wrote:
>>> From: Hemant Kumar <quic_hemantk@quicinc.com>
>>>
>>> Take irqsave lock after TRE is generated to avoid deadlock due to core
>>> getting interrupts enabled as local_bh_enable must not be called with
>>> irqs disabled based on upstream patch.
>>
>> Where is local_bh_enable() being called?  What patch?  What is 
>> upstream of the codebase you submitted this to?  Why is it safe to 
>> call mhi_gen_tre() without the lock?
> 
> This patch is to fix the issue included by  "[PATCH v2 1/2] bus: mhi: 
> host: Add spinlock to protect WP access when queueing TREs". In that 
> patch, we add write_lock_bh/write_unlock_bh in mhi_gen_tre().
> 
> However, before mhi_gen_tre() is invoked, mhi_cntrl->pm_lock is getted, 
> line 1125, and it is a spin lock. So it becomes we want to get and 
> release bh lock after spin lock.  __local_bh_enable_ip is called as part 
> of write_unlock_bh
> 
> and local_bh_enable. When CONFIG_TRACE_IRQFLAGS is enabled, irq will be 
> enabled once __local_bh_enable_ip is called. The commit message is not 
> clear and confusing, will change it in [patch v3].
> 

In addition to clarifying the commit message, I recommend looking at 
adding this to the other patch.  It seems very odd to review a series 
where one patch introduces a known issue, and a following patch corrects 
that issue.  It would be better to not introduce the issue in the first 
place.
