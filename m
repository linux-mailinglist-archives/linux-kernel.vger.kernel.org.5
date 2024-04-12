Return-Path: <linux-kernel+bounces-143280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F21A8A36B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B051C23223
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E37D15099F;
	Fri, 12 Apr 2024 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@isd.uni-stuttgart.de header.b="bglzD7am"
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903971509AB;
	Fri, 12 Apr 2024 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951999; cv=none; b=LL6lAJbArAbIMhHwNb5gxZ1gnzBKwOAdVZbXmm//X/Yn54cpYeolPOrwESPVb9arrWdlf2+1yHZSFZxkiFQYafRUMFZL9zprKYodKd5pjvQeQcmWNaDs48JHpQSU2R6sHi35Fe2EmWWQmrxRVul+kgn/E0RpY1jxiIeEQTQtUWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951999; c=relaxed/simple;
	bh=ObWGWVtdg8U0NPbe/EAvSL2dL0N1qhqx+T4lt2FGPoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r7vMm2aPaXa9dn/y7ys9KrRYo6FDKKsG9UCAUo4fYpvU4qyRUUxrqV7fi66fyRPS+VgkOW4Tp0B2vJ4gjNAC6POO6sPbIsjQZ/531u1Y1PjF0kmVoTMeNgiG/cVGoNylIkvbiK+bn0jYVTM8bmGqztnuM+5Fu8/it/Dh7QtDdSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isd.uni-stuttgart.de; spf=none smtp.mailfrom=isd.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@isd.uni-stuttgart.de header.b=bglzD7am; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isd.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isd.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id CFCA660B43;
	Fri, 12 Apr 2024 21:52:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=content-transfer-encoding:content-type:content-type
	:in-reply-to:organization:from:from:content-language:references
	:subject:subject:user-agent:mime-version:date:date:message-id;
	 s=dkim; i=@isd.uni-stuttgart.de; t=1712951522; x=1714690323;
	 bh=ObWGWVtdg8U0NPbe/EAvSL2dL0N1qhqx+T4lt2FGPoo=; b=bglzD7amfmfJ
	kMS2GaVF0TWKN1LuhlbIIguj1W3FyyWEpxF1gHVyoj1aT5mMCGafjtUMk3eu/KMW
	VaW8shkw+IkpLmY1Z/hzGPDMX+lL/T1+rWcwp4PDz46j/5hqLiP4McOOOJP2uV03
	N4cbnbv008i0dIfgyN3pDMBLUpAEnBJFAN1YN4jjiFp4FUMzfx4wiXjG0fO2ma91
	ZDQUDIiTq8nJfUNi0sXFamJqPQ8yiJ/Goj955aYNbcbd4ua2RJIRftnR9wsdrS5G
	6XT97+7h1jzVYmAmASVwwy+l05rXBT6U+OtOsxEcxW9pLd5gByYsTNYI0/5VoS5a
	T8Rd5sufrw==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id hMBUxXXMAYCz; Fri, 12 Apr 2024 21:52:02 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Message-ID: <4a1e0cb6-c319-4eb1-9bd1-5ff13eabfe1b@isd.uni-stuttgart.de>
Date: Fri, 12 Apr 2024 21:52:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath11k: support DT ieee80211-freq-limit
 property to limit channels
To: Robert Marko <robimarko@gmail.com>, kvalo@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, jjohnson@kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240412162510.29483-1-robimarko@gmail.com>
 <20240412162510.29483-2-robimarko@gmail.com>
Content-Language: de-DE, en-US
From: Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>
Organization: Universitaet Stuttgart - ISD
In-Reply-To: <20240412162510.29483-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 6:24 PM, Robert Marko wrote:
> The common DT property can be used to limit the available channels
> but ath11k has to manually call wiphy_read_of_freq_limits().
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

I've seen this before.

https://patchwork.kernel.org/project/linux-wireless/patch/ed266944c721de8dbf0fe35f387a3a71b2c84037.1686486468.git.chunkeey@gmail.com/

(dt-binding too. it has/had an ack)
https://patchwork.kernel.org/project/linux-wireless/patch/fc606d2550d047a53b4289235dd3c0fe23d5daac.1686486468.git.chunkeey@gmail.com/

sooo.... this is awkward.

> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index c32be587000d..59bde128d351 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -10124,6 +10124,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
>   	if (ret)
>   		goto err;
>   
> +	wiphy_read_of_freq_limits(ar->hw->wiphy);
>   	ath11k_mac_setup_ht_vht_cap(ar, cap, &ht_cap);
>   	ath11k_mac_setup_he_cap(ar, cap);
>   


