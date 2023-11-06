Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02F37E308E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjKFXBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKFXBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:01:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019FBD6E;
        Mon,  6 Nov 2023 15:01:45 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6K0Sjw008971;
        Mon, 6 Nov 2023 23:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=2ZEGF09vQGpieHjlo7ZfV0+0rZKfuX0JG4PVEwlxX5I=;
 b=ke4sWr+SKehvDu+G9fV0T8bDUQ2qRXEwApucvPf7ZQQGdairL3djwRtvEb/AVrOItfCz
 W3+5qvHltOsPWuVhFtriwx2VgekkuE052KrpEzCOisW4EycxqfkulHERoPwzmSxstz4i
 63WPC8h7dOXgfatVD8VIU2QOHxUUv/x0kK30IlKZEBRRh7WSLUzJorLQkBPgqQzCG9fG
 0P5Cx9p+M5xpVFL18S3L7PEIzZGBDiPwKMdqw97O9MUrNdvmOERqKDjkLaGN34xuvdaG
 CURJMunfeQMgUGuGYGohCK3dSyK6yLI+ksFQzWL1em76vtnEz6UKAnr9GMlwjJwCSuig 5Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u71br96pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 23:01:17 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6N15Ef029179
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 23:01:05 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 15:01:04 -0800
Date:   Mon, 6 Nov 2023 15:01:03 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     Atul Dhudase <quic_adhudase@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <swboyd@chromium.org>, <isaacm@codeaurora.org>,
        <dianders@chromium.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc
 configuration
Message-ID: <20231106230103.GA3553829@hu-bjorande-lv.qualcomm.com>
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
 <20231103193345.GY3553829@hu-bjorande-lv.qualcomm.com>
 <5e83d947-c77f-9318-4a4c-377a8304b8fd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e83d947-c77f-9318-4a4c-377a8304b8fd@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BQzNfI0YYRY4HVJo0YpcOS6tgd0Czf8Q
X-Proofpoint-GUID: BQzNfI0YYRY4HVJo0YpcOS6tgd0Czf8Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 12:24:28PM +0530, Mukesh Ojha wrote:
> 
> 
> On 11/4/2023 1:03 AM, Bjorn Andersson wrote:
> > On Fri, Nov 03, 2023 at 04:27:12PM +0530, Atul Dhudase wrote:
> > > While programming dis_cap_alloc and retain_on_pc, set a bit
> > > corresponding to a specific SCID without disturbing the
> > > previously configured bits.
> > > 
> > 
> > As far as I can see, the only invocation of _qcom_llcc_cfg_program()
> > comes from qcom_llcc_cfg_program(), which is only called once, from
> > qcom_llcc_probe(), and here also seems to only be the single write to
> > these two registers.
> 
> It does not look to be single write but the write is for each slice
> in the same register which was overriding other slices values.
> 

Ahh, you're right. I missed that it was hitting the same register in
each iteration.

My concern remains though, unless a platform defines 32 slices only a
subset of the bits in the two registers will be touched - leaving the
remaining bits in whatever state they happened to have.

Regards,
Bjorn

> -Mukesh
> > 
> > This implies that "the previously configured bits" would be some unknown
> > configuration provided to us either from the bootloader or by reset of
> > the hardware. As such this changes the value of the two registers from
> > being known, to having 31 unknown bits.
> > 
> > 
> > I'm not saying that the change is wrong, but you're altering the
> > behavior of every platform except SDM845.
> > As such, I want the commit message to provide an actual problem
> > description, and mention the fact that you're changing the logic to
> > retain the state prior to Linux.
> > 
> > Regards,
> > Bjorn
> > 
> > > Fixes: c14e64b46944 ("soc: qcom: llcc: Support chipsets that can write to llcc")
> > > Signed-off-by: Atul Dhudase <quic_adhudase@quicinc.com>
> > > ---
> > >   drivers/soc/qcom/llcc-qcom.c | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> > > index 674abd0d6700..509d972c1bd9 100644
> > > --- a/drivers/soc/qcom/llcc-qcom.c
> > > +++ b/drivers/soc/qcom/llcc-qcom.c
> > > @@ -941,15 +941,15 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
> > >   		u32 disable_cap_alloc, retain_pc;
> > > 
> > >   		disable_cap_alloc = config->dis_cap_alloc << config->slice_id;
> > > -		ret = regmap_write(drv_data->bcast_regmap,
> > > -				LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_alloc);
> > > +		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_SCID_DIS_CAP_ALLOC,
> > > +				BIT(config->slice_id), disable_cap_alloc);
> > >   		if (ret)
> > >   			return ret;
> > > 
> > >   		if (drv_data->version < LLCC_VERSION_4_1_0_0) {
> > >   			retain_pc = config->retain_on_pc << config->slice_id;
> > > -			ret = regmap_write(drv_data->bcast_regmap,
> > > -					LLCC_TRP_PCB_ACT, retain_pc);
> > > +			ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_PCB_ACT,
> > > +					BIT(config->slice_id), retain_pc);
> > >   			if (ret)
> > >   				return ret;
> > >   		}
> > > --
> > > 2.25.1
> > > 
