Return-Path: <linux-kernel+bounces-91960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9C87190E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239BA1F2411A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F604CB4E;
	Tue,  5 Mar 2024 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl0DrYVE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDB4DA10
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629690; cv=none; b=ukqY9oDWG8Jpi1fPjuj0xuGmStU1QpSBlUlw3X66l5dC97JHJM6da8jfC2IaZW8glhP4/brgJug3NM+Xpc2sZzi4DH/W7a1bKJo00rhi3LCa3MlDa5BGWNjSoanRn9Ddt86YUA/VWNCzMVfP1A7e4xM0GecJX0X9IgkS86jJYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629690; c=relaxed/simple;
	bh=h455HCdulbwhayh3eDpkrvibMajOVPDkVlKDVe+2pGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipIv1sTLLA6Tv0h2QGouKJd6y98usjKvYHxFCY3eXXDK28nGV2F7Yy0yLOFpJLRktuqbPUEfzqpiHQM6ZoBkndDPii/q7SR6MddwhXhXWhN/rw61qC1b5h6Csf/4OV2TTxqqdk0ErzxNNfrG7KP8ykiPZNnWGUjoobBTqIZ7ELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cl0DrYVE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709629687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eacxxgxORnICKYWOMS/sQ3/ShQ0nCl3n/H8AgYX9QXY=;
	b=cl0DrYVE3annZWpkVMWws1RJktdWEftdEmf64Zai/oA0eqMzu5JEDv6pcxVUTVqajyWvnQ
	VoV/l0lgGn+mK9pTmzFK2kTfHZsvv9nDosAURCsz2IxsU29T5GoyyR/h7WHVTNZKzI4QaQ
	spyVChy+sT8q5Ti/aSISPrLOj4vyM68=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-OHXoik9IOKuNy8pPChVn8Q-1; Tue, 05 Mar 2024 04:08:05 -0500
X-MC-Unique: OHXoik9IOKuNy8pPChVn8Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4531df8727so72235166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629684; x=1710234484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eacxxgxORnICKYWOMS/sQ3/ShQ0nCl3n/H8AgYX9QXY=;
        b=mkVrFhgJmSPAEeRAZzy6UET4MU630FCLzkb4YDiwbGCCXIkZvhLiivb3egp2kDULNs
         HfoE7lSxl/o90LZomrYCA3RlE4LGixKDegyu0dUnteSDiYNlEh8Lo+Gr2cECZ0Q2Qi0l
         6qGXprp0FtGLErVs1S9nB8I4T9Wn/2f4+rZHIbI/r7yV/5jnIhdE7kT73pEj6kFVmODJ
         Ou8zLYkrRpRQ9jaH/XsYykRkW4YxG+HFpPbLaYyjelbhM1tLDmObDtpzvWD1SOKheOMb
         4/QXSOZLOqtufD+fQp0L/aKQ92qQCYh3ZMKXS8c90tt42lyppChnQ00y6PQehaCpllRr
         zERA==
X-Forwarded-Encrypted: i=1; AJvYcCVvQRXqW5i5Gg4yU2P7XSZWQ+qiduhcRjhrGtfqaZPBa7KDBXi7hp5NAQXNz/2I9lYNiLgJKF5hwESLEp48P4YMUW/7MaXP6fKoMwRs
X-Gm-Message-State: AOJu0YwGXMYhhFcyx7ZSdL4aIl8wzv1rNSEqfwM6npoFxR0Ea1AIoOAo
	6VxBYqbbk4Aa1dHasLsIKRL3wTR1u6ChSfB1cEHuLQN3bbymMSJmbeZgnPi3W6dmYW7AQ0Zm84w
	FbqEG7jr0BiPUStcalv5jTc15+GEx3/aAfdw2TAGtl0GfWIICH1pw5H93Re4sA/gg/wBAIQ==
X-Received: by 2002:a17:906:4a10:b0:a43:2c94:9420 with SMTP id w16-20020a1709064a1000b00a432c949420mr8184631eju.60.1709629684118;
        Tue, 05 Mar 2024 01:08:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtF0rrCgWZbp3f9P+Y1akZetFZZA93pf4sDbU0Tv7kLUmNzeybTEuO1Txnj/aLi1hKRdcCtg==
X-Received: by 2002:a17:906:4a10:b0:a43:2c94:9420 with SMTP id w16-20020a1709064a1000b00a432c949420mr8184619eju.60.1709629683794;
        Tue, 05 Mar 2024 01:08:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ld1-20020a170906f94100b00a451e507cfcsm2644192ejb.52.2024.03.05.01.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 01:08:03 -0800 (PST)
Message-ID: <6b8bca7a-feb4-4269-9f00-2cb04d8a6235@redhat.com>
Date: Tue, 5 Mar 2024 10:08:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/x86: wmi: Support reading/writing 16 bit EC
 values
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240304221732.39272-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240304221732.39272-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/4/24 23:17, Armin Wolf wrote:
> The ACPI EC address space handler currently only supports
> reading/writing 8 bit values. Some firmware implementations however
> want to access for example 16 bit values, which is prefectly legal
> according to the ACPI spec.
> 
> Add support for reading/writing such values.
> 
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/wmi.c | 44 +++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 1920e115da89..900e0e52a5fa 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1153,6 +1153,32 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>  	return 0;
>  }
> 
> +static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < bytes; i++) {
> +		ret = ec_read(address + i, &buffer[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ec_write_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < bytes; i++) {
> +		ret = ec_write(address + i, buffer[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * WMI can have EmbeddedControl access regions. In which case, we just want to
>   * hand these off to the EC driver.
> @@ -1162,27 +1188,25 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  			  u32 bits, u64 *value,
>  			  void *handler_context, void *region_context)
>  {
> -	int result = 0;
> -	u8 temp = 0;
> +	int bytes = bits / 8;
> +	int ret;
> 
> -	if ((address > 0xFF) || !value)
> +	if (address > 0xFF || !value)
>  		return AE_BAD_PARAMETER;
> 
> -	if (function != ACPI_READ && function != ACPI_WRITE)
> +	if (bytes > sizeof(*value))
>  		return AE_BAD_PARAMETER;
> 
> -	if (bits != 8)
> +	if (function != ACPI_READ && function != ACPI_WRITE)
>  		return AE_BAD_PARAMETER;
> 
>  	if (function == ACPI_READ) {
> -		result = ec_read(address, &temp);
> -		*value = temp;
> +		ret = ec_read_multiple(address, (u8 *)value, bytes);
>  	} else {
> -		temp = 0xff & *value;
> -		result = ec_write(address, temp);
> +		ret = ec_write_multiple(address, (u8 *)value, bytes);
>  	}
> 
> -	switch (result) {
> +	switch (ret) {
>  	case -EINVAL:
>  		return AE_BAD_PARAMETER;
>  	case -ENODEV:
> --
> 2.39.2
> 


