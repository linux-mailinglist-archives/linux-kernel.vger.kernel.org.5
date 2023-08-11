Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE377930A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjHKP1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHKP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:27:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F788F5;
        Fri, 11 Aug 2023 08:27:20 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BE5L7M023199;
        Fri, 11 Aug 2023 15:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Mzquj8eTvhvEyz0nSaD8F2VvGcyfO5NM+CW4hTL1NQw=;
 b=EDHbNOObH+THUyxh3BkK+qoHQ/le0emdST4x+V978qX/EqJFMb1Kooa889paOnZTKMJf
 gBxDuulNW7bp6EMafClvMWgMg2FPwIxa4kgAp9SR+7to/atrGGWj3Meh88Qq71oTJd+S
 pUvvuBfux0B659QjYHyb7+Mvbc5TarDS6I8w1ArtQH0G1IONj1lSut8TV6HRrhaDt6ez
 jFk49kewju3gyZHciAAnhI+xMnIfdcuSDxIZCkKn0N+k789Rua5PRWELngrtgMEosomm
 dzBmObml8obsg+YfGNSQRjuDet2lPM5C2ATCanwkoHEjz5DTnl5GgTPZNqitFZ1V8tur nw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8yda2cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 15:26:44 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BFQhja009600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 15:26:43 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 08:26:43 -0700
Date:   Fri, 11 Aug 2023 08:26:41 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] interconnect: qcom: bcm-voter: Improve enable_mask
 handling
Message-ID: <20230811152641.GR1428172@hu-bjorande-lv.qualcomm.com>
References: <20230811-topic-icc_fix_1he-v1-0-5c96ccef3399@linaro.org>
 <20230811-topic-icc_fix_1he-v1-1-5c96ccef3399@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811-topic-icc_fix_1he-v1-1-5c96ccef3399@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MFFk38_6czTssm7vmajHSBtUZ9HPpD75
X-Proofpoint-ORIG-GUID: MFFk38_6czTssm7vmajHSBtUZ9HPpD75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=801 bulkscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308110141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:55:07PM +0200, Konrad Dybcio wrote:
> We don't need all the complex arithmetic for BCMs utilizing enable_mask,
> as all we need to do is to determine whether there's any user (or
> keepalive) asking for it to be on.
> 
> Separate the logic for such BCMs for a small speed boost.
> 

Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn
