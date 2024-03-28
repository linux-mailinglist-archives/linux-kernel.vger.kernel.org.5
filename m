Return-Path: <linux-kernel+bounces-122739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4994588FC4E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041C228D81D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069E7AE7F;
	Thu, 28 Mar 2024 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l/zXdZcw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5991E861;
	Thu, 28 Mar 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620037; cv=none; b=bLhM2ZrPKbBhQMkNvEgtiXg+h6xEDRSduiczK+KoR/fbTTFG+k+hOWNpuJbgTA+ouGaCnFHe9+pfiIylWjfHn/KJEBjmqLOSRhSgT44ddUHctq04m8I2ve/XTCy8KnfSl1ggVqXrrPaQ5tlh0wK8Jt/YfY6eG8dkw2mhnilBasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620037; c=relaxed/simple;
	bh=Emrrp4t1Me2Gws3cn87MMVbQOlKKudRm3ej2wUakzUY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtB/aPnp/lZtAFPIKnRXb75GYkTN6J/UW8jU+uFrZMUvi31CdHDk72TRCynMmGo6hfStIRk2sx1NznwZJmXZFyUK/ypiJAsNzJMQKNt7l3wU6sRbfLwwSJmkEXlKTVUIOhw8DC3LzybQq5eyZWIZevTjWNKnHtu7pG2m9+TmMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l/zXdZcw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S9xeaI014834;
	Thu, 28 Mar 2024 10:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=PmY3Bf684EtzVI98XVg2D
	Tqw4xfM4PdBGIOA1wwdRmo=; b=l/zXdZcw+h2F5vQ5dDfRqcf6ScXoZM8fhVlhe
	SLpjxQvQt+S8UKJ4qcYpuuqP2AnEcYZHheTkl4MwDxJcY45F2S5kr+xpt5O5fP4E
	cMWu/YTpBs+N0BXiFiCxtCIsezidVKA6Vg9P7GrwldWp5w2KxQK8f+e5cmzpcWdG
	F3WmKQpxBKBo1w/GB5IRG0mgvCRDwms6IaRL8Dhjs49KwmeTrEM9omz+WXjv7oGy
	2Puz2A3XAe2bJC6c6bi+WZkooTSBMNbuyaj/1kX81RNUhjei3Yesf7I7/KQYm3TP
	/PiFLOFodjy668W5yWLUz/jjnLTgrkutDGYr+S12tEBQXyTVg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x53nxgpxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:00:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SA0Uej019574
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:00:30 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 03:00:25 -0700
Date: Thu, 28 Mar 2024 15:30:21 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] clk: qcom: add IPQ9574 interconnect clocks support
Message-ID: <ZgU/tcAE7x4MBdx7@hu-varada-blr.qualcomm.com>
References: <20240327081850.2924870-1-quic_varada@quicinc.com>
 <20240327081850.2924870-3-quic_varada@quicinc.com>
 <CAA8EJpoFw3Qyq+NRffe5HBUbCfdYv03oWgoUwkB6pbdVrF6LEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpoFw3Qyq+NRffe5HBUbCfdYv03oWgoUwkB6pbdVrF6LEg@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mPntLGzbq1JEOFupbpa7dIGTRZFOS6Zp
X-Proofpoint-ORIG-GUID: mPntLGzbq1JEOFupbpa7dIGTRZFOS6Zp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=925 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280067

On Wed, Mar 27, 2024 at 10:49:56AM +0200, Dmitry Baryshkov wrote:
> On Wed, 27 Mar 2024 at 10:21, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Unlike MSM platforms that manage NoC related clocks and scaling
> > from RPM, IPQ SoCs dont involve RPM in managing NoC related
> > clocks and there is no NoC scaling.
> >
> > However, there is a requirement to enable some NoC interface
> > clocks for accessing the peripheral controllers present on
> > these NoCs. Though exposing these as normal clocks would work,
> > having a minimalistic interconnect driver to handle these clocks
> > would make it consistent with other Qualcomm platforms resulting
> > in common code paths. This is similar to msm8996-cbf's usage of
> > icc-clk framework.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v4: Use clk_hw instead of indices
> >     Do icc register in qcom_cc_probe() call stream
> >     Add icc clock info to qcom_cc_desc structure
> > v3: Use indexed identifiers here to avoid confusion
> >     Fix error messages and move to common.c
> > v2: Move DTS to separate patch
> >     Update commit log
> >     Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK to fix build error
> > ---
> >  drivers/clk/qcom/Kconfig       |  2 ++
> >  drivers/clk/qcom/common.c      | 34 ++++++++++++++++++++-
> >  drivers/clk/qcom/common.h      |  4 ++-
> >  drivers/clk/qcom/gcc-ipq9574.c | 54 ++++++++++++++++++++++++++++++++++

Have addressed the comments and posted v5.
Kindly review.

Thanks
Varada

