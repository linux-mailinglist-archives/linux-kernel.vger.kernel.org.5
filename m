Return-Path: <linux-kernel+bounces-89477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 589EF86F0DD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5202840B0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962F18643;
	Sat,  2 Mar 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="ATzL9mNS"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA364182C5
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709393504; cv=none; b=eHRQ64QWi4A0sfVDy66pDtz+W+DjC2EYt2NiIZ8HrsHfoK5rGOgtE7nk36Fj22Dx6Hr8DBWz05Sa2gtdCh53lq/vcZRXiLX4gOkDTIxjFtsvakAGFKtK4ahs1pfmDu/Ke0Lk4M6d1r0zLvrYSPBGSLYOWk6KxORmvdYmlJOiGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709393504; c=relaxed/simple;
	bh=+v4yvN0kxUI9tPDM9nvpiiOzpOQi8oxzkIuHiqx0jYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrmBjM9dTIRjyhqHzGQ2jKVv9/mxfHEq8NSzGAZ3uSbC5wxhV6gQ01pqkx5cfpuNGrp3GgweEKFL2U0uHg/PzMUcWh1XVMN1BGD8CU+nS82pIYP0zw6oXKI9uLJyCHW9eDr9Xqz1RcMpyIG2OqSj9AkRmKelkhdSjKN3X9RqS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=ATzL9mNS; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c8395e24fbso20952839f.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 07:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1709393500; x=1709998300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pcwS+vAT2fwsjgoSR/yvl2URHCxzURia5C1neOopGqY=;
        b=ATzL9mNSR5xwP4h409FTm4sMxEbW4NcIIHWT7osyWzs4tZo41TvmDjn3QcdIPWqffF
         VpZ9Ufh5FxYc9bNOFbsVGloPf886Rk4vcLwJ4BwPE4LQO8PLiLWcdMVt2RagzYC568lm
         waMfv+Mf3wboZsDrppeAxEl99lbi0TBFJk1B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709393500; x=1709998300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcwS+vAT2fwsjgoSR/yvl2URHCxzURia5C1neOopGqY=;
        b=gd21tFuxdS4vuEb+RFBRuGIvYZNoI5Rb5MajuQua+b9Sz8ofIryIK/35o1zRQIUCFU
         U0u0tuK52NieAqsjyju9ktXdQcr8Y5rAPDbNxQ6LKJNjcHK9W59gorwS1dfzeBhrX/vh
         0kbita4JD0qWpG6JvtnIHDBQ7zLiU3LIXHfC2KgO7HVV2kc7nJ2AZ4vg//w8o4Amp48X
         98yN4fX9niQR8XYSgPpWDy9onIJXgaWtYmNTrZcj5ZoJCQMNeq0vErDpMGTLUbykAcjG
         hYHOi9CIeFIz/Wg1zv+Md+4no22V0OB85BxhfYtb7am9vt+qAjQKVVFQOh+cdJLjpg1O
         SGCg==
X-Forwarded-Encrypted: i=1; AJvYcCWC1sUS/7jiCjObFVg+QQAuqfXJYGrT5MQi39K7hwNUamyRLHUgQrXU0pzxOBzqsqL3Jmbm7j0daSYVT/bPiL9EIaEzcSypUrGV261r
X-Gm-Message-State: AOJu0Yy5HivJhX5VX4Xa9e7qSI+s48iRhmkNuleq86/TCbJKtkaLjfUe
	Sg/AuCY0MbMOn5/e1TyG/6/4JbtPNogwLdx2u7+/Zg/HRJRgR0fHHmEh+lcnrQ==
X-Google-Smtp-Source: AGHT+IEBv+JTa8wk1BLmy4gNLO1GkrEgOLNKogq6t7WnUC0e929OVeUuFvEzgQyds5sDteHCjN1p8Q==
X-Received: by 2002:a5e:a810:0:b0:7c7:f6ac:cb4 with SMTP id c16-20020a5ea810000000b007c7f6ac0cb4mr4979742ioa.3.1709393499975;
        Sat, 02 Mar 2024 07:31:39 -0800 (PST)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id s7-20020a056602168700b007c7ab36d3ffsm1438960iow.43.2024.03.02.07.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 07:31:39 -0800 (PST)
Message-ID: <07df4b96-70c2-41de-9d76-1deb80447a79@ieee.org>
Date: Sat, 2 Mar 2024 09:31:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [greybus-dev] [PATCH] greybus: Fix deref of NULL in
 __gb_lights_flash_brightness_set
Content-Language: en-US
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
 Rui Miguel Silva <rmfrfs@gmail.com>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 1:04 PM, Mikhail Lobanov wrote:
> Dereference of null pointer in the __gb_lights_flash_brightness_set function.
> Assigning the channel the result of executing the get_channel_from_mode function
> without checking for NULL may result in an error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

I think this is an actual problem but this might not be the
right fix.

The point of the call to get_channel_from_mode() is to get
the attached torch channel if the passed-in channel is a
flash channel.  It's *possible* that any flash channel will
*always* have an attached torch channel, but if so there
ought to be a comment to that effect near this call (to
explain why there's no need for the null pointer check).

I think Dan's suggestion should be implemented as well.
It's possible the intention really *was* to have
get_channel_from_mode() return the original channel pointer
if there is no attached channel with the requested mode.
But if so, that should be done differently.  I.e., Dan's
suggestion should be taken, and the callers should use the
passed-in channel if the call to get_channel_from_mode()
returns NULL.  (I hope that's clear.)

So anyway, I think this (and Dan's suggestion) should be
addressed, but your fix might not be correct.

Rui, can you please shed some light on the situation?

					-Alex

> 
> Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
> ---
>   drivers/staging/greybus/light.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index 87d36948c610..929514350947 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -148,10 +148,15 @@ static int __gb_lights_flash_brightness_set(struct gb_channel *channel)
>   						GB_CHANNEL_MODE_TORCH);
>   
>   	/* For not flash we need to convert brightness to intensity */
> -	intensity = channel->intensity_uA.min +
> +
> +	if (channel) {
> +		intensity = channel->intensity_uA.min +
>   			(channel->intensity_uA.step * channel->led->brightness);
>   
> -	return __gb_lights_flash_intensity_set(channel, intensity);
> +		return __gb_lights_flash_intensity_set(channel, intensity);
> +	}
> +
> +	return 0;
>   }
>   #else
>   static struct gb_channel *get_channel_from_cdev(struct led_classdev *cdev)


