Return-Path: <linux-kernel+bounces-123680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB86890C94
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6711C1C278DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B9E13AD34;
	Thu, 28 Mar 2024 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EAfXeDLD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93B1311AC;
	Thu, 28 Mar 2024 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711661819; cv=none; b=pqv/7s4LkT4CSOPqJ7ocsQp0TKAIcvu1mYbjczveMfzokvTGehiNW2rj9UYz6FWsRYjku5fLZsLpNzvaKXG3Ejz40eZzhWMgRqQIb/ri22x+z5rHf5ag0IE+1hOoNjazdYFPNbqw2haoxkg7JqkZdlrC3i95+MuFTa5YS63retk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711661819; c=relaxed/simple;
	bh=ciS7g8D3sOmPOyXh80G8O8KJ4mZPNq5m0pw5JpgEEQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DSH+aHAjKlR/iXmmgFRfk0BJ8oxNfNvDsL4SzswmGcvK9IPK4r5LM3sb9VVcd9ghdJF1/McMGNc245zAwNkRGHWQEhUCasfDsfAvNckZ4DrQpeaG01O7uDxm0GOnrO7Cxaqn36BLqNIwWLNpy4jLohf4H5a149n9ia/9DSMKshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EAfXeDLD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SKccpk027858;
	Thu, 28 Mar 2024 21:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Wbl8mTdmFirTVbOxG3JDWlBj+qx60dTg3W8aC3GMrxw=; b=EA
	fXeDLDFqnYyPGPvHRkRv1qmR2hvcIo7u8Al/6UOgcVSwe4rmzhmx+A8M2qP0Zkj3
	kEAtMKR7/vvx9sxT13Gs/5UtwpWjgWXVS0C0/vjQbM6kpHp12dQAsxHA4fg+AWuC
	kewuz07C9C5iZ2zuPtJ7jF++WsWlktNaoYXpmTidcpIELwyE7V5jvh0QFUkyZTrr
	e6MFiCBovxxPxIi7au64Mf0tgJvek7EjX+zpX2iWAWlhfXMNP3Xb2rhBbKUcWbeK
	9/qYNXVTBaT1c+Z+Dz9v3IF0h9jIkpAX14+WL+GP9Ey9ixzL+oSkgf3C2Vz7X686
	A58FKv+1NZIkNOqGL96w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5fr7g3ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:36:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SLakvL008709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:36:46 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 14:36:42 -0700
Message-ID: <6641b5c9-1685-3d90-ac15-0b2e9d546bc5@quicinc.com>
Date: Thu, 28 Mar 2024 14:36:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] phy/qcom-qmp-combo: propagate correct return value at
 phy_power_on()
Content-Language: en-US
To: Kuogee Hsieh <quic_khsieh@quicinc.com>, <dri-devel@lists.freedesktop.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <vkoul@kernel.org>, <daniel@ffwll.ch>,
        <airlied@gmail.com>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>,
        <andersson@kernel.org>
CC: <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1711660035-9656-1-git-send-email-quic_khsieh@quicinc.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <1711660035-9656-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H9Ik6Um8WmXRdJ6Uc54PceshbDXUWukj
X-Proofpoint-ORIG-GUID: H9Ik6Um8WmXRdJ6Uc54PceshbDXUWukj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280154



On 3/28/2024 2:07 PM, Kuogee Hsieh wrote:
> Currently qmp_combo_dp_power_on() always return 0 in regardless of
> return value of cfg->configure_dp_phy(). This patch propagate
> return value of cfg->configure_dp_phy() all the way back to caller.
> 

This is good. But I am also thinking if we should add some prints in 
this driver like it doesnt even tell where it failed like here


         ret = qmp_v456_configure_dp_phy(qmp);
         if (ret < 0)
                 return ret;

> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

Also, I think we should have

Fixes: 94a407cc17a4 ("phy: qcom-qmp: create copies of QMP PHY driver")

If there is a better fixes tag for this, please let me know.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 36632fa..884973a 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -2754,6 +2754,7 @@ static int qmp_combo_dp_power_on(struct phy *phy)
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>   	void __iomem *tx = qmp->dp_tx;
>   	void __iomem *tx2 = qmp->dp_tx2;
> +	int ret = 0;
>   
>   	mutex_lock(&qmp->phy_mutex);
>   
> @@ -2766,11 +2767,11 @@ static int qmp_combo_dp_power_on(struct phy *phy)
>   	cfg->configure_dp_tx(qmp);
>   
>   	/* Configure link rate, swing, etc. */
> -	cfg->configure_dp_phy(qmp);
> +	ret = cfg->configure_dp_phy(qmp);
>   
>   	mutex_unlock(&qmp->phy_mutex);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int qmp_combo_dp_power_off(struct phy *phy)

