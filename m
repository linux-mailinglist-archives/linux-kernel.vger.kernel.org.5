Return-Path: <linux-kernel+bounces-81209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C74B867207
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7EE1C2904E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BCA20DE5;
	Mon, 26 Feb 2024 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3qIJF0H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790F208B0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944512; cv=none; b=FPlF/q5TWguLG6uxlLTtMRLHLl0daG+qR1xX2/g9Y4dzRnK+c0vWX/BviDVY9JSLMvPR0Qx3PKo7kM/aVPwfxXYtWqVP0h1ds4DTFYnh1JBx/pmwIHhjRHUuhV94fbIf6whiUIj5i8dUw3560e749CxVuc9NC1MdCWwwLuEVOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944512; c=relaxed/simple;
	bh=acLFONxVsgOTr7U735zdjWOky1DA+WSRO0IbU4NPfOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwFPkn6ob8K1aKA0//XrQvHXf8KpK1G0Ez6+GNOEC8SwWKO42d3Zah0Mk/02Taly+rQuVzm/4Jz6YKQUv9WMbDEP9GALqR15s+1QxzHKT2uqlOU+AaTkAENpSFWhbCQA3bNZ9Uj88Ulzdz6GKDrsghtADOfmOkzb8ZdfyD/pmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3qIJF0H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708944509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WWbzeMEGRxSialS8tcKozQ9wwd4hRgUVyZjvYbLpxY=;
	b=Q3qIJF0HjRQXuMEZKFt5yObsjqLCNytQLOF+gT+5ZiVi+dultDc5VxZQJKz4MDMXHAkGCJ
	WWhfFXGhOrqID4U5K3NPMUiHtoHqiq1r3ZiblffAYNkdHGUrUxg+NPrbeA0bUc1ii6aOfW
	+VLqXxltHueJFXliYR700Y7KeJ/fBxI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-aCoOmdD8NW2y9aKHOrgGsQ-1; Mon, 26 Feb 2024 05:48:27 -0500
X-MC-Unique: aCoOmdD8NW2y9aKHOrgGsQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3f84b660b8so192373266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708944506; x=1709549306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WWbzeMEGRxSialS8tcKozQ9wwd4hRgUVyZjvYbLpxY=;
        b=UylV3eqw/xNU6cNOji+vPfM/WAstsdTEQglVCHlHgSAVOhfRvuVHgotde9vlX+vC4V
         ZtcCc4WAXXk8Mf4QFJ64oq4/Cs7Snkmxntrz7ll/MRmxqLibcE4MNATiJapsDyJN88VA
         eSbg3znGhKL7R8IbozsBshF4FjBDz8u8+qitpqRNTRU5Ithgkcy3hM9nUwHGfDQERVJI
         cF06QnNUFOtLOm/mSGDa1MBgt2zwp5xYeaAVYlZW8P3EwFVJ2sz3r7wyRFxXFJ7UPjgl
         1ePkIKEpucljqigL+JbvCcX0JUPHvNQxCF4n0Dl9mqcupOzRDM6uo4vP+YXt6IkkG2Rg
         2I1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3iGCP3AHgZL5Fa7FeK7zynpSMubLS4T5zIhPnzUazIZjxHEJ0vTgK47UNsVezP+K5Kcjerj3ZQi0OsXiYSHAwAIHqmeDjFlnIu7mB
X-Gm-Message-State: AOJu0YyZ9I4Kt2OjyN7XoaOVhsKNjItfDzAUjqh3tiXDi57+C7aRMQOJ
	lsQlGYIadoTzk8DtVZKFAg+G2XNwZQY5Ofc1CYIJg9S+h7YcHtjd8r+/vpGBY/UIda9bUcrunVO
	XlvDh2jdl4VD01a8Z6BWNF/3vGGjibZHGzX/bdiI36iq/5y7w2ku8p3kYdR2M/Q==
X-Received: by 2002:a17:906:1745:b0:a3e:7eb1:4bf6 with SMTP id d5-20020a170906174500b00a3e7eb14bf6mr4954345eje.2.1708944506488;
        Mon, 26 Feb 2024 02:48:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/DbS/FCtwKr1Rp5bCbvcrf2BitGmFkRtx+KUkSgHkve9ZbfaEcy17sRDczqZ/+/ba7QExmA==
X-Received: by 2002:a17:906:1745:b0:a3e:7eb1:4bf6 with SMTP id d5-20020a170906174500b00a3e7eb14bf6mr4954332eje.2.1708944506154;
        Mon, 26 Feb 2024 02:48:26 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id rf14-20020a1709076a0e00b00a4339b8b1bbsm1143238ejc.212.2024.02.26.02.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 02:48:25 -0800 (PST)
Message-ID: <1044283e-5059-421b-810b-f5f6938937cc@redhat.com>
Date: Mon, 26 Feb 2024 11:48:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: media: atomisp: Fix various formatting issues
 and remove unneccesary braces
Content-Language: en-US
To: Jonathan Bergh <bergh.jonathan@gmail.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240225120350.31226-1-bergh.jonathan@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240225120350.31226-1-bergh.jonathan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 2/25/24 13:03, Jonathan Bergh wrote:
> This patch fixes the following formatting issues:
>  * Fix various misaligned * and */ in multiline block comments
>  * Remove unnecessary braces from single line conditional statements
>  * Remove repeated word "from" from comment
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

(I'll apply this to my atomisp-branch the next time I'm working on that branch).

Regards,

Hans

> ---
>  drivers/staging/media/atomisp/pci/atomisp_cmd.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> index d0db2efe0045..5fa9918c8e1e 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> @@ -65,7 +65,8 @@
>   * At 15fps this means 133ms. We set the timeout a bit longer.
>   * Each flash driver is supposed to set its own timeout, but
>   * just in case someone else changed the timeout, we set it
> - * here to make sure we don't damage the flash hardware. */
> + * here to make sure we don't damage the flash hardware.
> + */
>  #define FLASH_TIMEOUT 800 /* ms */
>  
>  union host {
> @@ -1261,11 +1262,10 @@ int atomisp_gdc_cac(struct atomisp_sub_device *asd, int flag,
>  	}
>  
>  	asd->params.gdc_cac_en = !!*value;
> -	if (asd->params.gdc_cac_en) {
> +	if (asd->params.gdc_cac_en)
>  		asd->params.config.morph_table = asd->params.css_param.morph_table;
> -	} else {
> +	else
>  		asd->params.config.morph_table = NULL;
> -	}
>  	asd->params.css_update_params_needed = true;
>  	atomisp_update_capture_mode(asd);
>  	return 0;
> @@ -3035,8 +3035,8 @@ void atomisp_handle_parameter_and_buffer(struct atomisp_video_pipe *pipe)
>  }
>  
>  /*
> -* Function to configure ISP parameters
> -*/
> + * Function to configure ISP parameters
> + */
>  int atomisp_set_parameters(struct video_device *vdev,
>  			   struct atomisp_parameters *arg)
>  {
> @@ -3367,7 +3367,7 @@ int atomisp_fixed_pattern(struct atomisp_sub_device *asd, int flag,
>  		return 0;
>  	}
>  
> -	/* Add function to get black from from sensor with shutter off */
> +	/* Add function to get black from sensor with shutter off */
>  	return 0;
>  }
>  


