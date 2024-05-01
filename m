Return-Path: <linux-kernel+bounces-165035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7266D8B86E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14502811D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE7A502B9;
	Wed,  1 May 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCKABiGI"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FDB1DA4C;
	Wed,  1 May 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552370; cv=none; b=UAxe7hZEh4yzG5F4DTmYNXwH1oyYlFrmqcdDpPrQojnLZHqFU9+SuxeEYK0Xr2a+xHbmJwnTtG+9CVztYm/FQ6Hp0pFT50g0MVFvWkPH5Db5YPMIm8ytW/hmnb7eMdT6GjKLinnJsTCvFMcNOWqpnoOf0HH0qL/p0nGPZHk75Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552370; c=relaxed/simple;
	bh=022s0DMx01dj0809aHOZNTIDH54IcHq2bcPlkyclrt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pec5uVjwQbH1uoB/TdQ+agjx6916AljJy+LCzeSkK68cLOA5WfzqRM9tN3iM5dEEoKgGyrJA6YdgAQG2GNshcMOphtRUYR7fJ/jyHvHdsD6s+Pbg4s8kJCu8tk/kapaafn60gnB1T3mDM8hoLfjin93OEwwGBKAjmXg/Cfg6GkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCKABiGI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e51398cc4eso58351435ad.2;
        Wed, 01 May 2024 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714552368; x=1715157168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHgX42UfUGRGX78Ivvg9lI7RMb4di4wjmmdmQo/NqGs=;
        b=FCKABiGI2fSLrEwepdZ28JNHaoPiK2TxC2ktmjN1nMt9uk0KOiWllrv7XQXgviIbmd
         wPzdW9Mu+iaRPInwhSpm68diL8rIcyd840IEsTKiUrPkrni4RQ/g5l+hqDCtj9LGBRZo
         j6c0Op03573jYk6yWMC4YzldKXBwOSZpNNu+uupaHaMCFfGuFm7j0/b6cpgnSvMe4PNp
         p7HDD0m1vpdJHpdy9N7Lhaa9SH7RChdGk+/6/OalAF7xCBzz1zparD076w4MnTmHrn4/
         PuIv9SP3CZ4+jvzMsJY2VbTKp00r+ocOYHePhuqvhD4PU9nn9Vzv+/sFNFcYk7zDI/ah
         NNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714552368; x=1715157168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHgX42UfUGRGX78Ivvg9lI7RMb4di4wjmmdmQo/NqGs=;
        b=FwWUg02moK7V2U3On4M0YvYXF0jcWK54uBn+vZhl4TYLrAeEU5phwfG02PjQwhcr/U
         E/hfR0aBYYoAWFSyvQ9AD7vL8ectU7be+PYz9euLlPScGGiAhu26IcxR+IqWVGSy8Wxv
         dRHil07Ul/pooNPdVJhzHYbfI7tR7HKNhkJZtx0RAKm/0jO+HJCa2p+lFMJdpNCgqEKi
         if393yzHvfmVip6aRIyXAFp76YsVuqm/UVqrra57OqfLNfWaAHMTsaE+58CqUnfAoOlv
         0L/dimrf9MtPw7Zmq5bLggcSG7Z8rC79dLr9vfCfdnPjc+Cne1IG/qaIyiTrhacqTO6X
         2tIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTUIQQcZveNxMZxJnbNPaVin/XXhLHy5AiFcFeYNs5r6O4cIQXWgyVTVLXzki0+mTRcSZzsppjsHgjZDwGj5/4tolzGjnM6fN6sXja3Ea8T6wewUMufwc3kz1KmMF9dVCnNc8PyJsAwZj3hKjt8cEiKBUiYADBjkDo7+/aQHQpa+beVw==
X-Gm-Message-State: AOJu0YytA7FImKUaj4V8vtr/GQyjt/0LLeqHpBteGcp4zczBNBaGEWMv
	jd59LdhJD/csbfM6d44GqtBhQtRFZ7MRMmIheAcdww8yiTxWLPM0
X-Google-Smtp-Source: AGHT+IGVmAU0ocOEPEAiaXOyjcCYrseaEMIut51PWpsmGN+SgT6XgmAwMY6nwemsP9Ut6K6YeB7efw==
X-Received: by 2002:a17:903:120b:b0:1e5:a025:12f9 with SMTP id l11-20020a170903120b00b001e5a02512f9mr2569146plh.28.1714552367572;
        Wed, 01 May 2024 01:32:47 -0700 (PDT)
Received: from localhost ([39.152.149.70])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001e49428f327sm23758946plf.176.2024.05.01.01.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 01:32:47 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com
Cc: dlan@gentoo.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v7 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Date: Wed,  1 May 2024 16:32:40 +0800
Message-Id: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
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

Changes since v6:
- add detailed Limitations
- using BIT(n) instead BIT(0) << n
- use 0 instead of disable macro
- modify OE judgment criteria
- add devm_regmap_init_mmio error message
- delete unused variable

v6: https://lore.kernel.org/all/20240406063413.3334639-1-qiujingbao.dlmu@gmail.com/

Changes since v5:
- delete the OE function because we plan to use the counter subsystem
  instead of capture, so there is no need to reuse this code.
- fix set polarity reverse error.

v5: https://lore.kernel.org/all/20240314100131.323540-1-qiujingbao.dlmu@gmail.com/

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
 drivers/pwm/pwm-cv1800.c                      | 293 ++++++++++++++++++
 4 files changed, 349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
 create mode 100644 drivers/pwm/pwm-cv1800.c


base-commit: 32c44e1fa921aebf8a5ef9f778534a30aab39313
-- 
2.25.1


