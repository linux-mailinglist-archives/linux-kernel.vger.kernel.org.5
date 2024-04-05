Return-Path: <linux-kernel+bounces-132495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B6E8995DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797201C20DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE3224B28;
	Fri,  5 Apr 2024 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvinfKEZ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DD21CA9E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299882; cv=none; b=BTfCIudh4pwIHPPbAezGyprRd9Mfwm/2I8M+wAJEqsBxtiecubNd+MxyxZ+xtNRqOCbH2kcld76pvPNf2sB638wL/jzC546nVPrpV3GG+dF9KS4FTQ7P340fBUdqy6cCbmMT1l849sihwM4H8BIJN+IQPQv+SAb2+TK8yR6/SFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299882; c=relaxed/simple;
	bh=4oDVAHGYYcR/2l5FlZ2TZi7td9mGan3FkIWef+vpdkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sm6uHK8HTEYKg2JEnoYNK8yMqK7OpH5szYM8JrPwLWnMLWvzl/d6oxb2wI1JuqGuMvTjTbOddPTEBJJk0KfN9nq9MJLh3GjMk/lt/QmksUR1+xD/Ng0F4qqb0TuerTFPEtNW1axznaEvV7WWbHRKd2STIukhPfcRtX4XZc+b5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nvinfKEZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343e986aa6cso41445f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712299879; x=1712904679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/LaVfwoI2Gev4h8pd9kUELtSUqC9s7I3hRen4i8R0o=;
        b=nvinfKEZSzD5YmtTGtIpvZKKTHgnGpX0XmdiKh5nFqaZaDMLbChosTffNZoxAHYnrX
         ubanMps9gVtuK39aUh/RrF+quA+PVDIZwVn953gO1A5IOzFXATyIqTlf8Y6mfJdLU+6p
         6VI3XZPV0yx1sfhraWlEQQSx+KaIO5kHDBUdqN2ZjFTlTTBhSNshFfc8RD5eLWWJQMNb
         kK1yq1bqKScNJ8+G2b4u9HB9vcRR53alY1zs4bTwsZZC1IeROLbf7l0LIWI94SyYjN08
         KPIHPz45W7SIIP87kuybRkIKceALOThTsrBld1tAWqLtxill14E62qvwUhfJJbFY0H7A
         8cCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712299879; x=1712904679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/LaVfwoI2Gev4h8pd9kUELtSUqC9s7I3hRen4i8R0o=;
        b=Acp3aZUVlZVfT37nWDT6DVPdFeb2iRYdr6a74nUWHtAimAEzzWjo/AjJaD4/eTPcC5
         OeBwLI1YUHYU3hhkV2uwo2VJ52GwFjRLJDnnaUf2P6opH1/0mLWepOLQaMHmZmOebhb+
         9oU1vzNlefmRJtwHAUVsjuYG32TJINAlNBwrUFDgfxgBdspmTcN2pvXFu8s4IkKXdmja
         9+yKIDLvf2o1JGiEUAXKMiLtBfNrP7gXPiVol+QY0PehEQEhPbLamtsVXwDjDigCA8X6
         5u4VY/ubO9iBYL45rK0I6jR5frCHIK2Gd0AXcE9l5l21B8PjDumiBvNgxhzwJQgNR3Wj
         nCPQ==
X-Gm-Message-State: AOJu0YwpOrP5rNMOrOsqNp1I4J2Ev5ReJ57TvhTytLA0Dw+W4vzvADsj
	aCamBDpyk41Z3ebtBd6dPx5ZgaPzkNLtDFqoq/2Yi7GArMUd+yGShmv8dXiw6n8=
X-Google-Smtp-Source: AGHT+IEyhPrmjE/oN6EOHsuw0ki2NGJjyj01bnaXLlQUKnVG5zEK9TNydD+65vOAyHQ2YpRh30qzqg==
X-Received: by 2002:adf:f251:0:b0:343:77f4:e663 with SMTP id b17-20020adff251000000b0034377f4e663mr308655wrp.18.1712299879068;
        Thu, 04 Apr 2024 23:51:19 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y16-20020adff6d0000000b0034335f13570sm1211624wrp.116.2024.04.04.23.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 23:51:18 -0700 (PDT)
Message-ID: <e3005e1d-02b8-4e2a-8f83-d6b67de9d4a9@linaro.org>
Date: Fri, 5 Apr 2024 08:51:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: core: Relocate the struct thermal_governor
 definition
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <2725268.mvXUDI8C0e@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2725268.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/04/2024 21:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that struct thermal_governor is only used by the thermal core
> and so move its definition to thermal_core.h.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/thermal/thermal_core.h |   25 +++++++++++++++++++++++++
>   include/linux/thermal.h        |   25 -------------------------
>   2 files changed, 25 insertions(+), 25 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -23,6 +23,31 @@ struct thermal_trip_desc {
>   };
>   
>   /**
> + * struct thermal_governor - structure that holds thermal governor information
> + * @name:	name of the governor
> + * @bind_to_tz: callback called when binding to a thermal zone.  If it
> + *		returns 0, the governor is bound to the thermal zone,
> + *		otherwise it fails.
> + * @unbind_from_tz:	callback called when a governor is unbound from a
> + *			thermal zone.
> + * @throttle:	callback called for every trip point even if temperature is
> + *		below the trip point temperature
> + * @update_tz:	callback called when thermal zone internals have changed, e.g.
> + *		thermal cooling instance was added/removed
> + * @governor_list:	node in thermal_governor_list (in thermal_core.c)
> + */
> +struct thermal_governor {
> +	const char *name;
> +	int (*bind_to_tz)(struct thermal_zone_device *tz);
> +	void (*unbind_from_tz)(struct thermal_zone_device *tz);
> +	int (*throttle)(struct thermal_zone_device *tz,
> +			const struct thermal_trip *trip);
> +	void (*update_tz)(struct thermal_zone_device *tz,
> +			  enum thermal_notify_event reason);
> +	struct list_head	governor_list;
> +};
> +
> +/**
>    * struct thermal_zone_device - structure for a thermal zone
>    * @id:		unique id number for each thermal zone
>    * @type:	the thermal zone device type
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -126,31 +126,6 @@ struct thermal_cooling_device {
>   #endif
>   };
>   
> -/**
> - * struct thermal_governor - structure that holds thermal governor information
> - * @name:	name of the governor
> - * @bind_to_tz: callback called when binding to a thermal zone.  If it
> - *		returns 0, the governor is bound to the thermal zone,
> - *		otherwise it fails.
> - * @unbind_from_tz:	callback called when a governor is unbound from a
> - *			thermal zone.
> - * @throttle:	callback called for every trip point even if temperature is
> - *		below the trip point temperature
> - * @update_tz:	callback called when thermal zone internals have changed, e.g.
> - *		thermal cooling instance was added/removed
> - * @governor_list:	node in thermal_governor_list (in thermal_core.c)
> - */
> -struct thermal_governor {
> -	const char *name;
> -	int (*bind_to_tz)(struct thermal_zone_device *tz);
> -	void (*unbind_from_tz)(struct thermal_zone_device *tz);
> -	int (*throttle)(struct thermal_zone_device *tz,
> -			const struct thermal_trip *trip);
> -	void (*update_tz)(struct thermal_zone_device *tz,
> -			  enum thermal_notify_event reason);
> -	struct list_head	governor_list;
> -};
> -
>   /* Structure to define Thermal Zone parameters */
>   struct thermal_zone_params {
>   	const char *governor_name;
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


