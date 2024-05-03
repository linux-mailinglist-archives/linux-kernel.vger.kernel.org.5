Return-Path: <linux-kernel+bounces-167634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3E8BAC4A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1663D284AFE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0623F153518;
	Fri,  3 May 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bask4Jfl"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3FD1534E0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738889; cv=none; b=u3Q1GpWHZWPiNRprVY0VQMVr4jjxBPXKEtcpzdpOcZtoNsL/8P3eFwWcWC+r8K9uHralDhwSpm7i38wcF1Me5JFu1m+6t4H/g4l+EnjSNF1j0YBwilHjth5Tps3DFcUCXcVPsqFCtBf55LPphYlNhuxntgNQVQa7ktIlagU0G5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738889; c=relaxed/simple;
	bh=TvbAm4wwVEmwer4Y6LZ8Txfy38/Jyf19ctQ6Ha1H6ew=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=R7e17Aa3jVQj3Lir+/tSHj/Ko6x1ejcWPdukqAYH3GP83akiy9QOdeaPQnvvfF65yNHLvZ7dhXIj9/zd8HS9EDVnfAUxf4ZEbyvky1Vd57lmBYQ4+wdu3ud+YnSu2UlW2F/YFDM/idQBgU57rpqKtrOqBnIvgZrkNY8heyhVII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bask4Jfl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34da4d6f543so2816436f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714738885; x=1715343685; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=FE1I/jBycBoqAmvsabhWL2xuaCucHohgag0bUdqLVzQ=;
        b=Bask4JfleUekFIk1PSxcBii95X+QRnO7KfwFh7+Z7e1OLjVfUIBWzDndUoR7BEttC8
         aOKEFnSf3QUpnwhkHO3upaYZxBgEXHLTDNvLzPg79Q1FI57jCBTxbYdv5XnmcscxnofX
         81W0sJBHwTmtAeXsjh19o3Kp+CeTrztam9kVaAAPeHxOiQWwSC6j4SRGToiMVZo+YeyX
         NNw2q0mqJ0K0dHelkmWJI0yfMl/cDZdzQP1pMB2FYQr+zayVDOHbt2t3eNFUQgFGRI6K
         S7KIg1uNmZyFs92rQhYX7x8oAvQyvt1/GFaHMCI7l7/+T0zHSG3cBTcgWAjnu7lSyfMg
         yFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714738885; x=1715343685;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE1I/jBycBoqAmvsabhWL2xuaCucHohgag0bUdqLVzQ=;
        b=sMENQ6Pw3MvzzvYPKCxEhAeaTaD/NwEexOM2Kkht7y3BLP0eKp0n+MpidWKhVqWmln
         zWURwG/nr/Nk980BrbefMVR/w4xYiirNPHXwkW8jlH7Xd58LHdo8xM12m+6QDzCBZDj2
         MF4bjIk/qSGryDlJjdMA+Mv/TCZH+Bpb+wTmoJOY4c9BWG4397/udoHBWowieNCehaQx
         UtUdp+8/m5KFxJesJckrHKnZ4Q3PZS60RWVKTz1gNc/tWkPvsicFoBEy8XjpUKe9ZJdW
         zfE9J8EqIdAdcv0hcF1RLoOkHY3Po0a44GwzN6RdEcLOIMdVmU+jw970DA71yeSVOvb1
         4lJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI3NeL5q0sW5vreeGWP5C6w8g89xMfF6ZPY66yyahCKl9IectX0Sl9cqv5Jy9AKRrAiKIRoXb1zByI5AQ6ccM8UCzTkBJLiQ9k/6+e
X-Gm-Message-State: AOJu0YyL44Ec1rDAFBEAmPOg7yjqQS10hvlbcablK0/CTeC2hROtEgOW
	0UmJbGT6PitScnWmuWDPMjW3aEzyjeAK2K67nmfoMbMQy23n2gY5d1o/Z35Fo2Y=
X-Google-Smtp-Source: AGHT+IE0DbMuSx/eoQe4w4zgYxtSoMrhzPIpgLgKzjijku4u86QRScfsOqCpX0Dv3i9LAF6ci4xU3A==
X-Received: by 2002:a05:6000:128c:b0:34d:a3e5:c954 with SMTP id f12-20020a056000128c00b0034da3e5c954mr1761292wrx.67.1714738885490;
        Fri, 03 May 2024 05:21:25 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1b85:e590:355b:9957])
        by smtp.gmail.com with ESMTPSA id c4-20020a5d4cc4000000b0034e4d029a62sm2452058wrt.2.2024.05.03.05.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:21:25 -0700 (PDT)
References: <20240424050928.1997820-1-xianwei.zhao@amlogic.com>
 <20240424050928.1997820-6-xianwei.zhao@amlogic.com>
 <20240424200107.GA372179-robh@kernel.org>
 <9a9ab302-5da5-47bb-85f1-d2295fa9f8c9@amlogic.com>
 <1jle4r3x5l.fsf@starbuckisacylon.baylibre.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>, Rob Herring <robh@kernel.org>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Neil  Armstrong
 <neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH v7 5/5] clk: meson: c3: add c3 clock peripherals
 controller driver
Date: Fri, 03 May 2024 14:20:58 +0200
In-reply-to: <1jle4r3x5l.fsf@starbuckisacylon.baylibre.com>
Message-ID: <1jh6ff3x2z.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Fri 03 May 2024 at 14:16, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Thu 25 Apr 2024 at 14:28, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>
>> Hi Rob,
>>    Thanks for your review.
>>
>> On 2024/4/25 04:01, Rob Herring wrote:
>>> [ EXTERNAL EMAIL ]
>>> On Wed, Apr 24, 2024 at 01:09:28PM +0800, Xianwei Zhao wrote:
>>>> Add the C3 peripherals clock controller driver in the C3 SoC family.
>>>>
>>>> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
>>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>> ---
>>>>   drivers/clk/meson/Kconfig          |   15 +
>>>>   drivers/clk/meson/Makefile         |    1 +
>>>>   drivers/clk/meson/c3-peripherals.c | 2366 ++++++++++++++++++++++++++++
>>>>   3 files changed, 2382 insertions(+)
>>>>   create mode 100644 drivers/clk/meson/c3-peripherals.c
>>>>
>>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>>> index 9f975a980581..0b85d584910e 100644
>>>> --- a/drivers/clk/meson/Kconfig
>>>> +++ b/drivers/clk/meson/Kconfig
>>>> @@ -142,6 +142,21 @@ config COMMON_CLK_C3_PLL
>>>>          AKA C3. Say Y if you want the board to work, because PLLs are the parent
>>>>          of most peripherals.
>>>>
>>>> +config COMMON_CLK_C3_PERIPHERALS
>>>> +     tristate "Amlogic C3 peripherals clock controller"
>>>> +     depends on ARM64
>>>> +     depends on ARM_SCMI_PROTOCOL
>>> I may have missed it, but I don't see the dependency on SCMI in this
>>> driver.
>>> 
>>
>> Some clock sources for peripherals controller from SCMI module.
>> In previous version, Jerome suggest us the clock  that relevant registers
>> can only be accessed securely is implemented through SCMI.
>>
>
> There is no dependency but you are guranteed to have have problem if
> SCMI is missing because it provides several inputs to this controller.
>
> IMO, this controller should 'imply ARM_SCMI_PROTOCOL'
>
> You have already posted a v8 without it.
> I expect a fix up change on top of v8 if there is no other comment on
> this v8 version. Part of v9 otherwise.
>
>>>> +     depends on COMMON_CLK_SCMI
>>>> +     depends on COMMON_CLK_C3_PLL

Same here - imply, not depends

>>>> +     default y
>>>> +     select COMMON_CLK_MESON_REGMAP
>>>> +     select COMMON_CLK_MESON_DUALDIV
>>>> +     select COMMON_CLK_MESON_CLKC_UTILS
>>>> +     help
>>>> +       Support for the Peripherals clock controller on Amlogic C302X and
>>>> +       C308L devices, AKA C3. Say Y if you want the peripherals clock to
>>>> +       work.
>>>> +
>>>>   config COMMON_CLK_G12A
>>>>        tristate "G12 and SM1 SoC clock controllers support"
>>>>        depends on ARM64
>>>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>>>> index 4420af628b31..20ad9482c892 100644
>>>> --- a/drivers/clk/meson/Makefile
>>>> +++ b/drivers/clk/meson/Makefile
>>>> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>>>   obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>>>>   obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>>>> +obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>>>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>>>> diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
>>>> new file mode 100644
>>>> index 000000000000..0f834ced0ee9
>>>> --- /dev/null
>>>> +++ b/drivers/clk/meson/c3-peripherals.c
>>>> @@ -0,0 +1,2366 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Amlogic C3 Peripherals Clock Controller Driver
>>>> + *
>>>> + * Copyright (c) 2023 Amlogic, inc.
>>>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>>>> + */
>>>> +
>>>> +#include <linux/clk-provider.h>
>>>> +#include <linux/of_device.h>
>>> I don't think you need this header.
>>> 
>>
>> Yes, I will fix it with c3-pll.c.
>>
>>>> +#include <linux/platform_device.h>
>>>> +#include "clk-regmap.h"
>>>> +#include "clk-dualdiv.h"
>>>> +#include "meson-clkc-utils.h"
>>>> +#include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>


-- 
Jerome

