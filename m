Return-Path: <linux-kernel+bounces-147701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42FF8A77F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65997284F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C09A139D18;
	Tue, 16 Apr 2024 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrMsOM/h"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA239FCF;
	Tue, 16 Apr 2024 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307534; cv=none; b=RwsFKdJj73BsmaLleRBrZW0zbUaGA1KLREZUCB5vK2YeIlfySz6HoNPXYe1I0dFspyqktpkB+cPjEmSudVPGCpg57gR1PcgbukqMztv8RxR/66iQFEWy1B3wf3WIWlEGaYAj1WjKwVVlLZuW8wWfdJnnW7vgyeYzX7eWJjENeGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307534; c=relaxed/simple;
	bh=0VzB5+Q9ofJyg0gP34BsSh3BoomupAI0XaVbVIQmrvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NLH89OykdqyWXkwnb+nwLLJEuaLfkdssfo/Qg2xvUGpTe7WaPZi8pVOtVJ3rMYqwQ5GxS2A9A4I7cdNmqKETDiMSnJh/bvoJSg++/I025RrvEYsSTkoTmMTW6/IsBGrk5NLK631Ycoz/aL8ia/OGrS15LhVh38UpNHb1m0S7PgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrMsOM/h; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d6c1e238so5889421e87.2;
        Tue, 16 Apr 2024 15:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307530; x=1713912330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2oB8g0Okh5agcJG9tvO9c1PuQd/hlx4PDEJCTdcM2Ao=;
        b=nrMsOM/h4bD8pjzcADQZe7otCVA/lUshFbkhejN2JFxqM5spTuS4Dy1SxZAnaYl8IZ
         lQyPIbuw7Y4yEjoaNi9kD3cX/Pqn7pNBQQ8P6K2WwwwgtCo4f1u5C98pUQzpo5CyAoqG
         uq7DnEKJT0ohMY+/azCe8/8pShpuxFXVbCu0Z5I0qo2ak1hcXibAlNmk6mxLPW+mb7G8
         zmNpV6FGe7rosd2QYYvu9TdBeV9/nUwRs4wJP77sGoZe1rn9QYBV/s1aWDioCwRUfkWa
         Qm4z4Uwk21XPJ0PgalqUa/daTLTzHlg9smJ048PNblnF0UyPJ6tYajdXRukEy1yA3Hee
         2vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307530; x=1713912330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oB8g0Okh5agcJG9tvO9c1PuQd/hlx4PDEJCTdcM2Ao=;
        b=i9Gv1aSkYOvf/WpCiL7MT4deOPM1zOYBwJAYr1z6yD9uVMZq81CiCEEZgElQUUz/AT
         EtCQPtPrpoOLcBEo/+Fxy+AQsnBljleoy84bwF0wPv7Y8/IWI3O2nCtkfdCfkW2wUTvB
         a8DqgtXyziEXPJYJJ9IpO1xfkDyZHzpZhvgOqUX0rhlHy53XvVgaRZbCSNnyE1sU3giE
         OL1+G9Q1MZ6pGQJNiIHsCs6SGVtDAnBPP4IwubyU51KbxkBbIMm7SRRFi8j8m1j0i2+V
         WLj8NHUV+0pVYyl38dJCR6IQn32Zl3n63qgHpd1zI/1waAsqdD8AUe1ltVyx6APkNxvS
         CASA==
X-Forwarded-Encrypted: i=1; AJvYcCXoyRQ21xZzsR0vXrf5tQoiO8w/lTtbsLIK+KRF3y2hDGVydNanfoDfvAi1/4+Wn2n4MEI2M4yIxbYyO6nf0iugH6qPVR+0Ca0B5kCr
X-Gm-Message-State: AOJu0Yw2Ydz9JKlUtOptykuSO9KKGAl6y6MlQGKUVtMNnNTS3amL4SR2
	7AtOwJ+k930aDVW1PZPRrYOvx0RAn5OpTr4+YCPN9w/luE/KGgN7XxrGgffK/3Q=
X-Google-Smtp-Source: AGHT+IE7qKkZS8qSqRQMj+JPYn3z406l1CKC4weKeOngybrqbedGLlURGfbijluMNWNiMCrZ8OtauA==
X-Received: by 2002:a19:550c:0:b0:519:a55:7ee2 with SMTP id n12-20020a19550c000000b005190a557ee2mr2924570lfe.68.1713307529879;
        Tue, 16 Apr 2024 15:45:29 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id z18-20020a19f712000000b00518e3a194e9sm800726lfe.304.2024.04.16.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:29 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v5 00/16] Omnivision OV4689 refactoring and improvements
Date: Wed, 17 Apr 2024 01:45:08 +0300
Message-ID: <20240416224524.1511357-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is the fourth revision of the series containing refactoring and
new features implementation for the Omnivision OV4689 sensor
driver. Specifically, patches 1, 2, 3, 5, 6, 10, 15, 16 are
refactorings, and are not supposed to introduce any functional
change. Patches 4 and 7 perform migration to CCI helpers and subdevice
active state respectively, and should not introduce any hardware-
and/or user-visible change either. Patch 8 fixes a possible race
condition due to v4l2_async_register_subdev_sensor being called too
early in ov4689_probe, and patch 9 migrates power management to PM
autosuspend.

Patches 11-14 expose more sensor controls to the userspace, such as
(read-write) HBLANK, VFLIP/HFLIP, digital gain, and color balance. It
should be noted that publicly available sensor documentation is
lacking description of many registers and their value ranges, so a lot
of values had to be found by experimentation.

Patches 17-20 from v4 are dropped and will be reintroduced as a
separate series later.

Changes in v5:
- add spaces inside {} in the register tables

Changes in v4:
- rebase on top of media_stage
- collect Reviewed-by's from v3
- add comments "Horizontal" and "Vertical" to TIMING_FORMAT registers
- fix a typo in the commit message in patch 17/20
- remove "__" prefix from stream on/off functions
- rename the label in ov4689_stream_off and remove extra space

Changes in v3:
- rebase on top of media_stage
- collect Reviewed-by and Acked-by from v2
- update copyright year
- zero-initialize ret in ov4689_set_ctrl
- get back blank line before return in ov4689_set_ctrl
- move `sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE` before
  `ov4689_initialize_controls()` in ov4689_probe
- remove blank line after `v4l2_subdev_init_finalize(sd)`
- use pm_runtime_put instead of pm_runtime_put_sync
- add comment for dummy columns/rows defines
- fix OV4689_PIXEL_ARRAY_WIDTH use instead of OV4689_PIXEL_ARRAY_HEIGHT
  in ov4689_get_selection
- split s_stream into two functions for start and stop

Changes in v2:
- collect Laurent's r-b's
- squash together "CCI conversion" and "Set gain in one 16 bit write"
- use ctrl->val in ov4689_set_ctrl
- rename try_fmt to fmt in ov4689_init_cfg and drop corresponding comment
- rebase on top of media-stage and rename init_cfg->init_state
- sort register definitions by address throughout the whole series
- fix number of controls hint in v4l2_ctrl_handler_init
- make all hexadecimal constants lowercase
- disable runtime pm in probe error path
- implement pm autosuspend


Mikhail Rudenko (16):
  media: i2c: ov4689: Clean up and annotate the register table
  media: i2c: ov4689: Sort register definitions by address
  media: i2c: ov4689: Fix typo in a comment
  media: i2c: ov4689: CCI conversion
  media: i2c: ov4689: Remove i2c_client from ov4689 struct
  media: i2c: ov4689: Refactor ov4689_set_ctrl
  media: i2c: ov4689: Use sub-device active state
  media: i2c: ov4689: Enable runtime PM before registering sub-device
  media: i2c: ov4689: Use runtime PM autosuspend
  media: i2c: ov4689: Remove max_fps field from struct ov4689_mode
  media: i2c: ov4689: Make horizontal blanking configurable
  media: i2c: ov4689: Implement vflip/hflip controls
  media: i2c: ov4689: Implement digital gain control
  media: i2c: ov4689: Implement manual color balance controls
  media: i2c: ov4689: Move pixel array size out of struct ov4689_mode
  media: i2c: ov4689: Set timing registers programmatically

 drivers/media/i2c/Kconfig  |   1 +
 drivers/media/i2c/ov4689.c | 671 ++++++++++++++++++++-----------------
 2 files changed, 359 insertions(+), 313 deletions(-)

--
2.44.0

