Return-Path: <linux-kernel+bounces-31505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E248832F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840C41C24F79
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ABF55E66;
	Fri, 19 Jan 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qv0j/v2P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EC1E520;
	Fri, 19 Jan 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690847; cv=none; b=MdxOzkNbl6kSo18FEB5d3jazxXLZ6mCjxCTtfMCtwkShqGdche4lh/TJhgMnw0pU5dwjuPLsf9KtWuBm/Q4CDUdxzG2ytTvySmD7ZsSe2PHErFhZqIj8wn9QXXq9IwEuHJ0Ces6nts13K4eAqb6LcwmcqSNBORv901wRg6J7i40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690847; c=relaxed/simple;
	bh=ZaEF5YQIRGcqMql2J192zOqBYfhdrbQVff9PSVbXwBs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiQUGD8Qt99h8PvSs96Gyu+aRqQuvXv3stGREg4BbS+arNPoFRFp1zu1KtoHedaqxue+sKLEAaoiWaBMW2YD+v1sHUoIBNJUMCF1IcGUYwwPgCo8ERyuoHALDLG503SBo0VrpOMPgImTyoY5R1OCEJvamphxLCQF8kNak6Ty+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qv0j/v2P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JIVGpD020244;
	Fri, 19 Jan 2024 19:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=on0XcPwc+PbykBkSSYRKs
	qVcF6ETqtHDs5BU2s4PETc=; b=Qv0j/v2Pn4Tq0NVIjAF8VVW6Ul8Pd0AOHMTJq
	HikJby76arOfaAkBNcm7p6nZYUODbkaMBLOw0DD8W3gWUnx1txxZAQkzyxUmj5M+
	YoJYdTZQJUZbLvKZ7KTPHnTnw31GRGXUX+uDlYjDZZW0fzcpMlF+wj0lUiMgDjGM
	S+giJR5+IxXcukChSZq9vYbVLOehv7PvSYIG239sNlH/IuPdpUuDEW8ZxEkhrNm7
	aFdqwczKCeFH2Ht8jJXluH522nYmvI4YCMhYhVA4x+FA4X/WcuVe9PdwmTc2aLv6
	tRvA84iHQE3S3u9xZYzWyzHzVc0fBq1PdM2FyhyViC/oEIDfg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqhpb9p6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 19:00:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JJ0SWh016889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 19:00:28 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 11:00:28 -0800
Date: Fri, 19 Jan 2024 11:00:27 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Introduce additional tsens
 instances
Message-ID: <20240119190027.GQ3013251@hu-bjorande-lv.qualcomm.com>
References: <20240118-sc8280xp-tsens2_3-v1-1-e86bce14f6bf@quicinc.com>
 <ce77861a-b362-4ecc-8e92-7fb846c7e508@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ce77861a-b362-4ecc-8e92-7fb846c7e508@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S8dDUsXmc9FWYSVML_owDDxyruCuwhVj
X-Proofpoint-GUID: S8dDUsXmc9FWYSVML_owDDxyruCuwhVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_11,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190110

On Fri, Jan 19, 2024 at 12:31:06AM +0100, Konrad Dybcio wrote:
> 
> 
> On 1/19/24 00:00, Bjorn Andersson wrote:
> > The SC8280XP contains two additional tsens instances, providing among
> > other things thermal measurements for the GPU.
> > 
> > Add these and a GPU thermal-zone.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 37 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 37 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index febf28356ff8..68b5ac0339a0 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -4033,6 +4033,28 @@ tsens1: thermal-sensor@c265000 {
> >   			#thermal-sensor-cells = <1>;
> >   		};
> > +		tsens2: thermal-sensor@c251000 {
> > +			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
> > +			reg = <0 0x0c251000 0 0x1ff>, /* TM */
> > +			      <0 0x0c224000 0 0x8>; /* SROT */
> 
> I've previously called for removing these comments that we've been
> copypasting around for years and years, and I'm gonna stand by that :P
> 

I'm not against that idea, but are you requesting that I update the
patch, removing the comments as well. Or that I send another patch
removing all of them?

> [...]
> 
> > +		gpu-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> 
> Hm, did tsens only gain support of non-polled reporting with 8450?
> 
> If not, we should definitely update all the relevant SoCs.
> 

Are you referring to the fact that 8450 seems to set most*
polling-delays to 0, which are "valid" delays but would cause
thermal_zone_device_set_polling() to just cancel the timeout every time?

We should be able to do that on all platforms with working interrupts,
no?

[*] Some of the zones has a passive timeout of 10?


That said, as above. Would you like me to fix that now?

Regards,
Bjorn

