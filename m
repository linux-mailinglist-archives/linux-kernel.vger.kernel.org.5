Return-Path: <linux-kernel+bounces-25381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B5B82CEF5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 23:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21621F22001
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F6417BD0;
	Sat, 13 Jan 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NNRgbx92"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7282168A3;
	Sat, 13 Jan 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-558eedb6fd8so799076a12.2;
        Sat, 13 Jan 2024 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705186017; x=1705790817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PAv5l0VtvnO1pRB8FcDO9H9jLbmc1LXe0iJC5gP0mFM=;
        b=NNRgbx92Nmj41z2h1FF/D/j140z0wrjot3HZ8szbHUOOaDjR2QMBZ21bLuI9GoHD9a
         iSx7Eq1WZlDeiRtyDdQQ8fgux2g23CUOOlbebMnSMNBGU1Wu6AAJx6+Y/BehwJQ4bNcf
         cvYrtnAkFTtFPw4tNHwOoo690oML1QZTR0AYHmZEZX9cr/YudirMTUEP2MJQuXGeqvt7
         CqAiEkt3hJvM2zi8YZD+fEa/yXYQHgnE9zVzGrtZwXYVG57OnlylIDtQP6HOsTM7sPA7
         YC3A7H/3eotQqmjYuJMjF5Z2UBdCZ8WUiOiRGRlsuD0peILBIB1Qy1UqtRovt+OQD8Tp
         bNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705186017; x=1705790817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAv5l0VtvnO1pRB8FcDO9H9jLbmc1LXe0iJC5gP0mFM=;
        b=bVZwPC/1XGA0gz5aqTrWRRsJ9F2pGg+cXgO6KHYpw3EEOMl3z8fii2uNYv9qefddWj
         d9GkEqBk8kaoAC31+iIBqacwUxNg8viP9Cg/7v+CMssRTKWb+mrYm+7rV9r5hpqzj7+B
         yhrVhiRVBnYd0P/upI1xdg1BM4Zc0SZXpOrp9pnWPR38ztGvnVP7+9bMj2qIDa1o619x
         Do6SgdaoqJQ1w0CRCVY1LPDvgc7BvZ17X13cj5buTODTnb5llmGQBbu2cWFxL2hEKlDm
         WHtHl3c1s/VMkQcT7XyYHNzAvOAroYvZ3k6tJU8K1tNQmy/bxrIW9yv5saYQMqJYJze5
         7N/Q==
X-Gm-Message-State: AOJu0YwxKZUQx3qF/eiv57VLAMqPRhqQw8f/D093gqgAvPGiwiYMDyy9
	R2dLyG0F+VPYxEMOJfCV3Vk=
X-Google-Smtp-Source: AGHT+IFg0Jc9rGZcwGGkPbHFtCvCtdIraNk6iU99Ny4eASgGfZGCe+646zfhY31ak/W99X7fBqqqPA==
X-Received: by 2002:a17:906:7c59:b0:a29:f55d:e1a6 with SMTP id g25-20020a1709067c5900b00a29f55de1a6mr1593516ejp.105.1705186016494;
        Sat, 13 Jan 2024 14:46:56 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-6fe7-c700-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:6fe7:c700::e63])
        by smtp.googlemail.com with ESMTPSA id g18-20020a170906595200b00a2d4e658132sm755409ejr.42.2024.01.13.14.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 14:46:56 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v2 0/3] regulator: pwm-regulator: Fixes for disabled PWMs at boot
Date: Sat, 13 Jan 2024 23:46:25 +0100
Message-ID: <20240113224628.377993-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the second version of an attempt to fix booting mainline Linux
on Meson8b Odroid-C1.
This series is an update to an RFC patch that I sent some time ago [0]
and incorporates a lot of the feedback from that v1.

The main changes since v1 [0] are:
- new patch checking the voltage limits in pwm_regulator_get_voltage()
- updated calculation for disabled regulators in+
  pwm_regulator_get_voltage() utilizing above limit checking
- new pwm_regulator_init_boot_on() to preserve the output voltage when
  pwm_regulator_enable() later enables the PWM output without and
  preceding pwm_regulator_set_voltage().


[0] https://lore.kernel.org/linux-pwm/20231221211222.1380658-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (3):
  regulator: pwm-regulator: Add validity checks in continuous
    .get_voltage
  regulator: pwm-regulator: Calculate the output voltage for disabled
    PWMs
  regulator: pwm-regulator: Manage boot-on with disabled PWM channels

 drivers/regulator/pwm-regulator.c | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

-- 
2.43.0


