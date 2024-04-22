Return-Path: <linux-kernel+bounces-153452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D338ACE45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D45283175
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A6014F9FE;
	Mon, 22 Apr 2024 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8oE0p4e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231614F13D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792721; cv=none; b=t7xDjY2AisQNjbd40j8Gqqec6H6yMQmiSMWY6WIZcQwIyOtlKVypTLkSSzqcmuLR5D27y7xKetsdVZYEfFc6aLlmT1tHAYjAL2p4iVE2R7u5ZGn477kmQ1ORKOql1sLj6YZq/UzYVoXAxqIEq0gZoNGWzHLDIdjO3ls6s7my29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792721; c=relaxed/simple;
	bh=awX5B76+HzKgX2w5I2DsXCUaJAK/mYe3tND15fSkqMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARH32/FiFCpwcRmVObkH3jr87Bknwmxl8wBiugx5L1RtXQI7u5u/+vOfbNCBCGK6lBQAUEGmsf849Z+57XHqgECvbhdPvtuQW3xGF4Y41DP1z8uArojWI6uZ8VUgDbzIAK+XaknmM5pAJc1OMjCLTCKWACdRAeErw3XILVO23nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8oE0p4e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713792718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANX+xaTgZeaaXkTxg9wkNgDys/2r+xl16Yffp7Qdk4w=;
	b=W8oE0p4e+q2AHpKrGFMa4jIrLVt5fmmg2KobVjK3L/ws9lz6UZLyX/gI1f78zfP9yGBkvA
	OsbrXAHgkb9luLRZeJUGN3B7Ia5x0xqPz7lHbY6LdOu4fPXdNURRrUieVcTUSKn5OLzd+a
	eea2fSZR9coB51Rogp6EiQMmh+XUaiU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Kq-Cp6F-PcuokZSkd0-8rA-1; Mon, 22 Apr 2024 09:31:56 -0400
X-MC-Unique: Kq-Cp6F-PcuokZSkd0-8rA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a5872678bd2so7538266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792715; x=1714397515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANX+xaTgZeaaXkTxg9wkNgDys/2r+xl16Yffp7Qdk4w=;
        b=YvFjdkMe9c9OVWOG9hLioOrStRGX0n7EZmtDVx7OUMN7F9h9XpeREiWv7wDkQkN2hX
         pdpCxPWz2cBq+GH4QjMk8531spP89KULj1TIgDla3LaMFku3KuooWZ3udy/0e7bWpT/d
         5hB+fwNEBxHYhpQ4YF0NQXT50IEOXAda49wLUI2bBb47qFxZgE/hrkM5cxIfsDCGMNee
         AfVJVjQuUq1EgWWaaWJxyiJ0yguolSTsz0T45LEDKh7AsrzO1JpvZfTbAdQf0eLobwWs
         Lr4aF4oMIWNLgAdCCIxwycN5KARjMrpYHHjeOsQPwTVvgbJMswIiZsfLbjsQeLYsJdsU
         H3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPBi5jDCrSvZersvKebOtLaPUaoJmNcltvwrUJh2YWfdoMooNm5KduZRM0E1QGLeKXPa2HPjbznGttAYYuT3rnaWFA9NMGarZOHDbQ
X-Gm-Message-State: AOJu0YxPGuFBe105N8qwo5G7IqUtaFzFNp4FWVAybhFkKvMAeSkDR5S1
	podFkeoz/0s9kG0wFyAIQe1OxrRVaQLdTt+FsSgmqBS39pCkJNPkcrEKD20eGkDW7+ny4ds3bLA
	hWLkw2r3+2PxWC9EjAmDm+e/Q9XTnxz3UmfPBZblQFcoWwV6R6nsWHPGVBeHGmA==
X-Received: by 2002:a17:907:94cb:b0:a55:b272:ea02 with SMTP id dn11-20020a17090794cb00b00a55b272ea02mr2618069ejc.75.1713792714915;
        Mon, 22 Apr 2024 06:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG82ZH8/Jtju0mhAdG8/PW4XqvBdwQxaB7D0jxdPhLmOnBwNV/D0nX8zuy+43rjCw52vpCfaQ==
X-Received: by 2002:a17:907:94cb:b0:a55:b272:ea02 with SMTP id dn11-20020a17090794cb00b00a55b272ea02mr2618055ejc.75.1713792714632;
        Mon, 22 Apr 2024 06:31:54 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170907360200b00a55a8ec5879sm2130351ejc.116.2024.04.22.06.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 06:31:54 -0700 (PDT)
Message-ID: <25965583-4d8a-4e7a-9a2e-83ec2faa4187@redhat.com>
Date: Mon, 22 Apr 2024 15:31:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] platform/x86/intel/pmc: Fix PCH names in comments
To: Colin Ian King <colin.i.king@gmail.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240418215202.879171-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240418215202.879171-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/18/24 11:52 PM, Colin Ian King wrote:
> The PCH names in the pmc drivers are incorrect in the comments,
> fix these.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

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
>  drivers/platform/x86/intel/pmc/arl.c | 2 +-
>  drivers/platform/x86/intel/pmc/lnl.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index 34b4cd23bfe5..e10527c4e3e0 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * This file contains platform specific structure definitions
> - * and init function used by Meteor Lake PCH.
> + * and init function used by Arrow Lake PCH.
>   *
>   * Copyright (c) 2022, Intel Corporation.
>   * All Rights Reserved.
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
> index 068d72504683..ec89e7dda103 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * This file contains platform specific structure definitions
> - * and init function used by Meteor Lake PCH.
> + * and init function used by Lunar Lake PCH.
>   *
>   * Copyright (c) 2022, Intel Corporation.
>   * All Rights Reserved.


