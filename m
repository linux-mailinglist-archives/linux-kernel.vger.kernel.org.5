Return-Path: <linux-kernel+bounces-117296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC088A9C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FFA1F625C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BCD157A7A;
	Mon, 25 Mar 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4xvPEv3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0513C14D285
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378467; cv=none; b=YoZg0AOSTJvkMzkmMwN/+GgzqmWx73nPpRRyWFWvAy8HaTDA2yATH69zDvQKHPpOKyPqntfbSDGhsbMlDQmtSQdfqHFP0GJWlPwdRNOX/raSQNXb683GzJS/uuWTp+VwX9sqpj409+5rfHvbo8n5mWZ5gYcJWR94QhlVLiN88c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378467; c=relaxed/simple;
	bh=8VnhkxfxjuirtOBESexek616wd5NCpd98WMDdIt5ims=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1EXo4ZXHz//NfF94KvtaBzn6hM5L5gNGxhcmJdSIywwoURbmBUyhsCJeH/PJmNZRxLERA8tl5t9zRhHzsqvuj0WRjdHNLlD8RydvkX8rykVQulouSBD67KO/4YcPbQ0QtMFwSjSgsGzEgpzuAHYWqyauZU2iYLI8W6dzpgNNrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4xvPEv3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711378464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0TLk3PDJF8gYRGg4jydpewHHRZR1/qQMFUxS/nBJe8=;
	b=e4xvPEv3L+2HCn+h0rQ5T/WtT5G4k1LwjRmywvBc9J0V+qHfzMFxwYS92KBrEkNsoT1FLM
	sb0yAG1gnBYpmlYx7O6S+hnpdSLO9Ozs2k2mz85hCGs5ox0mnYNmZSMTT8evYhUSpsArjr
	TLoCn3YdvS0+W6lgSbRjGelv2WWK6ug=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-v3BMhr3wOR-WDjkwFKruFA-1; Mon, 25 Mar 2024 10:54:22 -0400
X-MC-Unique: v3BMhr3wOR-WDjkwFKruFA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56bf2d97292so1051398a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711378461; x=1711983261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0TLk3PDJF8gYRGg4jydpewHHRZR1/qQMFUxS/nBJe8=;
        b=hpwNCB/xeBWgbWFei7BqDIECbRs9CTKZ081CL3yJ3VPLCbNJJLTxLHhwWeuZAYevCO
         uH3wdYB3hfLtGcbuMHKgqxeCvCGTL9Db7F8oagBYYXixQHEx8wK06epGD6kv1rDQRG3a
         1pt7pP9Y97qFRUMbNDMs9Oh04smDSj6XVhIXE2cvsS3WBokF9EW5EDFr/vgmf6CRczCp
         d20832P9LwdjkOBUJteOac1B9Z43MqspdO37PYQ8Sco7HUwGnX0mZ8HMeMxY0mBdc2+X
         4aj4LhaIXFQ8USEvY9PhkYD3iBZPN4IqDlhkiQ6+0zSSMSelCddU7jf7CtDyiBRsn6Ny
         f6aA==
X-Forwarded-Encrypted: i=1; AJvYcCXezh6RFYptnCLKKtnp4Pxm9d0uOcNhg/MQcGgBd6mxcqWrGWYG85lS1zvfiJeTGv//CUA+fKDEUdPKpW/ov/WTRuwDRKJD+Vtp+JE+
X-Gm-Message-State: AOJu0Yz+qj80CBxVUjqEwPXbri/5z46k5ZSybAj50X8Zo95ohNb0+DKJ
	oG3PcInfWWL5Cs0bl/cgbIQ/k786dUZrCVaQK0vkdmgmWpMQXT+KolNq8HcHlKOZbVQYEFMrFUU
	ZB9GYQjO3nxEWwVhwQshAbi0WnJtft0XI8eeNgM0vGUYKbNYhRXB7+EEy24r2/A==
X-Received: by 2002:a50:9b4e:0:b0:56b:f2d2:eb8c with SMTP id a14-20020a509b4e000000b0056bf2d2eb8cmr4001984edj.40.1711378461074;
        Mon, 25 Mar 2024 07:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH68YpwfWBvW9gni07CY7AVxgdhlpPWb3L1BY2eMBTbWB0ch8sTsCV/rCb8oe7oK0YESzMMvw==
X-Received: by 2002:a50:9b4e:0:b0:56b:f2d2:eb8c with SMTP id a14-20020a509b4e000000b0056bf2d2eb8cmr4001973edj.40.1711378460741;
        Mon, 25 Mar 2024 07:54:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id y3-20020a50bb03000000b0056b8dcdaca5sm3195919ede.73.2024.03.25.07.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 07:54:20 -0700 (PDT)
Message-ID: <5f07bed0-045b-4576-81ee-c87392846334@redhat.com>
Date: Mon, 25 Mar 2024 15:54:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] platform/x86: wmi: Support reading/writing 16 bit
 EC values
Content-Language: en-US, nl
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240314184538.2933-1-W_Armin@gmx.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240314184538.2933-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/14/24 7:45 PM, Armin Wolf wrote:
> The ACPI EC address space handler currently only supports
> reading/writing 8 bit values. Some firmware implementations however
> want to access for example 16 bit values, which is perfectly legal
> according to the ACPI spec.
> 
> Add support for reading/writing such values.
> 
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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
> Chnages since v4:
> - spelling fix
> - fix checkpatch warning
> 
> Changes since v3:
> - change type of variable i to size_t
> 
> Changes since v2:
> - fix address overflow check
> 
> Changes since v1:
> - use BITS_PER_BYTE
> - validate that number of bytes to read/write does not overflow the
>   address
> ---
>  drivers/platform/x86/wmi.c | 54 +++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 1920e115da89..9602658711cf 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1153,6 +1153,34 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>  	return 0;
>  }
> 
> +static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +	size_t i;
> +	int ret;
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
> +	size_t i;
> +	int ret;
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
> @@ -1162,27 +1190,27 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  			  u32 bits, u64 *value,
>  			  void *handler_context, void *region_context)
>  {
> -	int result = 0;
> -	u8 temp = 0;
> +	int bytes = bits / BITS_PER_BYTE;
> +	int ret;
> 
> -	if ((address > 0xFF) || !value)
> +	if (!value)
> +		return AE_NULL_ENTRY;
> +
> +	if (!bytes || bytes > sizeof(*value))
>  		return AE_BAD_PARAMETER;
> 
> -	if (function != ACPI_READ && function != ACPI_WRITE)
> +	if (address > U8_MAX || address + bytes - 1 > U8_MAX)
>  		return AE_BAD_PARAMETER;
> 
> -	if (bits != 8)
> +	if (function != ACPI_READ && function != ACPI_WRITE)
>  		return AE_BAD_PARAMETER;
> 
> -	if (function == ACPI_READ) {
> -		result = ec_read(address, &temp);
> -		*value = temp;
> -	} else {
> -		temp = 0xff & *value;
> -		result = ec_write(address, temp);
> -	}
> +	if (function == ACPI_READ)
> +		ret = ec_read_multiple(address, (u8 *)value, bytes);
> +	else
> +		ret = ec_write_multiple(address, (u8 *)value, bytes);
> 
> -	switch (result) {
> +	switch (ret) {
>  	case -EINVAL:
>  		return AE_BAD_PARAMETER;
>  	case -ENODEV:
> --
> 2.39.2
> 


