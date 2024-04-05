Return-Path: <linux-kernel+bounces-133494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDEA89A482
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F92285B35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9479172BBC;
	Fri,  5 Apr 2024 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aCccgfcS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5A6BFAB;
	Fri,  5 Apr 2024 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343728; cv=none; b=hHzu2i529q8RmIxRrAXBuxwatItK/ITReKus2fJigEhkhe9k9tEEzCKuO7a7txPriLbHwi8zatl+7eu4MTA5Tqq7YdG9HDIwQoNbJfEktkJpUsmTo+UUowKZExoo6Rq140V0ZZ9Vxb/CuvCTPqLADQ4nNJKOwcZ1dPncHzdeYkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343728; c=relaxed/simple;
	bh=Jn1Oy+XCAUi5rnI5iukKYayUyHHzGIT3V10iyCKqn9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+SomtUMHHDQzfxABuSmmg5QNa0o29hYaYWoQK37WKXnU7gWEz4XcABPu8Omt7hraDYSRV2+4ruaLPR/JaZJdI4GHoLeCe93ZSQ84bLVoyp5dcPyLKDZR4d67ijZiTVxdgI+RSLzcnYLN+js3J0iy/WCMtK/SYMOXXt+p16ZeEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aCccgfcS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435EIXP6029795;
	Fri, 5 Apr 2024 19:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xbWS5Wiw8b3vJMw3biJy+RRQElmSanUl30WKx0+vdFQ=; b=aC
	ccgfcSzzhIOkLN+/9V5RlHwEemrXRWUj3ur+0buPxDGhH3mwu5ONtqSKQUchneQF
	Q/02985SThNZx0DL0cCV6ssaAXlIgXqBJqWym/SdrK0uooOIOaXZtUfGTRMd6+3x
	hm7BnFrJIZPPz0zFZwC/EFXQ7la/gRy9CCJ2dSQH9d8Knn+QZMrIq8485TAPoOch
	YHLjShNvou1beUQHdAADuKvxYc+EmWwJQ50zz8uObIOl0FYlDSrZGq7iszjk7Odl
	j2TWwrZHBbPrzgeJqrtN1DQQnkCu5pkQq72j6e1k64KEtp4KkCigg9SCpWTL1AQN
	ogQfJXX8rNrHLc5NOiCg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa4ejacx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 19:01:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435J1j1r028532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 19:01:45 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 12:01:44 -0700
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
CC: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh
	<quic_khsieh@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] drm/msm/dp: fix runtime PM leaks on hotplug
Date: Fri, 5 Apr 2024 12:01:15 -0700
Message-ID: <171234049348.25688.14475949253944677974.b4-ty@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313164306.23133-1-johan+linaro@kernel.org>
References: <20240313164306.23133-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cuAQkm2Mu3sy5CySf2oNGMj2Pp_HjboG
X-Proofpoint-GUID: cuAQkm2Mu3sy5CySf2oNGMj2Pp_HjboG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_21,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=994 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050134


On Wed, 13 Mar 2024 17:43:04 +0100, Johan Hovold wrote:
> As I've reported elsewhere, I've been hitting runtime PM usage count
> leaks when investigated a DisplayPort hotplug regression on the Lenovo
> ThinkPad X13s. [1]
> 
> This series addresses two obvious leaks on disconnect and on connect
> failures, respectively.
> 
> [...]

Applied, thanks!

[1/2] drm/msm/dp: fix runtime PM leak on disconnect
      https://gitlab.freedesktop.org/drm/msm/-/commit/0640f47b7426
[2/2] drm/msm/dp: fix runtime PM leak on connect failure
      https://gitlab.freedesktop.org/drm/msm/-/commit/e86750b01a15      

Best regards,
-- 
Abhinav Kumar <quic_abhinavk@quicinc.com>

