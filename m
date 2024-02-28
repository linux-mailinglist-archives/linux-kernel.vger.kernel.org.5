Return-Path: <linux-kernel+bounces-85324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB0786B437
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9211C223E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6740615D5D3;
	Wed, 28 Feb 2024 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+SXQoP4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D915D5CC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136548; cv=none; b=igNmYfVgxGN18iIqbuia9nWHhztuE/20Ei8friu4b/aXyUErjwUBfAVVQEwx/nAK0T2RVtsh2hLv5pLU3fY5lTCygNeFo3sryU480l5ImlMrJKEDiGB9B2LhpTRq/nzKI7J+79e+GRfGbIbO+yNJ4t8f/T8eFYp7VZ4sxvuclls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136548; c=relaxed/simple;
	bh=p8Bv08NMy9sxlY2HjMBQCRLqLvoSLxLbo1AYBtEKC5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fc7xDucvaZqA9CKLrpCRon78kOJIGwazlTF5NtTlrB9v34zXxyIYlqQR7Z5ZRg1h8hDHjTTvZ4GRiSwwQ5II+CSJ2GOvHAx5m3XBbi0/a+YKPbeV5oDfLUokKRw7bWLyZVVqo8Ii/j2sRmhX6DHHlbVnz6h1D3pB3ArYuBe5nJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+SXQoP4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709136545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAyUNcJj+Jv2s8topw4mPSfaGyXkk/RXpTh+ahzl1vE=;
	b=N+SXQoP4oSKJh3M8kr3+wckUvHmy55DybAG4RGVBEbWKU5YTBkfjmJq0cWSxY7iblpj+Ex
	ajD44wlpZCXlvzHe0p8EqmQhUj6eaxwNYd9hfmLnrAuJBttaNJIGff12RHQSpE5GdfJEc8
	Z1If9D53gYDWEaao1/iCCWZ6zT+aEZE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-AA4V5WiFP2KeXolwDJBuxg-1; Wed, 28 Feb 2024 11:09:04 -0500
X-MC-Unique: AA4V5WiFP2KeXolwDJBuxg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-563df53b566so3026603a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136542; x=1709741342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAyUNcJj+Jv2s8topw4mPSfaGyXkk/RXpTh+ahzl1vE=;
        b=hc9Od3TzQc56uRa0zQpPBUrSofc2t0uuZPPxTcZqhLqcZKMrOsEVWv6opL8n0lx27+
         wLAXmv+Fa4+Ua3xb8ozoHan1VlCqTMSz7J0s2QUVvI8C3n0HSVzVI6QJS2KFYDvOebxp
         bLjR9zZqSYcX0NNabqzbK3eTr30lehZtx7op7AC6mTIN/OeLk41JiR3edHhDX1KPEMUk
         DSt9+LoKL7HkinFALpEG/h+kHyTVipf4o6uRCk3VmDgYWIuQMVLgvw8smZ369BqQlBG2
         K4mC3Msv5I1mttd4/9q2Vr7NlNrYIFz+rhvwmVeO+lkdoU6xhGpdLzxw8Cx0Frp2vWZ7
         SMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPz3qf1UqFS1nP8Ad20SxB9503nQcutK0/9178JX+RYo9CCU3+Tl52JlnoC7MMywkcvvNv2WLideC6UNtrw0pVvBx/1XILeLaGh1wS
X-Gm-Message-State: AOJu0Yypmmk+kDkdSZZJeJ/FdNrL+tN0A7UmC+yyzJKcv8q1c2aBPG3Q
	bvVUrHfdK6kvOkVFZG2te8oIwetA7sdRGXdiHpWflfiLRfSQ6RkEgF8PGRaOpoc1ggOnhViOuTb
	5CfuYb1KtrSeEUobd49aG4EMKFpjisHOCulrTZKkccoVtKHCgWcFXl7pTwVXs+tKWsrsUVA==
X-Received: by 2002:a17:906:5785:b0:a43:f927:4432 with SMTP id k5-20020a170906578500b00a43f9274432mr83545ejq.77.1709136542624;
        Wed, 28 Feb 2024 08:09:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN5X+9gPveSPQSNtChI79j146rrgKC29HhYTxSYDo7S+hGwkWR0WsTFq+h1lWoDOQd9r8Ezw==
X-Received: by 2002:a17:906:5785:b0:a43:f927:4432 with SMTP id k5-20020a170906578500b00a43f9274432mr83527ejq.77.1709136542351;
        Wed, 28 Feb 2024 08:09:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hk8-20020a170906c9c800b00a3db46018a4sm2010052ejb.71.2024.02.28.08.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:09:01 -0800 (PST)
Message-ID: <d6d0806e-5b5d-474c-affa-d43d88785275@redhat.com>
Date: Wed, 28 Feb 2024 17:09:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add more ThinkPads with
 non-standard reg address for fan
To: Vishnu Sankar <vishnuocv@gmail.com>, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca, vsankar@lenovo.com
References: <20240228150149.4799-1-vishnuocv@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240228150149.4799-1-vishnuocv@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/28/24 16:01, Vishnu Sankar wrote:
> Add more ThinkPads with non-standard register addresses to read fan values.
> 
> ThinkPads added are L13 Yoga Gen1, X13 Yoga Gen1, L380, L390, 11e Gen5 GL,
> 11e Gen5 GL-R, 11e Gen5 KL-Y.
> 
> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>

Thanks, I have no objection against this patch:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

But this feels like it will become a game of whack-a-mole.

Mark can you reach out to the ThinkPad firmware team and
figure out if there is some supported way to automatically detect
this ?

Regards,

Hans



> ---
>  drivers/platform/x86/thinkpad_acpi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 5ecd9d33250d..23b2abe44a5a 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8767,6 +8767,13 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_Q_LNV3('N', '3', '7', TPACPI_FAN_2CTL),  /* T15g (2nd gen) */
>  	TPACPI_Q_LNV3('R', '1', 'F', TPACPI_FAN_NS),	/* L13 Yoga Gen 2 */
>  	TPACPI_Q_LNV3('N', '2', 'U', TPACPI_FAN_NS),	/* X13 Yoga Gen 2*/
> +	TPACPI_Q_LNV3('R', '0', 'R', TPACPI_FAN_NS),	/* L380 */
> +	TPACPI_Q_LNV3('R', '1', '5', TPACPI_FAN_NS),	/* L13 Yoga Gen 1 */
> +	TPACPI_Q_LNV3('R', '1', '0', TPACPI_FAN_NS),	/* L390 */
> +	TPACPI_Q_LNV3('N', '2', 'L', TPACPI_FAN_NS),	/* X13 Yoga Gen 1 */
> +	TPACPI_Q_LNV3('R', '0', 'T', TPACPI_FAN_NS),	/* 11e Gen5 GL */
> +	TPACPI_Q_LNV3('R', '1', 'D', TPACPI_FAN_NS),	/* 11e Gen5 GL-R */
> +	TPACPI_Q_LNV3('R', '0', 'V', TPACPI_FAN_NS),	/* 11e Gen5 KL-Y */
>  	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
>  };
>  


