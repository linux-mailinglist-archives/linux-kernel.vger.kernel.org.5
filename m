Return-Path: <linux-kernel+bounces-87106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE5486CFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D82B24C21
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A6B6CBF7;
	Thu, 29 Feb 2024 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1EhP9C1"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A23770C;
	Thu, 29 Feb 2024 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225632; cv=none; b=JmN+uJpXNm/COot6FUhKpAApWBOjHxvJ8271echAyqguaJZIPD0zQPAvugq2RAqyh3n3yfBLznLwahOVNxImibEL6ViErlBX+rZAjk2Lqq7U/xOXwSMqp8t21fY2XnTBanTv4OUCJ3v2C+DYNfXyDvfOYmrUOzj9rYWpZQuwWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225632; c=relaxed/simple;
	bh=6nUDMEYGUfxHVEKkeMkr+OYMLMqJ1KXcgPHzN5jW+is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/5S74E1XjyNNDDvWGt9Bpsnjg7lusmfCI/brl84kLVdX6QAoeafbqf5mCSd2bOz9duWor8Ef195PAZPZzMwde9Gc5Q5pMcVmzlBAwlkVSf+nMU3jnTOiEnRxtCIsTcdvsQMX74ohisvOhjjs+wy6RaCoJwtSR0CGLMvMCLrrJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1EhP9C1; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d29111272eso13809351fa.0;
        Thu, 29 Feb 2024 08:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225626; x=1709830426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDgRtT3BGtrQFTqpJ/xCmUJivNRGOmFTEriQdIVVtdY=;
        b=a1EhP9C16OgQqfPmftXOS66SjGgOwxjajY2bODVqlP+qrwl4j9Yyh9i9OxRMk1+o+O
         lAAbT5P6RfWchNBf2O1KLh6SJs1ZlCiEKW0sbO/XGY8FDunJkH52aKrJzhwg/hwsxgGb
         ZVR5n4gffgMPVM2AT2Lr95DXJapXnFqQtqzshpXd48tknLNZM/zCu4An4sVjhW310vzg
         Kmz9DPLYx6BIJv6Gu3vUYCKIyNfu22n3opfcaZ5fSh0iN/17ldtMErqUMIEDq25drLvZ
         IUZT6cV2xNJBkvf2JxCwwEYWhIdDE90wXm/OY4uzGvsP8M5iIiKStMm3+J03Xu6sni4M
         Vtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225626; x=1709830426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDgRtT3BGtrQFTqpJ/xCmUJivNRGOmFTEriQdIVVtdY=;
        b=IRWdM63MqnpUK3NG5gGBt14vrgMuqYFIBvfIwvm1dtSHksagfWUQ8CDBpPe7+QMVBg
         DUgXBJ/cDD92DmSGy2Wo/ShsFfH5eZZ1QyI6CgyF+mdK+nUtc5nSTxDgoVP34x37vD3z
         qaIT0TmCstxog+E7pR8Xg6NHTte2/aogDqY+1CRL9ABeyEUmID1HnaGD7Oabxcu8GFSY
         TWTh8n9Y1xAjjYoyPMztuXcj5zxSbyJJOlJaGjoDO23XgK2UKA7rABdKZYdpyQ4NWyJO
         mOVqhOOMCbtNfTlfixU7cHBeP/PzDeIzcssdSyMclS0AxaQzUZ/jKS2uKeC7NwHEsmaN
         dF1w==
X-Forwarded-Encrypted: i=1; AJvYcCWwDBv3MPNRLRAHKGKLTRY3NKedzveRWykhNDIXr4fGAhPnBezFL/nF+AHAOWH9/bjbCvK77KC5gXHXjtEPMP6sX/oG/lMIdz0I0GB9
X-Gm-Message-State: AOJu0YxPTQhDgsbfA51KqLTzaqFruZR4uLYAf48hbOptPMHXX2C1A7MH
	SpNJj5SbwNfDGMqbttsi/JW1D2CGNMTm1XlMWn/LYq5skRo80tKODDmKlc+/PHA=
X-Google-Smtp-Source: AGHT+IHrnNQ+VZCSRL3mER8oBxjLgfoNFkSHy2jOgg1LGXnuP4+EA4v1I0ExQfvPntbXGRVwiw+43Q==
X-Received: by 2002:a2e:9613:0:b0:2d2:ed31:9fa6 with SMTP id v19-20020a2e9613000000b002d2ed319fa6mr1751801ljh.49.1709225625789;
        Thu, 29 Feb 2024 08:53:45 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id a26-20020a05651c031a00b002d318451854sm106048ljp.113.2024.02.29.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:53:45 -0800 (PST)
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
Subject: [PATCH v3 00/20] Omnivision OV4689 refactoring and improvements
Date: Thu, 29 Feb 2024 19:53:13 +0300
Message-ID: <20240229165333.227484-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is a third revision of the series containing refactoring and new
features implementation for the Omnivision OV4689 sensor
driver. Specifically, patches 1, 2, 3, 5, 6, 10, 15, 16, 18, and 19
are refactorings, and are not supposed to introduce any functional
change. Patches 4 and 7 perform migration to CCI helpers and subdevice
active state respectively, and should not introduce any hardware-
and/or user-visible change either. Patch 8 fixes a possible race
condition due to v4l2_async_register_subdev_sensor being called too
early in ov4689_probe, and patch 9 migrates power management to PM
autosuspend.

Patches 11-14 expose more sensor controls to the userspace, such as
(read-write) HBLANK, VFLIP/HFLIP, digital gain, and color
balance. Patch 17 implements configurable analogue crop rectangle via
set_selection callback. And finally, patch 20 enables 2x2 binning
option. It should be noted that publicly available sensor
documentation is lacking description of many registers and their value
ranges, so a lot of values had to be found by experimentation.

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

Mikhail Rudenko (20):
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
  media: i2c: ov4689: Configurable analogue crop
  media: i2c: ov4689: Eliminate struct ov4689_mode
  media: i2c: ov4689: Refactor ov4689_s_stream
  media: i2c: ov4689: Implement 2x2 binning

 drivers/media/i2c/Kconfig  |    1 +
 drivers/media/i2c/ov4689.c | 1003 ++++++++++++++++++++++--------------
 2 files changed, 618 insertions(+), 386 deletions(-)

--
2.43.0

