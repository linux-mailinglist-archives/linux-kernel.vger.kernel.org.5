Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C620580D79F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345371AbjLKSkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345340AbjLKSkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:40:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D72AC;
        Mon, 11 Dec 2023 10:40:20 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBDsDtl001856;
        Mon, 11 Dec 2023 18:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=qcppdkim1; bh=MRRNuQONWClYR4eBG1E1+
        q5vj4Ilwq/AJXvmsCIPt34=; b=TpTbgBZV02G9wloAMA/MpC3qVzdVI6IdPGdNK
        UZD6tP4og3gwEuqbZ6knulcUx7EI5JDXi88lbVUVD36k9foS/MLAOG0U4MFCOtkZ
        SfQjZJRmHO0wHM7YxuASCmNWclnLGNc6cnXa3aXl7AkeDvfv18qWejU6VvI52xKW
        SO3wYAp83geuA1uniGSPiJ+cOcv+cdyE2Y+cBe+ST9WgqkPI/BOVDfclOAFNZw4D
        6zZAqBcNeBsu39hy6+1V1QrLhpABpLC83ZZo9oPo0IMAkzahhHA7KgO0qK0mwCoK
        JwPZvLVll7j3B4DgpoLNIsTV6ctVXSK8oafDcWXNnVFL77Vng==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ux28s8wau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 18:40:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BBIeBgM014042
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 18:40:11 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 10:40:11 -0800
Date:   Mon, 11 Dec 2023 10:40:10 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rpmsg: glink: Fix buffer overflow
Message-ID: <20231211184010.GM1766637@hu-bjorande-lv.qualcomm.com>
References: <20231211160221.2843339-1-hardevsinh.palaniya@siliconsignals.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231211160221.2843339-1-hardevsinh.palaniya@siliconsignals.io>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e8VfhhdK2sZICJzW7tRnNXJOMb_xuMQ5
X-Proofpoint-GUID: e8VfhhdK2sZICJzW7tRnNXJOMb_xuMQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=397 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312110154
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 09:32:20PM +0530, Hardevsinh Palaniya wrote:
> In qcom_glink_send_open_req() remove error: strcpy() 'channel->name'
> too large for 'req.name' (1010102 vs 32)
> 

As far as I can tell, channel->name comes from the struct
rpmsg_channel_info->name, which is a 32-byte array, and all code paths I
can find either uses strscpy() or explicitly NUL-terminates this string.

I'm curious to know which path took us here.

> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 82d460ff4777..2d6a592e1c72 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -479,7 +479,7 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
>  	req.msg.cmd = cpu_to_le16(GLINK_CMD_OPEN);
>  	req.msg.param1 = cpu_to_le16(channel->lcid);
>  	req.msg.param2 = cpu_to_le32(name_len);
> -	strcpy(req.name, channel->name);
> +	strscpy_pad(req.name, channel->name, sizeof(req.name));

I think this patch is incomplete. While it makes sure we don't overwrite
the stack. name_len is strlen(channel->name) + 1 and the amount of data
sent out is based on name_len.

As such, if you can get here with a @name of arbitrary length, then you
can control how much of the stack we're going to now leak to the
recipient.

Regards,
Bjorn

>  
>  	ret = qcom_glink_tx(glink, &req, req_len, NULL, 0, true);
>  	if (ret)
> -- 
> 2.25.1
> 
> 
