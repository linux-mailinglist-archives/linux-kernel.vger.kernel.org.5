Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0617A9026
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjIUA0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIUA0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:26:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE799D7;
        Wed, 20 Sep 2023 17:26:36 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38L0QRU1005211;
        Thu, 21 Sep 2023 00:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hiFCCl/MJHW12WaPm21+mtf9pdSpv8QL8D+K6g5ozQU=;
 b=GJAiIcVhPBP2epM0fRlLXLhMudaIR4OEilS6FY46jD6BHN6EnddPOTniw6YE7V+ppjKX
 AE3mb+nex4TjmpZ0cxhUjmQNbDqe4eyj7gU1d4Q1arYnnn7By9Lkf4mqcn3LMut/DYEt
 +xUgloYnI9wszyxdJ4QN3qqRr70vKwIVSHZUclck06YgoDEntSq5ljwm33bLkta9CMCj
 ELn1KSkbpMjdGGbF6TL9VLvR6mEZeD24sPNR7av22yM6qNJuRWVIjdRUwHh0V81SH+Gm
 AkX/X7tlt8t2txWEktQWl25D+xGDaUtRi6bHvh+gXvq0FqiCaDLjn8yhN0t7+NK5T4tx qg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7rhutkr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 00:26:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38L0QQZJ003410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 00:26:26 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 20 Sep
 2023 17:26:25 -0700
Message-ID: <349a7b1c-915f-4f58-260f-900aa7e3db65@quicinc.com>
Date:   Wed, 20 Sep 2023 17:26:25 -0700
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
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230920053317.2165867-3-quic_srichara@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dQ90yI795B6dzzHNMLJKua5wLu4G7y-r
X-Proofpoint-GUID: dQ90yI795B6dzzHNMLJKua5wLu4G7y-r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_12,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 adultscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210001
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/19/2023 10:33 PM, Sricharan Ramabadhran wrote:

> @@ -122,6 +123,9 @@ static DEFINE_XARRAY_ALLOC(qrtr_ports);
>    * @qrtr_tx_lock: lock for qrtr_tx_flow inserts
>    * @rx_queue: receive queue
>    * @item: list item for broadcast list
> + * @kworker: worker thread for recv work
> + * @task: task to run the worker thread
> + * @read_data: scheduled work for recv work

I think I made these descriptions a bit ambiguous with "recv work". 
Since we are only parsing DEL_PROC messages at the moment, the 
descriptions should be more accurate on what they are for.

>    */
>   struct qrtr_node {
>   	struct mutex ep_lock;
> @@ -134,6 +138,9 @@ struct qrtr_node {
>   
>   	struct sk_buff_head rx_queue;
>   	struct list_head item;
> +	struct kthread_worker kworker;
> +	struct task_struct *task;
> +	struct kthread_work read_data;

I think our own kthread here might have been overkill. I forget why we 
needed it instead of using a workqueue.

> +		if (cb->type == QRTR_TYPE_DEL_PROC) {
> +			/* Free tx flow counters */
> +			mutex_lock(&node->qrtr_tx_lock);
> +			radix_tree_for_each_slot(slot, &node->qrtr_tx_flow, &iter, 0) {
> +				flow = rcu_dereference_raw(*slot);
> +				wake_up_interruptible_all(&flow->resume_tx);
> +			}
> +			mutex_unlock(&node->qrtr_tx_lock);
> +

I don't see any other places where we use rcu_dereference_raw for the 
flow. Does this need to be updated for the rest of the places we get the 
flow?

The same loop is done in qrtr_endpoint_unregister() so maybe we should 
look into adding a helper for this logic?

> +			/* Translate DEL_PROC to BYE for local enqueue */
> +			cb->type = QRTR_TYPE_BYE;
> +			pkt = (struct qrtr_ctrl_pkt *)skb->data;
> +			memset(pkt, 0, sizeof(*pkt));
> +			pkt->cmd = cpu_to_le32(QRTR_TYPE_BYE);
> +

Are we relying on the remote to program the destination of this packet 
to be the control port?

Thanks,
Chris
