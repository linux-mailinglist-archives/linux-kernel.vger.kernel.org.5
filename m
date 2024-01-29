Return-Path: <linux-kernel+bounces-43152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ACC840C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261A71F24E62
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB115704E;
	Mon, 29 Jan 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dpj4s6dl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6696A15703F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547273; cv=none; b=uger0SKVLVFInukk9mHH7tMAXYA52P/ciAZJs10FKPyrnWP4CYMoyhzsUbx9NrFV9Q/+3aT9bQttRqM5gBZmSgpSKfwCACTYZ546noMpicZyUZWlpE/SHsJ2M7OE3TLnYxi1df4bO+E6N/p5PMeCg1N3iAQDDOaNAv9alf3Lv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547273; c=relaxed/simple;
	bh=iFNzd4mw40s4KUm6eOReaJzKwb+wS/JRCr/xou02cuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyEeHsu/ExQ9wxXTALL/6QYnXtSr43zVOSrkY015C4sYAEbwifStt8uyht4RjHq5GUMU4krEr1oMj0x53IojA2LyfD4lQBpei5hcbYHN/UK+ziJxdhgzx6ctUrVJ0M6sA5Pt45H1l+7buJCB3z7HKUBR30Uun3wges0FxMTR7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dpj4s6dl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706547270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IB0VM0uJ1/FZbzHRbCVJX5WpCqsKxQUXqystAOpQFds=;
	b=Dpj4s6dlKnilDE80eKEUlNTadSDxsL/OpJsOvL+B/PBviQ33aXsRvV5QKS2eP32MjlE8Aa
	BWy4DBFtm24ju9M1w9mnOD1P4QdFQjpYvnfWtq60hUg9XzXM1NABlYUH6OegBmEPR1ce65
	RGECpuIkCvmQGnciORShKEb27CETk5Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-KDNGua4DP0CjZyjV_wfnPg-1; Mon, 29 Jan 2024 11:54:28 -0500
X-MC-Unique: KDNGua4DP0CjZyjV_wfnPg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3496ea2ff6so151881266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706547267; x=1707152067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IB0VM0uJ1/FZbzHRbCVJX5WpCqsKxQUXqystAOpQFds=;
        b=WskXMXkcVCXhHi69u4ACK7v43DCmDNZhFFL+/QikciQe3Y8mjrdopyNZuARlPwhRlc
         z1OBKejmPcASOIEnVmgdJb+xZUmZ2dzNL6uIzSk2dFoaotNGSzgetKxXrzXjv6Qd12ch
         //PaiLUoL49uzKYpUHREQB8f/OOlzG45NcDmBa9yI1t/feM3AIYO5V2c2d8E7L9kszbC
         +rhPB88hnSQCuYMRBJNjG18/ol58I97rcv+V0WNH9AVNQ21t1u6MB5+EN5RfXE86Ni1b
         QB5wj/IWF42zcr8E9h/yLodWtLKzpGp2YLPejGnbYtPKUlzVNWF16RN74cq7saE4PZ3A
         oSpA==
X-Gm-Message-State: AOJu0Yy5hYcqwykkzUoXMi16vD+A3/bNzNLJGHX+cLvoGWz/KLCkV0k7
	hLA+l8Oyl4tlzz6Cxj4lGY+lSdsJ5eO8FmkIwVuL6XkDLWEU+6VPWRxStzN7es7NSJsVqU/BNCx
	804yAz8s1pwW9jlVaxd9Lv7fgM1GQW2ApApK04ykYBIz6T0gJe6BntTJGaBOJrQ==
X-Received: by 2002:a17:906:6d8:b0:a36:11f:58fc with SMTP id v24-20020a17090606d800b00a36011f58fcmr426343ejb.40.1706547266874;
        Mon, 29 Jan 2024 08:54:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6GX9Muw9V608uTSaVb3N1AMA/7de2U9pcEOdDZ4kom1ckkYgQxh9xiaz+xeokcP2fjiMX/Q==
X-Received: by 2002:a17:906:6d8:b0:a36:11f:58fc with SMTP id v24-20020a17090606d800b00a36011f58fcmr426336ejb.40.1706547266580;
        Mon, 29 Jan 2024 08:54:26 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i6-20020a170906114600b00a35a3d322e4sm1631217eja.209.2024.01.29.08.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:54:26 -0800 (PST)
Message-ID: <4bd022b8-e4a9-4269-a261-65fddc791ec5@redhat.com>
Date: Mon, 29 Jan 2024 17:54:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: logitech-hidpp: Do not flood kernel log
Content-Language: en-US, nl
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, =?UTF-8?Q?Filipe_La=C3=ADns?=
 <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <20240129164931.38477-1-oleksandr@natalenko.name>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240129164931.38477-1-oleksandr@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/29/24 17:49, Oleksandr Natalenko wrote:
> Since commit 680ee411a98e ("HID: logitech-hidpp: Fix connect event race")
> the following messages appear in the kernel log from time to time:
> 
> logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> logitech-hidpp-device 0003:046D:408A.0005: Disconnected
> 
> As discussed, print the first per-device "device connected" message
> at info level, demoting subsequent messages to debug level. Also,
> demote the "Disconnected message" to debug level unconditionally.
> 
> Link: https://lore.kernel.org/lkml/3277085.44csPzL39Z@natalenko.name/
> Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/hid/hid-logitech-hidpp.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 6ef0c88e3e60a..d2f3f234f29de 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -203,6 +203,8 @@ struct hidpp_device {
>  	struct hidpp_scroll_counter vertical_wheel_counter;
>  
>  	u8 wireless_feature_index;
> +
> +	bool connected_once;
>  };
>  
>  /* HID++ 1.0 error codes */
> @@ -988,8 +990,13 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
>  	hidpp->protocol_minor = response.rap.params[1];
>  
>  print_version:
> -	hid_info(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
> -		 hidpp->protocol_major, hidpp->protocol_minor);
> +	if (!hidpp->connected_once) {
> +		hid_info(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
> +			 hidpp->protocol_major, hidpp->protocol_minor);
> +		hidpp->connected_once = true;
> +	} else
> +		hid_dbg(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
> +			 hidpp->protocol_major, hidpp->protocol_minor);
>  	return 0;
>  }
>  
> @@ -4184,7 +4191,7 @@ static void hidpp_connect_event(struct work_struct *work)
>  	/* Get device version to check if it is connected */
>  	ret = hidpp_root_get_protocol_version(hidpp);
>  	if (ret) {
> -		hid_info(hidpp->hid_dev, "Disconnected\n");
> +		hid_dbg(hidpp->hid_dev, "Disconnected\n");
>  		if (hidpp->battery.ps) {
>  			hidpp->battery.online = false;
>  			hidpp->battery.status = POWER_SUPPLY_STATUS_UNKNOWN;


