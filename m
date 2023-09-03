Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05488790BDF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 14:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbjICMW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjICMW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:22:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F858126;
        Sun,  3 Sep 2023 05:22:22 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383CKBDO022398;
        Sun, 3 Sep 2023 12:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k0CKR7RTDRnQ7iIZKSJscEYlJcwa01uVpg94z0vnRBI=;
 b=CmTVqNnp300JdXOZKKVokxmf7EpgbV1Fs7NU4cFUXGmzzr4jJPez+r99h/4WicD9Iq/x
 bs5Yu0E3qhrl9GpuAdCEt2/IfxDqrtCjHl8yfMsL1r32ndcjrA3R5N8N5odk8cbcwOWs
 ttmuv/IWX4Q9vvNgwCRdq4+/jBILEqHk902s/xAPYd+mMITQjtK8IfxmunJUoTju0XGE
 w6uxpCrHVxwaEogANnaJnlB3SUFTim2jX8P1s0qtyN3iWu2QKMzshCooxzS1sPUkoEXM
 70zoKAafxkvPZ6Y7UMGZxzzFvLCBkIO7Zw5VUV30ClagSedTkZer2Lifq3SdbqkhZZoX rw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suw50sn7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 12:22:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 383CMEvF008699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Sep 2023 12:22:14 GMT
Received: from [10.216.14.155] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 3 Sep
 2023 05:22:10 -0700
Message-ID: <d7b7f611-e15b-e7a0-ce99-bd6c90027853@quicinc.com>
Date:   Sun, 3 Sep 2023 17:52:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next 1/2] net: qrtr: Prevent stale ports from sending
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        <quic_clew@quicinc.com>
CC:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_viswanat@quicinc.com>
References: <1693563621-1920-1-git-send-email-quic_srichara@quicinc.com>
 <1693563621-1920-2-git-send-email-quic_srichara@quicinc.com>
 <20230901141128.GO818859@hu-bjorande-lv.qualcomm.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230901141128.GO818859@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K1vR0GmeFoPG5HBs8kCrMuVCjWkWWs7L
X-Proofpoint-ORIG-GUID: K1vR0GmeFoPG5HBs8kCrMuVCjWkWWs7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-03_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309030115
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 9/1/2023 7:41 PM, Bjorn Andersson wrote:
> On Fri, Sep 01, 2023 at 03:50:20PM +0530, Sricharan Ramabadhran wrote:
>> From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>>
>> If qrtr and some other process try to bind to the QMI Control port at
> 
> It's unclear to me which "qrtr" is being referred here, could it be
> "qrtr-ns", if so could we express that as "the name server".
> 

  yes, its name-space server. Will put it explicitly.

> We only allow one bind on the qrtr control port, so could it be that
> "QMI Control port" refer to the control socket in the userspace QC[CS]I
> libraries, if so that's just any random socket sending out a control
> message.
> 
> Can we please rephrase this problem description to make the chain of
> events clear?
> 

   In this case we are talking about a client connecting/sending to QRTR
   socket and the 'NS' doing a qrtr_bind during its init. There is
   possibility that a client tries to send to the 'NS' before  processing
   the ENETRESET. In the case of a NEW_SERVER control message will
   reach the 'NS' and be forwarded to the firmware. The client will then
   process the ENETRESET closing and re-opening the socket which triggers
   a DEL_SERVER and then a second NEW_SERVER. This scenario will give an
   unnecessary disconnect to the clients on the firmware who were able to
   initialize on the first NEW_SERVER.

   Also about the patch #2, i guess QRTR_BYE/DEL_PROC should also be
   broadcasted, right now we are only listening on DEL_PROC sent by
   legacy kernels like SDX modems. Without that modem SSR feature is
   broken on IPQ + SDX targets.

>> the same time, NEW_SERVER might come before ENETRESET is given to the
>> socket. This might cause a socket down/up when ENETRESET is received as
>> per the protocol and this triggers a DEL_SERVER and a second NEW_SERVER.
>>
>> In order to prevent such messages from stale sockets being sent, check
>> if ENETRESET has been set on the socket and drop the packet.
>>
>> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
>> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
> 
> The first person to certify the patch's origin, must be the author, and
> when you pick the patch to send it you need to add your s-o-b.
> 
> So please fix the author, and add your s-o-b.
> 

  ok sure, will fix.

> 
> Let's add Chris to the recipients list as well.
> 

  ok.

>> ---
>>   net/qrtr/af_qrtr.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
>> index 41ece61..26197a0 100644
>> --- a/net/qrtr/af_qrtr.c
>> +++ b/net/qrtr/af_qrtr.c
>> @@ -851,6 +851,7 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>>   {
>>   	struct qrtr_sock *ipc;
>>   	struct qrtr_cb *cb;
>> +	struct sock *sk = skb->sk;
>>   
>>   	ipc = qrtr_port_lookup(to->sq_port);
>>   	if (!ipc || &ipc->sk == skb->sk) { /* do not send to self */
>> @@ -860,6 +861,15 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>>   		return -ENODEV;
>>   	}
>>   
>> +	/* Keep resetting NETRESET until socket is closed */
>> +	if (sk && sk->sk_err == ENETRESET) {
>> +		sk->sk_err = ENETRESET;
> 
> Isn't this line unnecessary?
> 

  yup, will be removed in V2.

Regards,
  Sricharan
