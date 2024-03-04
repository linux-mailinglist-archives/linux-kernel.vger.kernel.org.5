Return-Path: <linux-kernel+bounces-91035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6DA8708B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D86228408C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1072C6166D;
	Mon,  4 Mar 2024 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Bek58VT8"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F306169F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574777; cv=none; b=lCWO/FJHvpAWF4TBb09LkeRpXsXFrWSeooXHuDxV87RZurapiXRoI12pE7mYDiYtdVKFPlfQuiBmFCw89arhtc5P5dUAQeDCIycVhJpXcxqSf0zuj1MciTCHijVJr1CyI+/Rdox9jc5XuupQmnqAXfFZCbcz9fTwxYzRdI7ycx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574777; c=relaxed/simple;
	bh=xhasQr4zUh+OrVX82rx043F2uZu3+QI7EosIcFcG7EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoVpY2mQ3Jx4tKlqWGxz1YDQka/XrqnzyK1NCoYaOj9elNdM1Y3dkOqfpo8RjUO1cNwNfsQtY7XZiKNj6OjsNpHJYSe/XOeID7Z9ghitDrhBWyRBhnd2pgcGougQvXe7ORBMnAES0pY1zw0V7mKDTAUB4tGA5X4WpE7dLNAEOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=Bek58VT8; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a12661c8a2so354734eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1709574774; x=1710179574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+OnqRcS2a1ooBnCy5mQV9aG9KxXx9irk+upPadR0EN0=;
        b=Bek58VT84uVH4WMuWF2F7GbOXJpsoMCP9PuBbadhsQ63d9y3NjwhMhXR7NIF6yI0Mb
         w+Np/W3bWqkEFtnYoIIiCUhNYzzmoMWcPfTgoGrVRsExh8Xh7EknziZf6HcFedLhjeHl
         fQeS34Dq8UBvbgvCKaS13lDJzV48HP1eYMz58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574774; x=1710179574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OnqRcS2a1ooBnCy5mQV9aG9KxXx9irk+upPadR0EN0=;
        b=IWMEsAnl6sRHhoOKV9C1bNBHBr1ywMbtOe8MhMQmas6MhTeLY9goirVOFSQEhuyUY9
         eVpAPgTRGUOjFD0zK0newgBYA5i+kDsdj2QqSd/UMUku37nH7rpMQ/bw199avg07LE4K
         zlGhRVdgbF2yZQzIbrcRrKv8DE9rQZnlI6oW91Yux/9MZzOFGOsQXHJXyPdKMgf7KGyo
         pIklV7xU1x33SSP6FKtrUr0U3x2KV2SIIgJi6P25++NX66i9J7MuEhv1ijMT2aplKNfF
         acIXBHu17wNcX3w5aDOtkmEi+P1smvHluE/kuqafcTQt4nRsihA+hWdgIg2nCVOn/sfH
         HIsg==
X-Forwarded-Encrypted: i=1; AJvYcCUrUjEGSyMKc99lnfG2OWBmgo94EdRW8Iit9TLgwhgTpP5+GuqajGmgGcoFqrxwIYyIOwbP6W+X8pJWoUKMLet6beuVQ3Z7yWn2idqc
X-Gm-Message-State: AOJu0Yxfq0dewmoTdVR7z64nvmKosy6k50dBjXgSnMb+Ema4N+R7Mizj
	b2rdrMhLNkmiAZUyS1td6jop8Y8Wmr97hBn+bJZ9X23nbSfeGOJAY0dTUG6iy8udNK+CU0gMN5c
	=
X-Google-Smtp-Source: AGHT+IFKmL3fB16A8TnnCK5B0H81r4wmRERTTWJIwx12JOjfjCiJ27Yt0CtC04p7ZNiTRMVCkdW1zg==
X-Received: by 2002:a05:6358:6383:b0:17b:ee29:40a with SMTP id k3-20020a056358638300b0017bee29040amr6653835rwh.6.1709574773600;
        Mon, 04 Mar 2024 09:52:53 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id lv8-20020a056214578800b0068f881d0d00sm5129116qvb.53.2024.03.04.09.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:52:53 -0800 (PST)
Message-ID: <984ff1d6-b661-4fab-9943-44008d5ccf3c@ieee.org>
Date: Mon, 4 Mar 2024 11:52:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: move is_gb_* functions out of greybus.h
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20240226-device_cleanup-greybus2-v1-1-5f7d1161e684@marliere.net>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240226-device_cleanup-greybus2-v1-1-5f7d1161e684@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/24 3:05 PM, Ricardo B. Marliere wrote:
> The functions below are only used within the context of
> drivers/greybus/core.c, so move them all into core and drop their 'inline'
> specifiers:
> 
> is_gb_host_device(), is_gb_module(), is_gb_interface(), is_gb_control(),
> is_gb_bundle() and is_gb_svc().
> 
> Suggested-by: Alex Elder <elder@ieee.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/greybus/core.c  | 30 ++++++++++++++++++++++++++++++
>   include/linux/greybus.h | 30 ------------------------------
>   2 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
> index 5714be740470..f660b213233d 100644
> --- a/drivers/greybus/core.c
> +++ b/drivers/greybus/core.c
> @@ -27,6 +27,36 @@ int greybus_disabled(void)
>   }
>   EXPORT_SYMBOL_GPL(greybus_disabled);
>   
> +static int is_gb_host_device(const struct device *dev)
> +{
> +	return dev->type == &greybus_hd_type;
> +}
> +
> +static int is_gb_module(const struct device *dev)
> +{
> +	return dev->type == &greybus_module_type;
> +}
> +
> +static int is_gb_interface(const struct device *dev)
> +{
> +	return dev->type == &greybus_interface_type;
> +}
> +
> +static int is_gb_control(const struct device *dev)
> +{
> +	return dev->type == &greybus_control_type;
> +}
> +
> +static int is_gb_bundle(const struct device *dev)
> +{
> +	return dev->type == &greybus_bundle_type;
> +}
> +
> +static int is_gb_svc(const struct device *dev)
> +{
> +	return dev->type == &greybus_svc_type;
> +}
> +
>   static bool greybus_match_one_id(struct gb_bundle *bundle,
>   				 const struct greybus_bundle_id *id)
>   {
> diff --git a/include/linux/greybus.h b/include/linux/greybus.h
> index 18c0fb958b74..38c45ec7d099 100644
> --- a/include/linux/greybus.h
> +++ b/include/linux/greybus.h
> @@ -113,36 +113,6 @@ extern struct device_type greybus_control_type;
>   extern struct device_type greybus_bundle_type;
>   extern struct device_type greybus_svc_type;
>   
> -static inline int is_gb_host_device(const struct device *dev)
> -{
> -	return dev->type == &greybus_hd_type;
> -}
> -
> -static inline int is_gb_module(const struct device *dev)
> -{
> -	return dev->type == &greybus_module_type;
> -}
> -
> -static inline int is_gb_interface(const struct device *dev)
> -{
> -	return dev->type == &greybus_interface_type;
> -}
> -
> -static inline int is_gb_control(const struct device *dev)
> -{
> -	return dev->type == &greybus_control_type;
> -}
> -
> -static inline int is_gb_bundle(const struct device *dev)
> -{
> -	return dev->type == &greybus_bundle_type;
> -}
> -
> -static inline int is_gb_svc(const struct device *dev)
> -{
> -	return dev->type == &greybus_svc_type;
> -}
> -
>   static inline bool cport_id_valid(struct gb_host_device *hd, u16 cport_id)
>   {
>   	return cport_id != CPORT_ID_BAD && cport_id < hd->num_cports;
> 
> ---
> base-commit: 70ff1fe626a166dcaadb5a81bfe75e22c91f5dbf
> change-id: 20240226-device_cleanup-greybus2-b763f50221ab
> 
> Best regards,


