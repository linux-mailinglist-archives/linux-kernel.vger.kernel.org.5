Return-Path: <linux-kernel+bounces-135135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD17B89BB83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B65B24287
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A804594B;
	Mon,  8 Apr 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6auGtrv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2313F9FA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568050; cv=none; b=VX1+/KcinlOL2JwFYm1zgxJHJTzKhHH0Z2jecqevL6YBQHNZ/UDykgeiOq0AVOFB5lqV6rmoNO7ZUaFVUtsitrdg6X3G5nN3CCpghPIGw6qzhcVaxemNUTnNLuKazeJWr2UTQU5EXUB033DlU3L6ldpagLL6GmTwB/FV7+oq5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568050; c=relaxed/simple;
	bh=uICW+mNY3EyrSEYGd3zlsmDxfG0iZhWyhJx+NXP/ayo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3IXAK5uuS0l8Qnv7T9j2psnMq8K60kc8YNHLpnteE4FZiiW8C/kUUv7NNe/ryUgEVgLX9yB4rc/6qRz90E5LxYHV8LldyI+NlNM9fl+NSubXoVn2vzMT3dmvfZCn/nkyo3y2BBYn1TGmlJ+OYwLQ1mr+iB4Ne2VIB4pCZXm74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6auGtrv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712568047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXtEdlF4UoQvZ+64ZfEdPlGWL47TtGijXyBK/aKKQV0=;
	b=H6auGtrvbC03tRBL9xBTr5ok338MLeYY8MjhAVPGofjpO3v3GQghHhxUhIhmCNyZ32+Cqj
	kMvqgGR9jd2X7dN4j77xzXqhjoVspKWr5PvLcpVoKWBC0bfZ/hfsOGWMAQRtzsDugZSEtH
	a/6pG4ZjGrHM/A1cvGoAKyc2v174hBw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-2ny9n-wIMmCksUkPoRMDRg-1; Mon, 08 Apr 2024 05:20:45 -0400
X-MC-Unique: 2ny9n-wIMmCksUkPoRMDRg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a45acc7f191so271788266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712568044; x=1713172844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXtEdlF4UoQvZ+64ZfEdPlGWL47TtGijXyBK/aKKQV0=;
        b=q0PzaAWm8lfoky59KZeya8Dy0fVSeiYhLuoanVO1ohgyqJn2CRU95Fq48RNPiqzflH
         xYqnN5QgSUKbwc+0bGne1Kd8JvvJk/dZo4Azi4RVYQA8hYg2Vlk2SzfHoUbFhIe+YBMJ
         hROUoVYi1J6rlKHvg+x8HzUxPf+5BTymmbvj8xqPKlAELdM88ivVMo1NmD8gnNfkFW+a
         HBJRaAl8V+VU6xO8VP6dxI81NINEpQl3jyI0Lgi4SIdWkUqeUobxukw1lnsg1PsejhPD
         LNZfGraW0ArzNk6XbmQmt+xJf/QeYh4G3ITbYVGRzByLFb/I5DIZThU6jU1dV+F8t04+
         S4RA==
X-Forwarded-Encrypted: i=1; AJvYcCUjdT/PEqaBdtDa/Kklmv8r6/OuPlc9XWIV6OUZGnR6FTfkfKBDbfou7p3yPIrz02PNja6YNQ2BlYYsUFzwu6CC0SdE1KNXDdrj8bku
X-Gm-Message-State: AOJu0YzxWQ2jB/7LMlsI2jkHlmb1LCyChpT76g0hLAmCX7k+I+xrmmJf
	j6MNNmv+psEc/WlQHEFbM6AxhLZ7eZn12DE+n7lh6ec/75rQuHKUWBTVjUGTFb1Vqs4ZDj5VQJW
	6JZboKyCBTP0x0hcQVU6xBZnkfI9NxG4OTjIqFS/uZUxWOGpRsZkVFEyCk/nH+w==
X-Received: by 2002:a17:906:2514:b0:a50:9190:b751 with SMTP id i20-20020a170906251400b00a509190b751mr5880259ejb.10.1712568044181;
        Mon, 08 Apr 2024 02:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHARFE3hVYdjK6ftgphFMP9J3EAhaisQhKehclQ0kly3VquLZBtyeG/nX8FsGt/GOoivRgBKQ==
X-Received: by 2002:a17:906:2514:b0:a50:9190:b751 with SMTP id i20-20020a170906251400b00a509190b751mr5880242ejb.10.1712568043813;
        Mon, 08 Apr 2024 02:20:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906414f00b00a519de61bebsm4205764ejk.137.2024.04.08.02.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 02:20:43 -0700 (PDT)
Message-ID: <bc71ae19-bc6f-4071-bcaa-f4e41ae283e9@redhat.com>
Date: Mon, 8 Apr 2024 11:20:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: quickstart: fix Kconfig selects
To: Arnd Bergmann <arnd@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Henning Schild
 <henning.schild@siemens.com>, SungHwan Jung <onenowy@gmail.com>,
 Ai Chao <aichao@kylinos.cn>, Robert Joslyn <robert.joslyn@redrectangle.org>,
 Henry Shi <henryshi2018@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404123435.2684819-1-arnd@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240404123435.2684819-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/4/24 2:34 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new driver Kconfig entry has a typo that causes a link failure
> when CONFIG_INPUT_SPARSEKMAP is disabled:
> 
> x86_64-linux-ld: drivers/platform/x86/quickstart.o: in function `quickstart_notify':
> quickstart.c:(.text+0x96): undefined reference to `sparse_keymap_report_event'
> x86_64-linux-ld: drivers/platform/x86/quickstart.o: in function `quickstart_probe':
> quickstart.c:(.text+0x1da): undefined reference to `sparse_keymap_setup'
> 
> Select this symbol instead of the incorrect INPUT_SPARSE_KEYMAP.
> 
> Fixes: afd66f2a739e ("platform/x86: Add ACPI quickstart button (PNP0C32) driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ba88a7f259f1..21a37f1b73ab 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -647,7 +647,7 @@ config ACPI_QUICKSTART
>  	tristate "ACPI Quickstart button driver"
>  	depends on ACPI
>  	depends on INPUT
> -	select INPUT_SPARSE_KEYMAP
> +	select INPUT_SPARSEKMAP
>  	help
>  	  This driver adds support for ACPI quickstart button (PNP0C32) devices.
>  	  The button emits a manufacturer-specific key value when pressed, so


