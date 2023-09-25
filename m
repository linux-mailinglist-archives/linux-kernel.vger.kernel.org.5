Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6627AE2AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjIYXz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIYXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:55:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D7FFB;
        Mon, 25 Sep 2023 16:55:48 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PNddmU003441;
        Mon, 25 Sep 2023 23:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9WRP/dH5LzRyecuJLSulsR2WIEaltd6yZiyLu9pOr44=;
 b=MfbXRJkdMSjbeT3E5Tvi6NDku2B1FaLjc2K39/8KHnMz3yQ7702e0b4Ovn+4kMFknUKz
 wuNcvexdGn8EM0KRJKykDZuxOBbNRZv4FbqOiAgHzfmp/EbBTofwsLAuwp62QGQDjA7b
 IeFbC0sxcX4rrhrbgGjEQUEqzYH7uqWfz0q72dr172jkYtQu72XF+SBE4/ConN3i7mEB
 DOqYZ8el/RLNE3zMXPDLS0HX9qOzrWzY3eRIMQs2iRk2zg7zpy03Yiif3u6JNEVg1Bzv
 1aHftk4de7XfB7tAVeELxgZ/tjotmUPAQ29xHpuGv0o4uQhB0iEiuQIyf70uaEWtlsqy tw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb72shu55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 23:55:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PNtdAH023250
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 23:55:39 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 16:55:39 -0700
Message-ID: <dffdbd5c-3d21-5cee-03d6-b89e0caf9a41@quicinc.com>
Date:   Mon, 25 Sep 2023 16:55:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net-next 2/2] net: qrtr: Add support for processing
 DEL_PROC type control message
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_viswanat@quicinc.com>,
        <horms@kernel.org>
References: <20230920053317.2165867-1-quic_srichara@quicinc.com>
 <20230920053317.2165867-3-quic_srichara@quicinc.com>
 <349a7b1c-915f-4f58-260f-900aa7e3db65@quicinc.com>
 <0db026e7-6017-83ed-4071-c2ea6d72e3d7@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <0db026e7-6017-83ed-4071-c2ea6d72e3d7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4QfOrP3wocDMjFYvr6tmtwL2UN1bdoEs
X-Proofpoint-ORIG-GUID: 4QfOrP3wocDMjFYvr6tmtwL2UN1bdoEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=740 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/2023 6:49 PM, Sricharan Ramabadhran wrote:
>>>    */
>>>   struct qrtr_node {
>>>       struct mutex ep_lock;
>>> @@ -134,6 +138,9 @@ struct qrtr_node {
>>>       struct sk_buff_head rx_queue;
>>>       struct list_head item;
>>> +    struct kthread_worker kworker;
>>> +    struct task_struct *task;
>>> +    struct kthread_work read_data;
>>
>> I think our own kthread here might have been overkill. I forget why we 
>> needed it instead of using a workqueue.
> 
>    I added a workqueue here because endpoint post is getting called from
>    atomic contexts and below DEL_PROC handling acquires qrtr_tx_lock.


Got it, I think deferring the processing makes sense. I was more 
focusing on the fact that we are creating our own kthread instead of 
using the system workqueues.

Prior to commit e04df98adf7d ("net: qrtr: Remove receive worker"), this 
was a work_struct. I think we should keep it as a work_struct until we 
can motivate why a qrtr_node needs it's own kthread.
