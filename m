Return-Path: <linux-kernel+bounces-112714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C71887D41
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6081C20A0F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3323A1862F;
	Sun, 24 Mar 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc3z7nY2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBE182DD
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711292137; cv=none; b=i/HMAiSWa9KfuKLNMSwTaWAzUgdMsBbSd/3rz/9JyIqJLdjFIWUvj0hnnKLCml+xp9YbsFamn8NyCV7+wU+qxjl5t8bE5NqmoHf2sJSvqaV+ApW27KrswPH6zseg0USJ4py3sD3M+vikQ6RyHvbqArUU9SPkb6kpRuMe0OCIP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711292137; c=relaxed/simple;
	bh=WJoWst2zWLDtp8+Lu77pigv3C7PxlCT5Xd4GOWz6EAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ky3Po0LeV+/a/7H9Vde7vzgL0u0TL115X2BaC0dykMCBkg+yhNQCsL3oWFKrRI5Dk69hc5u70mGogbLpewg2Auas+VbYK/nqUdvpdkKNlbl7ymz2uU41nyyDDJwE1EIZ0fOK/NlJgqOzZDfYEQW9QzX0dj3x0rIxdcIeBziSdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc3z7nY2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711292134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoWkPYMgfn83U/WIpgmkyv2XVlLKQD/eNN6maIkW/vQ=;
	b=Sc3z7nY2vGH2OPvjt+4JVjMiZ3oc3RBtcfVtsqifi5jnn8o2nydGQE7E40ezJjOTlq5Cft
	bT7tl0XkIrKbhXLazWmxcx+4HU8LlRHUN9gP5YIHvXyH8urA1SdwBTO5ZgYDaFm3c6qfim
	rD4t5bTeBqra5DIVMzWCqYdupFGUszA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-FsLH7DepPiSjSS8uf8C9vQ-1; Sun, 24 Mar 2024 10:55:33 -0400
X-MC-Unique: FsLH7DepPiSjSS8uf8C9vQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a4921e09cebso14613466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 07:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711292132; x=1711896932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoWkPYMgfn83U/WIpgmkyv2XVlLKQD/eNN6maIkW/vQ=;
        b=kGRfr8al0WrhkWOxN6Qf8sSBJxfQoc3eVkA/T41SPgz1/rF7eWD+X1eSId4goqZFzV
         u/esXXukUXpMls1s2XXasdWdjnZdOgkK/NNIl118YDH9T9sGJ9LoNrCYlvW9T5xG5mrV
         lDhu0pkrMzbdDW3bIFf64ar6j8yZcvurbW92fC0UL+yE6PSSdZ4O3XbqynLRmhmSUMRB
         bTsfNbWIHwFhgBoIfKfNPTT+hqRSZuKKSwZ0rO1jpzCUNsvFzxlX4bXL2FRqpkkbyEBp
         LnnkMBKxUi3SNHJ2IniFryMZfssFAntaBY2dw89pUiwIK2FPcsQhNavCoExHW1SjrFiR
         1fIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuwnKv1APZXBVvzwVf1yT+m+NlMs2peK20Ad3mMtFhvllLjZJWVVA8aqBPHgrsAxCnaEETA5XlsiC9JUqlCHFnx/O/NpZ7sUXeGOhG
X-Gm-Message-State: AOJu0Yw5O0uJB6B2GE5IcdJgF9c2Jy43TLZjiKnYMZx4AbYFQSMksX71
	XSHjJTzI9XFUHgNf01Puo3GOjIuiX/DNeyoX9j964zEkvervxGa0ZgdGBuX6oJJf9v4KgR/PEQ6
	gr1Yq44bRLeRK6uvfI98zOwcHZY03J6IUq8fYoqcHJQlPcYmiisogZBBlELiMmA==
X-Received: by 2002:a17:906:110d:b0:a46:967b:7c94 with SMTP id h13-20020a170906110d00b00a46967b7c94mr2972935eja.18.1711292131902;
        Sun, 24 Mar 2024 07:55:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxZZIYrtutRgtQNAdaEoOkVNvYIb+8XyS6Fs70snfoHYWImMZPXg0HmOlQNNF4auSy32WHxQ==
X-Received: by 2002:a17:906:110d:b0:a46:967b:7c94 with SMTP id h13-20020a170906110d00b00a46967b7c94mr2972924eja.18.1711292131571;
        Sun, 24 Mar 2024 07:55:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709062b4200b00a4725e4f53asm2031403ejg.40.2024.03.24.07.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 07:55:31 -0700 (PDT)
Message-ID: <c1b08bbb-ad57-4f41-9b7b-40a6aeb3da9b@redhat.com>
Date: Sun, 24 Mar 2024 15:55:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: Add ACPI quickstart button driver
Content-Language: en-US, nl
To: Armin Wolf <W_Armin@gmx.de>, dennisn@dennisn.mooo.com, lkml@vorpal.se,
 ilpo.jarvinen@linux.intel.com
Cc: coproscefalo@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240131111641.4418-1-W_Armin@gmx.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240131111641.4418-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Armin and Arvid,

On 1/31/24 12:16 PM, Armin Wolf wrote:
> This patch series adds support for the ACPI PNP0C32 device as
> proposed in 2022 by Arvid Norlander. The first patch adds support
> for the device itself, while the second patch was taken from the
> original series.
> 
> Both patches are compile-tested only.

Armin, thank you for creating a new cleaned up driver for the
quickstart button support.

I have managed to get my hands on a Toshiba Portege Z830 and
I have successfully tested this series. That is this makes
the 2 quickstart application and the toggle-touchpad button
work when the system is running normally.

Neither the quickstart buttons, nor the touchpad-toggle button
which also uses the PNP0C32 interface, work to wakeup
the system from sleep though.

I've also review both patches and they look good to me:

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

So I plan to merge this series into pdx86/for-next once
6.9-rc1 is out.

Regards,

Hans



> Armin Wolf (1):
>   platform/x86: Add ACPI quickstart button (PNP0C32) driver
> 
> Arvid Norlander (1):
>   platform/x86: toshiba_acpi: Add quirk for buttons on Z830
> 
>  MAINTAINERS                         |   6 +
>  drivers/platform/x86/Kconfig        |  13 ++
>  drivers/platform/x86/Makefile       |   3 +
>  drivers/platform/x86/quickstart.c   | 225 ++++++++++++++++++++++++++++
>  drivers/platform/x86/toshiba_acpi.c |  36 ++++-
>  5 files changed, 280 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/platform/x86/quickstart.c
> 
> --
> 2.39.2
> 
> 


