Return-Path: <linux-kernel+bounces-103085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B605E87BAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FE82831EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060FA6D1C8;
	Thu, 14 Mar 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwJ3ejFi"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75F4316C;
	Thu, 14 Mar 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410503; cv=none; b=W2sUFIXUxrf+BqsbayveXkwgMKbMPYr86ARR0ExGRSnBNlIHSe/kigzNuiOU3OBBQ6qjJ6/xFNz1xqhlD8j6ZXAj5BpT7tjKjh6pVU4qCwbyfhq96Z7F3Wli0GOoaaXOrk9Sbgoqei1Riwu+K+bVQ4YSTB1R3DDJkEjwiIBRVyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410503; c=relaxed/simple;
	bh=Df14kap9wEZTzQsYhlgPRS9/j8FR9jLTl+XDsI/CjxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=scJQjjwEMO20Vq6VODHkoDURz8l11ANxGwwvvQlcyiDakdyzkYxMIlt7Br0jSMKPLGXhQejk9rNwRy3dqH4X42yPxG9X+QfjA4zsQ4j5bLkByMYpuV2CqldQCO2RU3XrkugUQytLQnhOkRubESGc3L0vDxdxpVuBNlD4Yh2EHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwJ3ejFi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6ca8c8be2so563497b3a.1;
        Thu, 14 Mar 2024 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710410501; x=1711015301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bADiP2JMoy9tupS84LlT0K2ooRmfm9NBpaoBAI0A3AU=;
        b=NwJ3ejFiADgZ0b3AaEbMZiCZp7xFArAu9gPSfxJjJAzjovH7gHaC+DHVWyB/rODg8p
         ZbWaOFIPo9y5rVdnGEfXd9uUDPpuZGp8NEx3Z+X9T71s9+qgsEfViHZINN8PVL1si4g6
         /UeDubHY4ayFpKHN0wbLBrZPC1wr+yUqQ2z4DSY/kN2rAzNlguJkqXBkGfQyYssx2Gec
         uGnP2IijvWggiiXAQabkKTedIOKACwiSTH2yex+iRtSVqmDQen7feQtftG8GGCawdjXO
         mUsXcFn8ACfGGaMj0eBchUqlg0+x+rvpISvKamnl8We+puIk6cmn5gw6PGRD2UScKkgx
         eRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710410501; x=1711015301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bADiP2JMoy9tupS84LlT0K2ooRmfm9NBpaoBAI0A3AU=;
        b=bn5ictTK9TzxeNUYrySnuUTPjvnCefh4ALtPPatXM48yQJfzsAc43yVidwoaGIgUdp
         4eveUFyHqiq+hWx/KwJmeE4am/iF/r4Nq9BQ/+ZcF7TBH9WB6HbWdMxCXDd6o/WSa2Id
         br+ARMThBTy0X6AXXDjI3Nl36qHSY0+Z7nugMt9ETnt6x4bKhf/ABq8Wt/9+rjW8kHci
         W3HKYLmW2Z/c6NxVNDlkvLagSJBkpIQwRK1l5CqEbenLgEx3oS09JSK8DsL7TlhO7Bx/
         cvL4k4yykfEOENaSllBp2q4obx8M2xIi2z4lRJqsiL9v5e/uvpqhYFtK2pLsm90bqZIp
         MEMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOAiKLzTemEdzvnxq+gHdv+V9qBocLdkbV+SpnF8l9UMl3t66AN66UumUUIMrVOY1FyouLpro44wPdCpEXg7vMGbLph1E8/U/NUoWOj88got5PY7Y1Ifu9FVXjLZgNT74tLmPcUCmSmg==
X-Gm-Message-State: AOJu0YyD90RCJ+t/q8RGofvARcJx3M+Ij3FiwodxZBpT7ahXYZAMIwUw
	NfXqNqgiJY0yT88Flt/rHIC13OSDCLkMLWGLeX8OQxHYA8S79PRg
X-Google-Smtp-Source: AGHT+IFFzJM+HQEOJ7Cz4atZvEGs+rBe4yQQcu9ZWDjJnEVxLYoMA196zIfehODsDYXjZPNscvpwDA==
X-Received: by 2002:a05:6a00:23c3:b0:6e6:b129:1842 with SMTP id g3-20020a056a0023c300b006e6b1291842mr1281104pfc.28.1710410500940;
        Thu, 14 Mar 2024 03:01:40 -0700 (PDT)
Received: from localhost ([2001:da8:a801:69b2:6cee:23f3:5da6:de15])
        by smtp.gmail.com with ESMTPSA id lc24-20020a056a004f5800b006e6bda407b6sm1073123pfb.202.2024.03.14.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 03:01:40 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: u.kleine-koenig@pengutronix.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v5 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Date: Thu, 14 Mar 2024 18:01:29 +0800
Message-Id: <20240314100131.323540-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sophgo CV1800 chip provides a set of four independent
PWM channel outputs.
This series adds PWM controller support for Sophgo cv1800.

Changes since v4:
- drop filename
- fix macro
- optimize cv1800_pwm_set_polarity()
- optimize cv1800_pwm_set_oe()
- add comment for cv1800_pwm_set_oe()
- use ticks replace tem
- fix duty_cycle larger than period_val
- use devm_clk_rate_exclusive_get() replace
  clk_rate_exclusive_get()
- map linux polarity to register polarity 

v4: https://lore.kernel.org/all/20240304085933.1246964-1-qiujingbao.dlmu@gmail.com/

datasheet Link: https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
page 614

Changes since v3:
- use macro instead of npwm number
- add support for polarity feature
- add support for Output-Enable/OE feature

v3: https://lore.kernel.org/all/20240223082014.109385-1-qiujingbao.dlmu@gmail.com/

Changes since v2:
- use 0x08 instead of macro
- split if statements based on conditions
- in order to round up, first calculate the
  number of high-level cycles, then subtract
  it from the PERIOD to obtain the number of HLPERIOD
- use new pwmchip_alloc() API instead of old style

v2: https://lore.kernel.org/all/20240212121729.1086718-1-qiujingbao.dlmu@gmail.com/

Changes since v1:
- drop full stop from subject
- re-order maintainers and description
- pass checkpatch.pl --strict
- fix naming errors
- add "Limitations" section
- use a driver specific prefix for all defines
- using bool instead u32 in cv1800_pwm_enable
- check and set state->polarity
- use mul_u64_u64_div_u64
- use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
- using macro definitions instead of shift operations
- remove shift operation on 0
- use priv replace cv_pwm
- hardcode npwm
- set atomic to true
- remove MODULE_ALIAS

v1: https://lore.kernel.org/all/20240207055856.672184-1-qiujingbao.dlmu@gmail.com/

Jingbao Qiu (2):
  dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
  pwm: sophgo: add pwm support for Sophgo CV1800 SoC

 .../bindings/pwm/sophgo,cv1800-pwm.yaml       |  45 +++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-cv1800.c                      | 315 ++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
 create mode 100644 drivers/pwm/pwm-cv1800.c


base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.25.1


