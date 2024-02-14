Return-Path: <linux-kernel+bounces-66114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A928D855725
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB231F2C710
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF981419A6;
	Wed, 14 Feb 2024 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6aEcaMv"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96865191;
	Wed, 14 Feb 2024 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952727; cv=none; b=EXp3wfeYlz7XAfZTS5PA++YFf+2BMLA7qJwUckxbka8p0bnAoIKBfKVYZf2au+3ZgES3WXrEJ/jxmm2366mmPsClwQefcXs5ndJ1eZoSp/dI456xbzBUyPQyTzbOWkdSITmAfU5P1KAcVXrCuWbpR6VGyEmxO4ye2hCbnc4IOE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952727; c=relaxed/simple;
	bh=VGJIwjorLZIJF2X2hdtTQ6k7C57Bsk5u97evVWkupdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjZmcTpb4oppm2GhZGMbwSSg8WIzkCOvAzI61G/cm1KrEc8s0QdzqYQePrdtcBQL0+aAcHCmhprTe6UX5hnp900g2Vrb4aAmnlvHSWmOXE+kQOJSvy6PODdEIc+GCM78Z950v9CKU9JRip7lYxCkB5PMnVFVSVe+Z9tenONG3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6aEcaMv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3d6cd979b6so26671066b.1;
        Wed, 14 Feb 2024 15:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707952724; x=1708557524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPPQ6md3pSWimsiinsHHjmNddWVDIiu8YX9efW9PpZE=;
        b=L6aEcaMvDWTmSBlk/ItOAsLarDV6zFWEl0DczEVlmJEeUohGx0yOaiKXp69spGAayA
         QGUJ2WtrrTmLl5H+qGnIGyGLRTkuyfX5iDopamr6OGkRQ6GlyL+u3ydR2sTv8KBlwQ4C
         COFXCrIcd/C/A+trLI88ZTy5//OOSZpAG6gzY+Y6jt81+CON21hYlefGN7w54B7bnsb4
         Zqy1MGx+HFP6PLOJ+Etv16xEQmrOtgnUUzVts/RZoVGQT4Z/+cSUFRGr4Dw+S+wWUvGG
         Y6aC/WDXoq1+cS5ClR9xxgf92kp4q2jWFfp8DiRVsldAVepXCMDmsMOe/fuRhgypPosM
         /eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952724; x=1708557524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPPQ6md3pSWimsiinsHHjmNddWVDIiu8YX9efW9PpZE=;
        b=rovhO/Cm5+XeJwPjpV8O9MAU7BatVVq5/NEty6WUeQCwJOdARIpc4OTCY0lAtTFjxi
         YuDk3xDNfotOTnhq6LA4fvlbIfqBRZsL8rdgkY4ha0cjAatlmYtl6lVLh4/qX9W4pIRW
         i2Y8lA6rH+4eMl4T3sAQRwvmY35sGfLe2or4cUQSc9KjNYNd1Aur86JvCZU8wTfhZdCv
         kLMt/KuPc5eqSWHM7EvxLQVf6TaApYc4+Dxp7PaCFlZEeUy1bz/UXUNc9vGQfMpX6TWW
         9dVse4wIu1QLI0/Y5CphIU5qqOQNh+gO9XXNoTvyX3mfaU9pJXJGJS9/fbMhk0HjUIsa
         GDeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpJj7yS3XEeArD3wFB2EKrk8xJMe/M/4FGIshmZAveJB1szWeSgTKS43dk48UmZIev8XBh1uTrtPV87+D5qRsByups7qMcX64tSsVC7QNX/WJp2QM7FFGRVVyxznIZMlshLc5Bv9nu
X-Gm-Message-State: AOJu0Yw+I6DSBwxea6/zicT2PGItJSpNoCn+BSyIE3yQM4q1XnxP4eVh
	vu+KLZMuXvz4EDW9itdMY7WDjk9ZALvPcLiY8AoB/JqzgDGpp0aX
X-Google-Smtp-Source: AGHT+IFqpExUYy6HBVMmoUrt5WYY43PkRA7vN4YsSSRMJ3dQFAOMMAkop/833vf38PmhZrOq5DkUBA==
X-Received: by 2002:a17:906:6d04:b0:a3d:1f59:7410 with SMTP id m4-20020a1709066d0400b00a3d1f597410mr18578ejr.22.1707952723458;
        Wed, 14 Feb 2024 15:18:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeal/aza678iXYXZKW5TF/eYEW67MBqzJzP7jkQFzVrrwwfow/rX12ICcnFSWF3CawrMDfuWM5et5Y2cuCq9iLMLqyIJBsl8v++QiI83eGRDZT8lW6B/+UMpeYAkwdR686R+2/tP+f+TfR3oPbGCyASbtjCTBV0FnHcYkUmppqSmpleljnMG2ZxK3CMoRZ0uPAfjLGAgPKraEPP3/vFg==
Received: from ?IPV6:2a02:8389:41cf:e200:b3c7:969b:2be:1e0f? (2a02-8389-41cf-e200-b3c7-969b-02be-1e0f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3c7:969b:2be:1e0f])
        by smtp.gmail.com with ESMTPSA id vh2-20020a170907d38200b00a3d08f3283fsm2000518ejc.104.2024.02.14.15.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 15:18:43 -0800 (PST)
Message-ID: <b159b10b-513f-4116-b2ef-faf6741dc3b6@gmail.com>
Date: Thu, 15 Feb 2024 00:18:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] iio: humidity: hdc3020: add threshold events
 support
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>, Li peiyu
 <579lpy@gmail.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240214085350.19382-1-dima.fedrau@gmail.com>
 <20240214085350.19382-4-dima.fedrau@gmail.com>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240214085350.19382-4-dima.fedrau@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.02.24 09:53, Dimitri Fedrau wrote:
> Add threshold events support for temperature and relative humidity. To
> enable them the higher and lower threshold registers must be programmed
> and the higher threshold must be greater then or equal to the lower
> threshold. Otherwise the event is disabled. Invalid hysteresis values
> are ignored by the device. There is no further configuration possible.
> 
> Tested by setting thresholds/hysteresis and turning the heater on/off.
> Used iio_event_monitor in tools/iio to catch events while constantly
> displaying temperature and humidity values.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---

Hi Dimitri,

now that the decimal part is used, the resolution loss is within the
ranges mentioned in the datasheet.

For the records: the truncated values lead to alerts slightly lower than
the target alerts. Therefore, measured values below the "comfort zone"
defined by the user (but close to the low alert) will not trigger
events. The other way around is "more secure" because the target comfort
zone is guaranteed:

-------- High val -> event (as expected)

******** Target High Alert

-------- Meas -> **event** (still in target comfort zone)

######## Truncated High Alert

..

******** Target Low Alert

-------- Meas -> **no event** (out of target comfort zone)

######## Truncated Low Alert

-------- Meas -> event (as expected)

But as I said, the resolution loss is in the valid range anyway:

Tested-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Thank you for adding this feature.

Best regards,
Javier Carrasco



