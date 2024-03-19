Return-Path: <linux-kernel+bounces-108053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1DA880545
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF0AB224EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291339FD8;
	Tue, 19 Mar 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hA/li5iN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245E39FCE;
	Tue, 19 Mar 2024 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710875545; cv=none; b=sVE8Rp/f/XCX/ifB1RLo5iXPhprZ6DDQR+oTgabNKCu/66sE3OkMU0VuzegXlVLoU0YqEaCJH8atZvt8xKuiRFKp4qnP4GjOpLVxfNmbrCzowZn2k1KCes+HDI30LsAb48GobtfxuUxd6Ncs3rXYdDjXmDytoBr0D/kTjJEfzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710875545; c=relaxed/simple;
	bh=O8NYpGM0/OyuIF8bjp4YEUnlFA9aHIm3cnZ/dXozUvI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgtXL6FZ5X9h1ufyCQeZHLhT1ArtqrkoItiwzdRQhcaPZAOoZ2oy7HfoeaJj7oCGvorr7Mc7GTQ4aBwsFLI4gEduQn99CGjVyMD8VLWe6GFnaTCK3Cwsf5YWgQWLWt28Q9a/ta7IGGc1qYuKMMuBDGZsI83D/j0s99JrXtTsUOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hA/li5iN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JHI4tR025635;
	Tue, 19 Mar 2024 19:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=S3U7YTobRt4muzvepzN9U
	ioae2zubIX7XXpm6xsDWsc=; b=hA/li5iN7HN/Uk97RcX4ciEX6hWv7/F5Tg1Li
	1kzzIwp23pbbwp1HWiJ9DlWmGxbKNGa2ReCvnvG1WxkJ6AQGe06TRGzDn/p7oV6Y
	hsu4/e1NGQlLFYkHq5Od8I1Dq8PfV+MsfLp6sHwSFm55R98R904jVXy7yG0SNZkq
	rzYuIjvPoMTH2fpjWsLTyQiPR6Z60gn0yq8by4uTuQ4d3qK/GwZMnfYM/sNfbowD
	lavVpaYBQUgitQEQO0U8RyJLFj97I/cHdopbMl7/ljxq8SnmK8msEdFHr7/MvYBR
	hE4o+rrJ/gccfDE8P0EIMQfMv/mXgPuiNr+tsV2YIF5yCozQA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wye5n8ey5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 19:12:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JJCIrm026714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 19:12:18 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 12:12:18 -0700
Date: Tue, 19 Mar 2024 12:12:16 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: jianbinz <quic_jianbinz@quicinc.com>
CC: <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] rtc: rtc-pm8xxx: Correct the
 PM8xxx_RTC_ALARM_CLEAR vaule in trigger
Message-ID: <20240319191216.GB3796206@hu-bjorande-lv.qualcomm.com>
References: <20240314033449.10872-1-quic_jianbinz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240314033449.10872-1-quic_jianbinz@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DIOob3ir223Gc6ojX2gkbG4QAL9nt17X
X-Proofpoint-ORIG-GUID: DIOob3ir223Gc6ojX2gkbG4QAL9nt17X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=954 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190146

On Thu, Mar 14, 2024 at 11:34:49AM +0800, jianbinz wrote:
> Change in v3:
> *Correct the vaule that writed into the PM8xxx_RTC_ALARM_CLEAR to 1.
> 
> Change in v2:
> *Switch to using regmap_update_bits() instead of open coding
> read-modify-write accesses.
> Link to v2: https://lore.kernel.org/lkml/20230202155448.6715-4-johan+linaro@kernel.org/
> 
> Signed-off-by: jianbinz <quic_jianbinz@quicinc.com>

Same feedback as on patch 1/2, but on this one you're also completely
missing a commit message clearly describing the problem that your change
is solving.

Regards,
Bjorn

> ---
>  drivers/rtc/rtc-pm8xxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index 1b5a96924e57..8a9be78d0b0b 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -391,7 +391,7 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
>  
>  	/* Clear alarm status */
>  	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl2,
> -				PM8xxx_RTC_ALARM_CLEAR, 0);
> +				PM8xxx_RTC_ALARM_CLEAR, 1);
>  	if (rc)
>  		return IRQ_NONE;
>  
> -- 
> 2.17.1
> 

