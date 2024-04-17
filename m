Return-Path: <linux-kernel+bounces-148920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E648A8903
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1936AB23158
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669B16FF5E;
	Wed, 17 Apr 2024 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fIONCEzf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1D147C8D;
	Wed, 17 Apr 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371927; cv=none; b=bOro1/AFo+E77t7ztnCNhRzcfseblZE1/yIMfsR7L8OiTyZmNctU8XMlIAPXiBdqzqZBVlDgnZPrMg21kUzsMp1wmnPaRZyE8fOzHAWQeBJFNxEcPIb0X2HYrMBX8aQPBSLNmhpZCm52tATCiGEjf8NtNCRAcR1quPJUyRdXhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371927; c=relaxed/simple;
	bh=XkyigaLoqGrDju8x7p5ZO9EyT7mR6ub2SfGzdRVkHJ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEF2ySs0BwFSP5M0Z90lC1nfa/qXZb9KJWPMQYlNoFbWT3Mft0HVK2xPiJijAo8APByLmYYRrD6eGVohTs8kLvxPhfBpZ8JeT6afF9nx3DruxHrc3mlZTqom8CP9IXQR9JHsQtnZ/wQtOsgqL3wTra4NI2s/HFyenFT5WpD0f2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fIONCEzf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H5gx3N001355;
	Wed, 17 Apr 2024 16:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=zy0H98RL5GDOAhAFySbyK
	c2AD+YRLlUBoSJb/L1L880=; b=fIONCEzf82RT/DqK1Kag0TFklB0f5vFca8GhL
	uQsJJe6zmoAAYdlx1JVx5leM+zjW4ACngqVlsUq/sxLbuTJmkWKccaP2sWEJw8Jo
	K8SvLo0Ix423gNV/lUYtpWMjrf4UipqpeNqpMq4Og75GqNvFNAr+aFgv2Arab4um
	mYBGaVNb35cRvgdxwEEBtJMRHD2IzasvO+7DcAzXG+12B71rW/Xhm9GGM4K3qbAy
	T0LKPdE5I2IIVp+InH7jqx3D+yDTpcrkC4m4e2rCz6umACNGlzr5tgmSqPqTNtXd
	EPaD1pWbjUL1PdOGIq3aoXAZAgyzOYo/zsea3sW42+2qmfSCg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj8h79md5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:38:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HGcfYL027185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:38:41 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 09:38:36 -0700
Date: Wed, 17 Apr 2024 22:08:32 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v8 3/7] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
Message-ID: <Zh/7CPQ4OO9DeqqY@hu-varada-blr.qualcomm.com>
References: <20240417105605.836705-1-quic_varada@quicinc.com>
 <20240417105605.836705-4-quic_varada@quicinc.com>
 <f00a62c8-6f4d-4be4-800e-58898ea58490@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f00a62c8-6f4d-4be4-800e-58898ea58490@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VSC8DJCaX-ZtFbXsUcDNyg-YV4c8OT6C
X-Proofpoint-ORIG-GUID: VSC8DJCaX-ZtFbXsUcDNyg-YV4c8OT6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170116

On Wed, Apr 17, 2024 at 04:07:59PM +0200, Krzysztof Kozlowski wrote:
> On 17/04/2024 12:56, Varadarajan Narayanan wrote:
> > Add interconnect-cells to clock provider so that it can be
> > used as icc provider.
> >
> > Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
> > interfaces. This will be used by the gcc-ipq9574 driver
> > that will for providing interconnect services using the
> > icc-clk framework.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v8:
> > Remove ICC_xxx macros
> > Fix macro defines to be consistent with other bindings
> > v7:
> > Fix macro names to be consistent with other bindings
> > v6:
> > Removed Reviewed-by: Krzysztof Kozlowski
> > Redefine the bindings such that driver and DT can share them
> >
> > v3:
> > Squash Documentation/ and include/ changes into same patch
> >
> > qcom,ipq9574.h
> > 	Move 'first id' to clock driver
> >
> > ---
> >  .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
> >  .../dt-bindings/interconnect/qcom,ipq9574.h   | 59 +++++++++++++++++++
> >  2 files changed, 62 insertions(+)
> >  create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> > index 944a0ea79cd6..824781cbdf34 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> > @@ -33,6 +33,9 @@ properties:
> >        - description: PCIE30 PHY3 pipe clock source
> >        - description: USB3 PHY pipe clock source
> >
> > +  '#interconnect-cells':
> > +    const: 1
> > +
> >  required:
> >    - compatible
> >    - clocks
> > diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
> > new file mode 100644
> > index 000000000000..42019335c7dd
> > --- /dev/null
> > +++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
> > @@ -0,0 +1,59 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +#ifndef INTERCONNECT_QCOM_IPQ9574_H
> > +#define INTERCONNECT_QCOM_IPQ9574_H
> > +
> > +#define MASTER_ANOC_PCIE0		0
> > +#define SLAVE_ANOC_PCIE0		1
>
> I still do not see any usage of it. At least symbol cannot be resolved.
> I assume you use the value, otherwise it would mean our entire feedback
> was ignored, but then why this cannot be searchable?
>
> Again, open existing drivers and look how it is there. Not being able to
> find the constant is not good.

It is used in the 6th patch in drivers/clk/qcom/gcc-ipq9574.c via the
HWS_DATA macro. Will remove the macro and use it explicitly (as suggested
by Dmitry also).

Thanks
Varada

