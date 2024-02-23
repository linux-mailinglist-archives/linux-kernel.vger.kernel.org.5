Return-Path: <linux-kernel+bounces-78249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750A08610C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BA81C21E29
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62A67AE49;
	Fri, 23 Feb 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B1O1+HYs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF178667;
	Fri, 23 Feb 2024 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688971; cv=none; b=sQaxVit5KaG6wdzW2ZpxqEqWcQTWeIKrXCeqwI6IjS1m4OFR33SPpmOc4Y+OyxE1KMqPi9DrfZfJuIA4VMKKsBpJPkvbZOjv+mRX2TKVDwXl13WYrZCmP6uJ4ODnu78S8rsWEVhfDmgttdvqrTml19tbI+ppDuOh0C1270Rp7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688971; c=relaxed/simple;
	bh=EsRGeozb7apaQ7onSXnq4jDVTUreCA6fdeWQyVeWqPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SW9CW48O1iJCcp+VtO6qYILjMetl6d9LYNA+ZK1qIudZF9jd0u0G+VMbSZqm4XiRIvPHOnCPAHB6aItqWDyhjqBcXQ4rfMLKtuZHxhGJW7jITTXdItQeURexUdj4Fz46btU2kMK8Ehuk/eJhwxJ7WyEWZdlEWtZTcnCt6h9OKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B1O1+HYs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N6xRJR006731;
	Fri, 23 Feb 2024 11:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=Mh7jc07pcOIykuea9G2Hj
	9dHxtwoWsG+W3aQTol0rs0=; b=B1O1+HYsQ0wVXeDVssDAUfo2gpOolZh/QU2h8
	RbdjKVHmC1JtBHgj7QiO4DVGNAgWj9Gk9/46KR2Zm05hp6lVU/jiBsmR6+wDr1Z7
	McUm19Ja2O3iezOsmnG7vDjHhWzwIjE6FEPXPYwiheKrb//525o4H7CmM5nnKd0c
	O3ynMs65Ftso5vatgU04STh1L2lB1bh5+QWlUnJ+Gf1Dqs+fc2SVDXcV9+XzNoTF
	8ha/0286yfOj82DyU4t70UviIkTwHWCHk1o4PmLxJeseQQHyfmzaeO/5gVqOb6mO
	7xJVXevPOaFSCX/nTWbkz16rSsn4D6Rz3ADT253K+Xq9uey5w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weedkspaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:49:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NBnAYu032725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:49:10 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 03:49:07 -0800
Date: Fri, 23 Feb 2024 17:19:03 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Gabor Juhos <j4g8y7@gmail.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@kernel.org>,
        Sricharan Ramabadhran
	<quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] phy: qcom: m31: match requested regulator name with dt
 schema
Message-ID: <ZdiGL/TryPVrbDWp@hu-varada-blr.qualcomm.com>
References: <20240220-phy-qcom-m31-regulator-fix-v1-1-7675b4a916b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240220-phy-qcom-m31-regulator-fix-v1-1-7675b4a916b3@gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BHtyA4R3RzExzDv_YuGE59WkAnu706b0
X-Proofpoint-GUID: BHtyA4R3RzExzDv_YuGE59WkAnu706b0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402230084

On Tue, Feb 20, 2024 at 08:13:47PM +0100, Gabor Juhos wrote:
> According to the 'qcom,ipq5332-usb-hsphy.yaml' schema, the 5V
> supply regulator must be defined via the 'vdd-supply' property.
> The driver however requests for the 'vdda-phy' regulator which
> results in the following message when the driver is probed on
> a IPQ5018 based board with a device tree matching to the schema:
>
>   qcom-m31usb-phy 5b000.phy: supply vdda-phy not found, using dummy regulator
>   qcom-m31usb-phy 5b000.phy: Registered M31 USB phy
>
> This means that the regulator specified in the device tree never
> gets enabled.
>
> Change the driver to use the 'vdd' name for the regulator as per
> defined in the schema in order to ensure that the corresponding
> regulator gets enabled.
>
> Fixes: 08e49af50701 ("phy: qcom: Introduce M31 USB PHY driver")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-m31.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> index c2590579190a..9d84858ba1db 100644
> --- a/drivers/phy/qualcomm/phy-qcom-m31.c
> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> @@ -297,7 +297,7 @@ static int m31usb_phy_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(qphy->phy),
>  				     "failed to create phy\n");
>
> -	qphy->vreg = devm_regulator_get(dev, "vdda-phy");
> +	qphy->vreg = devm_regulator_get(dev, "vdd");
>  	if (IS_ERR(qphy->vreg))
>  		return dev_err_probe(dev, PTR_ERR(qphy->phy),
>  				     "failed to get vreg\n");
>
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240220-phy-qcom-m31-regulator-fix-97555a4650b1

Reviewed-by: Varadarajan Narayanan <quic_varada@quicinc.com>

