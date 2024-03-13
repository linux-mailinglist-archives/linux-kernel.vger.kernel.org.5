Return-Path: <linux-kernel+bounces-101687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB5987AA85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9197B1F23163
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C114047773;
	Wed, 13 Mar 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HoE+ILJd"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F83E48C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344247; cv=none; b=LmkOUslPL3IdCOx5HT6hA0JFi/yi90j/RrX4Ky6nxEakL7UgQjUczZIQl/buDprB+vozvW1GgK2f+BQNnmhA3lAloz9rJZ3iqD12txKEVvRKeqD2oz3/LYh9mgA5IR1J0K2tSOTU/RgF+uGZkXXGGT9QqqZJ3x3zvgZutC+T2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344247; c=relaxed/simple;
	bh=wyRvOh55eFri7lzQSBWIL+bfhOJ6wW4bqJdvl15+6n8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Be6n8rWZa9OA+8xIoanIhA/zWuDTy+zj4ROnVCpxlrI9/esZ00RZBP1VLYWf7CoFHattTyYgb9X+J2qnPzLPoLfptTliNxOhP0B7cjo2600xeiMypWKnCjNxAoEG1yGBGB1W9viRK2eIMVjVnwc0McVVYOKIBXGRQyLdZ+AUjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HoE+ILJd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e7ae72312so4902057f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710344243; x=1710949043; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ltqfc1ssllsg0Pb1xlVI1xuNT6EUJLMewunYB64JavQ=;
        b=HoE+ILJdW059WWBrVvHiQDEZgq06d/78nASkahtHIrtGj0nuFOM6GRCADOBPAmEOlc
         TwZEHXWS09NK1487XiuhUOPvm4aza2v5YjeULYdGjjhWvjWM4rz80oJZmzprK+nTBWNO
         Kptlkkj8r11NpvF6pK8kry188ZxQL7EAv7jnX98wqL5nAGVycEuLgDQPaNXErMSD44x4
         j8JcFbDl120PMGq9snLzncqEVNp2/rI9EWUKWuGAgkrz0UuNxVU3Z3s8c9eA8ktlo/aH
         8TeEq00c4Rj845QEs9hHaIMV+BXS13s++a/x/rtBIKiLu7LLwB6w9dH5QYBv5XXJ0rui
         GHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710344243; x=1710949043;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ltqfc1ssllsg0Pb1xlVI1xuNT6EUJLMewunYB64JavQ=;
        b=UvRumcgntHnaT2G2wirmghh1ucJFB7jZE6dlebX3Lj7FdFfb21qHuj7pCYVjMEagd+
         zSd/NdR7s4JTs4fmteItI4Un5UWrJCdBzcpP7BJCmIFvrQH4aNWE++xBWcTyKLu+0oiy
         Jv949hsyWYFt3arZGkj9Ll4E1sn6cpzAGGDKm55Qu9HOR6SYZX9ZJOeZR7dl6AI3hwGp
         dY0q2F9f4E4QQwB4Mb+UJaB31W+nmCnUjrXzBGIU1CxtOo4WiCSHuBpBkOqJmBZQk1TP
         w6lg1rvG4sBBlLczLx8DgkW60neo+ZQZpSAFwWkZgBICSlIkeufq412XO5jcEnymEFT+
         NM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNeL4k3bCgcEEOPnlcbjN72x6UyoNlJJh+T+y1LaNEBtanfqh6ovqa81uyMzh1duTcZRglSd480TtunH810KUXDlfXiBE57kXy1g6o
X-Gm-Message-State: AOJu0YzgEhzec7wZ4mA6SD3mcMzSjHJNUk++IKQKPV642QfRbVEkHnz1
	AwIVZahyf4JbITTXiEIPIXlDKA+ILRcvodNryrp3XLs20TJTsf3M4CcuXqa7rQc=
X-Google-Smtp-Source: AGHT+IGr2jNokbIYXEgfMfmScVl25We1OALkmrBI3/mDBeg9nYZCi45jpVwfa4YlpyXlTDQ/yAOQnA==
X-Received: by 2002:a5d:4110:0:b0:33e:5fb9:af21 with SMTP id l16-20020a5d4110000000b0033e5fb9af21mr2092726wrp.56.1710344243401;
        Wed, 13 Mar 2024 08:37:23 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bp24-20020a5d5a98000000b0033e25c39ac3sm12423960wrb.80.2024.03.13.08.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 08:37:23 -0700 (PDT)
Message-ID: <5552010a-1ce2-46a1-a740-a69f2e9a2cf2@linaro.org>
Date: Wed, 13 Mar 2024 16:37:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Mubin Sayyed <mubin.sayyed@amd.com>, Ley Foon Tan <lftan@altera.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v6.9-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,

The following changes since commit 71fee48fb772ac4f6cfa63dbebc5629de8b4cc09:

   tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug 
(2024-01-19 16:40:38 +0100)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.9-rc1

for you to fetch changes up to 8248ca30ef89f9cc74ace62ae1b9a22b5f16736c:

   clocksource/drivers/timer-riscv: Clear timer interrupt on timer 
initialization (2024-03-13 12:08:59 +0100)

----------------------------------------------------------------
- Fix -Wunused-but-set-variable warning for the iMX GPT timer (Daniel
   Lezcano)

- Add Pixel6 compatible string for Exynos 4210 MCT timer (Peter Griffin)

- Fix all kernel-doc warnings and misuse of comment format (Randy
   Dunlap)

- Document in the DT bindings the interrupt used for input capture
   interrupt and udpate the example to match the reality (Geert
   Uytterhoeven)

- Document RZ/Five SoC DT bindings (Lad Prabhakar)

- Add DT bindings support for the i.MX95, reorganize the driver to
   move globale variables to a timer private structure and introduce
   the i.MX95 timer support (Peng Fan)

- Fix prescalar value to conform to the ARM global timer
   documentation. Fix data types and comparison, guard the divide by
   zero code section and use the available macros for bit manipulation
   (Martin Blumenstingl)

- Add Ralink SoCs system tick counter (Sergio Paracuellos)

- Add support for cadence TTC PWM (Mubin Sayyed)

- Clear timer interrupt on timer initialization to prevent the
   interrupt to fire during setup (Ley Foon Tan)

----------------------------------------------------------------
Daniel Lezcano (1):
       clocksource/drivers/imx: Fix -Wunused-but-set-variable warning

Geert Uytterhoeven (1):
       dt-bindings: timer: renesas,tmu: Document input capture interrupt

Lad Prabhakar (1):
       dt-bindings: timer: renesas: ostm: Document RZ/Five SoC

Ley Foon Tan (1):
       clocksource/drivers/timer-riscv: Clear timer interrupt on timer 
initialization

Martin Blumenstingl (5):
       clocksource/drivers/arm_global_timer: Fix maximum prescaler value
       clocksource/drivers/arm_global_timer: Remove stray tab
       clocksource/drivers/arm_global_timer: Make gt_target_rate 
unsigned long
       clocksource/drivers/arm_global_timer: Guard against division by zero
       clocksource/drivers/arm_global_timer: Simplify prescaler register 
access

Mubin Sayyed (1):
       dt-bindings: timer: Add support for cadence TTC PWM

Peng Fan (3):
       dt-bindings: timer: nxp,sysctr-timer: support i.MX95
       clocksource/drivers/imx-sysctr: Drop use global variables
       clocksource/drivers/imx-sysctr: Add i.MX95 support

Peter Griffin (1):
       dt-bindings: timer: exynos4210-mct: Add google,gs101-mct compatible

Randy Dunlap (3):
       clocksource/drivers/stm32: Fix all kernel-doc warnings
       clocksource/drivers/ti-32K: Fix misuse of "/**" comment
       clocksource: arm_global_timer: fix non-kernel-doc comment

Sergio Paracuellos (1):
       dt-bindings: timer: add Ralink SoCs system tick counter

  .../devicetree/bindings/timer/cdns,ttc.yaml        |  22 +++-
  .../bindings/timer/nxp,sysctr-timer.yaml           |   4 +-
  .../bindings/timer/ralink,cevt-systick.yaml        |  38 +++++++
  .../devicetree/bindings/timer/renesas,ostm.yaml    |   2 +-
  .../devicetree/bindings/timer/renesas,tmu.yaml     |  18 +++-
  .../bindings/timer/samsung,exynos4210-mct.yaml     |   2 +
  drivers/clocksource/arm_global_timer.c             |  35 +++---
  drivers/clocksource/timer-imx-gpt.c                |   3 +-
  drivers/clocksource/timer-imx-sysctr.c             | 117 
+++++++++++++++------
  drivers/clocksource/timer-riscv.c                  |   3 +
  drivers/clocksource/timer-stm32.c                  |   4 +-
  drivers/clocksource/timer-ti-32k.c                 |   2 +-
  12 files changed, 191 insertions(+), 59 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

