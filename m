Return-Path: <linux-kernel+bounces-111583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3D9886E20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC761F22973
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A01481D7;
	Fri, 22 Mar 2024 14:10:33 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27C81CA80;
	Fri, 22 Mar 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116632; cv=none; b=P8OLKkKkeRx3y+59w4i004huBjv9WfWVe8A1DLjEKu9qx9oIDTxxH6Cxlidfe7KWZpgH/IoDQsTPkNk/MbZBMCPzyD4wXI9kc4FmhUYRELJXQOJUteaDPQNS+hv9hNJ31U0iSPZwHM4C+RbZfx3CGUx72fezWmJqn3uyKF4Pz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116632; c=relaxed/simple;
	bh=oQuYmWVqALX8DuaBrS27WLrJOU8gMDweyWEs5gjnIaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLFoS50s03dLib3Hj3lXUwHhg6497atvoiem/RMu9MRLtt+wn8nfCXM1Gk04tQGps3I84zOE8nDXag2ksF3XM2rXsKqPfu982Dw3xFfhw8i6MqPzV8Hn1BwS1s12meCGavkn0M9rYKWqfoPHKzTWdjT0pISDMa6HGBUiEzUhXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.. (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 8E6A367184;
	Fri, 22 Mar 2024 15:10:22 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v4 3/3] media: mgb4: Fixed signal frame rate limit handling
Date: Fri, 22 Mar 2024 16:10:05 +0100
Message-ID: <20240322151005.3499-4-tumic@gpxsee.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322151005.3499-1-tumic@gpxsee.org>
References: <20240322151005.3499-1-tumic@gpxsee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Properly document the function of the mgb4 output frame_rate sysfs parameter
and fix the corner case when the frame rate is set to zero causing a "divide
by zero" kernel panic.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 Documentation/admin-guide/media/mgb4.rst |  8 ++++++--
 drivers/media/pci/mgb4/mgb4_sysfs_out.c  |  9 +++++----
 drivers/media/pci/mgb4/mgb4_vout.c       | 12 ++++++------
 drivers/media/pci/mgb4/mgb4_vout.h       |  2 +-
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
index 2977f74d7e26..6fff886003e2 100644
--- a/Documentation/admin-guide/media/mgb4.rst
+++ b/Documentation/admin-guide/media/mgb4.rst
@@ -228,8 +228,12 @@ Common FPDL3/GMSL output parameters
     open.*
 
 **frame_rate** (RW):
-    Output video frame rate in frames per second. The default frame rate is
-    60Hz.
+    Output video signal frame rate limit in frames per second. Due to
+    the limited output pixel clock steps, the card can not always generate
+    a frame rate perfectly matching the value required by the connected display.
+    Using this parameter one can limit the frame rate by "crippling" the signal
+    so that the lines are not equal but the signal appears like having the exact
+    frame rate to the connected display. The default frame rate limit is 60Hz.
 
 **hsync_polarity** (RW):
     HSYNC signal polarity.
diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_out.c b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
index f67ff2a48329..573aa61c69d4 100644
--- a/drivers/media/pci/mgb4/mgb4_sysfs_out.c
+++ b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
@@ -229,9 +229,9 @@ static ssize_t frame_rate_show(struct device *dev,
 	struct video_device *vdev = to_video_device(dev);
 	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
 	u32 period = mgb4_read_reg(&voutdev->mgbdev->video,
-				   voutdev->config->regs.frame_period);
+				   voutdev->config->regs.frame_limit);
 
-	return sprintf(buf, "%u\n", MGB4_HW_FREQ / period);
+	return sprintf(buf, "%u\n", period ? MGB4_HW_FREQ / period : 0);
 }
 
 /*
@@ -245,14 +245,15 @@ static ssize_t frame_rate_store(struct device *dev,
 	struct video_device *vdev = to_video_device(dev);
 	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
 	unsigned long val;
-	int ret;
+	int limit, ret;
 
 	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		return ret;
 
+	limit = val ? MGB4_HW_FREQ / val : 0;
 	mgb4_write_reg(&voutdev->mgbdev->video,
-		       voutdev->config->regs.frame_period, MGB4_HW_FREQ / val);
+		       voutdev->config->regs.frame_limit, limit);
 
 	return count;
 }
diff --git a/drivers/media/pci/mgb4/mgb4_vout.c b/drivers/media/pci/mgb4/mgb4_vout.c
index a6b55669f0a8..cd001ceaae63 100644
--- a/drivers/media/pci/mgb4/mgb4_vout.c
+++ b/drivers/media/pci/mgb4/mgb4_vout.c
@@ -680,12 +680,12 @@ static void fpga_init(struct mgb4_vout_dev *voutdev)
 	mgb4_write_reg(video, regs->config, 0x00000011);
 	mgb4_write_reg(video, regs->resolution,
 		       (DEFAULT_WIDTH << 16) | DEFAULT_HEIGHT);
-	mgb4_write_reg(video, regs->hsync, 0x00102020);
-	mgb4_write_reg(video, regs->vsync, 0x40020202);
-	mgb4_write_reg(video, regs->frame_period, DEFAULT_PERIOD);
+	mgb4_write_reg(video, regs->hsync, 0x00283232);
+	mgb4_write_reg(video, regs->vsync, 0x40141F1E);
+	mgb4_write_reg(video, regs->frame_limit, DEFAULT_PERIOD);
 	mgb4_write_reg(video, regs->padding, 0x00000000);
 
-	voutdev->freq = mgb4_cmt_set_vout_freq(voutdev, 70000 >> 1) << 1;
+	voutdev->freq = mgb4_cmt_set_vout_freq(voutdev, 61150 >> 1) << 1;
 
 	mgb4_write_reg(video, regs->config,
 		       (voutdev->config->id + MGB4_VIN_DEVICES) << 2 | 1 << 4);
@@ -711,8 +711,8 @@ static void debugfs_init(struct mgb4_vout_dev *voutdev)
 	voutdev->regs[3].offset = voutdev->config->regs.hsync;
 	voutdev->regs[4].name = "VIDEO_PARAMS_2";
 	voutdev->regs[4].offset = voutdev->config->regs.vsync;
-	voutdev->regs[5].name = "FRAME_PERIOD";
-	voutdev->regs[5].offset = voutdev->config->regs.frame_period;
+	voutdev->regs[5].name = "FRAME_LIMIT";
+	voutdev->regs[5].offset = voutdev->config->regs.frame_limit;
 	voutdev->regs[6].name = "PADDING_PIXELS";
 	voutdev->regs[6].offset = voutdev->config->regs.padding;
 	if (has_timeperframe(video)) {
diff --git a/drivers/media/pci/mgb4/mgb4_vout.h b/drivers/media/pci/mgb4/mgb4_vout.h
index ab9b58b1deb7..adc8fe1e7ae6 100644
--- a/drivers/media/pci/mgb4/mgb4_vout.h
+++ b/drivers/media/pci/mgb4/mgb4_vout.h
@@ -19,7 +19,7 @@ struct mgb4_vout_regs {
 	u32 config;
 	u32 status;
 	u32 resolution;
-	u32 frame_period;
+	u32 frame_limit;
 	u32 hsync;
 	u32 vsync;
 	u32 padding;
-- 
2.44.0


