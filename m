Return-Path: <linux-kernel+bounces-161281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F9D8B4A10
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674AD1C20A74
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DD2C157;
	Sun, 28 Apr 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLwG79hs"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7ED79CF;
	Sun, 28 Apr 2024 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714284539; cv=none; b=smg3MFbr4Qg4X6XVeIZcO2ScGMHuvrzoE3GLWG+qrUWVqB0tQV73mqPz95S/RsFjAPD6PdHkZhLxX0jH0v1xN11bs2Pc8p2s3epJuRvGrvKo5FLDmUCvzui6lVyy3x5EB305r2W2BbyGZuChC24hnXEr8Ls9OsPjg8U7NzgMxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714284539; c=relaxed/simple;
	bh=dG84CmQsboARQ2M2JNXiilDeQ9J4Rkb/1kPusvmnrm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KU34JstrIjoVU0XIDij1brnifJ256Wh8RQQ8siHldW5LyG/u1osgMX6TZ5mQ9iKsFg7kvrVEZEkQia3sNgeMXCM/k9OUzLU1SHEn38ooLHsKIR7QqHtvYdVqG4rA6JW254eavmWTM6HTln0hOrAVaPCZXQ5Y3SdCmiEihUVLFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLwG79hs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f07de6ab93so3223540b3a.2;
        Sat, 27 Apr 2024 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714284537; x=1714889337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NI9A5W3LDtQ0HwJGHFmFDOTVj47cZE4nr8GGIX4pdrA=;
        b=WLwG79hs1oE3wCmQdGHG8m/DHQpMWlkLtjq+wxdqeksrCMjy91Du8ptSm9W6Y5hkdF
         GrIblh3SxWbknXWcD4QiqhzKH0eD/u/UK61vHfWsL/kZY4K2Otey0FFE26gQ9Huz1xZQ
         XQiiNehVxqhz9ly32qUV1F+ki4s5P+TB1Usj/kdypuCcWAMKbaVbLhnq079u2ke8gYDA
         093r4n+1auaBPvvrmBH401alWA62Jz4vbM6giwDPNbX1//IKYjwyk/L7zxYRzJeUi7yy
         agj5Wtz2P7xm6wzDfZ6T5KhYdzi5R/PnivOwwX7U2mMmeLa3XeuRkneoFDjshnEGSP5z
         dMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714284537; x=1714889337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NI9A5W3LDtQ0HwJGHFmFDOTVj47cZE4nr8GGIX4pdrA=;
        b=wE8Ju73sZ9t9QHYuhusjvItT1M4bbHzM55GXMhsNCOGMJVwUbohwW9sp57xkeQYk4g
         5Z+NtFB/bdZ3pwT6P+bOJ0xKh/7TeQGLOgbGJOlZwKDXMsMFxzMViyh8nUDGgiaiv56f
         qHv9yNFpRJ2HvKVlK3S4raxQZqpBpo36QVhi4avGBDhGYRpX3WitiwYHgzXrg0pCcHWT
         CSyFqEJT+c1wCJSJGKnsII656OtDoXW1B28GaM+Mwo9yjDtSBgAcJBiyn+rJ/+s86VlS
         EN4cefy52TeXVQvv9i1VyQgGtnkk7XjEUXJrdXQ5wb2TA9c4jM+0QiNfVqaenCGezxxc
         AA9A==
X-Forwarded-Encrypted: i=1; AJvYcCX6n0fvHSgmvfCDEw2tJLzFl+tyNGTNSf+Mw/L6LBJ7rtvwR/HrTBkK+LCN+W+Qodna7Ljj4fCTcM+YubbxEuNJV+H28sfQ0bk98GEQgW2KRNQU79M6V2QdDyEWXjptLsjnbC1MgLZvMRJQ8Gb7DW+SLMwMQUXfMuA/2PVJSEFM5vuHqQ==
X-Gm-Message-State: AOJu0Yyg3BjxF+1gnmeMYStzkCjx4k8Qhz81tfVw0GBT8F9M+SbC/2b1
	mcRPIyrinJ5azc7gmFzjMB6COdCuiEeciYhxM7o2i6TdLtTKEEq4
X-Google-Smtp-Source: AGHT+IHERhqIfk/gO2h2bzv+XJOcMEnSnmsVUGYOsK+jwOpFsEtUAtZfTvklzjWPM7czXeHN9ImnLQ==
X-Received: by 2002:a05:6a00:a24:b0:6ed:6b11:4076 with SMTP id p36-20020a056a000a2400b006ed6b114076mr9334890pfh.12.1714284536341;
        Sat, 27 Apr 2024 23:08:56 -0700 (PDT)
Received: from localhost ([46.3.240.103])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78648000000b006eade394613sm17156609pfo.198.2024.04.27.23.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 23:08:56 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: dlan@gentoo.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v9 0/2] riscv: rtc: sophgo: add rtc support for CV1800
Date: Sun, 28 Apr 2024 14:08:46 +0800
Message-Id: <20240428060848.706573-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Real Time Clock (RTC) is an independently powered module
within the chip, which includes a 32KHz oscillator and
a Power On Reset/POR submodule. It can be used for time
display and timed alarm generation.

Power On Reset/POR submodule only using register resources
so it should be empty. The 32KHz oscillator only provides
pulses for RTC in hardware.

Changes since v8:
- delete unused macros
- using 0/1 instead of the DISABLE/ENABLE macro
- pass in the correct pointer when applying for IRQ
- convert the incoming pointer into an appropriate
  structure pointer in the irq handler

v8: https://lore.kernel.org/all/20240204044143.415915-1-qiujingbao.dlmu@gmail.com/

Changes since v7:
- pass checkpatch.pl --strict
- using u32 replace uint32
- using devm_kzalloc(*) replace
  devm_kzalloc(sizeof())
- sort header files alphabetically
- delete unnecessary header files
- fix wrap error
- drop dependent description
- using hardware automatic calibration replace
  software calibration. see documentation 197 page

v7: https://lore.kernel.org/all/20240122080500.2621-1-qiujingbao.dlmu@gmail.com/
documentation: https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf

Changes since v6:
- completely delete POR dt node
- remove syscon tag
- use devm_regmap_init_mmio() replace
  syscon_node_to_regmap

v6: https://lore.kernel.org/all/20240115160600.5444-1-qiujingbao.dlmu@gmail.com/

Changes since v5:
- remove unnecessary lock
- fix cv1800_rtc_alarm_irq_enable()
- remove duplicate checks
- using alrm->enabled instead of unconditionally
  enabling
- remove disable alarms on probe
- using rtc_update_irq() replace mess of alarm
- remove leak clk
- useing devm_rtc_allocate_device() and
  devm_rtc_register_device() instead old way
- add judgment for rtc_enable_sec_counter()
- add POR nodes in DTS. This POR device shares
  the register region with the RTC device

v5: https://lore.kernel.org/all/20240108072253.30183-1-qiujingbao.dlmu@gmail.com/

Changes since v4:
- remove POR dt-bindings because it empty
- remove MFD dt-bindings because SoC does
  not have MFDs
- add syscon attribute to share registers
  with POR

v4: https://lore.kernel.org/all/20231229090643.116575-1-qiujingbao.dlmu@gmail.com/

Changes since v3:
- temporarily not submitting RTC driver code
  waiting for communication with IC designer
- add MFD dt-bindings
- add POR dt-bindings

v3: https://lore.kernel.org/all/20231226100431.331616-1-qiujingbao.dlmu@gmail.com/

Changes since v2:
- add mfd support for CV1800
- add rtc to mfd
- using regmap replace iomap
- merge register address in dts

v2: https://lore.kernel.org/lkml/20231217110952.78784-1-qiujingbao.dlmu@gmail.com/

Changes since v1
- fix duplicate names in subject
- using RTC replace RTC controller
- improve the properties of dt-bindings
- using `unevaluatedProperties` replace `additionalProperties`
- dt-bindings passed the test
- using `devm_platform_ioremap_resource()` replace
  `platform_get_resource()` and `devm_ioremap_resource()`
- fix random order of the code
- fix wrong wrapping of the `devm_request_irq()` and map the flag with dts
- using devm_clk_get_enabled replace `devm_clk_get()` and
  `clk_prepare_enable()`
- fix return style
- add rtc clock calibration function
- use spinlock when write register on read/set time

v1: https://lore.kernel.org/lkml/20231121094642.2973795-1-qiujingbao.dlmu@gmail.com/

Jingbao Qiu (2):
  dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
  rtc: sophgo: add rtc support for Sophgo CV1800 SoC

 .../bindings/rtc/sophgo,cv1800-rtc.yaml       |  53 ++++
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-cv1800.c                      | 240 ++++++++++++++++++
 4 files changed, 304 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
 create mode 100644 drivers/rtc/rtc-cv1800.c


base-commit: 1c431b92e21bcbfc374f97d801840c1df47e3d6b
-- 
2.25.1


