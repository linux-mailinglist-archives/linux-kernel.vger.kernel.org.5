Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E6D76A48C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjGaXK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGaXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:10:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384B19F;
        Mon, 31 Jul 2023 16:10:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VMuIP4009841;
        Mon, 31 Jul 2023 23:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ry5bpxN/GcJzG3E2og5Mdyx0LupQp3g6Wh2YRZLBktk=;
 b=OWpcXSX25umehtFL9WhgQa+2nyn1guG0xewH1edRIExg9NIFJhsU+BVeVWYDoc8qq9j8
 zf0K5M7yZjJnmrkrOtw0p043TuuYhDOCWQz+NDp+IF9FGRt9TXDMKV24JMwqbxwH2LF9
 fjeZCTilWiYrkY/+lo1wKGfxqIui/dBTS7ZXDj6IwbNH/N8oLkZD619CrIF6EzHRUj0i
 OKYQ5jz09gIrJ1TstUxMoEDeKzuSq45QRys1V8U57xR1KGgRRmJYHojFy97klF4EPxae
 mz1CuPuTlAidgky0IKAQCM2doUh9B67nwAbfLqDpqAC1ysOIPvfU2KfJRlqVDMZrpnnV ZA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d8gsje6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 23:10:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VNAFJb029019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 23:10:15 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 16:10:15 -0700
Date:   Mon, 31 Jul 2023 16:10:14 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Chris Lew <quic_clew@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
Subject: Re: [PATCH 1/4] soc: qcom: aoss: Move length requirements from caller
Message-ID: <20230731231014.GI1428172@hu-bjorande-lv.qualcomm.com>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-2-quic_bjorande@quicinc.com>
 <e4592feb-3878-b0eb-61e4-fb6dfc358e1a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e4592feb-3878-b0eb-61e4-fb6dfc358e1a@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CvMc4eTeUlbqtP3w7NPv6DO1jc0S2WI_
X-Proofpoint-GUID: CvMc4eTeUlbqtP3w7NPv6DO1jc0S2WI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 02:29:44PM -0700, Chris Lew wrote:
> 
> 
> On 7/30/2023 9:10 PM, Bjorn Andersson wrote:
> > diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> >   	/* The message RAM only implements 32-bit accesses */
> >   	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
> > -			 data, len / sizeof(u32));
> > -	writel(len, qmp->msgram + qmp->offset);
> > +			 buf, sizeof(buf) / sizeof(u32));
> > +	writel(sizeof(buf), qmp->msgram + qmp->offset);
> 
> Looks like we are telling the firmware the packet size will always be
> QMP_MSG_LEN?
> 
> This should be ok but might be a problem when debugging. The AOSS firmware
> only logs size of the message instead of the full string because of memory
> constraints.
> 

Until now ipa_power_retention() has been passing 36 here, everyone else
64, so it is ok.

> We would normally match the firmware and host logs based on size, but won't
> be able to differentiate this way with a fixed size.

I don't mind us changing it to ALIGN(len, 4), but as that would change
the current behavior I'd like to do so in a subsequent patch.

Speaking of behavior, is 64 the max message size? We inherited the 64
from the initial downstream implementation, but qmp->size is quite a bit
bigger.

Regards,
Bjorn
