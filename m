Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F078FEC8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbjIAOMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345352AbjIAOMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:12:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AFC10FC;
        Fri,  1 Sep 2023 07:11:45 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381AjHOF022994;
        Fri, 1 Sep 2023 14:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=T95fhzdpLZ9FIIjOpz7F+rzBUf8gHJ265d5aJDNLhLg=;
 b=cffMsC1QMn0KlEvcL8fIrecV6ygcz2OnplIiwFcATWeSnj66Y5/Ws26PWmB6tPoA+BdY
 Q6oUf/ZZsqgOkRQsHtqgE9SA9S/Qttmr4VEoTSccpnHWaRzE9RRHIIxarnfsJM5BiJr8
 CRt5pd9a14nqizOybM/WanbuPlx0neLgV3IMu59OoSf2jb+yikXV85VFcad5GXIlBjKX
 NOgXT5xj8algk+Ko+aQMxzPT8r7RsS+U/HiJ6TNeUyufZdAsE5d72JjdP0NXubElWjYT
 +cD+fxULOV/c2Xz1WGFMWGdLd1S1vklfb28ed9Rnk2tfInaa/t86lPxHDqJK1pSXZvWN Vg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suc9k0txk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 14:11:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381EBTwG009676
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 14:11:29 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 1 Sep 2023 07:11:29 -0700
Date:   Fri, 1 Sep 2023 07:11:28 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        <quic_clew@quicinc.com>
CC:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_viswanat@quicinc.com>
Subject: Re: [PATCH net-next 1/2] net: qrtr: Prevent stale ports from sending
Message-ID: <20230901141128.GO818859@hu-bjorande-lv.qualcomm.com>
References: <1693563621-1920-1-git-send-email-quic_srichara@quicinc.com>
 <1693563621-1920-2-git-send-email-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1693563621-1920-2-git-send-email-quic_srichara@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gvvVWahd67BmrYyohr1zV2BGUXTRRsg0
X-Proofpoint-ORIG-GUID: gvvVWahd67BmrYyohr1zV2BGUXTRRsg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=550
 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309010132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 03:50:20PM +0530, Sricharan Ramabadhran wrote:
> From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
> 
> If qrtr and some other process try to bind to the QMI Control port at

It's unclear to me which "qrtr" is being referred here, could it be
"qrtr-ns", if so could we express that as "the name server".

We only allow one bind on the qrtr control port, so could it be that
"QMI Control port" refer to the control socket in the userspace QC[CS]I
libraries, if so that's just any random socket sending out a control
message.

Can we please rephrase this problem description to make the chain of
events clear?

> the same time, NEW_SERVER might come before ENETRESET is given to the
> socket. This might cause a socket down/up when ENETRESET is received as
> per the protocol and this triggers a DEL_SERVER and a second NEW_SERVER.
> 
> In order to prevent such messages from stale sockets being sent, check
> if ENETRESET has been set on the socket and drop the packet.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>

The first person to certify the patch's origin, must be the author, and
when you pick the patch to send it you need to add your s-o-b.

So please fix the author, and add your s-o-b.


Let's add Chris to the recipients list as well.

> ---
>  net/qrtr/af_qrtr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index 41ece61..26197a0 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c
> @@ -851,6 +851,7 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  {
>  	struct qrtr_sock *ipc;
>  	struct qrtr_cb *cb;
> +	struct sock *sk = skb->sk;
>  
>  	ipc = qrtr_port_lookup(to->sq_port);
>  	if (!ipc || &ipc->sk == skb->sk) { /* do not send to self */
> @@ -860,6 +861,15 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  		return -ENODEV;
>  	}
>  
> +	/* Keep resetting NETRESET until socket is closed */
> +	if (sk && sk->sk_err == ENETRESET) {
> +		sk->sk_err = ENETRESET;

Isn't this line unnecessary?

Regards,
Bjorn

> +		sk_error_report(sk);
> +		qrtr_port_put(ipc);
> +		kfree_skb(skb);
> +		return 0;
> +	}
> +
>  	cb = (struct qrtr_cb *)skb->cb;
>  	cb->src_node = from->sq_node;
>  	cb->src_port = from->sq_port;
> -- 
> 2.7.4
> 
