Return-Path: <linux-kernel+bounces-135615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB2E89C88D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7951C23F8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237B9141981;
	Mon,  8 Apr 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uj0wN22H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14892561F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590852; cv=none; b=Esa1pqTSWsbKjCICLZ5NYYFIBChpRM2UkdndEXKLYZAz/dy8j4RJP29a6wlP+nkQqub99eJJ94O1nACuS07CQyhci+kY3YCUCleppOwsOzMK5s5WL2TU9QyQ2EQnvGFDVirO+cmQRWR1m7lcvHxCN0GLf3VGXloVBwZShHluJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590852; c=relaxed/simple;
	bh=53u/ieqERkyf7mkrfcHCloeINDAbD0lTZhdu4LH8wOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEyf1H1J4YB1gm+msgukxAgwbAKCgNMsRahZJj03o6YxQJoFsDA9AaaoCfW0CR+bNT9fgfXUPNlmBd+pWuS+336lDmRlANL+lQLzXK6KGJ1GtHezyODN/uvabzTLMVacDXuGz5tjtyfNTjhlUeZC7HhoVaZE0KmYK4gUb08udbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uj0wN22H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712590849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qnh8e0FZeCXeuN57OAvQ7h9lJ3J1XV9u7rdXhlfnOms=;
	b=Uj0wN22HWErfrtx2++dc3kCHTB1sZs2sFGxQ1EoGCXM24ih9R5ZA9aC6bx5YAovBDKwTiQ
	8qXbhHdb48UH1L5wfYyLvpDgc3cUsBXGv1AQjg/l44RKi87FtIVb4udRlrtLsMYwtddBwC
	+EQHAqVeBUUxSIv0zhT15DLh4tLwzXI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-XeftFY4TPHS6AAW3ZFiXkA-1; Mon, 08 Apr 2024 11:40:46 -0400
X-MC-Unique: XeftFY4TPHS6AAW3ZFiXkA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51b97efbb8so223345566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590845; x=1713195645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnh8e0FZeCXeuN57OAvQ7h9lJ3J1XV9u7rdXhlfnOms=;
        b=PAZnQPyxycMPV5Fr+5J4bHfjdhFTO4tpKKIfg4YiiCKytBi9LWshFt1pIyQVK7Zb9c
         GUS+L5BKfRhTG5uzE8l8P788ywEwgwCryPxpgdvsnrDUOyuTaOHpG8s0BFFIMYDUauHj
         hSq8wmlJ4HTzNyv9Nhesi0LEPMfA7FRBD1fkfj9oUoCRJTCDofKGJPQ1nHFq9Zg4eS+l
         KX1va3OxiDhCZq/yAI8Zjs2WzwCCgcl9BIPjbTxQ+db0o5fQtGgvvVELSrvlpQTyZfzw
         a9fHiHNiNjBsiyWu0ubu1zpHEgH1FnTmag/dv8DAuL2FmjpWT6EG+D582opXSswGbi8l
         t3hg==
X-Forwarded-Encrypted: i=1; AJvYcCVBNYZqNBG5GbKhYH0gqffp01mSELnhr533tAl2u0fgdTdOavXCpMHJGgejN56CiOlxcFB371yHbm59CKj/CPD3pJaRled87cRM+BJS
X-Gm-Message-State: AOJu0YxkvVCxekb5vO0gaSTTej2EVr9fZPsfhug3PDCBGL1t6/wv0G0V
	HmLw0of3nW70b8VtohXfZfVcJPm7Dnb+FLqa5NWvGpMPcWcjkEM8xHMXt7ZQLqBA3+fbs97euA8
	T+BUrh1trk8jpUe8z86+wPRWaICr0x7H/OEWImKvHdWKZMV74dSqIcpREklt0yg==
X-Received: by 2002:a17:907:2687:b0:a51:e427:f418 with SMTP id bn7-20020a170907268700b00a51e427f418mr30714ejc.35.1712590845504;
        Mon, 08 Apr 2024 08:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqFndACzMzgue7oq/n2V6d4eUGU5nTF24UnlZxTj1ggn2kkYl8iT6pHsyvZaXtQ8vguwA9HQ==
X-Received: by 2002:a17:907:2687:b0:a51:e427:f418 with SMTP id bn7-20020a170907268700b00a51e427f418mr30684ejc.35.1712590845135;
        Mon, 08 Apr 2024 08:40:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709061ec800b00a46d2e9fd73sm4573031ejj.222.2024.04.08.08.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 08:40:44 -0700 (PDT)
Message-ID: <7d1cd4f6-118a-4dbf-a882-4c13386a0e18@redhat.com>
Date: Mon, 8 Apr 2024 17:40:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] platform/x86: wmi: Mark simple WMI drivers as
 legacy-free
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240402143059.8456-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240402143059.8456-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/2/24 4:30 PM, Armin Wolf wrote:
> The inspur_platform_profile driver and the xiaomi-wmi driver both
> meet the requirements for modern WMI drivers, as they both do not
> use the legacy GUID-based interface and can be safely instantiated
> multiple times.
> 
> Mark them both as legacy-free using the no_singleton flag.
> 
> Compile-tested only.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> Changes since v1:
> - add Reviewed-by tag
> ---
>  drivers/platform/x86/inspur_platform_profile.c | 1 +
>  drivers/platform/x86/xiaomi-wmi.c              | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 743705bddda3..8440defa6788 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -207,6 +207,7 @@ static struct wmi_driver inspur_wmi_driver = {
>  	.id_table = inspur_wmi_id_table,
>  	.probe = inspur_wmi_probe,
>  	.remove = inspur_wmi_remove,
> +	.no_singleton = true,
>  };
> 
>  module_wmi_driver(inspur_wmi_driver);
> diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
> index 54a2546bb93b..1f5f108d87c0 100644
> --- a/drivers/platform/x86/xiaomi-wmi.c
> +++ b/drivers/platform/x86/xiaomi-wmi.c
> @@ -83,6 +83,7 @@ static struct wmi_driver xiaomi_wmi_driver = {
>  	.id_table = xiaomi_wmi_id_table,
>  	.probe = xiaomi_wmi_probe,
>  	.notify = xiaomi_wmi_notify,
> +	.no_singleton = true,
>  };
>  module_wmi_driver(xiaomi_wmi_driver);
> 
> --
> 2.39.2
> 


