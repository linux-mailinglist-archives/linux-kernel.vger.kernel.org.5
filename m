Return-Path: <linux-kernel+bounces-120522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD0688D8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFBC29D9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BC52E62C;
	Wed, 27 Mar 2024 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DdWltAI7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0F24B26;
	Wed, 27 Mar 2024 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527735; cv=none; b=Ggvga6T2zEx919cwX+5IQVbwhqN1CqcLG1iuTJ/gUfRFujurJfj+yeFTCXcN8+e1TzefglrUVM//PoEhnKwFNdZujLfJZxzOR5426zvXLodcpeL1dHiEm5GUTODgjaOHbtOufYhBBdyJhdbU6Di33KrGfadSQS2nizHqQ1i0T0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527735; c=relaxed/simple;
	bh=DVhc/DiH6aBTQ49+AvbMyiv/Jw2lQu94miyyYFAiNkc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1dgjdUvqBdVmPM+zeGwKoByZrRxr71e0eVcBr6tKZ9qj8xZK7tIfrC4s7PAuJa+hwAXcC8zs3pUtLu5z5ur8QvqMjUkDm6GQxAITTYIPPG2xTGK6fLtiNby8OiqnwBTxYvC6kcWh3GyuSc4n4Rt9Wpbj8Yr+p/mbbcboQUFqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DdWltAI7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R7l1oT025841;
	Wed, 27 Mar 2024 08:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=DVhc/DiH6aBTQ49+AvbMy
	iv/Jw2lQu94miyyYFAiNkc=; b=DdWltAI7U0u7wa4A8PA5IMynwD0ERXrPlPhvS
	XexbDaRh54iRQgkXYKOUoP4MezPzOsm4ByhbYbE2nfrBZQ7CObW/+bzEC7ULF9lQ
	gOJ/4OLV0wXvsN5ycYsXL4XxFCg2ga7sW7F1HIDFjp8iXin/1NzUX2h2KKMcqtla
	TAYoLPypt8QCi+HsEgKzKU03lJy6memzFRol8fMb9N+I1CRM2pQLbdiwcUwkbuQ7
	ofCbsoAbjKLWM6SyUiBUstBN7lOuzmbrR6g0bje1sHkeRln6X5W17PxCBzA/VRPU
	YOL8QNyj1/NFPGT7ZqsODqMmkm8dURav/daRGbmViFQU0y4EQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4fbq82u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 08:22:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R8M77Y006560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 08:22:07 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 27 Mar 2024 01:22:02 -0700
Date: Wed, 27 Mar 2024 13:51:58 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] clk: qcom: add IPQ9574 interconnect clocks support
Message-ID: <ZgPXJr2T0GLIo4g+@hu-varada-blr.qualcomm.com>
References: <20240326121312.1702701-1-quic_varada@quicinc.com>
 <20240326121312.1702701-3-quic_varada@quicinc.com>
 <CAA8EJpq5ng2K_Y481FbsjSXCaGM5_2+xkwWqFzfzXv2ZOBpMgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpq5ng2K_Y481FbsjSXCaGM5_2+xkwWqFzfzXv2ZOBpMgw@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KRpQO8Mmk6U_gNDAuR-4qoFy4TeKdVlN
X-Proofpoint-ORIG-GUID: KRpQO8Mmk6U_gNDAuR-4qoFy4TeKdVlN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=700 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270055

Dmitry,

On Tue, Mar 26, 2024 at 02:37:20PM +0200, Dmitry Baryshkov wrote:
> On Tue, 26 Mar 2024 at 14:14, Varadarajan Narayanan
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

Have posted the next version addressing your comments.
Please review.

Thanks
Varada

