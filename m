Return-Path: <linux-kernel+bounces-122573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39E388F9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598941F217AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31E354FA0;
	Thu, 28 Mar 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNou+ijJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D7854907
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613754; cv=none; b=qU/Bw4vb+TQ72mfxjd6Dn9ncH/Txui2DoSHYgju5ez0Bz3cJH3Rb1M7FZ+mvp9mDbT8LY2i05tD+Ub1q3E1L/r8Kslc6GcfQw/bUQlSI5RuYGQM2qZmvUkWEtEQnhUrhjvvQqtaOu9mJNQtN+7cVZppWHwaOt57oZBSSP9AzwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613754; c=relaxed/simple;
	bh=AEHEjkDnCHHUxB0G77hRCttazDS5YP2phnhrwEJqMM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFRk3u/vzvR99UiuK6Lh+nrTe5Idq1gTHN7ebKSc8z4ymEOFn0tG2UQxm2/5QTo8RSmcRAnKi6gViKdr8jEExl5A+fLRDgMKJH8S7SYBZQ5IdXr/u+sNUwaHST9fYYa7b/Yq/eFwnwBuN/c0mZ0QBS40h9miZKBVnw+4qJ4J34o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNou+ijJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711613751;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjUADkxK7W8MqHSaaLff78AqyJRHwq7pquaV+zZOTUA=;
	b=aNou+ijJfztx9D/cTS0PPIPdowA4HKJIH3nXQ3YkDAW3SOgUQyAxfVAaavmEjqr5xPdaOs
	KuLc9dC/9RHW9m4PUD+Ln7+IXlpgnH+jVEBGd1VKa6ZQ30pdGLHbCq9P0TQmqeRczRnbxB
	2QD8SuPvlRPz19k91viqGLkeBRyNba0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-9G8eoH0mPmWUBcSUHzxc2w-1; Thu, 28 Mar 2024 04:15:47 -0400
X-MC-Unique: 9G8eoH0mPmWUBcSUHzxc2w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3419f517aceso282939f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613746; x=1712218546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjUADkxK7W8MqHSaaLff78AqyJRHwq7pquaV+zZOTUA=;
        b=MqhSt9YfRuEs07TyWcPyTEw43e/LTm88DhQg8y3u0cthxk30nAn8wPx7Uaqn4LbZm9
         IQ7WS8PLgB0USE862wx0YAHpCrgLXUhGMmDc4UURyeEtnpjEZFJj2XgG5SNkzmb3X9aB
         RhVGExDPDrU47mpc6by8obVHrG1h9J+UsRYuEgVAvzYn7/9CIXqROWK5HRaymaoK7cmN
         uf1SzpBid+iDe3msZ/YhHQfmiWTSHSQzten0nwo0y4ahCS5xXXpjvuSBdGpqVuI+Gc5U
         URCLAo9J5wiHnLenWw5SgxRiOWCs/BL0OUPXS0GinFfyWytvGYaznr4EhwwJbXW62qpL
         h18g==
X-Gm-Message-State: AOJu0Yzl1l39ikRmPlysG7fqTzO0ys58Hc2GKJzXZdCaHsN5f9Lw833v
	KNXwJs5y20AOSKYlfaZcQzK3DQEtUrYABlkO9bkyWaWIypMCCD2T6EBpKz71UDGkll7Xx3f+tge
	0ONMIAqhlNI7XEcEDeUpHjG7OwZrkDzYH9bBPQwdZ38lGZl/LZDuOlyznB9fzpw==
X-Received: by 2002:a05:600c:468a:b0:414:c42:e114 with SMTP id p10-20020a05600c468a00b004140c42e114mr1687528wmo.39.1711613746211;
        Thu, 28 Mar 2024 01:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8MDeRM7xS3BA3duuFbIO3KAqdPRdzqESI90M9Ta6qWW4GGp1Je55w6TxUEAK7EYkUeNt2Cw==
X-Received: by 2002:a05:600c:468a:b0:414:c42:e114 with SMTP id p10-20020a05600c468a00b004140c42e114mr1687496wmo.39.1711613745872;
        Thu, 28 Mar 2024 01:15:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0041487f70d9fsm4599444wmo.21.2024.03.28.01.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 01:15:44 -0700 (PDT)
Message-ID: <66fd044e-37a8-4f03-a19a-fcd754bdcc40@redhat.com>
Date: Thu, 28 Mar 2024 09:15:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 19/19] vfio: amba: drop owner assignment
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Russell King <linux@armlinux.org.uk>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andi Shyti
 <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michal Simek <michal.simek@amd.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-input@vger.kernel.org, kvm@vger.kernel.org
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
 <20240326-module-owner-amba-v1-19-4517b091385b@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240326-module-owner-amba-v1-19-4517b091385b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/26/24 21:23, Krzysztof Kozlowski wrote:
> Amba bus core already sets owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Depends on first amba patch.
> ---
>  drivers/vfio/platform/vfio_amba.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
> index 485c6f9161a9..ff8ff8480968 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -134,7 +134,6 @@ static struct amba_driver vfio_amba_driver = {
>  	.id_table = vfio_amba_ids,
>  	.drv = {
>  		.name = "vfio-amba",
> -		.owner = THIS_MODULE,
>  	},
>  	.driver_managed_dma = true,
>  };
>
>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


