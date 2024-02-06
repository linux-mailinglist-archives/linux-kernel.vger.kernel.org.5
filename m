Return-Path: <linux-kernel+bounces-55699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5F884C02F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794C12865CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AF21C283;
	Tue,  6 Feb 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NohBTfRn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EFA1C291;
	Tue,  6 Feb 2024 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707259280; cv=none; b=OiDfrgbRBnyJEn2nsbe22SrR5KRe3GBJnI1zNcH9KUe68BIcuSbNdspf3+u0PQETWNhjgdEOr5tUygupMQye+dcPmYSNBwGYLWRBcq1v2xni5DZp/BVaklyQ0SxjtWoLa4aFLZKEWdeIDa21BgAJoAo2iIz6yqwfyuz6xKm7PcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707259280; c=relaxed/simple;
	bh=GvQWGxfzzJo/PNDI8kmCuJ1FJnA7C1Qpj2C4krhkaK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IC7uLJWG3UT39tEQ7CSwwoa72J9mfdbaR2EWSK3mnJ+GsefELAnStatz31pPpE+YTUvUhrgp79npU++Jq191a10GGXvIlUH1Ddej0nhN9EYt+kHoDdXVKTyNKEIFHa1VtIV9kU9RUXZ6GDRrvBsHHbyo7KZi4IvGN7EKeI/UVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NohBTfRn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416KWrq3009087;
	Tue, 6 Feb 2024 22:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XxdHIA+QMOuSWmvYypzcXruKSBNNGtCu59rJ1V7ez8A=; b=No
	hBTfRnxrX69Eu+8SXUmV/QXc/mYYHIiFVdMt3O/9J0JdnHagFaKR6Kl8dCIQk66v
	aCI0GXuz3RpZtdcsBSTPmqVe41WxYsOEzX6suCl0hwc+sjGWfll55bT6mT7Qr/h4
	eHLPAvW1kBKLolcJ+YxcZ7rTpT3S4dObKxaKzww1rVO107Dtbo+hsrPtiB5AaPLe
	HyPqvgYu9I2QuUCo2juBMgXfxKX7XIeAN1VevdnnIKvUiN9kK/jrPZRQuv7Z83a8
	AQxsXGnZW2tIM2qkq9COpZqswqAt8cnrjUZQHPRNn4VNLbzoKQLmQSlQqN2gyIi/
	djehOOBI97R/j4f8EAvA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3k6g9evp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 22:41:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416Mf80B020563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 22:41:08 GMT
Received: from [10.110.46.191] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 14:41:07 -0800
Message-ID: <bce60ac4-9c57-94ff-f93a-c3facf0ad267@quicinc.com>
Date: Tue, 6 Feb 2024 14:41:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 06/10] clk: qcom: clk-alpha-pll: Add support for zonda
 ole pll configure
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rajendra Nayak
	<quic_rjendra@quicinc.com>
References: <20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org>
 <20240129-x1e80100-clock-controllers-v3-6-d96dacfed104@linaro.org>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20240129-x1e80100-clock-controllers-v3-6-d96dacfed104@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Co5JC-mJFxt24F0GfrrBMK_a0lQ-E7QV
X-Proofpoint-GUID: Co5JC-mJFxt24F0GfrrBMK_a0lQ-E7QV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=792
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402060160

On 1/28/2024 2:52 PM, Abel Vesa wrote:
> +	.set_rate = clk_zonda_pll_set_rate,
> +};
> +EXPORT_SYMBOL(clk_alpha_pll_zonda_ole_ops);

GPL variant please. 

-- 
---Trilok Soni


