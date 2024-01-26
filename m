Return-Path: <linux-kernel+bounces-40560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D90283E274
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE71FB233A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E43224E7;
	Fri, 26 Jan 2024 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvC9WHxK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A51DDEA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297127; cv=none; b=pCFNqbOmQlXc+Mrj0nt5qBuOTjiqK80r6MG0IfOU6NWuFsvYBCTtK5o1eqfs8stFgjTdNYOWtJPT3qegMxai4OrMK/XbGAAEbxMGerv8YwmJzouyFBZOQBA11jAAtVWQwrw337rDOuK1V7WNxk+ENNgMEH41fc1MEeBvdmO1gwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297127; c=relaxed/simple;
	bh=8RvrO6y0/Of68/2+jUaQkLUjJNzaixet1pA07PR0cp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LH3jbGk0Cu4cJ+OCD5sIxIVKGR1+4qfOhHTbqN3pAvl04X8Aqgpo33Mxob30DMyJsDYcaDArDaCXMHWBZihtEFR6+flldQ6FcEWPY/hdZZgT6XVqr1u0rgz9AGO06zdNS85WsuHXguX4enGxHWqrFdeJPgyntUNCNgn0e1KwbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvC9WHxK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706297124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BwPJ3hvI/qWKIxSwUd8kfeZg8oeRu3IC468fyX+vyo=;
	b=XvC9WHxKfcA1ADUv0Exmeb2aDFfy7ibHnJXzFaq75y7coADffGxz+zniN0RjcvJ1QfusQT
	GdB/6AFyIUN2UpeMOeE8Fs+eMzgoC/Idu65RmyMvY4kCIgMYaPBiaM/t2925RgKnovKutj
	JYvO+/UGvH0ljEPKIxPG6nVDzjMcBfY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Jb7mHXp_PNmCuszwaODNrA-1; Fri, 26 Jan 2024 14:25:23 -0500
X-MC-Unique: Jb7mHXp_PNmCuszwaODNrA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a30f9374db7so239002666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297122; x=1706901922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BwPJ3hvI/qWKIxSwUd8kfeZg8oeRu3IC468fyX+vyo=;
        b=c4Ulc7/tTltUgklEIxESKAWN7zYtaXDsOTO2bBm1C5J0gKJHTv2jLiOjBxySNVx3fm
         SYg29ab+cS2V9iXDHo54wJY3knAWqiYsDhKYSlfMiZMLA82f809j8UgrYaxZucezMD11
         nvwN1maGyc45f5UDsiyCzPRwL45XftuTKmKTOm8jey489zhGSp/S26685hgnU7OIJMWQ
         wEllRKkmbEwJhylAuRRIMCQJClKmQMmXG4rD0cXABmCr2sgE+O8ewOQNaCWC9BJ9C2pG
         m+9FeqZmUg+EvgZiVJu3/MlKk2Y0XVpp1ilnoaDJfauQB6rjlH5Wy6TG0SGK54cyYs4P
         PXkA==
X-Gm-Message-State: AOJu0YwbnlcQoPYDFNNmbI+fTq9FqrU8IKfAiX6MglBn4Ov49KFGMLb5
	LHyRvcw+MyGASAzomOepGMebj7/j+Z2kLju7Bzgh5KkTPgY4qeNJmrP+xl46a7l9UYs0EUIPt1O
	Ac1Z4tJkFLQcEpuDH/p/n7omDOOQxw4G0NX/STF7LXWwDZ3WNVACRX2E9PB87pg==
X-Received: by 2002:a17:907:d40f:b0:a32:6050:46eb with SMTP id vi15-20020a170907d40f00b00a32605046ebmr2342014ejc.23.1706297122305;
        Fri, 26 Jan 2024 11:25:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH7koZ3GtAHLsUDuZmgVG/7afQQStoYjkOG4elT+L0C6gW2E+7RHwF8ftfXVXnrcCaZieTBQ==
X-Received: by 2002:a17:907:d40f:b0:a32:6050:46eb with SMTP id vi15-20020a170907d40f00b00a32605046ebmr2342001ejc.23.1706297122033;
        Fri, 26 Jan 2024 11:25:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jt6-20020a170906dfc600b00a2d1b0c7b80sm931908ejc.57.2024.01.26.11.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 11:25:21 -0800 (PST)
Message-ID: <d2600cc6-332f-4a6b-9eb4-b84fa4aa033f@redhat.com>
Date: Fri, 26 Jan 2024 20:25:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/platform/x86/touchscreen_dmi.c: Add touch config
Content-Language: en-US, nl
To: Phoenix Chen <asbeltogf@gmail.com>
Cc: ilpo.jarvinen@linux.intel.com, linux-input@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240126095308.5042-1-asbeltogf@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240126095308.5042-1-asbeltogf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/26/24 10:53, Phoenix Chen wrote:
> Added touch screen info for TECLAST X16 Plus tablet.
> 
> Signed-off-by: Phoenix Chen <asbeltogf@gmail.com>

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

And thank you for also adding the embedded_fw data so that is
will work out of the box for end users.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans





> ---
>  drivers/platform/x86/touchscreen_dmi.c | 35 ++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 0c6733772698..7aee5e9ff2b8 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -944,6 +944,32 @@ static const struct ts_dmi_data teclast_tbook11_data = {
>  	.properties	= teclast_tbook11_props,
>  };
>  
> +static const struct property_entry teclast_x16_plus_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-min-x", 8),
> +	PROPERTY_ENTRY_U32("touchscreen-min-y", 14),
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1916),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1264),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +	PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-teclast-x16-plus.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	PROPERTY_ENTRY_BOOL("silead,home-button"),
> +	{ }
> +};
> +
> +static const struct ts_dmi_data teclast_x16_plus_data = {
> +	.embedded_fw = {
> +		.name	= "silead/gsl3692-teclast-x16-plus.fw",
> +		.prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
> +		.length	= 43560,
> +		.sha256	= { 0x9d, 0xb0, 0x3d, 0xf1, 0x00, 0x3c, 0xb5, 0x25,
> +			    0x62, 0x8a, 0xa0, 0x93, 0x4b, 0xe0, 0x4e, 0x75,
> +			    0xd1, 0x27, 0xb1, 0x65, 0x3c, 0xba, 0xa5, 0x0f,
> +			    0xcd, 0xb4, 0xbe, 0x00, 0xbb, 0xf6, 0x43, 0x29 },
> +	},
> +	.acpi_name	= "MSSL1680:00",
> +	.properties	= teclast_x16_plus_props,
> +};
> +
>  static const struct property_entry teclast_x3_plus_props[] = {
>  	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
>  	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
> @@ -1612,6 +1638,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_SKU, "E5A6_A1"),
>  		},
>  	},
> +	{
> +		/* Teclast X16 Plus */
> +		.driver_data = (void *)&teclast_x16_plus_data,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
> +			DMI_MATCH(DMI_PRODUCT_SKU, "D3A5_A1"),
> +		},
> +	},
>  	{
>  		/* Teclast X3 Plus */
>  		.driver_data = (void *)&teclast_x3_plus_data,


