Return-Path: <linux-kernel+bounces-158390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B88B1F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7C2B2474B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA386641;
	Thu, 25 Apr 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hjiPiwsN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350E7FBA3;
	Thu, 25 Apr 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040897; cv=none; b=PQ79iMcjuWTMtNT8zmCgE/Ca42uLxlih4BJx1hdLpeMsusTYGQhIvbN0ypiFOdFJXkK2r4lDfShTqJwxcwOvI1VQOplFJE8W3j2om5ADfJpm5eVjf308fWuKgPblHhznd7xSHaWiXuJKtBu/ESUtQXyNiPrmuBCkistEaviaovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040897; c=relaxed/simple;
	bh=wLXSKG+9X8bcpno5txQEm1gBb/7d39Vog9Qq+VlVE6Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO9YHXFoTf3SduVJtJY8IjQP4N5GWqjBqFcNT8+n9QW0ZBfJ3Im069fkI89O1n9U1RlmIEM5Ca6hijJGjp9bH97zfN0fDv2md7W8ZWxyrS6/ILTR8/jvjUbAIkbjCBMAYws6AtPXypxElF2HRl2tfZJ5wmpY/t1F1UYRxDr8gJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hjiPiwsN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P8T5Yk013993;
	Thu, 25 Apr 2024 10:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=ZzsPK0gVYKVJFOLxk7adQ
	3hNeawRyhuL+q/G5p4TGHA=; b=hjiPiwsNDiCuQPsi+EKsWc7fSXfO19O90zxRV
	/CH++AIz1pVEQ7zJG3noH9YMEy88mSk7Y2v3A7BSDeuTRsBPOApTC5BpHvvJTUWP
	PvNdLcZdWCKLfZ41zzf20r5Gl5CixKZFTX/jnmz76PFrO8maLdzz9YHK7/NWFGAM
	ZZhwOEvyhNTByNxgddf+2q05Zxre1d0l7ms/pUwSDBQJzYIcclJc/YPIAxdFeycb
	iR5s+H97uhG8RhKVaPzhywutk7IvaSDmh2/emc+/yDNdo6bD4hHoI+q+ZIEkM369
	foBmv79Vp+92guHH3sSbvf/Mdij633W5VzkqB09w1hwrjaOUQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenh21mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:28:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PASB2C007674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:28:11 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 03:28:06 -0700
Date: Thu, 25 Apr 2024 15:58:02 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v9 1/6] interconnect: icc-clk: Allow user to specify
 master/slave ids
Message-ID: <ZiowMuNlBsxYQesc@hu-varada-blr.qualcomm.com>
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-2-quic_varada@quicinc.com>
 <da8fc783-6b2b-495d-ab15-be297b0fa435@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <da8fc783-6b2b-495d-ab15-be297b0fa435@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V-k3WPLHeU2LaZW1bl5h6lmjH8g8ED3o
X-Proofpoint-GUID: V-k3WPLHeU2LaZW1bl5h6lmjH8g8ED3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_10,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=666 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250075

On Tue, Apr 23, 2024 at 01:00:48AM +0200, Konrad Dybcio wrote:
>
>
> On 4/18/24 11:23, Varadarajan Narayanan wrote:
> > Presently, icc-clk driver autogenerates the master and slave ids.
> > However, devices with multiple nodes on the interconnect could
> > have other constraints and may not match with the auto generated
> > node ids. Hence, allow the driver to provide the preferred master
> > and slave ids.
> >
> > Also, update clk-cbf-8996 accordingly.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v9: squash cbf-msm8996 change into this
> > v8: Per review feedback, set master/slave ids explicitly. Dont autogenerate
> >      https://lore.kernel.org/linux-arm-msm/f1b0d280-6986-4055-a611-2caceb15867d@linaro.org/
> > ---
> >   drivers/clk/qcom/clk-cbf-8996.c  | 7 ++++++-
> >   drivers/interconnect/icc-clk.c   | 6 +++---
> >   include/linux/interconnect-clk.h | 2 ++
>
> How is this going to be merged? :/
>
> icc-next? clk-next?

Bjorn,

Can you help answer this.

Thanks
Varada

