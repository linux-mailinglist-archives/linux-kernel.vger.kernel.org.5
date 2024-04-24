Return-Path: <linux-kernel+bounces-157358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2F88B1056
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2E92817BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF216D301;
	Wed, 24 Apr 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mMZVtqoB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DAA16C450;
	Wed, 24 Apr 2024 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977739; cv=none; b=TlT/f3bI+RLgST/CBW25SUnWzZAO+5n2zhV4yVbe+urcZiJpsOx1VFxzVYUAURg+EKRdCuPjqtogAnajt6yjSlceQbDHXpZW3KaCmsGzQFkgbwB7fGDc9E9TMiHKzm68J0LgowBqB6cMVKYkN1pahUZhEfgB07xsEgz+3oL/3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977739; c=relaxed/simple;
	bh=ismdr1NH89EyqlRlfJMRiCPmKdo+TMgxDhu4SNwwFKM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izHC4Cq7Tka0vxVSy0aVB3jM3+lVC5+/wDPw+O36JRzScB45yX3SPI3PhPtp32RVYTHJF05IMnu6UI6xJBdFTu0V6CLjEOUW8KSoI/xU9sn1ZqlrtZlc9cPPnVyY+76WmKYt8CqM7bpPCpmXAM7J8zkyscR7SEe8W+OlpjZisuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mMZVtqoB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OGrFNG018626;
	Wed, 24 Apr 2024 16:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=S3QwG/gp7sGhYK+iMw8kH
	vsDhub3gIJuqyRymC6Hyns=; b=mMZVtqoBq1oaB0lOfFqvvBc0fcWm9kvADGZWT
	tGp19sacBYS0+2Vwq40/MdKK/pWfK93DUxOcEksATBJ/oEoJEDFk9e32d/ysQNMD
	3eDHG51iVFZH7/ULg2RDWglFU5xGToV7rvN9WSn+4bnvYSvSbwpq6bpwrphe1ebE
	kXaZMdIwL0/OZXI1fAu+7AukFa+xHvqwvQkSOd89W1pz3Dyi2ahDnKK4QB9d9qSm
	QecIkmOYNyxx1AWcf7xm/jsoy8lTW+hjiNCUd722QKX2ak55hUdQFvGg1xbN6vMz
	bjXq0VXGyW5zeH8iM6IG0aIdd6nKhhwDx4/F/7IF4lzyN/VGg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9g9hqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 16:55:32 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OGtVgX031427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 16:55:31 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 09:55:31 -0700
Date: Wed, 24 Apr 2024 09:55:30 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Luca Weiss <luca@z3ntu.xyz>
CC: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/7] Use mboxes instead of syscon for APCS (arm32 & arm64)
Message-ID: <Zik5gmTixGpk13qj@hu-bjorande-lv.qualcomm.com>
References: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hQv8mAhEPOsbXGPMhm9SQ19NB9rfqNBn
X-Proofpoint-GUID: hQv8mAhEPOsbXGPMhm9SQ19NB9rfqNBn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_14,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=922 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240072

On Wed, Apr 24, 2024 at 06:23:53PM +0200, Luca Weiss wrote:
> The first patch is for removing a bogus error warning I've noticed while
> developing this on msm8226 - there the patches are also coming later for
> this SoC since apcs is getting hooked up to cpufreq there also.
> 
> Apart from usages from the qcom,smsm driver (patches coming!) all other
> usages of the apcs mailbox now go via the mailbox driver - where one is
> used, so some arm32 boards will continue using "qcom,ipc*" properties in
> the short or long term.
> 

Very nice, thank you for cleaning this up.

Regards,
Bjorn

> Only compile-tested apart from msm8953 (tested on sdm632-fairphone-fp3)
> and msm8974 (tested on msm8974pro-fairphone-fp2), but I don't expect any
> complications with this.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Luca Weiss (7):
>       rpmsg: qcom_smd: Don't print error during probe deferral
>       ARM: dts: qcom: msm8974: Use mboxes properties for APCS
>       arm64: dts: qcom: msm8916: Use mboxes properties for APCS
>       arm64: dts: qcom: msm8939: Use mboxes properties for APCS
>       arm64: dts: qcom: msm8953: Use mboxes properties for APCS
>       arm64: dts: qcom: msm8976: Use mboxes properties for APCS
>       arm64: dts: qcom: msm8994: Use mboxes properties for APCS
> 
>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 14 +++++++-------
>  arch/arm64/boot/dts/qcom/msm8916.dtsi    | 10 +++++-----
>  arch/arm64/boot/dts/qcom/msm8939.dtsi    |  4 ++--
>  arch/arm64/boot/dts/qcom/msm8953.dtsi    | 10 +++++-----
>  arch/arm64/boot/dts/qcom/msm8976.dtsi    |  8 ++++----
>  arch/arm64/boot/dts/qcom/msm8994.dtsi    |  6 +++---
>  drivers/rpmsg/qcom_smd.c                 |  3 ++-
>  7 files changed, 28 insertions(+), 27 deletions(-)
> ---
> base-commit: 43173e6dbaa227f3107310d4df4a3bacd5e0df33
> change-id: 20240423-apcs-mboxes-12ee6c01a5b3
> 
> Best regards,
> -- 
> Luca Weiss <luca@z3ntu.xyz>
> 

