Return-Path: <linux-kernel+bounces-106017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FB287E798
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED582828F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C00E2E84E;
	Mon, 18 Mar 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1cM11hDe"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67F32C92
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758679; cv=none; b=oBMBrZsCHjG/T0jQbJh43Y7CWWa36+RPOgYdfAT7Sv1zyD7w90AQUUM1v+m7Us9AneNQ+OEiNt+iTa1LYxTCKNDSiivCRckdiWOmmIzQf+VcOr/hl6pYIaU6QFO+PpCIWUgu85cHNbrUMq+2TCdWWkwW1UAVxsU8JPcEYNt7hyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758679; c=relaxed/simple;
	bh=+SOG/JMXzSLzhcPXLSIqOGl5VMrpHzfQZrNkOx8y724=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=tfDaB+sYvoPEFaMDGUywyWs6jIDTEP8e4x8G4HrqWyhIxTVt3vjmGwjGlsvt9ISnC2oGBFDjMoo0KH8TMd6V71FW1FHurAQv+gJpCbwOcyemMOa6xV7L6LrhRENNt9l8XQJR+PdmkwpPoNoiuVc5wjdoJrG6KZypPy9nRI9prQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1cM11hDe; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513d3746950so4964529e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710758676; x=1711363476; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=KCGPrCwTOITqjTnhSele0x2XpulUBe47CHNWCd7XesU=;
        b=1cM11hDeSMTR9lFAQfTERjAzuRrCa3rqVEh8PZNzqy7eDhvjQWyz2Y2AL5sm5dsTje
         +7mG0i3XjWHnHUKnzcJJY3DoxefsHtBLvVXh8+ifZxU8Z7T0dywDnFYKbvrJqyDh2R19
         qkquO0aTGqDWuTt2z/K/HinTLVZzcScfgDhd/mkiQDGUS9oCSfDx5v3nWjp/ZRwgW2Ut
         qSRCe46G/cPOUA4LtQfuzodZnBE9W22UwhqBQ37IPmmNaYbC5Fy6Z5nCrQtYndYpR4Fr
         GN6JDqT8wIJ2ymn2rxXh+ytzIklDaFm1PQLiB68BWuow9Whp8oKMDBD29i2C7KacOvEO
         pdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710758676; x=1711363476;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCGPrCwTOITqjTnhSele0x2XpulUBe47CHNWCd7XesU=;
        b=p7c9mARX/mOCKxy4bhmJjNADnOfoPtrrW5mRLydD3Tc9Pg0+LkGUim1yJLH5oI2GO0
         3w4bnE0qTnbgf7DBs2RwafA9qtaOFHpCGp0uRaqpAoCUjpWdr9XPr7pdrA6q1rLGerD0
         HAAdX75faYJ+6KI/HMMmEiKYdNvg019meTMm791YpBYPi9Wc29gA0aqaYtihaLe+6V+v
         LSgrVln+cJo68fwTi0YP58bat9+hD6An6hEH8qqrtgs/tEbFGKFRihAWdym5wGUCsLa2
         ZGRdMJLIgnFg7hIgcd1WeNEIoEwuEyDJPRJ+H5SXoOFuaB1HWFgRdHYA6/RubIXDOkE5
         ZSrw==
X-Forwarded-Encrypted: i=1; AJvYcCUglfax3CfHMONmybtwzFYBMTx0Dzjnu+aY32I8j2Gwhuyu3AZNGcNlxDKBQRdqUIodyITOsMEbvyCf93j0QdeK8e3fdp3THfCSAsOv
X-Gm-Message-State: AOJu0YyGtxkxmab+rb7pfWRiMDy3gq/569rfj3i9PdfSou/mot9vR/d3
	vejDp+JKBSMAW39Fvt37qrMGW0U9vj87QRdaLeXibMGzrTBXrkcISetSiCCnEGQ=
X-Google-Smtp-Source: AGHT+IHrBhAsRVSFIOS45FQu5E9/DGiPnUOBufbspQxtJ2p2r6r0OzKNwEix9BKbpaZlbyfnUT+a6Q==
X-Received: by 2002:ac2:494f:0:b0:513:c963:895e with SMTP id o15-20020ac2494f000000b00513c963895emr7169639lfi.42.1710758676166;
        Mon, 18 Mar 2024 03:44:36 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:e4d5:78c0:18b:ad85])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b00413ea26f942sm17214532wmq.14.2024.03.18.03.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:44:35 -0700 (PDT)
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-10-jan.dakinevich@salutedevices.com>
 <2a41e8b6-7e8a-4995-a1d7-c5d30e53c2d5@sirena.org.uk>
 <3ae535cf-9a89-4187-a761-8390d649b00b@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Mark Brown <broonie@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen  Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman
 <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Jaroslav  Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
 kernel@salutedevices.com
Subject: Re: [PATCH 09/25] ASoC: meson: g12a-toacodec: add support for A1
 SoC family
Date: Mon, 18 Mar 2024 11:42:20 +0100
In-reply-to: <3ae535cf-9a89-4187-a761-8390d649b00b@salutedevices.com>
Message-ID: <1ja5mvhl9o.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Sun 17 Mar 2024 at 18:19, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

> On 3/15/24 16:33, Mark Brown wrote:
>> On Fri, Mar 15, 2024 at 02:21:45AM +0300, Jan Dakinevich wrote:
>> 
>>>  static const struct regmap_config g12a_toacodec_regmap_cfg = {
>>> -	.reg_bits	= 32,
>>> -	.val_bits	= 32,
>>> -	.reg_stride	= 4,
>>> +	.reg_bits		= 32,
>>> +	.val_bits		= 32,
>>> +	.reg_stride		= 4,
>>> +	.max_register		= TOACODEC_CTRL0,
>>> +	.max_register_is_0	= true,
>> 
>> If the maximum register is 0 how does the regmap have a stride?
>
> reg_stride inherited from existing code. Apparently, it was meaningless
> even before my modifications (the hardware has single register
> regardless of max_register declaration) and it should be dropped. But,
> is it okay to remove it in the same commit?

Yes it has a single register, for now. Still the stride is 4.
And assuming the mmio region passed from DT is correct, I'm not sure the
hunk is useful at all.

-- 
Jerome

