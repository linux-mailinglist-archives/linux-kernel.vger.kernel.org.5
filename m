Return-Path: <linux-kernel+bounces-55490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E278684BD54
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C211C24A82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA4D13FE7;
	Tue,  6 Feb 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wczz7y8p"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5576200C0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245107; cv=none; b=aY54PNuVOHuDsqOE2ih8WP1oPt1Sx1zXPDrml7mlXDeC1hoOy9cMT5QB5N4rMrteBo27yzU1Z0rF0KB+s/pqN0A7Z/miI/mLR9H/Dd3KqBDLx+3r0EvII8uy/kdwzAe+RGo4bZw6ihpaaL676Foy3Xcp4ucRTvAuitu+eKIfG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245107; c=relaxed/simple;
	bh=idoPEl5FVwNrTYpFLCWN9SrGWDsz9Wu0hTAQpxTOGJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POIW7XW9IKW9KDpTICpExAZdFceKMC2CYAP2uxbHPgIYUndPG1TegbC2bf3jPYyvadiP2ehamwguASzZe+s4/wjPBllrF1aDQRHpk0pLD8zl4mx2zqyBeTE9j7kFw9ZenFqV2PN/w3/0GrqaqEITR6r2LwzWYAx0ZEoPqAznQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wczz7y8p; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a30f7c9574eso785493466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245104; x=1707849904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzXAJUXwHJ7hSx/xEMC9Uv9BjsFQj7gJIIbI4keCMvI=;
        b=Wczz7y8pmMm1G4CXWGsVcFztcfmydyDjaoYfviJA7kEbPWOiF7FBwCmwMra19pEXeW
         /v2SW/pjn4zxfhq5sVQ9zNDDomL9oKp5GEeJxEVwFdAax99qdICe+bNehds+MEAjZy9f
         nnOpjD77j+nzurFwUsZKlUHGZq2Gl/PBKm8lFt1GSantENkKZkhdCSkP1b0gFpiy/pwC
         v1O7Q+X4pSS2TuaCYbRfvBDyj4otHyRNSzUIt/2NygcYuh8HX3DP/Z33ja7vhq+ddfh5
         uq2pW8BGCv5F4cuk3aIAvCYaHrLdKzAGEsf9TVn/0JWv2BtbWad2cRsz4q0Y+7hrN4ed
         AyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245104; x=1707849904;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzXAJUXwHJ7hSx/xEMC9Uv9BjsFQj7gJIIbI4keCMvI=;
        b=B8AZvxavXkJ3WYwDZzMc6h18AT+TAfP0wlZdF8NVzZLMtJtO01w6C0MC2JzLbuTery
         YczheOokmlA4KtPA/IEuEcfs7Ds666qXqAp/uvqOSbs5eLpJnCh2xlT2mn9DrYTL07A8
         3HtkyJIVmf37xtnOUMny+zi7p8aMHPqjxodM/QlzQRZ9klEjQee1JkvIDMCpmOC9ZqD6
         em30KhjnS+DbD/+Y0ayncl9mReP9FnQUL6+2PwmxGDRFEFlZmNY0jWdFFsVOO2XBscoX
         snXxGxe4PD6GX71DWxnhwrnoWf6xy2xjFbU27vy+h8TUniWMRQdOOdiOrieATijpdgvM
         tASw==
X-Gm-Message-State: AOJu0Yw4f384w6fR/sjWGV3i3sTvX0TApazq/qywN1VDTBi/eaBL4zac
	ju50Dh3mt9Sq82Zv7wON8JUg5RWd718iXmcpR7eTMzvcywmUDfN2j+aSXLe5UwI=
X-Google-Smtp-Source: AGHT+IHKJZhzG4xTsbwO2KDAhBptB/p+YMr0/6L3XIh1VfcrTzwfM6xQUksE4gkuOCkMlnp8dopofQ==
X-Received: by 2002:a17:906:a450:b0:a37:b4a9:3d53 with SMTP id cb16-20020a170906a45000b00a37b4a93d53mr2883454ejb.2.1707245104352;
        Tue, 06 Feb 2024 10:45:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU9KWv0wiP6nJI7zqWKT9pYcoKAUlkIotZm2RWh6IwSYk5XTJOhmjgHmq75G5NotNBrih261uO7UCnEi2ooQPTGUvtxESZtBtBoa4016bSLQ6SqajjxtHYsJCL3YgMw2TxCwk9xDwdNjMTUPstYMAktmmNmHFXdpcTzFcqaTNlVdsaOV/6dfFKM94ompYLt
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090619d000b00a385535a02asm209216ejd.171.2024.02.06.10.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 10:45:04 -0800 (PST)
Message-ID: <3669bded-aa85-4e16-b990-f42834b10091@linaro.org>
Date: Tue, 6 Feb 2024 19:45:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: mm8013: select REGMAP_I2C
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240204-mm8013-regmap-v1-1-7cc6b619b7d3@weissschuh.net>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240204-mm8013-regmap-v1-1-7cc6b619b7d3@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4.02.2024 18:30, Thomas Weißschuh wrote:
> The driver uses regmap APIs so it should make sure they are available.
> 
> Fixes: c75f4bf6800b ("power: supply: Introduce MM8013 fuel gauge driver")
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---

Thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

