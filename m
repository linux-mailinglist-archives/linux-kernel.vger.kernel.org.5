Return-Path: <linux-kernel+bounces-162103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB38B55DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E21F1F230E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBE93A8EF;
	Mon, 29 Apr 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwvLdH+I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295222EEB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387948; cv=none; b=S1W1R7ehZ5YHl70Uk21406Pdw87Y0meMbuJHNaQL54HfAAm9v5bCeapv3WMMLz+iSBx6wb8R8Anda512SZ6LNeusJ9OBStX5kmkJ2m5HKEALTGj87VQPVNnj5u89Vdxi3etK4pcVwVnoFbeNRGv1SoGB02Bzt7Ay0lTCAxJXaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387948; c=relaxed/simple;
	bh=bbxnpi/NaXr0e5sWNyBNj5+TVIxN+ODPhN6bNk2paHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QramRPcEV8rBo6KtrMxZzSbLYtPZ78QIJgmE/yVa8QGkQsgsF/tm1zINqM5XLBwMsSb5Ppo+GEHGswuc6jDcruBqi8FeqzowaAZRWtO7VumTdDKYcmEHv3fZxJLH0sJN/kTS9FzGZQJjsFx1CV6ElmPt2L4KAxxnzrKu2K3arn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwvLdH+I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714387945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWr2wFFYDefmCv3FctymID7mRGnXleZS4K7sde3WKUs=;
	b=TwvLdH+IERfPdEYngcPN8O68/WLb4Nbss0QlIPPUyHWeRs05mQ40StIGo7sSd4T2bLTgaQ
	/3dT+VVA/Dshn3xCrbHiiakq/s7TYVkrrutGFr6JAv93u29tqEY84zKaNmpUGCAvbGqcwp
	QsaLjS2nrEseWt/AILNWMYgGm0Q6F6c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-mrgAt7IEOJKKfKrJclVsxw-1; Mon, 29 Apr 2024 06:52:24 -0400
X-MC-Unique: mrgAt7IEOJKKfKrJclVsxw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5193fab7e5so284733066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714387943; x=1714992743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWr2wFFYDefmCv3FctymID7mRGnXleZS4K7sde3WKUs=;
        b=BGKyOWI0bTvplzv/bnxY8Z8An8nOxybjVzlw6/kM+e8RFeVfFBADx2RFP7JUL+F0xu
         xdaGL6+QOS82Hm/FzLXlbaS7lxHWel4d5a1wR18t63BGRcPxMPxslaMRv5zIWDHesAQI
         WClswQn5ykpMXWi8n8diSJWr2QkHhDJ5/idu+1fuX7poAvmti8ZJsWDDJk7JZBW7LsmP
         wfRcBsYK8H68uMWNt4uSurKoJGK5aXvwfNBpyY8+4Htdc/BSatQEkOVAWJF1uqhtzdnc
         6S8PxpFWR1O4D8iYyLCyC0vcU1WKzS3gjqQwepPHdPHiRtNBje7eKvTvaNZ0t8QkMJpt
         ALhw==
X-Forwarded-Encrypted: i=1; AJvYcCUE5xq2oao4Z6R+KUKacWCERR4l6z+8AKKSNbnOqGw2dO6J7BIEWS/2v3u3w99rfaPIVAlbS66Pz1AzvnVS5WHrLNdM//tiDcOTUibb
X-Gm-Message-State: AOJu0YxReT7vZyhYtV6ktj7p/MwhKa1ULw0ImjADw/Q3moIbQe34WmSr
	rSCTOUWfaAPyn49Jte+RaaZ88JheJ8kInJfvobeGspruknoYODtegZuna1TRvV77CtQ93Ny43bJ
	qECft8dGHguLSdqxaVsyHV/m/DCL7dJwRYX59P5E+uTYdwP8Tl7zOCcTJeWF08A==
X-Received: by 2002:a17:907:7790:b0:a58:7e00:255e with SMTP id ky16-20020a170907779000b00a587e00255emr6364072ejc.30.1714387943493;
        Mon, 29 Apr 2024 03:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExSZaaBtowGRGzWVJrdBhegNqFQKtr6Khu4CbRXHOHx2JpLPwVBuThxMf+b0m0087QT8rDew==
X-Received: by 2002:a17:907:7790:b0:a58:7e00:255e with SMTP id ky16-20020a170907779000b00a587e00255emr6364066ejc.30.1714387943196;
        Mon, 29 Apr 2024 03:52:23 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id j25-20020a170906279900b00a58e170f175sm2972047ejc.63.2024.04.29.03.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 03:52:22 -0700 (PDT)
Message-ID: <6a87e669-d45e-436a-9570-d07658b5b5e8@redhat.com>
Date: Mon, 29 Apr 2024 12:52:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] platform/x86: classmate-laptop: Add missing
 MODULE_DESCRIPTION()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240423161108.2636958-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240423161108.2636958-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/23/24 6:09 PM, Andy Shevchenko wrote:
> The modpost script is not happy
> 
>   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/classmate-laptop.o
> 
> because there is a missing module description.
> 
> Add it to the module.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
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
> v2: alinged text with Kconfig entry (Thadeu Lima)
>  drivers/platform/x86/classmate-laptop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
> index 87462e7c6219..cb6fce655e35 100644
> --- a/drivers/platform/x86/classmate-laptop.c
> +++ b/drivers/platform/x86/classmate-laptop.c
> @@ -13,8 +13,6 @@
>  #include <linux/input.h>
>  #include <linux/rfkill.h>
>  
> -MODULE_LICENSE("GPL");
> -
>  struct cmpc_accel {
>  	int sensitivity;
>  	int g_select;
> @@ -1139,3 +1137,5 @@ static const struct acpi_device_id cmpc_device_ids[] __maybe_unused = {
>  };
>  
>  MODULE_DEVICE_TABLE(acpi, cmpc_device_ids);
> +MODULE_DESCRIPTION("Support for Intel Classmate PC ACPI devices");
> +MODULE_LICENSE("GPL");


