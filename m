Return-Path: <linux-kernel+bounces-128366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448468959FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08771F24710
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2C215990C;
	Tue,  2 Apr 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSNR2RN4"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E362AD1E;
	Tue,  2 Apr 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076370; cv=none; b=guLtX0llfNNVnN4mGAv7O1HwvFYdkqWk5TckI4VIvjqtZfuVjTQYUegD95Iq5FhzXs6TnVp/94l0UOT/N1yY5Yj9lt4dKcc8vDs2jDRz/gkV5uZ5jhdn9do+eDotE/Vd8/q6uFwM3rv7SoQ5SWFuYN7Z/ci7okSLSulAuyas5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076370; c=relaxed/simple;
	bh=wyuqyuVzJtDl4MDlHcF/zgxnGC0Eo+7SnHjQK5bofCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMSdirUG1FUrvAKbbqx3YvGFWYz4As4OIkdUZgDWQclzbg0zTAN4pHDUheEg7tUR3DILLJr6cn4AeALpqzlV/ACqqMEdAmlJsaRZFrM63+SNzD/NCqg/yfX5/g75OfiL5eaBUI1Zd1q7cXlPuM28AM5OnEE479O+BaSfBGlcDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSNR2RN4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d485886545so89415731fa.2;
        Tue, 02 Apr 2024 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076366; x=1712681166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUHjpil4rDvGTV3dOF5Z7yYlhI4sqmrtKZfpfHGbHjo=;
        b=gSNR2RN4d33ap0162aVcu426ocXn50GOqqQoZuOvVyNm7TtE+Fdorc048QndcHce66
         ufjSqDVqgcStjzVjPjSkPfPExo7H8Fl2k19FefxcqNWnUyHeUZRZ5rf2UxDgWBbsYs1H
         78FWWYpQ+m7Vsk9OtBYlcEil3EnBoXugipfb3HTQjt6SDa2Ay5G/leDM7E9DgbLzSWK9
         HmbkXAeJtM4g3IlfrBxOMAjdKHFFqlIodDiGZjTsk56LTxk2XQ8WB9wWHCG7LBcReNVq
         DdUdX02GTZJbW/xg/O8014uKBFxLUNISvUqs33o6ev2oavmqQ0NdIgalxi/jWDN7tkho
         DHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076366; x=1712681166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUHjpil4rDvGTV3dOF5Z7yYlhI4sqmrtKZfpfHGbHjo=;
        b=Vc7jK/1Qj5XZhKnhu5IpNzBWtZQZqclMelvbknLUXs2ImcU7hz6uXglT4nmYarufiJ
         61e5oAHGLDOBgXU3wv6y4IjwSq537GoROfMqmKWNMJ8lKWCdllW9/kS9XESITRum42sy
         9LypXfCZMZuE8lQbI9FW89QXnZESp0f5KbxgRviqehcYVmuJA3Qwg55+UXn81f16FK1B
         AcVV/C8JAteXi/Lj3eddDZaIhbumcjByJzYDSfWahhlHx1f1DUN8UJUfNuOoiVaH1nJp
         zZo4s0qZu2VKQbCfzAmajv2PQbZitunJTLUvGw2NqAx8BpPhwKvlTduzRBlEzxqzJ0MH
         QH3w==
X-Forwarded-Encrypted: i=1; AJvYcCXMY+ZFg1++WYnVNSv2dKzEjNky74+EH8jY3WZcd4RNgi70QgDEA8IZ7HTtxTJ8308BDOLeMJYsKvqca42xfWExSmik5TZIGav5hHxe
X-Gm-Message-State: AOJu0YxZfpfECK2AGXZnwPA/GfOhOgQ6YBD2i8r4+gT/aAQZ0TQT+DIt
	vkOusrD85wM2luRYUVAC1TwqppRJ79EHe6R7OQSkiERWdDss5Bc3wnFyI3JiMEqLMw==
X-Google-Smtp-Source: AGHT+IFlJ9whIuvxmPUHk3VJHfOQsHQwG7Lb9S9kKtTnPa3yOWqqTuFwE0iHnYVl2EODAwrEYoxkvw==
X-Received: by 2002:a2e:7207:0:b0:2d6:8e88:5a8b with SMTP id n7-20020a2e7207000000b002d68e885a8bmr1931713ljc.32.1712076365372;
        Tue, 02 Apr 2024 09:46:05 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id u11-20020a2eb80b000000b002d436e25f83sm1731976ljo.46.2024.04.02.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:04 -0700 (PDT)
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
Subject: [PATCH v4 00/20] Omnivision OV4689 refactoring and improvements
Date: Tue,  2 Apr 2024 19:45:31 +0300
Message-ID: <20240402164552.19171-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is the fourth revision of the series containing refactoring and new
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
2.44.0

