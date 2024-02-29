Return-Path: <linux-kernel+bounces-87346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3D86D31E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A091F230E7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DFA13C9EE;
	Thu, 29 Feb 2024 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKZPpW0v"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C542113C9DB;
	Thu, 29 Feb 2024 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234824; cv=none; b=gFo3ot3b1VPu8X5wy1fx1TEWUvKR5WCL4JlSpD8VMflhYYaFKuckXooqPYGGO+Q0htDttpNO9QmRehz3WJo4+7lGBKbBdLCKK0EO5c9xW0wFSC1dbq4csBkZL2LiDyDz89OKXUPqJMC8pknhsRz6Ic2oXoREnwOw6yLUh6xO3HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234824; c=relaxed/simple;
	bh=hAYEg69gGvrO2LTlkt7LFP2fOAof7WF6nmTQJr0yRQs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n7Z0glSxIXmPE63hQZNJ4PxFkPUsZz9G5Lk5PByy6on3efjkbIk0tRNVwmabJY+2BPDTfXWO38GbeNQgGcOoS+EPy61iYxLtX1QbIJjGJJRtSdNZJaLkUXfSRW0f/Gdp2rCTee8nDElncPegOejn32CrPnqwVu7st8EU975+HfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKZPpW0v; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412a14299a4so9984325e9.1;
        Thu, 29 Feb 2024 11:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709234820; x=1709839620; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJOJyUFKE6vWJvYSz1LvG697rW0U88KqR4dAP+GyGq4=;
        b=cKZPpW0vBTY5fGABZ0/WPynqOJ0Q+Q1YEUC7F2nnjT1TRTAu5SKpViWSe5j2OWF5bE
         q1MFkHKpKKbrIHxEhGYfdZISsi8a31BftgYxQX6XWVB+mVxWcacK6s3hO0+yGr+TSqKC
         a1gina1Q0dCpZhVtQBodZNk2Hv4IiuQy3EFzWyuEUDhRCqkiBLRY38Alry2la9hIDKle
         NGhUxvdN7xgpPSC+qzbivAZe1fkuxXagzrwicqMNiW80t+ADahR0a/7vAClxRqICBNh4
         T/TtA46PV6xoYpdT+DXb1zG6NfqMLyDotoTEqfB9FIY0J5Gid8ZYfnMZrMHDDap7IheZ
         mlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234820; x=1709839620;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJOJyUFKE6vWJvYSz1LvG697rW0U88KqR4dAP+GyGq4=;
        b=ViJyTb/BWzUY3Bxev0VOGQ8PzgY3HIb/xYmVAvARC6fFHIBN+Yh5QYBpQZVmtm1p6x
         T34Gp6C9BKBbCcuwbmwOO/OkZ0rqKEX7ulz5ZI0+VkW170uvLnE15RPxavwQm0zl9yyE
         H2ADR8iSzX5SQSVVSw6Bz3zxNL+y2YJh7ohg1a6PgwWGehG1UAaFxpDgERbOBVfn2b/0
         KYt6BHhPEnkFS6z8LmkH9nDF6mJFzBcrLZ8Z9Ke2Sb+X7bbnB0MWi4aLCz38JMsvcplA
         +6rtkjIZjSrp3HeVyk9yEZNHJtLRNJ/6/DoY87lCblV/WN575htS+wG5lpqPvd/sZovg
         fqAg==
X-Forwarded-Encrypted: i=1; AJvYcCXdrLqh40xan5YSpM+1TOb2WnzqAIhbkBIZzqkiclcmCYiEX8lsNInk94GVAHoUZRT8a9QElnC/ArniOH+dgX9GPj9pWcwr9fpFO5cbM02Gwwqw+LqNn8J5kthTStgFDOgfr6Z8b7LvAA==
X-Gm-Message-State: AOJu0YwXu2ZSKdzG7aHJSJk4ZWEocY54CLPKXIif7e8yf8qlvYfdxdC4
	x/lqooqzXw+j0FTR3dWUrKxmvFGLQaHYc9g4c/GHyT3uFy+9lqkuJ2w3skShc3IWaA==
X-Google-Smtp-Source: AGHT+IEmConaemKMtcTzN62uobZUuH1/Oz6g74N2+DYM6UgwDD8QkXzhIsYPJiHOQJ25qJEWxsvgdA==
X-Received: by 2002:a05:600c:444e:b0:412:bd9b:2a55 with SMTP id v14-20020a05600c444e00b00412bd9b2a55mr2325602wmn.13.1709234820222;
        Thu, 29 Feb 2024 11:27:00 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:6ebc::d35])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b00412bca49a5bsm2853944wms.42.2024.02.29.11.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:26:59 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v3 0/5] RK3588 and Rock 5B dts additions: thermal, OPP and
 fan
Date: Thu, 29 Feb 2024 23:26:31 +0400
Message-Id: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGfa4GUC/23NwQ6CMAwG4FchOzszCmPgyfcwHmAd0KhgNrJoC
 O9uITHR6K1/8/frLILz5II4JLPwLlKgceCQ7RJh+3ronCTkLEBBrlLIpb9InIKsEWniLk8Fmka
 DKU1TCT67e9fSYyNPZ849hWn0z+1DTNftG9O/WEylkro0FRiNTVa0x+5W03Vvx5tYsQgfQKb+A
 MCALQDA5taU+AUsy/IC2/+ckvEAAAA=
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709234816; l=4526;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=hAYEg69gGvrO2LTlkt7LFP2fOAof7WF6nmTQJr0yRQs=;
 b=8Jd8dVO6bUfYp/U7rjYgPVzmRlNnRBnMSq82B8/2P2cj+d66afXQk6tm+K1xjrrxSTY/72ER6
 hk5QZc0BWj4AS/b5yjnWVo+X0dTuTjtACCdHufZH5JGxxfXs5z/zs2w
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
active cooling on Radxa Rock 5B via the provided PWM fan.

Some RK3588 boards use separate regulators to supply CPUs and their
respective memory interfaces, so this is handled by coupling those
regulators in affected boards' device trees to ensure that their
voltage is adjusted in step.

In this revision of the series I chose to enable TSADC for all boards
at .dtsi level, because:
 - The defaults already in .dtsi should work for all users, given that
   the CRU based resets don't need any out-of-chip components, and
   the CRU vs. PMIC reset is pretty much the only thing a board might
   have to configure / override there
 - The boards that have TSADC_SHUT signal wired to the PMIC reset line
   can still choose to override the reset logic in their .dts. Or stay
   with CRU based resets, as downstream kernels do anyway
 - The on-by-default approach helps ensure thermal protections are in
   place (emergency reset and throttling) for any board even with a
   rudimentary .dts, and thus lets us introduce CPU DVFS with better
   peace of mind

Fan control on Rock 5B has been split into two intervals: let it spin
at the minimum cooling state between 55C and 65C, and then accelerate
if the system crosses the 65C mark - thanks to Dragan for suggesting.
This lets some cooling setups with beefier heatsinks and/or larger
fan fins to stay in the quietest non-zero fan state while still
gaining potential benefits from the airflow it generates, and
possibly avoiding noisy speeds altogether for some workloads.

OPPs help actually scale CPU frequencies up and down for both cooling
and performance - tested on Rock 5B under varied loads. I've split
the patch into two parts: the first containing those OPPs that seem
to be no-regret with general consensus during v1 review [2], while
the second contains OPPs that cause frequency reductions without
accompanying decrease in CPU voltage. There seems to be a slight
performance gain in some workload scenarios when using these, but
previous discussion was inconclusive as to whether they should be
included or not. Having them as separate patches enables easier
comparison and partial reversion if people want to test it under
their workloads, and also enables the first 'no-regret' part to be
merged to -next while the jury is still out on the second one.

[1] https://lore.kernel.org/linux-rockchip/1824717.EqSB1tO5pr@bagend/T/#ma2ab949da2235a8e759eab22155fb2bc397d8aea
[2] https://lore.kernel.org/linux-rockchip/CABjd4YxqarUCbZ-a2XLe3TWJ-qjphGkyq=wDnctnEhdoSdPPpw@mail.gmail.com/T/#m49d2b94e773f5b532a0bb5d3d7664799ff28cc2c

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Changes in v3:
- Added regulator coupling for EVB1 and QuartzPro64
- Enabled the TSADC for all boards in .dtsi, not just Rock 5B (thanks ChenYu)
- Added comments regarding two passive cooling trips in each zone (thanks Dragan)
- Fixed active cooling map numbering for Radxa Rock 5B (thanks Dragan)
- Dropped Daniel's Acked-by tag from the Rock 5B fan patch, as there's been quite some
  churn there since the version he acknowledged
- Link to v2: https://lore.kernel.org/r/20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com

Changes in v2:
- Dropped the rfkill patch which Heiko has already applied
- Set higher 'polling-delay-passive' (100 instead of 20)
- Name all cooling maps starting from map0 in each respective zone
- Drop 'contribution' properties from passive cooling maps
- Link to v1: https://lore.kernel.org/r/20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com

---
Alexey Charkov (5):
      arm64: dts: rockchip: enable built-in thermal monitoring on RK3588
      arm64: dts: rockchip: enable automatic active cooling on Rock 5B
      arm64: dts: rockchip: Add CPU/memory regulator coupling for RK3588
      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
      arm64: dts: rockchip: Add further granularity in RK3588 CPU OPPs

 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  12 +
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  12 +
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  30 +-
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi          | 385 ++++++++++++++++++++-
 4 files changed, 437 insertions(+), 2 deletions(-)
---
base-commit: cf1182944c7cc9f1c21a8a44e0d29abe12527412
change-id: 20240124-rk-dts-additions-a6d7b52787b9

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


