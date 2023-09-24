Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACAA7AC63C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 03:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjIXBt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 21:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjIXBtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 21:49:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F2911D;
        Sat, 23 Sep 2023 18:49:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38O1nQgh027351;
        Sun, 24 Sep 2023 01:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4VLKUqTxeqOaNbyYh4MYg0CT/s3Ahd/+306CMK1HYi0=;
 b=M0psSG3guhtUT4LPooJOu7g64WqFePnXdBOsxI1oGt4WWwWXclgjN6extBX9qMjBvkIh
 krNCqQi74Qtt31gb17654ISEqT7RFWxaubqI6ElJzcG11HVHLAbacMh/eDjg8s2vCRri
 GTGyfPD5MTGDWhbMQ2bgHT3/Cdom/dTXwpMRFwI89MlADWdwShPjcPrmlLUNvkgr+Khv
 AUi1kQouW+P77jRutYZELs0rYCGYKQujdugZoH4Kt/y7R/lfXFwX1a9vsYh8WS67rBPY
 mN6ZbbULDf18u4Qb/xdNddgqxNhWyVbEl91wrTm81qQ3gEQT6ctgoYcrVj1VAITJkUEY Jg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9saf9ccg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Sep 2023 01:49:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38O1nPfJ006722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Sep 2023 01:49:25 GMT
Received: from [10.216.19.6] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sat, 23 Sep
 2023 18:49:21 -0700
Message-ID: <0db026e7-6017-83ed-4071-c2ea6d72e3d7@quicinc.com>
Date:   Sun, 24 Sep 2023 07:19:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2 net-next 2/2] net: qrtr: Add support for processing
 DEL_PROC type control message
Content-Language: en-US
To:     Chris Lew <quic_clew@quicinc.com>, <mani@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_viswanat@quicinc.com>, <horms@kernel.org>
References: <20230920053317.2165867-1-quic_srichara@quicinc.com>
 <20230920053317.2165867-3-quic_srichara@quicinc.com>
 <349a7b1c-915f-4f58-260f-900aa7e3db65@quicinc.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <349a7b1c-915f-4f58-260f-900aa7e3db65@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9xriFD8UV0JUzODUSEkrLtI4pQ8BHVnB
X-Proofpoint-GUID: 9xriFD8UV0JUzODUSEkrLtI4pQ8BHVnB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-23_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309240013
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/2023 5:56 AM, Chris Lew wrote:
> 
> On 9/19/2023 10:33 PM, Sricharan Ramabadhran wrote:
> 
>> @@ -122,6 +123,9 @@ static DEFINE_XARRAY_ALLOC(qrtr_ports);
>>    * @qrtr_tx_lock: lock for qrtr_tx_flow inserts
>>    * @rx_queue: receive queue
>>    * @item: list item for broadcast list
>> + * @kworker: worker thread for recv work
>> + * @task: task to run the worker thread
>> + * @read_data: scheduled work for recv work
> 
> I think I made these descriptions a bit ambiguous with "recv work". 
> Since we are only parsing DEL_PROC messages at the moment, the 
> descriptions should be more accurate on what they are for.

  ok, btw, then would keep your authorship in first place.
  In our downstream, there were multiple changes around here and
  could not get a clear author here. I fixed this while testing
  with Modem SSR recently for our tree, that said, will fix it
  next version.

> 
>>    */
>>   struct qrtr_node {
>>       struct mutex ep_lock;
>> @@ -134,6 +138,9 @@ struct qrtr_node {
>>       struct sk_buff_head rx_queue;
>>       struct list_head item;
>> +    struct kthread_worker kworker;
>> +    struct task_struct *task;
>> +    struct kthread_work read_data;
> 
> I think our own kthread here might have been overkill. I forget why we 
> needed it instead of using a workqueue.

   I added a workqueue here because endpoint post is getting called from
   atomic contexts and below DEL_PROC handling acquires qrtr_tx_lock.

> 
>> +        if (cb->type == QRTR_TYPE_DEL_PROC) {
>> +            /* Free tx flow counters */
>> +            mutex_lock(&node->qrtr_tx_lock);
>> +            radix_tree_for_each_slot(slot, &node->qrtr_tx_flow, 
>> &iter, 0) {
>> +                flow = rcu_dereference_raw(*slot);
>> +                wake_up_interruptible_all(&flow->resume_tx);
>> +            }
>> +            mutex_unlock(&node->qrtr_tx_lock);
>> +
> 
> I don't see any other places where we use rcu_dereference_raw for the 
> flow. Does this need to be updated for the rest of the places we get the 
> flow?
> 
     Yes, without the rcu_dereference_raw there is a SPARSE warning.
     For some reason, did not see the same in other places where flow is
     de-referenced. That said, yeah, will pull this common code and
     create a new helper.

> The same loop is done in qrtr_endpoint_unregister() so maybe we should 
> look into adding a helper for this logic?
> 
>> +            /* Translate DEL_PROC to BYE for local enqueue */
>> +            cb->type = QRTR_TYPE_BYE;
>> +            pkt = (struct qrtr_ctrl_pkt *)skb->data;
>> +            memset(pkt, 0, sizeof(*pkt));
>> +            pkt->cmd = cpu_to_le32(QRTR_TYPE_BYE);
>> +
> 
> Are we relying on the remote to program the destination of this packet 
> to be the control port?
> 
     Yeah, targets like SDX modems, have a qrtr_fwd_del_proc in the
     endpoint_unregister path.

Regards,
  Sricharan

