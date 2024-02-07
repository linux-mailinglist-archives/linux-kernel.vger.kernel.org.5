Return-Path: <linux-kernel+bounces-56981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5355D84D232
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED99E288A30
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C60C8593E;
	Wed,  7 Feb 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CVogVLNu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301558562D;
	Wed,  7 Feb 2024 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333591; cv=none; b=RR6NFe/zN2KWrXr8UPk/KCM1N0l5jTrT3JQqj+xhASX2kM4DdHwVIA/mqKzfFxXoRhRp0ZU9uJT/8uZ7RhmPTA77F5+0W0CO444M7Tp6pPRMNHLJb0HBA2G2cvLlBScwOekFs/spErytjjjQHAnetp457urBFMRz6YH2TnxFkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333591; c=relaxed/simple;
	bh=sHXNvgc9UarrYc9iJXIFjX3yH/gJM0hkb+lJh6JySjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c4mPAaYRLkfFN/qt6mwhwUPEJufN6KxmmX0W7jiBAL466oaTi6XpUP8S8IIDHRuTWU03rWbKpU1tfryxv7hw5RuAXW+np8nEdo7JeYrJm2sI8fGoU/nBzx2ECZevZtcJiAMis7/KhY68WzFmTxjyZPGHp+/l91BE1QWq21TQwFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CVogVLNu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417HseVs008737;
	Wed, 7 Feb 2024 19:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wQa3IkeDWDZNIJEgmH/jdPP7gbb8Id6gt71z1DJ8Cs8=; b=CV
	ogVLNuBkwnjcxHig6YNfD/Flw7EO6aH+LnjcGZ9dvQvwgG36dGz8tgRKiwYQbY8z
	OjIyEq++yHVLHMecmMKLm/iQsGBKvzE4uXuwiP/tmXjEHLZ9D31xN+14Iyg+gbFZ
	LXZkJw2eRT/BasDzdE9H0Mx8zjTJ6BHlYVoZ7FGlZZPRr4od6ZdhHQ2QsGCdhZll
	Rj4ZDYWZRpa79uBhNK5YXMgvHrbXPLZLUoGOtEdWiiZYJTT2R782SHJYfAk4x1p0
	+cX7HZQmM7qo5milk2zs2kDTy9yRn2OxsddvKWhD9Ej9AOkqGtTzgPfN584nDG0o
	grnBo/kE33qRBDhBrKxw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3ywbt6aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 19:19:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 417JJamA012671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 19:19:36 GMT
Received: from [10.110.9.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 11:19:36 -0800
Message-ID: <cb515863-f9ad-068e-88a2-7fec9b3d51dc@quicinc.com>
Date: Wed, 7 Feb 2024 11:19:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/4] drm/msm: add a kernel param to select between MDP5
 and DPU drivers
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Stephen
 Boyd <swboyd@chromium.org>
References: <20240106-fd-migrate-mdp5-v3-0-3d2750378063@linaro.org>
 <20240106-fd-migrate-mdp5-v3-3-3d2750378063@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240106-fd-migrate-mdp5-v3-3-3d2750378063@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uXQeDuwH3EepLNEDio5yi5-gG9slAwva
X-Proofpoint-GUID: uXQeDuwH3EepLNEDio5yi5-gG9slAwva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=794 impostorscore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070143



On 1/5/2024 3:34 PM, Dmitry Baryshkov wrote:
> For some of the platforms (e.g. SDM660, SDM630, MSM8996, etc.) it is
> possible to support this platform via the DPU driver (e.g. to provide
> support for DP, multirect, etc). Add a modparam to be able to switch
> between these two drivers.
> 
> All platforms supported by both drivers are by default handled by the
> MDP5 driver. To let them be handled by the DPU driver pass the
> `msm.prefer_mdp5=false` kernel param.
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

