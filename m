Return-Path: <linux-kernel+bounces-101585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6988E87A904
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D46288563
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C4945022;
	Wed, 13 Mar 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qwALjHVr"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E3F43AD5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338788; cv=none; b=Ucooo80zykZFc30sdgwvrjBtix6SYfmvXUAT+wy3UlBrtT8ngt6bSV33SPslirsq4ma+brmxOUctp2oDDZN54Pf1avwlvimi7f+jYYvLBkdrbBpW9B4nAD2RHLTUdjxhqskzCK0199Md1O3PFFhUCdBZ40PyE5iLHshn1gp6VHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338788; c=relaxed/simple;
	bh=dILn5Hndi6QvLrMyB/RNVJCWfu6T1Nm7fN4fplsjkac=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fHNJfntep2PG0oq/KustxTlMj5fHGs93hL5k+G5ZBO2QxKoB75ZSXBuLwYhCLVdPgjcr3gnrQa6/ua7Zby9kbRf5KAR8u4KgWzSs5FrC95bvJkoLEkJ5ufA4ZmoYb5FfsxOteltt/uES83KNYJYaV/7BRmKGcEQCi+tF8z2cYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qwALjHVr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e95b68b3eso3184105f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710338785; x=1710943585; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0SucWULpAR7kwQjBV+IjlaMrkGCCyLEbqf0BnsbnwA=;
        b=qwALjHVrl7rClkS1P6C/sPcJbtFpjgXzBMFBwBUcnigGbaW7XFU8LZqNQkO7pNeiV5
         P2d+zQAQd8J38ui+iYSrhqrsT3bl4q4b5BV7dd66Da3N4DjmZY0oDwFaKBgFX56GOoef
         /+uVj0UQ29COQCrrD+mP2IBvS0a/sdXHr6i7+sYaUlIlYdYzOduUX3lyopam/A6lvDJ3
         KbBhnCLnKTbo946GJWO/t2UH6ANkj0MKDtxYrToS50ZVNdr+vDHXLTMLQWv00XegRqq6
         /QyKg/qoDjrGcUatzUyZcrNlTozTTQygTGaF49g8zp6ta1K52wHJiUC4ayYd1yI9vDRv
         6YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338785; x=1710943585;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q0SucWULpAR7kwQjBV+IjlaMrkGCCyLEbqf0BnsbnwA=;
        b=vLShkLLrvtype/TEnq8v8Yw/CEjyL4hBTEZlnm65ZjbadyklSMvFUroLBqENpyuLkF
         dwgmtlq+oA4x1avTj2wMg/ooiplTzvwl0mQ2l01rCpGYhFFjLXv48UxllgoLLGRFWy6n
         xNzfXHMQKilSMlr4OluWISlcx8yB4M9YwCSsOFdedFwO9YQB6a4ogL0EQvtNmqW7BSnI
         iaumoHAPNPqSGV3j7MHUnXSY1TC/KJi/cC7olZZxDgC5U1X43cqvwrBk3Ut/gDQLDjxd
         XwwPRKQZeaHgM23bSaSnsOhziPgdILcy9FRkhAyYoKfu6Eco4AEKBjQio0uthVQfL5xV
         hGrA==
X-Forwarded-Encrypted: i=1; AJvYcCW1cHyKMfNcq1iVOps+TT/wYwsnC7VrINZXkDJmEoE7NqfG6NV9mGHw0NGFLqunXymR4k4M7JCsfJHx/KqCVQbk9i5zex0GO1GbopKQ
X-Gm-Message-State: AOJu0YzMeWWKlWOCa477dZEDNrknrOsLVIIyDUMlbLuAN88Z10F7yJYz
	PR3sJXsy9n8UErsft0C/3/uoUI5lRoySYHdauYjPncJSFAkJvdXpUjILT3wBdB0=
X-Google-Smtp-Source: AGHT+IHaK9tAlmweFTo+WHnVjQsXoGvjan+LgRuk7V5ZXDrSOlyqkZoO2eO4gJVT1XnMmiEzTFMFng==
X-Received: by 2002:adf:ffc7:0:b0:33e:12a2:297f with SMTP id x7-20020adfffc7000000b0033e12a2297fmr1805870wrs.41.1710338785078;
        Wed, 13 Mar 2024 07:06:25 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bj26-20020a0560001e1a00b0033b66c2d61esm1993293wrb.48.2024.03.13.07.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 07:06:24 -0700 (PDT)
Message-ID: <8f00bf23-47cb-4656-a326-6d8d1d0d10d6@linaro.org>
Date: Wed, 13 Mar 2024 15:06:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Frank Wunderlich <frank-w@public-files.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Fabio Estevam <festevam@denx.de>, Martin Botka
 <martin.botka@somainline.org>, Mark Brown <broonie@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Konrad Dybcio <konrad.dybcio@somainline.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] Thermal material for v6.9-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

The following changes since commit dcb497ec993265dfc5fffa60b486c1ad353e9ad5:

   Merge branches 'thermal-core' and 'thermal-intel' (2024-03-07 
21:05:12 +0100)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.9-rc1

for you to fetch changes up to 1828c1c17bb2adf3a3f26abc69cb3fe971eac0e4:

   thermal/drivers/rcar_gen3: Add support for R-Car V4M (2024-03-11 
17:14:46 +0100)

----------------------------------------------------------------
- Fix memory leak in the error path at probe time in the Mediatek LVTS
   driver (Christophe Jaillet)

- Fix control buffer enablement regression on Meditek MT7896 (Frank
   Wunderlich)

- Drop spaces before TABs in different places: thermal-of, ST drivers
   and Makefile (Geert Uytterhoeven)

- Adjust DT binding for NXP as fsl,tmu-range min/maxItems can vary
   among several SoC versions (Fabio Estevam)

- Add support for H616 THS controller for the Sun8i platforms. Note
   that this change relies on another change in the SoC specific code
   which is included in this branch (Martin Botka)

- Don't fail probe due to zone registration failure because there is
   no trip points defined in the DT (Mark Brown)

- Support variable TMU array size for new platforms (Peng Fan)

- Adjust the DT binding for thermal-of and make the polling time not
   required and assume it is zero when not found in the DT (Konrad
   Dybcio)

- Add r8a779h0 support in both the DT and the driver (Geert Uytterhoeven)

----------------------------------------------------------------
Andre Przywara (3):
       soc: sunxi: sram: export register 0 for THS on H616
       thermal/drivers/sun8i: Explain unknown H6 register value
       thermal/drivers/sun8i: Add SRAM register access code

Christophe JAILLET (1):
       thermal/drivers/mediatek/lvts_thermal: Fix a memory leak in an 
error handling path

Duy Nguyen (1):
       dt-bindings: thermal: rcar-gen3-thermal: Add r8a779h0 support

Fabio Estevam (1):
       dt-bindings: thermal: qoriq-thermal: Adjust fsl,tmu-range 
min/maxItems

Frank Wunderlich (1):
       thermal/drivers/mediatek: Fix control buffer enablement on MT7896

Geert Uytterhoeven (2):
       thermal: Drop spaces before TABs
       thermal/drivers/rcar_gen3: Add support for R-Car V4M

Konrad Dybcio (2):
       dt-bindings: thermal-zones: Don't require polling-delay(-passive)
       thermal/of: Assume polling-delay(-passive) 0 when absent

Maksim Kiselev (1):
       thermal/drivers/sun8i: Extend H6 calibration to support 4 sensors

Mark Brown (1):
       thermal/drivers/sun8i: Don't fail probe due to zone registration 
failure

Martin Botka (2):
       dt-bindings: thermal: sun8i: Add H616 THS controller
       thermal/drivers/sun8i: Add support for H616 THS controller

Peng Fan (1):
       thermal/drivers/qoriq: Fix getting tmu range

  .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |  34 +++--
  .../devicetree/bindings/thermal/qoriq-thermal.yaml |   3 +-
  .../bindings/thermal/rcar-gen3-thermal.yaml        |   2 +
  .../devicetree/bindings/thermal/thermal-zones.yaml |   2 -
  drivers/soc/sunxi/sunxi_sram.c                     |  22 ++++
  drivers/thermal/Makefile                           |   2 +-
  drivers/thermal/mediatek/auxadc_thermal.c          |   3 +
  drivers/thermal/mediatek/lvts_thermal.c            |   4 +-
  drivers/thermal/qoriq_thermal.c                    |  12 +-
  drivers/thermal/rcar_gen3_thermal.c                |   4 +
  drivers/thermal/st/st_thermal.h                    |  18 +--
  drivers/thermal/st/st_thermal_memmap.c             |   2 +-
  drivers/thermal/sun8i_thermal.c                    | 139 
+++++++++++++++++----
  drivers/thermal/thermal_of.c                       |  14 ++-
  14 files changed, 203 insertions(+), 58 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

