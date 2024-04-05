Return-Path: <linux-kernel+bounces-132293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75A89929B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022CF1C21966
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C456A538A;
	Fri,  5 Apr 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kxpa2wFs"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D197FF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712277032; cv=none; b=pF6gFw7xtj3eIJ5AK7yjYJt1eYo2anoAQvUFeByiuTFUUCcSyR37Tbq5PM98NcJKBlPbCP5o3yMjvdrFWeueKrhuk5RW0hHFXmlzgfaXInbBLybuVFnDso9SauIVrM3B4AKot85dvS3OR2s9ydlktAYxuKJB9JW3TppDtiL+M1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712277032; c=relaxed/simple;
	bh=jm2S4gXt5t03+EYoZp2cT5abCQ0PDuVgQv0IOQbbDsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhqoCv1A5Fma8MoZ7VSG0wU8JWQ7muq3iiNgJfOybE08v3xARnTwMlOl/amlR6i0baMjfUkSsHYY0xbQ+H63Tx7bNBQ1jNg0vzE4h3VwuP1+/+iyGYBgwP/HDJ0o5XWDBEKCuEEAYtBkUiBbtE0ZOwqv3+mKACOQ4YcfQ2911jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kxpa2wFs; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78d423ab87dso69320685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 17:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712277028; x=1712881828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGt59heqX0LzwtX6QO6FxTaNLRifoHIlymDGYTHl+14=;
        b=Kxpa2wFsJnUkxI3KZ8h/XKqngVhIal5uRK9tSJLCEPTyeI9qt3IkP+ZDx0nDTW5FhO
         CjigdYkjD57jI1PFamOQrum/vTwDYmqR/tGjTQphkexU3yw/lvlOs5tKu1CSpLndVkCi
         dCeUCIPqP99ATCESnyA1kq9VOzQ8sKMVhLbP0VWwo9OsiKG7l9rEMgq1HEYUZVuJZqks
         Liud8dz8tzYuj0tSGzDJmjmgXuEu7By/DUDdAVo5bhxz2ox6QwHOZH/pLaQWSxJc2AMb
         Pa9Lkcsb73kImFS/zru+zzkvg9P9eFJEBX1zsqWoEiXzC9De7A4iSy1dl7NstxXJM7Wa
         o2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712277028; x=1712881828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGt59heqX0LzwtX6QO6FxTaNLRifoHIlymDGYTHl+14=;
        b=YonuKVoexZ6NyBHFytomouDbiFxJakF6d61wrazXReqkG5EETqb8p/qyGPHjsT7jOr
         S8RwXN5foa8kQb4r0h2/efycISNvd5b+meqaOBPdL5MtHn3YDMUgoxB4yThCk+QMz98p
         js/9in//sXbB/jbqm1lCwsTsR2+Bo+GFwxX/8DnCo8G9/uPPv/6A7eiSXGhrxEtYy/vt
         X/Tx6C3BN0n9yCwszUc6aW1vGjzmMdE00e8B4n1exfYfJAqzNyEn6t7G+g1SPueWjdOJ
         E6gFuMfrOwo+2jxGqDDagRBwxD7FjrUIqGM3s/Q+Shtc9SwzzygDBHg3i+tpEZEQtzQR
         kHYA==
X-Gm-Message-State: AOJu0YyJlK/fNs6WWauB0VaoK8/OO0vmW0JHWOXHHM1x9Vdm9N5w7dLP
	vI+A45lkX5emTz7JgrW6EezEz9EBqJ4vbc7D+f5YGM5zAPm88TQFYwEJD225o5odluHOxUSJYDE
	FJc8=
X-Google-Smtp-Source: AGHT+IHx4gIxWhwWoSzOIck3XCQ8tqWEopZ/vzlXy0x9e6etkvAlfJ6lZ2KoG7b6kvOlbBlREJZgFg==
X-Received: by 2002:a05:622a:296:b0:431:51d:42b1 with SMTP id z22-20020a05622a029600b00431051d42b1mr1253239qtw.42.1712277027867;
        Thu, 04 Apr 2024 17:30:27 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id o4-20020ac86d04000000b00432feda5986sm232728qtt.35.2024.04.04.17.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:30:27 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [RFC PATCH 0/3] pwm: add support for duty_offset
Date: Thu,  4 Apr 2024 20:30:22 -0400
Message-ID: <20240405003025.739603-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the PWM subsystem to support the duty_offset feature
found on some PWM devices. It includes a patch to enable this feature
for the axi-pwmgen driver, which can also serve as an example of how to
implement it for other devices. It also contains a patch adding a new
pwm_config_full() function mirroring the behavior of pwm_config() but
with duty_offset included, to help maintain compatibility for drivers
that don't support the feature.

The series was tested on actual hardware using a Zedboard. An
oscilloscope was used to validate that the generated PWM signals matched
the requested ones. The libpwm [1] tool was also used for testing the
char device functionality.

The series is marked RFC as there are some outstanding questions about
implementation:

1. In drivers/pwm/core.c, __pwm_apply() was modified to check that the
sum of state->duty_offset + state->duty_cycle does not exceed
state->period, but in the character device section these values are
being checked separately. Is this intentional? What is the intended
behavior?

2. Should __pwm_apply() explicitly disallow PWM_POLARITY_INVERSED and
duty_offset together?

3. Are there other places that would need duty_offset handling which
have been missed?

Note that in addition to the other patches in this series, the changes
to the axi-pwmgen driver rely on [2] and [3], which haven't been picked
up yet.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git/
[2] https://lore.kernel.org/linux-pwm/20240301173343.1086332-1-tgamblin@baylibre.com/
[3] https://lore.kernel.org/linux-pwm/20240314204722.1291993-1-tgamblin@baylibre.com/

Trevor Gamblin (3):
  pwm: add duty offset support
  pwm: axi-pwmgen: add duty offset support
  pwm: add pwm_config_full to pwm.h

 drivers/pwm/core.c           | 75 +++++++++++++++++++++++++++++++++---
 drivers/pwm/pwm-axi-pwmgen.c | 35 +++++++++++++----
 include/linux/pwm.h          | 52 ++++++++++++++++++++++---
 include/trace/events/pwm.h   |  6 ++-
 4 files changed, 147 insertions(+), 21 deletions(-)

-- 
2.44.0


