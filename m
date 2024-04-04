Return-Path: <linux-kernel+bounces-132180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C538990FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A769A1C20C73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FBC13C3DF;
	Thu,  4 Apr 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="KrP/LNGQ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2413C3DD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268313; cv=none; b=LuSkrQly3MNg+izu36GSuY1Exy80NEHm3uU/WhbJfW/5DUJ4nKvUqlDOqERue3lg23JtWSmZhvbPsiJUJepphYxVn+s7tJ7t5hiHPOyaH+tjF9Cr2geMjBzTRTLge7p15nkKXhvb8YwnJPi2dhp/vtpFEQnrVMdoSN6zXq0aZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268313; c=relaxed/simple;
	bh=RAKB7kyF0fNWR2j1HvVjKXB7jfD2l116apUdxmo3sY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HGQ4ro96vrlacS1URHuHlINtTTEpCcCjlbRjaLItx+kdid9xKSaTPtSS0HU/HB3EOQ3ed5gsIAFS0WS5DN3LC7Er3jWCCdaQL0bYSyVCoW1j+7LcZISCVYeGl2Sj9GEJHHkufjX46r3DNEa26mFkM0V6pKlVmj1upzD8n3zDB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=KrP/LNGQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecfd29f65dso258133b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1712268311; x=1712873111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sy7266lMQnSMjMFEHXw5ktQWimUH2FejCxx70Ap0ANM=;
        b=KrP/LNGQhd7Dw9kBZp843AucZEHI/olB3247czU3ubZYlfzQfvXgGKCknebPYXEoQK
         A/XfAOs3RK+HRkcdDGrCWxTJbysExh8HHBzie9UsLL5p4Y35DZDYsODknZ3ERxT+VrXe
         s+5SoJ1RaMDPWJhsVXXRX8GXRRvCzGGbnDyq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712268311; x=1712873111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sy7266lMQnSMjMFEHXw5ktQWimUH2FejCxx70Ap0ANM=;
        b=qner+o9uEKJG68WOgq9GOVAugSJT/8pTrQn0Txu5TOAbTec0zz1SRHzeGDuK16UEpz
         s95l+iVhoWy86IhGBpQ6pWnXlTJmUOfLGqNErqASKVbTqNSpGKzZLv+vMOmD+ztMPvTr
         p6XBWLN3XYwZONzCJJYI3p+SIOF0nXqhfLRD2otASJ29d0XSF9/PTA7Gu+Ro1YLl9ksL
         Xw8BiczdlRobZIhRTsZCz+Y9b3TVoovcQrVnhqCAehx/jc+Fwtzs26udb9HDC+0/RfvK
         B0s2x+haYX6hslRqM3TKe+hI3vVtHyp3Z8N78FIqxYmfjRQMNuIR5p1DGCgfheLWSi/g
         lRJg==
X-Forwarded-Encrypted: i=1; AJvYcCVGMFk2mZA9H1ZBeER1ocw2+8t9M1Q4vC/CCvDFAwIs+JTYzbrg7V4+fuNioLRosHoLhZM80lkNHL9wkzBsEf1nIw59TpqFPGS/x5G4
X-Gm-Message-State: AOJu0YzTvgIjo4mcqrWmFdtBRYExIyHXh4967MLd86VS9JWLc8MLfVL/
	SKDgPUdeWJ62edHwV1rj7rdZ3vPJ+brhRZ/f4wSKaTdHAmj+lCiDqgJS3o17s+JwgXxuayOf+50
	=
X-Google-Smtp-Source: AGHT+IE5nA/OpbcSy/r9kgCd3Js80VOlnXWp2HYIjgdhUy7KW36EOroFso0nwx9xB8SpB9KKftjehA==
X-Received: by 2002:aa7:8894:0:b0:6ea:d004:33c9 with SMTP id z20-20020aa78894000000b006ead00433c9mr960813pfe.30.1712268310720;
        Thu, 04 Apr 2024 15:05:10 -0700 (PDT)
Received: from [10.211.55.3] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.googlemail.com with ESMTPSA id j17-20020a056a00131100b006e6b989514bsm139111pfu.60.2024.04.04.15.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 15:05:10 -0700 (PDT)
Message-ID: <658e1f40-d1eb-4ba7-9ba3-0aa05a1ed06e@ieee.org>
Date: Thu, 4 Apr 2024 17:05:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: Clear up precedence for gcam logging
 macros
To: Jackson Chui <jacksonchui.qwerty@gmail.com>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240404001627.94858-1-jacksonchui.qwerty@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240404001627.94858-1-jacksonchui.qwerty@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 7:16 PM, Jackson Chui wrote:
> Reported by checkpatch:
> 
> CHECK: Macro argument 'gcam' may be better as '(gcam)' to avoid
> precedence issues

I agree with your argument about the way the macro should be
defined.  But perhaps these gcam_*() functions could just
be eliminated?

I see 15 calls to gcam_err(), 1 call to gcam_dbg(), and none
to gcam_info().  It would be a different patch, but maybe
you could do that instead?

					-Alex


> 
> Disambiguates '&' (address-of) operator and '->' operator precedence,
> accounting for how '(gcam)->bundle->dev' is a 'struct device' and not a
> 'struct device*', which is required by the dev_{dbg,info,err} driver
> model diagnostic macros. Issue found by checkpatch.
> 
> Signed-off-by: Jackson Chui <jacksonchui.qwerty@gmail.com>
> ---
>   drivers/staging/greybus/camera.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index a8173aa3a995..d82a2d2abdca 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -180,9 +180,9 @@ static const struct gb_camera_fmt_info *gb_camera_get_format_info(u16 gb_fmt)
>   
>   #define GB_CAMERA_MAX_SETTINGS_SIZE	8192
>   
> -#define gcam_dbg(gcam, format...)	dev_dbg(&gcam->bundle->dev, format)
> -#define gcam_info(gcam, format...)	dev_info(&gcam->bundle->dev, format)
> -#define gcam_err(gcam, format...)	dev_err(&gcam->bundle->dev, format)
> +#define gcam_dbg(gcam, format...)	dev_dbg(&((gcam)->bundle->dev), format)
> +#define gcam_info(gcam, format...)	dev_info(&((gcam)->bundle->dev), format)
> +#define gcam_err(gcam, format...)	dev_err(&((gcam)->bundle->dev), format)
>   
>   static int gb_camera_operation_sync_flags(struct gb_connection *connection,
>   					  int type, unsigned int flags,


