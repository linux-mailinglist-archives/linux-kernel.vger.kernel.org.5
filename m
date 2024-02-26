Return-Path: <linux-kernel+bounces-81210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D6586731D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D4EB361A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E823A1C3;
	Mon, 26 Feb 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOwwVIS8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC5249F5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944525; cv=none; b=OYdSfMeTublAGJhcZgrKl7OG8BBPIKv4eL+wimUoG7Q48MaNZLqHuIql8qZGQSo6GPVghWmCOiMxWtho/JALhDwXWoevQRJKJe8L6FLzAW8ZvRhf6y2ZaRyInuarBKxsPx+yOINpvCSAflGN/HwdPYgvjX52lIhZr9+LNZ2WqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944525; c=relaxed/simple;
	bh=CgLSVjg8YzV7wsZ4kQ2CtgEGGOtghXgQ/KD7jkKWfsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nF2/kqaKlzlDnytkgIEdveFdyk+yM7ifSzrGHzGfAW5i5b4Jnqi3sTbgjYKyVe7oNMzf6SltIWYFZ08o6X6u19IuSwsUfdQDTU5KhiPdx1s8YgJdovr9JvcSZKVqulpQGLMCdO2E1bRhEFQkDS2WHm8Zb02akHg65ZCj1wgxIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOwwVIS8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708944522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OE8GoZ9j6WhBuZWvbJNk/RKp/M9fLXpjDr094aLbX0=;
	b=DOwwVIS8+oCQ0PYOhfMqauWyLyd5lIA1A+P2Vnyyt2cwC4s04rHZdi8Wg8e9zx+IcUEbn3
	rL2P2hPzDyOPWTWsDgwLO8BU/Ux4/dRlwL++ua8+srkSf5fqwOPiCkJSnPYXv317z9IDLB
	97C4tsG3DvOAKP812A0E6c5J4DoFOPc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-3NwQjjPlP2iRQedq1xuajA-1; Mon, 26 Feb 2024 05:48:41 -0500
X-MC-Unique: 3NwQjjPlP2iRQedq1xuajA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3f84b660b8so192387366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:48:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708944520; x=1709549320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OE8GoZ9j6WhBuZWvbJNk/RKp/M9fLXpjDr094aLbX0=;
        b=Y68ue7L9rvsc8e2mVmpKdhJ7vnJu3g/kD4f+qD5AhdAA3pKvx9gsHlxeYPQLgWvqDt
         2RRBQXHdH7KRzRZWALN7O9vbgJhEQXeL01yvJYx2knZ3+Jb4Xx5r4H5l+QPKutnOlBul
         YpClua4q6kcnMvJC4xXd0a+7e9u3anHbepzcox0bpS0DU4raThTnENj4Y47HN/ossMiA
         9eUMLPqNqv2bAtEmH4gRX6tnVl4rLWyOhx5rP5qVlDbtKVAkLrFD0TFYf9z+Fi97Kycv
         yr5cMU4aCpor4gQ5AYjk2sl54h5sHW/V7iUquVhB3b7d2CvXSgFnSFDb0wBFGxRTkOKF
         qzPw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Z2HvjcQn7ey1L7IIqpazLUKz658hGZ2pGqw4Pg+BVgT4cp3IWBKN0WuM1ia11Q/scw0IEX0aiwjSmmq3YDVBNQP/yfCJzOx3AVC4
X-Gm-Message-State: AOJu0Yz/btVvS1WqxQpXIpruZkThDR3xcBmDYV19ZQg4eNF/aGpvWmCm
	GuCal9dp7l1uHlEVlwMj33FsvnmpT/NmT9BDlyiFSo5vdURUC++a3lcbjgMrHSf5ylI4MIWuPqb
	lehJ/567/4mDBWvgFQ9tmydDJ8yKToVXCkeOfqJwEpHtDTEH6SgDAtylqRUHuDg==
X-Received: by 2002:a17:906:5609:b0:a43:7df:1ad0 with SMTP id f9-20020a170906560900b00a4307df1ad0mr2785212ejq.10.1708944520270;
        Mon, 26 Feb 2024 02:48:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG00i0E8QDj4z2oVxDIc+1nq6MzBGh9+dsfWWEcglt6+KLB0qC1ou2UUdnvPuYHPSpzRDLnw==
X-Received: by 2002:a17:906:5609:b0:a43:7df:1ad0 with SMTP id f9-20020a170906560900b00a4307df1ad0mr2785200ejq.10.1708944520040;
        Mon, 26 Feb 2024 02:48:40 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id rf14-20020a1709076a0e00b00a4339b8b1bbsm1143238ejc.212.2024.02.26.02.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 02:48:39 -0800 (PST)
Message-ID: <182c1e88-0bc2-48a8-89d8-5b0e4b68c6b9@redhat.com>
Date: Mon, 26 Feb 2024 11:48:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: media: atomisp: Fix formatting issues and minor
 code issue
Content-Language: en-US
To: Jonathan Bergh <bergh.jonathan@gmail.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240225155359.41435-1-bergh.jonathan@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240225155359.41435-1-bergh.jonathan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 2/25/24 16:53, Jonathan Bergh wrote:
> This patch fixes the following code style and formatting issues:
>  * Ensure multiline block comments are correctly formatted
>  * Remove extra braces not required for single line conditional statements
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>


Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

(I'll apply this to my atomisp-branch the next time I'm working on that branch).

Regards,

Hans




> ---
>  drivers/staging/media/atomisp/pci/atomisp_drvfs.c         | 2 +-
>  drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 7 +++----
>  drivers/staging/media/atomisp/pci/atomisp_subdev.c        | 3 ++-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_drvfs.c b/drivers/staging/media/atomisp/pci/atomisp_drvfs.c
> index 1df534bf54d3..8ef25d2f8b87 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_drvfs.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_drvfs.c
> @@ -34,7 +34,7 @@
>   *        bit 0: binary list
>   *        bit 1: running binary
>   *        bit 2: memory statistic
> -*/
> + */
>  struct _iunit_debug {
>  	struct device_driver	*drv;
>  	struct atomisp_device	*isp;
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> index 139ad7ad1dcf..804ffff245f3 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> @@ -1416,13 +1416,12 @@ static int gmin_get_config_var(struct device *maindev,
>  	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
>  		status = efi.get_variable(var16, &GMIN_CFG_VAR_EFI_GUID, NULL,
>  					  (unsigned long *)out_len, out);
> -	if (status == EFI_SUCCESS) {
> +	if (status == EFI_SUCCESS)
>  		dev_info(maindev, "found EFI entry for '%s'\n", var8);
> -	} else if (is_gmin) {
> +	else if (is_gmin)
>  		dev_info(maindev, "Failed to find EFI gmin variable %s\n", var8);
> -	} else {
> +	else
>  		dev_info(maindev, "Failed to find EFI variable %s\n", var8);
> -	}
>  
>  	return ret;
>  }
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_subdev.c b/drivers/staging/media/atomisp/pci/atomisp_subdev.c
> index a87fc74159e2..f8efaef2c055 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_subdev.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_subdev.c
> @@ -394,7 +394,8 @@ int atomisp_subdev_set_selection(struct v4l2_subdev *sd,
>  			 * (of the desired captured image before
>  			 * scaling, or 1 / 6 of what we get from the
>  			 * sensor) in both width and height. Remove
> -			 * it. */
> +			 * it.
> +			 */
>  			crop[pad]->width = roundup(crop[pad]->width * 5 / 6,
>  						   ATOM_ISP_STEP_WIDTH);
>  			crop[pad]->height = roundup(crop[pad]->height * 5 / 6,


