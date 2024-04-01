Return-Path: <linux-kernel+bounces-127101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7008946AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1929C282F5F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22C555782;
	Mon,  1 Apr 2024 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pf/wscw7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6AD1C2E;
	Mon,  1 Apr 2024 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007947; cv=none; b=lsFs2qvAZNy6iBBK5VBECK5Zqhv7gOJCC7QrnQQfZQmatKqhL5nQ//Je7dFmjubgzS3ZaqQi8Kxig8BP5lxcGm405oSeInGDemeDNVzzIofw9fgAAZ304sllVwZnWsK7uUgmReTEnM4pO+VSWdviKhYlfnXMlCqM1atm0jdEct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007947; c=relaxed/simple;
	bh=fw9nSS+KqpQoVSXzolIRX0HVefPTBF3v8b1a0MzDFc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hoik+GePvSiXpVjtzuB29gdB1oeht+BY0qW0xuP5oLwhzm1BKHtzHQyoKB8VzWs+RHi9j14bUp+nadEgDlrEqLNKN9+uHTVzqOo7cdxFP38ZtR0zqGPchK3XYQPpKaP9L6Mw7D3SYPar0+nErVqz5X8ao4yTsuDz8GGeUucc6do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pf/wscw7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431K8wsN004624;
	Mon, 1 Apr 2024 21:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=g4gn72bbP7RfJOxqSqqUfglFc1LSGdxRE8H+zis9tY4=; b=pf
	/wscw7mAq0p6VKupyaCVJmxthInylo2SUNMrHYD8uODi/Wm3KesLkiGuX5Hm4gRF
	fJaaESlIUFuWOnhIWv5uMwGpUZOeE6T8q2vTyGYcR0HjhBih+l9shHjJRVsdxcDA
	zNtbndPKAgkj5eU1BmwoIv6vs1tX+6SefSlfJ4hDzkvDwaALDP5gKa+RJA0d5ISE
	Q1HSRkIRGZHYj2Sm5f7rIw4QGeF4wrWgyHYRqdyRVFC2spKbbY+oC02FUTuSiYWv
	f0SLgV7r0qpjoLRL5s7tIvWR4ztkLLiidMpphy9m9udtIjV2640ykrqzsW0yUdzu
	3ms84RJOV3sgKc2pHFZQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7u7f9dpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 21:45:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431LjVWF030793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 21:45:31 GMT
Received: from [10.110.91.214] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 14:45:31 -0700
Message-ID: <d2de0a0e-6cbe-3472-0a84-797f827ac635@quicinc.com>
Date: Mon, 1 Apr 2024 14:45:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/3] Add sy7802 flash led driver
Content-Language: en-US
To: <git@apitzsch.eu>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones
	<lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees
 Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B9aze7xX-EqVG7YmnwtSzvROMKSXS7ki
X-Proofpoint-ORIG-GUID: B9aze7xX-EqVG7YmnwtSzvROMKSXS7ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_15,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=993 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010153

On 4/1/2024 2:23 PM, André Apitzsch via B4 Relay wrote:
> This series introduces a driver for the Silergy SY7802 charge pump used
> in the BQ Aquaris M5 and X5 smartphones.
> 
> The implementation is based on information extracted from downstream as
> the datasheet provided by a distributor of the hardware didn't include
> any information about the i2c register description.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>


Is this the right email address? "From" shows devnull+git.apitzsch.eu@kernel.org. 

> ---
> Changes in v2:
> - bindings: remove unneeded allOf
> - bindings: example: move flash-led-controller under i2c node to fix
>   check error
> - Cc to phone-devel
> - Link to v1: https://lore.kernel.org/r/20240327-sy7802-v1-0-db74ab32faaf@apitzsch.eu
> 
> ---
> André Apitzsch (3):
>       dt-bindings: leds: Add Silergy SY7802 flash LED
>       leds: sy7802: Add support for Silergy SY7802 flash LED controller
>       arm64: dts: qcom: msm8939-longcheer-l9100: Add rear flash
> 
>  .../devicetree/bindings/leds/silergy,sy7802.yaml   | 100 ++++
>  .../boot/dts/qcom/msm8939-longcheer-l9100.dts      |  26 +
>  drivers/leds/flash/Kconfig                         |  11 +
>  drivers/leds/flash/Makefile                        |   1 +
>  drivers/leds/flash/leds-sy7802.c                   | 532 +++++++++++++++++++++
>  5 files changed, 670 insertions(+)
> ---
> base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
> change-id: 20240325-sy7802-f40fc6f56525
> 
> Best regards,
-- 
---Trilok Soni


