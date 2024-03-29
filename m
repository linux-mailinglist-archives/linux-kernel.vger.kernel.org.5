Return-Path: <linux-kernel+bounces-125524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7938927C5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBD71C210B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5529413E3FD;
	Fri, 29 Mar 2024 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mTcIVgYm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBC4B5DA;
	Fri, 29 Mar 2024 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711754574; cv=none; b=T8ZiMItxzllVnhMN7mKBttTO8VbRcQ5pwVgMkXJuNEACK0+e4inNcZ8iN90okGdVpf/4XMLGqFrAlvzID0wRVqp0hiOWB9i6gZyLgefqExMxVOrYhOiW51hqIUCFSHUDVNq7MA8oNkaOynnbYpgCRYf3+yRvcxU4wI24CcCNGdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711754574; c=relaxed/simple;
	bh=0Bgz3dygYfsN6NPG3lTjxdOt5S268zJki5K2RHRufYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VeMYwD+5F7IspitGWxwFCcYDOallyaNt0PUOkIM0AbsFxilqxi/WxMoHMe4PcLRTfSM007ctA6zwN8m1JsxjNwd5SSh2Rp24WTxwRblZx1MLcZHYASy+CnVYxIX6IF4bKR4e5mO9khUMwcVm8dqKFqEhyNbW8adFypnqbwJflIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mTcIVgYm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TLQSj5013426;
	Fri, 29 Mar 2024 23:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7UwDx5OuW8FtPG7iPK+HFKmVAJuPi5oZKhU7vXS9aS4=; b=mT
	cIVgYmE4vn+1WKdCBKVvcGY9JpVQgjzMVAqLZ+1qHySgkRDqdScgPph+XSqVvOgd
	l6yggGX8sisnfUgUXH3Vj3/QyHyb3K8MOhCeRdayW5pgmekSkoXU4zi1mbJ1Jzxt
	P+1U3mgoKCWPZaNbEBuzLTNyMLkiig0x1jc88aMmEpmJryuvkz6L8ain01FN2Uvc
	IgaLKzmraIvOv6LxShxYk3V2qayP/Qv67DdjsjrDazoQjgWkUfadtWc+FVqKYhjo
	kvLGgLc4o9NJoLlPPLAeAl6yLaZfHNUpl6zcfwh/G7H/jMDaYO1lZ/DjIOMntWa8
	Lpg6rNlqt9WCbM4SY2tg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5sm6j50r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 23:22:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TNMYfx000427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 23:22:34 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 16:22:33 -0700
Message-ID: <8ba398c9-b71c-4447-a1d0-bd560e41f39f@quicinc.com>
Date: Fri, 29 Mar 2024 16:22:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] wifi: ath10k: sdio: drop driver owner initialization
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto
 von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Kalle
 Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Arend van Spriel
	<arend.vanspriel@broadcom.com>,
        Brian Norris <briannorris@chromium.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <ath10k@lists.infradead.org>, <brcm80211@lists.linux.dev>,
        <brcm80211-dev-list.pdl@broadcom.com>
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
 <20240329-module-owner-sdio-v1-4-e4010b11ccaa@linaro.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240329-module-owner-sdio-v1-4-e4010b11ccaa@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pj5BXDPNqd-BazKf3WC1xlwtDGjZg8-7
X-Proofpoint-GUID: pj5BXDPNqd-BazKf3WC1xlwtDGjZg8-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=928 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290208

On 3/29/2024 10:24 AM, Krzysztof Kozlowski wrote:
> Core in sdio_register_driver() already sets the .owner, so driver does
> not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> 
> ---
> 
> Depends on the first patch.
> ---
>  drivers/net/wireless/ath/ath10k/sdio.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index 1acb9fba9a8e..cddd9e3010ee 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -2667,7 +2667,6 @@ static struct sdio_driver ath10k_sdio_driver = {
>  	.probe = ath10k_sdio_probe,
>  	.remove = ath10k_sdio_remove,
>  	.drv = {
> -		.owner = THIS_MODULE,
>  		.pm = ATH10K_SDIO_PM_OPS,
>  	},
>  };
> 


