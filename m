Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75476A2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjGaVbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjGaVaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:30:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5820319A4;
        Mon, 31 Jul 2023 14:30:18 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VLTKU1015630;
        Mon, 31 Jul 2023 21:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Up7tl0qt0HQUQxtc3m8aLw88GzHGZyI41BmbxGn0+Rg=;
 b=cmRZWd4Tbdo17n3fEThbWNC6DPhf/oiVdrmw2DVE9HK0jIMYNOuTxzvy649wwkCKQ1j7
 G9vkKTCuC0gYD3eypgC7nod/BxnxdbeW2odp1qYuI26AtBznXmrS8+PDaXV/ppofdQ+p
 uO0ryC66a8xKRWhsOU+14zPsGAba6b6WhroWIlp/E2Ib58UFYpTX0MLOkH6SixXlAk4F
 ct7ihkaMscpqu1wv+DzcjHzTdofR9Jh/rYV9K0YQw2XaXuVcmVLl05pHT0GZg9REm2W+
 UxkVzTREFwgSNLWrHSM44DJ9NVVBChwJDk967m/Hg7E/w7UIPj7CjyN+23KX0TMEum0V Dw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6fak8qcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 21:30:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VLUAED016647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 21:30:10 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 14:30:10 -0700
Message-ID: <e4592feb-3878-b0eb-61e4-fb6dfc358e1a@quicinc.com>
Date:   Mon, 31 Jul 2023 14:29:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] soc: qcom: aoss: Move length requirements from caller
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-2-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230731041013.2950307-2-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: roTXaohgMY-WI2SQze1t3CVll6O2G3BE
X-Proofpoint-GUID: roTXaohgMY-WI2SQze1t3CVll6O2G3BE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2023 9:10 PM, Bjorn Andersson wrote:
> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
>   	/* The message RAM only implements 32-bit accesses */
>   	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
> -			 data, len / sizeof(u32));
> -	writel(len, qmp->msgram + qmp->offset);
> +			 buf, sizeof(buf) / sizeof(u32));
> +	writel(sizeof(buf), qmp->msgram + qmp->offset);
>   

Looks like we are telling the firmware the packet size will always be 
QMP_MSG_LEN?

This should be ok but might be a problem when debugging. The AOSS 
firmware only logs size of the message instead of the full string 
because of memory constraints.

We would normally match the firmware and host logs based on size, but 
won't be able to differentiate this way with a fixed size.
