Return-Path: <linux-kernel+bounces-116826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D7C88A44C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE692E635A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5074D1A0B16;
	Mon, 25 Mar 2024 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="phdv4FLq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902F13A885;
	Mon, 25 Mar 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362142; cv=none; b=kYnuSVn93o6tr6vFToWZwHuIAeYnjYnadMeBKFUl6jsimATKU0KZeVGOvpCsICESxN8fdlQdW+dS+5jGPtY7KcFwUzft7LRkLE4pQBmcS27I21moAEP2ybUKOhgZBRhTds2PMuYVjIiXC4J2caFuqTzo8EAHlOHTXYJrAF+LASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362142; c=relaxed/simple;
	bh=FiYHzBCEpkdUNfkrGDS+ZiDWs6INjW7NIH8sfTk9h5U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYRVb6rwR/gX8eE0sM9MCrOEoDATSjYo0V/wpSB22WMDQlmJRNwpTuvh9AI696pNJnBHzLOdxeS/kC+a5iWjDhctRyOfBffSRa+pU8holQfOSsqUexovdCOB+zgftAu3cOVdyGM8LZhCW+RdgqJ2pR77b0lJ020X1c7bRzBzqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=phdv4FLq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P8joiF010474;
	Mon, 25 Mar 2024 10:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=c3k7pufci4QzOCp0QPRDA
	w2QzH6RRL6drS1FDsSSQsw=; b=phdv4FLqqDWkO9uvwh3noV/M1BwdUlTK1o7uM
	b89GPkouqKfDQvngWx3idg0dL/3z8TD7ZcHY4Xag/DyLn4cwjw2zp/9ur9KszL2G
	ldiKklNRwyC2FvpZHRrizfZ1y+YX9gerA3f/65tJmLkiEFEDdicZUGcxeVHCeCrE
	0g7Vf/OYdrysvdc65TjI+aU+PQOS0+uEwD+idVnQ2FtyuzuZhtkaKO5XSAucEmwD
	hykI/9DvjmgGF9y+c3gH4hAVkWhsaKb0KSTv8zU/eb+ZFBsuTgqbtJUyFKsYJEwH
	Uy+cS3ReNwLK0+ZO+k8CpMwW2hVNFVkdJNTauNmfew8K6Bt/g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x2yrurwfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 10:22:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PAMGju029032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 10:22:16 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 03:22:12 -0700
Date: Mon, 25 Mar 2024 15:52:08 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <andersson@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] clk: qcom: add IPQ9574 interconnect clocks support
Message-ID: <ZgFQUMcLvYC16aec@hu-varada-blr.qualcomm.com>
References: <20240321043149.2739204-1-quic_varada@quicinc.com>
 <20240321043149.2739204-3-quic_varada@quicinc.com>
 <4b37a6e5-f917-4ead-9678-554a0d8f4660@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b37a6e5-f917-4ead-9678-554a0d8f4660@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eaAkKU8RKyb8W1jl_JQfG_Cvufv7b4DL
X-Proofpoint-GUID: eaAkKU8RKyb8W1jl_JQfG_Cvufv7b4DL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403250057

On Sat, Mar 23, 2024 at 01:29:00AM +0100, Konrad Dybcio wrote:
> On 21.03.2024 05:31, Varadarajan Narayanan wrote:
> > Unlike MSM platforms that manage NoC related clocks and scaling
> > from RPM, IPQ SoCs dont involve RPM in managing NoC related
> > clocks and there is no NoC scaling.
> >
> > However, there is a requirement to enable some NoC interface
> > clocks for accessing the peripheral controllers present on
> > these NoCs.
> >
> > Hence adding a minimalistic interconnect driver that can enable
> > the relevant clocks. This is similar to msm8996-cbf's usage of
> > icc-clk framework.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> [...]
>
> > @@ -9,9 +9,16 @@
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> > +#if IS_ENABLED(CONFIG_INTERCONNECT)
>
> This is bad practice, especially given the reasoning for your changes.
>
> It's best if you add a dependency on interconnect to this driver,
> otherwise things will go into uncountable EPROBE_DEFERs if there are
> nodes consuming icc handles, but the supplier never registers.
>
> [...]
>
> >
> >  static int gcc_ipq9574_probe(struct platform_device *pdev)
>
> ..and that approach could save the probe func from the absolute mess it
> has become with this patch
>
> Konrad

Thanks for the feedback. Have addressed these and other
reviewers comments and posted v2. Please take a look.

-Varada

