Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660077E097D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjKCTe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjKCTeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:34:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC5FD5C;
        Fri,  3 Nov 2023 12:34:20 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3ImtN1018633;
        Fri, 3 Nov 2023 19:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=NnkKwHdTAG/uIB15wK/mUUmEM7fyaAx7mLbZtB7bWyk=;
 b=Vac+K9PaalKrkRgnP/MuB9UxdYy3tRRhRYsdSXnygZCeqY5tlZqj7h30iSnUtiAh4ltD
 fHkbpFhe5moOUsGUu+iHzqCA3DNrDFecWb9hs9mdpxutw+cR4xb56fSil6Wlb1Tb+HxJ
 9PfQ+bEhDLD/14vX4lUVua9iNViaACkAMW3Ytlf0vxpej6zMZSHEf0LH3yW77+Cu/dL+
 88UGXJs2HqZo5T9NPfS/w0FzjHpiY+oqGVOFSR5Uhwv9+jwKeNtFi2AMszmpqRb30ZqP
 9d0Fk60RO7kjhjrrHydDbzFBjQIY1UBxIh4YIHT786KscUHTyVO9aFmzYL0jlYNxDQkj zA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4r00j152-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 19:33:47 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3JXkeM006513
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 19:33:46 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 12:33:45 -0700
Date:   Fri, 3 Nov 2023 12:33:45 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Atul Dhudase <quic_adhudase@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <swboyd@chromium.org>,
        <isaacm@codeaurora.org>, <dianders@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc
 configuration
Message-ID: <20231103193345.GY3553829@hu-bjorande-lv.qualcomm.com>
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RJd56D_8WL5cb-sR_2q6tCtBeFrtqEPQ
X-Proofpoint-GUID: RJd56D_8WL5cb-sR_2q6tCtBeFrtqEPQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_18,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 04:27:12PM +0530, Atul Dhudase wrote:
> While programming dis_cap_alloc and retain_on_pc, set a bit
> corresponding to a specific SCID without disturbing the
> previously configured bits.
> 

As far as I can see, the only invocation of _qcom_llcc_cfg_program()
comes from qcom_llcc_cfg_program(), which is only called once, from
qcom_llcc_probe(), and here also seems to only be the single write to
these two registers.

This implies that "the previously configured bits" would be some unknown
configuration provided to us either from the bootloader or by reset of
the hardware. As such this changes the value of the two registers from
being known, to having 31 unknown bits.


I'm not saying that the change is wrong, but you're altering the
behavior of every platform except SDM845.
As such, I want the commit message to provide an actual problem
description, and mention the fact that you're changing the logic to
retain the state prior to Linux.

Regards,
Bjorn

> Fixes: c14e64b46944 ("soc: qcom: llcc: Support chipsets that can write to llcc")
> Signed-off-by: Atul Dhudase <quic_adhudase@quicinc.com>
> ---
>  drivers/soc/qcom/llcc-qcom.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 674abd0d6700..509d972c1bd9 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -941,15 +941,15 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
>  		u32 disable_cap_alloc, retain_pc;
> 
>  		disable_cap_alloc = config->dis_cap_alloc << config->slice_id;
> -		ret = regmap_write(drv_data->bcast_regmap,
> -				LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_alloc);
> +		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_SCID_DIS_CAP_ALLOC,
> +				BIT(config->slice_id), disable_cap_alloc);
>  		if (ret)
>  			return ret;
> 
>  		if (drv_data->version < LLCC_VERSION_4_1_0_0) {
>  			retain_pc = config->retain_on_pc << config->slice_id;
> -			ret = regmap_write(drv_data->bcast_regmap,
> -					LLCC_TRP_PCB_ACT, retain_pc);
> +			ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_PCB_ACT,
> +					BIT(config->slice_id), retain_pc);
>  			if (ret)
>  				return ret;
>  		}
> --
> 2.25.1
> 
