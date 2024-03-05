Return-Path: <linux-kernel+bounces-91962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9C871913
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BB8B22992
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70529524C7;
	Tue,  5 Mar 2024 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWOMYu/X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457545102F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629708; cv=none; b=U6C8XGCz6vnrZSw862gd9pLaKADkJpaTOnyecBYkSYiZxOQJ2s06dgdGc8wigDaFZ5pJg4quQvBxMCCfz6phF1SjxF4fKiutf8XB+SWdNkLVLOPtx5ElK5OmQDx7qMd2XyjgnO9tzUDDKn8da/92jPE2LUy0XumD4m9HoHwnKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629708; c=relaxed/simple;
	bh=IjAauvhfqdr5UwpHJRzD8ym4pPocRW0/F4T5uHiMWmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzS4ppySarf2FVylJgl7n8NRbeqcoYk3AqmOrfYskeQhiWzBt3ZMqOVByCjTdNsOatI0PMpQmpFAa37rh0XamfIQkvANeuYdJ9vVBGYlp/R5q0TfM3PwkDfttzsCtrWUkJRfygnJcz7puHEd7kbZJcdifvopEcWADaymVamDA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWOMYu/X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709629706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSNkggVyvaB+KZkPijsD+ulRW3SZwhAot3Raa1YQt8E=;
	b=UWOMYu/X0dotZDkUMRgP0sJZU2EBQX+nKu94PmbhSZDLyxgXKnekseAD8y1IoaD5JOeI6T
	3Kiry+CP82JTTVtpiGAWvP6KriRT37j9M9FYmDlFYEVzLSdmrYjUt4CdUqRZY6wcCW2pyv
	7q7hqspQPi0dbdyjIpE7GgSLsJk+ggA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-W21OONIhPl-cMeLB0zORIg-1; Tue, 05 Mar 2024 04:08:24 -0500
X-MC-Unique: W21OONIhPl-cMeLB0zORIg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-565146088eeso3415430a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629703; x=1710234503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSNkggVyvaB+KZkPijsD+ulRW3SZwhAot3Raa1YQt8E=;
        b=ZIa8EkkGlc4rrrtExSdw4Y5jfzcLOAvhmoiZpBG7ChZ6gjf/jV08lw+iiIccmIDsAE
         h/sMt56bnRnZd9uSzNRvgs0N0RHZCDoT6Kb/3YIiffxL5pFMtZSE73hwTMNRRMLvCJYJ
         bW/N91oJUGZRxslcPuEMXRffKdREO62iDlKCLBL20IFpGxO+2WYcEfZJgX86ykrRaQek
         iV65AnnkS3vCk3MFlVSqYA58ZkS3lrRaoE3Fo7yUiQzvodis+dGZnDZKFwDTDza1HUrA
         8qBtl7HlaXw4jGY/LSUT+Xc+1H+/XLKCmhHaCYOua033go6SVMwbcUGSwgYVLhC3jqKm
         7gQg==
X-Forwarded-Encrypted: i=1; AJvYcCWi+cR6+WwRROXcTAxTpx0Zy0ISXlm/pWgiGAj52a+OgJxx6jUjVrbyFRwlqbMQ5LeZnL7bS8eOj/iShe+qldLcHybkfQ0QWaGWUsOM
X-Gm-Message-State: AOJu0YyHcBNyNeIGBZa1JizyE/JWd0DnJhsCT0QlItEjqWupMU0bs30Q
	zfKvSRTi3qwV9HEQYjNjuw7nslCa+yh4bedpYOni3WsCz3KfU+D++/2BWqwbmYHKws+74OGFAnT
	6yEmIotfjes/yUXHXaguIDGfeTawhkOGkp1PhhxRFtOb2xT3SnQnY0Ptgb1rje5gAdhDaGg==
X-Received: by 2002:a17:906:1906:b0:a44:7db8:a343 with SMTP id a6-20020a170906190600b00a447db8a343mr7891751eje.76.1709629703281;
        Tue, 05 Mar 2024 01:08:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhS94s8uRYU3PPk9Oxl08yG3qUvdKCOWXKA4CRghTiLh68oFKznWVH4ajJkxicUm3rbsU/Fw==
X-Received: by 2002:a17:906:1906:b0:a44:7db8:a343 with SMTP id a6-20020a170906190600b00a447db8a343mr7891734eje.76.1709629702953;
        Tue, 05 Mar 2024 01:08:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ld1-20020a170906f94100b00a451e507cfcsm2644192ejb.52.2024.03.05.01.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 01:08:22 -0800 (PST)
Message-ID: <175fcdf2-255c-4cfe-9e5d-d349accb88d1@redhat.com>
Date: Tue, 5 Mar 2024 10:08:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86: wmi: Avoid returning AE_OK upon unknown
 error
Content-Language: en-US, nl
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240304221732.39272-1-W_Armin@gmx.de>
 <20240304221732.39272-2-W_Armin@gmx.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240304221732.39272-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/4/24 23:17, Armin Wolf wrote:
> If an error code other than EINVAL, ENODEV or ETIME is returned
> by ec_read()/ec_write(), then AE_OK is wrongly returned.
> 
> Fix this by only returning AE_OK if the return code is 0, and
> return AE_ERROR otherwise.
> 
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/platform/x86/wmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 900e0e52a5fa..be0e772a87c8 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1213,8 +1213,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  		return AE_NOT_FOUND;
>  	case -ETIME:
>  		return AE_TIME;
> -	default:
> +	case 0:
>  		return AE_OK;
> +	default:
> +		return AE_ERROR;
>  	}
>  }
> 
> --
> 2.39.2
> 


