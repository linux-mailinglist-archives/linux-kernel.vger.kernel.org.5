Return-Path: <linux-kernel+bounces-61002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520D9850C45
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0399E282732
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840039AFD;
	Sun, 11 Feb 2024 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="A98DfG8n"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636117C60
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693357; cv=none; b=q3AV5pQJrEve/+LCm88WOFMFMjpfpF3TRJmMtgiQW2IPO7sUUKOyFZYVyIAnYXb74nd067zGagQXeS5GAFkhKwzOADyhJlmoqfIYc8m2ekNSRxtvp8EtTfRzpOCL/QCp0BAW92fOHEGZZ+br8Ln+s7iZ7qbVSbiMXXXE1RSnJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693357; c=relaxed/simple;
	bh=tDggXG/cf55a0q6LxotFBFlEle9lDrYwqcOX09ziYD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJOpWjRWfvQWNBtb/f+FYq66XWxRYV336GCBUnpOffie1te0eGwybqNX5Oq3/lvau21VS1JfgDNGToIMmbI8kIdPiMc9BMyXlKIJQJUMmq//A9qN25TUqGj46OqjbfQ0DnfUOpkuFxQQeVnEO7shWuEWovBkXJfakP5CYJyeev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=A98DfG8n; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so3859307a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693348; x=1708298148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkBKq3xTlr2ouWRmtnOSWyY8EdO4jze66ij3tm/tNn8=;
        b=A98DfG8nDME9gkJMpy8rvHUOf1R5iMqGsq+taysoYiiGy7CyDt+kk8AkuX0O2FRROs
         EZZS82GpJLBrl/OvX6CR15Y8Z68Uc80Ahc4tK110X4CUJ1nGGC7r6Wo4rvXVdVErgxu5
         IbeasBBzvaIo6pbGNvaRf8Fm3pCsIgIObsCgcKT1rbkz6v83LgKDqzsiNFfNgr0CgCK7
         CrxTz6VUtE5lCygH59d/+KrTUpUe6H3tyYyE0BJYHywzUuDws5tBQV+GAFDZliOCCFHT
         9xPIVLxeKq4vPXsSP/gYRPDjID0SRgkHjeaRImo8uZ1RawJMbOG1nMusk47W6d1zlPkX
         bj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693348; x=1708298148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkBKq3xTlr2ouWRmtnOSWyY8EdO4jze66ij3tm/tNn8=;
        b=sghTXpYsB3OtuL//rgstBQjM+3ELrpCf8y4duMj3Rp2mj0UKJplaAGV5/2nanabEwd
         onps6LzuTnHfTxviCfo/TxtkOgzt4ul8AAkd+oiQOU6J+TGz6NtSkRo2hvghlGZTTmJF
         CLbZmIkfTqfR/cJbWBmVRzU0KQFWTu0T4UJ4FSiFTQ1WCkPe0pjQXmtYlCGLq0efCrWL
         4J6lSQGz2YIeZjXm1WGUGaR9U0/KZAmal9aO5fesvtwgZUoPgMMEL4LjBt0Xtfl0nFum
         tmtyj8IudApmkwokcFX9A2QGX/o3A1EaP0axqMnL1AqRWIuCRzU17hULAVfW1Ig1WoQM
         hFbQ==
X-Gm-Message-State: AOJu0Ywf41m9j5cB9Dn/CU3KBggTta1YU2xUevfx+RHjJtoHNkOlKwsE
	Yqfc14NUbFh9RzKeMW3ecNi7GohYJ1IYHAJ4ak5hT/ADB3YK14Velb+VlV2Iyl8k7ELUdkk/0Qw
	E
X-Google-Smtp-Source: AGHT+IFI52l/+FJBzTgKjSx37oABMu/kCavrw5PXKKYrdKlXVqAZpE8rbv6szJfPcS7Ydu5RZ9Hx3A==
X-Received: by 2002:aa7:d7c9:0:b0:55f:fd77:7b2d with SMTP id e9-20020aa7d7c9000000b0055ffd777b2dmr3243418eds.5.1707693347760;
        Sun, 11 Feb 2024 15:15:47 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:47 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 16/35] device.h: move declarations to device_types.h
Date: Mon, 12 Feb 2024 00:14:59 +0100
Message-Id: <20240211231518.349442-17-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 block/disk-events.c                           |   1 +
 block/early-lookup.c                          |   1 +
 block/partitions/core.c                       |   1 +
 drivers/counter/counter-chrdev.c              |   1 +
 drivers/cxl/cxl.h                             |   1 +
 drivers/devfreq/devfreq-event.c               |   1 +
 drivers/extcon/extcon.h                       |   2 +-
 drivers/gpu/drm/mcde/mcde_clk_div.c           |   1 +
 .../gpu/drm/renesas/rcar-du/rcar_du_encoder.c |   1 +
 .../drm/renesas/rcar-du/rcar_du_writeback.c   |   2 +
 drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c       |   1 +
 drivers/gpu/drm/tidss/tidss_encoder.c         |   1 +
 drivers/gpu/drm/tidss/tidss_plane.c           |   1 +
 include/linux/acpi.h                          |   2 +-
 include/linux/backlight.h                     |   2 +-
 include/linux/blk_types.h                     |   2 +-
 include/linux/blkdev.h                        |   2 +-
 include/linux/container.h                     |   2 +-
 include/linux/coresight.h                     |   2 +-
 include/linux/counter.h                       |   2 +-
 include/linux/devfreq-event.h                 |   2 +-
 include/linux/devfreq.h                       |   2 +-
 include/linux/device.h                        | 466 +---------------
 include/linux/device_types.h                  | 501 ++++++++++++++++++
 include/linux/dmaengine.h                     |   2 +-
 include/linux/edac.h                          |   2 +-
 include/linux/enclosure.h                     |   2 +-
 include/linux/fpga/fpga-bridge.h              |   2 +-
 include/linux/fpga/fpga-region.h              |   2 +-
 include/linux/framer/framer.h                 |   2 +-
 include/linux/hdmi.h                          |   2 +-
 include/linux/hwmon-sysfs.h                   |   2 +-
 include/linux/iio/iio.h                       |   2 +-
 include/linux/lcd.h                           |   2 +-
 include/linux/node.h                          |   2 +-
 include/linux/peci.h                          |   2 +-
 include/linux/pm_clock.h                      |   2 +-
 include/linux/pm_domain.h                     |   2 +-
 include/linux/pm_qos.h                        |   2 +-
 include/linux/power_supply.h                  |   2 +-
 include/linux/powercap.h                      |   2 +-
 include/linux/rtc.h                           |   2 +-
 include/linux/swiotlb.h                       |   3 +-
 include/linux/thermal.h                       |   2 +-
 include/linux/w1.h                            |   2 +-
 include/media/cec.h                           |   2 +-
 include/media/media-devnode.h                 |   2 +-
 include/net/nfc/nfc.h                         |   2 +-
 include/pcmcia/ss.h                           |   2 +-
 include/scsi/scsi_device.h                    |   1 +
 kernel/trace/blktrace.c                       |   1 +
 51 files changed, 552 insertions(+), 501 deletions(-)
 create mode 100644 include/linux/device_types.h

diff --git a/block/disk-events.c b/block/disk-events.c
index f9ec09799906..86b3a7b6ccdf 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/moduleparam.h>
 #include <linux/blkdev.h>
+#include <linux/device.h>
 #include <linux/kobject.h>
 #include "blk.h"
 #include <linux/sprintf.h>
diff --git a/block/early-lookup.c b/block/early-lookup.c
index 0862a56c25ac..0bfb6b3fecf5 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -5,6 +5,7 @@
  */
 #include <linux/blkdev.h>
 #include <linux/ctype.h>
+#include <linux/device.h>
 #include <linux/kstrtox.h>
 #include <linux/sprintf.h>
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b56add574054..576118154d57 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -9,6 +9,7 @@
 #include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
+#include <linux/device.h>
 #include <linux/sprintf.h>
 #include <linux/vmalloc.h>
 #include <linux/raid/detect.h>
diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index afc94d0062b1..7d3e44315c8c 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -5,6 +5,7 @@
  */
 #include <linux/cdev.h>
 #include <linux/counter.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/export.h>
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 784bcd943215..0c4b2b3f6217 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -7,6 +7,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/device_types.h>
 #include <linux/device/driver.h>
 #include <linux/log2.h>
 #include <linux/node.h>
diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 649971baca70..48237648615a 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/devfreq-event.h>
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/init.h>
diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index b2e0f715d81c..1b850b2a06ac 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_EXTCON_INTERNAL_H__
 #define __LINUX_EXTCON_INTERNAL_H__
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/extcon-provider.h>
 
 /**
diff --git a/drivers/gpu/drm/mcde/mcde_clk_div.c b/drivers/gpu/drm/mcde/mcde_clk_div.c
index 3056ac566473..ac90497d366a 100644
--- a/drivers/gpu/drm/mcde/mcde_clk_div.c
+++ b/drivers/gpu/drm/mcde/mcde_clk_div.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/clk-provider.h>
+#include <linux/device.h> // for devm_kzalloc()
 #include <linux/io.h>
 #include <linux/regulator/consumer.h>
 
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
index 7ecec7b04a8d..18842d466b74 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
@@ -7,6 +7,7 @@
  * Contact: Laurent Pinchart (laurent.pinchart@ideasonboard.com)
  */
 
+#include <linux/device.h> // for dev_dbg()
 #include <linux/export.h>
 #include <linux/of.h>
 
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index 8cd37d7b8ae2..0fb49db3a5b6 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -13,6 +13,8 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_writeback.h>
 
+#include <linux/device.h> // for dev_dbg()
+
 #include "rcar_du_crtc.h"
 #include "rcar_du_drv.h"
 #include "rcar_du_kms.h"
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c b/drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c
index 03d7de1911cd..e27219f38e80 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/device.h> // for devm_kzalloc()
 #include <linux/regmap.h>
 
 #include "sun4i_tcon.h"
diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 17a86bed8054..c002c07f262e 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -4,6 +4,7 @@
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
+#include <linux/device.h> // for dev_dbg()
 #include <linux/export.h>
 
 #include <drm/drm_atomic_helper.h>
diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index 2d9cc2b12cc6..13aac5a6ec21 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -11,6 +11,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
+#include <linux/device.h> // for dev_dbg()
 
 #include <linux/device.h> // for dev_dbg()
 #include <linux/slab.h>
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3beab76d31d4..9f0a021dfef3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -11,7 +11,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>	/* for struct resource */
 #include <linux/resource_ext.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/uuid.h>
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 614653e07e3a..9164ee5f1c8b 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -9,7 +9,7 @@
 #ifndef _LINUX_BACKLIGHT_H
 #define _LINUX_BACKLIGHT_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/fb.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 9d2d8a8328a6..96a37f399928 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -8,7 +8,7 @@
 
 #include <linux/types.h>
 #include <linux/bvec_types.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/ktime.h>
 
 struct bio_set;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2a8df9c0e87b..7e1fc101a5c3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 #include <linux/fs.h> // for inode_unhashed()
 #include <linux/blk_types.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/list.h>
 #include <linux/minmax.h>
 #include <linux/timer_types.h>
diff --git a/include/linux/container.h b/include/linux/container.h
index dd00cc918a92..a90e59f0c65d 100644
--- a/include/linux/container.h
+++ b/include/linux/container.h
@@ -9,7 +9,7 @@
 #ifndef _LINUX_CONTAINER_H
 #define _LINUX_CONTAINER_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 
 /* drivers/base/power/container.c */
 extern const struct bus_type container_subsys;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a4cb7dd6ca23..fce16528de85 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -8,7 +8,7 @@
 
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/io.h>
 #include <linux/perf_event.h>
 #include <linux/sched.h>
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 638ebb5b4d27..95e8067f4b78 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -7,7 +7,7 @@
 #define _COUNTER_H_
 
 #include <linux/cdev.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/mutex_types.h>
diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index 4a50a5c71a5f..36f0e6cf7cc5 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -9,7 +9,7 @@
 #ifndef __LINUX_DEVFREQ_EVENT_H__
 #define __LINUX_DEVFREQ_EVENT_H__
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 
 /**
  * struct devfreq_event_dev - the devfreq-event device
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index d312ffbac4dd..bf8d30af9fa2 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -10,7 +10,7 @@
 #ifndef __LINUX_DEVFREQ_H__
 #define __LINUX_DEVFREQ_H__
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/notifier.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
diff --git a/include/linux/device.h b/include/linux/device.h
index 3e221c132d89..56735ece2ada 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -12,6 +12,7 @@
 #ifndef _DEVICE_H_
 #define _DEVICE_H_
 
+#include <linux/device_types.h>
 #include <linux/dev_printk.h>
 #include <linux/energy_model.h>
 #include <linux/ioport.h>
@@ -30,7 +31,6 @@
 #include <linux/device/driver.h>
 #include <linux/cleanup.h>
 #include <linux/sysfs.h> // for __ATTR_*
-#include <asm/device.h>
 
 struct device;
 struct device_private;
@@ -46,27 +46,6 @@ struct dev_pin_info;
 struct dev_iommu;
 struct msi_device_data;
 
-/**
- * struct subsys_interface - interfaces to device functions
- * @name:       name of the device function
- * @subsys:     subsystem of the devices to attach to
- * @node:       the list of functions registered at the subsystem
- * @add_dev:    device hookup to device function handler
- * @remove_dev: device hookup to device function handler
- *
- * Simple interfaces attached to a subsystem. Multiple interfaces can
- * attach to a subsystem and its devices. Unlike drivers, they do not
- * exclusively claim or control devices. Interfaces usually represent
- * a specific functionality of a subsystem/class of devices.
- */
-struct subsys_interface {
-	const char *name;
-	const struct bus_type *subsys;
-	struct list_head node;
-	int (*add_dev)(struct device *dev, struct subsys_interface *sif);
-	void (*remove_dev)(struct device *dev, struct subsys_interface *sif);
-};
-
 int subsys_interface_register(struct subsys_interface *sif);
 void subsys_interface_unregister(struct subsys_interface *sif);
 
@@ -75,50 +54,6 @@ int subsys_system_register(const struct bus_type *subsys,
 int subsys_virtual_register(const struct bus_type *subsys,
 			    const struct attribute_group **groups);
 
-/*
- * The type of device, "struct device" is embedded in. A class
- * or bus can contain devices of different types
- * like "partitions" and "disks", "mouse" and "event".
- * This identifies the device type and carries type-specific
- * information, equivalent to the kobj_type of a kobject.
- * If "name" is specified, the uevent will contain it in
- * the DEVTYPE variable.
- */
-struct device_type {
-	const char *name;
-	const struct attribute_group **groups;
-	int (*uevent)(const struct device *dev, struct kobj_uevent_env *env);
-	char *(*devnode)(const struct device *dev, umode_t *mode,
-			 kuid_t *uid, kgid_t *gid);
-	void (*release)(struct device *dev);
-
-	const struct dev_pm_ops *pm;
-};
-
-/**
- * struct device_attribute - Interface for exporting device attributes.
- * @attr: sysfs attribute definition.
- * @show: Show handler.
- * @store: Store handler.
- */
-struct device_attribute {
-	struct attribute	attr;
-	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
-			char *buf);
-	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count);
-};
-
-/**
- * struct dev_ext_attribute - Exported device attribute with extra context.
- * @attr: Exported device attribute.
- * @var: Pointer to context.
- */
-struct dev_ext_attribute {
-	struct device_attribute attr;
-	void *var;
-};
-
 ssize_t device_show_ulong(struct device *dev, struct device_attribute *attr,
 			  char *buf);
 ssize_t device_store_ulong(struct device *dev, struct device_attribute *attr,
@@ -423,34 +358,6 @@ void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
 				   size_t align);
 void devm_free_percpu(struct device *dev, void __percpu *pdata);
 
-struct device_dma_parameters {
-	/*
-	 * a low level driver may set these to teach IOMMU code about
-	 * sg limitations.
-	 */
-	unsigned int max_segment_size;
-	unsigned int min_align_mask;
-	unsigned long segment_boundary_mask;
-};
-
-/**
- * enum device_link_state - Device link states.
- * @DL_STATE_NONE: The presence of the drivers is not being tracked.
- * @DL_STATE_DORMANT: None of the supplier/consumer drivers is present.
- * @DL_STATE_AVAILABLE: The supplier driver is present, but the consumer is not.
- * @DL_STATE_CONSUMER_PROBE: The consumer is probing (supplier driver present).
- * @DL_STATE_ACTIVE: Both the supplier and consumer drivers are present.
- * @DL_STATE_SUPPLIER_UNBIND: The supplier driver is unbinding.
- */
-enum device_link_state {
-	DL_STATE_NONE = -1,
-	DL_STATE_DORMANT = 0,
-	DL_STATE_AVAILABLE,
-	DL_STATE_CONSUMER_PROBE,
-	DL_STATE_ACTIVE,
-	DL_STATE_SUPPLIER_UNBIND,
-};
-
 /*
  * Device link flags.
  *
@@ -475,363 +382,6 @@ enum device_link_state {
 #define DL_FLAG_INFERRED		BIT(8)
 #define DL_FLAG_CYCLE			BIT(9)
 
-/**
- * enum dl_dev_state - Device driver presence tracking information.
- * @DL_DEV_NO_DRIVER: There is no driver attached to the device.
- * @DL_DEV_PROBING: A driver is probing.
- * @DL_DEV_DRIVER_BOUND: The driver has been bound to the device.
- * @DL_DEV_UNBINDING: The driver is unbinding from the device.
- */
-enum dl_dev_state {
-	DL_DEV_NO_DRIVER = 0,
-	DL_DEV_PROBING,
-	DL_DEV_DRIVER_BOUND,
-	DL_DEV_UNBINDING,
-};
-
-/**
- * enum device_removable - Whether the device is removable. The criteria for a
- * device to be classified as removable is determined by its subsystem or bus.
- * @DEVICE_REMOVABLE_NOT_SUPPORTED: This attribute is not supported for this
- *				    device (default).
- * @DEVICE_REMOVABLE_UNKNOWN:  Device location is Unknown.
- * @DEVICE_FIXED: Device is not removable by the user.
- * @DEVICE_REMOVABLE: Device is removable by the user.
- */
-enum device_removable {
-	DEVICE_REMOVABLE_NOT_SUPPORTED = 0, /* must be 0 */
-	DEVICE_REMOVABLE_UNKNOWN,
-	DEVICE_FIXED,
-	DEVICE_REMOVABLE,
-};
-
-/**
- * struct dev_links_info - Device data related to device links.
- * @suppliers: List of links to supplier devices.
- * @consumers: List of links to consumer devices.
- * @defer_sync: Hook to global list of devices that have deferred sync_state.
- * @status: Driver status information.
- */
-struct dev_links_info {
-	struct list_head suppliers;
-	struct list_head consumers;
-	struct list_head defer_sync;
-	enum dl_dev_state status;
-};
-
-/**
- * struct dev_msi_info - Device data related to MSI
- * @domain:	The MSI interrupt domain associated to the device
- * @data:	Pointer to MSI device data
- */
-struct dev_msi_info {
-#ifdef CONFIG_GENERIC_MSI_IRQ
-	struct irq_domain	*domain;
-	struct msi_device_data	*data;
-#endif
-};
-
-/**
- * enum device_physical_location_panel - Describes which panel surface of the
- * system's housing the device connection point resides on.
- * @DEVICE_PANEL_TOP: Device connection point is on the top panel.
- * @DEVICE_PANEL_BOTTOM: Device connection point is on the bottom panel.
- * @DEVICE_PANEL_LEFT: Device connection point is on the left panel.
- * @DEVICE_PANEL_RIGHT: Device connection point is on the right panel.
- * @DEVICE_PANEL_FRONT: Device connection point is on the front panel.
- * @DEVICE_PANEL_BACK: Device connection point is on the back panel.
- * @DEVICE_PANEL_UNKNOWN: The panel with device connection point is unknown.
- */
-enum device_physical_location_panel {
-	DEVICE_PANEL_TOP,
-	DEVICE_PANEL_BOTTOM,
-	DEVICE_PANEL_LEFT,
-	DEVICE_PANEL_RIGHT,
-	DEVICE_PANEL_FRONT,
-	DEVICE_PANEL_BACK,
-	DEVICE_PANEL_UNKNOWN,
-};
-
-/**
- * enum device_physical_location_vertical_position - Describes vertical
- * position of the device connection point on the panel surface.
- * @DEVICE_VERT_POS_UPPER: Device connection point is at upper part of panel.
- * @DEVICE_VERT_POS_CENTER: Device connection point is at center part of panel.
- * @DEVICE_VERT_POS_LOWER: Device connection point is at lower part of panel.
- */
-enum device_physical_location_vertical_position {
-	DEVICE_VERT_POS_UPPER,
-	DEVICE_VERT_POS_CENTER,
-	DEVICE_VERT_POS_LOWER,
-};
-
-/**
- * enum device_physical_location_horizontal_position - Describes horizontal
- * position of the device connection point on the panel surface.
- * @DEVICE_HORI_POS_LEFT: Device connection point is at left part of panel.
- * @DEVICE_HORI_POS_CENTER: Device connection point is at center part of panel.
- * @DEVICE_HORI_POS_RIGHT: Device connection point is at right part of panel.
- */
-enum device_physical_location_horizontal_position {
-	DEVICE_HORI_POS_LEFT,
-	DEVICE_HORI_POS_CENTER,
-	DEVICE_HORI_POS_RIGHT,
-};
-
-/**
- * struct device_physical_location - Device data related to physical location
- * of the device connection point.
- * @panel: Panel surface of the system's housing that the device connection
- *         point resides on.
- * @vertical_position: Vertical position of the device connection point within
- *                     the panel.
- * @horizontal_position: Horizontal position of the device connection point
- *                       within the panel.
- * @dock: Set if the device connection point resides in a docking station or
- *        port replicator.
- * @lid: Set if this device connection point resides on the lid of laptop
- *       system.
- */
-struct device_physical_location {
-	enum device_physical_location_panel panel;
-	enum device_physical_location_vertical_position vertical_position;
-	enum device_physical_location_horizontal_position horizontal_position;
-	bool dock;
-	bool lid;
-};
-
-/**
- * struct device - The basic device structure
- * @parent:	The device's "parent" device, the device to which it is attached.
- * 		In most cases, a parent device is some sort of bus or host
- * 		controller. If parent is NULL, the device, is a top-level device,
- * 		which is not usually what you want.
- * @p:		Holds the private data of the driver core portions of the device.
- * 		See the comment of the struct device_private for detail.
- * @kobj:	A top-level, abstract class from which other classes are derived.
- * @init_name:	Initial name of the device.
- * @type:	The type of device.
- * 		This identifies the device type and carries type-specific
- * 		information.
- * @mutex:	Mutex to synchronize calls to its driver.
- * @bus:	Type of bus device is on.
- * @driver:	Which driver has allocated this
- * @platform_data: Platform data specific to the device.
- * 		Example: For devices on custom boards, as typical of embedded
- * 		and SOC based hardware, Linux often uses platform_data to point
- * 		to board-specific structures describing devices and how they
- * 		are wired.  That can include what ports are available, chip
- * 		variants, which GPIO pins act in what additional roles, and so
- * 		on.  This shrinks the "Board Support Packages" (BSPs) and
- * 		minimizes board-specific #ifdefs in drivers.
- * @driver_data: Private pointer for driver specific info.
- * @links:	Links to suppliers and consumers of this device.
- * @power:	For device power management.
- *		See Documentation/driver-api/pm/devices.rst for details.
- * @pm_domain:	Provide callbacks that are executed during system suspend,
- * 		hibernation, system resume and during runtime PM transitions
- * 		along with subsystem-level and driver-level callbacks.
- * @em_pd:	device's energy model performance domain
- * @pins:	For device pin management.
- *		See Documentation/driver-api/pin-control.rst for details.
- * @msi:	MSI related data
- * @numa_node:	NUMA node this device is close to.
- * @dma_ops:    DMA mapping operations for this device.
- * @dma_mask:	Dma mask (if dma'ble device).
- * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
- * 		hardware supports 64-bit addresses for consistent allocations
- * 		such descriptors.
- * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
- *		DMA limit than the device itself supports.
- * @dma_range_map: map for DMA memory ranges relative to that of RAM
- * @dma_parms:	A low level driver may set these to teach IOMMU code about
- * 		segment limitations.
- * @dma_pools:	Dma pools (if dma'ble device).
- * @dma_mem:	Internal for coherent mem override.
- * @cma_area:	Contiguous memory area for dma allocations
- * @dma_io_tlb_mem: Software IO TLB allocator.  Not for driver use.
- * @dma_io_tlb_pools:	List of transient swiotlb memory pools.
- * @dma_io_tlb_lock:	Protects changes to the list of active pools.
- * @dma_uses_io_tlb: %true if device has used the software IO TLB.
- * @archdata:	For arch-specific additions.
- * @of_node:	Associated device tree node.
- * @fwnode:	Associated device node supplied by platform firmware.
- * @devt:	For creating the sysfs "dev".
- * @id:		device instance
- * @devres_lock: Spinlock to protect the resource of the device.
- * @devres_head: The resources list of the device.
- * @class:	The class of the device.
- * @groups:	Optional attribute groups.
- * @release:	Callback to free the device after all references have
- * 		gone away. This should be set by the allocator of the
- * 		device (i.e. the bus driver that discovered the device).
- * @iommu_group: IOMMU group the device belongs to.
- * @iommu:	Per device generic IOMMU runtime data
- * @physical_location: Describes physical location of the device connection
- *		point in the system housing.
- * @removable:  Whether the device can be removed from the system. This
- *              should be set by the subsystem / bus driver that discovered
- *              the device.
- *
- * @offline_disabled: If set, the device is permanently online.
- * @offline:	Set after successful invocation of bus type's .offline().
- * @of_node_reused: Set if the device-tree node is shared with an ancestor
- *              device.
- * @state_synced: The hardware state of this device has been synced to match
- *		  the software state of this device by calling the driver/bus
- *		  sync_state() callback.
- * @can_match:	The device has matched with a driver at least once or it is in
- *		a bus (like AMBA) which can't check for matching drivers until
- *		other devices probe successfully.
- * @dma_coherent: this particular device is dma coherent, even if the
- *		architecture supports non-coherent devices.
- * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
- *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*),
- *		and optionall (if the coherent mask is large enough) also
- *		for dma allocations.  This flag is managed by the dma ops
- *		instance from ->dma_supported.
- *
- * At the lowest level, every device in a Linux system is represented by an
- * instance of struct device. The device structure contains the information
- * that the device model core needs to model the system. Most subsystems,
- * however, track additional information about the devices they host. As a
- * result, it is rare for devices to be represented by bare device structures;
- * instead, that structure, like kobject structures, is usually embedded within
- * a higher-level representation of the device.
- */
-struct device {
-	struct kobject kobj;
-	struct device		*parent;
-
-	struct device_private	*p;
-
-	const char		*init_name; /* initial name of the device */
-	const struct device_type *type;
-
-	const struct bus_type	*bus;	/* type of bus device is on */
-	struct device_driver *driver;	/* which driver has allocated this
-					   device */
-	void		*platform_data;	/* Platform specific data, device
-					   core doesn't touch it */
-	void		*driver_data;	/* Driver data, set and get with
-					   dev_set_drvdata/dev_get_drvdata */
-	struct mutex		mutex;	/* mutex to synchronize calls to
-					 * its driver.
-					 */
-
-	struct dev_links_info	links;
-	struct dev_pm_info	power;
-	struct dev_pm_domain	*pm_domain;
-
-#ifdef CONFIG_ENERGY_MODEL
-	struct em_perf_domain	*em_pd;
-#endif
-
-#ifdef CONFIG_PINCTRL
-	struct dev_pin_info	*pins;
-#endif
-	struct dev_msi_info	msi;
-#ifdef CONFIG_DMA_OPS
-	const struct dma_map_ops *dma_ops;
-#endif
-	u64		*dma_mask;	/* dma mask (if dma'able device) */
-	u64		coherent_dma_mask;/* Like dma_mask, but for
-					     alloc_coherent mappings as
-					     not all hardware supports
-					     64 bit addresses for consistent
-					     allocations such descriptors. */
-	u64		bus_dma_limit;	/* upstream dma constraint */
-	const struct bus_dma_region *dma_range_map;
-
-	struct device_dma_parameters *dma_parms;
-
-	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
-
-#ifdef CONFIG_DMA_DECLARE_COHERENT
-	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
-					     override */
-#endif
-#ifdef CONFIG_DMA_CMA
-	struct cma *cma_area;		/* contiguous memory area for dma
-					   allocations */
-#endif
-#ifdef CONFIG_SWIOTLB
-	struct io_tlb_mem *dma_io_tlb_mem;
-#endif
-#ifdef CONFIG_SWIOTLB_DYNAMIC
-	struct list_head dma_io_tlb_pools;
-	spinlock_t dma_io_tlb_lock;
-	bool dma_uses_io_tlb;
-#endif
-	/* arch specific additions */
-	struct dev_archdata	archdata;
-
-	struct device_node	*of_node; /* associated device tree node */
-	struct fwnode_handle	*fwnode; /* firmware device node */
-
-#ifdef CONFIG_NUMA
-	int		numa_node;	/* NUMA node this device is close to */
-#endif
-	dev_t			devt;	/* dev_t, creates the sysfs "dev" */
-	u32			id;	/* device instance */
-
-	spinlock_t		devres_lock;
-	struct list_head	devres_head;
-
-	const struct class	*class;
-	const struct attribute_group **groups;	/* optional groups */
-
-	void	(*release)(struct device *dev);
-	struct iommu_group	*iommu_group;
-	struct dev_iommu	*iommu;
-
-	struct device_physical_location *physical_location;
-
-	enum device_removable	removable;
-
-	bool			offline_disabled:1;
-	bool			offline:1;
-	bool			of_node_reused:1;
-	bool			state_synced:1;
-	bool			can_match:1;
-#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
-    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
-	bool			dma_coherent:1;
-#endif
-#ifdef CONFIG_DMA_OPS_BYPASS
-	bool			dma_ops_bypass : 1;
-#endif
-};
-
-/**
- * struct device_link - Device link representation.
- * @supplier: The device on the supplier end of the link.
- * @s_node: Hook to the supplier device's list of links to consumers.
- * @consumer: The device on the consumer end of the link.
- * @c_node: Hook to the consumer device's list of links to suppliers.
- * @link_dev: device used to expose link details in sysfs
- * @status: The state of the link (with respect to the presence of drivers).
- * @flags: Link flags.
- * @rpm_active: Whether or not the consumer device is runtime-PM-active.
- * @kref: Count repeated addition of the same link.
- * @rm_work: Work structure used for removing the link.
- * @supplier_preactivated: Supplier has been made active before consumer probe.
- */
-struct device_link {
-	struct device *supplier;
-	struct list_head s_node;
-	struct device *consumer;
-	struct list_head c_node;
-	struct device link_dev;
-	enum device_link_state status;
-	u32 flags;
-	refcount_t rpm_active;
-	struct kref kref;
-	struct work_struct rm_work;
-	bool supplier_preactivated; /* Owned by consumer probe. */
-};
-
 #define kobj_to_dev(__kobj)	container_of_const(__kobj, struct device, kobj)
 
 /**
@@ -847,20 +397,6 @@ static inline bool device_iommu_mapped(struct device *dev)
 /* Get the wakeup routines, which depend on struct device */
 #include <linux/pm_wakeup.h>
 
-/**
- * dev_name - Return a device's name.
- * @dev: Device with name to get.
- * Return: The kobject name of the device, or its initial name if unavailable.
- */
-static inline const char *dev_name(const struct device *dev)
-{
-	/* Use the init name until the kobject becomes available */
-	if (dev->init_name)
-		return dev->init_name;
-
-	return kobject_name(&dev->kobj);
-}
-
 /**
  * dev_bus_name - Return a device's bus/class name, if at all possible
  * @dev: struct device to get the bus/class name of
diff --git a/include/linux/device_types.h b/include/linux/device_types.h
new file mode 100644
index 000000000000..ead555b00c11
--- /dev/null
+++ b/include/linux/device_types.h
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * device.h - generic, centralized driver model
+ *
+ * Copyright (c) 2001-2003 Patrick Mochel <mochel@osdl.org>
+ * Copyright (c) 2004-2009 Greg Kroah-Hartman <gregkh@suse.de>
+ * Copyright (c) 2008-2009 Novell Inc.
+ *
+ * See Documentation/driver-api/driver-model/ for more information.
+ */
+
+#ifndef _DEVICE_TYPES_H_
+#define _DEVICE_TYPES_H_
+
+#include <linux/kobject_types.h>
+#include <linux/mutex_types.h>
+#include <linux/pm.h>
+#include <linux/sysfs_types.h>
+#include <linux/uidgid_types.h>
+#include <asm/device.h>
+
+struct device;
+struct device_private;
+struct device_driver;
+struct driver_private;
+struct module;
+struct class;
+struct subsys_private;
+struct device_node;
+struct fwnode_handle;
+struct iommu_group;
+struct dev_pin_info;
+struct dev_iommu;
+struct msi_device_data;
+struct kobj_uevent_env;
+
+/**
+ * struct subsys_interface - interfaces to device functions
+ * @name:       name of the device function
+ * @subsys:     subsystem of the devices to attach to
+ * @node:       the list of functions registered at the subsystem
+ * @add_dev:    device hookup to device function handler
+ * @remove_dev: device hookup to device function handler
+ *
+ * Simple interfaces attached to a subsystem. Multiple interfaces can
+ * attach to a subsystem and its devices. Unlike drivers, they do not
+ * exclusively claim or control devices. Interfaces usually represent
+ * a specific functionality of a subsystem/class of devices.
+ */
+struct subsys_interface {
+	const char *name;
+	const struct bus_type *subsys;
+	struct list_head node;
+	int (*add_dev)(struct device *dev, struct subsys_interface *sif);
+	void (*remove_dev)(struct device *dev, struct subsys_interface *sif);
+};
+
+/*
+ * The type of device, "struct device" is embedded in. A class
+ * or bus can contain devices of different types
+ * like "partitions" and "disks", "mouse" and "event".
+ * This identifies the device type and carries type-specific
+ * information, equivalent to the kobj_type of a kobject.
+ * If "name" is specified, the uevent will contain it in
+ * the DEVTYPE variable.
+ */
+struct device_type {
+	const char *name;
+	const struct attribute_group **groups;
+	int (*uevent)(const struct device *dev, struct kobj_uevent_env *env);
+	char *(*devnode)(const struct device *dev, umode_t *mode,
+			 kuid_t *uid, kgid_t *gid);
+	void (*release)(struct device *dev);
+
+	const struct dev_pm_ops *pm;
+};
+
+/**
+ * struct device_attribute - Interface for exporting device attributes.
+ * @attr: sysfs attribute definition.
+ * @show: Show handler.
+ * @store: Store handler.
+ */
+struct device_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count);
+};
+
+/**
+ * struct dev_ext_attribute - Exported device attribute with extra context.
+ * @attr: Exported device attribute.
+ * @var: Pointer to context.
+ */
+struct dev_ext_attribute {
+	struct device_attribute attr;
+	void *var;
+};
+
+struct device_dma_parameters {
+	/*
+	 * a low level driver may set these to teach IOMMU code about
+	 * sg limitations.
+	 */
+	unsigned int max_segment_size;
+	unsigned int min_align_mask;
+	unsigned long segment_boundary_mask;
+};
+
+/**
+ * enum device_link_state - Device link states.
+ * @DL_STATE_NONE: The presence of the drivers is not being tracked.
+ * @DL_STATE_DORMANT: None of the supplier/consumer drivers is present.
+ * @DL_STATE_AVAILABLE: The supplier driver is present, but the consumer is not.
+ * @DL_STATE_CONSUMER_PROBE: The consumer is probing (supplier driver present).
+ * @DL_STATE_ACTIVE: Both the supplier and consumer drivers are present.
+ * @DL_STATE_SUPPLIER_UNBIND: The supplier driver is unbinding.
+ */
+enum device_link_state {
+	DL_STATE_NONE = -1,
+	DL_STATE_DORMANT = 0,
+	DL_STATE_AVAILABLE,
+	DL_STATE_CONSUMER_PROBE,
+	DL_STATE_ACTIVE,
+	DL_STATE_SUPPLIER_UNBIND,
+};
+
+/**
+ * enum dl_dev_state - Device driver presence tracking information.
+ * @DL_DEV_NO_DRIVER: There is no driver attached to the device.
+ * @DL_DEV_PROBING: A driver is probing.
+ * @DL_DEV_DRIVER_BOUND: The driver has been bound to the device.
+ * @DL_DEV_UNBINDING: The driver is unbinding from the device.
+ */
+enum dl_dev_state {
+	DL_DEV_NO_DRIVER = 0,
+	DL_DEV_PROBING,
+	DL_DEV_DRIVER_BOUND,
+	DL_DEV_UNBINDING,
+};
+
+/**
+ * enum device_removable - Whether the device is removable. The criteria for a
+ * device to be classified as removable is determined by its subsystem or bus.
+ * @DEVICE_REMOVABLE_NOT_SUPPORTED: This attribute is not supported for this
+ *				    device (default).
+ * @DEVICE_REMOVABLE_UNKNOWN:  Device location is Unknown.
+ * @DEVICE_FIXED: Device is not removable by the user.
+ * @DEVICE_REMOVABLE: Device is removable by the user.
+ */
+enum device_removable {
+	DEVICE_REMOVABLE_NOT_SUPPORTED = 0, /* must be 0 */
+	DEVICE_REMOVABLE_UNKNOWN,
+	DEVICE_FIXED,
+	DEVICE_REMOVABLE,
+};
+
+/**
+ * struct dev_links_info - Device data related to device links.
+ * @suppliers: List of links to supplier devices.
+ * @consumers: List of links to consumer devices.
+ * @defer_sync: Hook to global list of devices that have deferred sync_state.
+ * @status: Driver status information.
+ */
+struct dev_links_info {
+	struct list_head suppliers;
+	struct list_head consumers;
+	struct list_head defer_sync;
+	enum dl_dev_state status;
+};
+
+/**
+ * struct dev_msi_info - Device data related to MSI
+ * @domain:	The MSI interrupt domain associated to the device
+ * @data:	Pointer to MSI device data
+ */
+struct dev_msi_info {
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	struct irq_domain	*domain;
+	struct msi_device_data	*data;
+#endif
+};
+
+/**
+ * enum device_physical_location_panel - Describes which panel surface of the
+ * system's housing the device connection point resides on.
+ * @DEVICE_PANEL_TOP: Device connection point is on the top panel.
+ * @DEVICE_PANEL_BOTTOM: Device connection point is on the bottom panel.
+ * @DEVICE_PANEL_LEFT: Device connection point is on the left panel.
+ * @DEVICE_PANEL_RIGHT: Device connection point is on the right panel.
+ * @DEVICE_PANEL_FRONT: Device connection point is on the front panel.
+ * @DEVICE_PANEL_BACK: Device connection point is on the back panel.
+ * @DEVICE_PANEL_UNKNOWN: The panel with device connection point is unknown.
+ */
+enum device_physical_location_panel {
+	DEVICE_PANEL_TOP,
+	DEVICE_PANEL_BOTTOM,
+	DEVICE_PANEL_LEFT,
+	DEVICE_PANEL_RIGHT,
+	DEVICE_PANEL_FRONT,
+	DEVICE_PANEL_BACK,
+	DEVICE_PANEL_UNKNOWN,
+};
+
+/**
+ * enum device_physical_location_vertical_position - Describes vertical
+ * position of the device connection point on the panel surface.
+ * @DEVICE_VERT_POS_UPPER: Device connection point is at upper part of panel.
+ * @DEVICE_VERT_POS_CENTER: Device connection point is at center part of panel.
+ * @DEVICE_VERT_POS_LOWER: Device connection point is at lower part of panel.
+ */
+enum device_physical_location_vertical_position {
+	DEVICE_VERT_POS_UPPER,
+	DEVICE_VERT_POS_CENTER,
+	DEVICE_VERT_POS_LOWER,
+};
+
+/**
+ * enum device_physical_location_horizontal_position - Describes horizontal
+ * position of the device connection point on the panel surface.
+ * @DEVICE_HORI_POS_LEFT: Device connection point is at left part of panel.
+ * @DEVICE_HORI_POS_CENTER: Device connection point is at center part of panel.
+ * @DEVICE_HORI_POS_RIGHT: Device connection point is at right part of panel.
+ */
+enum device_physical_location_horizontal_position {
+	DEVICE_HORI_POS_LEFT,
+	DEVICE_HORI_POS_CENTER,
+	DEVICE_HORI_POS_RIGHT,
+};
+
+/**
+ * struct device_physical_location - Device data related to physical location
+ * of the device connection point.
+ * @panel: Panel surface of the system's housing that the device connection
+ *         point resides on.
+ * @vertical_position: Vertical position of the device connection point within
+ *                     the panel.
+ * @horizontal_position: Horizontal position of the device connection point
+ *                       within the panel.
+ * @dock: Set if the device connection point resides in a docking station or
+ *        port replicator.
+ * @lid: Set if this device connection point resides on the lid of laptop
+ *       system.
+ */
+struct device_physical_location {
+	enum device_physical_location_panel panel;
+	enum device_physical_location_vertical_position vertical_position;
+	enum device_physical_location_horizontal_position horizontal_position;
+	bool dock;
+	bool lid;
+};
+
+/**
+ * struct device - The basic device structure
+ * @parent:	The device's "parent" device, the device to which it is attached.
+ * 		In most cases, a parent device is some sort of bus or host
+ * 		controller. If parent is NULL, the device, is a top-level device,
+ * 		which is not usually what you want.
+ * @p:		Holds the private data of the driver core portions of the device.
+ * 		See the comment of the struct device_private for detail.
+ * @kobj:	A top-level, abstract class from which other classes are derived.
+ * @init_name:	Initial name of the device.
+ * @type:	The type of device.
+ * 		This identifies the device type and carries type-specific
+ * 		information.
+ * @mutex:	Mutex to synchronize calls to its driver.
+ * @bus:	Type of bus device is on.
+ * @driver:	Which driver has allocated this
+ * @platform_data: Platform data specific to the device.
+ * 		Example: For devices on custom boards, as typical of embedded
+ * 		and SOC based hardware, Linux often uses platform_data to point
+ * 		to board-specific structures describing devices and how they
+ * 		are wired.  That can include what ports are available, chip
+ * 		variants, which GPIO pins act in what additional roles, and so
+ * 		on.  This shrinks the "Board Support Packages" (BSPs) and
+ * 		minimizes board-specific #ifdefs in drivers.
+ * @driver_data: Private pointer for driver specific info.
+ * @links:	Links to suppliers and consumers of this device.
+ * @power:	For device power management.
+ *		See Documentation/driver-api/pm/devices.rst for details.
+ * @pm_domain:	Provide callbacks that are executed during system suspend,
+ * 		hibernation, system resume and during runtime PM transitions
+ * 		along with subsystem-level and driver-level callbacks.
+ * @em_pd:	device's energy model performance domain
+ * @pins:	For device pin management.
+ *		See Documentation/driver-api/pin-control.rst for details.
+ * @msi:	MSI related data
+ * @numa_node:	NUMA node this device is close to.
+ * @dma_ops:    DMA mapping operations for this device.
+ * @dma_mask:	Dma mask (if dma'ble device).
+ * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
+ * 		hardware supports 64-bit addresses for consistent allocations
+ * 		such descriptors.
+ * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
+ *		DMA limit than the device itself supports.
+ * @dma_range_map: map for DMA memory ranges relative to that of RAM
+ * @dma_parms:	A low level driver may set these to teach IOMMU code about
+ * 		segment limitations.
+ * @dma_pools:	Dma pools (if dma'ble device).
+ * @dma_mem:	Internal for coherent mem override.
+ * @cma_area:	Contiguous memory area for dma allocations
+ * @dma_io_tlb_mem: Software IO TLB allocator.  Not for driver use.
+ * @dma_io_tlb_pools:	List of transient swiotlb memory pools.
+ * @dma_io_tlb_lock:	Protects changes to the list of active pools.
+ * @dma_uses_io_tlb: %true if device has used the software IO TLB.
+ * @archdata:	For arch-specific additions.
+ * @of_node:	Associated device tree node.
+ * @fwnode:	Associated device node supplied by platform firmware.
+ * @devt:	For creating the sysfs "dev".
+ * @id:		device instance
+ * @devres_lock: Spinlock to protect the resource of the device.
+ * @devres_head: The resources list of the device.
+ * @class:	The class of the device.
+ * @groups:	Optional attribute groups.
+ * @release:	Callback to free the device after all references have
+ * 		gone away. This should be set by the allocator of the
+ * 		device (i.e. the bus driver that discovered the device).
+ * @iommu_group: IOMMU group the device belongs to.
+ * @iommu:	Per device generic IOMMU runtime data
+ * @physical_location: Describes physical location of the device connection
+ *		point in the system housing.
+ * @removable:  Whether the device can be removed from the system. This
+ *              should be set by the subsystem / bus driver that discovered
+ *              the device.
+ *
+ * @offline_disabled: If set, the device is permanently online.
+ * @offline:	Set after successful invocation of bus type's .offline().
+ * @of_node_reused: Set if the device-tree node is shared with an ancestor
+ *              device.
+ * @state_synced: The hardware state of this device has been synced to match
+ *		  the software state of this device by calling the driver/bus
+ *		  sync_state() callback.
+ * @can_match:	The device has matched with a driver at least once or it is in
+ *		a bus (like AMBA) which can't check for matching drivers until
+ *		other devices probe successfully.
+ * @dma_coherent: this particular device is dma coherent, even if the
+ *		architecture supports non-coherent devices.
+ * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
+ *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*),
+ *		and optionall (if the coherent mask is large enough) also
+ *		for dma allocations.  This flag is managed by the dma ops
+ *		instance from ->dma_supported.
+ *
+ * At the lowest level, every device in a Linux system is represented by an
+ * instance of struct device. The device structure contains the information
+ * that the device model core needs to model the system. Most subsystems,
+ * however, track additional information about the devices they host. As a
+ * result, it is rare for devices to be represented by bare device structures;
+ * instead, that structure, like kobject structures, is usually embedded within
+ * a higher-level representation of the device.
+ */
+struct device {
+	struct kobject kobj;
+	struct device		*parent;
+
+	struct device_private	*p;
+
+	const char		*init_name; /* initial name of the device */
+	const struct device_type *type;
+
+	const struct bus_type	*bus;	/* type of bus device is on */
+	struct device_driver *driver;	/* which driver has allocated this
+					   device */
+	void		*platform_data;	/* Platform specific data, device
+					   core doesn't touch it */
+	void		*driver_data;	/* Driver data, set and get with
+					   dev_set_drvdata/dev_get_drvdata */
+	struct mutex		mutex;	/* mutex to synchronize calls to
+					 * its driver.
+					 */
+
+	struct dev_links_info	links;
+	struct dev_pm_info	power;
+	struct dev_pm_domain	*pm_domain;
+
+#ifdef CONFIG_ENERGY_MODEL
+	struct em_perf_domain	*em_pd;
+#endif
+
+#ifdef CONFIG_PINCTRL
+	struct dev_pin_info	*pins;
+#endif
+	struct dev_msi_info	msi;
+#ifdef CONFIG_DMA_OPS
+	const struct dma_map_ops *dma_ops;
+#endif
+	u64		*dma_mask;	/* dma mask (if dma'able device) */
+	u64		coherent_dma_mask;/* Like dma_mask, but for
+					     alloc_coherent mappings as
+					     not all hardware supports
+					     64 bit addresses for consistent
+					     allocations such descriptors. */
+	u64		bus_dma_limit;	/* upstream dma constraint */
+	const struct bus_dma_region *dma_range_map;
+
+	struct device_dma_parameters *dma_parms;
+
+	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
+
+#ifdef CONFIG_DMA_DECLARE_COHERENT
+	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
+					     override */
+#endif
+#ifdef CONFIG_DMA_CMA
+	struct cma *cma_area;		/* contiguous memory area for dma
+					   allocations */
+#endif
+#ifdef CONFIG_SWIOTLB
+	struct io_tlb_mem *dma_io_tlb_mem;
+#endif
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	struct list_head dma_io_tlb_pools;
+	spinlock_t dma_io_tlb_lock;
+	bool dma_uses_io_tlb;
+#endif
+	/* arch specific additions */
+	struct dev_archdata	archdata;
+
+	struct device_node	*of_node; /* associated device tree node */
+	struct fwnode_handle	*fwnode; /* firmware device node */
+
+#ifdef CONFIG_NUMA
+	int		numa_node;	/* NUMA node this device is close to */
+#endif
+	dev_t			devt;	/* dev_t, creates the sysfs "dev" */
+	u32			id;	/* device instance */
+
+	spinlock_t		devres_lock;
+	struct list_head	devres_head;
+
+	const struct class	*class;
+	const struct attribute_group **groups;	/* optional groups */
+
+	void	(*release)(struct device *dev);
+	struct iommu_group	*iommu_group;
+	struct dev_iommu	*iommu;
+
+	struct device_physical_location *physical_location;
+
+	enum device_removable	removable;
+
+	bool			offline_disabled:1;
+	bool			offline:1;
+	bool			of_node_reused:1;
+	bool			state_synced:1;
+	bool			can_match:1;
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+	bool			dma_coherent:1;
+#endif
+#ifdef CONFIG_DMA_OPS_BYPASS
+	bool			dma_ops_bypass : 1;
+#endif
+};
+
+/**
+ * struct device_link - Device link representation.
+ * @supplier: The device on the supplier end of the link.
+ * @s_node: Hook to the supplier device's list of links to consumers.
+ * @consumer: The device on the consumer end of the link.
+ * @c_node: Hook to the consumer device's list of links to suppliers.
+ * @link_dev: device used to expose link details in sysfs
+ * @status: The state of the link (with respect to the presence of drivers).
+ * @flags: Link flags.
+ * @rpm_active: Whether or not the consumer device is runtime-PM-active.
+ * @kref: Count repeated addition of the same link.
+ * @rm_work: Work structure used for removing the link.
+ * @supplier_preactivated: Supplier has been made active before consumer probe.
+ */
+struct device_link {
+	struct device *supplier;
+	struct list_head s_node;
+	struct device *consumer;
+	struct list_head c_node;
+	struct device link_dev;
+	enum device_link_state status;
+	u32 flags;
+	refcount_t rpm_active;
+	struct kref kref;
+	struct work_struct rm_work;
+	bool supplier_preactivated; /* Owned by consumer probe. */
+};
+
+/**
+ * dev_name - Return a device's name.
+ * @dev: Device with name to get.
+ * Return: The kobject name of the device, or its initial name if unavailable.
+ */
+static inline const char *dev_name(const struct device *dev)
+{
+	/* Use the init name until the kobject becomes available */
+	if (dev->init_name)
+		return dev->init_name;
+
+	return kobject_name(&dev->kobj);
+}
+
+#endif /* _DEVICE_TYPES_H_ */
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 32c2f49177b1..765f799d49bd 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -5,7 +5,7 @@
 #ifndef LINUX_DMAENGINE_H
 #define LINUX_DMAENGINE_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/err.h>
 #include <linux/idr.h> // for struct ida
 #include <linux/uio.h>
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 7b78403cac40..08ba34f2a43e 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -13,7 +13,7 @@
 #define _LINUX_EDAC_H_
 
 #include <linux/atomic.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/completion_types.h>
 #include <linux/workqueue_types.h>
 #include <linux/debugfs.h>
diff --git a/include/linux/enclosure.h b/include/linux/enclosure.h
index 1c630e2c2756..8fb9f561263f 100644
--- a/include/linux/enclosure.h
+++ b/include/linux/enclosure.h
@@ -12,7 +12,7 @@
 #ifndef _LINUX_ENCLOSURE_H_
 #define _LINUX_ENCLOSURE_H_
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/list.h>
 
 /* A few generic types ... taken from ses-2 */
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index 223da48a6d18..3a1eeb26bd65 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -3,7 +3,7 @@
 #ifndef _LINUX_FPGA_BRIDGE_H
 #define _LINUX_FPGA_BRIDGE_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/fpga/fpga-mgr.h>
 
 struct fpga_bridge;
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 9d4d32909340..be1e5033f0d3 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -3,7 +3,7 @@
 #ifndef _FPGA_REGION_H
 #define _FPGA_REGION_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-bridge.h>
 
diff --git a/include/linux/framer/framer.h b/include/linux/framer/framer.h
index 2352a52d7d0f..ebaacd782702 100644
--- a/include/linux/framer/framer.h
+++ b/include/linux/framer/framer.h
@@ -14,7 +14,7 @@
 #include <linux/mutex_types.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/workqueue_types.h>
 
 /**
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 3bb87bf6bc65..5803588f86db 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -25,7 +25,7 @@
 #define __LINUX_HDMI_H_
 
 #include <linux/types.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 
 enum hdmi_packet_type {
 	HDMI_PACKET_TYPE_NULL = 0x00,
diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
index d896713359cd..6b13b3e5a9b5 100644
--- a/include/linux/hwmon-sysfs.h
+++ b/include/linux/hwmon-sysfs.h
@@ -7,7 +7,7 @@
 #ifndef _LINUX_HWMON_SYSFS_H
 #define _LINUX_HWMON_SYSFS_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/kstrtox.h>
 
 struct sensor_device_attribute{
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 6dafef342e91..91d67fdda784 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -7,7 +7,7 @@
 #ifndef _INDUSTRIAL_IO_H_
 #define _INDUSTRIAL_IO_H_
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/slab.h>
diff --git a/include/linux/lcd.h b/include/linux/lcd.h
index 238fb1dfed98..a0deeeb3db49 100644
--- a/include/linux/lcd.h
+++ b/include/linux/lcd.h
@@ -9,7 +9,7 @@
 #ifndef _LINUX_LCD_H
 #define _LINUX_LCD_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/fb.h>
diff --git a/include/linux/node.h b/include/linux/node.h
index c4c17037c954..791954e0f01b 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -15,7 +15,7 @@
 #ifndef _LINUX_NODE_H_
 #define _LINUX_NODE_H_
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/cpumask.h>
 #include <linux/list.h>
 #include <linux/mmzone.h> // for enum meminit_context
diff --git a/include/linux/peci.h b/include/linux/peci.h
index ad3ea1371680..39d455231e21 100644
--- a/include/linux/peci.h
+++ b/include/linux/peci.h
@@ -4,7 +4,7 @@
 #ifndef __LINUX_PECI_H
 #define __LINUX_PECI_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/kernel.h>
 #include <linux/mutex_types.h>
 #include <linux/types.h>
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index 68669ce18720..8b89565c6e6e 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -8,7 +8,7 @@
 #ifndef _LINUX_PM_CLOCK_H
 #define _LINUX_PM_CLOCK_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/notifier.h>
 
 struct pm_clk_notifier_block {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5c90e059cdb7..215867204aa9 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -8,7 +8,7 @@
 #ifndef _LINUX_PM_DOMAIN_H
 #define _LINUX_PM_DOMAIN_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/ktime.h>
 #include <linux/mutex_types.h>
 #include <linux/pm.h>
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4a69d4af3ff8..97234cba44e0 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -14,7 +14,7 @@
 
 #include <linux/plist.h>
 #include <linux/notifier.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 
 enum pm_qos_flags_status {
 	PM_QOS_FLAGS_UNDEFINED = -1,
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 2bcf998da2a7..762ffc2c5dc2 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -12,7 +12,7 @@
 #ifndef __LINUX_POWER_SUPPLY_H__
 #define __LINUX_POWER_SUPPLY_H__
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/workqueue_types.h>
 #include <linux/leds.h>
 #include <linux/spinlock_types.h>
diff --git a/include/linux/powercap.h b/include/linux/powercap.h
index 3d557bbcd2c7..da48bd9bcdd7 100644
--- a/include/linux/powercap.h
+++ b/include/linux/powercap.h
@@ -7,7 +7,7 @@
 #ifndef __POWERCAP_H__
 #define __POWERCAP_H__
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/idr.h>
 
 /*
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 98401e771e75..82cb7f0fd843 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -34,7 +34,7 @@ static inline time64_t rtc_tm_sub(struct rtc_time *lhs, struct rtc_time *rhs)
 	return rtc_tm_to_time64(lhs) - rtc_tm_to_time64(rhs);
 }
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/seq_file.h>
 #include <linux/cdev.h>
 #include <linux/poll.h>
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index c37473373649..94aa8de02ea7 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_SWIOTLB_H
 #define __LINUX_SWIOTLB_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/dma-direction.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -10,7 +10,6 @@
 #include <linux/spinlock_types.h>
 #include <linux/workqueue_types.h>
 
-struct device;
 struct page;
 struct scatterlist;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 14450673bd8b..ba5d2bd8e007 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -11,7 +11,7 @@
 #define __THERMAL_H__
 
 #include <linux/idr.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/sysfs_types.h>
 #include <linux/workqueue_types.h>
 #include <uapi/linux/thermal.h>
diff --git a/include/linux/w1.h b/include/linux/w1.h
index 9a2a0ef39018..3cbc5e0bab9d 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -6,7 +6,7 @@
 #ifndef __LINUX_W1_H
 #define __LINUX_W1_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 
 /**
  * struct w1_reg_num - broken out slave device id
diff --git a/include/media/cec.h b/include/media/cec.h
index 4c9daa53ae34..562aad160e2b 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -11,7 +11,7 @@
 #include <linux/poll.h>
 #include <linux/fs.h>
 #include <linux/debugfs.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/cdev.h>
 #include <linux/kthread.h>
 #include <linux/cec-funcs.h>
diff --git a/include/media/media-devnode.h b/include/media/media-devnode.h
index d27c1c646c28..e690f171c67e 100644
--- a/include/media/media-devnode.h
+++ b/include/media/media-devnode.h
@@ -18,7 +18,7 @@
 
 #include <linux/poll.h>
 #include <linux/fs.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/cdev.h>
 
 struct media_device;
diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index 5dee575fbe86..9b8991560a3e 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -12,7 +12,7 @@
 #define __NET_NFC_H
 
 #include <linux/nfc.h>
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/skbuff.h>
 
 #define nfc_dbg(dev, fmt, ...) dev_dbg((dev), "NFC: " fmt, ##__VA_ARGS__)
diff --git a/include/pcmcia/ss.h b/include/pcmcia/ss.h
index 694e5ae0f245..4bf85a0cfa5e 100644
--- a/include/pcmcia/ss.h
+++ b/include/pcmcia/ss.h
@@ -12,7 +12,7 @@
 #ifndef _LINUX_SS_H
 #define _LINUX_SS_H
 
-#include <linux/device.h>
+#include <linux/device_types.h>
 #include <linux/sched.h>	/* task_struct, completion */
 #include <linux/mutex_types.h>
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index c70aafd415b5..74c9a6d165ac 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -2,6 +2,7 @@
 #ifndef _SCSI_SCSI_DEVICE_H
 #define _SCSI_SCSI_DEVICE_H
 
+#include <linux/device.h> // for device_reprobe()
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
 #include <linux/workqueue_types.h>
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 620ffbd44dbe..76b77496d734 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/sprintf.h>
 #include <linux/time.h>
-- 
2.39.2


