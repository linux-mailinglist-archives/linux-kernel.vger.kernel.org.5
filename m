Return-Path: <linux-kernel+bounces-81211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B9867216
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA8328FF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417AF2C85A;
	Mon, 26 Feb 2024 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAnRi3fW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536C249F5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944549; cv=none; b=HwUtvHiC8nH9EOcomX0XOsk000NHEsf39PlufqQ12utLiMZLPu9Vs7sWzt7b7RIeb022jA7UOSBP1QHvHW6Dcnt49RnOSa3/SRVShynY1cXX6bkLJACrEHMc0GnqxQk+WkfYWSI99hNGxkGAvcKkFqvlBfKeHuLSFf0v8cVlpXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944549; c=relaxed/simple;
	bh=oN6z/Ma+rlJcjTxPxoSfXJuY6hkPlkN3GBr7lfToEJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBnHsIYaeXAFr2gkPYfJsYRFTokFiVWQvmHS1Sl0lnIMt2ylCLFc976ddjcnjP1wCwc1kzHgfRh/kPvfX5hPxD0jGWOmvuSC8wHLAsRtE+DPNyloO85Huju/4Z34kaHv33A0lbywqVKWnoxFT4s6aDJNeh7b0Jjxf8hBIDsgiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAnRi3fW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708944546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrWLYtqd2oPYXe7xrqMQ9XAg0ahyT9g/GSMPGa3xAnU=;
	b=BAnRi3fWo3uPOl95FFIU6cLqwmsxAai3i1qN5I9/dXVlDQm26fcHa+uED+bv+GsnkUm+cN
	FyLlP9zs8JXLL4pGSKiBTlnAPlNQa0AiFcQGv7gsx9v/yMxsu7qXjvEkIOHoiMmZuOIVXP
	sfAwSaHAumx59xiyZMsD+m/PM0qUn7w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-x7z6bIFyMOaX1vv7x24PUQ-1; Mon, 26 Feb 2024 05:49:05 -0500
X-MC-Unique: x7z6bIFyMOaX1vv7x24PUQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3f52ebbb6cso130879266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708944544; x=1709549344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrWLYtqd2oPYXe7xrqMQ9XAg0ahyT9g/GSMPGa3xAnU=;
        b=qC5w6VEJVUPuowzx82MuJn95MoKqql4C01FbFXpcXPOjopsOLran+5nyLm8nC4tgMi
         lpFU60SFXUQ3AyYaxoI5YYof5Foz6+qtPM7Rsc1c5J4CcXW9fopEdCxucURKLOEexz7o
         YgF9/6jZQi4shqC0W983Cmh/D0gyxV3D6s9kgAWzBTemN6Vo4O1PxQxVdjCerSKX/7pE
         OReRWaYqtDwV9NBBpOBo2/l1bT7sLwsWLbuHlj/Ykca6syN5ZIV0IJQltN5rGZy1Z1JB
         gjvOvcsFg0KiemZzMfGyhoxkfNHgJ8OEwavw5fxOiMatwbZ7D1lOa8lZQXaGnE+aPHpk
         RZgg==
X-Forwarded-Encrypted: i=1; AJvYcCWoGmJR8uV71YQfTr3r6y+SI7335XhzAApaIlmEzSsBglIkcrnIFBlm0YbasW3GEvZ8oq/ch26hdL9Sq1W9xftpdPFitUsdxhciE7VK
X-Gm-Message-State: AOJu0YxmOWVxQ6yYS7bT30+brEPlrFssgsVjLR76hWX2l4a7djBm1hoT
	1FJxXbWzPEhBHutFkLWl9Wcq7B5uHr4aZf5eJKN1a9DD6Xd6H91Co+1sX0mBicWc/qP36JKkOSV
	jwYjL6GKcaj4NjjZSpyPG1TwvADd7tFBkxCYGAuTyqZfagL4oFB+DXljVQkQRXA==
X-Received: by 2002:a17:906:c40c:b0:a3f:d2f3:d226 with SMTP id u12-20020a170906c40c00b00a3fd2f3d226mr3902605ejz.17.1708944544473;
        Mon, 26 Feb 2024 02:49:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgFHc4kU42ZCWURdwrBTU2m+DV9YfBo4gixVnObYtzVknKuFLf5Ic5UH7eLPkpUMhjJLrKkQ==
X-Received: by 2002:a17:906:c40c:b0:a3f:d2f3:d226 with SMTP id u12-20020a170906c40c00b00a3fd2f3d226mr3902592ejz.17.1708944544206;
        Mon, 26 Feb 2024 02:49:04 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id rf14-20020a1709076a0e00b00a4339b8b1bbsm1143238ejc.212.2024.02.26.02.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 02:49:03 -0800 (PST)
Message-ID: <549ba85b-9902-4fed-9f67-e3ebc3aec3ec@redhat.com>
Date: Mon, 26 Feb 2024 11:49:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-privacy: Remove usage of
 wmi_has_guid()
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223162905.12416-1-W_Armin@gmx.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240223162905.12416-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/23/24 17:29, Armin Wolf wrote:
> The WMI driver core already takes care that the WMI driver is
> only bound to WMI devices with a matching GUID.
> 
> Remove the unnecessary call to wmi_has_guid(), which will always
> be true when the driver probes.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/dell/dell-wmi-privacy.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-privacy.c b/drivers/platform/x86/dell/dell-wmi-privacy.c
> index 4d94603f7785..4b65e1655d42 100644
> --- a/drivers/platform/x86/dell/dell-wmi-privacy.c
> +++ b/drivers/platform/x86/dell/dell-wmi-privacy.c
> @@ -297,10 +297,6 @@ static int dell_privacy_wmi_probe(struct wmi_device *wdev, const void *context)
>  	struct key_entry *keymap;
>  	int ret, i, j;
> 
> -	ret = wmi_has_guid(DELL_PRIVACY_GUID);
> -	if (!ret)
> -		pr_debug("Unable to detect available Dell privacy devices!\n");
> -
>  	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> --
> 2.39.2
> 


