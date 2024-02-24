Return-Path: <linux-kernel+bounces-79640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0777C862518
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5BA1C21147
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6873F9C6;
	Sat, 24 Feb 2024 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TAEC4+a4"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036828E3C
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708779137; cv=none; b=O+Xw/csPdmW1/mCyi2WG+0GtQMyM203lKFMkDhZQiWHZgC3GI1jsconOB5DzjOazaflyZiTYoN4v9TsKER6isIWDngFS40pyfpE0SZ+CEvazkiGj0V1u3ySlnJycp03fMIDx0EQjK57HJKCrcU8ryPdfLXiWaWb0vcO43lw2j4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708779137; c=relaxed/simple;
	bh=IxKmzHbKURU66+Gq8LhlzaiwqGSFQlc9MB2J49I73Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGR4BNAVhGguDXdpK/Va1ZKWompyG9ihWGXnhEJtE0GfVNUztN1GxGkUbA8EeTI3dM21UjLpg6+mZ0ekbAQnlsJM7xW2jsjiSnq7TVOo0HFyOiiZkLs9PJwbvmDJ/RTnPbx/3FTN2QRJeKbNMdfFgShj3L2zYI/8VkaJzlnpQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TAEC4+a4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512e39226efso2343726e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 04:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708779134; x=1709383934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xI5sCcxvIw+wCH0k/MFKMsnG/9USCpJCifLHFTbuCDA=;
        b=TAEC4+a41g2uT19m0TuF5BkVXWAAUlEELiUqnMbYX1v1e8fYeQSBnsZlvTRo8mWPQn
         tQCwSDPc795z6mYCBqLwn6VZQ2dhAe/0ztOzpLWTB3ZXvguGiLMh4iUxHAoBkvMshPAD
         v1GpgCl4mdOdIxfokrykXrYwGhpIyeDFkOgsLq8MrkZu7PIwifK4nKbZyn/EJkxWTImv
         BpYtr0KVnCSdh+Ge+/jUH70pe6SNmV7uYLLRwQozf8o5gL7reruMZ2hDabRIFY2j6can
         tHTN+e2w5p7UmjSkDkXzXRmUeSzbdyzTs0ShgMuln0cUjgOAaCeAcIIo8FcckIl4uyQu
         usAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708779134; x=1709383934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xI5sCcxvIw+wCH0k/MFKMsnG/9USCpJCifLHFTbuCDA=;
        b=bA2jr9L+Hb5tw0nGQRzmauQnwbvGMzHZ9/4JbHVCRArEnKxNDCg9W0m4P4vCBfnwik
         zZ5AIPFUpif1ODBsQy2ZI75FF5DsdG4oJuZGihwceRHaGKwJ703koz3JHvnJA3zMH6CM
         V31/HU3PQFn8qPLOaqkpm3V06964eECG1TjhzJvegvLPNyW+qkpTMO3jp7trlw4FoUMR
         SVcToMUbv7StyR7+MUGxoO8xUpMQbcSZH1y1DwNVHZbHl51LMmeUUKEeQjXHYWbzF2Hl
         pjCZMI6BXXD0gVkNeT0iPLIZSg/FjGIIAJIlmgQs+vorV8o9QWcNrUW0FfXqu9QIcCOH
         wN8w==
X-Forwarded-Encrypted: i=1; AJvYcCW60cbg0q0V3JXdBp8btC4deNeF8DsiDn7MQ2jD8WqmTJI437OeHtfze1uCclkcuD7QW0y9XvtTlK0HaZE9fRLFK6HzaFr2LrjStixO
X-Gm-Message-State: AOJu0YzMupS+WvH8hN/RvNMeHD3hpBcNoo87GHAowuwZyOzzwqiIoC/J
	Sn7TTfkmVxANH2gAqM3YFtIqkMpjvSiQgJJiUqBHIAFHuejVmg5XbYhgvPjBJnI=
X-Google-Smtp-Source: AGHT+IGvClWG427ReM6uDzldJ1NsnDu1SHQoKbXcHviUsK2l0V7b81cRm9OVaIDAvJAINZBAsFBQFQ==
X-Received: by 2002:a19:6545:0:b0:512:bdd3:150d with SMTP id c5-20020a196545000000b00512bdd3150dmr1384907lfj.52.1708779133698;
        Sat, 24 Feb 2024 04:52:13 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.99])
        by smtp.gmail.com with ESMTPSA id nb18-20020a1709071c9200b00a3e45a18a5asm564678ejc.61.2024.02.24.04.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 04:52:13 -0800 (PST)
Message-ID: <b5d9b028-4a1e-4bbd-9572-290b0042afdc@tuxon.dev>
Date: Sat, 24 Feb 2024 14:52:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] Add support for XLCDC to sam9x7 SoC family.
Content-Language: en-US
To: Manikandan Muralidharan <manikandan.m@microchip.com>, sam@ravnborg.org,
 bbrezillon@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, lee@kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Hari.PrasathGE@microchip.com, Balamanikandan.Gunasundar@microchip.com,
 Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
 Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
 Balakrishnan.S@microchip.com, Charan.Pedumuru@microchip.com
References: <20240221053531.12701-1-manikandan.m@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240221053531.12701-1-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Manikandan,

On 21.02.2024 07:35, Manikandan Muralidharan wrote:
> This patch series aims to add support for XLCDC IP of sam9x7 SoC family
> to the DRM subsystem.XLCDC IP has additional registers and new
> configuration bits compared to the existing register set of HLCDC IP.
> The new compatible string "microchip,sam9x75-xlcdc" is defined for sam9x75
> variant of the sam9x7 SoC family.The is_xlcdc flag under driver data and
> IP specific driver ops helps to differentiate the XLCDC and existing HLCDC
> code within the same driver.
> 
> changes in v8:
> * Re-arrange the patch set to prepare and update the current HLCDC
> code base with the new LCDC IP based driver ops and then add support
> for XLCDC code changes.
> * Fix Cosmetic issues.
> 
> changes in v7:
> * LCDC IP driver ops functions are declared static and its 
> declaration are removed.
> 
> changes in v6:
> * Fixed Cosmetic defects.
> * Added comments for readability.
> 
> changes in v5:
> * return value of regmap_read_poll_timeout is checked in failure
> case.
> * HLCDC and XLCDC specific driver functions are now invoked
> using its IP specific driver ops w/o the need of checking is_xlcdc flag.
> * Removed empty spaces and blank lines.
> 
> changes in v4:
> * fixed kernel warnings reported by kernel test robot.
> 
> changes in v3:
> * Removed de-referencing the value of is_xlcdc flag multiple times in
> a single function.
> * Removed cpu_relax() call when using regmap_read_poll_timeout.
> * Updated xfactor and yfactor equations using shift operators
> * Defined CSC co-efficients in an array for code readability.
> 
> changes in v2:
> * Change the driver compatible name from "microchip,sam9x7-xlcdc" to
> "microchip,sam9x75-xlcdc".
> * Move is_xlcdc flag to driver data.
> * Remove unsed Macro definitions.
> * Add co-developed-bys tags
> * Replace regmap_read() with regmap_read_poll_timeout() call
> * Split code into two helpers for code readablitity.
> ---
> 
> Durai Manickam KR (1):
>   drm: atmel-hlcdc: Define XLCDC specific registers
> 
> Manikandan Muralidharan (6):
>   drm: atmel-hlcdc: add driver ops to differentiate HLCDC and XLCDC IP
>   drm: atmel_hlcdc: Add support for XLCDC using IP specific driver ops
>   drm: atmel-hlcdc: add DPI mode support for XLCDC
>   drm: atmel-hlcdc: add vertical and horizontal scaling support for
>     XLCDC
>   drm: atmel-hlcdc: add support for DSI output formats
>   drm: atmel-hlcdc: add LCD controller layer definition for sam9x75
> 

Only minor comments from me (check individual patches). W/ or w/o those
addressed you can add:

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>


