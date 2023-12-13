Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF90812232
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjLMW6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjLMW6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:58:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B486CF;
        Wed, 13 Dec 2023 14:58:49 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDMRrH0025021;
        Wed, 13 Dec 2023 22:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=qcppdkim1; bh=NP7EFzGzSWr3xJEehuEaH
        FNBqnTzbp9svuRkZjLJpIg=; b=GmSO81oGf0DHtJzuwuNRWjgAoREqygR+nSh+i
        SXxnUSDYjdnLSN4DTDAAD4axnGVBDNspMhdmqkZZyzgYr8hZ4MqEJqpTUO/oFNDT
        YCUtstmKC6/rFsrIOhG5QslktU/zB/1Kn6LSTF7HRKQHqjYylG/k3thv+4FqOTWw
        ObAWQHVGoYySl1/zzCvPtlhb0uClvCuACTWQDYZIwcaV5seYLRtiyvjgLqvre9md
        6/e0ymnvzGBZZbAQE/VzjgYUe+rUYVpnNcWuPpqPcjcFS2Isc2Ae5RFS5eA5lvAb
        MUBYmvwzKtVplu25cX/Y9/5hXyigSis7mIZj6ut6blg8Svetg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy32naqjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 22:58:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDMwenj020451
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 22:58:40 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 14:58:39 -0800
Date:   Wed, 13 Dec 2023 14:58:38 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
CC:     "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rpmsg: glink: Fix buffer overflow
Message-ID: <20231213225838.GQ1766637@hu-bjorande-lv.qualcomm.com>
References: <20231211160221.2843339-1-hardevsinh.palaniya@siliconsignals.io>
 <20231211184010.GM1766637@hu-bjorande-lv.qualcomm.com>
 <MA0PR01MB7145C9A06689F2C5C43A3876FF8DA@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <MA0PR01MB7145C9A06689F2C5C43A3876FF8DA@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7Y1GNvv0MyO9zVXySLREKgiMNY4YodMg
X-Proofpoint-GUID: 7Y1GNvv0MyO9zVXySLREKgiMNY4YodMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=825
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312130162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:15:15PM +0000, Hardevsinh Palaniya wrote:
>    Hello [1]@Bjorn Andersson,

Please use appropriate mail list etiquette, and avoid HTML and
top-posting in your responses.

> 
>    "strscpy_pad" itself takes care of null-terminated strings. So, there
>    will be no leak.

Your strscpy_pad() will NUL-terminate and zero-pad up to 32 bytes.
Following this the next line will write strlen(name) + sizeof(hdr) bytes
to the FIFO.

So if strlen(name) >= 32 you will read beyond the end of the zero-padded
string.

Regards,
Bjorn

>      __________________________________________________________________
> 
>    From: Bjorn Andersson <quic_bjorande@quicinc.com>
>    Sent: Tuesday, December 12, 2023 12:10 AM
>    To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
>    Cc: agross@kernel.org <agross@kernel.org>; andersson@kernel.org
>    <andersson@kernel.org>; Konrad Dybcio <konrad.dybcio@linaro.org>;
>    Mathieu Poirier <mathieu.poirier@linaro.org>;
>    linux-arm-msm@vger.kernel.org <linux-arm-msm@vger.kernel.org>;
>    linux-remoteproc@vger.kernel.org <linux-remoteproc@vger.kernel.org>;
>    linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
>    Subject: Re: [PATCH] rpmsg: glink: Fix buffer overflow
> 
>    On Mon, Dec 11, 2023 at 09:32:20PM +0530, Hardevsinh Palaniya wrote:
>    > In qcom_glink_send_open_req() remove error: strcpy() 'channel->name'
>    > too large for 'req.name' (1010102 vs 32)
>    >
>    As far as I can tell, channel->name comes from the struct
>    rpmsg_channel_info->name, which is a 32-byte array, and all code paths
>    I
>    can find either uses strscpy() or explicitly NUL-terminates this
>    string.
>    I'm curious to know which path took us here.
>    > Signed-off-by: Hardevsinh Palaniya
>    <hardevsinh.palaniya@siliconsignals.io>
>    >
>    > diff --git a/drivers/rpmsg/qcom_glink_native.c
>    b/drivers/rpmsg/qcom_glink_native.c
>    > index 82d460ff4777..2d6a592e1c72 100644
>    > --- a/drivers/rpmsg/qcom_glink_native.c
>    > +++ b/drivers/rpmsg/qcom_glink_native.c
>    > @@ -479,7 +479,7 @@ static int qcom_glink_send_open_req(struct
>    qcom_glink *glink,
>    >        req.msg.cmd = cpu_to_le16(GLINK_CMD_OPEN);
>    >        req.msg.param1 = cpu_to_le16(channel->lcid);
>    >        req.msg.param2 = cpu_to_le32(name_len);
>    > -     strcpy(req.name, channel->name);
>    > +     strscpy_pad(req.name, channel->name, sizeof(req.name));
>    I think this patch is incomplete. While it makes sure we don't
>    overwrite
>    the stack. name_len is strlen(channel->name) + 1 and the amount of data
>    sent out is based on name_len.
>    As such, if you can get here with a @name of arbitrary length, then you
>    can control how much of the stack we're going to now leak to the
>    recipient.
>    Regards,
>    Bjorn
>    >
>    >        ret = qcom_glink_tx(glink, &req, req_len, NULL, 0, true);
>    >        if (ret)
>    > --
>    > 2.25.1
>    >
>    >
> 
> References
> 
>    1. mailto:quic_bjorande@quicinc.com
