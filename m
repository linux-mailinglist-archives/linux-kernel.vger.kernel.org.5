Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77E7AE276
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjIYXfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjIYXfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:35:50 -0400
Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE3CCA;
        Mon, 25 Sep 2023 16:35:23 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 38PNYcNt921420; Tue, 26 Sep 2023 08:34:39 +0900
X-Iguazu-Qid: 2yAaUxDRJTAi8rQJgA
X-Iguazu-QSIG: v=2; s=0; t=1695684878; q=2yAaUxDRJTAi8rQJgA; m=xX/3yEd/L94v0Ake5aDZYIP3P66xwrJHLuGlZZPNEMw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1800) id 38PNYbHm055299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Sep 2023 08:34:37 +0900
X-SA-MID: 8623331
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/5] media: platform: visconti: Add Toshiba Visconti Video Input Interface driver
Date:   Tue, 26 Sep 2023 08:28:03 +0900
X-TSB-HOP2: ON
Message-Id: <20230925232806.950683-3-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
References: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
The interface device includes CSI2 Receiver,
frame grabber, video DMAC and image signal processor.

A driver instance provides three /dev/videoX device files;
one for RGB image capture, another one for optional RGB capture
with different parameters and the last one for RAW capture.

Through the device files, the driver provides streaming interface.
Both DMABUF and MMAP operations are supported.
A userland application should feed phisically continuous
DMA-BUF instances as capture buffers.

The driver is based on media controller framework.
Its operations are roughly mapped to three subdrivers;
CSI2 receiver subdevice, ISP subdevice and capture devices.

The Video DMACs have 32bit address space
and currently corresponding IOMMU driver is not provided.
Therefore, memory-block address for captured image is 32bit IOVA
which is equal to 32bit-truncated phisical address.
When the Visconti IOMMU driver (currently under development) is accepted,
the hardware layer will use 32bit IOVA mapped by the attached IOMMU.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
Changelog v2:
- Resend v1 because a patch exceeds size limit.

Changelog v3:
- Adapted to media control framework
- Introduced ISP subdevice, capture device
- Remove private IOCTLs and add vendor specific V4L2 controls
- Change function name avoiding camelcase and uppercase letters

Changelog v4:
- fix style problems at the v3 patch
- remove "index" member
- update example
- Split patches because the v3 patch exceeds size limit
- Stop using ID number to identify driver instance:
  - Use dynamically allocated structure to hold driver's context,
    instead of static one indexed by ID number.
  - internal functions accept context structure instead of ID number.
- Use pm_runtime to trigger initialization of HW
  along with open/close of device files.
  
Changelog v5:
- Fix coding style problems in viif.c

Changelog v6:
- update dependency description of Kconfig
- bugfix: usage of buffer pointed with dma_active
- remove unused macros
- add viif_common.c for commonly used register buffer control routine
- add initialization of Bus Controller (HWAIF) and Memory Protection Unit
- removed hwd_ and HWD_ prefix
- update source code documentation
- Suggestion from Hans Verkuil
  - pointer to userland memory is removed from uAPI arguments
    - style of structure is now "nested" instead of "chained by pointer";
  - use div64_u64 for 64bit division
  - define Visconti specific control IDs in v4l2-controls.h
  - set proper initial size to v4l2_ctrl_handler_init()
  - set all buffers to QUEUED state on an error at start_streaming
  - use vb2_is_busy() instead of vb2_is_streaming()
  - add parameter check for s->type and s->target in get_selection()
  - remove ioctls related to DV format and EDID
  - release v4l2 fh instance on and error at opening device file
  - support VB2_MMAP mode for streaming operation 
  - add initial value to each vendor specific control
  - GET_LAST_CAPTURE_STATUS control is updated asyncnously from workqueue
  - applied v4l2-compliance
- Suggestion from Sakari Ailus
  - use div64_u64 for 64bit division
  - update copyright's year
  - use common definition of MIPI CSI2 DataTypes
  - remove redandunt cast
  - use bool instead of HWD_VIIF_ENABLE/DISABLE
  - simplify comparison to 0
  - simplify statements with trigram operator
  - remove redundant local variables
  - simplify timeout loop
  - use general integer types instead of u32/s32
- Suggestion from Laurent Pinchart
  - moved VIIF driver to driver/platform/toshiba/visconti
  - add CSI2RX subdevice
  - change register access: struct-style to macro-style
  - use common definition of MIPI CSI2 DataTypes
  - Kconfig: add SPDX header, add V4L2_ASYNC
  - remove unused type definitions
  - define enums instead of successive macro constants
  - remove redundant parenthesis of macro constant
  - embed struct hwd_res into struct viif_device
  - turn switch-case into table lookup
  - use xxx_dma instead of xxx_paddr for variable names of IOVA
  - literal value: just 0 instead of 0x0
  - use literal 1 or 0 instead of HWD_VIIF_ENABLE, DISABLE for register access
  - use true or false instead of HWD_VIIF_ENABLE, DISABLE for function calls
  - remove ioctl request handlers which refers subdevices

Changelog v7:
- change compatible string to visconti5-viif
- remove unused variables
- set static to internal functions
- Suggestion from kernel test robot <lkp@intel.com>
  - update references to headers

Changelog v8:
- bugfix: handling return value of visconti_viiif_parse_dt()
- add visconti_viif_subdev_notifier_register() to gather
  all operations around v4l2_async_notifier
- update for v6.6-rc2
  - use v4l2_async_connection instead of v4l2_async_subdev
  - aid for devices using subdev active state
- add __maybe_unused for runtime_pm callbacks
- Suggestion from Krzysztof Kozlowski
  - use static initialization of local variable
  - use dev_err_probe()
  - remove error message for DMA memory allocation failure
  - remove unused comment messages
  - add error handling at fail of workqueue_create()
  - remove redundant mutex for pm_runtime callback routines
- Suggestion from Hans Verkuil
  - remove pr_info() calls
  - build check with media_stage.git 
  - some lacks for kerneldoc description

 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/toshiba/Kconfig        |    6 +
 drivers/media/platform/toshiba/Makefile       |    2 +
 .../media/platform/toshiba/visconti/Kconfig   |   18 +
 .../media/platform/toshiba/visconti/Makefile  |    8 +
 .../media/platform/toshiba/visconti/viif.c    |  652 ++++++
 .../media/platform/toshiba/visconti/viif.h    |  374 ++++
 .../platform/toshiba/visconti/viif_capture.c  | 1489 ++++++++++++++
 .../platform/toshiba/visconti/viif_capture.h  |   22 +
 .../platform/toshiba/visconti/viif_common.c   |  199 ++
 .../platform/toshiba/visconti/viif_common.h   |   38 +
 .../platform/toshiba/visconti/viif_csi2rx.c   |  691 +++++++
 .../platform/toshiba/visconti/viif_csi2rx.h   |   24 +
 .../toshiba/visconti/viif_csi2rx_regs.h       |  102 +
 .../platform/toshiba/visconti/viif_isp.c      | 1264 ++++++++++++
 .../platform/toshiba/visconti/viif_isp.h      |   24 +
 .../platform/toshiba/visconti/viif_regs.h     |  716 +++++++
 include/uapi/linux/v4l2-controls.h            |    6 +
 include/uapi/linux/visconti_viif.h            | 1800 +++++++++++++++++
 20 files changed, 7437 insertions(+)
 create mode 100644 drivers/media/platform/toshiba/Kconfig
 create mode 100644 drivers/media/platform/toshiba/Makefile
 create mode 100644 drivers/media/platform/toshiba/visconti/Kconfig
 create mode 100644 drivers/media/platform/toshiba/visconti/Makefile
 create mode 100644 drivers/media/platform/toshiba/visconti/viif.c
 create mode 100644 drivers/media/platform/toshiba/visconti/viif.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_capture.c
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_capture.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_common.c
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_common.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx.c
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx_regs.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_isp.c
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_isp.h
 create mode 100644 drivers/media/platform/toshiba/visconti/viif_regs.h
 create mode 100644 include/uapi/linux/visconti_viif.h

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index ee579916f874..d20ca25d3d00 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -84,6 +84,7 @@ source "drivers/media/platform/sunxi/Kconfig"
 source "drivers/media/platform/ti/Kconfig"
 source "drivers/media/platform/verisilicon/Kconfig"
 source "drivers/media/platform/via/Kconfig"
+source "drivers/media/platform/toshiba/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 
 endif # MEDIA_PLATFORM_DRIVERS
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 5453bb868e67..0406f2488dd3 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -27,6 +27,7 @@ obj-y += sunxi/
 obj-y += ti/
 obj-y += verisilicon/
 obj-y += via/
+obj-y += toshiba/
 obj-y += xilinx/
 
 # Please place here only ancillary drivers that aren't SoC-specific
diff --git a/drivers/media/platform/toshiba/Kconfig b/drivers/media/platform/toshiba/Kconfig
new file mode 100644
index 000000000000..f02983f4fc97
--- /dev/null
+++ b/drivers/media/platform/toshiba/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+comment "Toshiba media platform drivers"
+
+source "drivers/media/platform/toshiba/visconti/Kconfig"
+
diff --git a/drivers/media/platform/toshiba/Makefile b/drivers/media/platform/toshiba/Makefile
new file mode 100644
index 000000000000..2bce85ef3b48
--- /dev/null
+++ b/drivers/media/platform/toshiba/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += visconti/
diff --git a/drivers/media/platform/toshiba/visconti/Kconfig b/drivers/media/platform/toshiba/visconti/Kconfig
new file mode 100644
index 000000000000..acab70e9c04b
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_VISCONTI_VIIF
+	tristate "Visconti Camera Interface driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && OF
+	depends on ARCH_VISCONTI || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select V4L2_ASYNC
+	select V4L2_FWNODE
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This is V4L2 driver for Toshiba Visconti Camera Interface hardware
+
+	  This driver yields 3 video device nodes
+	  and 1 media device node for a hardware instance.
+	  To compile this driver as a module, choose M here: the
+	  module will be called visconti-viif.
diff --git a/drivers/media/platform/toshiba/visconti/Makefile b/drivers/media/platform/toshiba/visconti/Makefile
new file mode 100644
index 000000000000..5f2f9199c772
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Visconti video input device driver
+#
+
+visconti-viif-objs = viif.o viif_capture.o viif_isp.o viif_csi2rx.o viif_common.o
+
+obj-$(CONFIG_VIDEO_VISCONTI_VIIF) += visconti-viif.o
diff --git a/drivers/media/platform/toshiba/visconti/viif.c b/drivers/media/platform/toshiba/visconti/viif.c
new file mode 100644
index 000000000000..862310025773
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif.c
@@ -0,0 +1,652 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <media/v4l2-fwnode.h>
+
+#include "viif.h"
+#include "viif_capture.h"
+#include "viif_csi2rx.h"
+#include "viif_common.h"
+#include "viif_isp.h"
+#include "viif_regs.h"
+
+/*=============================================*/
+/* Register Access */
+/*=============================================*/
+static inline void viif_hwaif_write(struct viif_device *viif_dev, unsigned int regid, u32 val)
+{
+	writel(val, viif_dev->hwaif_reg + regid);
+}
+
+static inline void viif_mpu_write(struct viif_device *viif_dev, unsigned int regid, u32 val)
+{
+	writel(val, viif_dev->mpu_reg + regid);
+}
+
+/*=============================================*/
+/* Low Layer Interrupt handler */
+/*=============================================*/
+static void viif_main_status_err_set_irq_mask(struct viif_device *viif_dev, u32 mask)
+{
+	viif_capture_write(viif_dev, REG_INT_M_MASK, mask);
+}
+
+static void viif_main_vsync_set_irq_mask(struct viif_device *viif_dev, u32 mask)
+{
+	viif_capture_write(viif_dev, REG_INT_M_SYNC_MASK, mask);
+}
+
+static void viif_sub_status_err_set_irq_mask(struct viif_device *viif_dev, u32 mask)
+{
+	viif_capture_write(viif_dev, REG_INT_S_MASK, mask);
+}
+
+static void viif_sub_vsync_set_irq_mask(struct viif_device *viif_dev, u32 mask)
+{
+	viif_capture_write(viif_dev, REG_INT_S_SYNC_MASK, mask);
+}
+
+/* IRQ handler: read and clear error status, report masked result */
+static void viif_read_err_irq_registers(struct viif_device *viif_dev, u32 *event_main,
+					u32 *event_sub)
+{
+	u32 val, mask;
+
+	*event_main = 0;
+	*event_sub = 0;
+
+	val = viif_capture_read(viif_dev, REG_INT_M_STATUS);
+	mask = viif_capture_read(viif_dev, REG_INT_M_MASK);
+	val &= ~mask;
+	if (val) {
+		viif_capture_write(viif_dev, REG_INT_M_STATUS, val);
+		*event_main = val;
+	}
+
+	val = viif_capture_read(viif_dev, REG_INT_S_STATUS);
+	mask = viif_capture_read(viif_dev, REG_INT_S_MASK);
+	val &= ~mask;
+	if (val) {
+		viif_capture_write(viif_dev, REG_INT_S_STATUS, val);
+		*event_sub = val;
+	}
+}
+
+/* IRQ handler: read and clear vsync status, report masked result */
+static void viif_read_vsynq_irq_registers(struct viif_device *viif_dev, u32 *event_main,
+					  u32 *event_sub)
+{
+	u32 val, mask;
+
+	*event_main = 0;
+	*event_sub = 0;
+
+	val = viif_capture_read(viif_dev, REG_INT_M_SYNC);
+	mask = viif_capture_read(viif_dev, REG_INT_M_SYNC_MASK);
+	val &= ~mask;
+	if (val) {
+		viif_capture_write(viif_dev, REG_INT_M_SYNC, val);
+		*event_main = val;
+	}
+
+	val = viif_capture_read(viif_dev, REG_INT_S_SYNC);
+	mask = viif_capture_read(viif_dev, REG_INT_S_SYNC_MASK);
+	val &= ~mask;
+	if (val) {
+		viif_capture_write(viif_dev, REG_INT_S_SYNC, val);
+		*event_sub = val;
+	}
+}
+
+/* IRQ handler: read and clear L2ISP status, report result */
+static u32 viif_get_l2_transfer_status(struct viif_device *viif_dev)
+{
+	u32 l2_status;
+
+	l2_status = viif_capture_read(viif_dev, REG_L2_CRGBF_ISP_INT);
+	viif_capture_write(viif_dev, REG_L2_CRGBF_ISP_INT, l2_status);
+	return l2_status & MASK_L2_STATUS_ERR_ALL;
+}
+
+/*=============================================*/
+/* Low Layer hardware setup */
+/*=============================================*/
+static void viif_mpu_disable(struct viif_device *viif_dev)
+{
+	viif_mpu_write(viif_dev, REG_MPU_MP_EN, 0);
+	viif_mpu_write(viif_dev, REG_MPU_MF_EN, 1);
+}
+
+static void viif_hwaif_enable(struct viif_device *viif_dev)
+{
+	/* pass through; disable all entries */
+	viif_hwaif_write(viif_dev, REG_HWAIF_REGION_ENTRY_EN, 0);
+
+	/* no limit for outstanding requests */
+	viif_hwaif_write(viif_dev, REG_HWAIF_OSTD_RLEN, 0);
+	viif_hwaif_write(viif_dev, REG_HWAIF_OSTD_WREQ, 0);
+
+	/* no data-pack/outstanding */
+	viif_hwaif_write(viif_dev, REG_HWAIF_HWAIF_CONF, 0);
+
+	/* enable bus access */
+	viif_hwaif_write(viif_dev, REG_HWAIF_HWAIF_EN, 1);
+}
+
+/*=============================================*/
+/* handling V4L2 framework */
+/*=============================================*/
+static void visconti_viif_hw_on(struct viif_device *viif_dev)
+{
+	/* Disable MPU */
+	viif_mpu_disable(viif_dev);
+	/* Enable HWAIF */
+	viif_hwaif_enable(viif_dev);
+}
+
+static void visconti_viif_hw_off(struct viif_device *viif_dev)
+{
+	/* Uninitialize HWD driver */
+}
+
+static inline struct viif_device *v4l2_to_viif(struct v4l2_device *v4l2_dev)
+{
+	return container_of(v4l2_dev, struct viif_device, v4l2_dev);
+}
+
+/* This function runs in work queue context */
+/* Reading ISP registers takes 30us. */
+/* Please note that this function should be finished */
+/* before a userland capture application is trigered by vb2_buffer_done() */
+static void visconti_viif_wthread_l1info(struct work_struct *work)
+{
+	/* called function is implemented by the next patch */
+/*
+ *	struct viif_device *viif_dev = container_of(work, struct viif_device, work);
+ *
+ *	visconti_viif_save_l1_info(viif_dev);
+ */
+}
+
+static void viif_vsync_irq_handler_w_isp(struct viif_device *viif_dev)
+{
+	u32 event_main, event_sub, status_err, l2_transfer_status;
+	u64 ts;
+
+	ts = ktime_get_ns();
+	viif_read_vsynq_irq_registers(viif_dev, &event_main, &event_sub);
+
+	/* Delayed Vsync of MAIN unit */
+	if (event_main & MASK_INT_M_SYNC_LINES_DELAY_INT2) {
+		/* unmask timeout error of gamma table */
+		viif_main_status_err_set_irq_mask(viif_dev, MASK_INT_M_DELAY_INT_ERROR);
+		viif_dev->masked_gamma_path = 0;
+
+		/* Get abort status of L2ISP */
+		spin_lock(&viif_dev->regbuf_lock);
+		hwd_viif_isp_guard_start(viif_dev);
+		l2_transfer_status = viif_get_l2_transfer_status(viif_dev);
+		hwd_viif_isp_guard_end(viif_dev);
+		spin_unlock(&viif_dev->regbuf_lock);
+
+		status_err = viif_dev->status_err;
+		viif_dev->status_err = 0;
+
+		visconti_viif_capture_switch_buffer(&viif_dev->cap_dev0, status_err,
+						    l2_transfer_status, ts);
+		visconti_viif_capture_switch_buffer(&viif_dev->cap_dev1, status_err,
+						    l2_transfer_status, ts);
+		queue_work(viif_dev->wq, &viif_dev->work);
+	}
+
+	/* Delayed Vsync of SUB unit */
+	if (event_sub & MASK_INT_S_SYNC_LINES_DELAY_INT1)
+		visconti_viif_capture_switch_buffer(&viif_dev->cap_dev2, 0, 0, ts);
+}
+
+static void viif_status_err_irq_handler(struct viif_device *viif_dev)
+{
+	u32 event_main, event_sub, val, mask;
+
+	viif_read_err_irq_registers(viif_dev, &event_main, &event_sub);
+
+	if (event_main) {
+		/* mask for gamma table time out error which will be unmasked in the next Vsync */
+		val = FIELD_GET(MASK_INT_M_L2ISP_GAMMA_TABLE_TIMEOUT, event_main);
+		if (val) {
+			viif_dev->masked_gamma_path |= val;
+			mask = MASK_INT_M_DELAY_INT_ERROR |
+			       FIELD_PREP(MASK_INT_M_L2ISP_GAMMA_TABLE_TIMEOUT,
+					  viif_dev->masked_gamma_path);
+			viif_main_status_err_set_irq_mask(viif_dev, mask);
+		}
+
+		viif_dev->status_err = event_main;
+	}
+	viif_dev->reported_err_main |= event_main;
+	viif_dev->reported_err_sub |= event_sub;
+	dev_err(viif_dev->dev, "MAIN/SUB error 0x%x 0x%x.\n", event_main, event_sub);
+}
+
+static void viif_csi2rx_err_irq_handler(struct viif_device *viif_dev)
+{
+	u32 event;
+
+	event = visconti_viif_csi2rx_err_irq_handler(viif_dev);
+	viif_dev->reported_err_csi2rx |= event;
+	dev_err(viif_dev->dev, "CSI2RX error 0x%x.\n", event);
+}
+
+static irqreturn_t visconti_viif_irq(int irq, void *dev_id)
+{
+	struct viif_device *viif_dev = dev_id;
+	int irq_type = irq - viif_dev->irq[0];
+
+	switch (irq_type) {
+	case 0:
+		viif_vsync_irq_handler_w_isp(viif_dev);
+		break;
+	case 1:
+		viif_status_err_irq_handler(viif_dev);
+		break;
+	case 2:
+		viif_csi2rx_err_irq_handler(viif_dev);
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* ----- Async Notifier Operations----- */
+static int visconti_viif_create_sensor_link(struct viif_device *viif_dev)
+{
+	struct v4l2_subdev *sensor_sd = viif_dev->sensor_sd;
+	int source_pad;
+	int ret;
+
+	if (!sensor_sd)
+		return -EINVAL;
+
+	/* camera subdev pad0 -> isp suddev pad0 */
+	source_pad = media_entity_get_fwnode_pad(&sensor_sd->entity, sensor_sd->fwnode,
+						 MEDIA_PAD_FL_SOURCE);
+	if (source_pad < 0) {
+		dev_err(viif_dev->dev, "failed to find source pad\n");
+		return source_pad;
+	}
+
+	ret = media_create_pad_link(&sensor_sd->entity, source_pad,
+				    &viif_dev->csi2rx_subdev.sd.entity, VIIF_CSI2RX_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		dev_err(viif_dev->dev, "failed create_pad_link (camera:src -> csi2rx:sink)\n");
+
+	return ret;
+}
+
+static int visconti_viif_notify_bound(struct v4l2_async_notifier *notifier,
+				      struct v4l2_subdev *v4l2_sd,
+				      struct v4l2_async_connection *asc)
+{
+	struct viif_device *viif_dev = container_of(notifier, struct viif_device, notifier);
+	struct viif_sensor_async *s_as = container_of(asc, struct viif_sensor_async, asc);
+
+	s_as->v4l2_sd = v4l2_sd;
+	if (!s_as->index) {
+		viif_dev->sensor_sd = v4l2_sd;
+		viif_dev->sensor_num_lane = s_as->num_lane;
+		return visconti_viif_create_sensor_link(viif_dev);
+	}
+
+	return 0;
+}
+
+static void visconti_viif_notify_unbind(struct v4l2_async_notifier *notifier,
+					struct v4l2_subdev *subdev,
+					struct v4l2_async_connection *asc)
+{
+	struct viif_device *viif_dev = container_of(notifier, struct viif_device, notifier);
+
+	if (viif_dev->sensor_sd == subdev)
+		viif_dev->sensor_sd = NULL;
+}
+
+static int visconti_viif_notify_complete(struct v4l2_async_notifier *notifier)
+{
+	struct v4l2_device *v4l2_dev = notifier->v4l2_dev;
+	struct viif_device *viif_dev = v4l2_to_viif(v4l2_dev);
+	int ret;
+
+	ret = v4l2_device_register_subdev_nodes(v4l2_dev);
+	if (ret)
+		return ret;
+
+	return visconti_viif_capture_register_ctrl_handlers(viif_dev);
+}
+
+static const struct v4l2_async_notifier_operations viif_notify_ops = {
+	.bound = visconti_viif_notify_bound,
+	.unbind = visconti_viif_notify_unbind,
+	.complete = visconti_viif_notify_complete,
+};
+
+/* ----- Probe and Remove ----- */
+static int visconti_viif_subdev_notifier_register(struct viif_device *viif_dev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(viif_dev->dev);
+	struct v4l2_async_notifier *ntf = &viif_dev->notifier;
+	struct fwnode_handle *ep;
+	unsigned int index = 0;
+	int ret = 0;
+
+	v4l2_async_nf_init(ntf, &viif_dev->v4l2_dev);
+	ntf->ops = &viif_notify_ops;
+
+	fwnode_graph_for_each_endpoint(fwnode, ep) {
+		struct v4l2_fwnode_endpoint vep = {};
+		struct viif_sensor_async *viif_asd;
+
+		ret = v4l2_fwnode_endpoint_parse(ep, &vep);
+		if (ret) {
+			dev_err(viif_dev->dev, "failed to parse endpoint %pfw\n", ep);
+			break;
+		}
+
+		if (vep.bus_type != V4L2_MBUS_CSI2_DPHY || vep.bus.mipi_csi2.num_data_lanes == 0) {
+			dev_warn(viif_dev->dev, "missing CSI-2 properties in endpoint %pfw\n", ep);
+			break;
+		}
+
+		viif_asd = v4l2_async_nf_add_fwnode_remote(ntf, ep, struct viif_sensor_async);
+		viif_asd->index = index++;
+		viif_asd->num_lane = vep.bus.mipi_csi2.num_data_lanes;
+	}
+
+	if (ret) {
+		fwnode_handle_put(ep);
+		v4l2_async_nf_cleanup(ntf);
+		return ret;
+	}
+
+	if (!index)
+		dev_dbg(viif_dev->dev, "No remote subdevice found\n");
+
+	ret = v4l2_async_nf_register(ntf);
+	if (ret) {
+		v4l2_async_nf_cleanup(ntf);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int visconti_viif_create_links(struct viif_device *viif_dev)
+{
+	int ret;
+
+	ret = media_create_pad_link(&viif_dev->csi2rx_subdev.sd.entity, VIIF_CSI2RX_PAD_SRC,
+				    &viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret) {
+		dev_err(viif_dev->dev, "failed create_pad_link (csi2rx:src -> isp:sink)\n");
+		return ret;
+	}
+
+	ret = media_create_pad_link(&viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SRC_PATH0,
+				    &viif_dev->cap_dev0.vdev.entity, VIIF_CAPTURE_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret) {
+		dev_err(viif_dev->dev, "failed create_pad_link (isp:src -> capture0:sink)\n");
+		return ret;
+	}
+
+	ret = media_create_pad_link(&viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SRC_PATH1,
+				    &viif_dev->cap_dev1.vdev.entity, VIIF_CAPTURE_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret) {
+		dev_err(viif_dev->dev, "failed create_pad_link (isp:src -> capture1:sink)\n");
+		return ret;
+	}
+
+	ret = media_create_pad_link(&viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SRC_PATH2,
+				    &viif_dev->cap_dev2.vdev.entity, VIIF_CAPTURE_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		dev_err(viif_dev->dev, "failed create_pad_link (isp:src -> capture2:sink)\n");
+
+	return ret;
+}
+
+static const struct of_device_id visconti_viif_of_table[] = {
+	{
+		.compatible = "toshiba,visconti5-viif",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, visconti_viif_of_table);
+
+#define NUM_IRQS   3
+#define IRQ_ID_STR "viif"
+
+static int visconti_viif_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct viif_device *viif_dev;
+	dma_addr_t tables_dma;
+	int ret, i;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
+	if (ret)
+		return ret;
+
+	viif_dev = devm_kzalloc(dev, sizeof(*viif_dev), GFP_KERNEL);
+	if (!viif_dev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, viif_dev);
+	viif_dev->dev = dev;
+
+	spin_lock_init(&viif_dev->regbuf_lock);
+	mutex_init(&viif_dev->stream_lock);
+
+	viif_dev->capture_reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(viif_dev->capture_reg))
+		return PTR_ERR(viif_dev->capture_reg);
+
+	viif_dev->csi2host_reg = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(viif_dev->csi2host_reg))
+		return PTR_ERR(viif_dev->csi2host_reg);
+
+	viif_dev->hwaif_reg = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(viif_dev->hwaif_reg))
+		return PTR_ERR(viif_dev->hwaif_reg);
+
+	viif_dev->mpu_reg = devm_platform_ioremap_resource(pdev, 3);
+	if (IS_ERR(viif_dev->mpu_reg))
+		return PTR_ERR(viif_dev->mpu_reg);
+
+	viif_dev->run_flag_main = false;
+
+	for (i = 0; i < NUM_IRQS; i++) {
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "failed to acquire irq resource\n");
+		viif_dev->irq[i] = ret;
+		ret = devm_request_irq(dev, viif_dev->irq[i], visconti_viif_irq, 0, IRQ_ID_STR,
+				       viif_dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "irq request failed\n");
+	}
+
+	viif_dev->tables =
+		dma_alloc_wc(dev, sizeof(struct viif_table_area), &tables_dma, GFP_KERNEL);
+	if (!viif_dev->tables)
+		return -ENOMEM;
+	viif_dev->tables_dma = (struct viif_table_area *)tables_dma;
+
+	pm_runtime_enable(dev);
+
+	/* build media_dev */
+	viif_dev->media_dev.hw_revision = 0;
+	strscpy(viif_dev->media_dev.model, VIIF_DRIVER_NAME, sizeof(viif_dev->media_dev.model));
+	viif_dev->media_dev.dev = dev;
+	/* TODO: platform:visconti-viif-0,1,2,3 for each VIIF driver instance */
+	snprintf(viif_dev->media_dev.bus_info, sizeof(viif_dev->media_dev.bus_info), "%s-0",
+		 VIIF_BUS_INFO_BASE);
+	media_device_init(&viif_dev->media_dev);
+
+	/* build v4l2_dev */
+	viif_dev->v4l2_dev.mdev = &viif_dev->media_dev;
+	ret = v4l2_device_register(dev, &viif_dev->v4l2_dev);
+	if (ret)
+		goto error_dma_free;
+
+	ret = media_device_register(&viif_dev->media_dev);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to register media device\n");
+		goto error_v4l2_unregister;
+	}
+
+	ret = visconti_viif_csi2rx_register(viif_dev);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to register csi2rx sub node\n");
+		goto error_media_unregister;
+	}
+
+	ret = visconti_viif_isp_register(viif_dev);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to register isp sub node\n");
+		goto error_csi2rx_unregister;
+	}
+
+	ret = visconti_viif_capture_register(viif_dev);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to register capture node\n");
+		goto error_isp_unregister;
+	}
+
+	ret = visconti_viif_create_links(viif_dev);
+	if (ret)
+		goto error_capture_unregister;
+
+	visconti_viif_subdev_notifier_register(viif_dev);
+	if (ret)
+		goto error_capture_unregister;
+
+	viif_dev->wq = create_workqueue("visconti-viif");
+	if (!viif_dev->wq) {
+		ret = dev_err_probe(dev, -ENOMEM, "failed to create workqueue\n");
+		goto error_notifier_unregister;
+	}
+	INIT_WORK(&viif_dev->work, visconti_viif_wthread_l1info);
+
+	return 0;
+
+error_notifier_unregister:
+	v4l2_async_nf_unregister(&viif_dev->notifier);
+	v4l2_async_nf_cleanup(&viif_dev->notifier);
+error_capture_unregister:
+	visconti_viif_capture_unregister(viif_dev);
+error_isp_unregister:
+	visconti_viif_isp_unregister(viif_dev);
+error_csi2rx_unregister:
+	visconti_viif_csi2rx_unregister(viif_dev);
+error_media_unregister:
+	media_device_unregister(&viif_dev->media_dev);
+error_v4l2_unregister:
+	v4l2_device_unregister(&viif_dev->v4l2_dev);
+error_dma_free:
+	pm_runtime_disable(dev);
+	dma_free_wc(&pdev->dev, sizeof(struct viif_table_area), viif_dev->tables,
+		    (dma_addr_t)viif_dev->tables_dma);
+	return ret;
+}
+
+static int visconti_viif_remove(struct platform_device *pdev)
+{
+	struct viif_device *viif_dev = platform_get_drvdata(pdev);
+
+	destroy_workqueue(viif_dev->wq);
+	v4l2_async_nf_unregister(&viif_dev->notifier);
+	v4l2_async_nf_cleanup(&viif_dev->notifier);
+	visconti_viif_capture_unregister(viif_dev);
+	visconti_viif_isp_unregister(viif_dev);
+	visconti_viif_csi2rx_unregister(viif_dev);
+	media_device_unregister(&viif_dev->media_dev);
+	v4l2_device_unregister(&viif_dev->v4l2_dev);
+
+	pm_runtime_disable(&pdev->dev);
+	dma_free_wc(&pdev->dev, sizeof(struct viif_table_area), viif_dev->tables,
+		    (dma_addr_t)viif_dev->tables_dma);
+
+	return 0;
+}
+
+static int __maybe_unused visconti_viif_runtime_suspend(struct device *dev)
+{
+	/* This callback is kicked when the last device-file is closed */
+	struct viif_device *viif_dev = dev_get_drvdata(dev);
+
+	visconti_viif_hw_off(viif_dev);
+
+	return 0;
+}
+
+static int __maybe_unused visconti_viif_runtime_resume(struct device *dev)
+{
+	/* This callback is kicked when the first device-file is opened */
+	struct viif_device *viif_dev = dev_get_drvdata(dev);
+
+	viif_dev->rawpack_mode = (u32)VIIF_RAWPACK_DISABLE;
+
+	/* Initialize HWD driver */
+	visconti_viif_hw_on(viif_dev);
+
+	/* VSYNC mask setting of MAIN unit */
+	viif_main_vsync_set_irq_mask(viif_dev, MASK_INT_M_SYNC_MASK_SET);
+
+	/* STATUS error mask setting of MAIN unit */
+	viif_main_status_err_set_irq_mask(viif_dev, MASK_INT_M_DELAY_INT_ERROR);
+
+	/* VSYNC mask settings of SUB unit */
+	viif_sub_vsync_set_irq_mask(viif_dev, MASK_INT_S_SYNC_MASK_SET);
+
+	/* STATUS error mask setting(unmask) of SUB unit */
+	viif_sub_status_err_set_irq_mask(viif_dev,
+					 MASK_INT_S_RESERVED_SET | MASK_INT_S_DELAY_INT_ERROR);
+
+	return 0;
+}
+
+static const struct dev_pm_ops visconti_viif_pm_ops = {
+	SET_RUNTIME_PM_OPS(visconti_viif_runtime_suspend, visconti_viif_runtime_resume, NULL)
+};
+
+static struct platform_driver visconti_viif_driver = {
+	.probe = visconti_viif_probe,
+	.remove = visconti_viif_remove,
+	.driver = {
+			.name = "visconti_viif",
+			.of_match_table = visconti_viif_of_table,
+			.pm = &visconti_viif_pm_ops,
+		},
+};
+
+module_platform_driver(visconti_viif_driver);
+
+MODULE_AUTHOR("Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>");
+MODULE_DESCRIPTION("Toshiba Visconti Video Input driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/media/platform/toshiba/visconti/viif.h b/drivers/media/platform/toshiba/visconti/viif.h
new file mode 100644
index 000000000000..6ad3e2e1b43a
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif.h
@@ -0,0 +1,374 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef VIIF_H
+#define VIIF_H
+
+#include <linux/visconti_viif.h>
+#include <linux/workqueue.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mediabus.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/videobuf2-dma-contig.h>
+
+#define VIIF_DRIVER_NAME   "visconti-viif"
+#define VIIF_BUS_INFO_BASE "platform:" VIIF_DRIVER_NAME
+
+#define VIIF_ISP_REGBUF_0 0
+#define VIIF_L2ISP_POST_0 0
+#define VIIF_L2ISP_POST_1 1
+#define VIIF_MAX_POST_NUM 2U
+
+#define VIIF_CAPTURE_PAD_SINK  0
+#define VIIF_ISP_PAD_SINK      0
+#define VIIF_ISP_PAD_SRC_PATH0 1
+#define VIIF_ISP_PAD_SRC_PATH1 2
+#define VIIF_ISP_PAD_SRC_PATH2 3
+#define VIIF_ISP_PAD_NUM       4
+
+#define VIIF_CSI2RX_PAD_SINK 0
+#define VIIF_CSI2RX_PAD_SRC  1
+#define VIIF_CSI2RX_PAD_NUM  2
+
+#define CAPTURE_PATH_MAIN_POST0 0
+#define CAPTURE_PATH_MAIN_POST1 1
+#define CAPTURE_PATH_SUB	2
+
+#define VIIF_DPC_TABLE_BYTES	   8192
+#define VIIF_LSC_TABLE_BYTES	   1536
+#define VIIF_UNDIST_TABLE_BYTES	   8192
+#define VIIF_L2_GAMMA_TABLE_BYTES  512
+#define VIIF_L2_GAMMA_TABLE_CH_NUM 6
+
+#define VIIF_HW_AVAILABLE_IRQS 4
+
+#define VIIF_SYS_CLK 500000UL
+
+enum viif_output_color_mode {
+	VIIF_COLOR_Y_G = 0,
+	VIIF_COLOR_U_B = 1U,
+	VIIF_COLOR_V_R = 2U,
+	VIIF_COLOR_YUV_RGB = 4U
+};
+
+/**
+ * struct viif_img_area - image area definition
+ * @x: x position. Range: [0..8062]
+ * @y: y position. Range: [0..3966]
+ * @w: image width. Range: [128..8190]
+ * @h: image height. Range: [128..4094]
+ */
+struct viif_img_area {
+	u32 x;
+	u32 y;
+	u32 w;
+	u32 h;
+};
+
+/**
+ * struct viif_out_process - configuration of output process of MAIN unit and L2ISP
+ * @half_scale: true to enable half scaling
+ * @select_color: viif_output_color_mode "select output color"
+ * @alpha: alpha value used in case of ARGB8888 output. Range: [0..255]
+ */
+struct viif_out_process {
+	bool half_scale;
+	enum viif_output_color_mode select_color;
+	u8 alpha;
+};
+
+/**
+ * struct viif_fmt - description of supported output image format
+ * @fourcc: V4L2 fourcc format ID
+ * @bpp: bits per pixel for each plane
+ * @num_planes: number of planes in a image
+ * @colorspace: colorspace ID
+ * @pitch_align: alignment constraint of pitch
+ */
+struct viif_fmt {
+	u32 fourcc;
+	u8 bpp[3];
+	u8 num_planes;
+	u32 colorspace;
+	u32 pitch_align;
+};
+
+/**
+ * struct viif_sensor_async -  sensor information handled by v4l2_async APIs
+ * @asc:      async_connection for the sensor
+ * @v4l2_sd:  v4l2_subdev for the sensor
+ * @num_lane: number of lanes provided by the sensor
+ * @index:    index of the sensor
+ */
+struct viif_sensor_async {
+	struct v4l2_async_connection asc;
+	struct v4l2_subdev *v4l2_sd;
+	unsigned int num_lane;
+	unsigned int index;
+};
+
+/*
+ * struct viif_table_area - table for ISP features.
+ *
+ * The memory block for this structure must be allocated with dma_alloc_wc()
+ * so that the allocated block will be phisically continuous.
+ */
+struct viif_table_area {
+	/* L1ISP DPC */
+	u32 dpc_table_h[VIIF_DPC_TABLE_BYTES / sizeof(u32)];
+	u32 dpc_table_m[VIIF_DPC_TABLE_BYTES / sizeof(u32)];
+	u32 dpc_table_l[VIIF_DPC_TABLE_BYTES / sizeof(u32)];
+	/* L1ISP LSC */
+	u16 lsc_table_gr[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	u16 lsc_table_r[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	u16 lsc_table_b[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	u16 lsc_table_gb[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	/* L2ISP UNDIST */
+	u32 undist_write_g[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	u32 undist_read_b[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	u32 undist_read_g[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	u32 undist_read_r[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	/* L2ISP GAMMA */
+	u16 l2_gamma_table[VIIF_MAX_POST_NUM][VIIF_L2_GAMMA_TABLE_CH_NUM]
+			  [VIIF_L2_GAMMA_TABLE_BYTES / sizeof(u16)];
+};
+
+/**
+ * struct cap_dev - device node for capture device
+ * @pathid: 0 for MAIN POST0, 1 for MAIN POST1, 2 for SUB
+ * @vdev: video node
+ * @capture_pad: media pad
+ * @ctrl_handler: v4l2 control handler
+ * @vlock: serialize ioctl to vb2_queue and video_device
+ * @vb2_vq: queue of buffers
+ * @buf_queue: list of available buffers
+ * @active: VDMAC will start writing to this bufffer at the next VSYNC
+ * @dma_active: VDMAC will complete writing to this buffer at the next VSYNC
+ * @buf_cnt: number of queued buffers
+ * @sequence: total count of processed frames
+ * @buf_lock: serialize queue access (including ISR's)
+ * @v4l2_pix: current picture format (set by S_FMT)
+ * @out_format: output format for VDMAC
+ * @img_area: crop of output picture
+ * @out_process: output configuration
+ * @fmts: format supported by this capture device
+ * @fmt_size: sizeof fmts
+ * @viif_dev: reference to viif device
+ */
+struct cap_dev {
+	u32 pathid;
+	struct video_device vdev;
+	struct media_pad capture_pad;
+	struct v4l2_ctrl_handler ctrl_handler;
+	struct mutex vlock; /*serialize ioctl to vb2_queue and video_device*/
+
+	/* vb2 queue, capture buffer list and active buffer pointer */
+	struct vb2_queue vb2_vq;
+	struct list_head buf_queue;
+	struct vb2_v4l2_buffer *active;
+	struct vb2_v4l2_buffer *dma_active;
+	int buf_cnt;
+	unsigned int sequence;
+	spinlock_t buf_lock; /* serialize queue access (including ISR's) */
+
+	/* current configuration of frame and pixel format */
+	struct v4l2_pix_format_mplane v4l2_pix;
+	unsigned int out_format;
+	struct viif_img_area img_area;
+	struct viif_out_process out_process;
+
+	/* format supported by this cap device */
+	const struct viif_fmt *fmts;
+	int fmt_size;
+
+	struct viif_device *viif_dev;
+};
+
+/**
+ * struct isp_subdev - device node for ISP suddevice
+ * @sd: v4l2 subdevice
+ * @pads: media pad
+ * @pad_cfg: configuration of media pad
+ * @ops_lock: serialize V4L2 query
+ * @viif_dev: reference to viif device
+ * @ctrl_handler: v4l2 control handler
+ * @ctrl_rawpack_mode: control
+ * @ctrl_input_mode: control
+ * @ctrl_last_capture_status: control
+ */
+struct isp_subdev {
+	struct v4l2_subdev sd;
+	struct media_pad pads[VIIF_ISP_PAD_NUM];
+	struct v4l2_subdev_pad_config pad_cfg[VIIF_ISP_PAD_NUM];
+	struct mutex ops_lock; /* serialize V4L2 query */
+	struct viif_device *viif_dev;
+	struct v4l2_ctrl_handler ctrl_handler;
+	struct v4l2_ctrl *ctrl_rawpack_mode;
+	struct v4l2_ctrl *ctrl_input_mode;
+	struct v4l2_ctrl *ctrl_last_capture_status;
+};
+
+/**
+ * struct csi2rx_subdev - device node for CSI2RX suddevice
+ * @sd: v4l2 subdevice
+ * @pads: media pad
+ * @pad_cfg: configuration of media pad
+ * @ops_lock: serialize V4L2 query
+ * @viif_dev: reference to viif device
+ */
+struct csi2rx_subdev {
+	struct v4l2_subdev sd;
+	struct media_pad pads[VIIF_CSI2RX_PAD_NUM];
+	struct v4l2_subdev_pad_config pad_cfg[VIIF_CSI2RX_PAD_NUM];
+	struct mutex ops_lock; /* serialize V4L2 query */
+	struct viif_device *viif_dev;
+};
+
+/**
+ * struct viif_l2_roi_path_info - crop information of main paths
+ * @roi_num:
+ *
+ * - 1: crops of MAIN POST0 and POST1 share the same ROI
+ * - 2: crops of MAIN POST0 and POST1 have independent ROIs
+ *
+ * @post_enable_flag: flag to enable corresponding main path
+ * @post_crop_x: left of crop rect for a POST
+ * @post_crop_y: top of crop rect for a POST
+ * @post_crop_w: width of crop rect for a POST
+ * @post_crop_h: height of crop rect for a POST
+ */
+struct viif_l2_roi_path_info {
+	u32 roi_num;
+	bool post_enable_flag[VIIF_MAX_POST_NUM];
+	u32 post_crop_x[VIIF_MAX_POST_NUM];
+	u32 post_crop_y[VIIF_MAX_POST_NUM];
+	u32 post_crop_w[VIIF_MAX_POST_NUM];
+	u32 post_crop_h[VIIF_MAX_POST_NUM];
+};
+
+/**
+ * struct viif_img_clk - relation between realtime duration and number of lines
+ * @pixel_clock: picture transfer clock frequency
+ * @htotal_size: width of picture including blanking period
+ *
+ * These values are used to convert realtime duration (such as HW specific setup time)
+ * into number of lines in a picture.
+ * See sysclk_to_numlines() called at the reconfiguration of L1ISP HDRC feature.
+ */
+struct viif_img_clk {
+	unsigned int pixel_clock;
+	unsigned int htotal_size;
+};
+
+/**
+ * struct viif_device - driver information of Visconti VIIF
+ * @dev: device
+ * @v4l2_dev: v4l2 device
+ * @media_dev: media device
+ * @pipe: media pipeline
+ * @masked_gamma_path: flag to ignore L2_GAMMA error just after capture error
+ * @subdevs: sensor subdevice specified in device tree
+ * @asds: async subdevices for subdevs
+ * @notifier: async subdev notification helper
+ * @sd: points current image sensor subdevice
+ * @cap_dev0: capture device for MAIN PATH 0
+ * @cap_dev1: capture device for MAIN PATH 1
+ * @cap_dev2: capture device for MAIN PATH 2
+ * @isp_subdev: ISP subdevice
+ * @csi2rx_subdev: CSI2RX subdevice
+ * @sensor_sd: currently active sensor subdevice
+ * @sensor_num_lane: number of lanes for currently active sensor
+ * @stream_lock: serialize stream ON/OFF sequence
+ * @regbuf_lock: Serialize VIIF Register Buffer Access
+ * @l2_roi_path_info: crop information of main paths
+ * @img_clk: relation between realtime duration and number of lines
+ * @run_flag_main: flag to check if the stream is ON
+ * @capture_reg: HW capture registers
+ * @csi2host_reg: HW CSI2RX registers
+ * @hwaif_reg: HW bus interface registers
+ * @mpu_reg: HW memory protection unit registers
+ * @irq: IRQ number
+ * @tables: table for ISP features (virtual address)
+ * @tables_dma: table for ISP features (IOVA)
+ * @rawpack_mode: rawpack mode
+ * @wq: workqueue queue
+ * @work: workqueue task to update V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS
+ * @status_err: error of Main path in a frame
+ * @reported_err_main: accumerated error flags for MAIN path
+ * @reported_err_sub: accumerated error flags for SUB path
+ * @reported_err_csi2rx: accumerated error flags for CSI2RX
+ */
+struct viif_device {
+	struct device *dev;
+	struct v4l2_device v4l2_dev;
+	struct media_device media_dev;
+	struct media_pipeline pipe;
+	u32 masked_gamma_path;
+
+	struct v4l2_async_notifier notifier;
+
+	struct cap_dev cap_dev0;
+	struct cap_dev cap_dev1;
+	struct cap_dev cap_dev2;
+	struct isp_subdev isp_subdev;
+	struct csi2rx_subdev csi2rx_subdev;
+	struct v4l2_subdev *sensor_sd;
+	unsigned int sensor_num_lane;
+
+	/* stream_lock - Serialize stream ON/OFF sequence */
+	struct mutex stream_lock;
+
+	/* regbuf_lock - Serialize VIIF Register Buffer Access */
+	spinlock_t regbuf_lock;
+
+	struct viif_l2_roi_path_info l2_roi_path_info;
+	struct viif_img_clk img_clk;
+	bool run_flag_main;
+
+	void __iomem *capture_reg;
+	void __iomem *csi2host_reg;
+	void __iomem *hwaif_reg;
+	void __iomem *mpu_reg;
+	unsigned int irq[VIIF_HW_AVAILABLE_IRQS];
+
+	/* Un-cache table area */
+	struct viif_table_area *tables;
+	struct viif_table_area *tables_dma;
+
+	/* Rawpack mode */
+	u32 rawpack_mode;
+
+	/* work queue to save L1 status of the latest frame */
+	struct workqueue_struct *wq;
+	struct work_struct work;
+
+	/* Error flag checked at delayed vsync handler  */
+	u32 status_err;
+
+	/* Error flag checked at compound control GET_REPORTED_ERRORS  */
+	u32 reported_err_main;
+	u32 reported_err_sub;
+	u32 reported_err_csi2rx;
+};
+
+static inline void viif_capture_write(struct viif_device *viif_dev, unsigned int regid, u32 val)
+{
+	writel(val, viif_dev->capture_reg + regid);
+}
+
+static inline u32 viif_capture_read(struct viif_device *viif_dev, unsigned int regid)
+{
+	return readl(viif_dev->capture_reg + regid);
+}
+
+#endif /* VIIF_H */
diff --git a/drivers/media/platform/toshiba/visconti/viif_capture.c b/drivers/media/platform/toshiba/visconti/viif_capture.c
new file mode 100644
index 000000000000..eeb9fdcdd0ef
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif_capture.c
@@ -0,0 +1,1489 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-subdev.h>
+
+#include "viif.h"
+#include "viif_capture.h"
+#include "viif_common.h"
+#include "viif_isp.h"
+#include "viif_regs.h"
+
+/* single plane for RGB/Grayscale types, 3 planes for YUV types */
+#define VIIF_MAX_PLANE_NUM 3
+
+/* maximum horizontal/vertical position/dimension of CROP with ISP */
+#define VIIF_CROP_MAX_X_ISP 8062U
+#define VIIF_CROP_MAX_Y_ISP 3966U
+#define VIIF_CROP_MAX_W_ISP 8190U
+#define VIIF_CROP_MAX_H_ISP 4094U
+
+/* minimum horizontal/vertical dimension of CROP */
+#define VIIF_CROP_MIN_W 128U
+#define VIIF_CROP_MIN_H 128U
+
+/* maximum output size with ISP */
+#define VIIF_MAX_OUTPUT_IMG_WIDTH_ISP  5760U
+#define VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP 3240U
+#define VIIF_MAX_PITCH_ISP	       32704U
+
+/* maximum output size for SUB path */
+#define VIIF_MAX_OUTPUT_IMG_WIDTH_SUB  4096U
+#define VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB 2160U
+#define VIIF_MAX_PITCH		       65536U
+
+/* minimum output size */
+#define VIIF_MIN_OUTPUT_IMG_WIDTH  128U
+#define VIIF_MIN_OUTPUT_IMG_HEIGHT 128U
+
+/* DMA settings for SUB path */
+#define VDMAC_SRAM_BASE_ADDR_W03 0x440U
+#define SRAM_SIZE_W_PORT	 0x200
+
+enum viif_color_format {
+	VIIF_YCBCR422_8_PACKED = 0,
+	VIIF_RGB888_PACKED = 1U,
+	VIIF_ARGB8888_PACKED = 3U,
+	VIIF_YCBCR422_8_PLANAR = 8U,
+	VIIF_RGB888_YCBCR444_8_PLANAR = 9U,
+	VIIF_ONE_COLOR_8 = 11U,
+	VIIF_YCBCR422_16_PLANAR = 12U,
+	VIIF_RGB161616_YCBCR444_16_PLANAR = 13U,
+	VIIF_ONE_COLOR_16 = 15U
+};
+
+/**
+ * struct viif_csc_param - color conversion information
+ * @r_cr_in_offset: input offset of R/Cr
+ * @g_y_in_offset: input offset of G/Y
+ * @b_cb_in_offset: input offset of B/Cb
+ * @coef: coefficient of matrix.
+ * @r_cr_out_offset: output offset of R/Cr
+ * @g_y_out_offset: output offset of G/Y
+ * @b_cb_out_offset: output offset of B/Cb
+ *
+ * Range of parameters is:
+ *
+ * - {r_cr,g_y,b_cb}_{in,out}_offset
+ *
+ *   - Range: [0x0..0x1FFFF]
+ *
+ * - coef
+ *
+ *   - Range: [0x0..0xFFFF]
+ *   - [0] : c00(YG_YG), [1] : c01(UB_YG), [2] : c02(VR_YG),
+ *   - [3] : c10(YG_UB), [4] : c11(UB_UB), [5] : c12(VR_UB),
+ *   - [6] : c20(YG_VR), [7] : c21(UB_VR), [8] : c22(VR_VR)
+ */
+struct viif_csc_param {
+	u32 r_cr_in_offset;
+	u32 g_y_in_offset;
+	u32 b_cb_in_offset;
+	u32 coef[9];
+	u32 r_cr_out_offset;
+	u32 g_y_out_offset;
+	u32 b_cb_out_offset;
+};
+
+/**
+ * struct viif_pixelmap - pixelmap information
+ * @pmap_dma: start address of pixel data(DMA address). 4byte alignment.
+ * @pitch: pitch size of pixel map [unit: byte]
+ *
+ * Condition of pitch in case of L2ISP output is as below.
+ *
+ * * max: 32704
+ * * min: max (active width of image * k / r, 128)
+ * * alignment: 64
+ *
+ * Condition of pitch in the other cases is as below.
+ *
+ * * max: 65536
+ * * min: active width of image * k / r
+ * * alignment: 4
+ *
+ * k is the size of 1 pixel and the value is as below.
+ *
+ * * VIIF_YCBCR422_8_PACKED: 2
+ * * VIIF_RGB888_PACKED: 3
+ * * VIIF_ARGB8888_PACKED: 4
+ * * VIIF_YCBCR422_8_PLANAR: 1
+ * * VIIF_RGB888_YCBCR444_8_PLANAR: 1
+ * * VIIF_ONE_COLOR_8: 1
+ * * VIIF_YCBCR422_16_PLANAR: 2
+ * * VIIF_RGB161616_YCBCR444_16_PLANAR: 2
+ * * VIIF_ONE_COLOR_16: 2
+ *
+ * r is the correction factor for Cb or Cr of YCbCr422 planar and the value is as below.
+ *
+ * * YCbCr422 Cb-planar: 2
+ * * YCbCr422 Cr-planar: 2
+ * * others: 1
+ */
+struct viif_pixelmap {
+	dma_addr_t pmap_dma;
+	u32 pitch;
+};
+
+/**
+ * struct viif_img - image information
+ * @width: active width of image [unit: pixel]
+ * * Range: [128..5760](output from L2ISP)
+ * * Range: [128..4096](output from SUB unit)
+ * * The value should be even.
+ *
+ * @height: active height of image[line]
+ * * Range: [128..3240](output from L2ISP)
+ * * Range: [128..2160](output from SUB unit)
+ * * The value should be even.
+ *
+ * @format: viif_color_format "color format"
+ * * Below color formats are supported for input and output of MAIN unit
+ * * VIIF_YCBCR422_8_PACKED
+ * * VIIF_RGB888_PACKED
+ * * VIIF_ARGB8888_PACKED
+ * * VIIF_YCBCR422_8_PLANAR
+ * * VIIF_RGB888_YCBCR444_8_PLANAR
+ * * VIIF_ONE_COLOR_8
+ * * VIIF_YCBCR422_16_PLANAR
+ * * VIIF_RGB161616_YCBCR444_16_PLANAR
+ * * VIIF_ONE_COLOR_16
+ * * Below color formats are supported for output of SUB unit
+ * * VIIF_ONE_COLOR_8
+ * * VIIF_ONE_COLOR_16
+ *
+ * @pixelmap: pixelmap information
+ * * [0]: Y/G-planar, packed/Y/RAW
+ * * [1]: Cb/B-planar
+ * * [2]: Cr/R-planar
+ */
+struct viif_img {
+	u32 width;
+	u32 height;
+	enum viif_color_format format;
+	struct viif_pixelmap pixelmap[VIIF_MAX_PLANE_NUM];
+};
+
+/*=============================================*/
+/* Low Layer Implementation */
+/*=============================================*/
+/**
+ * viif_l2_set_output_csc() - Set output CSC parameters of L2ISP
+ *
+ * @viif_dev: the VIIF device
+ * @post_id: POST ID. Range: [0..1]
+ * @param: Pointer to output csc parameters of L2ISP
+ */
+static int viif_l2_set_output_csc(struct viif_device *viif_dev, u32 post_id,
+				  const struct viif_csc_param *param)
+{
+	/* disable csc matrix when param is NULL */
+	if (!param) {
+		viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB(post_id), 0);
+		return 0;
+	}
+
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_YG_OFFSETI(post_id),
+			   param->g_y_in_offset);
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_YG1(post_id),
+			   FIELD_CSC_MTB_LOWER(param->coef[0]));
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_YG2(post_id),
+			   FIELD_CSC_MTB_UPPER(param->coef[1]) |
+				   FIELD_CSC_MTB_LOWER(param->coef[2]));
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_YG_OFFSETO(post_id),
+			   param->g_y_out_offset);
+
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_CB_OFFSETI(post_id),
+			   param->b_cb_in_offset);
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_CB1(post_id),
+			   FIELD_CSC_MTB_LOWER(param->coef[3]));
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_CB2(post_id),
+			   FIELD_CSC_MTB_UPPER(param->coef[4]) |
+				   FIELD_CSC_MTB_LOWER(param->coef[5]));
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_CB_OFFSETO(post_id),
+			   param->b_cb_out_offset);
+
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_CR_OFFSETI(post_id),
+			   param->r_cr_in_offset);
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_CR1(post_id),
+			   FIELD_CSC_MTB_LOWER(param->coef[6]));
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_CR2(post_id),
+			   FIELD_CSC_MTB_UPPER(param->coef[7]) |
+				   FIELD_CSC_MTB_LOWER(param->coef[8]));
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB_CR_OFFSETO(post_id),
+			   param->r_cr_out_offset);
+
+	viif_capture_write(viif_dev, REG_L2_POST_X_CSC_MTB(post_id), 1);
+
+	return 0;
+}
+
+struct viif_out_format_spec {
+	int num_planes;
+	int bytes_per_px;
+	int pitch_align;
+	int skips_px[3];
+};
+
+struct viif_out_format_spec out_format_spec[] = {
+	[VIIF_YCBCR422_8_PACKED] = {
+		.num_planes = 1,
+		.bytes_per_px = 2,
+		.pitch_align = 256,
+		.skips_px = {1},
+	},
+	[VIIF_RGB888_PACKED] = {
+		.num_planes = 1,
+		.bytes_per_px = 3,
+		.pitch_align = 384,
+		.skips_px = {1},
+	},
+	[VIIF_ARGB8888_PACKED] = {
+		.num_planes = 1,
+		.bytes_per_px = 4,
+		.pitch_align = 512,
+		.skips_px = {1},
+	},
+	[VIIF_ONE_COLOR_8] = {
+		.num_planes = 1,
+		.bytes_per_px = 1,
+		.pitch_align = 128,
+		.skips_px = {1},
+	},
+	[VIIF_ONE_COLOR_16] = {
+		.num_planes = 1,
+		.bytes_per_px = 2,
+		.pitch_align = 128,
+		.skips_px = {1},
+	},
+	[VIIF_YCBCR422_8_PLANAR] = {
+		.num_planes = 3,
+		.bytes_per_px = 1,
+		.pitch_align = 128,
+		.skips_px = {1, 2, 2},
+	},
+	[VIIF_RGB888_YCBCR444_8_PLANAR] = {
+		.num_planes = 3,
+		.bytes_per_px = 1,
+		.pitch_align = 128,
+		.skips_px = {1, 1, 1},
+	},
+	[VIIF_YCBCR422_16_PLANAR] = {
+		.num_planes = 3,
+		.bytes_per_px = 2,
+		.pitch_align = 128,
+		.skips_px = {1, 2, 2},
+	},
+	[VIIF_RGB161616_YCBCR444_16_PLANAR] = {
+		.num_planes = 3,
+		.bytes_per_px = 2,
+		.pitch_align = 128,
+		.skips_px = {1, 1, 1}
+	}
+};
+
+/**
+ * viif_l2_set_img_transmission() - Set image transfer condition of L2ISP
+ *
+ * @viif_dev: the VIIF device
+ * @post_id: POST ID. Range: [0..1]
+ * @enable: set True to enable image transfer of MAIN unit.
+ * @src: Pointer to crop area information
+ * @out_process: Pointer to output process information
+ * @img: Pointer to output image information
+ *
+ * see also: #viif_l2_set_roi_path
+ */
+static int viif_l2_set_img_transmission(struct viif_device *viif_dev, u32 post_id, bool enable,
+					const struct viif_img_area *src,
+					const struct viif_out_process *out_process,
+					const struct viif_img *img)
+{
+	dma_addr_t img_start_addr[VIIF_MAX_PLANE_NUM];
+	u32 pitch[VIIF_MAX_PLANE_NUM];
+	struct viif_out_format_spec *spec;
+	unsigned int i;
+
+	/* pitch alignment for planar or one color format */
+	if (post_id >= VIIF_MAX_POST_NUM || (enable && (!src || !out_process)) ||
+	    (!enable && (src || out_process))) {
+		return -EINVAL;
+	}
+
+	/* DISABLE: no DMA transmission setup, set minimum crop rectangle */
+	if (!enable) {
+		viif_dev->l2_roi_path_info.post_enable_flag[post_id] = false;
+		viif_dev->l2_roi_path_info.post_crop_x[post_id] = 0U;
+		viif_dev->l2_roi_path_info.post_crop_y[post_id] = 0U;
+		viif_dev->l2_roi_path_info.post_crop_w[post_id] = VIIF_CROP_MIN_W;
+		viif_dev->l2_roi_path_info.post_crop_h[post_id] = VIIF_CROP_MIN_H;
+		visconti_viif_l2_set_roi_path(viif_dev);
+
+		return 0;
+	}
+
+	if (out_process->select_color != VIIF_COLOR_Y_G &&
+	    out_process->select_color != VIIF_COLOR_U_B &&
+	    out_process->select_color != VIIF_COLOR_V_R &&
+	    out_process->select_color != VIIF_COLOR_YUV_RGB) {
+		return -EINVAL;
+	}
+
+	if (img->format != VIIF_ARGB8888_PACKED && out_process->alpha)
+		return -EINVAL;
+
+	if ((img->width % 2U) || (img->height % 2U) || img->width < VIIF_MIN_OUTPUT_IMG_WIDTH ||
+	    img->height < VIIF_MIN_OUTPUT_IMG_HEIGHT ||
+	    img->width > VIIF_MAX_OUTPUT_IMG_WIDTH_ISP ||
+	    img->height > VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP) {
+		return -EINVAL;
+	}
+
+	if (src->x > VIIF_CROP_MAX_X_ISP || src->y > VIIF_CROP_MAX_Y_ISP ||
+	    src->w < VIIF_CROP_MIN_W || src->w > VIIF_CROP_MAX_W_ISP || src->h < VIIF_CROP_MIN_H ||
+	    src->h > VIIF_CROP_MAX_H_ISP) {
+		return -EINVAL;
+	}
+
+	if (out_process->half_scale) {
+		if ((src->w != (img->width * 2U)) || (src->h != (img->height * 2U)))
+			return -EINVAL;
+	} else {
+		if (src->w != img->width || src->h != img->height)
+			return -EINVAL;
+	}
+
+	if (out_process->select_color == VIIF_COLOR_Y_G ||
+	    out_process->select_color == VIIF_COLOR_U_B ||
+	    out_process->select_color == VIIF_COLOR_V_R) {
+		if (img->format != VIIF_ONE_COLOR_8 && img->format != VIIF_ONE_COLOR_16)
+			return -EINVAL;
+	}
+
+	spec = &out_format_spec[img->format];
+	if (!spec->num_planes)
+		return -EINVAL;
+
+	for (i = 0; i < spec->num_planes; i++) {
+		img_start_addr[i] = (u32)img->pixelmap[i].pmap_dma;
+		pitch[i] = img->pixelmap[i].pitch;
+	}
+
+	for (i = 0; i < spec->num_planes; i++) {
+		u32 pitch_req = max(((img->width * spec->bytes_per_px) / spec->skips_px[i]), 128U);
+
+		if (pitch[i] < pitch_req || pitch[i] > VIIF_MAX_PITCH_ISP ||
+		    (pitch[i] % spec->pitch_align) || (img_start_addr[i] % 4U)) {
+			return -EINVAL;
+		}
+	}
+
+	viif_capture_write(viif_dev, REG_L2_POST_X_OUT_STADR_G(post_id), (u32)img_start_addr[0]);
+	viif_capture_write(viif_dev, REG_L2_POST_X_OUT_PITCH_G(post_id), pitch[0]);
+	if (spec->num_planes == 3) {
+		viif_capture_write(viif_dev, REG_L2_POST_X_OUT_STADR_B(post_id),
+				   (u32)img_start_addr[1]);
+		viif_capture_write(viif_dev, REG_L2_POST_X_OUT_STADR_R(post_id),
+				   (u32)img_start_addr[2]);
+		viif_capture_write(viif_dev, REG_L2_POST_X_OUT_PITCH_B(post_id), pitch[1]);
+		viif_capture_write(viif_dev, REG_L2_POST_X_OUT_PITCH_R(post_id), pitch[2]);
+	}
+
+	/* Set CROP */
+	viif_capture_write(viif_dev, REG_L2_POST_X_CAP_OFFSET(post_id), (src->y << 16U) | src->x);
+	viif_capture_write(viif_dev, REG_L2_POST_X_CAP_SIZE(post_id), (src->h << 16U) | src->w);
+
+	/* Set output process */
+	viif_capture_write(viif_dev, REG_L2_POST_X_HALF_SCALE_EN(post_id),
+			   out_process->half_scale ? 1 : 0);
+	viif_capture_write(viif_dev, REG_L2_POST_X_C_SELECT(post_id), out_process->select_color);
+	viif_capture_write(viif_dev, REG_L2_POST_X_OPORTALP(post_id), (u32)out_process->alpha);
+	viif_capture_write(viif_dev, REG_L2_POST_X_OPORTFMT(post_id), img->format);
+
+	/* Update ROI area and input to each POST */
+	viif_dev->l2_roi_path_info.post_enable_flag[post_id] = true;
+	viif_dev->l2_roi_path_info.post_crop_x[post_id] = src->x;
+	viif_dev->l2_roi_path_info.post_crop_y[post_id] = src->y;
+	viif_dev->l2_roi_path_info.post_crop_w[post_id] = src->w;
+	viif_dev->l2_roi_path_info.post_crop_h[post_id] = src->h;
+	visconti_viif_l2_set_roi_path(viif_dev);
+
+	return 0;
+}
+
+/**
+ * viif_sub_set_img_transmission() - Set image transfer condition of SUB unit
+ *
+ * @viif_dev: the VIIF device
+ * @img: Pointer to output image information
+ */
+static int viif_sub_set_img_transmission(struct viif_device *viif_dev, const struct viif_img *img)
+{
+	dma_addr_t img_start_addr, img_end_addr;
+	u32 data_width, pitch, height;
+	u32 bytes_px, port_control;
+
+	/* disable VDMAC when img is NULL */
+	if (!img) {
+		viif_capture_write(viif_dev, REG_IPORTS_IMGEN, 0);
+		port_control = ~((u32)1U << 3U) & viif_capture_read(viif_dev, REG_VDM_W_ENABLE);
+		viif_capture_write(viif_dev, REG_VDM_W_ENABLE, port_control);
+		return 0;
+	}
+
+	if ((img->width % 2U) || (img->height % 2U))
+		return -EINVAL;
+
+	if (img->width < VIIF_MIN_OUTPUT_IMG_WIDTH || img->height < VIIF_MIN_OUTPUT_IMG_HEIGHT ||
+	    img->width > VIIF_MAX_OUTPUT_IMG_WIDTH_SUB ||
+	    img->height > VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB) {
+		return -EINVAL;
+	}
+
+	img_start_addr = (u32)img->pixelmap[0].pmap_dma;
+	pitch = img->pixelmap[0].pitch;
+	height = img->height;
+
+	switch (img->format) {
+	case VIIF_ONE_COLOR_8:
+		data_width = 0U;
+		img_end_addr = img_start_addr + img->width - 1U;
+		bytes_px = 1;
+		break;
+	case VIIF_ONE_COLOR_16:
+		data_width = 1U;
+		img_end_addr = img_start_addr + (img->width * 2U) - 1U;
+		bytes_px = 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (img_start_addr % 4U)
+		return -EINVAL;
+
+	if ((pitch < (img->width * bytes_px)) || pitch > VIIF_MAX_PITCH || (pitch % 4U))
+		return -EINVAL;
+
+	viif_capture_write(viif_dev, REG_VDM_WPORT_X_W_SRAM_BASE(IDX_WPORT_SUB_IMG),
+			   VDMAC_SRAM_BASE_ADDR_W03);
+	viif_capture_write(viif_dev, REG_VDM_WPORT_X_W_SRAM_SIZE(IDX_WPORT_SUB_IMG),
+			   SRAM_SIZE_W_PORT);
+	viif_capture_write(viif_dev, REG_VDM_WPORT_X_W_STADR(IDX_WPORT_SUB_IMG),
+			   (u32)img_start_addr);
+	viif_capture_write(viif_dev, REG_VDM_WPORT_X_W_ENDADR(IDX_WPORT_SUB_IMG),
+			   (u32)img_end_addr);
+	viif_capture_write(viif_dev, REG_VDM_WPORT_X_W_HEIGHT(IDX_WPORT_SUB_IMG), height);
+	viif_capture_write(viif_dev, REG_VDM_WPORT_X_W_PITCH(IDX_WPORT_SUB_IMG), pitch);
+	viif_capture_write(viif_dev, REG_VDM_WPORT_X_W_CFG0(IDX_WPORT_SUB_IMG), data_width << 8U);
+	port_control = BIT(3) | viif_capture_read(viif_dev, REG_VDM_W_ENABLE);
+	viif_capture_write(viif_dev, REG_VDM_W_ENABLE, port_control);
+	viif_capture_write(viif_dev, REG_IPORTS_IMGEN, 1);
+
+	return 0;
+}
+
+/*=============================================*/
+/* handling V4L2 framework */
+/*=============================================*/
+struct viif_buffer {
+	struct vb2_v4l2_buffer vb;
+	struct list_head queue;
+};
+
+static inline struct viif_buffer *vb2_to_viif(struct vb2_v4l2_buffer *vbuf)
+{
+	return container_of(vbuf, struct viif_buffer, vb);
+}
+
+static inline struct cap_dev *video_drvdata_to_capdev(struct file *file)
+{
+	return (struct cap_dev *)video_drvdata(file);
+}
+
+static inline struct cap_dev *vb2queue_to_capdev(struct vb2_queue *vq)
+{
+	return (struct cap_dev *)vb2_get_drv_priv(vq);
+}
+
+/* ----- ISRs and VB2 Operations ----- */
+static void viif_regbuf_access_start(struct viif_device *viif_dev)
+{
+	spin_lock(&viif_dev->regbuf_lock);
+	hwd_viif_isp_guard_start(viif_dev);
+}
+
+static void viif_regbuf_access_end(struct viif_device *viif_dev)
+{
+	hwd_viif_isp_guard_end(viif_dev);
+	spin_unlock(&viif_dev->regbuf_lock);
+}
+
+static int viif_set_img(struct cap_dev *cap_dev, struct vb2_buffer *vb)
+{
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct viif_img next_out_img;
+	int i, ret = 0;
+
+	next_out_img.width = pix->width;
+	next_out_img.height = pix->height;
+	next_out_img.format = cap_dev->out_format;
+
+	for (i = 0; i < pix->num_planes; i++) {
+		next_out_img.pixelmap[i].pitch = pix->plane_fmt[i].bytesperline;
+		next_out_img.pixelmap[i].pmap_dma = vb2_dma_contig_plane_dma_addr(vb, i);
+	}
+
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		viif_regbuf_access_start(viif_dev);
+		ret = viif_l2_set_img_transmission(viif_dev, VIIF_L2ISP_POST_0, true,
+						   &cap_dev->img_area, &cap_dev->out_process,
+						   &next_out_img);
+		viif_regbuf_access_end(viif_dev);
+		if (ret)
+			dev_err(viif_dev->dev, "set img error. %d\n", ret);
+	} else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1) {
+		viif_regbuf_access_start(viif_dev);
+		ret = viif_l2_set_img_transmission(viif_dev, VIIF_L2ISP_POST_1, true,
+						   &cap_dev->img_area, &cap_dev->out_process,
+						   &next_out_img);
+		viif_regbuf_access_end(viif_dev);
+		if (ret)
+			dev_err(viif_dev->dev, "set img error. %d\n", ret);
+	} else if (cap_dev->pathid == CAPTURE_PATH_SUB) {
+		viif_regbuf_access_start(viif_dev);
+		ret = viif_sub_set_img_transmission(viif_dev, &next_out_img);
+		viif_regbuf_access_end(viif_dev);
+		if (ret)
+			dev_err(viif_dev->dev, "set img error. %d\n", ret);
+	}
+
+	return ret;
+}
+
+/*
+ * viif_capture_switch_buffer() is called from interrupt service routine
+ * triggered by VSync with some fixed delay.
+ * The function may switch DMA target buffer by calling viif_set_img().
+ * The VIIF DMA HW captures the destination address at next VSync
+ * and completes transfer at one more after.
+ * Therefore, filled buffer is available at the one after next ISR.
+ *
+ * To avoid DMA HW getting stucked, we always need to set valid destination address.
+ * If a prepared buffer is not available, we reuse the buffer currently being transferred to.
+ *
+ * The cap_dev structure has two pointers and a queue to handle video buffers;
+ + Description of each item at the entry of this function:
+ * * buf_queue:  holds prepared buffers, set by vb2_queue()
+ * * active:     pointing at address captured (and to be filled) by DMA HW
+ * * dma_active: pointing at buffer filled by DMA HW
+ *
+ * Rules to update items:
+ * * when buf_queue is not empty, "active" buffer goes "dma_active"
+ * * when buf_queue is empty:
+ *   * "active" buffer stays the same (DMA HW fills the same buffer for coming two frames)
+ *   * "dma_active" gets NULL (filled buffer will be reused; should not go "DONE" at next ISR)
+ *
+ * Simulation:
+ * | buf_queue   | active  | dma_active | note |
+ * | X           | NULL    | NULL       |      |
+ * <QBUF BUF0>
+ * | X           | BUF0    | NULL       | BUF0 stays |
+ * | X           | BUF0    | NULL       | BUF0 stays |
+ * <QBUF BUF1>
+ * <QBUF BUF2>
+ * | BUF2 BUF1   | BUF0    | NULL       |      |
+ * | BUF2        | BUF1    | BUF0       | BUF0 goes DONE |
+ * | X           | BUF2    | BUF1       | BUF1 goes DONE, BUF2 stays |
+ * | X           | BUF2    | NULL       | BUF2 stays |
+ */
+void visconti_viif_capture_switch_buffer(struct cap_dev *cap_dev, u32 status_err,
+					 u32 l2_transfer_status, u64 timestamp)
+{
+	spin_lock(&cap_dev->buf_lock);
+
+	if (cap_dev->dma_active) {
+		/* DMA has completed and another framebuffer instance is set */
+		struct vb2_v4l2_buffer *vbuf = cap_dev->dma_active;
+		enum vb2_buffer_state state;
+
+		cap_dev->buf_cnt--;
+		vbuf->vb2_buf.timestamp = timestamp;
+		vbuf->sequence = cap_dev->sequence++;
+		vbuf->field = V4L2_FIELD_NONE;
+		if (status_err || l2_transfer_status)
+			state = VB2_BUF_STATE_ERROR;
+		else
+			state = VB2_BUF_STATE_DONE;
+
+		vb2_buffer_done(&vbuf->vb2_buf, state);
+	}
+
+	/* QUEUE pop to register an instance as next DMA target; if empty, reuse current instance */
+	if (!list_empty(&cap_dev->buf_queue)) {
+		struct viif_buffer *buf =
+			list_entry(cap_dev->buf_queue.next, struct viif_buffer, queue);
+		list_del_init(&buf->queue);
+		viif_set_img(cap_dev, &buf->vb.vb2_buf);
+		cap_dev->dma_active = cap_dev->active;
+		cap_dev->active = &buf->vb;
+	} else {
+		cap_dev->dma_active = NULL;
+	}
+
+	spin_unlock(&cap_dev->buf_lock);
+}
+
+/* --- Capture buffer control --- */
+static int viif_vb2_setup(struct vb2_queue *vq, unsigned int *count, unsigned int *num_planes,
+			  unsigned int sizes[], struct device *alloc_devs[])
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vq);
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	unsigned int i;
+
+	/* num_planes is set: just check plane sizes. */
+	if (*num_planes) {
+		for (i = 0; i < pix->num_planes; i++)
+			if (sizes[i] < pix->plane_fmt[i].sizeimage)
+				return -EINVAL;
+
+		return 0;
+	}
+
+	/* num_planes not set: called from REQBUFS, just set plane sizes. */
+	*num_planes = pix->num_planes;
+	for (i = 0; i < pix->num_planes; i++)
+		sizes[i] = pix->plane_fmt[i].sizeimage;
+
+	cap_dev->buf_cnt = 0;
+
+	return 0;
+}
+
+static void viif_vb2_queue(struct vb2_buffer *vb)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct viif_buffer *buf = vb2_to_viif(vbuf);
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&cap_dev->buf_lock, irqflags);
+
+	if (!cap_dev->active) {
+		cap_dev->active = vbuf;
+		viif_set_img(cap_dev, vb);
+	} else {
+		list_add_tail(&buf->queue, &cap_dev->buf_queue);
+	}
+	cap_dev->buf_cnt++;
+
+	spin_unlock_irqrestore(&cap_dev->buf_lock, irqflags);
+}
+
+static int viif_vb2_prepare(struct vb2_buffer *vb)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vb->vb2_queue);
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	unsigned int i;
+
+	for (i = 0; i < pix->num_planes; i++) {
+		if (vb2_plane_size(vb, i) < pix->plane_fmt[i].sizeimage) {
+			dev_err(viif_dev->dev, "Plane size too small (%lu < %u)\n",
+				vb2_plane_size(vb, i), pix->plane_fmt[i].sizeimage);
+			return -EINVAL;
+		}
+
+		vb2_set_plane_payload(vb, i, pix->plane_fmt[i].sizeimage);
+	}
+	return 0;
+}
+
+static void viif_return_all_buffers(struct cap_dev *cap_dev, enum vb2_buffer_state state)
+{
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct viif_buffer *buf;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&cap_dev->buf_lock, irqflags);
+
+	/* buffer control */
+	if (cap_dev->active) {
+		vb2_buffer_done(&cap_dev->active->vb2_buf, state);
+		cap_dev->buf_cnt--;
+		cap_dev->active = NULL;
+	}
+	if (cap_dev->dma_active) {
+		vb2_buffer_done(&cap_dev->dma_active->vb2_buf, state);
+		cap_dev->buf_cnt--;
+		cap_dev->dma_active = NULL;
+	}
+
+	/* Release all queued buffers. */
+	list_for_each_entry(buf, &cap_dev->buf_queue, queue) {
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		cap_dev->buf_cnt--;
+	}
+	INIT_LIST_HEAD(&cap_dev->buf_queue);
+	if (cap_dev->buf_cnt)
+		dev_err(viif_dev->dev, "Buffer count error %d\n", cap_dev->buf_cnt);
+
+	spin_unlock_irqrestore(&cap_dev->buf_lock, irqflags);
+}
+
+static int viif_start_streaming(struct vb2_queue *vq, unsigned int count)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vq);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	int ret = 0;
+
+	mutex_lock(&viif_dev->stream_lock);
+
+	/* note that pipe is shared among paths; see pipe.streaming_count member variable */
+	ret = video_device_pipeline_start(&cap_dev->vdev, &viif_dev->pipe);
+	if (ret) {
+		dev_err(viif_dev->dev, "start pipeline failed %d\n", ret);
+		goto release_lock;
+	}
+
+	/* buffer control */
+	cap_dev->sequence = 0;
+
+	/* Currently, only path0 (MAIN POST0) initializes ISP and Camera */
+	/* Possibly, initialization can be done when pipe.streaming_count==0 */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		/* CSI2RX start */
+		ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, video, s_stream, true);
+		if (ret) {
+			dev_err(viif_dev->dev, "Start isp subdevice stream failed. %d\n", ret);
+			viif_return_all_buffers(cap_dev, VB2_BUF_STATE_QUEUED);
+			video_device_pipeline_stop(&cap_dev->vdev);
+			goto release_lock;
+		}
+	}
+
+release_lock:
+	mutex_unlock(&viif_dev->stream_lock);
+	return ret;
+}
+
+static void viif_stop_streaming(struct vb2_queue *vq)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vq);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	int ret;
+
+	mutex_lock(&viif_dev->stream_lock);
+
+	/* Currently, only path0 (MAIN POST0) stops ISP and Camera */
+	/* Possibly, teardown can be done when pipe.streaming_count==0 */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, video, s_stream, false);
+		if (ret)
+			dev_err(viif_dev->dev, "Stop isp subdevice stream failed %d\n", ret);
+	}
+
+	viif_return_all_buffers(cap_dev, VB2_BUF_STATE_ERROR);
+	video_device_pipeline_stop(&cap_dev->vdev);
+	mutex_unlock(&viif_dev->stream_lock);
+}
+
+static const struct vb2_ops viif_vb2_ops = {
+	.queue_setup = viif_vb2_setup,
+	.buf_queue = viif_vb2_queue,
+	.buf_prepare = viif_vb2_prepare,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+	.start_streaming = viif_start_streaming,
+	.stop_streaming = viif_stop_streaming,
+};
+
+/* --- VIIF hardware settings --- */
+/* L2ISP output csc setting for YUV to RGB(ITU-R BT.709) */
+static const struct viif_csc_param viif_csc_yuv2rgb = {
+	.r_cr_in_offset = 0x18000,
+	.g_y_in_offset = 0x1f000,
+	.b_cb_in_offset = 0x18000,
+	.coef = {
+			[0] = 0x1000,
+			[1] = 0xfd12,
+			[2] = 0xf8ad,
+			[3] = 0x1000,
+			[4] = 0x1d07,
+			[5] = 0x0000,
+			[6] = 0x1000,
+			[7] = 0x0000,
+			[8] = 0x18a2,
+		},
+	.r_cr_out_offset = 0x1000,
+	.g_y_out_offset = 0x1000,
+	.b_cb_out_offset = 0x1000,
+};
+
+/* L2ISP output csc setting for RGB to YUV(ITU-R BT.709) */
+static const struct viif_csc_param viif_csc_rgb2yuv = {
+	.r_cr_in_offset = 0x1f000,
+	.g_y_in_offset = 0x1f000,
+	.b_cb_in_offset = 0x1f000,
+	.coef = {
+			[0] = 0x0b71,
+			[1] = 0x0128,
+			[2] = 0x0367,
+			[3] = 0xf9b1,
+			[4] = 0x082f,
+			[5] = 0xfe20,
+			[6] = 0xf891,
+			[7] = 0xff40,
+			[8] = 0x082f,
+		},
+	.r_cr_out_offset = 0x8000,
+	.g_y_out_offset = 0x1000,
+	.b_cb_out_offset = 0x8000,
+};
+
+static int viif_l2_set_format(struct cap_dev *cap_dev)
+{
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	const struct viif_csc_param *csc_param = NULL;
+	struct v4l2_subdev_selection sel = {
+		.target = V4L2_SEL_TGT_CROP,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct v4l2_subdev_format fmt = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	bool inp_is_rgb = false;
+	bool out_is_rgb = false;
+	u32 postid;
+	int ret;
+
+	/* check path id */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		sel.pad = VIIF_ISP_PAD_SRC_PATH0;
+		fmt.pad = VIIF_ISP_PAD_SRC_PATH0;
+		postid = VIIF_L2ISP_POST_0;
+	} else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1) {
+		sel.pad = VIIF_ISP_PAD_SRC_PATH1;
+		fmt.pad = VIIF_ISP_PAD_SRC_PATH1;
+		postid = VIIF_L2ISP_POST_1;
+	} else {
+		return -EINVAL;
+	}
+
+	cap_dev->out_process.half_scale = false;
+	cap_dev->out_process.select_color = VIIF_COLOR_YUV_RGB;
+	cap_dev->out_process.alpha = 0;
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_selection, NULL, &sel);
+	if (ret) {
+		cap_dev->img_area.x = 0;
+		cap_dev->img_area.y = 0;
+		cap_dev->img_area.w = pix->width;
+		cap_dev->img_area.h = pix->height;
+	} else {
+		cap_dev->img_area.x = sel.r.left;
+		cap_dev->img_area.y = sel.r.top;
+		cap_dev->img_area.w = sel.r.width;
+		cap_dev->img_area.h = sel.r.height;
+	}
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_fmt, NULL, &fmt);
+	if (!ret)
+		inp_is_rgb = (fmt.format.code == MEDIA_BUS_FMT_RGB888_1X24);
+
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_RGB24:
+		cap_dev->out_format = VIIF_RGB888_PACKED;
+		out_is_rgb = true;
+		break;
+	case V4L2_PIX_FMT_ABGR32:
+		cap_dev->out_format = VIIF_ARGB8888_PACKED;
+		cap_dev->out_process.alpha = 0xff;
+		out_is_rgb = true;
+		break;
+	case V4L2_PIX_FMT_YUV422M:
+		cap_dev->out_format = VIIF_YCBCR422_8_PLANAR;
+		break;
+	case V4L2_PIX_FMT_YUV444M:
+		cap_dev->out_format = VIIF_RGB888_YCBCR444_8_PLANAR;
+		break;
+	case V4L2_PIX_FMT_Y16:
+		cap_dev->out_format = VIIF_ONE_COLOR_16;
+		cap_dev->out_process.select_color = VIIF_COLOR_Y_G;
+		break;
+	}
+
+	if (!inp_is_rgb && out_is_rgb)
+		csc_param = &viif_csc_yuv2rgb; /* YUV -> RGB */
+	else if (inp_is_rgb && !out_is_rgb)
+		csc_param = &viif_csc_rgb2yuv; /* RGB -> YUV */
+
+	return viif_l2_set_output_csc(viif_dev, postid, csc_param);
+}
+
+/* --- IOCTL Operations --- */
+static const struct viif_fmt viif_capture_fmt_list_mainpath[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_RGB24,
+		.bpp = { 24, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 384,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_ABGR32,
+		.bpp = { 32, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 512,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_YUV422M,
+		.bpp = { 8, 4, 4 },
+		.num_planes = 3,
+		.colorspace = V4L2_COLORSPACE_REC709,
+		.pitch_align = 128,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_YUV444M,
+		.bpp = { 8, 8, 8 },
+		.num_planes = 3,
+		.colorspace = V4L2_COLORSPACE_REC709,
+		.pitch_align = 128,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_Y16,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_REC709,
+		.pitch_align = 128,
+	},
+};
+
+static const struct viif_fmt viif_capture_fmt_list_subpath[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_SRGGB8,
+		.bpp = { 8, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 256,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_SRGGB10,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 256,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_SRGGB12,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 256,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_SRGGB14,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 256,
+	},
+};
+
+static const struct viif_fmt *get_viif_fmt_from_fourcc(struct cap_dev *cap_dev, unsigned int fourcc)
+{
+	unsigned int i;
+
+	for (i = 0; i < cap_dev->fmt_size; i++) {
+		const struct viif_fmt *fmt = &cap_dev->fmts[i];
+
+		if (fmt->fourcc == fourcc)
+			return fmt;
+	}
+	return NULL;
+}
+
+static u32 get_pixelformat_from_fourcc(struct cap_dev *cap_dev, unsigned int fourcc)
+{
+	const struct viif_fmt *fmt = get_viif_fmt_from_fourcc(cap_dev, fourcc);
+
+	return fmt ? fmt->fourcc : cap_dev->fmts[0].fourcc;
+}
+
+static u32 get_pixelformat_from_mbus_code(struct cap_dev *cap_dev, unsigned int mbus_code)
+{
+	const struct viif_fmt *fmt;
+	unsigned int fourcc;
+
+	switch (mbus_code) {
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+		fourcc = V4L2_PIX_FMT_SRGGB8;
+		break;
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+		fourcc = V4L2_PIX_FMT_SRGGB10;
+		break;
+	case MEDIA_BUS_FMT_SRGGB12_1X12:
+	case MEDIA_BUS_FMT_SGRBG12_1X12:
+	case MEDIA_BUS_FMT_SGBRG12_1X12:
+	case MEDIA_BUS_FMT_SBGGR12_1X12:
+		fourcc = V4L2_PIX_FMT_SRGGB12;
+		break;
+	case MEDIA_BUS_FMT_SRGGB14_1X14:
+	case MEDIA_BUS_FMT_SGRBG14_1X14:
+	case MEDIA_BUS_FMT_SGBRG14_1X14:
+	case MEDIA_BUS_FMT_SBGGR14_1X14:
+		fourcc = V4L2_PIX_FMT_SRGGB14;
+		break;
+	default:
+		return cap_dev->fmts[0].fourcc;
+	}
+
+	fmt = get_viif_fmt_from_fourcc(cap_dev, fourcc);
+	return fmt ? fmt->fourcc : cap_dev->fmts[0].fourcc;
+}
+
+static void viif_calc_plane_sizes(struct cap_dev *cap_dev, struct v4l2_pix_format_mplane *pix)
+{
+	const struct viif_fmt *viif_fmt = get_viif_fmt_from_fourcc(cap_dev, pix->pixelformat);
+	unsigned int i;
+
+	for (i = 0; i < viif_fmt->num_planes; i++) {
+		struct v4l2_plane_pix_format *plane_i = &pix->plane_fmt[i];
+		unsigned int bpl;
+
+		memset(plane_i, 0, sizeof(*plane_i));
+		bpl = roundup(pix->width * viif_fmt->bpp[i] / 8, viif_fmt->pitch_align);
+
+		plane_i->bytesperline = bpl;
+		plane_i->sizeimage = pix->height * bpl;
+	}
+	pix->num_planes = viif_fmt->num_planes;
+}
+
+static int viif_querycap(struct file *file, void *priv, struct v4l2_capability *cap)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+
+	strscpy(cap->driver, VIIF_DRIVER_NAME, sizeof(cap->driver));
+	snprintf(cap->card, sizeof(cap->card), "%s-%s", VIIF_DRIVER_NAME, dev_name(viif_dev->dev));
+	/* TODO: platform:visconti-viif-0,1,2,3 for each VIIF driver instance */
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "%s-0", VIIF_BUS_INFO_BASE);
+
+	return 0;
+}
+
+static int viif_enum_fmt_vid_cap(struct file *file, void *priv, struct v4l2_fmtdesc *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+
+	if (f->index >= cap_dev->fmt_size)
+		return -EINVAL;
+
+	f->pixelformat = cap_dev->fmts[f->index].fourcc;
+	return 0;
+}
+
+static void viif_try_fmt(struct cap_dev *cap_dev, struct v4l2_pix_format_mplane *pix)
+{
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int ret;
+
+	/* check path id */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0)
+		format.pad = VIIF_ISP_PAD_SRC_PATH0;
+	else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1)
+		format.pad = VIIF_ISP_PAD_SRC_PATH1;
+	else
+		format.pad = VIIF_ISP_PAD_SRC_PATH2;
+
+	pix->field = V4L2_FIELD_NONE;
+	pix->colorspace = V4L2_COLORSPACE_DEFAULT;
+	pix->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	pix->quantization = V4L2_QUANTIZATION_DEFAULT;
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_fmt, NULL, &format);
+	if (ret) {
+		/* minimal default format */
+		pix->width = VIIF_MIN_OUTPUT_IMG_WIDTH;
+		pix->height = VIIF_MIN_OUTPUT_IMG_HEIGHT;
+		pix->pixelformat = (cap_dev->pathid == CAPTURE_PATH_SUB) ? V4L2_PIX_FMT_SRGGB8 :
+										 V4L2_PIX_FMT_RGB24;
+		viif_calc_plane_sizes(cap_dev, pix);
+		return;
+	}
+
+	pix->width = format.format.width;
+	pix->height = format.format.height;
+
+	/* check output format */
+	pix->pixelformat = (cap_dev->pathid == CAPTURE_PATH_SUB) ?
+				 get_pixelformat_from_mbus_code(cap_dev, format.format.code) :
+				 get_pixelformat_from_fourcc(cap_dev, pix->pixelformat);
+
+	/* update derived parameters, such as bpp */
+	viif_calc_plane_sizes(cap_dev, pix);
+}
+
+static int viif_try_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+
+	viif_try_fmt(cap_dev, &f->fmt.pix_mp);
+	return 0;
+}
+
+static int viif_s_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	int ret = 0;
+
+	if (vb2_is_busy(&cap_dev->vb2_vq))
+		return -EBUSY;
+
+	if (f->type != cap_dev->vb2_vq.type)
+		return -EINVAL;
+
+	viif_try_fmt(cap_dev, &f->fmt.pix_mp);
+	cap_dev->v4l2_pix = f->fmt.pix_mp;
+
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		ret = visconti_viif_isp_main_set_unit(viif_dev);
+		if (ret)
+			return ret;
+
+		ret = viif_l2_set_format(cap_dev);
+	} else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1) {
+		ret = viif_l2_set_format(cap_dev);
+	} else {
+		cap_dev->out_format = (f->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_SRGGB8) ?
+						    VIIF_ONE_COLOR_8 :
+						    VIIF_ONE_COLOR_16;
+		ret = visconti_viif_isp_sub_set_unit(viif_dev);
+	}
+
+	return ret;
+}
+
+static int viif_g_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+
+	f->fmt.pix_mp = cap_dev->v4l2_pix;
+
+	return 0;
+}
+
+static int viif_enum_framesizes(struct file *file, void *fh, struct v4l2_frmsizeenum *fsize)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+
+	if (fsize->index)
+		return -EINVAL;
+
+	if (!get_viif_fmt_from_fourcc(cap_dev, fsize->pixel_format))
+		return -EINVAL;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
+	fsize->stepwise.min_width = VIIF_MIN_OUTPUT_IMG_WIDTH;
+	fsize->stepwise.max_width = (cap_dev->pathid == CAPTURE_PATH_SUB) ?
+						  VIIF_MAX_OUTPUT_IMG_WIDTH_SUB :
+						  VIIF_MAX_OUTPUT_IMG_WIDTH_ISP;
+	fsize->stepwise.min_height = VIIF_MIN_OUTPUT_IMG_HEIGHT;
+	fsize->stepwise.max_height = (cap_dev->pathid == CAPTURE_PATH_SUB) ?
+						   VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB :
+						   VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP;
+	fsize->stepwise.step_width = 1;
+	fsize->stepwise.step_height = 1;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops viif_ioctl_ops = {
+	.vidioc_querycap = viif_querycap,
+
+	.vidioc_enum_fmt_vid_cap = viif_enum_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap_mplane = viif_try_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap_mplane = viif_s_fmt_vid_cap,
+	.vidioc_g_fmt_vid_cap_mplane = viif_g_fmt_vid_cap,
+
+	.vidioc_enum_framesizes = viif_enum_framesizes,
+
+	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+	.vidioc_querybuf = vb2_ioctl_querybuf,
+	.vidioc_qbuf = vb2_ioctl_qbuf,
+	.vidioc_expbuf = vb2_ioctl_expbuf,
+	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
+	.vidioc_streamon = vb2_ioctl_streamon,
+	.vidioc_streamoff = vb2_ioctl_streamoff,
+
+	.vidioc_log_status = v4l2_ctrl_log_status,
+	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+/* --- File Operations --- */
+static const struct v4l2_pix_format_mplane pixm_default[3] = {
+	{
+		.pixelformat = V4L2_PIX_FMT_RGB24,
+		.width = 1920,
+		.height = 1080,
+		.field = V4L2_FIELD_NONE,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+	},
+	{
+		.pixelformat = V4L2_PIX_FMT_RGB24,
+		.width = 1920,
+		.height = 1080,
+		.field = V4L2_FIELD_NONE,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+	},
+	{
+		.pixelformat = V4L2_PIX_FMT_SRGGB8,
+		.width = 1920,
+		.height = 1080,
+		.field = V4L2_FIELD_NONE,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+	}
+};
+
+static int viif_capture_open(struct file *file)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct v4l2_pix_format_mplane pixm;
+	int ret;
+
+	ret = v4l2_fh_open(file);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(viif_dev->dev);
+	if (ret) {
+		v4l2_fh_release(file);
+		return ret;
+	}
+
+	/* Initialize image format */
+	pixm = pixm_default[cap_dev->pathid];
+	viif_try_fmt(cap_dev, &pixm);
+	cap_dev->v4l2_pix = pixm;
+
+	return 0;
+}
+
+static int viif_capture_release(struct file *file)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+
+	vb2_fop_release(file);
+	pm_runtime_put(viif_dev->dev);
+
+	return 0;
+}
+
+static const struct v4l2_file_operations viif_fops = {
+	.owner = THIS_MODULE,
+	.open = viif_capture_open,
+	.release = viif_capture_release,
+	.unlocked_ioctl = video_ioctl2,
+	.mmap = vb2_fop_mmap,
+	.poll = vb2_fop_poll,
+};
+
+/* ----- media control callbacks ----- */
+static int viif_capture_link_validate(struct media_link *link)
+{
+	/* link validation at start-stream */
+	return 0;
+}
+
+static const struct media_entity_operations viif_media_ops = {
+	.link_validate = viif_capture_link_validate,
+};
+
+/* ----- attach ctrl callbacck handler ----- */
+int visconti_viif_capture_register_ctrl_handlers(struct viif_device *viif_dev)
+{
+	struct v4l2_subdev *sensor_sd = viif_dev->sensor_sd;
+	int ret;
+
+	if (!sensor_sd)
+		return -EINVAL;
+
+	/* MAIN POST0: merge controls of ISP and sensor */
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev0.ctrl_handler, sensor_sd->ctrl_handler, NULL,
+				    true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add sensor ctrl_handler");
+		return ret;
+	}
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev0.ctrl_handler,
+				    &viif_dev->isp_subdev.ctrl_handler, NULL, true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add isp subdev ctrl_handler");
+		return ret;
+	}
+
+	/* MAIN POST1: merge controls of ISP and sensor */
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev1.ctrl_handler, sensor_sd->ctrl_handler, NULL,
+				    true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add sensor ctrl_handler");
+		return ret;
+	}
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev1.ctrl_handler,
+				    &viif_dev->isp_subdev.ctrl_handler, NULL, true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add isp subdev ctrl_handler");
+		return ret;
+	}
+
+	/* SUB: no control is exported */
+
+	return 0;
+}
+
+/* ----- register/remove capture device node ----- */
+static int visconti_viif_capture_register_node(struct cap_dev *cap_dev)
+{
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct v4l2_device *v4l2_dev = &viif_dev->v4l2_dev;
+	struct video_device *vdev = &cap_dev->vdev;
+	struct vb2_queue *q = &cap_dev->vb2_vq;
+	static const char *const node_name[] = {
+		"viif_capture_post0",
+		"viif_capture_post1",
+		"viif_capture_sub",
+	};
+	int ret;
+
+	INIT_LIST_HEAD(&cap_dev->buf_queue);
+
+	mutex_init(&cap_dev->vlock);
+	spin_lock_init(&cap_dev->buf_lock);
+
+	/* Initialize vb2 queue. */
+	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	q->io_modes = VB2_MMAP | VB2_DMABUF;
+	q->min_buffers_needed = 3;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->ops = &viif_vb2_ops;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->drv_priv = cap_dev;
+	q->buf_struct_size = sizeof(struct viif_buffer);
+	q->lock = &cap_dev->vlock;
+	q->dev = viif_dev->v4l2_dev.dev;
+
+	ret = vb2_queue_init(q);
+	if (ret)
+		return ret;
+
+	/* Register the video device. */
+	strscpy(vdev->name, node_name[cap_dev->pathid], sizeof(vdev->name));
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->lock = &cap_dev->vlock;
+	vdev->queue = &cap_dev->vb2_vq;
+	vdev->ctrl_handler = NULL;
+	vdev->fops = &viif_fops;
+	vdev->ioctl_ops = &viif_ioctl_ops;
+	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_STREAMING;
+	vdev->device_caps |= V4L2_CAP_IO_MC;
+	vdev->entity.ops = &viif_media_ops;
+	vdev->release = video_device_release_empty;
+	video_set_drvdata(vdev, cap_dev);
+	vdev->vfl_dir = VFL_DIR_RX;
+	cap_dev->capture_pad.flags = MEDIA_PAD_FL_SINK;
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret < 0) {
+		dev_err(v4l2_dev->dev, "video_register_device failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = media_entity_pads_init(&vdev->entity, 1, &cap_dev->capture_pad);
+	if (ret) {
+		video_unregister_device(vdev);
+		return ret;
+	}
+
+	ret = v4l2_ctrl_handler_init(&cap_dev->ctrl_handler, 30);
+	if (ret)
+		return -ENOMEM;
+
+	cap_dev->vdev.ctrl_handler = &cap_dev->ctrl_handler;
+
+	return 0;
+}
+
+int visconti_viif_capture_register(struct viif_device *viif_dev)
+{
+	int ret;
+
+	/* register MAIN POST0 (primary RGB)*/
+	viif_dev->cap_dev0.pathid = CAPTURE_PATH_MAIN_POST0;
+	viif_dev->cap_dev0.viif_dev = viif_dev;
+	viif_dev->cap_dev0.fmts = viif_capture_fmt_list_mainpath;
+	viif_dev->cap_dev0.fmt_size = ARRAY_SIZE(viif_capture_fmt_list_mainpath);
+	ret = visconti_viif_capture_register_node(&viif_dev->cap_dev0);
+	if (ret)
+		return ret;
+
+	/* register MAIN POST1 (additional RGB)*/
+	viif_dev->cap_dev1.pathid = CAPTURE_PATH_MAIN_POST1;
+	viif_dev->cap_dev1.viif_dev = viif_dev;
+	viif_dev->cap_dev1.fmts = viif_capture_fmt_list_mainpath;
+	viif_dev->cap_dev1.fmt_size = ARRAY_SIZE(viif_capture_fmt_list_mainpath);
+	ret = visconti_viif_capture_register_node(&viif_dev->cap_dev1);
+	if (ret)
+		return ret;
+
+	/* register SUB (RAW) */
+	viif_dev->cap_dev2.pathid = CAPTURE_PATH_SUB;
+	viif_dev->cap_dev2.viif_dev = viif_dev;
+	viif_dev->cap_dev2.fmts = viif_capture_fmt_list_subpath;
+	viif_dev->cap_dev2.fmt_size = ARRAY_SIZE(viif_capture_fmt_list_subpath);
+	ret = visconti_viif_capture_register_node(&viif_dev->cap_dev2);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void visconti_viif_capture_unregister_node(struct cap_dev *cap_dev)
+{
+	media_entity_cleanup(&cap_dev->vdev.entity);
+	v4l2_ctrl_handler_free(&cap_dev->ctrl_handler);
+	vb2_video_unregister_device(&cap_dev->vdev);
+	mutex_destroy(&cap_dev->vlock);
+}
+
+void visconti_viif_capture_unregister(struct viif_device *viif_dev)
+{
+	visconti_viif_capture_unregister_node(&viif_dev->cap_dev0);
+	visconti_viif_capture_unregister_node(&viif_dev->cap_dev1);
+	visconti_viif_capture_unregister_node(&viif_dev->cap_dev2);
+}
diff --git a/drivers/media/platform/toshiba/visconti/viif_capture.h b/drivers/media/platform/toshiba/visconti/viif_capture.h
new file mode 100644
index 000000000000..dded862bedf4
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif_capture.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef VIIF_CAPTURE_H
+#define VIIF_CAPTURE_H
+
+struct viif_device;
+struct cap_dev;
+struct viif_l2_roi_config;
+
+int visconti_viif_capture_register_ctrl_handlers(struct viif_device *viif_dev);
+void visconti_viif_capture_switch_buffer(struct cap_dev *cap_dev, u32 status_err,
+					 u32 l2_transfer_status, u64 timestamp);
+
+int visconti_viif_capture_register(struct viif_device *viif_dev);
+void visconti_viif_capture_unregister(struct viif_device *viif_dev);
+
+#endif /* VIIF_CAPTURE_H */
diff --git a/drivers/media/platform/toshiba/visconti/viif_common.c b/drivers/media/platform/toshiba/visconti/viif_common.c
new file mode 100644
index 000000000000..7a735df3b141
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif_common.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <media/mipi-csi2.h>
+#include <media/v4l2-common.h>
+
+#include "viif.h"
+#include "viif_common.h"
+#include "viif_regs.h"
+
+/*=============================================*/
+/* Low level guards for registers */
+/*=============================================*/
+
+#define VIIF_L1_CRGBF_R_START_ADDR_LIMIT 0x0200U
+#define VIIF_L1_CRGBF_R_END_ADDR_LIMIT	 0x10BFU
+#define VIIF_L2_CRGBF_R_START_ADDR_LIMIT 0x1CU
+#define VIIF_L2_CRGBF_R_END_ADDR_LIMIT	 0x1FU
+
+/**
+ * hwd_viif_main_mask_vlatch() - Control Vlatch mask of MAIN unit
+ *
+ * @viif_dev: the VIIF device
+ * @enable: true to enable Vlatch mask of MAIN unit, false to disable
+ */
+static void hwd_viif_main_mask_vlatch(struct viif_device *viif_dev, bool enable)
+{
+	u32 val = enable ? MASK_IPORTM_VLATCH : 0;
+
+	viif_capture_write(viif_dev, REG_IPORTM0_LD, val);
+	viif_capture_write(viif_dev, REG_IPORTM1_LD, val);
+}
+
+/**
+ * hwd_viif_isp_set_regbuf_auto_transmission() - Set register buffer auto transmission
+ *
+ * @viif_dev: the VIIF device
+ */
+void hwd_viif_isp_set_regbuf_auto_transmission(struct viif_device *viif_dev)
+{
+	/* Set parameters for auto read transmission of register buffer */
+	viif_capture_write(viif_dev, REG_L1_CRGBF_TRN_A_CONF, 0);
+	viif_capture_write(viif_dev, REG_L2_CRGBF_TRN_A_CONF, 0);
+	viif_capture_write(viif_dev, REG_L1_CRGBF_TRN_RBADDR, VIIF_L1_CRGBF_R_START_ADDR_LIMIT);
+	viif_capture_write(viif_dev, REG_L1_CRGBF_TRN_READDR, VIIF_L1_CRGBF_R_END_ADDR_LIMIT);
+	viif_capture_write(viif_dev, REG_L2_CRGBF_TRN_RBADDR, VIIF_L2_CRGBF_R_START_ADDR_LIMIT);
+	viif_capture_write(viif_dev, REG_L2_CRGBF_TRN_READDR, VIIF_L2_CRGBF_R_END_ADDR_LIMIT);
+	viif_capture_write(viif_dev, REG_L2_CRGBF_TRN_A_CONF, VAL_L2_CRGBF_TRN_AUTO_READ_BANK0);
+	viif_capture_write(viif_dev, REG_L1_CRGBF_TRN_A_CONF, VAL_L1_CRGBF_TRN_AUTO_READ_BANK0);
+}
+
+/**
+ * hwd_viif_isp_disable_regbuf_auto_transmission() - Disable register buffer auto transmission
+ *
+ * @viif_dev: the VIIF device
+ */
+void hwd_viif_isp_disable_regbuf_auto_transmission(struct viif_device *viif_dev)
+{
+	viif_capture_write(viif_dev, REG_L1_CRGBF_TRN_A_CONF, 0);
+	viif_capture_write(viif_dev, REG_L2_CRGBF_TRN_A_CONF, 0);
+}
+
+/**
+ * hwd_viif_isp_guard_start() - stop register auto update
+ *
+ * @viif_dev: the VIIF device
+ *
+ * This function call stops update of some hardware registers
+ * while the manual setup of VIIF, L1ISP registers is in progress.
+ *
+ * * regbuf control: load/store HW register (settings, status) values to backup SRAM.
+ * * vlatch control: copy timer-counter register value to status register.
+ */
+void hwd_viif_isp_guard_start(struct viif_device *viif_dev)
+{
+	hwd_viif_isp_disable_regbuf_auto_transmission(viif_dev);
+	ndelay(500);
+	hwd_viif_main_mask_vlatch(viif_dev, true);
+}
+
+/**
+ * hwd_viif_isp_guard_end() - restart register auto update
+ *
+ * @viif_dev: the VIIF device
+ *
+ * see also hwd_viif_isp_guard_start().
+ */
+void hwd_viif_isp_guard_end(struct viif_device *viif_dev)
+{
+	hwd_viif_main_mask_vlatch(viif_dev, false);
+	hwd_viif_isp_set_regbuf_auto_transmission(viif_dev);
+}
+
+/*=============================================*/
+/* supported Visual formats */
+/*=============================================*/
+static const struct viif_mbus_format mbus_formats[] = {
+	{ .code = MEDIA_BUS_FMT_RGB888_1X24,
+	  .bpp = 24,
+	  .rgb_out = true,
+	  .mipi_dt = MIPI_CSI2_DT_RGB888 },
+	{ .code = MEDIA_BUS_FMT_UYVY8_1X16,
+	  .bpp = 16,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_YUV422_8B },
+	{ .code = MEDIA_BUS_FMT_UYVY10_1X20,
+	  .bpp = 20,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_YUV422_10B },
+	{ .code = MEDIA_BUS_FMT_RGB565_1X16,
+	  .bpp = 16,
+	  .rgb_out = true,
+	  .mipi_dt = MIPI_CSI2_DT_RGB565 },
+	{ .code = MEDIA_BUS_FMT_SBGGR8_1X8,
+	  .bpp = 8,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW8 },
+	{ .code = MEDIA_BUS_FMT_SGBRG8_1X8,
+	  .bpp = 8,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW8 },
+	{ .code = MEDIA_BUS_FMT_SGRBG8_1X8,
+	  .bpp = 8,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW8 },
+	{ .code = MEDIA_BUS_FMT_SRGGB8_1X8,
+	  .bpp = 8,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW8 },
+	{ .code = MEDIA_BUS_FMT_SRGGB10_1X10,
+	  .bpp = 10,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW10 },
+	{ .code = MEDIA_BUS_FMT_SGRBG10_1X10,
+	  .bpp = 10,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW10 },
+	{ .code = MEDIA_BUS_FMT_SGBRG10_1X10,
+	  .bpp = 10,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW10 },
+	{ .code = MEDIA_BUS_FMT_SBGGR10_1X10,
+	  .bpp = 10,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW10 },
+	{ .code = MEDIA_BUS_FMT_SRGGB12_1X12,
+	  .bpp = 12,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW12 },
+	{ .code = MEDIA_BUS_FMT_SGRBG12_1X12,
+	  .bpp = 12,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW12 },
+	{ .code = MEDIA_BUS_FMT_SGBRG12_1X12,
+	  .bpp = 12,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW12 },
+	{ .code = MEDIA_BUS_FMT_SBGGR12_1X12,
+	  .bpp = 12,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW12 },
+	{ .code = MEDIA_BUS_FMT_SRGGB14_1X14,
+	  .bpp = 14,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW14 },
+	{ .code = MEDIA_BUS_FMT_SGRBG14_1X14,
+	  .bpp = 14,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW14 },
+	{ .code = MEDIA_BUS_FMT_SGBRG14_1X14,
+	  .bpp = 14,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW14 },
+	{ .code = MEDIA_BUS_FMT_SBGGR14_1X14,
+	  .bpp = 14,
+	  .rgb_out = false,
+	  .mipi_dt = MIPI_CSI2_DT_RAW14 },
+};
+
+const struct viif_mbus_format *viif_mbus_format_from_code(unsigned int mbus_code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mbus_formats); i++)
+		if (mbus_formats[i].code == mbus_code)
+			return &mbus_formats[i];
+
+	return NULL;
+}
+
+const struct viif_mbus_format *viif_mbus_format_nth(unsigned int n)
+{
+	return (n < ARRAY_SIZE(mbus_formats)) ? &mbus_formats[n] : NULL;
+}
diff --git a/drivers/media/platform/toshiba/visconti/viif_common.h b/drivers/media/platform/toshiba/visconti/viif_common.h
new file mode 100644
index 000000000000..e9dbac6faf6b
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif_common.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef VIIF_COMMON_H
+#define VIIF_COMMON_H
+
+#include "viif.h"
+
+/**
+ * struct viif_mbus_format - description of supported input format
+ *
+ * @code: V4L2 media bus format (coming from image sensor)
+ * @bpp: bits per pixel
+ * @mipi_dt: MIPI Datatype corresponding to code
+ * @rgb_out:
+ * * True: L1ISP output is RGB format
+ * * False: L1ISP output is YUV format
+ */
+struct viif_mbus_format {
+	unsigned int code;
+	unsigned int bpp;
+	unsigned int mipi_dt;
+	bool rgb_out;
+};
+
+void hwd_viif_isp_set_regbuf_auto_transmission(struct viif_device *viif_dev);
+void hwd_viif_isp_disable_regbuf_auto_transmission(struct viif_device *viif_dev);
+void hwd_viif_isp_guard_start(struct viif_device *viif_dev);
+void hwd_viif_isp_guard_end(struct viif_device *viif_dev);
+
+const struct viif_mbus_format *viif_mbus_format_from_code(unsigned int mbus_code);
+const struct viif_mbus_format *viif_mbus_format_nth(unsigned int n);
+
+#endif /* VIIF_COMMON_H */
diff --git a/drivers/media/platform/toshiba/visconti/viif_csi2rx.c b/drivers/media/platform/toshiba/visconti/viif_csi2rx.c
new file mode 100644
index 000000000000..f4ec17655ab1
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif_csi2rx.c
@@ -0,0 +1,691 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <media/mipi-csi2.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-subdev.h>
+
+#include "viif.h"
+#include "viif_common.h"
+#include "viif_csi2rx.h"
+#include "viif_csi2rx_regs.h"
+#include "viif_regs.h"
+
+/* specifies which D-PHY line(L0-L3) is assigned to D0-D3 */
+enum viif_csi2rx_dphy_lane {
+	VIIF_CSI2RX_DPHY_L0L1L2L3 = 0U,
+	VIIF_CSI2RX_DPHY_L0L3L1L2 = 1U,
+	VIIF_CSI2RX_DPHY_L0L2L3L1 = 2U,
+	VIIF_CSI2RX_DPHY_L0L1L3L2 = 4U,
+	VIIF_CSI2RX_DPHY_L0L3L2L1 = 5U,
+	VIIF_CSI2RX_DPHY_L0L2L1L3 = 6U
+};
+
+#define VIIF_CSI2RX_ERROR_MONITORS_NUM 8
+
+/**
+ * struct viif_csi2rx_line_err_target
+ *
+ * Virtual Channel and Data Type pair for CSI2RX line error monitor
+ *
+ * When 0 is set to dt, line error detection is disabled.
+ *
+ * @vc: Virtual Channel to monitor; Range 0..3
+ * @dt: Data Type to monitor; Range 0, 0x10..0x3F
+ */
+struct viif_csi2rx_line_err_target {
+	u32 vc[VIIF_CSI2RX_ERROR_MONITORS_NUM];
+	u32 dt[VIIF_CSI2RX_ERROR_MONITORS_NUM];
+};
+
+#define VIIF_CSI2RX_MAX_VC	3U
+#define VIIF_DPHY_MIN_DATA_RATE 80U
+#define VIIF_DPHY_MAX_DATA_RATE 1500U
+#define VIIF_DPHY_CFG_CLK_25M	32U
+
+#define VIIF_CSI2RX_DEF_WIDTH  1920
+#define VIIF_CSI2RX_DEF_HEIGHT 1080
+#define VIIF_CSI2RX_DEF_FMT    MEDIA_BUS_FMT_SRGGB10_1X10
+#define VIIF_ISP_MIN_WIDTH     640
+#define VIIF_ISP_MAX_WIDTH     3840
+#define VIIF_ISP_MIN_HEIGHT    480
+#define VIIF_ISP_MAX_HEIGHT    2160
+
+/*=============================================*/
+/* Register Access */
+/*=============================================*/
+static inline void viif_csi2rx_write(struct viif_device *viif_dev, u32 regid, u32 val)
+{
+	writel(val, viif_dev->csi2host_reg + regid);
+}
+
+static inline u32 viif_csi2rx_read(struct viif_device *viif_dev, u32 regid)
+{
+	return readl(viif_dev->csi2host_reg + regid);
+}
+
+/*=============================================*/
+/* DPHY control commands via test register */
+/*=============================================*/
+static inline void tick_testclk(struct viif_device *viif_dev)
+{
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_TESTCTRL0, BIT_TESTCTRL0_CLK_1);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_TESTCTRL0, BIT_TESTCTRL0_CLK_0);
+}
+
+static inline void set_dphy_addr(struct viif_device *viif_dev, u32 test_mode)
+{
+	/* select testcode Ex space with top 4bits of test_mode */
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_TESTCTRL1,
+			  BIT_TESTCTRL1_ADDR | DIG_TESTCODE_EXT);
+	tick_testclk(viif_dev);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_TESTCTRL1, FIELD_GET(0xF00, test_mode));
+	tick_testclk(viif_dev);
+
+	/* set bottom 8bit of test_mode */
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_TESTCTRL1,
+			  BIT_TESTCTRL1_ADDR | FIELD_GET(0xFF, test_mode));
+	tick_testclk(viif_dev);
+}
+
+static void write_dphy_param(struct viif_device *viif_dev, u32 test_mode, u8 test_in)
+{
+	set_dphy_addr(viif_dev, test_mode);
+
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_TESTCTRL1, (u32)test_in);
+	tick_testclk(viif_dev);
+}
+
+static u8 read_dphy_param(u32 test_mode, struct viif_device *viif_dev)
+{
+	u32 read_data;
+
+	set_dphy_addr(viif_dev, test_mode);
+
+	read_data = viif_csi2rx_read(viif_dev, REG_CSI2RX_PHY_TESTCTRL1);
+	return (u8)(FIELD_GET(MASK_TESTCTRL1_DIN, read_data));
+}
+
+/*=============================================*/
+/* DPHY configuration */
+/*=============================================*/
+/**
+ * struct viif_dphy_hs_info - dphy hs information
+ *
+ * @rate: Data rate [Mbps]
+ * @hsfreqrange: IP operating frequency(hsfreqrange)
+ * @osc_freq_target: DDL target oscillation frequency(osc_freq_target)
+ */
+struct viif_dphy_hs_info {
+	u32 rate;
+	u32 hsfreqrange;
+	u32 osc_freq_target;
+};
+
+static const struct viif_dphy_hs_info dphy_hs_info[] = {
+	{ 80, 0x0, 0x1cc },   { 85, 0x10, 0x1cc },   { 95, 0x20, 0x1cc },   { 105, 0x30, 0x1cc },
+	{ 115, 0x1, 0x1cc },  { 125, 0x11, 0x1cc },  { 135, 0x21, 0x1cc },  { 145, 0x31, 0x1cc },
+	{ 155, 0x2, 0x1cc },  { 165, 0x12, 0x1cc },  { 175, 0x22, 0x1cc },  { 185, 0x32, 0x1cc },
+	{ 198, 0x3, 0x1cc },  { 213, 0x13, 0x1cc },  { 228, 0x23, 0x1cc },  { 243, 0x33, 0x1cc },
+	{ 263, 0x4, 0x1cc },  { 288, 0x14, 0x1cc },  { 313, 0x25, 0x1cc },  { 338, 0x35, 0x1cc },
+	{ 375, 0x5, 0x1cc },  { 425, 0x16, 0x1cc },  { 475, 0x26, 0x1cc },  { 525, 0x37, 0x1cc },
+	{ 575, 0x7, 0x1cc },  { 625, 0x18, 0x1cc },  { 675, 0x28, 0x1cc },  { 725, 0x39, 0x1cc },
+	{ 775, 0x9, 0x1cc },  { 825, 0x19, 0x1cc },  { 875, 0x29, 0x1cc },  { 925, 0x3a, 0x1cc },
+	{ 975, 0xa, 0x1cc },  { 1025, 0x1a, 0x1cc }, { 1075, 0x2a, 0x1cc }, { 1125, 0x3b, 0x1cc },
+	{ 1175, 0xb, 0x1cc }, { 1225, 0x1b, 0x1cc }, { 1275, 0x2b, 0x1cc }, { 1325, 0x3c, 0x1cc },
+	{ 1375, 0xc, 0x1cc }, { 1425, 0x1c, 0x1cc }, { 1475, 0x2c, 0x1cc }
+};
+
+/**
+ * get_dphy_hs_transfer_info() - Get DPHY HS info from table
+ *
+ * @dphy_rate: DPHY clock in MHz
+ * @hsfreqrange: HS Frequency Range
+ * @osc_freq_target: OSC Frequency Target
+ */
+static void get_dphy_hs_transfer_info(u32 dphy_rate, u32 *hsfreqrange, u32 *osc_freq_target)
+{
+	unsigned int i;
+
+	for (i = 1; i < ARRAY_SIZE(dphy_hs_info); i++) {
+		if (dphy_rate < dphy_hs_info[i].rate) {
+			*hsfreqrange = dphy_hs_info[i - 1].hsfreqrange;
+			*osc_freq_target = dphy_hs_info[i - 1].osc_freq_target;
+			return;
+		}
+	}
+
+	/* not found; return the largest entry */
+	*hsfreqrange = dphy_hs_info[ARRAY_SIZE(dphy_hs_info) - 1].hsfreqrange;
+	*osc_freq_target = dphy_hs_info[ARRAY_SIZE(dphy_hs_info) - 1].osc_freq_target;
+}
+
+/**
+ * viif_csi2rx_set_dphy_rate() - Set D-PHY rate
+ *
+ * @viif_dev: the VIIF device
+ * @dphy_rate: D-PHY rate of 1 Lane [Unit: Mbps]. Range: [80..1500]
+ */
+static void viif_csi2rx_set_dphy_rate(struct viif_device *viif_dev, u32 dphy_rate)
+{
+	u32 hsfreqrange, osc_freq_target;
+
+	get_dphy_hs_transfer_info(dphy_rate, &hsfreqrange, &osc_freq_target);
+
+	write_dphy_param(viif_dev, DIG_SYS_1, (u8)hsfreqrange);
+	write_dphy_param(viif_dev, DIG_SYS_0, SYS_0_HSFREQRANGE_OVR);
+	write_dphy_param(viif_dev, DIG_RX_STARTUP_OVR_5, STARTUP_OVR_5_BYPASS);
+	write_dphy_param(viif_dev, DIG_RX_STARTUP_OVR_4, STARTUP_OVR_4_CNTVAL);
+	write_dphy_param(viif_dev, DIG_CB_2, CB_2_LPRX_BIAS | CB_2_RESERVED);
+	write_dphy_param(viif_dev, DIG_SYS_7, SYS_7_DESKEW_POL | SYS_7_RESERVED);
+	write_dphy_param(viif_dev, DIG_CLKLANE_LANE_6, CLKLANE_RXHS_PULL_LONG);
+	write_dphy_param(viif_dev, DIG_RX_STARTUP_OVR_2, FIELD_GET(0xFF, osc_freq_target));
+	write_dphy_param(viif_dev, DIG_RX_STARTUP_OVR_3, FIELD_GET(0xF00, osc_freq_target));
+	write_dphy_param(viif_dev, DIG_RX_STARTUP_OVR_4,
+			 STARTUP_OVR_4_CNTVAL | STARTUP_OVR_4_DDL_EN);
+
+	viif_capture_write(viif_dev, REG_DPHY_FREQRANGE, VIIF_DPHY_CFG_CLK_25M);
+}
+
+/**
+ * check_dphy_calibration_status() - Check D-PHY calibration status
+ *
+ * @viif_dev: the VIIF device
+ * @test_mode: test code related to calibration information
+ * @mask_err: mask for error bit (0 for absence)
+ * @mask_done: mask for done bit
+ * Return: 0 for success, -EAGAIN for not done, -EIO for failure
+ */
+static int check_dphy_calibration_status(struct viif_device *viif_dev, u32 test_mode, u32 mask_err,
+					 u32 mask_done)
+{
+	u32 read_data = (u32)read_dphy_param(test_mode, viif_dev);
+
+	if (!(read_data & mask_done))
+		return -EAGAIN;
+
+	/* done with error */
+	if (read_data & mask_err)
+		return -EIO;
+
+	return 0;
+}
+
+/*=============================================*/
+/* Low Layer Implementation */
+/*=============================================*/
+/**
+ * viif_csi2rx_initialize() - Initialize CSI-2 RX driver
+ *
+ * @viif_dev: the VIIF device
+ * @num_lane: Range: [1..4]
+ * @lane_assign: lane connection. For more refer @ref viif_dphy_lane_assignment
+ * @dphy_rate: D-PHY rate of 1 Lane [Unit: Mbps]. Range: [80..1500]
+ * @rext_calibration: set True to enable rext calibration, False to disable.
+ * @err_target: Pointer to configuration for Line error detection.
+ * Return: 0 for success, -EINVAL for parameter error
+ */
+static int viif_csi2rx_initialize(struct viif_device *viif_dev, u32 num_lane,
+				  enum viif_csi2rx_dphy_lane lane_assign, u32 dphy_rate,
+				  bool rext_calibration,
+				  const struct viif_csi2rx_line_err_target *err_target)
+{
+	u32 i, val;
+
+	if (num_lane == 0U || num_lane > 4U || lane_assign > VIIF_CSI2RX_DPHY_L0L2L1L3)
+		return -EINVAL;
+
+	if (dphy_rate < VIIF_DPHY_MIN_DATA_RATE || dphy_rate > VIIF_DPHY_MAX_DATA_RATE ||
+	    !err_target) {
+		return -EINVAL;
+	}
+
+	for (i = 0; i < VIIF_CSI2RX_ERROR_MONITORS_NUM; i++) {
+		if (err_target->vc[i] > VIIF_CSI2RX_MAX_VC ||
+		    err_target->dt[i] > MIPI_CSI2_DT_USER_DEFINED(7) ||
+		    (err_target->dt[i] < MIPI_CSI2_DT_NULL && err_target->dt[i])) {
+			return -EINVAL;
+		}
+	}
+
+	/* 1st phase of initialization */
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_RESETN, 1);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_RSTZ, 0);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_SHUTDOWNZ, 0);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_TESTCTRL0, 1);
+	ndelay(15U);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_TESTCTRL0, 0);
+
+	/* Configure D-PHY frequency range */
+	viif_csi2rx_set_dphy_rate(viif_dev, dphy_rate);
+
+	/* 2nd phase of initialization */
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_NLANES, (num_lane - 1U));
+	ndelay(5U);
+
+	/* configuration not to use rext */
+	if (!rext_calibration) {
+		write_dphy_param(viif_dev, DIG_SYS_3, SYS_3_NO_REXT);
+		ndelay(5U);
+	}
+
+	/* Release D-PHY from Reset */
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_SHUTDOWNZ, 1);
+	ndelay(5U);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_RSTZ, 1);
+
+	/* configuration of line error target */
+	val = (err_target->vc[3] << 30U) | (err_target->dt[3] << 24U) | (err_target->vc[2] << 22U) |
+	      (err_target->dt[2] << 16U) | (err_target->vc[1] << 14U) | (err_target->dt[1] << 8U) |
+	      (err_target->vc[0] << 6U) | (err_target->dt[0]);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_DATA_IDS_1, val);
+	val = (err_target->vc[7] << 30U) | (err_target->dt[7] << 24U) | (err_target->vc[6] << 22U) |
+	      (err_target->dt[6] << 16U) | (err_target->vc[5] << 14U) | (err_target->dt[5] << 8U) |
+	      (err_target->vc[4] << 6U) | (err_target->dt[4]);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_DATA_IDS_2, val);
+
+	/* configuration of mask */
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_INT_MSK_PHY_FATAL, MASK_PHY_FATAL_ALL);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_INT_MSK_PKT_FATAL, MASK_PKT_FATAL_ALL);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_INT_MSK_FRAME_FATAL, MASK_FRAME_FATAL_ALL);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_INT_MSK_PHY, MASK_PHY_ERROR_ALL);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_INT_MSK_PKT, MASK_PKT_ERROR_ALL);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_INT_MSK_LINE, MASK_LINE_ERROR_ALL);
+
+	/* configuration of lane assignment */
+	viif_capture_write(viif_dev, REG_DPHY_LANE, lane_assign);
+
+	return 0;
+}
+
+/**
+ * viif_csi2rx_uninitialize() - Uninitialize CSI-2 RX driver
+ *
+ * @viif_dev: the VIIF device
+ */
+static int viif_csi2rx_uninitialize(struct viif_device *viif_dev)
+{
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_SHUTDOWNZ, 0);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_RSTZ, 0);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_PHY_TESTCTRL0, 1);
+	viif_csi2rx_write(viif_dev, REG_CSI2RX_RESETN, 0);
+
+	return 0;
+}
+
+/*=============================================*/
+/* handling vendor specific control requests */
+/*=============================================*/
+/**
+ * visconti_viif_csi2rx_get_calibration_status() - Get CSI-2 RX calibration status
+ *
+ * @viif_dev: the VIIF device
+ * @status: Pointer to D-PHY calibration status information
+ * Return: 0 Operation completes successfully
+ */
+int visconti_viif_csi2rx_get_calibration_status(struct viif_device *viif_dev,
+						struct viif_csi2rx_dphy_calibration_status *status)
+{
+	/* termination calibration with REXT */
+	status->term_cal_with_rext = check_dphy_calibration_status(
+		viif_dev, DIG_TERM_CAL_1, MASK_TERM_CAL_ERR, MASK_TERM_CAL_DONE);
+
+	/* offset calibration */
+	status->clock_lane_offset_cal = check_dphy_calibration_status(
+		viif_dev, DIG_CLKLANE_OFFSET_CAL_0, MASK_CLK_CAL_ERR, MASK_CLK_CAL_DONE);
+	status->data_lane0_offset_cal = check_dphy_calibration_status(
+		viif_dev, DIG_LANE0_OFFSET_CAL_0, MASK_CAL_ERR, MASK_CAL_DONE);
+	status->data_lane1_offset_cal = check_dphy_calibration_status(
+		viif_dev, DIG_LANE1_OFFSET_CAL_0, MASK_CAL_ERR, MASK_CAL_DONE);
+	status->data_lane2_offset_cal = check_dphy_calibration_status(
+		viif_dev, DIG_LANE2_OFFSET_CAL_0, MASK_CAL_ERR, MASK_CAL_DONE);
+	status->data_lane3_offset_cal = check_dphy_calibration_status(
+		viif_dev, DIG_LANE3_OFFSET_CAL_0, MASK_CAL_ERR, MASK_CAL_DONE);
+
+	/* Digital Delay Line calibration */
+	status->data_lane0_ddl_tuning_cal = check_dphy_calibration_status(
+		viif_dev, DIG_LANE0_DDL_0, MASK_DDL_ERR, MASK_DDL_DONE);
+	status->data_lane1_ddl_tuning_cal = check_dphy_calibration_status(
+		viif_dev, DIG_LANE1_DDL_0, MASK_DDL_ERR, MASK_DDL_DONE);
+	status->data_lane2_ddl_tuning_cal = check_dphy_calibration_status(
+		viif_dev, DIG_LANE2_DDL_0, MASK_DDL_ERR, MASK_DDL_DONE);
+	status->data_lane3_ddl_tuning_cal = check_dphy_calibration_status(
+		viif_dev, DIG_LANE3_DDL_0, MASK_DDL_ERR, MASK_DDL_DONE);
+
+	return 0;
+}
+
+/**
+ * visconti_viif_csi2rx_get_err_status() - Get CSI-2 RX error status
+ *
+ * @viif_dev: the VIIF device
+ * @csi_err: error information
+ * Return: 0 Operation completes successfully
+ */
+int visconti_viif_csi2rx_get_err_status(struct viif_device *viif_dev,
+					struct viif_csi2rx_err_status *csi_err)
+{
+	csi_err->err_phy_fatal = viif_csi2rx_read(viif_dev, REG_CSI2RX_INT_ST_PHY_FATAL);
+	csi_err->err_pkt_fatal = viif_csi2rx_read(viif_dev, REG_CSI2RX_INT_ST_PKT_FATAL);
+	csi_err->err_frame_fatal = viif_csi2rx_read(viif_dev, REG_CSI2RX_INT_ST_FRAME_FATAL);
+	csi_err->err_phy = viif_csi2rx_read(viif_dev, REG_CSI2RX_INT_ST_PHY);
+	csi_err->err_pkt = viif_csi2rx_read(viif_dev, REG_CSI2RX_INT_ST_PKT);
+	csi_err->err_line = viif_csi2rx_read(viif_dev, REG_CSI2RX_INT_ST_LINE);
+
+	return 0;
+}
+
+/* IRQ handler: reports CSI-2 RX error status */
+u32 visconti_viif_csi2rx_err_irq_handler(struct viif_device *viif_dev)
+{
+	return viif_csi2rx_read(viif_dev, REG_CSI2RX_INT_ST_MAIN);
+}
+
+/*=============================================*/
+/* handling V4L2 framework */
+/*=============================================*/
+static inline struct csi2rx_subdev *to_csi2rx_subdev(struct v4l2_subdev *sd)
+{
+	return container_of(sd, struct csi2rx_subdev, sd);
+}
+
+static int64_t get_pixelclock(struct v4l2_subdev *sd)
+{
+	struct v4l2_ctrl *ctrl;
+
+	ctrl = v4l2_ctrl_find(sd->ctrl_handler, V4L2_CID_PIXEL_RATE);
+	if (!ctrl)
+		return -EINVAL;
+
+	return v4l2_ctrl_g_ctrl_int64(ctrl);
+}
+
+static unsigned int viif_get_mbus_bpp(unsigned int mbus_code)
+{
+	const struct viif_mbus_format *fmt;
+
+	fmt = viif_mbus_format_from_code(mbus_code);
+
+	return fmt ? fmt->bpp : 24; /* default bpp */
+}
+
+/* ----- handling CSI2RX hardware ----- */
+static const struct viif_csi2rx_line_err_target err_target_vc0_alldt = {
+	/* select VC=0 */
+	/* select all supported DataTypes */
+	.dt = {
+		MIPI_CSI2_DT_RGB565,
+		MIPI_CSI2_DT_YUV422_8B,
+		MIPI_CSI2_DT_YUV422_10B,
+		MIPI_CSI2_DT_RGB888,
+		MIPI_CSI2_DT_RAW8,
+		MIPI_CSI2_DT_RAW10,
+		MIPI_CSI2_DT_RAW12,
+		MIPI_CSI2_DT_RAW14,
+	}
+};
+
+static int viif_csi2rx_start(struct viif_device *viif_dev)
+{
+	struct v4l2_subdev *sensor_sd = viif_dev->sensor_sd;
+	struct v4l2_mbus_config cfg = { 0 };
+	struct v4l2_subdev_format fmt = {
+		.pad = 0,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int num_lane, dphy_rate;
+	s64 pixelclock;
+	int ret;
+
+	if (!sensor_sd)
+		return -EINVAL;
+
+	ret = v4l2_subdev_call(sensor_sd, pad, get_mbus_config, 0, &cfg);
+	if (ret) {
+		dev_dbg(viif_dev->dev, "subdev: g_mbus_config error. %d\n", ret);
+		num_lane = viif_dev->sensor_num_lane;
+	} else {
+		if (cfg.type != V4L2_MBUS_CSI2_DPHY)
+			return -EINVAL;
+		num_lane = cfg.bus.mipi_csi2.num_data_lanes;
+	}
+
+	ret = v4l2_subdev_call(sensor_sd, pad, get_fmt, 0, &fmt);
+	if (ret)
+		return -EINVAL;
+
+	pixelclock = get_pixelclock(sensor_sd);
+	if (pixelclock < 0)
+		return -EINVAL;
+
+	dphy_rate = pixelclock * viif_get_mbus_bpp(fmt.format.code) / num_lane / 1000000;
+
+	ret = viif_csi2rx_initialize(viif_dev, num_lane, VIIF_CSI2RX_DPHY_L0L1L2L3, dphy_rate, true,
+				     &err_target_vc0_alldt);
+	return ret;
+}
+
+static int viif_csi2rx_stop(struct viif_device *viif_dev)
+{
+	viif_csi2rx_uninitialize(viif_dev);
+
+	return 0;
+}
+
+/* ----- V4L2 subdevice APIs (csi2rx subdevice) ----- */
+static struct v4l2_mbus_framefmt *
+visconti_viif_csi2rx_get_pad_fmt(struct csi2rx_subdev *csi2rx, struct v4l2_subdev_state *sd_state,
+				 unsigned int pad, u32 which)
+{
+	struct v4l2_subdev_state state = {
+		.pads = csi2rx->pad_cfg,
+	};
+
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&csi2rx->sd, sd_state, pad);
+	else
+		return v4l2_subdev_get_try_format(&csi2rx->sd, &state, pad);
+}
+
+static int visconti_viif_csi2rx_enum_mbus_code(struct v4l2_subdev *sd,
+					       struct v4l2_subdev_state *sd_state,
+					       struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct csi2rx_subdev *csi2rx = to_csi2rx_subdev(sd);
+	const struct viif_mbus_format *fmt;
+
+	if (code->pad == VIIF_CSI2RX_PAD_SRC) {
+		const struct v4l2_mbus_framefmt *sink_fmt;
+
+		/* should be equal to current settings of sink pad */
+		if (code->index)
+			return -EINVAL;
+
+		mutex_lock(&csi2rx->ops_lock);
+
+		sink_fmt = visconti_viif_csi2rx_get_pad_fmt(csi2rx, sd_state, VIIF_CSI2RX_PAD_SINK,
+							    code->which);
+		code->code = sink_fmt->code;
+
+		mutex_unlock(&csi2rx->ops_lock);
+
+		return 0;
+	}
+
+	/* find specified format */
+	fmt = viif_mbus_format_nth(code->index);
+	if (!fmt)
+		return -EINVAL;
+
+	code->code = fmt->code;
+	return 0;
+}
+
+static int visconti_viif_csi2rx_init_config(struct v4l2_subdev *sd,
+					    struct v4l2_subdev_state *sd_state)
+{
+	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
+
+	sink_fmt = v4l2_subdev_get_try_format(sd, sd_state, VIIF_CSI2RX_PAD_SINK);
+	src_fmt = v4l2_subdev_get_try_format(sd, sd_state, VIIF_CSI2RX_PAD_SRC);
+
+	sink_fmt->width = VIIF_CSI2RX_DEF_WIDTH;
+	sink_fmt->height = VIIF_CSI2RX_DEF_HEIGHT;
+	sink_fmt->field = V4L2_FIELD_NONE;
+	sink_fmt->code = VIIF_CSI2RX_DEF_FMT;
+
+	*src_fmt = *sink_fmt;
+
+	return 0;
+}
+
+static int visconti_viif_csi2rx_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *sd_state,
+					struct v4l2_subdev_format *fmt)
+{
+	struct csi2rx_subdev *csi2rx = to_csi2rx_subdev(sd);
+
+	mutex_lock(&csi2rx->ops_lock);
+	fmt->format = *visconti_viif_csi2rx_get_pad_fmt(csi2rx, sd_state, fmt->pad, fmt->which);
+	mutex_unlock(&csi2rx->ops_lock);
+
+	return 0;
+}
+
+static int visconti_viif_csi2rx_set_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *sd_state,
+					struct v4l2_subdev_format *fmt)
+{
+	struct csi2rx_subdev *csi2rx = to_csi2rx_subdev(sd);
+	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
+
+	if (fmt->pad == VIIF_CSI2RX_PAD_SRC)
+		return visconti_viif_csi2rx_get_fmt(sd, sd_state, fmt);
+
+	mutex_lock(&csi2rx->ops_lock);
+
+	sink_fmt = visconti_viif_csi2rx_get_pad_fmt(csi2rx, sd_state, VIIF_CSI2RX_PAD_SINK,
+						    fmt->which);
+
+	sink_fmt->code = viif_mbus_format_from_code(fmt->format.code) ? fmt->format.code :
+									      VIIF_CSI2RX_DEF_FMT;
+	sink_fmt->width = clamp_t(u32, fmt->format.width, VIIF_ISP_MIN_WIDTH, VIIF_ISP_MAX_WIDTH);
+	sink_fmt->height =
+		clamp_t(u32, fmt->format.height, VIIF_ISP_MIN_HEIGHT, VIIF_ISP_MAX_HEIGHT);
+
+	fmt->format = *sink_fmt;
+
+	/* sourcep pad should have the same format */
+	src_fmt =
+		visconti_viif_csi2rx_get_pad_fmt(csi2rx, sd_state, VIIF_CSI2RX_PAD_SRC, fmt->which);
+	*src_fmt = *sink_fmt;
+
+	mutex_unlock(&csi2rx->ops_lock);
+
+	return 0;
+}
+
+static int visconti_viif_csi2rx_s_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct csi2rx_subdev *csi2rx = to_csi2rx_subdev(sd);
+	struct viif_device *viif_dev = csi2rx->viif_dev;
+	struct v4l2_subdev *sensor_sd = viif_dev->sensor_sd;
+	int ret;
+
+	if (!sensor_sd)
+		return -EINVAL;
+
+	/* disabling: turn off sensor -> turn off CSI2RX */
+	if (!enable) {
+		v4l2_subdev_call(sensor_sd, video, s_stream, false);
+		return viif_csi2rx_stop(viif_dev);
+	}
+
+	/* enabling: turn on CSI2RX -> turn on sensor -> (error handling) */
+	ret = viif_csi2rx_start(viif_dev);
+	if (ret)
+		return ret;
+
+	ret = v4l2_subdev_call(sensor_sd, video, s_stream, true);
+	if (ret) {
+		viif_csi2rx_stop(viif_dev);
+		return ret;
+	}
+	return 0;
+}
+
+/* ----- register/remove csi2rx subdevice node ----- */
+static const struct media_entity_operations visconti_viif_csi2rx_media_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+static const struct v4l2_subdev_video_ops visconti_viif_csi2rx_video_ops = {
+	.s_stream = visconti_viif_csi2rx_s_stream,
+};
+
+static const struct v4l2_subdev_pad_ops visconti_viif_csi2rx_pad_ops = {
+	.enum_mbus_code = visconti_viif_csi2rx_enum_mbus_code,
+	.init_cfg = visconti_viif_csi2rx_init_config,
+	.get_fmt = visconti_viif_csi2rx_get_fmt,
+	.set_fmt = visconti_viif_csi2rx_set_fmt,
+};
+
+static const struct v4l2_subdev_ops visconti_viif_csi2rx_ops = {
+	.video = &visconti_viif_csi2rx_video_ops,
+	.pad = &visconti_viif_csi2rx_pad_ops,
+};
+
+int visconti_viif_csi2rx_register(struct viif_device *viif_dev)
+{
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->csi2rx_subdev.pad_cfg,
+	};
+	struct media_pad *pads = viif_dev->csi2rx_subdev.pads;
+	struct v4l2_subdev *sd = &viif_dev->csi2rx_subdev.sd;
+	int ret;
+
+	viif_dev->csi2rx_subdev.viif_dev = viif_dev;
+
+	v4l2_subdev_init(sd, &visconti_viif_csi2rx_ops);
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->entity.ops = &visconti_viif_csi2rx_media_ops;
+	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
+	sd->owner = THIS_MODULE;
+	strscpy(sd->name, "visconti-viif:csi2rx", sizeof(sd->name));
+
+	pads[VIIF_CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
+	pads[VIIF_CSI2RX_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
+
+	mutex_init(&viif_dev->csi2rx_subdev.ops_lock);
+
+	ret = media_entity_pads_init(&sd->entity, VIIF_CSI2RX_PAD_NUM, pads);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed on media_entity_pads_init\n");
+		return ret;
+	}
+
+	ret = v4l2_device_register_subdev(&viif_dev->v4l2_dev, sd);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to register CSI2RX subdev\n");
+		goto err_cleanup_media_entity;
+	}
+
+	visconti_viif_csi2rx_init_config(sd, &state);
+
+	return 0;
+
+err_cleanup_media_entity:
+	media_entity_cleanup(&sd->entity);
+	mutex_destroy(&viif_dev->csi2rx_subdev.ops_lock);
+	viif_dev->csi2rx_subdev.viif_dev = NULL;
+	return ret;
+}
+
+void visconti_viif_csi2rx_unregister(struct viif_device *viif_dev)
+{
+	v4l2_device_unregister_subdev(&viif_dev->csi2rx_subdev.sd);
+	media_entity_cleanup(&viif_dev->csi2rx_subdev.sd.entity);
+}
diff --git a/drivers/media/platform/toshiba/visconti/viif_csi2rx.h b/drivers/media/platform/toshiba/visconti/viif_csi2rx.h
new file mode 100644
index 000000000000..07dd70d72924
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif_csi2rx.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef VIIF_CSI2RX_H
+#define VIIF_CSI2RX_H
+
+struct viif_device;
+struct viif_csi2rx_dphy_calibration_status;
+
+int visconti_viif_csi2rx_get_calibration_status(
+	struct viif_device *viif_dev,
+	struct viif_csi2rx_dphy_calibration_status *calibration_status);
+int visconti_viif_csi2rx_get_err_status(struct viif_device *viif_dev,
+					struct viif_csi2rx_err_status *csi_err);
+u32 visconti_viif_csi2rx_err_irq_handler(struct viif_device *viif_dev);
+
+int visconti_viif_csi2rx_register(struct viif_device *viif_dev);
+void visconti_viif_csi2rx_unregister(struct viif_device *viif_dev);
+
+#endif /* VIIF_CSI2RX_H */
diff --git a/drivers/media/platform/toshiba/visconti/viif_csi2rx_regs.h b/drivers/media/platform/toshiba/visconti/viif_csi2rx_regs.h
new file mode 100644
index 000000000000..d3865d4f7a2a
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif_csi2rx_regs.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture register definitions
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef VIIF_CSI2RX_REGS_H
+#define VIIF_CSI2RX_REGS_H
+
+/*=============================================*/
+/* CSI2HOST registers */
+/*=============================================*/
+#define REG_CSI2RX_NLANES	 0x4
+#define REG_CSI2RX_PHY_SHUTDOWNZ 0x40
+#define REG_CSI2RX_PHY_RSTZ	 0x44
+
+/* access to dphy external registers */
+#define REG_CSI2RX_PHY_TESTCTRL0 0x50
+#define BIT_TESTCTRL0_CLK_0	 0
+#define BIT_TESTCTRL0_CLK_1	 BIT(1)
+
+#define REG_CSI2RX_PHY_TESTCTRL1 0x54
+#define BIT_TESTCTRL1_ADDR	 BIT(16)
+#define MASK_TESTCTRL1_DIN	 0xFF
+#define MASK_TESTCTRL1_DOUT	 0xFF00
+
+#define REG_CSI2RX_INT_ST_PHY_FATAL  0xE0
+#define REG_CSI2RX_INT_MSK_PHY_FATAL 0xE4
+#define MASK_PHY_FATAL_ALL	     0x0000000F
+
+#define REG_CSI2RX_INT_ST_PKT_FATAL  0xF0
+#define REG_CSI2RX_INT_MSK_PKT_FATAL 0xF4
+#define MASK_PKT_FATAL_ALL	     0x0001000F
+
+#define REG_CSI2RX_INT_ST_FRAME_FATAL  0x100
+#define REG_CSI2RX_INT_MSK_FRAME_FATAL 0x104
+#define MASK_FRAME_FATAL_ALL	       0x000F0F0F
+
+#define REG_CSI2RX_INT_ST_PHY  0x110
+#define REG_CSI2RX_INT_MSK_PHY 0x114
+#define MASK_PHY_ERROR_ALL     0x000F000F
+
+#define REG_CSI2RX_INT_ST_PKT  0x120
+#define REG_CSI2RX_INT_MSK_PKT 0x124
+#define MASK_PKT_ERROR_ALL     0x000F000F
+
+#define REG_CSI2RX_INT_ST_LINE	0x130
+#define REG_CSI2RX_INT_MSK_LINE 0x134
+#define MASK_LINE_ERROR_ALL	0x00FF00FF
+
+/*=============================================*/
+/* DPHY register space */
+/*=============================================*/
+enum dphy_testcode {
+	DIG_TESTCODE_EXT = 0,
+	DIG_SYS_0 = 0x001,
+	DIG_SYS_1 = 0x002,
+	DIG_SYS_3 = 0x004,
+	DIG_SYS_7 = 0x008,
+	DIG_RX_STARTUP_OVR_2 = 0x0E2,
+	DIG_RX_STARTUP_OVR_3 = 0x0E3,
+	DIG_RX_STARTUP_OVR_4 = 0x0E4,
+	DIG_RX_STARTUP_OVR_5 = 0x0E5,
+	DIG_CB_2 = 0x1AC,
+	DIG_TERM_CAL_0 = 0x220,
+	DIG_TERM_CAL_1 = 0x221,
+	DIG_TERM_CAL_2 = 0x222,
+	DIG_CLKLANE_LANE_6 = 0x307,
+	DIG_CLKLANE_OFFSET_CAL_0 = 0x39D,
+	DIG_LANE0_OFFSET_CAL_0 = 0x59F,
+	DIG_LANE0_DDL_0 = 0x5E0,
+	DIG_LANE1_OFFSET_CAL_0 = 0x79F,
+	DIG_LANE1_DDL_0 = 0x7E0,
+	DIG_LANE2_OFFSET_CAL_0 = 0x99F,
+	DIG_LANE2_DDL_0 = 0x9E0,
+	DIG_LANE3_OFFSET_CAL_0 = 0xB9F,
+	DIG_LANE3_DDL_0 = 0xBE0,
+};
+
+#define SYS_0_HSFREQRANGE_OVR  BIT(5)
+#define SYS_3_NO_REXT	       BIT(4)
+#define SYS_7_RESERVED	       FIELD_PREP(0x1F, 0x0C)
+#define SYS_7_DESKEW_POL       BIT(5)
+#define STARTUP_OVR_4_CNTVAL   FIELD_PREP(0x70, 0x01)
+#define STARTUP_OVR_4_DDL_EN   BIT(0)
+#define STARTUP_OVR_5_BYPASS   BIT(0)
+#define CB_2_LPRX_BIAS	       BIT(6)
+#define CB_2_RESERVED	       FIELD_PREP(0x3F, 0x0B)
+#define CLKLANE_RXHS_PULL_LONG BIT(7)
+
+/* bit mask for calibration result registers */
+#define MASK_TERM_CAL_ERR  0
+#define MASK_TERM_CAL_DONE BIT(7)
+#define MASK_CLK_CAL_ERR   BIT(4)
+#define MASK_CLK_CAL_DONE  BIT(0)
+#define MASK_CAL_ERR	   BIT(2)
+#define MASK_CAL_DONE	   BIT(1)
+#define MASK_DDL_ERR	   BIT(1)
+#define MASK_DDL_DONE	   BIT(2)
+
+#endif /* VIIF_CSI2RX_REGS_H */
diff --git a/drivers/media/platform/toshiba/visconti/viif_isp.c b/drivers/media/platform/toshiba/visconti/viif_isp.c
new file mode 100644
index 000000000000..7a440da0f021
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif_isp.c
@@ -0,0 +1,1264 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <media/mipi-csi2.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-subdev.h>
+
+#include "viif.h"
+#include "viif_common.h"
+#include "viif_isp.h"
+#include "viif_regs.h"
+
+/* disable CSI2 capture at viif_mux_start() */
+#define VIIF_CSI2_NOT_CAPTURE -1
+
+/* minimum crop width and height */
+#define VIIF_CROP_MIN_W 128U
+#define VIIF_CROP_MIN_H 128U
+
+/* up to 2 ROIs are available to be passed to POSTs */
+/* set ROI_NONE for a POST currently not running */
+#define VIIF_L2_ROI_MAX_NUM 2U
+#define VIIF_L2_ROI_NONE    3U
+
+/* validation at main_set_unit() and sub_set_unit() */
+/* picture size: [unit: pixel] */
+#define VIIF_MIN_HTOTAL_PIXEL 143U
+#define VIIF_MAX_HTOTAL_PIXEL 65535U
+
+/* pixel clock: [unit: kHz] */
+#define VIIF_MIN_PIXEL_CLOCK 3375U
+#define VIIF_MAX_PIXEL_CLOCK 600000U
+
+/* horizontal back porch size: [unit: system clock ticks] */
+#define VIIF_HBP_SYSCLK 10U
+
+/* num of pictures accepted by the ISP */
+#define VIIF_L1_INPUT_NUM_MIN 1U
+#define VIIF_L1_INPUT_NUM_MAX 3U
+
+/* active picture size: [unit: pixel] */
+#define VIIF_MIN_HACTIVE_PIXEL_W_L1ISP	640U
+#define VIIF_MAX_HACTIVE_PIXEL_W_L1ISP	3840U
+#define VIIF_MIN_HACTIVE_PIXEL_WO_L1ISP 128U
+#define VIIF_MAX_HACTIVE_PIXEL_WO_L1ISP 4096U
+
+/* picture vertical size: [unit: line] */
+#define VIIF_MIN_VTOTAL_LINE	       144U
+#define VIIF_MAX_VTOTAL_LINE	       16383U
+#define VIIF_MIN_VBP_LINE	       5U
+#define VIIF_MAX_VBP_LINE	       4095U
+#define VIIF_MIN_VACTIVE_LINE_WO_L1ISP 128U
+#define VIIF_MAX_VACTIVE_LINE_WO_L1ISP 2160U
+#define VIIF_MIN_VACTIVE_LINE_W_L1ISP  480U
+#define VIIF_MAX_VACTIVE_LINE_W_L1ISP  2160U
+
+/* internal operation latencies: [unit: system clock ticks]*/
+#define VIIF_TABLE_LOAD_TIME	24000UL
+#define VIIF_REGBUF_ACCESS_TIME 15360UL
+
+/* offset of Vsync delay: [unit: line] */
+#define VIIF_L1_DELAY_W_HDRC  31U
+#define VIIF_L1_DELAY_WO_HDRC 11U
+
+/* timeout definitions for viif_stop_mux() */
+/*
+ * wait time for force abort to complete (max 1line time = 1228.8 us)
+ * when width = 4096, RAW24, 80Mbps
+ */
+#define VIIF_WAIT_ABORT_COMPLETE_TIME 1229U
+
+/*
+ * complete time of register buffer transfer.
+ * actual time is about 30us in case of L1ISP
+ */
+#define VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME 39U
+
+/* default parameters for V4L2 subdevice node */
+#define VISCONTI_VIIF_ISP_DEFAULT_WIDTH	  1920
+#define VISCONTI_VIIF_ISP_DEFAULT_HEIGHT  1080
+#define VISCONTI_VIIF_MAX_COMPOSED_WIDTH  8190
+#define VISCONTI_VIIF_MAX_COMPOSED_HEIGHT 4094
+
+/**
+ * struct viif_input_img - input image information
+ * @pixel_clock: pixel clock [unit: kHz]. Range: [3375..600000]
+ * @htotal_size: horizontal total size [unit: pixel]. Range: [143..65535]
+ * @hactive_size: horizontal active size [unit: pixel]
+ * * Range (w/o L1ISP): [128..4096] (multiple of 2)
+ * * Range (with L1ISP): [640..3840] (multiple of 8)
+ * * Range (SUB path): 0
+ * @vtotal_size: vertical total size [unit: line].
+ * * Range: [144..16383]
+ * @vbp_size: vertical back porch size.
+ * * Range: [5..4095]
+ * @vactive_size: vertical active size [unit: line].
+ * * Range (w/o L1ISP) [128..2160] (multiple of 2)
+ * * Range (with L1ISP) [480..2160] (multiple of 2)
+ * @input_num: the number of input images. Range: [1..3]
+ * * Range (w/o L1ISP): 1
+ * * Range (with L1ISP): [1..3]
+ * * Range (SUB path): 1
+ * @hobc_width: the number of horizontal optical black pixels.
+ * * Range (w/o L1ISP): 0
+ * * Range (with L1ISP):  [0,16,32,64 or 128]
+ *   * should be 0 when hobc_margin = 0
+ * * Range (SUB path): 0
+ * @hobc_margin: the number of horizontal optical black margin.
+ * * Range (w/o L1ISP): 0
+ * * Range (with L1ISP): [0..30] (even number)
+ +   * should be 0 when hobc_width = 0
+ * * Range (SUB path): 0
+ *
+ * Constraints between parameters:
+ *
+ * * (htotal_size > (hactive_size + hobc_width + hobc_margin))
+ * * (vtotal_size > (vbp_size + vactive_size * input_num))
+ * * w/o L1ISP:
+ *   * vbp_size >= (39360[cycle] / 500000[kHz]) * (pixel_clock / htotal_size) + 16 + ISST time
+ * * with L1ISP:
+ *   * vbp_size >= (54720[cycle] / 500000[kHz]) * (pixel_clock / htotal_size) + 38 + ISST time
+ *
+ * Note: L1ISP is used when RAW data is input to MAIN unit
+ */
+struct viif_input_img {
+	u32 pixel_clock;
+	u32 htotal_size;
+	u32 hactive_size;
+	u32 vtotal_size;
+	u32 vbp_size;
+	u32 vactive_size;
+	u32 input_num;
+	u32 hobc_width;
+	u32 hobc_margin;
+};
+
+/*=============================================*/
+/* Low Layer Implementation */
+/*=============================================*/
+/* Convert the unit of time-period (from sysclk, to num lines in the image) */
+static u32 sysclk_to_numlines(u32 time_in_sysclk, const struct viif_input_img *img)
+{
+	u64 v1 = (u64)time_in_sysclk * img->pixel_clock;
+	u64 v2 = (u64)img->htotal_size * VIIF_SYS_CLK;
+
+	return div64_u64(v1, v2);
+}
+
+static u32 lineperiod_in_sysclk(u32 hsize, u32 pixel_clock)
+{
+	return div64_u64((u64)hsize * VIIF_SYS_CLK, pixel_clock);
+}
+
+/* Set ROI path condition when ROI num is 2 */
+static void viif_l2_set_roi_num_2(struct viif_device *viif_dev)
+{
+	struct viif_l2_roi_path_info *info = &viif_dev->l2_roi_path_info;
+	u32 i;
+
+	for (i = 0; i < VIIF_L2_ROI_MAX_NUM; i++) {
+		/* ROI-n is the same as CROP area of POST-n */
+		if (info->post_enable_flag[i]) {
+			viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_OFS_H(i),
+					   info->post_crop_x[i]);
+			viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_OFS_V(i),
+					   info->post_crop_y[i]);
+			viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_HSIZE(i),
+					   info->post_crop_w[i]);
+			viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_VSIZE(i),
+					   info->post_crop_h[i]);
+			viif_capture_write(viif_dev, REG_L2_ROI_TO_POST(i), i);
+		} else {
+			viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_OFS_H(i), 0);
+			viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_OFS_V(i), 0);
+			viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_HSIZE(i), VIIF_CROP_MIN_W);
+			viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_VSIZE(i), VIIF_CROP_MIN_H);
+			viif_capture_write(viif_dev, REG_L2_ROI_TO_POST(i), VIIF_L2_ROI_NONE);
+		}
+	}
+}
+
+/* Set ROI path condition when ROI num is 1 */
+static void viif_l2_set_roi_num_1(struct viif_device *viif_dev)
+{
+	struct viif_l2_roi_path_info *info = &viif_dev->l2_roi_path_info;
+	u32 val, x_min, x_max, y_min, y_max;
+	u32 i, x, y, w, h;
+
+	/* ROI0 is input to POST0 and POST1 */
+	if (info->post_enable_flag[0]) {
+		/* POST0 is enabled */
+		x_min = info->post_crop_x[0];
+		x_max = info->post_crop_x[0] + info->post_crop_w[0];
+		y_min = info->post_crop_y[0];
+		y_max = info->post_crop_y[0] + info->post_crop_h[0];
+		if (info->post_enable_flag[1]) {
+			/* POST1 is enabled */
+			x_min = min(x_min, info->post_crop_x[1]);
+			val = info->post_crop_x[1] + info->post_crop_w[1];
+			x_max = max(x_max, val);
+			y_min = min(y_min, info->post_crop_y[1]);
+			val = info->post_crop_y[1] + info->post_crop_h[1];
+			y_max = max(y_max, val);
+		}
+		x = x_min;
+		y = y_min;
+		w = x_max - x_min;
+		h = y_max - y_min;
+	} else if (info->post_enable_flag[1]) {
+		/* POST0 is disabled and POST1 is enabled */
+		x = info->post_crop_x[1];
+		w = info->post_crop_w[1];
+		y = info->post_crop_y[1];
+		h = info->post_crop_h[1];
+	} else {
+		/* All POSTs are disabled */
+		x = 0;
+		y = 0;
+		w = VIIF_CROP_MIN_W;
+		h = VIIF_CROP_MIN_H;
+	}
+	viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_OFS_H(0), x);
+	viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_OFS_V(0), y);
+	viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_HSIZE(0), w);
+	viif_capture_write(viif_dev, REG_L2_ROI_X_OUT_VSIZE(0), h);
+
+	for (i = 0; i < VIIF_MAX_POST_NUM; i++)
+		viif_capture_write(viif_dev, REG_L2_ROI_TO_POST(i),
+				   info->post_enable_flag[i] ? 0 : VIIF_L2_ROI_NONE);
+}
+
+/* Set ROI path condition */
+void visconti_viif_l2_set_roi_path(struct viif_device *viif_dev)
+{
+	if (viif_dev->l2_roi_path_info.roi_num == 1U)
+		viif_l2_set_roi_num_1(viif_dev);
+	else
+		viif_l2_set_roi_num_2(viif_dev);
+}
+
+/* Set ROI parameters of L2ISP */
+void visconti_viif_l2_set_roi(struct viif_device *viif_dev, const struct viif_l2_roi_config *param)
+{
+	u32 val;
+	int i;
+
+	/* Set the number of ROI and update resource info with roi_num */
+	viif_capture_write(viif_dev, REG_L2_ROI_NUM, param->roi_num);
+	viif_dev->l2_roi_path_info.roi_num = param->roi_num;
+
+	/* Update ROI area and input to each POST */
+	visconti_viif_l2_set_roi_path(viif_dev);
+
+	/* Set the remaining parameters */
+	for (i = 0; i < 2; i++) {
+		viif_capture_write(viif_dev, REG_L2_ROI_X_SCALE(i), param->roi_scale[i]);
+		viif_capture_write(viif_dev, REG_L2_ROI_X_SCALE_INV(i), param->roi_scale_inv[i]);
+		val = (param->corrected_wo_scale_hsize[i] << 13U) | param->corrected_hsize[i];
+		viif_capture_write(viif_dev, REG_L2_ROI_X_CORRECTED_HSIZE(i), val);
+		val = (param->corrected_wo_scale_vsize[i] << 12U) | param->corrected_vsize[i];
+		viif_capture_write(viif_dev, REG_L2_ROI_X_CORRECTED_VSIZE(i), val);
+	}
+}
+
+/**
+ * viif_main_set_unit() - Set static configuration of MAIN unit(CH0 or CH1)
+ *
+ * @viif_dev: the VIIF device
+ * @data_type: DT of image; either of
+ *     YUV422_8B, YUV422_10B, RGB565, RGB888, RAW8, RAW10, RAW12, RAW14
+ * @in_img: Pointer to input image information
+ * @rawpack: RAW pack mode. For more refer @ref hwd_viif_raw_pack_mode
+ * @yuv_interp: true to use interpolation for YUV422 to YUV444 conversion.
+ * Return: 0 for success, -EINVAL for parameter error
+ */
+static int viif_main_set_unit(struct viif_device *viif_dev, u32 data_type,
+			      const struct viif_input_img *in_img, u32 rawpack, bool yuv_interp)
+{
+	u32 total_hact_size = 0U, total_vact_size = 0U;
+	u32 sw_delay0, sw_delay1, hw_delay;
+	u32 val, color, sysclk_num;
+	u32 i;
+
+	if (!in_img)
+		return -EINVAL;
+	if (rawpack != VIIF_RAWPACK_DISABLE && rawpack != VIIF_RAWPACK_MSBFIRST &&
+	    rawpack != VIIF_RAWPACK_LSBFIRST) {
+		return -EINVAL;
+	}
+	if (data_type != MIPI_CSI2_DT_RAW8 && data_type != MIPI_CSI2_DT_RAW10 &&
+	    data_type != MIPI_CSI2_DT_RAW12 && rawpack != VIIF_RAWPACK_DISABLE) {
+		return -EINVAL;
+	}
+
+	if (in_img->pixel_clock < VIIF_MIN_PIXEL_CLOCK ||
+	    in_img->pixel_clock > VIIF_MAX_PIXEL_CLOCK ||
+	    in_img->htotal_size < VIIF_MIN_HTOTAL_PIXEL ||
+	    in_img->htotal_size > VIIF_MAX_HTOTAL_PIXEL ||
+	    in_img->vtotal_size < VIIF_MIN_VTOTAL_LINE ||
+	    in_img->vtotal_size > VIIF_MAX_VTOTAL_LINE || in_img->vbp_size < VIIF_MIN_VBP_LINE ||
+	    in_img->vbp_size > VIIF_MAX_VBP_LINE || (in_img->hactive_size % 2U) ||
+	    (in_img->vactive_size % 2U)) {
+		return -EINVAL;
+	}
+
+	if (in_img->input_num < VIIF_L1_INPUT_NUM_MIN ||
+	    in_img->input_num > VIIF_L1_INPUT_NUM_MAX) {
+		return -EINVAL;
+	}
+
+	if (in_img->hobc_width != 0U && in_img->hobc_width != 16U && in_img->hobc_width != 32U &&
+	    in_img->hobc_width != 64U && in_img->hobc_width != 128U) {
+		return -EINVAL;
+	}
+
+	if (in_img->hobc_margin > 30U || (in_img->hobc_margin % 2U))
+		return -EINVAL;
+
+	if (!in_img->hobc_width && in_img->hobc_margin)
+		return -EINVAL;
+
+	if (in_img->hobc_width && !in_img->hobc_margin)
+		return -EINVAL;
+
+	if (data_type == MIPI_CSI2_DT_RAW8 || data_type == MIPI_CSI2_DT_RAW10 ||
+	    data_type == MIPI_CSI2_DT_RAW12 || data_type == MIPI_CSI2_DT_RAW14) {
+		/* parameter check in case of L1ISP(in case of RAW) */
+		if (in_img->hactive_size < VIIF_MIN_HACTIVE_PIXEL_W_L1ISP ||
+		    in_img->hactive_size > VIIF_MAX_HACTIVE_PIXEL_W_L1ISP ||
+		    in_img->vactive_size < VIIF_MIN_VACTIVE_LINE_W_L1ISP ||
+		    in_img->vactive_size > VIIF_MAX_VACTIVE_LINE_W_L1ISP ||
+		    (in_img->hactive_size % 8U)) {
+			return -EINVAL;
+		}
+
+		/* check vbp range in case of L1ISP on */
+		/* the constant value "7" is configuration margin */
+		val = sysclk_to_numlines(VIIF_TABLE_LOAD_TIME + VIIF_REGBUF_ACCESS_TIME * 2U,
+					 in_img) +
+		      VIIF_L1_DELAY_W_HDRC + 7U;
+		if (in_img->vbp_size < val)
+			return -EINVAL;
+
+		/* calculate total of horizontal active size and vertical active size */
+		if (rawpack != VIIF_RAWPACK_DISABLE) {
+			val = (in_img->hactive_size + in_img->hobc_width + in_img->hobc_margin) *
+			      2U;
+		} else {
+			val = in_img->hactive_size + in_img->hobc_width + in_img->hobc_margin;
+		}
+
+		total_hact_size = val;
+		total_vact_size = in_img->vactive_size * in_img->input_num;
+	} else {
+		/* OTHER input than RAW(L1ISP is off) */
+		if (in_img->hactive_size < VIIF_MIN_HACTIVE_PIXEL_WO_L1ISP ||
+		    in_img->hactive_size > VIIF_MAX_HACTIVE_PIXEL_WO_L1ISP ||
+		    in_img->vactive_size < VIIF_MIN_VACTIVE_LINE_WO_L1ISP ||
+		    in_img->vactive_size > VIIF_MAX_VACTIVE_LINE_WO_L1ISP ||
+		    in_img->input_num != 1 || in_img->hobc_width) {
+			return -EINVAL;
+		}
+
+		/* check vbp range in case of L1ISP off */
+		/* the constant value "16" is configuration margin */
+		val = sysclk_to_numlines(VIIF_TABLE_LOAD_TIME + VIIF_REGBUF_ACCESS_TIME, in_img) +
+		      16U;
+		if (in_img->vbp_size < val)
+			return -EINVAL;
+
+		total_hact_size = in_img->hactive_size;
+		total_vact_size = in_img->vactive_size;
+	}
+
+	if (in_img->htotal_size <= total_hact_size ||
+	    (in_img->vtotal_size <= (in_img->vbp_size + total_vact_size))) {
+		return -EINVAL;
+	}
+
+	/* Set DT and color type of image data */
+	viif_capture_write(viif_dev, REG_IPORTM_MAIN_DT, (data_type << 8U) | data_type);
+	viif_capture_write(viif_dev, REG_IPORTM_OTHER, 0x00);
+
+	/* Set back porch*/
+	viif_capture_write(viif_dev, REG_BACK_PORCH_M, (in_img->vbp_size << 16U) | VIIF_HBP_SYSCLK);
+
+	/* single pulse of vsync is input to DPGM */
+	viif_capture_write(viif_dev, REG_DPGM_VSYNC_SOURCE, VAL_DPGM_VSYNC_PULSE);
+
+	/* set preprocess type before L2ISP based on color_type. */
+	if (data_type == MIPI_CSI2_DT_YUV422_8B || data_type == MIPI_CSI2_DT_YUV422_10B) {
+		color = VAL_PREPROCCESS_FMT_YUV422;
+	} else if (data_type == MIPI_CSI2_DT_RGB565 || data_type == MIPI_CSI2_DT_RGB888) {
+		color = VAL_PREPROCCESS_FMT_RGB;
+	} else {
+		/* RGB or YUV444 from L1ISP */
+		color = VAL_PREPROCCESS_FMT_YUV444;
+	}
+	viif_capture_write(viif_dev, REG_PREPROCCESS_FMTM, color);
+
+	/* set Total size and valid size information of image data */
+	sysclk_num = lineperiod_in_sysclk(in_img->htotal_size, in_img->pixel_clock);
+	sysclk_num &= GENMASK(15, 0);
+	viif_capture_write(viif_dev, REG_TOTALSIZE_M, (in_img->vtotal_size << 16U) | sysclk_num);
+	viif_capture_write(viif_dev, REG_VALSIZE_M, (total_vact_size << 16U) | total_hact_size);
+
+	/* set image size information to L2ISP */
+	viif_capture_write(viif_dev, REG_L2_SENSOR_CROP_VSIZE, in_img->vactive_size);
+	viif_capture_write(viif_dev, REG_L2_SENSOR_CROP_HSIZE, in_img->hactive_size);
+
+	/* RAW input case */
+	if (data_type >= MIPI_CSI2_DT_RAW8) {
+		/* interpolaton mode = by LINE */
+		viif_capture_write(viif_dev, REG_L1_IBUF_INPUT_ORDER, in_img->input_num);
+		viif_capture_write(viif_dev, REG_L1_SYSM_HEIGHT, in_img->vactive_size);
+		viif_capture_write(viif_dev, REG_L1_SYSM_WIDTH, in_img->hactive_size);
+		val = (in_img->hobc_margin << 8U) | in_img->hobc_width;
+		viif_capture_write(viif_dev, REG_L1_HOBC_MARGIN, val);
+	}
+
+	/* Set rawpack */
+	viif_capture_write(viif_dev, REG_IPORTM_MAIN_RAW, rawpack);
+
+	/* Set yuv_conv; only for VAL_PREPROCCESS_FMT_YUV422 */
+	viif_capture_write(viif_dev, REG_PREPROCCESS_C24M, yuv_interp ? 1 : 0);
+
+	/* Set vsync delay */
+	hw_delay = in_img->vbp_size - sysclk_to_numlines(VIIF_TABLE_LOAD_TIME, in_img) + 4U;
+	hw_delay = min(hw_delay, 255U);
+
+	sw_delay0 = hw_delay - sysclk_to_numlines(VIIF_REGBUF_ACCESS_TIME, in_img) + 2U;
+
+	if (data_type == MIPI_CSI2_DT_RAW8 || data_type == MIPI_CSI2_DT_RAW10 ||
+	    data_type == MIPI_CSI2_DT_RAW12 || data_type == MIPI_CSI2_DT_RAW14) {
+		sw_delay1 = sysclk_to_numlines(VIIF_REGBUF_ACCESS_TIME, in_img) +
+			    VIIF_L1_DELAY_WO_HDRC + 1U;
+	} else {
+		sw_delay1 = 10U;
+	}
+	viif_capture_write(viif_dev, REG_INT_M0_LINE, sw_delay0 << 16U);
+	viif_capture_write(viif_dev, REG_INT_M1_LINE, (sw_delay1 << 16U) | hw_delay);
+
+	/* M2_LINE is the same condition as M1_LINE */
+	viif_capture_write(viif_dev, REG_INT_M2_LINE, (sw_delay1 << 16U) | hw_delay);
+
+	/* hold pixel_clock, htotal_size for future use */
+	viif_dev->img_clk.pixel_clock = in_img->pixel_clock;
+	viif_dev->img_clk.htotal_size = in_img->htotal_size;
+
+	/* initialize crop information of POSTs */
+	viif_dev->l2_roi_path_info.roi_num = 0;
+	for (i = 0; i < VIIF_MAX_POST_NUM; i++) {
+		viif_dev->l2_roi_path_info.post_enable_flag[i] = false;
+		viif_dev->l2_roi_path_info.post_crop_x[i] = 0;
+		viif_dev->l2_roi_path_info.post_crop_y[i] = 0;
+		viif_dev->l2_roi_path_info.post_crop_w[i] = 0;
+		viif_dev->l2_roi_path_info.post_crop_h[i] = 0;
+	}
+
+	return 0;
+}
+
+/**
+ * viif_sub_set_unit() - Set static configuration of SUB unit
+ *
+ * @viif_dev: the VIIF device
+ * @dt_image: DT of image. Range: [0x1E, 0x1F, 0x22, 0x24, 0x2A-0x2D]
+ * @in_img: Pointer to input image information
+ * Return: 0 for success, -EINVAL for parameter error
+ */
+static int viif_sub_set_unit(struct viif_device *viif_dev, u32 dt_image,
+			     const struct viif_input_img *in_img)
+{
+	u32 sysclk_num, temp_delay;
+
+	if (dt_image < MIPI_CSI2_DT_RAW8 || dt_image > MIPI_CSI2_DT_RAW14)
+		return -EINVAL;
+
+	if (!in_img)
+		return -EINVAL;
+
+	if (in_img->hactive_size || in_img->input_num != 1 || in_img->hobc_width ||
+	    in_img->hobc_margin) {
+		return -EINVAL;
+	}
+
+	if (in_img->pixel_clock < VIIF_MIN_PIXEL_CLOCK ||
+	    in_img->pixel_clock > VIIF_MAX_PIXEL_CLOCK ||
+	    in_img->htotal_size < VIIF_MIN_HTOTAL_PIXEL ||
+	    in_img->htotal_size > VIIF_MAX_HTOTAL_PIXEL ||
+	    in_img->vtotal_size < VIIF_MIN_VTOTAL_LINE ||
+	    in_img->vtotal_size > VIIF_MAX_VTOTAL_LINE || in_img->vbp_size < VIIF_MIN_VBP_LINE ||
+	    in_img->vbp_size > VIIF_MAX_VBP_LINE ||
+	    in_img->vactive_size < VIIF_MIN_VACTIVE_LINE_WO_L1ISP ||
+	    in_img->vactive_size > VIIF_MAX_VACTIVE_LINE_WO_L1ISP || (in_img->vactive_size % 2U)) {
+		return -EINVAL;
+	}
+
+	if (in_img->vtotal_size <= (in_img->vbp_size + in_img->vactive_size))
+		return -EINVAL;
+
+	/* Set DT of image data and DT of long packet data*/
+	viif_capture_write(viif_dev, REG_IPORTS_MAIN_DT, dt_image);
+	viif_capture_write(viif_dev, REG_IPORTS_OTHER, 0x00);
+
+	/* Set line size and delay value of delayed Vsync */
+	sysclk_num = lineperiod_in_sysclk(in_img->htotal_size, in_img->pixel_clock);
+	viif_capture_write(viif_dev, REG_INT_SA0_LINE, sysclk_num & GENMASK(15, 0));
+	temp_delay = in_img->vbp_size - 4U;
+	if (temp_delay > 255U) {
+		/* Replace the value with HW max spec */
+		temp_delay = 255U;
+	}
+	viif_capture_write(viif_dev, REG_INT_SA1_LINE, temp_delay);
+
+	return 0;
+}
+
+/**
+ * viif_mux_start() - Setup CSI-2 input path
+ *
+ * @viif_dev: the VIIF device
+ * @vc_main: VCID (0, 1, 2, 3) to capture with Main unit; VIIF_CSI2_NOT_CAPTURE to disable.
+ * @vc_sub:  VCID (0, 1, 2, 3) to capture with Sub unit; VIIF_CSI2_NOT_CAPTURE to disable.
+ */
+static void viif_mux_start(struct viif_device *viif_dev, s32 vc_main, s32 vc_sub)
+{
+	bool en_vc0 = false, en_vc1 = false;
+
+	viif_capture_write(viif_dev, REG_IPORTM, VAL_IPORTM_INPUT_CSI2);
+
+	if (vc_main != VIIF_CSI2_NOT_CAPTURE) {
+		viif_capture_write(viif_dev, REG_VCID0SELECT, (u32)vc_main);
+		en_vc0 = true;
+	}
+	if (vc_sub != VIIF_CSI2_NOT_CAPTURE) {
+		viif_capture_write(viif_dev, REG_VCID1SELECT, (u32)vc_sub);
+		en_vc1 = true;
+	}
+
+	/* Control VC port enable */
+	viif_capture_write(viif_dev, REG_VCPORTEN,
+			   (en_vc0 ? MASK_VCPORTEN_EN_VC0 : 0) |
+				   (en_vc1 ? MASK_VCPORTEN_EN_VC1 : 0));
+
+	if (en_vc0) {
+		/* Update flag information for run status of MAIN unit */
+		viif_dev->run_flag_main = true;
+	}
+}
+
+/**
+ * viif_mux_stop() - Teardown CSI-2 input path
+ *
+ * @viif_dev: the VIIF device
+ * Return: 0 for success, -ETIMEDOUT for timeout error
+ */
+static int viif_mux_stop(struct viif_device *viif_dev)
+{
+	u64 timeout_ns, cur_ns;
+
+	/* Disable auto transmission of register buffer */
+	viif_capture_write(viif_dev, REG_L1_CRGBF_TRN_A_CONF, 0);
+	viif_capture_write(viif_dev, REG_L2_CRGBF_TRN_A_CONF, 0);
+
+	/* Wait for completion of register buffer transmission */
+	udelay(VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME);
+
+	/* Stop all VCs, long packet input and emb data input of MAIN unit */
+	viif_capture_write(viif_dev, REG_VCPORTEN, 0);
+	viif_capture_write(viif_dev, REG_IPORTM_OTHEREN, 0);
+	viif_capture_write(viif_dev, REG_IPORTM_EMBEN, 0);
+
+	/* Stop image data input, long packet input and emb data input of SUB unit */
+	viif_capture_write(viif_dev, REG_IPORTS_OTHEREN, 0);
+	viif_capture_write(viif_dev, REG_IPORTS_EMBEN, 0);
+	viif_capture_write(viif_dev, REG_IPORTS_IMGEN, 0);
+
+	/* Stop VDMAC for all table ports, input ports and write ports */
+	viif_capture_write(viif_dev, REG_VDM_T_ENABLE, 0);
+	viif_capture_write(viif_dev, REG_VDM_R_ENABLE, 0);
+	viif_capture_write(viif_dev, REG_VDM_W_ENABLE, 0);
+
+	/* Stop all groups(g00, g01 and g02) of VDMAC */
+	viif_capture_write(viif_dev, REG_VDM_ABORTSET, 0x7);
+
+	timeout_ns = ktime_get_ns() + VIIF_WAIT_ABORT_COMPLETE_TIME * 1000;
+
+	do {
+		u32 status_r, status_w, status_t, l2_status;
+
+		/* Get VDMAC transfer status  */
+		status_r = viif_capture_read(viif_dev, REG_VDM_R_RUN);
+		status_w = viif_capture_read(viif_dev, REG_VDM_W_RUN);
+		status_t = viif_capture_read(viif_dev, REG_VDM_T_RUN);
+		l2_status = viif_capture_read(viif_dev, REG_L2_BUS_L2_STATUS);
+
+		if (!status_r && !status_w && !status_t && !l2_status) {
+			viif_dev->run_flag_main = false;
+			return 0;
+		}
+
+		cur_ns = ktime_get_ns();
+	} while (timeout_ns > cur_ns);
+
+	return -ETIMEDOUT;
+}
+
+/*=============================================*/
+/* handling V4L2 framework */
+/*=============================================*/
+/* ----- supported MBUS formats ----- */
+static bool viif_get_mbus_rgb_out(unsigned int mbus_code)
+{
+	const struct viif_mbus_format *fmt;
+
+	fmt = viif_mbus_format_from_code(mbus_code);
+
+	return fmt ? fmt->rgb_out : false; /* YUV as default */
+}
+
+static bool viif_is_valid_mbus_code(unsigned int mbus_code)
+{
+	return viif_mbus_format_from_code(mbus_code) ? true : false;
+}
+
+/* ----- handling main processing path ----- */
+static int viif_get_dv_timings(struct viif_device *viif_dev, struct v4l2_dv_timings *timings,
+			       unsigned int *mbus_code)
+{
+	struct v4l2_subdev *sensor_sd = viif_dev->sensor_sd;
+	struct v4l2_subdev_state *state;
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad = 0,
+	};
+	struct v4l2_ctrl *ctrl;
+	int ret;
+
+	if (!sensor_sd)
+		return -EINVAL;
+
+	state = v4l2_subdev_lock_and_get_active_state(sensor_sd);
+	if (state) {
+		ret = v4l2_subdev_call(sensor_sd, pad, get_fmt, state, &format);
+		v4l2_subdev_unlock_state(state);
+	} else {
+		struct v4l2_subdev_pad_config pad_cfg;
+		struct v4l2_subdev_state pad_state = { .pads = &pad_cfg };
+
+		ret = v4l2_subdev_call(sensor_sd, pad, get_fmt, &pad_state, &format);
+	}
+	if (ret)
+		return ret;
+
+	/* some video I/F support dv_timings query */
+	ret = v4l2_subdev_call(sensor_sd, video, g_dv_timings, timings);
+	if (!ret) {
+		*mbus_code = format.format.code;
+		return 0;
+	}
+
+	/* others: call some discrete APIs */
+	timings->bt.width = format.format.width;
+	timings->bt.height = format.format.height;
+	*mbus_code = format.format.code;
+
+	ctrl = v4l2_ctrl_find(sensor_sd->ctrl_handler, V4L2_CID_HBLANK);
+	if (!ctrl) {
+		dev_err(viif_dev->dev, "subdev: V4L2_CID_VBLANK error.\n");
+		return -EINVAL;
+	}
+	timings->bt.hsync = v4l2_ctrl_g_ctrl(ctrl);
+
+	ctrl = v4l2_ctrl_find(sensor_sd->ctrl_handler, V4L2_CID_VBLANK);
+	if (!ctrl) {
+		dev_err(viif_dev->dev, "subdev: V4L2_CID_VBLANK error.\n");
+		return -EINVAL;
+	}
+	timings->bt.vsync = v4l2_ctrl_g_ctrl(ctrl);
+
+	ctrl = v4l2_ctrl_find(sensor_sd->ctrl_handler, V4L2_CID_PIXEL_RATE);
+	if (!ctrl) {
+		dev_err(viif_dev->dev, "subdev: V4L2_CID_PIXEL_RATE error.\n");
+		return -EINVAL;
+	}
+	timings->bt.pixelclock = v4l2_ctrl_g_ctrl_int64(ctrl);
+
+	return 0;
+}
+
+static unsigned int dt_image_from_mbus_code(unsigned int mbus_code)
+{
+	const struct viif_mbus_format *fmt;
+
+	fmt = viif_mbus_format_from_code(mbus_code);
+
+	return fmt ? fmt->mipi_dt : MIPI_CSI2_DT_RGB888;
+}
+
+int visconti_viif_isp_main_set_unit(struct viif_device *viif_dev)
+{
+	struct v4l2_subdev *sensor_sd = viif_dev->sensor_sd;
+	struct viif_input_img in_img_main = {};
+	struct v4l2_dv_timings timings = {};
+	unsigned int data_type, rawpack;
+	bool yuv_interp = false;
+	unsigned int mbus_code;
+	int mag_hactive = 1;
+	int ret = 0;
+
+	if (!sensor_sd)
+		return -EINVAL;
+
+	/* check controls */
+	viif_dev->isp_subdev.ctrl_rawpack_mode->ops->s_ctrl(viif_dev->isp_subdev.ctrl_rawpack_mode);
+	viif_dev->isp_subdev.ctrl_input_mode->ops->s_ctrl(viif_dev->isp_subdev.ctrl_input_mode);
+
+	ret = viif_get_dv_timings(viif_dev, &timings, &mbus_code);
+	if (ret) {
+		dev_err(viif_dev->dev, "could not get timing information of subdev");
+		return -EINVAL;
+	}
+
+	data_type = dt_image_from_mbus_code(mbus_code);
+
+	if (data_type == MIPI_CSI2_DT_RAW8 || data_type == MIPI_CSI2_DT_RAW10 ||
+	    data_type == MIPI_CSI2_DT_RAW12) {
+		rawpack = viif_dev->rawpack_mode;
+		if (rawpack != VIIF_RAWPACK_DISABLE)
+			mag_hactive = 2;
+	} else {
+		rawpack = VIIF_RAWPACK_DISABLE;
+	}
+
+	yuv_interp = (data_type == MIPI_CSI2_DT_YUV422_8B || data_type == MIPI_CSI2_DT_YUV422_10B);
+
+	in_img_main.hactive_size = timings.bt.width;
+	in_img_main.vactive_size = timings.bt.height;
+	in_img_main.htotal_size = timings.bt.width * mag_hactive + timings.bt.hsync;
+	in_img_main.vtotal_size = timings.bt.height + timings.bt.vsync;
+	in_img_main.pixel_clock = timings.bt.pixelclock / 1000;
+	in_img_main.vbp_size = timings.bt.vsync - 5;
+
+	in_img_main.input_num = 1;
+	in_img_main.hobc_width = 0;
+	in_img_main.hobc_margin = 0;
+
+	/* configuration of MAIN unit */
+	ret = viif_main_set_unit(viif_dev, data_type, &in_img_main, rawpack, yuv_interp);
+	if (ret) {
+		dev_err(viif_dev->dev, "main_set_unit error. %d\n", ret);
+		return ret;
+	}
+
+	/* Enable regbuf */
+	hwd_viif_isp_set_regbuf_auto_transmission(viif_dev);
+
+	/* L2 UNDIST Enable through mode as default  */
+	/* this function is implemented in the next patch */
+	/*
+	 * ret = visconti_viif_l2_undist_through(viif_dev);
+	 * if (ret)
+	 *	dev_err(viif_dev->dev, "l2_set_undist error. %d\n", ret);
+	 */
+	return ret;
+}
+
+int visconti_viif_isp_sub_set_unit(struct viif_device *viif_dev)
+{
+	struct v4l2_subdev *sensor_sd = viif_dev->sensor_sd;
+	struct viif_input_img in_img_sub;
+	struct v4l2_dv_timings timings;
+	unsigned int mbus_code;
+	unsigned int dt_image;
+	int ret;
+
+	if (!sensor_sd)
+		return -EINVAL;
+
+	ret = viif_get_dv_timings(viif_dev, &timings, &mbus_code);
+	if (ret)
+		return -EINVAL;
+
+	dt_image = dt_image_from_mbus_code(mbus_code);
+
+	in_img_sub.hactive_size = 0;
+	in_img_sub.vactive_size = timings.bt.height;
+	in_img_sub.htotal_size = timings.bt.width + timings.bt.hsync;
+	in_img_sub.vtotal_size = timings.bt.height + timings.bt.vsync;
+	in_img_sub.pixel_clock = timings.bt.pixelclock / 1000;
+	in_img_sub.vbp_size = timings.bt.vsync - 5;
+	in_img_sub.input_num = 1;
+	in_img_sub.hobc_width = 0;
+	in_img_sub.hobc_margin = 0;
+
+	ret = viif_sub_set_unit(viif_dev, dt_image, &in_img_sub);
+	if (ret)
+		dev_err(viif_dev->dev, "sub_set_unit error. %d\n", ret);
+
+	return ret;
+};
+
+/* ----- subdevice video operations ----- */
+static int visconti_viif_isp_s_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	int ret;
+
+	/* disabling: stop sensor, CSI2RX -> stop MUX, ISP */
+	if (!enable) {
+		v4l2_subdev_call(&viif_dev->csi2rx_subdev.sd, video, s_stream, false);
+		viif_mux_stop(viif_dev);
+		// stop ISP
+		return 0;
+	}
+
+	__v4l2_ctrl_handler_setup(&viif_dev->isp_subdev.ctrl_handler);
+
+	/* enabling: start ISP, MUX -> start CSI2RX, sensor */
+	// start ISP
+	viif_dev->masked_gamma_path = 0;
+	viif_mux_start(viif_dev, 0, 0);
+	ret = v4l2_subdev_call(&viif_dev->csi2rx_subdev.sd, video, s_stream, true);
+	if (ret)
+		viif_mux_stop(viif_dev);
+	return ret;
+}
+
+/* ----- subdevice pad operations ----- */
+static int visconti_viif_isp_enum_mbus_code(struct v4l2_subdev *sd,
+					    struct v4l2_subdev_state *sd_state,
+					    struct v4l2_subdev_mbus_code_enum *code)
+{
+	if (!code->pad) {
+		/* sink */
+		const struct viif_mbus_format *fmt;
+
+		fmt = viif_mbus_format_nth(code->index);
+		if (fmt) {
+			code->code = fmt->code;
+			return 0;
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	/* source */
+	if (code->index > 0)
+		return -EINVAL;
+	code->code = MEDIA_BUS_FMT_YUV8_1X24;
+	return 0;
+}
+
+static struct v4l2_mbus_framefmt *visconti_viif_isp_get_pad_fmt(struct v4l2_subdev *sd,
+								struct v4l2_subdev_state *sd_state,
+								unsigned int pad, u32 which)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state, pad);
+	else
+		return v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, &state, pad);
+}
+
+static struct v4l2_rect *visconti_viif_isp_get_pad_crop(struct v4l2_subdev *sd,
+							struct v4l2_subdev_state *sd_state,
+							unsigned int pad, u32 which)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, sd_state, pad);
+	else
+		return v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, &state, pad);
+}
+
+static struct v4l2_rect *visconti_viif_isp_get_pad_compose(struct v4l2_subdev *sd,
+							   struct v4l2_subdev_state *sd_state,
+							   unsigned int pad, u32 which)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, sd_state, pad);
+	else
+		return v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, &state, pad);
+}
+
+static int visconti_viif_isp_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *sd_state,
+				     struct v4l2_subdev_format *fmt)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+	fmt->format = *visconti_viif_isp_get_pad_fmt(sd, sd_state, fmt->pad, fmt->which);
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return 0;
+}
+
+static void visconti_viif_isp_set_sink_fmt(struct v4l2_subdev *sd,
+					   struct v4l2_subdev_state *sd_state,
+					   struct v4l2_mbus_framefmt *format, u32 which)
+{
+	struct v4l2_mbus_framefmt *sink_fmt, *src0_fmt, *src1_fmt, *src2_fmt;
+
+	sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK, which);
+	src0_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SRC_PATH0, which);
+	src1_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SRC_PATH1, which);
+	src2_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SRC_PATH2, which);
+
+	/* update mbus code only if it's available */
+	if (viif_is_valid_mbus_code(format->code))
+		sink_fmt->code = format->code;
+
+	/* sink::mbus_code is derived from src::mbus_code */
+	if (viif_get_mbus_rgb_out(sink_fmt->code)) {
+		src0_fmt->code = MEDIA_BUS_FMT_RGB888_1X24;
+		src1_fmt->code = MEDIA_BUS_FMT_RGB888_1X24;
+	} else {
+		src0_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+		src1_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+	}
+
+	/* SRC2 (RAW output) follows SINK format */
+	src2_fmt->code = format->code;
+	src2_fmt->width = format->width;
+	src2_fmt->height = format->height;
+
+	/* size check */
+	sink_fmt->width = format->width;
+	sink_fmt->height = format->height;
+
+	*format = *sink_fmt;
+}
+
+static void visconti_viif_isp_set_src_fmt(struct v4l2_subdev *sd,
+					  struct v4l2_subdev_state *sd_state,
+					  struct v4l2_mbus_framefmt *format, unsigned int pad,
+					  u32 which)
+{
+	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
+	struct v4l2_rect *src_crop;
+
+	sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK,
+						 V4L2_SUBDEV_FORMAT_ACTIVE);
+	src_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, pad, which);
+	src_crop = visconti_viif_isp_get_pad_crop(sd, sd_state, pad, which);
+
+	/* sink::mbus_code is derived from src::mbus_code */
+	if (viif_get_mbus_rgb_out(sink_fmt->code))
+		src_fmt->code = MEDIA_BUS_FMT_RGB888_1X24;
+	else
+		src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+
+	/*size check*/
+	src_fmt->width = format->width;
+	src_fmt->height = format->height;
+
+	/*update crop*/
+	src_crop->width = format->width;
+	src_crop->height = format->height;
+
+	*format = *src_fmt;
+}
+
+static void visconti_viif_isp_set_src_fmt_rawpath(struct v4l2_subdev *sd,
+						  struct v4l2_subdev_state *sd_state,
+						  struct v4l2_mbus_framefmt *format,
+						  unsigned int pad, u32 which)
+{
+	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
+
+	sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK,
+						 V4L2_SUBDEV_FORMAT_ACTIVE);
+	src_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, pad, which);
+
+	/* RAWPATH SRC pad has just the same configuration as SINK pad */
+	src_fmt->code = sink_fmt->code;
+	src_fmt->width = sink_fmt->width;
+	src_fmt->height = sink_fmt->height;
+
+	*format = *src_fmt;
+}
+
+static int visconti_viif_isp_set_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *sd_state,
+				     struct v4l2_subdev_format *fmt)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+
+	if (fmt->pad == VIIF_ISP_PAD_SINK)
+		visconti_viif_isp_set_sink_fmt(sd, sd_state, &fmt->format, fmt->which);
+	else if (fmt->pad == VIIF_ISP_PAD_SRC_PATH2)
+		visconti_viif_isp_set_src_fmt_rawpath(sd, sd_state, &fmt->format, fmt->pad,
+						      fmt->which);
+	else
+		visconti_viif_isp_set_src_fmt(sd, sd_state, &fmt->format, fmt->pad, fmt->which);
+
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return 0;
+}
+
+static int visconti_viif_isp_init_config(struct v4l2_subdev *sd, struct v4l2_subdev_state *sd_state)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
+	struct v4l2_rect *src_crop, *sink_compose;
+
+	sink_fmt =
+		v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state, VIIF_ISP_PAD_SINK);
+	sink_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	sink_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	sink_fmt->field = V4L2_FIELD_NONE;
+	sink_fmt->code = MEDIA_BUS_FMT_SRGGB10_1X10;
+
+	sink_compose =
+		v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, sd_state, VIIF_ISP_PAD_SINK);
+	sink_compose->top = 0;
+	sink_compose->left = 0;
+	sink_compose->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	sink_compose->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+
+	src_fmt = v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state,
+					     VIIF_ISP_PAD_SRC_PATH0);
+	src_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	src_fmt->field = V4L2_FIELD_NONE;
+	src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+
+	src_crop = v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, sd_state,
+					    VIIF_ISP_PAD_SRC_PATH0);
+	src_crop->top = 0;
+	src_crop->left = 0;
+	src_crop->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_crop->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+
+	src_fmt = v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state,
+					     VIIF_ISP_PAD_SRC_PATH1);
+	src_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	src_fmt->field = V4L2_FIELD_NONE;
+	src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+
+	src_crop = v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, sd_state,
+					    VIIF_ISP_PAD_SRC_PATH1);
+	src_crop->top = 0;
+	src_crop->left = 0;
+	src_crop->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_crop->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+
+	src_fmt = v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state,
+					     VIIF_ISP_PAD_SRC_PATH2);
+	src_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	src_fmt->field = V4L2_FIELD_NONE;
+	src_fmt->code = MEDIA_BUS_FMT_SRGGB10_1X10;
+
+	return 0;
+}
+
+static int visconti_viif_isp_get_selection(struct v4l2_subdev *sd,
+					   struct v4l2_subdev_state *sd_state,
+					   struct v4l2_subdev_selection *sel)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_mbus_framefmt *sink_fmt;
+	int ret = -EINVAL;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+	if (sel->pad == VIIF_ISP_PAD_SINK) {
+		/* SINK PAD */
+		switch (sel->target) {
+		case V4L2_SEL_TGT_CROP:
+			sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK,
+								 sel->which);
+			sel->r.top = 0;
+			sel->r.left = 0;
+			sel->r.width = sink_fmt->width;
+			sel->r.height = sink_fmt->height;
+			ret = 0;
+			break;
+		case V4L2_SEL_TGT_COMPOSE:
+			sel->r = *visconti_viif_isp_get_pad_compose(sd, sd_state, VIIF_ISP_PAD_SINK,
+								    sel->which);
+			ret = 0;
+			break;
+		case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+			/* fixed value */
+			sel->r.top = 0;
+			sel->r.left = 0;
+			sel->r.width = VISCONTI_VIIF_MAX_COMPOSED_WIDTH;
+			sel->r.height = VISCONTI_VIIF_MAX_COMPOSED_HEIGHT;
+			ret = 0;
+			break;
+		}
+	} else if ((sel->pad == VIIF_ISP_PAD_SRC_PATH0) || (sel->pad == VIIF_ISP_PAD_SRC_PATH1)) {
+		/* SRC PAD */
+		switch (sel->target) {
+		case V4L2_SEL_TGT_CROP:
+			sel->r =
+				*visconti_viif_isp_get_pad_crop(sd, sd_state, sel->pad, sel->which);
+			ret = 0;
+			break;
+		}
+	}
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return ret;
+}
+
+static int visconti_viif_isp_set_selection(struct v4l2_subdev *sd,
+					   struct v4l2_subdev_state *sd_state,
+					   struct v4l2_subdev_selection *sel)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_rect *rect, *rect_compose;
+	struct v4l2_mbus_framefmt *src_fmt;
+	int ret = -EINVAL;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+	/* only source::selection::crop is writable */
+	if (sel->pad == VIIF_ISP_PAD_SRC_PATH0 || sel->pad == VIIF_ISP_PAD_SRC_PATH1) {
+		switch (sel->target) {
+		case V4L2_SEL_TGT_CROP: {
+			/* check if new SRC::CROP is inside SINK::COMPOSE */
+			rect_compose = visconti_viif_isp_get_pad_compose(
+				sd, sd_state, VIIF_ISP_PAD_SINK, sel->which);
+			if (sel->r.top < rect_compose->top || sel->r.left < rect_compose->left ||
+			    (sel->r.top + sel->r.height) >
+				    (rect_compose->top + rect_compose->height) ||
+			    (sel->r.left + sel->r.width) >
+				    (rect_compose->left + rect_compose->width)) {
+				break;
+			}
+
+			rect = visconti_viif_isp_get_pad_crop(sd, sd_state, sel->pad, sel->which);
+			*rect = sel->r;
+
+			/* update SRC::FMT along with SRC::CROP */
+			src_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, sel->pad, sel->which);
+			src_fmt->width = sel->r.width;
+			src_fmt->height = sel->r.height;
+			ret = 0;
+			break;
+		}
+		}
+	}
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return ret;
+}
+
+void visconti_viif_isp_set_compose_rect(struct viif_device *viif_dev,
+					struct viif_l2_roi_config *roi)
+{
+	struct v4l2_rect *rect;
+
+	rect = visconti_viif_isp_get_pad_compose(&viif_dev->isp_subdev.sd, NULL, VIIF_ISP_PAD_SINK,
+						 V4L2_SUBDEV_FORMAT_ACTIVE);
+	rect->top = 0;
+	rect->left = 0;
+	rect->width = roi->corrected_hsize[0];
+	rect->height = roi->corrected_vsize[0];
+}
+
+static const struct media_entity_operations visconti_viif_isp_media_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+static const struct v4l2_subdev_pad_ops visconti_viif_isp_pad_ops = {
+	.enum_mbus_code = visconti_viif_isp_enum_mbus_code,
+	.get_selection = visconti_viif_isp_get_selection,
+	.set_selection = visconti_viif_isp_set_selection,
+	.init_cfg = visconti_viif_isp_init_config,
+	.get_fmt = visconti_viif_isp_get_fmt,
+	.set_fmt = visconti_viif_isp_set_fmt,
+	.link_validate = v4l2_subdev_link_validate_default,
+};
+
+static const struct v4l2_subdev_video_ops visconti_viif_isp_video_ops = {
+	.s_stream = visconti_viif_isp_s_stream,
+};
+
+static const struct v4l2_subdev_ops visconti_viif_isp_ops = {
+	.video = &visconti_viif_isp_video_ops,
+	.pad = &visconti_viif_isp_pad_ops,
+};
+
+/* ----- register/remove isp subdevice node ----- */
+int visconti_viif_isp_register(struct viif_device *viif_dev)
+{
+	struct media_pad *pads = viif_dev->isp_subdev.pads;
+	struct v4l2_subdev *sd = &viif_dev->isp_subdev.sd;
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+	int ret;
+
+	viif_dev->isp_subdev.viif_dev = viif_dev;
+
+	v4l2_subdev_init(sd, &visconti_viif_isp_ops);
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->entity.ops = &visconti_viif_isp_media_ops;
+	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;
+	sd->owner = THIS_MODULE;
+	strscpy(sd->name, "visconti-viif:isp", sizeof(sd->name));
+
+	pads[0].flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
+	pads[1].flags = MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
+	pads[2].flags = MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
+	pads[3].flags = MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
+
+	mutex_init(&viif_dev->isp_subdev.ops_lock);
+
+	/* this function is implemented in the next patch */
+/*
+ *	visconti_viif_isp_init_controls(viif_dev);
+ */
+
+	ret = media_entity_pads_init(&sd->entity, 4, pads);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed on media_entity_pads_init\n");
+		return ret;
+	}
+
+	ret = v4l2_device_register_subdev(&viif_dev->v4l2_dev, sd);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to resize ISP subdev\n");
+		goto err_cleanup_media_entity;
+	}
+
+	visconti_viif_isp_init_config(sd, &state);
+
+	return 0;
+
+err_cleanup_media_entity:
+	media_entity_cleanup(&sd->entity);
+	return ret;
+}
+
+void visconti_viif_isp_unregister(struct viif_device *viif_dev)
+{
+	v4l2_device_unregister_subdev(&viif_dev->isp_subdev.sd);
+	media_entity_cleanup(&viif_dev->isp_subdev.sd.entity);
+}
diff --git a/drivers/media/platform/toshiba/visconti/viif_isp.h b/drivers/media/platform/toshiba/visconti/viif_isp.h
new file mode 100644
index 000000000000..42e9e30098d4
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif_isp.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef VIIF_ISP_H
+#define VIIF_ISP_H
+
+struct viif_device;
+struct viif_l2_roi_config;
+
+void visconti_viif_l2_set_roi_path(struct viif_device *viif_dev);
+void visconti_viif_l2_set_roi(struct viif_device *viif_dev, const struct viif_l2_roi_config *param);
+int visconti_viif_isp_main_set_unit(struct viif_device *viif_dev);
+int visconti_viif_isp_sub_set_unit(struct viif_device *viif_dev);
+void visconti_viif_isp_set_compose_rect(struct viif_device *viif_dev,
+					struct viif_l2_roi_config *roi);
+
+int visconti_viif_isp_register(struct viif_device *viif_dev);
+void visconti_viif_isp_unregister(struct viif_device *viif_dev);
+
+#endif /* VIIF_ISP_H */
diff --git a/drivers/media/platform/toshiba/visconti/viif_regs.h b/drivers/media/platform/toshiba/visconti/viif_regs.h
new file mode 100644
index 000000000000..93cc9d593db1
--- /dev/null
+++ b/drivers/media/platform/toshiba/visconti/viif_regs.h
@@ -0,0 +1,716 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture register definitions
+ *
+ * (C) Copyright 2023 TOSHIBA CORPORATION
+ * (C) Copyright 2023 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef VIIF_REGS_H
+#define VIIF_REGS_H
+
+#include <linux/bitfield.h>
+
+/*=============================================*/
+/* Capture registers */
+/*=============================================*/
+#define REG_IPORTM0_LD	   0
+#define REG_IPORTM1_LD	   0x4
+#define MASK_IPORTM_VLATCH 0x3
+
+#define REG_CSI2RX_RESETN      0x8
+#define REG_CSI2RX_INT_ST_MAIN 0xC
+#define REG_CSI2RX_DATA_IDS_1  0x10
+#define REG_CSI2RX_DATA_IDS_2  0x14
+#define REG_VCID0SELECT	       0x30
+#define REG_VCID1SELECT	       0x34
+#define REG_VCPORTEN	       0x3C
+#define MASK_VCPORTEN_EN_VC0   BIT(0)
+#define MASK_VCPORTEN_EN_VC1   BIT(4)
+#define REG_IPORTM	       0x54
+#define VAL_IPORTM_INPUT_CSI2  0
+
+#define REG_IPORTM_MAIN_DT		 0x58
+#define REG_IPORTM_MAIN_RAW		 0x5C
+#define REG_IPORTM_OTHER		 0x60
+#define REG_IPORTM_OTHEREN		 0x64
+#define REG_IPORTM_EMBEN		 0x68
+#define REG_IPORTS_MAIN_DT		 0x78
+#define REG_IPORTS_OTHER		 0x80
+#define REG_IPORTS_OTHEREN		 0x84
+#define REG_IPORTS_EMBEN		 0x88
+#define REG_IPORTS_IMGEN		 0x8C
+#define REG_TOTALSIZE_M			 0xC0
+#define REG_VALSIZE_M			 0xC4
+#define REG_BACK_PORCH_M		 0xC8
+#define REG_INT_M_SYNC			 0x130
+#define REG_INT_M_SYNC_MASK		 0x134
+#define MASK_INT_M_SYNC_VSYNC_INT	 BIT(0)
+#define MASK_INT_M_SYNC_LINES_DELAY_INT1 BIT(1)
+#define MASK_INT_M_SYNC_LINES_DELAY_INT2 BIT(2)
+#define MASK_INT_M_SYNC_SW_DELAY_INT0	 BIT(16)
+#define MASK_INT_M_SYNC_SW_DELAY_INT1	 BIT(17)
+#define MASK_INT_M_SYNC_SW_DELAY_INT2	 BIT(18)
+/* we only care for LINES_DELAY_INT2, SW_DELAY_INT2 */
+#define MASK_INT_M_SYNC_MASK_SET                                        \
+	(MASK_INT_M_SYNC_VSYNC_INT | MASK_INT_M_SYNC_LINES_DELAY_INT1 | \
+	 MASK_INT_M_SYNC_SW_DELAY_INT0 | MASK_INT_M_SYNC_SW_DELAY_INT1)
+
+#define REG_INT_S_SYNC			 0x138
+#define REG_INT_S_SYNC_MASK		 0x13C
+#define MASK_INT_S_SYNC_VSYNC_INT	 BIT(0)
+#define MASK_INT_S_SYNC_LINES_DELAY_INT1 BIT(1)
+#define MASK_INT_S_SYNC_SW_DELAY_INT0	 BIT(16)
+#define MASK_INT_S_SYNC_SW_DELAY_INT1	 BIT(17)
+/* we only care for LINES_DELAY_INT1 */
+#define MASK_INT_S_SYNC_MASK_SET \
+	(MASK_INT_S_SYNC_VSYNC_INT | MASK_INT_S_SYNC_SW_DELAY_INT0 | MASK_INT_S_SYNC_SW_DELAY_INT1)
+
+#define REG_INT_M0_LINE			     0x140
+#define REG_INT_M1_LINE			     0x144
+#define REG_INT_M2_LINE			     0x148
+#define REG_INT_SA0_LINE		     0x160
+#define REG_INT_SA1_LINE		     0x164
+#define REG_INT_M_STATUS		     0x180
+#define REG_INT_M_MASK			     0x184
+#define MASK_INT_M_L2ISP_SIZE_ERROR	     BIT(0)
+#define MASK_INT_M_CRGBF_INTCRGERR_WRSTART   BIT(1)
+#define MASK_INT_M_CRGBF_INTCRGERR_RDSTART   BIT(2)
+#define MASK_INT_M_EMBED_ERROR		     BIT(3)
+#define MASK_INT_M_USERDATA_ERROR	     BIT(4)
+#define MASK_INT_M_L2ISP_GAMMA_TABLE_TIMEOUT (BIT(8) | BIT(9) | BIT(10))
+#define MASK_INT_M_L2ISP_GRID_TABLE_TIMEOUT  BIT(11)
+#define MASK_INT_M_L1ISP_SIZE_ERROR0	     BIT(16)
+#define MASK_INT_M_L1ISP_SIZE_ERROR1	     BIT(17)
+#define MASK_INT_M_L1ISP_SIZE_ERROR2	     BIT(18)
+#define MASK_INT_M_L1ISP_SIZE_ERROR3	     BIT(19)
+#define MASK_INT_M_L1ISP_SIZE_ERROR4	     BIT(20)
+#define MASK_INT_M_L1ISP_INT_ERR_CRGWRSTART  BIT(21)
+#define MASK_INT_M_L1ISP_INT_ERR_CRGRDSTART  BIT(22)
+#define MASK_INT_M_DELAY_INT_ERROR	     BIT(24)
+
+#define REG_INT_S_STATUS	   0x188
+#define REG_INT_S_MASK		   0x18C
+#define MASK_INT_S_SIZE_ERROR	   BIT(0)
+#define MASK_INT_S_EMBED_ERROR	   BIT(1)
+#define MASK_INT_S_USERDATA_ERROR  BIT(2)
+#define MASK_INT_S_DELAY_INT_ERROR BIT(24)
+#define MASK_INT_S_RESERVED_SET	   (BIT(16) | BIT(28))
+
+#define REG_PREPROCCESS_FMTM	   0x210
+#define VAL_PREPROCCESS_FMT_RGB	   (0x0 << 4)
+#define VAL_PREPROCCESS_FMT_YUV444 (0x1 << 4)
+#define VAL_PREPROCCESS_FMT_YUV422 (0x3 << 4)
+
+#define REG_PREPROCCESS_C24M		   0x214
+#define REG_L2ISP_INPUT_CSC_MTB		   0x220
+#define REG_L2ISP_INPUT_CSC_MTB_YG_OFFSETI 0x230
+#define REG_L2ISP_INPUT_CSC_MTB_YG1	   0x234
+#define REG_L2ISP_INPUT_CSC_MTB_YG2	   0x238
+#define REG_L2ISP_INPUT_CSC_MTB_YG_OFFSETO 0x23C
+#define REG_L2ISP_INPUT_CSC_MTB_CB_OFFSETI 0x240
+#define REG_L2ISP_INPUT_CSC_MTB_CB1	   0x244
+#define REG_L2ISP_INPUT_CSC_MTB_CB2	   0x248
+#define REG_L2ISP_INPUT_CSC_MTB_CB_OFFSETO 0x24C
+#define REG_L2ISP_INPUT_CSC_MTB_CR_OFFSETI 0x250
+#define REG_L2ISP_INPUT_CSC_MTB_CR1	   0x254
+#define REG_L2ISP_INPUT_CSC_MTB_CR2	   0x258
+#define REG_L2ISP_INPUT_CSC_MTB_CR_OFFSETO 0x25C
+#define REG_DPHY_FREQRANGE		   0x700
+#define REG_DPHY_LANE			   0x710
+#define REG_DPGM_VSYNC_SOURCE		   0x804
+#define VAL_DPGM_VSYNC_PULSE		   1
+
+#define REG_VDM_R_ENABLE		 0x1030
+#define REG_VDM_W_ENABLE		 0x1034
+#define REG_VDM_T_ENABLE		 0x1038
+#define MASK_VDM_T_ENABLE_L1_DPC_H	 BIT(0)
+#define MASK_VDM_T_ENABLE_L1_DPC_M	 BIT(1)
+#define MASK_VDM_T_ENABLE_L1_DPC_L	 BIT(2)
+#define MASK_VDM_T_ENABLE_L1_DPC	 0x07
+#define MASK_VDM_T_ENABLE_L1_LSSC_GR	 BIT(4)
+#define MASK_VDM_T_ENABLE_L1_LSSC_R	 BIT(5)
+#define MASK_VDM_T_ENABLE_L1_LSSC_B	 BIT(6)
+#define MASK_VDM_T_ENABLE_L1_LSSC_GB	 BIT(7)
+#define MASK_VDM_T_ENABLE_L1_LSSC	 0x00F0
+#define MASK_VDM_T_ENABLE_L2_UNDIST_RD_B BIT(8)
+#define MASK_VDM_T_ENABLE_L2_UNDIST_RD_G BIT(9)
+#define MASK_VDM_T_ENABLE_L2_UNDIST_RD_R BIT(10)
+#define MASK_VDM_T_ENABLE_L2_UNDIST_WR_G BIT(11)
+#define MASK_VDM_T_ENABLE_L2_UNDIST	 0x0F00
+/* val: 12-23; postid: 0-1, ch: 0-5 */
+#define MASK_VDM_T_ENABLE_L2_GAMMA(postid, ch) BIT(12 + ((postid) * 6) + (ch))
+#define MASK_VDM_T_ENABLE_L2_GAMMA_ALL(postid) (0x3FU << (12 + ((postid) * 6)))
+
+#define REG_VDM_ABORTSET 0x103C
+
+/* x: 0-3 */
+#define REG_VDM_TGROUP_X_BASE(x)		 (0x1040 + 16 * (x))
+#define REG_VDM_TGROUP_X_CFG(x)		 (REG_VDM_TGROUP_X_BASE(x) + 0)
+#define REG_VDM_TGROUP_X_SRAM_BASE(x)	 (REG_VDM_TGROUP_X_BASE(x) + 4)
+#define REG_VDM_TGROUP_X_SRAM_SIZE(x)	 (REG_VDM_TGROUP_X_BASE(x) + 8)
+#define IDX_TGROUP_L1_ISP		 0
+#define IDX_TGROUP_L2_UNDIST		 1
+#define IDX_TGROUP_L2_GAMMA_LUT(post_id) (2 + (post_id))
+#define VAL_TGROUP_CFG_64BIT_RD		 0x0310U
+#define VAL_TGROUP_CFG_32BIT_RD		 0x0210U
+
+/* x: 0-23*/
+#define REG_VDM_TPORT_X_BASE(x)	(0x1100 + 8 * (x))
+#define REG_VDM_TPORT_X_SIZE(x)	(REG_VDM_TPORT_X_BASE(x) + 4)
+#define REG_VDM_TPORT_X_STADR(x) (REG_VDM_TPORT_X_BASE(x) + 0)
+/* idx: 0-2; x: 0-2 */
+#define IDX_TPORT_L1_DPC(x)	 (x)
+#define IDX_TPORT_L1_DPC_H	 0
+#define IDX_TPORT_L1_DPC_M	 1
+#define IDX_TPORT_L1_DPC_L	 2
+#define IDX_TPORT_L1_LSSC_GR	 4
+#define IDX_TPORT_L1_LSSC_R	 5
+#define IDX_TPORT_L1_LSSC_B	 6
+#define IDX_TPORT_L1_LSSC_GB	 7
+#define IDX_TPORT_L2_UNDIST_RD_B 8
+#define IDX_TPORT_L2_UNDIST_RD_G 9
+#define IDX_TPORT_L2_UNDIST_RD_R 10
+#define IDX_TPORT_L2_UNDIST_WR_G 11
+/* idx: 12-23; post_id: 0-1, col: 0-5 */
+#define IDX_TPORT_L2_GAMMA_LUT(post_id, col) (12 + (col) + (post_id) * 6)
+
+/* x: 0-5 */
+#define REG_VDM_WPORT_X_BASE(x)	      (0x1300 + 64 * (x))
+#define REG_VDM_WPORT_X_W_CFG0(x)      (REG_VDM_WPORT_X_BASE(x) + 16)
+#define REG_VDM_WPORT_X_W_ENDADR(x)    (REG_VDM_WPORT_X_BASE(x) + 4)
+#define REG_VDM_WPORT_X_W_HEIGHT(x)    (REG_VDM_WPORT_X_BASE(x) + 8)
+#define REG_VDM_WPORT_X_W_PITCH(x)     (REG_VDM_WPORT_X_BASE(x) + 12)
+#define REG_VDM_WPORT_X_W_SRAM_BASE(x) (REG_VDM_WPORT_X_BASE(x) + 24)
+#define REG_VDM_WPORT_X_W_SRAM_SIZE(x) (REG_VDM_WPORT_X_BASE(x) + 28)
+#define REG_VDM_WPORT_X_W_STADR(x)     (REG_VDM_WPORT_X_BASE(x) + 0)
+#define IDX_WPORT_MAIN_LNG	      0
+#define IDX_WPORT_MAIN_EMB	      1
+#define IDX_WPORT_SUB_IMG	      3
+#define IDX_WPORT_SUB_LNG	      4
+#define IDX_WPORT_SUB_EMB	      5
+
+#define REG_VDM_R_RUN		0x1E18
+#define REG_VDM_W_RUN		0x1E1C
+#define REG_VDM_T_RUN		0x1E20
+#define REG_L1_SYSM_WIDTH	0x2000
+#define REG_L1_SYSM_HEIGHT	0x2004
+#define REG_L1_SYSM_START_COLOR 0x2008
+#define REG_L1_SYSM_INPUT_MODE	0x200C
+#define REG_L1_SYSM_YCOEF_R	0x2014
+#define REG_L1_SYSM_YCOEF_G	0x2018
+#define REG_L1_SYSM_YCOEF_B	0x201C
+#define REG_L1_SYSM_AG_H	0x2040
+#define REG_L1_SYSM_AG_M	0x2044
+#define REG_L1_SYSM_AG_L	0x2048
+#define REG_L1_SYSM_AG_PARAM_A	0x204C
+#define REG_L1_SYSM_AG_PARAM_B	0x2050
+#define REG_L1_SYSM_AG_PARAM_C	0x2054
+#define REG_L1_SYSM_AG_PARAM_D	0x2058
+#define PACK_L1_SYSM_AG_PARAM(grad, ofst) \
+	(FIELD_PREP(0x00FF0000, (grad)) | FIELD_PREP(0x00FFFF, (ofst)))
+
+#define REG_L1_SYSM_AG_SEL_HOBC 0x205C
+#define REG_L1_SYSM_AG_SEL_ABPC 0x2060
+#define REG_L1_SYSM_AG_SEL_RCNR 0x2064
+#define PACK_L1_SYSM_AG_SEL_HML(high, mid, low) \
+	(FIELD_PREP(0x00C0, (high)) | FIELD_PREP(0x0030, (mid)) | FIELD_PREP(0x0C, (low)))
+
+#define REG_L1_SYSM_AG_SEL_LSSC		   0x2068
+#define REG_L1_SYSM_AG_SEL_MPRO		   0x206C
+#define REG_L1_SYSM_AG_SEL_VPRO		   0x2070
+#define PACK_L1_SYSM_AG_SEL_SP(ssel, psel) (FIELD_PREP(0x00C0, (ssel)) | (FIELD_PREP(0x03, (psel))))
+
+#define REG_L1_SYSM_AG_CONT_HOBC01_EN 0x2074
+#define REG_L1_SYSM_AG_CONT_HOBC2_EN  0x2078
+#define REG_L1_SYSM_AG_CONT_ABPC01_EN 0x207C
+#define REG_L1_SYSM_AG_CONT_ABPC2_EN  0x2080
+#define REG_L1_SYSM_AG_CONT_RCNR01_EN 0x2084
+#define REG_L1_SYSM_AG_CONT_RCNR2_EN  0x2088
+#define MASK_L1_SYSM_AG_CONT_M_EN     BIT(24)
+#define MASK_L1_SYSM_AG_CONT_H_EN     BIT(8)
+#define MASK_L1_SYSM_AG_CONT_M_VAL    0x00FF0000
+#define MASK_L1_SYSM_AG_CONT_H_VAL    0x00FF
+#define MASK_L1_SYSM_AG_CONT_L_EN     BIT(8)
+#define MASK_L1_SYSM_AG_CONT_L_VAL    0x00FF
+
+#define REG_L1_SYSM_AG_CONT_LSSC_EN 0x208C
+#define REG_L1_SYSM_AG_CONT_MPRO_EN 0x2090
+#define REG_L1_SYSM_AG_CONT_VPRO_EN 0x2094
+#define MASK_L1_SYSM_AG_CONT_EN	    BIT(8)
+#define MASK_L1_SYSM_AG_CONT_VAL    0x00FF
+
+#define LEN_L1_HDRE_SRCPOINT	 16
+#define REG_L1_HDRE_SRCPOINT(x) (0x20C4 + 4 * (x))
+
+#define LEN_L1_HDRE_SRCBASE	17
+#define REG_L1_HDRE_SRCBASE(x) (0x2104 + 4 * (x))
+
+#define LEN_L1_HDRE_RATIO     17
+#define REG_L1_HDRE_RATIO(x) (0x2148 + 4 * (x))
+
+#define LEN_L1_HDRE_DSTBASE	17
+#define REG_L1_HDRE_DSTBASE(x) (0x218C + 4 * (x))
+
+#define REG_L1_HDRE_DSTMAXVAL	 0x21D0
+#define REG_L1_AEXP_ON		 0x2200
+#define REG_L1_AEXP_RESULT_AVE	 0x2204
+#define REG_L1_AEXP_START_X	 0x2210
+#define REG_L1_AEXP_START_Y	 0x2214
+#define REG_L1_AEXP_BLOCK_WIDTH	 0x2218
+#define REG_L1_AEXP_BLOCK_HEIGHT 0x221C
+#define REG_L1_AEXP_WEIGHT_0	 0x2220
+#define REG_L1_AEXP_WEIGHT_1	 0x2224
+#define REG_L1_AEXP_WEIGHT_2	 0x2228
+#define REG_L1_AEXP_WEIGHT_3	 0x222C
+#define REG_L1_AEXP_WEIGHT_4	 0x2230
+#define REG_L1_AEXP_WEIGHT_5	 0x2234
+#define REG_L1_AEXP_WEIGHT_6	 0x2238
+#define REG_L1_AEXP_WEIGHT_7	 0x223C
+#define REG_L1_AEXP_SATUR_RATIO	 0x2240
+#define REG_L1_AEXP_BLACK_RATIO	 0x2244
+#define REG_L1_AEXP_SATUR_LEVEL	 0x2248
+/* 8 x 8 elements */
+#define REG_L1_AEXP_AVE(y, x)	       (0x2250 + 32 * (y) + 4 * (x))
+#define REG_L1_AEXP_SATUR_BLACK_PIXNUM 0x2350
+#define REG_L1_AEXP_AVE4LINESY0	       0x2354
+#define REG_L1_AEXP_AVE4LINESY1	       0x2358
+#define REG_L1_AEXP_AVE4LINESY2	       0x235C
+#define REG_L1_AEXP_AVE4LINESY3	       0x2360
+#define REG_L1_AEXP_AVE4LINES0	       0x2364
+#define REG_L1_AEXP_AVE4LINES1	       0x2368
+#define REG_L1_AEXP_AVE4LINES2	       0x236C
+#define REG_L1_AEXP_AVE4LINES3	       0x2370
+#define REG_L1_IBUF_DEPTH	       0x2380
+#define REG_L1_IBUF_INPUT_ORDER	       0x2384
+#define REG_L1_SLIC_SRCBLACKLEVEL_GR   0x2390
+#define REG_L1_SLIC_SRCBLACKLEVEL_R    0x2394
+#define REG_L1_SLIC_SRCBLACKLEVEL_B    0x2398
+#define REG_L1_SLIC_SRCBLACKLEVEL_GB   0x239C
+#define REG_L1_ABPC012_STA_EN	       0x240C
+#define REG_L1_ABPC012_DYN_EN	       0x2410
+#define MASK_L1_ABPC_ENABLE_H	       BIT(24)
+#define MASK_L1_ABPC_ENABLE_M	       BIT(16)
+#define MASK_L1_ABPC_ENABLE_L	       BIT(8)
+
+#define REG_L1_ABPC012_DYN_MODE	       0x2414
+#define MASK_L1_ABPC_DYN_MODE_2PIXEL_H BIT(24)
+#define MASK_L1_ABPC_DYN_MODE_2PIXEL_M BIT(16)
+#define MASK_L1_ABPC_DYN_MODE_2PIXEL_L BIT(8)
+
+#define REG_L1_ABPC0_RATIO_LIMIT      0x2424
+#define REG_L1_ABPC0_DARK_LIMIT	      0x242C
+#define REG_L1_ABPC0_SN_COEF_W_AG_MIN 0x2430
+#define REG_L1_ABPC0_SN_COEF_W_AG_MID 0x2434
+#define REG_L1_ABPC0_SN_COEF_W_AG_MAX 0x2438
+#define REG_L1_ABPC0_SN_COEF_W_TH_MIN 0x243C
+#define REG_L1_ABPC0_SN_COEF_W_TH_MAX 0x2440
+#define REG_L1_ABPC0_SN_COEF_B_AG_MIN 0x2444
+#define REG_L1_ABPC0_SN_COEF_B_AG_MID 0x2448
+#define REG_L1_ABPC0_SN_COEF_B_AG_MAX 0x244C
+#define REG_L1_ABPC0_SN_COEF_B_TH_MIN 0x2450
+#define REG_L1_ABPC0_SN_COEF_B_TH_MAX 0x2454
+#define REG_L1_ABPC1_RATIO_LIMIT      0x2460
+#define REG_L1_ABPC1_DARK_LIMIT	      0x2468
+#define REG_L1_ABPC1_SN_COEF_W_AG_MIN 0x246C
+#define REG_L1_ABPC1_SN_COEF_W_AG_MID 0x2470
+#define REG_L1_ABPC1_SN_COEF_W_AG_MAX 0x2474
+#define REG_L1_ABPC1_SN_COEF_W_TH_MIN 0x2478
+#define REG_L1_ABPC1_SN_COEF_W_TH_MAX 0x247C
+#define REG_L1_ABPC1_SN_COEF_B_AG_MIN 0x2480
+#define REG_L1_ABPC1_SN_COEF_B_AG_MID 0x2484
+#define REG_L1_ABPC1_SN_COEF_B_AG_MAX 0x2488
+#define REG_L1_ABPC1_SN_COEF_B_TH_MIN 0x248C
+#define REG_L1_ABPC1_SN_COEF_B_TH_MAX 0x2490
+#define REG_L1_ABPC2_RATIO_LIMIT      0x249C
+#define REG_L1_ABPC2_DARK_LIMIT	      0x24A4
+#define REG_L1_ABPC2_SN_COEF_W_AG_MIN 0x24A8
+#define REG_L1_ABPC2_SN_COEF_W_AG_MID 0x24AC
+#define REG_L1_ABPC2_SN_COEF_W_AG_MAX 0x24B0
+#define REG_L1_ABPC2_SN_COEF_W_TH_MIN 0x24B4
+#define REG_L1_ABPC2_SN_COEF_W_TH_MAX 0x24B8
+#define REG_L1_ABPC2_SN_COEF_B_AG_MIN 0x24BC
+#define REG_L1_ABPC2_SN_COEF_B_AG_MID 0x24C0
+#define REG_L1_ABPC2_SN_COEF_B_AG_MAX 0x24C4
+#define REG_L1_ABPC2_SN_COEF_B_TH_MIN 0x24C8
+#define REG_L1_ABPC2_SN_COEF_B_TH_MAX 0x24CC
+#define REG_L1_PWHB_H_GR	      0x2584
+#define REG_L1_PWHB_HR		      0x2588
+#define REG_L1_PWHB_HB		      0x258C
+#define REG_L1_PWHB_H_GB	      0x2590
+#define REG_L1_PWHB_M_GR	      0x2594
+#define REG_L1_PWHB_MR		      0x2598
+#define REG_L1_PWHB_MB		      0x259C
+#define REG_L1_PWHB_M_GB	      0x25A0
+#define REG_L1_PWHB_L_GR	      0x25A4
+#define REG_L1_PWHB_LR		      0x25A8
+#define REG_L1_PWHB_LB		      0x25AC
+#define REG_L1_PWHB_L_GB	      0x25B0
+#define REG_L1_PWHB_DSTMAXVAL	      0x25B4
+
+/* 0 for high, 1 for middle, 2 for low sensitivity image */
+#define REG_L1_RCNR_X_SW(x)		  (0x2608 + 0x94 * (x))
+#define REG_L1_RCNR_X_CNF_DARK_AG0(x)	  (0x260C + 0x94 * (x))
+#define REG_L1_RCNR_X_CNF_DARK_AG1(x)	  (0x2610 + 0x94 * (x))
+#define REG_L1_RCNR_X_CNF_DARK_AG2(x)	  (0x2614 + 0x94 * (x))
+#define REG_L1_RCNR_X_CNF_RATIO_AG0(x)	  (0x2618 + 0x94 * (x))
+#define REG_L1_RCNR_X_CNF_RATIO_AG1(x)	  (0x261C + 0x94 * (x))
+#define REG_L1_RCNR_X_CNF_RATIO_AG2(x)	  (0x2620 + 0x94 * (x))
+#define REG_L1_RCNR_X_CNF_CLIP_GAIN_R(x)	  (0x2624 + 0x94 * (x))
+#define REG_L1_RCNR_X_CNF_CLIP_GAIN_G(x)	  (0x2628 + 0x94 * (x))
+#define REG_L1_RCNR_X_CNF_CLIP_GAIN_B(x)	  (0x262C + 0x94 * (x))
+#define REG_L1_RCNR_X_A1L_DARK_AG0(x)	  (0x2630 + 0x94 * (x))
+#define REG_L1_RCNR_X_A1L_DARK_AG1(x)	  (0x2634 + 0x94 * (x))
+#define REG_L1_RCNR_X_A1L_DARK_AG2(x)	  (0x2638 + 0x94 * (x))
+#define REG_L1_RCNR_X_A1L_RATIO_AG0(x)	  (0x263C + 0x94 * (x))
+#define REG_L1_RCNR_X_A1L_RATIO_AG1(x)	  (0x2640 + 0x94 * (x))
+#define REG_L1_RCNR_X_A1L_RATIO_AG2(x)	  (0x2644 + 0x94 * (x))
+#define REG_L1_RCNR_X_INF_ZERO_CLIP(x)	  (0x2648 + 0x94 * (x))
+#define REG_L1_RCNR_X_MERGE_D2BLEND_AG0(x) (0x2650 + 0x94 * (x))
+#define REG_L1_RCNR_X_MERGE_D2BLEND_AG1(x) (0x2654 + 0x94 * (x))
+#define REG_L1_RCNR_X_MERGE_D2BLEND_AG2(x) (0x2658 + 0x94 * (x))
+#define REG_L1_RCNR_X_MERGE_BLACK(x)	  (0x265C + 0x94 * (x))
+#define REG_L1_RCNR_X_MERGE_MINDIV(x)	  (0x2660 + 0x94 * (x))
+#define REG_L1_RCNR_X_HRY_TYPE(x)	  (0x2664 + 0x94 * (x))
+#define REG_L1_RCNR_X_ANF_BLEND_AG0(x)	  (0x2668 + 0x94 * (x))
+#define REG_L1_RCNR_X_ANF_BLEND_AG1(x)	  (0x266C + 0x94 * (x))
+#define REG_L1_RCNR_X_ANF_BLEND_AG2(x)	  (0x2670 + 0x94 * (x))
+#define REG_L1_RCNR_X_LPF_THRESHOLD(x)	  (0x2678 + 0x94 * (x))
+#define REG_L1_RCNR_X_MERGE_HLBLEND_AG0(x) (0x267C + 0x94 * (x))
+#define REG_L1_RCNR_X_MERGE_HLBLEND_AG1(x) (0x2680 + 0x94 * (x))
+#define REG_L1_RCNR_X_MERGE_HLBLEND_AG2(x) (0x2684 + 0x94 * (x))
+#define REG_L1_RCNR_X_GNR_SW(x)		  (0x2688 + 0x94 * (x))
+#define REG_L1_RCNR_X_GNR_RATIO(x)	  (0x268C + 0x94 * (x))
+#define REG_L1_RCNR_X_GNR_WIDE_EN(x)	  (0x2690 + 0x94 * (x))
+
+#define REG_L1_HDRS_HDRRATIO_M	     0x2884
+#define REG_L1_HDRS_HDRRATIO_L	     0x2888
+#define REG_L1_HDRS_HDRRATIO_E	     0x288C
+#define REG_L1_HDRS_BLENDEND_H	     0x2898
+#define REG_L1_HDRS_BLENDEND_M	     0x289C
+#define REG_L1_HDRS_BLENDEND_E	     0x28A0
+#define REG_L1_HDRS_BLENDBEG_H	     0x28A4
+#define REG_L1_HDRS_BLENDBEG_M	     0x28A8
+#define REG_L1_HDRS_BLENDBEG_E	     0x28AC
+#define REG_L1_HDRS_DG_H	     0x28C8
+#define REG_L1_HDRS_DG_M	     0x28CC
+#define REG_L1_HDRS_DG_L	     0x28D0
+#define REG_L1_HDRS_DG_E	     0x28D4
+#define REG_L1_HDRS_LEDMODE_ON	     0x28D8
+#define REG_L1_HDRS_HDRMODE	     0x28DC
+#define REG_L1_HDRS_DSTMAXVAL	     0x28EC
+#define REG_L1_BLVC_SRCBLACKLEVEL_GR 0x2900
+#define REG_L1_BLVC_SRCBLACKLEVEL_R  0x2904
+#define REG_L1_BLVC_SRCBLACKLEVEL_B  0x2908
+#define REG_L1_BLVC_SRCBLACKLEVELGB  0x290C
+#define REG_L1_BLVC_MULTVAL_GR	     0x2910
+#define REG_L1_BLVC_MULTVAL_R	     0x2914
+#define REG_L1_BLVC_MULTVAL_B	     0x2918
+#define REG_L1_BLVC_MULTVAL_GB	     0x291C
+#define REG_L1_BLVC_DSTMAXVAL	     0x2920
+#define REG_L1_LSSC_EN		     0x2980
+#define REG_L1_LSSC_PWHB_R_GAIN	     0x2990
+#define REG_L1_LSSC_PWHB_GR_GAIN     0x2994
+#define REG_L1_LSSC_PWHB_GB_GAIN     0x2998
+#define REG_L1_LSSC_PWHB_B_GAIN	     0x299C
+#define REG_L1_LSSC_PARA_EN	     0x29A0
+#define REG_L1_LSSC_PARA_H_CENTER    0x29A4
+#define REG_L1_LSSC_PARA_V_CENTER    0x29A8
+#define REG_L1_LSSC_PARA_H_GAIN	     0x29AC
+#define REG_L1_LSSC_PARA_V_GAIN	     0x29B0
+#define REG_L1_LSSC_PARA_MGSEL2	     0x29B4
+#define REG_L1_LSSC_PARA_MGSEL4	     0x29B8
+
+/*0: R/2D, 1: R/4D, 2: GR/2D, 3: GR/4D, 4: GB/2D, 5: GB/4D, 6: B/2D, 7: B/4D*/
+#define REG_L1_LSSC_PARA_COEF_X_H_L(x)	 (0x29BC + 0x20 * (x))
+#define REG_L1_LSSC_PARA_COEF_X_H_R(x)	 (0x29C0 + 0x20 * (x))
+#define REG_L1_LSSC_PARA_COEF_X_V_U(x)	 (0x29C4 + 0x20 * (x))
+#define REG_L1_LSSC_PARA_COEF_X_V_D(x)	 (0x29C8 + 0x20 * (x))
+#define REG_L1_LSSC_PARA_COEF_X_HV_LU(x) (0x29CC + 0x20 * (x))
+#define REG_L1_LSSC_PARA_COEF_X_HV_RU(x) (0x29D0 + 0x20 * (x))
+#define REG_L1_LSSC_PARA_COEF_X_HV_LD(x) (0x29D4 + 0x20 * (x))
+#define REG_L1_LSSC_PARA_COEF_X_HV_RD(x) (0x29D8 + 0x20 * (x))
+
+#define REG_L1_LSSC_GRID_EN	   0x2ABC
+#define REG_L1_LSSC_GRID_H_CENTER  0x2AC0
+#define REG_L1_LSSC_GRID_V_CENTER  0x2AC4
+#define REG_L1_LSSC_GRID_H_SIZE	   0x2AC8
+#define REG_L1_LSSC_GRID_V_SIZE	   0x2ACC
+#define REG_L1_LSSC_GRID_MGSEL	   0x2AD0
+#define REG_L1_MPRO_SW		   0x2B00
+#define REG_L1_MPRO_CONF	   0x2B04
+#define REG_L1_MPRO_DST_MINVAL	   0x2B0C
+#define REG_L1_MPRO_DST_MAXVAL	   0x2B10
+#define REG_L1_MPRO_LM0_RMG_MIN	   0x2B20
+#define REG_L1_MPRO_LM0_RMB_MIN	   0x2B24
+#define REG_L1_MPRO_LM0_GMR_MIN	   0x2B28
+#define REG_L1_MPRO_LM0_GMB_MIN	   0x2B2C
+#define REG_L1_MPRO_LM0_BMR_MIN	   0x2B30
+#define REG_L1_MPRO_LM0_BMG_MIN	   0x2B34
+#define REG_L1_MPRO_LM0_RMG_MAX	   0x2B38
+#define REG_L1_MPRO_LM0_RMB_MAX	   0x2B3C
+#define REG_L1_MPRO_LM0_GMR_MAX	   0x2B40
+#define REG_L1_MPRO_LM0_GMB_MAX	   0x2B44
+#define REG_L1_MPRO_LM0_BMR_MAX	   0x2B48
+#define REG_L1_MPRO_LM0_BMG_MAX	   0x2B4C
+#define REG_L1_MPRO_LCS_MODE	   0x2BF0
+#define REG_L1_VPRO_PGC_SW	   0x2D80
+#define REG_L1_VPRO_YUVC_SW	   0x2D88
+#define REG_L1_VPRO_YNR_SW	   0x2D8C
+#define REG_L1_VPRO_ETE_SW	   0x2D90
+#define REG_L1_VPRO_CSUP_UVSUP_SW  0x2D94
+#define REG_L1_VPRO_CSUP_CORING_SW 0x2D98
+#define REG_L1_VPRO_BRIGHT_SW	   0x2D9C
+#define REG_L1_VPRO_LCNT_SW	   0x2DA0
+#define REG_L1_VPRO_NLCNT_SW	   0x2DA4
+#define REG_L1_VPRO_EDGE_SUP_SW	   0x2DAC
+#define REG_L1_VPRO_CNR_SW	   0x2DB0
+#define REG_L1_VPRO_BLKADJ	   0x2DB8
+/* (GAM00P is fixed 0) GAM01P-GAM44P: x:0-43 */
+#define REG_L1_VPRO_GAMxP(x)		 (0x2DBC + 4 * (x))
+#define REG_L1_VPRO_CB_MAT		 0x2E6C
+#define REG_L1_VPRO_CR_MAT		 0x2E70
+#define REG_L1_VPRO_BRIGHT		 0x2E74
+#define REG_L1_VPRO_LCONT_LEV		 0x2E78
+#define REG_L1_VPRO_BLK_KNEE		 0x2E7C
+#define REG_L1_VPRO_WHT_KNEE		 0x2E80
+#define REG_L1_VPRO_BLK_CONT0		 0x2E84
+#define REG_L1_VPRO_BLK_CONT1		 0x2E88
+#define REG_L1_VPRO_BLK_CONT2		 0x2E8C
+#define REG_L1_VPRO_WHT_CONT0		 0x2E90
+#define REG_L1_VPRO_WHT_CONT1		 0x2E94
+#define REG_L1_VPRO_WHT_CONT2		 0x2E98
+#define REG_L1_VPRO_YNR_GAIN_MIN	 0x2EB4
+#define REG_L1_VPRO_YNR_GAIN_MAX	 0x2EB8
+#define REG_L1_VPRO_YNR_LIM_MIN		 0x2EBC
+#define REG_L1_VPRO_YNR_LIM_MAX		 0x2EC0
+#define REG_L1_VPRO_ETE_GAIN_MIN	 0x2EC4
+#define REG_L1_VPRO_ETE_GAIN_MAX	 0x2EC8
+#define REG_L1_VPRO_ETE_LIM_MIN		 0x2ECC
+#define REG_L1_VPRO_ETE_LIM_MAX		 0x2ED0
+#define REG_L1_VPRO_ETE_CORING_MIN	 0x2ED4
+#define REG_L1_VPRO_ETE_CORING_MAX	 0x2ED8
+#define REG_L1_VPRO_CB_GAIN		 0x2EDC
+#define REG_L1_VPRO_CR_GAIN		 0x2EE0
+#define REG_L1_VPRO_CBR_MGAIN_MIN	 0x2EE4
+#define REG_L1_VPRO_CB_P_GAIN_MAX	 0x2EE8
+#define REG_L1_VPRO_CB_M_GAIN_MAX	 0x2EEC
+#define REG_L1_VPRO_CR_P_GAIN_MAX	 0x2EF0
+#define REG_L1_VPRO_CR_M_GAIN_MAX	 0x2EF4
+#define REG_L1_VPRO_CSUP_CORING_LV_MIN	 0x2EF8
+#define REG_L1_VPRO_CSUP_CORING_LV_MAX	 0x2EFC
+#define REG_L1_VPRO_CSUP_CORING_GAIN_MIN 0x2F00
+#define REG_L1_VPRO_CSUP_CORING_GAIN_MAX 0x2F04
+#define REG_L1_VPRO_CSUP_BK_SLV		 0x2F08
+#define REG_L1_VPRO_CSUP_BK_MP		 0x2F0C
+#define REG_L1_VPRO_CSUP_BLACK		 0x2F10
+#define REG_L1_VPRO_CSUP_WH_SLV		 0x2F14
+#define REG_L1_VPRO_CSUP_WH_MP		 0x2F18
+#define REG_L1_VPRO_CSUP_WHITE		 0x2F1C
+#define REG_L1_VPRO_EDGE_SUP_GAIN	 0x2F20
+#define REG_L1_VPRO_EDGE_SUP_LIM	 0x2F24
+#define REG_L1_AWHB_SW			 0x2F80
+#define MASK_L1_AWHB_SW_EN		 BIT(7)
+#define MASK_L1_AWHB_SW_LOCK		 BIT(5)
+
+#define REG_L1_AWHB_WBMRG	     0x2F88
+#define REG_L1_AWHB_WBMGG	     0x2F8C
+#define REG_L1_AWHB_WBMBG	     0x2F90
+#define REG_L1_AWHB_GATE_CONF0	     0x2F94
+#define MASK_L1_AWHB_GATE_YGATE_SEL  BIT(7)
+#define MASK_L1_AWHB_GATE_YGATE_DATA 0x0060
+#define MASK_L1_AWHB_GATE_CGRANGE    0x0003
+
+#define REG_L1_AWHB_GATE_CONF1	   0x2F98
+#define MASK_L1_AWHB_GATE_YGATESW  BIT(5)
+#define MASK_L1_AWHB_GATE_HEXSW	   BIT(4)
+#define MASK_L1_AWHB_GATE_AREAMODE 0x0003
+
+#define REG_L1_AWHB_AREA_HSIZE	    0x2F9C
+#define REG_L1_AWHB_AREA_VSIZE	    0x2FA0
+#define REG_L1_AWHB_AREA_HOFS	    0x2FA4
+#define REG_L1_AWHB_AREA_VOFS	    0x2FA8
+#define REG_L1_AWHB_AREA_MASKH	    0x2FAC
+#define REG_L1_AWHB_AREA_MASKL	    0x2FB0
+#define REG_L1_AWHB_SQ_CONF	    0x2FB4
+#define MASK_L1_AWHB_SQ_CONF_SQ3POL BIT(2)
+#define MASK_L1_AWHB_SQ_CONF_SQ3SW  BIT(3)
+#define MASK_L1_AWHB_SQ_CONF_SQ2POL BIT(4)
+#define MASK_L1_AWHB_SQ_CONF_SQ2SW  BIT(5)
+#define MASK_L1_AWHB_SQ_CONF_SQ1POL BIT(6)
+#define MASK_L1_AWHB_SQ_CONF_SQ1SW  BIT(7)
+
+#define REG_L1_AWHB_YGATEH	   0x2FB8
+#define REG_L1_AWHB_YGATEL	   0x2FBC
+#define REG_L1_AWHB_BYCUT0P	   0x2FC8
+#define REG_L1_AWHB_BYCUT0N	   0x2FCC
+#define REG_L1_AWHB_RYCUT0P	   0x2FD0
+#define REG_L1_AWHB_RYCUT0N	   0x2FD4
+#define REG_L1_AWHB_RBCUT0H	   0x2FD8
+#define REG_L1_AWHB_RBCUT0L	   0x2FDC
+#define REG_L1_AWHB_BYCUT1H	   0x2FF8
+#define REG_L1_AWHB_BYCUT1L	   0x2FFC
+#define REG_L1_AWHB_RYCUT1H	   0x3000
+#define REG_L1_AWHB_RYCUT1L	   0x3004
+#define REG_L1_AWHB_BYCUT2H	   0x3008
+#define REG_L1_AWHB_BYCUT2L	   0x300C
+#define REG_L1_AWHB_RYCUT2H	   0x3010
+#define REG_L1_AWHB_RYCUT2L	   0x3014
+#define REG_L1_AWHB_BYCUT3H	   0x3018
+#define REG_L1_AWHB_BYCUT3L	   0x301C
+#define REG_L1_AWHB_RYCUT3H	   0x3020
+#define REG_L1_AWHB_RYCUT3L	   0x3024
+#define REG_L1_AWHB_AWBSFTU	   0x3028
+#define REG_L1_AWHB_AWBSFTV	   0x302C
+#define REG_L1_AWHB_AWBSPD	   0x3030
+#define MASK_L1_AWHB_AWBSPD_HUECOR BIT(4)
+#define MASK_L1_AWHB_AWBSPD_SPD	   0x0F
+
+#define REG_L1_AWHB_AWBULV	0x3034
+#define REG_L1_AWHB_AWBVLV	0x3038
+#define REG_L1_AWHB_AWBWAIT	0x303C
+#define REG_L1_AWHB_AWBONDOT	0x3040
+#define REG_L1_AWHB_AWBFZTIM	0x3044
+#define REG_L1_AWHB_WBGRMAX	0x3048
+#define REG_L1_AWHB_WBGRMIN	0x304C
+#define REG_L1_AWHB_WBGBMAX	0x3050
+#define REG_L1_AWHB_WBGBMIN	0x3054
+#define REG_L1_AWHB_AVE_USIG	0x308C
+#define REG_L1_AWHB_AVE_VSIG	0x3090
+#define REG_L1_AWHB_NUM_UVON	0x3094
+#define REG_L1_AWHB_AWBGAINR	0x3098
+#define REG_L1_AWHB_AWBGAING	0x309C
+#define REG_L1_AWHB_AWBGAINB	0x30A0
+#define REG_L1_AWHB_R_CTR_STOP	0x30B0
+#define REG_L1_HOBC_MARGIN	0x30C4
+#define REG_L1_HDRC_EN		0x3200
+#define REG_L1_HDRC_THR_SFT_AMT 0x3204
+#define REG_L1_HDRC_RATIO	0x320C
+#define REG_L1_HDRC_PT_RATIO	0x321C
+#define REG_L1_HDRC_PT_BLEND	0x3220
+#define REG_L1_HDRC_PT_BLEND2	0x3224
+#define REG_L1_HDRC_PT_SAT	0x3228
+#define REG_L1_HDRC_TN_TYPE	0x322C
+#define REG_L1_HDRC_TNP_MAX	0x3230
+#define REG_L1_HDRC_TNP_MAG	0x3234
+
+#define LEN_L1_HDRC_TNP_FIL	5
+#define REG_L1_HDRC_TNP_FIL(x) (0x3248 + 4 * (x))
+
+#define LEN_L1_HDRC_UTN_TBL	20
+#define REG_L1_HDRC_UTN_TBL(x) (0x325C + 4 * (x))
+
+#define REG_L1_HDRC_FLR_VAL		   0x32AC
+#define REG_L1_HDRC_FLR_ADP		   0x32B0
+#define REG_L1_HDRC_YBR_OFF		   0x32EC
+#define REG_L1_HDRC_ORGY_BLEND		   0x32F0
+#define REG_L1_HDRC_MAR_TOP		   0x3300
+#define REG_L1_HDRC_MAR_LEFT		   0x3304
+#define REG_L1_CRGBF_ACC_CONF		   0x3700
+#define VAL_L1_CRGBF_ACC_CONF_MODE_BYPASS  0
+#define VAL_L1_CRGBF_ACC_CONF_MODE_BUFFER0 1
+
+#define REG_L1_CRGBF_TRN_A_CONF		 0x370C
+#define VAL_L1_CRGBF_TRN_AUTO_READ_BANK0 BIT(16)
+
+#define REG_L1_CRGBF_INT_STAT	     0x3718
+#define REG_L1_CRGBF_INT_MASK	     0x371C
+#define REG_L1_CRGBF_INT_MASKED_STAT 0x3720
+#define REG_L1_CRGBF_TRN_RBADDR	     0x372C
+#define REG_L1_CRGBF_TRN_READDR	     0x3730
+#define REG_L1_CRGBF_ISP_INT_MASK    0x3738
+#define REG_L2_SENSOR_CROP_OFS_H     0x5000
+#define REG_L2_SENSOR_CROP_OFS_V     0x5004
+#define REG_L2_SENSOR_CROP_HSIZE     0x5008
+#define REG_L2_SENSOR_CROP_VSIZE     0x500C
+#define REG_L2_BUS_L2_STATUS	     0x5018
+#define REG_L2_ROI_NUM		     0x5040
+/* x: 0-1 */
+#define REG_L2_ROI_TO_POST(x)	       (0x5044 + 4 * (x))
+#define REG_L2_ROI_X_BASE(x)	       (0x5050 + 32 * (x))
+#define REG_L2_ROI_X_SCALE(x)	       (REG_L2_ROI_X_BASE(x) + 0)
+#define REG_L2_ROI_X_SCALE_INV(x)       (REG_L2_ROI_X_BASE(x) + 4)
+#define REG_L2_ROI_X_CORRECTED_HSIZE(x) (REG_L2_ROI_X_BASE(x) + 8)
+#define REG_L2_ROI_X_CORRECTED_VSIZE(x) (REG_L2_ROI_X_BASE(x) + 12)
+#define REG_L2_ROI_X_OUT_OFS_H(x)       (REG_L2_ROI_X_BASE(x) + 16)
+#define REG_L2_ROI_X_OUT_HSIZE(x)       (REG_L2_ROI_X_BASE(x) + 24)
+#define REG_L2_ROI_X_OUT_OFS_V(x)       (REG_L2_ROI_X_BASE(x) + 20)
+#define REG_L2_ROI_X_OUT_VSIZE(x)       (REG_L2_ROI_X_BASE(x) + 28)
+#define REG_L2_VALID_R_NORM2_POLY      0x50B0
+#define REG_L2_VALID_R_NORM2_GRID      0x50B4
+#define REG_L2_MODE		       0x5100
+#define REG_L2_NORM_SCALE	       0x5104
+#define REG_L2_ROI_WRITE_AREA_DELTA(x) (0x510C + 4 * (x))
+#define REG_L2_GRID_NODE_NUM_H	       0x5118
+#define REG_L2_GRID_NODE_NUM_V	       0x511C
+#define REG_L2_GRID_PATCH_HSIZE_INV    0x5120
+#define REG_L2_GRID_PATCH_VSIZE_INV    0x5124
+/* x: 0-10 */
+#define REG_L2_POLY10_WRITE_G_COEF(x) (0x5128 + 4 * (x))
+#define REG_L2_POLY10_READ_B_COEF(x)  (0x5154 + 4 * (x))
+#define REG_L2_POLY10_READ_G_COEF(x)  (0x5180 + 4 * (x))
+#define REG_L2_POLY10_READ_R_COEF(x)  (0x51AC + 4 * (x))
+/* x: 0-1 */
+#define REG_L2_POST_X_BASE(x)		   (0x5200 + 256 * (x))
+#define REG_L2_POST_X_CAP_OFFSET(x)	   (REG_L2_POST_X_BASE(x) + 0)
+#define REG_L2_POST_X_CAP_SIZE(x)	   (REG_L2_POST_X_BASE(x) + 4)
+#define REG_L2_POST_X_CSC_MTB_CB1(x)	   (REG_L2_POST_X_BASE(x) + 148)
+#define REG_L2_POST_X_CSC_MTB_CB2(x)	   (REG_L2_POST_X_BASE(x) + 152)
+#define REG_L2_POST_X_CSC_MTB_CB_OFFSETI(x) (REG_L2_POST_X_BASE(x) + 144)
+#define REG_L2_POST_X_CSC_MTB_CB_OFFSETO(x) (REG_L2_POST_X_BASE(x) + 156)
+#define REG_L2_POST_X_CSC_MTB_CR1(x)	   (REG_L2_POST_X_BASE(x) + 164)
+#define REG_L2_POST_X_CSC_MTB_CR2(x)	   (REG_L2_POST_X_BASE(x) + 168)
+#define REG_L2_POST_X_CSC_MTB_CR_OFFSETI(x) (REG_L2_POST_X_BASE(x) + 160)
+#define REG_L2_POST_X_CSC_MTB_CR_OFFSETO(x) (REG_L2_POST_X_BASE(x) + 172)
+#define REG_L2_POST_X_CSC_MTB(x)		   (REG_L2_POST_X_BASE(x) + 112)
+#define REG_L2_POST_X_CSC_MTB_YG1(x)	   (REG_L2_POST_X_BASE(x) + 132)
+#define REG_L2_POST_X_CSC_MTB_YG2(x)	   (REG_L2_POST_X_BASE(x) + 136)
+#define REG_L2_POST_X_CSC_MTB_YG_OFFSETI(x) (REG_L2_POST_X_BASE(x) + 128)
+#define REG_L2_POST_X_CSC_MTB_YG_OFFSETO(x) (REG_L2_POST_X_BASE(x) + 140)
+#define FIELD_CSC_MTB_UPPER(x)		   (FIELD_PREP(0xFFFF0000, (x)))
+#define FIELD_CSC_MTB_LOWER(x)		   (FIELD_PREP(0x0000FFFF, (x)))
+
+#define REG_L2_POST_X_C_SELECT(x)	 (REG_L2_POST_X_BASE(x) + 96)
+#define REG_L2_POST_X_GAMMA_M(x)		 (REG_L2_POST_X_BASE(x) + 80)
+#define REG_L2_POST_X_HALF_SCALE_EN(x)	 (REG_L2_POST_X_BASE(x) + 8)
+#define REG_L2_POST_X_OPORTALP(x)	 (REG_L2_POST_X_BASE(x) + 176)
+#define REG_L2_POST_X_OPORTFMT(x)	 (REG_L2_POST_X_BASE(x) + 180)
+#define REG_L2_POST_X_OUT_PITCH_B(x)	 (REG_L2_POST_X_BASE(x) + 196)
+#define REG_L2_POST_X_OUT_PITCH_G(x)	 (REG_L2_POST_X_BASE(x) + 200)
+#define REG_L2_POST_X_OUT_PITCH_R(x)	 (REG_L2_POST_X_BASE(x) + 204)
+#define REG_L2_POST_X_OUT_STADR_B(x)	 (REG_L2_POST_X_BASE(x) + 184)
+#define REG_L2_POST_X_OUT_STADR_G(x)	 (REG_L2_POST_X_BASE(x) + 188)
+#define REG_L2_POST_X_OUT_STADR_R(x)	 (REG_L2_POST_X_BASE(x) + 192)
+#define REG_L2_CRGBF_TRN_A_CONF		 0x570C
+#define VAL_L2_CRGBF_TRN_AUTO_READ_BANK0 BIT(16)
+
+#define REG_L2_CRGBF_INT_STAT		  0x5718
+#define REG_L2_CRGBF_INT_MASK		  0x571C
+#define REG_L2_CRGBF_INT_MASKED_STAT	  0x5720
+#define REG_L2_CRGBF_TRN_RBADDR		  0x572C
+#define REG_L2_CRGBF_TRN_READDR		  0x5730
+#define REG_L2_CRGBF_ISP_INT		  0x5734
+#define REG_L2_CRGBF_ISP_INT_MASK	  0x5738
+#define MASK_L2_CRGBF_ISP_INT_DONE	  BIT(0)
+#define MASK_L2_CRGBF_ISP_INT_ABORT_POST0 BIT(1)
+#define MASK_L2_CRGBF_ISP_INT_ABORT_POST1 BIT(2)
+#define MASK_L2_CRGBF_ISP_INT_ABORT_OTHER BIT(4)
+#define MASK_L2_STATUS_ERR_ALL                                                   \
+	(MASK_L2_CRGBF_ISP_INT_ABORT_POST0 | MASK_L2_CRGBF_ISP_INT_ABORT_POST1 | \
+	 MASK_L2_CRGBF_ISP_INT_ABORT_OTHER)
+
+/*=============================================*/
+/* HWA bus interface registers */
+/*=============================================*/
+#define REG_HWAIF_HWAIF_EN	  0
+#define REG_HWAIF_HWAIF_CONF	  0x10
+#define REG_HWAIF_OSTD_RLEN	  0x14
+#define REG_HWAIF_OSTD_WREQ	  0x18
+#define REG_HWAIF_REGION_ENTRY_EN 0xF0
+
+/*=============================================*/
+/* Memory Protection Unit registers */
+/*=============================================*/
+#define REG_MPU_MP_EN 0
+#define REG_MPU_MF_EN 0x3A4
+
+#endif /* VIIF_REGS_H */
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c3604a0a3e30..ea00cbcd4cbb 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -203,6 +203,12 @@ enum v4l2_colorfx {
  */
 #define V4L2_CID_USER_ASPEED_BASE		(V4L2_CID_USER_BASE + 0x11a0)
 
+/*
+ * The base for Toshiba Visconti VIIF driver controls
+ * We reserve 32 controls for this driver
+ */
+#define V4L2_CID_USER_VISCONTI_BASE		(V4L2_CID_USER_BASE + 0x11b0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
diff --git a/include/uapi/linux/visconti_viif.h b/include/uapi/linux/visconti_viif.h
new file mode 100644
index 000000000000..957b1fa6545a
--- /dev/null
+++ b/include/uapi/linux/visconti_viif.h
@@ -0,0 +1,1800 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef __UAPI_VISCONTI_VIIF_H_
+#define __UAPI_VISCONTI_VIIF_H_
+
+#include <linux/types.h>
+#include <linux/v4l2-controls.h>
+
+/* Visconti specific compound controls */
+#define V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE	       (V4L2_CID_USER_VISCONTI_BASE + 1)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE	       (V4L2_CID_USER_VISCONTI_BASE + 2)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF	       (V4L2_CID_USER_VISCONTI_BASE + 3)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE	       (V4L2_CID_USER_VISCONTI_BASE + 4)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG		       (V4L2_CID_USER_VISCONTI_BASE + 5)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE		       (V4L2_CID_USER_VISCONTI_BASE + 6)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION       (V4L2_CID_USER_VISCONTI_BASE + 7)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC		       (V4L2_CID_USER_VISCONTI_BASE + 8)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE (V4L2_CID_USER_VISCONTI_BASE + 9)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION \
+	(V4L2_CID_USER_VISCONTI_BASE + 10)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS			 (V4L2_CID_USER_VISCONTI_BASE + 11)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION (V4L2_CID_USER_VISCONTI_BASE + 12)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC			 (V4L2_CID_USER_VISCONTI_BASE + 13)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS		 (V4L2_CID_USER_VISCONTI_BASE + 14)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB			 (V4L2_CID_USER_VISCONTI_BASE + 15)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN		 (V4L2_CID_USER_VISCONTI_BASE + 16)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC			 (V4L2_CID_USER_VISCONTI_BASE + 17)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM		 (V4L2_CID_USER_VISCONTI_BASE + 18)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA			 (V4L2_CID_USER_VISCONTI_BASE + 19)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT (V4L2_CID_USER_VISCONTI_BASE + 20)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION	 (V4L2_CID_USER_VISCONTI_BASE + 21)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST		 (V4L2_CID_USER_VISCONTI_BASE + 22)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI			 (V4L2_CID_USER_VISCONTI_BASE + 23)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA			 (V4L2_CID_USER_VISCONTI_BASE + 24)
+#define V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS	 (V4L2_CID_USER_VISCONTI_BASE + 25)
+#define V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS		 (V4L2_CID_USER_VISCONTI_BASE + 26)
+#define V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS		 (V4L2_CID_USER_VISCONTI_BASE + 27)
+#define V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS		 (V4L2_CID_USER_VISCONTI_BASE + 28)
+
+/* Enable/Disable flag */
+#define VIIF_DISABLE (0U)
+#define VIIF_ENABLE  (1U)
+
+/**
+ * enum viif_rawpack_mode - RAW pack mode for :ref:`V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE`
+ *
+ * @VIIF_RAWPACK_DISABLE: RAW pack disable
+ * @VIIF_RAWPACK_MSBFIRST: RAW pack enable (MSB First)
+ * @VIIF_RAWPACK_LSBFIRST: RAW pack enable (LSB First)
+ */
+enum viif_rawpack_mode {
+	VIIF_RAWPACK_DISABLE = 0,
+	VIIF_RAWPACK_MSBFIRST = 2,
+	VIIF_RAWPACK_LSBFIRST = 3,
+};
+
+/**
+ * enum viif_l1_input - L1ISP preprocessing mode,
+ * referred by :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE`
+ *
+ * @VIIF_L1_INPUT_HDR: bypass(HDR input)
+ * @VIIF_L1_INPUT_PWL: HDRE(PWL input)
+ * @VIIF_L1_INPUT_HDR_IMG_CORRECT: SLIC-ABPC-PWHB-RCNR-HDRS
+ * @VIIF_L1_INPUT_PWL_IMG_CORRECT: HDRE-SLIC-ABPC-PWHB-RCNR-HDRS
+ */
+enum viif_l1_input {
+	VIIF_L1_INPUT_HDR = 0,
+	VIIF_L1_INPUT_PWL = 1,
+	VIIF_L1_INPUT_HDR_IMG_CORRECT = 3,
+	VIIF_L1_INPUT_PWL_IMG_CORRECT = 4,
+};
+
+/**
+ * enum viif_l1_raw - L1ISP RAW color filter mode,
+ * referred by :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE`
+ *
+ * @VIIF_L1_RAW_GR_R_B_GB: Gr-R-B-Gb
+ * @VIIF_L1_RAW_R_GR_GB_B: R-Gr-Gb-B
+ * @VIIF_L1_RAW_B_GB_GR_R: B-Gb-Gr-R
+ * @VIIF_L1_RAW_GB_B_R_GR: Gb-B-R-Gr
+ */
+enum viif_l1_raw {
+	VIIF_L1_RAW_GR_R_B_GB = 0,
+	VIIF_L1_RAW_R_GR_GB_B = 1,
+	VIIF_L1_RAW_B_GB_GR_R = 2,
+	VIIF_L1_RAW_GB_B_R_GR = 3,
+};
+
+/**
+ * struct viif_l1_input_mode_config - L1ISP INPUT MODE parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE`
+ *
+ * @mode: &enum viif_l1_input value.
+ * @depth: Color depth (even only). Range for each L1ISP pre-processing mode is:
+ *
+ *  - VIIF_L1_INPUT_HDR, VIIF_L1_INPUT_HDR_IMG_CORRECT: Range: [8..24].
+ *  - VIIF_L1_INPUT_PWL, VIIF_L1_INPUT_PWL_IMG_CORRECT: Range: [8..14].
+ * @raw_color_filter: &enum viif_l1_raw value.
+ */
+struct viif_l1_input_mode_config {
+	__u32 mode;
+	__u32 depth;
+	__u32 raw_color_filter;
+};
+
+/**
+ * struct viif_l1_rgb_to_y_coef_config - L1ISP coefficient for calculating
+ * Y from RGB parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF`
+ * @coef_r: R co-efficient. Range: [256..65024], Accuracy: 1/65536.
+ * @coef_g: G co-efficient. Range: [256..65024], Accuracy: 1/65536.
+ * @coef_b: B co-efficient. Range: [256..65024], Accuracy: 1/65536.
+ */
+struct viif_l1_rgb_to_y_coef_config {
+	__u16 coef_r;
+	__u16 coef_g;
+	__u16 coef_b;
+};
+
+/**
+ * enum viif_l1_img_sensitivity_mode - L1ISP image sensitivity
+ *
+ * @VIIF_L1_IMG_SENSITIVITY_HIGH: high sensitivity
+ * @VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED: middle sensitivity or led
+ * @VIIF_L1_IMG_SENSITIVITY_LOW: low sensitivity
+ */
+enum viif_l1_img_sensitivity_mode {
+	VIIF_L1_IMG_SENSITIVITY_HIGH = 0,
+	VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED = 1,
+	VIIF_L1_IMG_SENSITIVITY_LOW = 2,
+};
+
+/**
+ * struct viif_l1_ag_mode_config - L1ISP AG mode parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE`
+ * @sysm_ag_grad: Analog gain slope. Range: [0..255], Index corresponds to psel id.
+ * @sysm_ag_ofst: Analog gain offset. Range: [0..65535], Index corresponds to psel id.
+ * @sysm_ag_cont_hobc_en_high: set 1 to enable  control analog gain
+ *                             for high sensitivity image of OBCC
+ * @sysm_ag_psel_hobc_high: Analog gain id for high sensitivity image of OBCC. Range: [0..3]
+ * @sysm_ag_cont_hobc_en_middle_led: set 1 to enable control analog gain
+ *                                   for middle sensitivity or LED image of OBCC
+ * @sysm_ag_psel_hobc_middle_led: Analog gain id for middle sensitivity
+ *                                or LED image of OBCC. Range: [0..3]
+ * @sysm_ag_cont_hobc_en_low: set 1 to enable control analog gain
+ *                            for low sensitivity image of OBCC
+ * @sysm_ag_psel_hobc_low: Analog gain id for low sensitivity image of OBCC. Range:[0..3]
+ * @sysm_ag_cont_abpc_en_high: set 1 to enable control analog gain
+ *                             for high sensitivity image of ABPC
+ * @sysm_ag_psel_abpc_high: Analog gain id for high sensitivity image of ABPC. Range: [0..3]
+ * @sysm_ag_cont_abpc_en_middle_led: set 1 to enable control analog gain
+ *                                   for middle sensitivity or LED image of ABPC
+ * @sysm_ag_psel_abpc_middle_led: Analog gain id for middle sensitivity
+ *                                or LED image of ABPC. Range: [0..3]
+ * @sysm_ag_cont_abpc_en_low: set 1 to enable control analog gain
+ *                            for low sensitivity image of ABPC
+ * @sysm_ag_psel_abpc_low: Analog gain id for low sensitivity image of ABPC. Range: [0..3]
+ * @sysm_ag_cont_rcnr_en_high: set 1 to enable control analog gain
+ *                             for high sensitivity image of RCNR
+ * @sysm_ag_psel_rcnr_high: Analog gain id for high sensitivity image of RCNR. Range: [0..3]
+ * @sysm_ag_cont_rcnr_en_middle_led: set 1 to enable control analog gain
+ *                                   for middle sensitivity or LED image of RCNR
+ * @sysm_ag_psel_rcnr_middle_led: Analog gain id for middle sensitivity
+ *                                or LED image of RCNR. Range: [0..3]
+ * @sysm_ag_cont_rcnr_en_low: set 1 to enable control analog gain
+ *                            for low sensitivity image of RCNR
+ * @sysm_ag_psel_rcnr_low: Analog gain id for low sensitivity image of RCNR. Range: [0..3]
+ * @sysm_ag_cont_lssc_en: set 1 to enable control analog gain for LSC
+ * @sysm_ag_ssel_lssc: &enum viif_l1_img_sensitivity_mode value. Sensitive image used for LSC.
+ * @sysm_ag_psel_lssc: Analog gain id for LSC. Range: [0..3]
+ * @sysm_ag_cont_mpro_en: set 1 to enable control analog gain for color matrix
+ * @sysm_ag_ssel_mpro: &enum viif_l1_img_sensitivity_mode value.
+ *                     Sensitive image used for color matrix.
+ * @sysm_ag_psel_mpro: Analog gain id for color matrix. Range: [0..3]
+ * @sysm_ag_cont_vpro_en: set 1 to enable control analog gain for image adjustment
+ * @sysm_ag_ssel_vpro: &enum viif_l1_img_sensitivity_mode value.
+ *                     Sensitive image used for image adjustment.
+ * @sysm_ag_psel_vpro: Analog gain id for image adjustment. Range: [0..3]
+ * @sysm_ag_cont_hobc_test_high: Manual analog gain for high sensitivity image
+ *                               of OBCC. Range: [0..255]
+ * @sysm_ag_cont_hobc_test_middle_led: Manual analog gain for middle sensitivity
+ *                                     or led image of OBCC. Range: [0..255]
+ * @sysm_ag_cont_hobc_test_low: Manual analog gain for low sensitivity image
+ *                              of OBCC. Range: [0..255]
+ * @sysm_ag_cont_abpc_test_high: Manual analog gain for high sensitivity image
+ *                               of ABPC. Range: [0..255]
+ * @sysm_ag_cont_abpc_test_middle_led: Manual analog gain for middle sensitivity
+ *                                     or led image of ABPC. Range: [0..255]
+ * @sysm_ag_cont_abpc_test_low: Manual analog gain for low sensitivity image
+ *                              of ABPC. Range: [0..255]
+ * @sysm_ag_cont_rcnr_test_high: Manual analog gain for high sensitivity image
+ *                               of RCNR. Range:  [0..255]
+ * @sysm_ag_cont_rcnr_test_middle_led: Manual analog gain for middle sensitivity
+ *                                     or led image of RCNR. Range: [0..255]
+ * @sysm_ag_cont_rcnr_test_low: Manual analog gain for low sensitivity image
+ *                              of RCNR. Range:  [0..255]
+ * @sysm_ag_cont_lssc_test: Manual analog gain for LSSC. Range: [0..255]
+ * @sysm_ag_cont_mpro_test: Manual analog gain for color matrix. Range: [0..255]
+ * @sysm_ag_cont_vpro_test: Manual analog gain for image adjustment. Range: [0..255]
+ *
+ * Configuration of analog gain generation for each L1ISP module.
+ *
+ * If sysm_ag_cont_xxxx_en = 1, analog_gain for each module is generated from
+ * sysm_ag_grad, sysm_ag_ofst and the value specified at
+ * :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG`.
+ * If sysm_ag_cont_xxxx_en = 0,
+ * the value of sysm_ag_cont_xxxx_test is used for analog_gain for each module.
+ *
+ * Up to 4 sets of parameters (sysm_ag_grad[4] and sysm_ag_ofst[4]) can be used
+ * to generate analog gain.
+ * The parameter sysm_ag_psel_xxxx specifies the set to be used for module xxxx.
+ * For example, if sysm_ag_psel_hobc_high is set to 2,
+ * values in sysm_ag_grad[2] and sysm_ag_ofst[2] are used
+ * to generate analog gain for high sensitivity images in OBCC processing.
+ *
+ * Analog gain generation for each L1ISP module is disabled when
+ * "sysm_ag_cont_xxxx_en=0" and "sysm_ag_cont_xxxx_test=0".
+ * Be sure to disable the analog gain generation
+ * if VIIF_L1_INPUT_HDR or VIIF_L1_INPUT_PWL is set to
+ * :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE`.
+ *
+ */
+struct viif_l1_ag_mode_config {
+	__u8 sysm_ag_grad[4];
+	__u16 sysm_ag_ofst[4];
+	__u32 sysm_ag_cont_hobc_en_high;
+	__u32 sysm_ag_psel_hobc_high;
+	__u32 sysm_ag_cont_hobc_en_middle_led;
+	__u32 sysm_ag_psel_hobc_middle_led;
+	__u32 sysm_ag_cont_hobc_en_low;
+	__u32 sysm_ag_psel_hobc_low;
+	__u32 sysm_ag_cont_abpc_en_high;
+	__u32 sysm_ag_psel_abpc_high;
+	__u32 sysm_ag_cont_abpc_en_middle_led;
+	__u32 sysm_ag_psel_abpc_middle_led;
+	__u32 sysm_ag_cont_abpc_en_low;
+	__u32 sysm_ag_psel_abpc_low;
+	__u32 sysm_ag_cont_rcnr_en_high;
+	__u32 sysm_ag_psel_rcnr_high;
+	__u32 sysm_ag_cont_rcnr_en_middle_led;
+	__u32 sysm_ag_psel_rcnr_middle_led;
+	__u32 sysm_ag_cont_rcnr_en_low;
+	__u32 sysm_ag_psel_rcnr_low;
+	__u32 sysm_ag_cont_lssc_en;
+	__u32 sysm_ag_ssel_lssc;
+	__u32 sysm_ag_psel_lssc;
+	__u32 sysm_ag_cont_mpro_en;
+	__u32 sysm_ag_ssel_mpro;
+	__u32 sysm_ag_psel_mpro;
+	__u32 sysm_ag_cont_vpro_en;
+	__u32 sysm_ag_ssel_vpro;
+	__u32 sysm_ag_psel_vpro;
+	__u8 sysm_ag_cont_hobc_test_high;
+	__u8 sysm_ag_cont_hobc_test_middle_led;
+	__u8 sysm_ag_cont_hobc_test_low;
+	__u8 sysm_ag_cont_abpc_test_high;
+	__u8 sysm_ag_cont_abpc_test_middle_led;
+	__u8 sysm_ag_cont_abpc_test_low;
+	__u8 sysm_ag_cont_rcnr_test_high;
+	__u8 sysm_ag_cont_rcnr_test_middle_led;
+	__u8 sysm_ag_cont_rcnr_test_low;
+	__u8 sysm_ag_cont_lssc_test;
+	__u8 sysm_ag_cont_mpro_test;
+	__u8 sysm_ag_cont_vpro_test;
+};
+
+/**
+ * struct viif_l1_ag_config - L1ISP AG parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG`
+ * @gain_h: Analog gain for high sensitive image. Range: [0..65535].
+ * @gain_m: Analog gain for middle sensitive image or LED image. Range: [0..65535].
+ * @gain_l: Analog gain for low sensitive image. Range:  [0..65535].
+ */
+struct viif_l1_ag_config {
+	__u16 gain_h;
+	__u16 gain_m;
+	__u16 gain_l;
+};
+
+/**
+ * struct viif_l1_hdre_config - L1ISP HDRE parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE`
+ * @hdre_src_point: Knee point N value of PWL compressed signal. Range: [0..0x3FFF].
+ * @hdre_dst_base: Offset value of HDR signal in Knee area M. Range: [0..0xFFFFFF].
+ * @hdre_ratio: Slope of output pixel value in Knee area M.
+ *              Range: [0..0x3FFFFF], Accuracy: 1/64.
+ * @hdre_dst_max_val: Maximum value of output pixel. Range: [0..0xFFFFFF].
+ */
+struct viif_l1_hdre_config {
+	__u32 hdre_src_point[16];
+	__u32 hdre_dst_base[17];
+	__u32 hdre_ratio[17];
+	__u32 hdre_dst_max_val;
+};
+
+/**
+ * struct viif_l1_img_extraction_config -  L1ISP image extraction parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION`
+ * @input_black_gr: Black level of input pixel (Gr). Range: [0..0xFFFFFF].
+ * @input_black_r: Black level of input pixel (R). Range: [0..0xFFFFFF].
+ * @input_black_b: Black level of input pixel (B). Range: [0..0xFFFFFF].
+ * @input_black_gb: Black level of input pixel (Gb). Range: [0..0xFFFFFF].
+ */
+struct viif_l1_img_extraction_config {
+	__u32 input_black_gr;
+	__u32 input_black_r;
+	__u32 input_black_b;
+	__u32 input_black_gb;
+};
+
+/**
+ * enum viif_l1_dpc_mode - L1ISP defect pixel correction mode
+ * @VIIF_L1_DPC_1PIXEL: 1 pixel correction mode
+ * @VIIF_L1_DPC_2PIXEL: 2 pixel correction mode
+ */
+enum viif_l1_dpc_mode {
+	VIIF_L1_DPC_1PIXEL = 0,
+	VIIF_L1_DPC_2PIXEL = 1,
+};
+
+/**
+ * struct viif_l1_dpc - L1ISP defect pixel correction parameters
+ * for &struct viif_l1_dpc_config
+ * @abpc_sta_en: 1:enable/0:disable setting of Static DPC
+ * @abpc_dyn_en: 1:enable/0:disable setting of Dynamic DPC
+ * @abpc_dyn_mode: &enume viif_l1_dpc_mode value. Sets dynamic DPC mode.
+ * @abpc_ratio_limit: Variation adjustment of dynamic DPC. Range: [0..1023].
+ * @abpc_dark_limit: White defect judgment limit of dark area. Range: [0..1023].
+ * @abpc_sn_coef_w_ag_min: Luminance difference adjustment of white DPC
+ *                         (undere lower threshold).
+ * @abpc_sn_coef_w_ag_mid: Luminance difference adjustment of white DPC
+ *                         (between lower and upper threshold).
+ * @abpc_sn_coef_w_ag_max: Luminance difference adjustment of white DPC
+ *                         (over upper threshold).
+ * @abpc_sn_coef_b_ag_min: Luminance difference adjustment of black DPC
+ *                         (undere lower threshold).
+ * @abpc_sn_coef_b_ag_mid: Luminance difference adjustment of black DPC
+ *                         (between lower and upper threshold).
+ * @abpc_sn_coef_b_ag_max: Luminance difference adjustment of black DPC
+ *                         (over upper threshold).
+ * @abpc_sn_coef_w_th_min: Luminance difference adjustment of white DPC
+ *                         analog gain lower threshold.
+ * @abpc_sn_coef_w_th_max: Luminance difference adjustment of white DPC
+ *                         analog gain upper threshold.
+ * @abpc_sn_coef_b_th_min: Luminance difference adjustment of black DPC
+ *                         analog gain lower threshold.
+ * @abpc_sn_coef_b_th_max: Luminance difference adjustment of black DPC
+ *                         analog gain upper threshold.
+ *
+ * Range of abpc_sn_coef_{w,b}_ag_{min,mid,max} is:
+ *
+ * - Range: [1..31]
+ *
+ * Range and constraints of sn_coef_{w,b}_th_{min,max} are:
+ *
+ * - Range: [0..255]
+ * - Constraint: abpc_sn_coef_w_th_min < abpc_sn_coef_w_th_max
+ * - Constraint: abpc_sn_coef_b_th_min < abpc_sn_coef_b_th_max
+ */
+struct viif_l1_dpc {
+	__u32 abpc_sta_en;
+	__u32 abpc_dyn_en;
+	__u32 abpc_dyn_mode;
+	__u32 abpc_ratio_limit;
+	__u32 abpc_dark_limit;
+	__u32 abpc_sn_coef_w_ag_min;
+	__u32 abpc_sn_coef_w_ag_mid;
+	__u32 abpc_sn_coef_w_ag_max;
+	__u32 abpc_sn_coef_b_ag_min;
+	__u32 abpc_sn_coef_b_ag_mid;
+	__u32 abpc_sn_coef_b_ag_max;
+	__u8 abpc_sn_coef_w_th_min;
+	__u8 abpc_sn_coef_w_th_max;
+	__u8 abpc_sn_coef_b_th_min;
+	__u8 abpc_sn_coef_b_th_max;
+};
+
+/**
+ * struct viif_l1_dpc_config - L1ISP defect pixel correction parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC`
+ * @param_h: DPC parameter for high sensitive image. Refer to &struct viif_l1_dpc
+ * @param_m: DPC parameter for middle sensitive image. Refer to &struct viif_l1_dpc
+ * @param_l: DPC parameter for low sensitive image. Refer to &struct viif_l1_dpc
+ * @table_h: DPC table for high sensitive image.
+ *           The table is referred only when param_h.abpc_sta_en =1
+ * @table_m: DPC table for middle sensitive image or LED image.
+ *           The table is referred only when param_m.abpc_sta_en =1
+ * @table_l: DPC table for low sensitive image.
+ *           The table is referred only when param_l.abpc_sta_en =1
+ *
+ * The size of each table is 8192 Bytes (u32 * 2048)
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the DPC table.
+ */
+struct viif_l1_dpc_config {
+	struct viif_l1_dpc param_h;
+	struct viif_l1_dpc param_m;
+	struct viif_l1_dpc param_l;
+	__u32 table_h[2048];
+	__u32 table_m[2048];
+	__u32 table_l[2048];
+};
+
+/**
+ * struct viif_l1_preset_wb - L1ISP  preset white balance parameters
+ * for &struct viif_l1_preset_white_balance_config
+ * @gain_gr: Gr gain. Range: [0..524287], Accuracy 1/16384
+ * @gain_r: R gain. Range: [0..524287], Accuracy 1/16384
+ * @gain_b: B gain. Range: [0..524287], Accuracy 1/16384
+ * @gain_gb: Gb gain. Range: [0..524287], Accuracy 1/16384
+ */
+struct viif_l1_preset_wb {
+	__u32 gain_gr;
+	__u32 gain_r;
+	__u32 gain_b;
+	__u32 gain_gb;
+};
+
+/**
+ * struct viif_l1_preset_white_balance_config - L1ISP  preset white balance
+ * parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE`
+ * @dstmaxval: Maximum value of output pixel. Range: [0..4095]
+ * @param_h: Preset white balance parameter for high sensitive image.
+ *           Refer to &struct viif_l1_preset_wb
+ * @param_m: Preset white balance parameters for middle sensitive image or LED image.
+ *           Refer to &struct viif_l1_preset_wb
+ * @param_l: Preset white balance parameters for low sensitive image.
+ *           Refer to &struct viif_l1_preset_wb
+ */
+struct viif_l1_preset_white_balance_config {
+	__u32 dstmaxval;
+	struct viif_l1_preset_wb param_h;
+	struct viif_l1_preset_wb param_m;
+	struct viif_l1_preset_wb param_l;
+};
+
+/**
+ * enum viif_l1_rcnr_type - L1ISP high resolution luminance filter type
+ *
+ * @VIIF_L1_RCNR_LOW_RESOLUTION: low resolution
+ * @VIIF_L1_RCNR_MIDDLE_RESOLUTION: middle resolution
+ * @VIIF_L1_RCNR_HIGH_RESOLUTION: high resolution
+ * @VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION: ultra high resolution
+ */
+enum viif_l1_rcnr_type {
+	VIIF_L1_RCNR_LOW_RESOLUTION = 0,
+	VIIF_L1_RCNR_MIDDLE_RESOLUTION = 1,
+	VIIF_L1_RCNR_HIGH_RESOLUTION = 2,
+	VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION = 3,
+};
+
+/**
+ * enum viif_l1_msf_blend_ratio - L1ISP MSF blend ratio
+ *
+ * @VIIF_L1_MSF_BLEND_RATIO_0_DIV_64: 0/64
+ * @VIIF_L1_MSF_BLEND_RATIO_1_DIV_64: 1/64
+ * @VIIF_L1_MSF_BLEND_RATIO_2_DIV_64: 2/64
+ */
+enum viif_l1_msf_blend_ratio {
+	VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 = 0,
+	VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 = 1,
+	VIIF_L1_MSF_BLEND_RATIO_2_DIV_64 = 2,
+};
+
+/**
+ * struct viif_l1_raw_color_noise_reduction - L1ISP RCNR parameters
+ * for &struct viif_l1_raw_color_noise_reduction_config
+ * @rcnr_sw: set 1 to enable RAW color noise reduction, 0 to disable.
+ * @rcnr_cnf_dark_ag0: Maximum value of LSF dark noise adjustment. Range: [0..63].
+ * @rcnr_cnf_dark_ag1: Middle value of LSF dark noise adjustment. Range: [0..63].
+ * @rcnr_cnf_dark_ag2: Minimum value of LSF dark noise adjustment. Range: [0..63].
+ * @rcnr_cnf_ratio_ag0: Maximum value of LSF luminance interlocking noise adjustment.
+ *                      Range: [0..31].
+ * @rcnr_cnf_ratio_ag1: Middle value of LSF luminance interlocking noise adjustment:
+ *                      Range: [0..31].
+ * @rcnr_cnf_ratio_ag2: Minimum value of LSF luminance interlocking noise adjustment:
+ *                      Range: [0..31].
+ * @rcnr_cnf_clip_gain_r: LSF color correction limit adjustment gain R. Range: [0..3].
+ * @rcnr_cnf_clip_gain_g: LSF color correction limit adjustment gain G. Range: [0..3].
+ * @rcnr_cnf_clip_gain_b: LSF color correction limit adjustment gain B. Range: [0..3].
+ * @rcnr_a1l_dark_ag0: Maximum value of MSF dark noise adjustment. Range: [0..63].
+ * @rcnr_a1l_dark_ag1: Middle value of MSF dark noise adjustment. Range: [0..63].
+ * @rcnr_a1l_dark_ag2: Minimum value of MSF dark noise adjustment. Range: [0..63].
+ * @rcnr_a1l_ratio_ag0: Maximum value of MSF luminance interlocking noise adjustment.
+ *                      Range: [0..31].
+ * @rcnr_a1l_ratio_ag1: Middle value of MSF luminance interlocking noise adjustment.
+ *                      Range: [0..31].
+ * @rcnr_a1l_ratio_ag2: Minimum value of MSF luminance interlocking noise adjustment.
+ *                      Range: [0..31].
+ * @rcnr_inf_zero_clip: Input stage zero clip setting. Range: [0..256].
+ * @rcnr_merge_d2blend_ag0: Maximum value of filter results and input blend ratio. Range: [0..16].
+ * @rcnr_merge_d2blend_ag1: Middle value of filter results and input blend ratio. Range: [0..16].
+ * @rcnr_merge_d2blend_ag2: Minimum value of filter results and input blend ratio. Range: [0..16].
+ * @rcnr_merge_black: Black level minimum value. Range: [0..64].
+ * @rcnr_merge_mindiv: 0 div guard value of inverse arithmetic unit. Range: [4..16].
+ * @rcnr_hry_type: &enum viif_l1_rcnr_type value. Filter type for HSF filter process.
+ * @rcnr_anf_blend_ag0: &enum viif_l1_msf_blend_ratio value.
+ *                      Maximum value of MSF result blend ratio in write back data to line memory.
+ * @rcnr_anf_blend_ag1: &enum viif_l1_msf_blend_ratio value.
+ *                      Middle value of MSF result blend ratio in write back data to line memory.
+ * @rcnr_anf_blend_ag2: &enum viif_l1_msf_blend_ratio value.
+ *                      Minimum value of MSF result blend ratio in write back data to line memory.
+ * @rcnr_lpf_threshold: Multiplier value for calculating dark noise / luminance
+ *                      interlock noise of MSF. Range: [0..31], Accuracy: 1/8.
+ * @rcnr_merge_hlblend_ag0: Maximum value of luminance signal generation blend. Range: [0..2].
+ * @rcnr_merge_hlblend_ag1: Middle value of luminance signal generation blend. Range: [0..2].
+ * @rcnr_merge_hlblend_ag2: Minimum value of luminance signal generation blend. Range: [0..2].
+ * @rcnr_gnr_sw: set 1 to enable Gr/Gb sensitivity ratio correction function switching,
+ *                0 to disable.
+ * @rcnr_gnr_ratio: Upper limit of Gr/Gb sensitivity ratio correction factor. Range: [0..15].
+ * @rcnr_gnr_wide_en: set 1 to double correction upper limit ratio of rcnr_gnr_ratio,
+ *                    0 to just use the specified ratio.
+ */
+struct viif_l1_raw_color_noise_reduction {
+	__u32 rcnr_sw;
+	__u32 rcnr_cnf_dark_ag0;
+	__u32 rcnr_cnf_dark_ag1;
+	__u32 rcnr_cnf_dark_ag2;
+	__u32 rcnr_cnf_ratio_ag0;
+	__u32 rcnr_cnf_ratio_ag1;
+	__u32 rcnr_cnf_ratio_ag2;
+	__u32 rcnr_cnf_clip_gain_r;
+	__u32 rcnr_cnf_clip_gain_g;
+	__u32 rcnr_cnf_clip_gain_b;
+	__u32 rcnr_a1l_dark_ag0;
+	__u32 rcnr_a1l_dark_ag1;
+	__u32 rcnr_a1l_dark_ag2;
+	__u32 rcnr_a1l_ratio_ag0;
+	__u32 rcnr_a1l_ratio_ag1;
+	__u32 rcnr_a1l_ratio_ag2;
+	__u32 rcnr_inf_zero_clip;
+	__u32 rcnr_merge_d2blend_ag0;
+	__u32 rcnr_merge_d2blend_ag1;
+	__u32 rcnr_merge_d2blend_ag2;
+	__u32 rcnr_merge_black;
+	__u32 rcnr_merge_mindiv;
+	__u32 rcnr_hry_type;
+	__u32 rcnr_anf_blend_ag0;
+	__u32 rcnr_anf_blend_ag1;
+	__u32 rcnr_anf_blend_ag2;
+	__u32 rcnr_lpf_threshold;
+	__u32 rcnr_merge_hlblend_ag0;
+	__u32 rcnr_merge_hlblend_ag1;
+	__u32 rcnr_merge_hlblend_ag2;
+	__u32 rcnr_gnr_sw;
+	__u32 rcnr_gnr_ratio;
+	__u32 rcnr_gnr_wide_en;
+};
+
+/**
+ * struct viif_l1_raw_color_noise_reduction_config - L1ISP RCNR parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION`
+ * @param_h: RAW color noise reduction parameter for high sensitive image.
+ *           Refer to &struct viif_l1_raw_color_noise_reduction
+ * @param_m: RAW color noise reduction parameter for middle sensitive image or LED image.
+ *           Refer to &struct viif_l1_raw_color_noise_reduction
+ * @param_l: RAW color noise reduction parameter for low sensitive image.
+ *           Refer to &struct viif_l1_raw_color_noise_reduction
+ */
+struct viif_l1_raw_color_noise_reduction_config {
+	struct viif_l1_raw_color_noise_reduction param_h;
+	struct viif_l1_raw_color_noise_reduction param_m;
+	struct viif_l1_raw_color_noise_reduction param_l;
+};
+
+/**
+ * enum viif_l1_hdrs_middle_img_mode - L1ISP HDR setting
+ *
+ * @VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE: not use middle image
+ * @VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE: use middle image
+ */
+enum viif_l1_hdrs_middle_img_mode {
+	VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE = 0,
+	VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE = 1,
+};
+
+/**
+ * struct viif_l1_hdrs_config - L1ISP HDRS parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS`
+ * @hdrs_hdr_mode: &enum viif_l1_hdrs_middle_img_mode value.
+ *                 Switch for use of middle sensitivity image in HDRS.
+ * @hdrs_hdr_ratio_m: Magnification ratio of middle sensitivity image for high
+ *                    sensitivity image.
+ * @hdrs_hdr_ratio_l: Magnification ratio of low sensitivity image for high
+ *                    sensitivity image.
+ * @hdrs_hdr_ratio_e: Magnification ratio of LED image for high sensitivity image.
+ * @hdrs_dg_h: High sensitivity image digital gain.
+ * @hdrs_dg_m: Middle sensitivity image digital gain.
+ * @hdrs_dg_l: Low sensitivity image digital gain.
+ * @hdrs_dg_e: LED image digital gain.
+ * @hdrs_blendend_h: Maximum luminance used for blend high sensitivity image.
+ * @hdrs_blendend_m: Maximum luminance used for blend middle sensitivity image.
+ * @hdrs_blendend_e: Maximum luminance used for blend LED image.
+ * @hdrs_blendbeg_h: Minimum luminance used for blend high sensitivity image.
+ * @hdrs_blendbeg_m: Minimum luminance used for blend middle sensitivity image.
+ * @hdrs_blendbeg_e: Minimum luminance used for blend LED image.
+ * @hdrs_led_mode_on: set 1 to enable LED mode, 0 to disable
+ * @hdrs_dst_max_val: Maximum value of output pixel. Range: [0..0xFFFFFF].
+ *
+ * Range and Accuracy of parameters are:
+ *
+ * - hdrs_hdr_ratio_{m,l,e}
+ *
+ *   - Range: [0x400..0x400000]
+ *   - Accuracy: 1/1024
+ *
+ * - hdrs_dg_{h,m,l,e}
+ *
+ *   - Range: [0..0x3FFFFF]
+ *   - Accuracy: 1/1024
+ *
+ * - hdrs_blend{end,beg}_{h,m,e}
+ *
+ *   - Range [0..4095]
+ *
+ * Parameter error will be returned when:
+ * (hdrs_hdr_mode == VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE) && (hdrs_led_mode_on == 1)
+ */
+struct viif_l1_hdrs_config {
+	__u32 hdrs_hdr_mode;
+	__u32 hdrs_hdr_ratio_m;
+	__u32 hdrs_hdr_ratio_l;
+	__u32 hdrs_hdr_ratio_e;
+	__u32 hdrs_dg_h;
+	__u32 hdrs_dg_m;
+	__u32 hdrs_dg_l;
+	__u32 hdrs_dg_e;
+	__u32 hdrs_blendend_h;
+	__u32 hdrs_blendend_m;
+	__u32 hdrs_blendend_e;
+	__u32 hdrs_blendbeg_h;
+	__u32 hdrs_blendbeg_m;
+	__u32 hdrs_blendbeg_e;
+	__u32 hdrs_led_mode_on;
+	__u32 hdrs_dst_max_val;
+};
+
+/**
+ * struct viif_l1_black_level_correction_config -  L1ISP image level conversion
+ * parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION`
+ * @srcblacklevel_gr: Black level of Gr input pixel. Range: [0..0xFFFFFF].
+ * @srcblacklevel_r: Black level of R input pixel. Range: [0..0xFFFFFF].
+ * @srcblacklevel_b: Black level of B input pixel. Range: [0..0xFFFFFF].
+ * @srcblacklevel_gb: Black level of Gb input pixel. Range: [0..0xFFFFFF].
+ * @mulval_gr: Gr gain. Range: [0..0xFFFFF], Accuracy: 1/256.
+ * @mulval_r: R gain. Range: [0..0xFFFFF], Accuracy: 1/256.
+ * @mulval_b: B gain. Range: [0..0xFFFFF], Accuracy: 1/256.
+ * @mulval_gb: Gb gain. Range: [0..0xFFFFF], Accuracy: 1/256.
+ * @dstmaxval: Maximum value of output pixel. Range: [0..0xFFFFFF].
+ */
+struct viif_l1_black_level_correction_config {
+	__u32 srcblacklevel_gr;
+	__u32 srcblacklevel_r;
+	__u32 srcblacklevel_b;
+	__u32 srcblacklevel_gb;
+	__u32 mulval_gr;
+	__u32 mulval_r;
+	__u32 mulval_b;
+	__u32 mulval_gb;
+	__u32 dstmaxval;
+};
+
+/**
+ * enum viif_l1_para_coef_gain - L1ISP parabola shading correction coefficient ratio
+ *
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH: 1/8
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH: 1/4
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_SECOND: 1/2
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_FIRST: 1/1
+ */
+enum viif_l1_para_coef_gain {
+	VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH = 0, /* 1/8 */
+	VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH = 1, /* 1/4 */
+	VIIF_L1_PARA_COEF_GAIN_ONE_SECOND = 2, /* 1/2 */
+	VIIF_L1_PARA_COEF_GAIN_ONE_FIRST = 3, /* 1/1 */
+};
+
+/**
+ * enum viif_l1_grid_coef_gain - L1ISP grid shading correction coefficient ratio
+ *
+ * @VIIF_L1_GRID_COEF_GAIN_X1: x1
+ * @VIIF_L1_GRID_COEF_GAIN_X2: x2
+ */
+enum viif_l1_grid_coef_gain {
+	VIIF_L1_GRID_COEF_GAIN_X1 = 0,
+	VIIF_L1_GRID_COEF_GAIN_X2 = 1,
+};
+
+/**
+ * struct viif_l1_lsc_parabola_ag_param - L2ISP parabola shading parameters
+ * for &struct viif_l1_lsc_parabola_param
+ * @lssc_paracoef_h_l_max: Parabola coefficient left maximum gain value
+ * @lssc_paracoef_h_l_min: Parabola coefficient left minimum gain value
+ * @lssc_paracoef_h_r_max: Parabola coefficient right maximum gain value
+ * @lssc_paracoef_h_r_min: Parabola coefficient right minimum gain value
+ * @lssc_paracoef_v_u_max: Parabola coefficient upper maximum gain value
+ * @lssc_paracoef_v_u_min: Parabola coefficient upper minimum gain value
+ * @lssc_paracoef_v_d_max: Parabola coefficient lower maximum gain value
+ * @lssc_paracoef_v_d_min: Parabola coefficient lower minimum gain value
+ * @lssc_paracoef_hv_lu_max: Parabola coefficient upper left gain maximum value
+ * @lssc_paracoef_hv_lu_min: Parabola coefficient upper left gain minimum value
+ * @lssc_paracoef_hv_ru_max: Parabola coefficient upper right gain maximum value
+ * @lssc_paracoef_hv_ru_min: Parabola coefficient upper right minimum gain value
+ * @lssc_paracoef_hv_ld_max: Parabola coefficient lower left gain maximum value
+ * @lssc_paracoef_hv_ld_min: Parabola coefficient lower left gain minimum value
+ * @lssc_paracoef_hv_rd_max: Parabola coefficient lower right gain maximum value
+ * @lssc_paracoef_hv_rd_min: Parabola coefficient lower right minimum gain value
+ *
+ * The Range, Accuracy and Constraint of each coefficient are:
+ *
+ * - Range: [-4096..4095]
+ * - Accuracy: accuracy: 1/256
+ * - Constraint: lssc_paracoef_xx_xx_min <= lssc_paracoef_xx_xx_max
+ */
+struct viif_l1_lsc_parabola_ag_param {
+	__s16 lssc_paracoef_h_l_max;
+	__s16 lssc_paracoef_h_l_min;
+	__s16 lssc_paracoef_h_r_max;
+	__s16 lssc_paracoef_h_r_min;
+	__s16 lssc_paracoef_v_u_max;
+	__s16 lssc_paracoef_v_u_min;
+	__s16 lssc_paracoef_v_d_max;
+	__s16 lssc_paracoef_v_d_min;
+	__s16 lssc_paracoef_hv_lu_max;
+	__s16 lssc_paracoef_hv_lu_min;
+	__s16 lssc_paracoef_hv_ru_max;
+	__s16 lssc_paracoef_hv_ru_min;
+	__s16 lssc_paracoef_hv_ld_max;
+	__s16 lssc_paracoef_hv_ld_min;
+	__s16 lssc_paracoef_hv_rd_max;
+	__s16 lssc_paracoef_hv_rd_min;
+};
+
+/**
+ * struct viif_l1_lsc_parabola_param - L2ISP parabola shading parameters
+ * for &struct viif_l1_lsc
+ * @lssc_para_h_center: Horizontal coordinate of central optical axis.
+ *                      Range: [0..(Input image width - 1)].
+ * @lssc_para_v_center: Vertical coordinate of central optical axis.
+ *                      Range: [0..(Input image height - 1)].
+ * @lssc_para_h_gain: Horizontal distance gain with the optical axis.
+ *                    Range: [0..4095], Accuracy: 1/256.
+ * @lssc_para_v_gain: Vertical distance gain with the optical axis.
+ *                    Range: [0..4095], Accuracy: 1/256.
+ * @lssc_para_mgsel2: &enum viif_l1_para_coef_gain value.
+ *                    Parabola 2D correction coefficient gain magnification ratio.
+ * @lssc_para_mgsel4: &enum viif_l1_para_coef_gain value.
+ *                    Parabola 4D correction coefficient gain magnification ratio.
+ * @r_2d: 2D parabola coefficient for R.
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @r_4d: 4D parabola coefficient for R.
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gr_2d: 2D parabola coefficient for Gr
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gr_4d: 4D parabola coefficient for Gr
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gb_2d: 2D parabola coefficient for Gb
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gb_4d: 4D parabola coefficient for Gb
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @b_2d: 2D parabola coefficient for B
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @b_4d: 4D parabola coefficient for B
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ */
+struct viif_l1_lsc_parabola_param {
+	__u32 lssc_para_h_center;
+	__u32 lssc_para_v_center;
+	__u32 lssc_para_h_gain;
+	__u32 lssc_para_v_gain;
+	__u32 lssc_para_mgsel2;
+	__u32 lssc_para_mgsel4;
+	struct viif_l1_lsc_parabola_ag_param r_2d;
+	struct viif_l1_lsc_parabola_ag_param r_4d;
+	struct viif_l1_lsc_parabola_ag_param gr_2d;
+	struct viif_l1_lsc_parabola_ag_param gr_4d;
+	struct viif_l1_lsc_parabola_ag_param gb_2d;
+	struct viif_l1_lsc_parabola_ag_param gb_4d;
+	struct viif_l1_lsc_parabola_ag_param b_2d;
+	struct viif_l1_lsc_parabola_ag_param b_4d;
+};
+
+/**
+ * struct viif_l1_lsc_grid_param - L2ISP grid shading parameters
+ * for &struct viif_l1_lsc
+ * @lssc_grid_h_size:  Grid horizontal direction pixel count.
+ *                     Range: [32, 64, 128, 256, 512]
+ * @lssc_grid_v_size:  Grid vertical direction pixel count.
+ *                     Range: [32, 64, 128, 256, 512]
+ * @lssc_grid_h_center: Horizontal coordinates of grid (1, 1)
+ * @lssc_grid_v_center: Vertical coordinates of grid (1, 1)
+ * @lssc_grid_mgsel: &enum viif_l1_grid_coef_gain value.
+ *                   Grid correction coefficient gain value magnification ratio.
+ *
+ * Range and constraint of parameters are:
+ *
+ * - lssc_grid_h_center:
+ *
+ *    - Range: [1..lssc_grid_h_size]
+ *    - Constraint: "Input image width <= lssc_grid_h_center + lssc_grid_h_size * 31"
+ *
+ * - lssc_grid_v_center:
+ *
+ *    - Range: [1..lssc_grid_v_size]
+ *    - Constraint: "Input image height <= lssc_grid_v_center + lssc_grid_v_size * 23"
+ */
+struct viif_l1_lsc_grid_param {
+	__u32 lssc_grid_h_size;
+	__u32 lssc_grid_v_size;
+	__u32 lssc_grid_h_center;
+	__u32 lssc_grid_v_center;
+	__u32 lssc_grid_mgsel;
+};
+
+/**
+ * struct viif_l1_lsc - L2ISP LSC parameters for &struct viif_l1_lsc_config
+ * @lssc_parabola_param: see &struct viif_l1_lsc_parabola_param
+ * @lssc_grid_param: see &struct viif_l1_lsc_grid_param
+ * @lssc_pwhb_r_gain_max: PWB R correction processing coefficient maximum value
+ * @lssc_pwhb_r_gain_min: PWB R correction processing coefficient minimum value
+ * @lssc_pwhb_gr_gain_max: PWB Gr correction processing coefficient maximum value
+ * @lssc_pwhb_gr_gain_min: PWB Gr correction processing coefficient minimum value
+ * @lssc_pwhb_gb_gain_max: PWB Gb correction processing coefficient maximum value
+ * @lssc_pwhb_gb_gain_min: PWB Gb correction processing coefficient minimum value
+ * @lssc_pwhb_b_gain_max: PWB B correction processing coefficient maximum value
+ * @lssc_pwhb_b_gain_min: PWB B correction processing coefficient minimum value
+ *
+ * The range, accuracy and restriction of lssc_pwhb_{r,gr,gb,b}_gain_{max,min} are:
+ *
+ * - Range: [0..2047]
+ * - Accuracy: 1/256
+ * - Restriction: xxxx_gain_min <= xxxx_gain_max
+ */
+struct viif_l1_lsc {
+	struct viif_l1_lsc_parabola_param lssc_parabola_param;
+	struct viif_l1_lsc_grid_param lssc_grid_param;
+	__u32 lssc_pwhb_r_gain_max;
+	__u32 lssc_pwhb_r_gain_min;
+	__u32 lssc_pwhb_gr_gain_max;
+	__u32 lssc_pwhb_gr_gain_min;
+	__u32 lssc_pwhb_gb_gain_max;
+	__u32 lssc_pwhb_gb_gain_min;
+	__u32 lssc_pwhb_b_gain_max;
+	__u32 lssc_pwhb_b_gain_min;
+};
+
+/* MASKs for viif_l1_lsc_config::enable */
+#define VIIF_L1_LSC_PARABOLA_EN_MASK BIT(0)
+#define VIIF_L1_LSC_GRID_EN_MASK     BIT(1)
+
+/**
+ * struct viif_l1_lsc_config - L2ISP LSC parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC`
+ * @enable: set 0 to disable LSC operation,
+ *          1 to enable parabola shading,
+ *          2 to enable grid shading,
+ *          3 to enable both parabola and grid shadings.
+ * @param: see &struct viif_l1_lsc
+ * @table_gr: Grid table for LSC of Gr component.
+ *            This table is referred only when grid shading is used
+ * @table_r:  Grid table for LSC of R component.
+ *            This table is referred only when grid shading is used
+ * @table_b:  Grid table for LSC of B component.
+ *            This table is referred only when grid shading is used
+ * @table_gb: Grid table for LSC of Gb component.
+ *            This table is referred only when grid shading is used
+ *
+ * The size of each table is 1536 Bytes (u16 * 768).
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the grid table.
+ */
+struct viif_l1_lsc_config {
+	__u32 enable;
+	struct viif_l1_lsc param;
+	__u16 table_gr[768];
+	__u16 table_r[768];
+	__u16 table_b[768];
+	__u16 table_gb[768];
+};
+
+/**
+ * enum viif_l1_demosaic_mode - L1ISP demosaic modeenum viif_l1_demosaic_mode
+ *
+ * @VIIF_L1_DEMOSAIC_ACPI: Toshiba ACPI algorithm
+ * @VIIF_L1_DEMOSAIC_DMG: DMG algorithm
+ */
+enum viif_l1_demosaic_mode {
+	VIIF_L1_DEMOSAIC_ACPI = 0,
+	VIIF_L1_DEMOSAIC_DMG = 1,
+};
+
+/**
+ * struct viif_l1_color_matrix_correction - L1ISP color matrix correction
+ * parameters for &struct viif_l1_main_process_config
+ * @coef_rmg_min: (R-G) Minimum coefficient
+ * @coef_rmg_max: (R-G) Maximum coefficient
+ * @coef_rmb_min: (R-B) Minimum coefficient
+ * @coef_rmb_max: (R-B) Maximum coefficient
+ * @coef_gmr_min: (G-R) Minimum coefficient
+ * @coef_gmr_max: (G-R) Maximum coefficient
+ * @coef_gmb_min: (G-B) Minimum coefficient
+ * @coef_gmb_max: (G-B) Maximum coefficient
+ * @coef_bmr_min: (B-R) Minimum coefficient
+ * @coef_bmr_max: (B-R) Maximum coefficient
+ * @coef_bmg_min: (B-G) Minimum coefficient
+ * @coef_bmg_max: (B-G) Maximum coefficient
+ * @dst_minval: Minimum value of output pixel. Range: [0..0xFFFF].
+ *
+ * The range, accuracy and restriction of each coefficient are:
+ *
+ * - Range: [-32768..32767]
+ * - Accuracy: 1/4096
+ * - Restriction: coef_xxx_min <= coef_xxx_max
+ */
+struct viif_l1_color_matrix_correction {
+	__s16 coef_rmg_min;
+	__s16 coef_rmg_max;
+	__s16 coef_rmb_min;
+	__s16 coef_rmb_max;
+	__s16 coef_gmr_min;
+	__s16 coef_gmr_max;
+	__s16 coef_gmb_min;
+	__s16 coef_gmb_max;
+	__s16 coef_bmr_min;
+	__s16 coef_bmr_max;
+	__s16 coef_bmg_min;
+	__s16 coef_bmg_max;
+	__u16 dst_minval;
+};
+
+/**
+ * struct viif_l1_main_process_config - L1ISP Main process operating parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS`
+ * @demosaic_mode: &enum viif_l1_demosaic_mode value. Sets demosaic mode.
+ * @damp_lsbsel: Clipping range of output pixel value to AWB adjustment function. Range: [0..15].
+ * @colormat_enable: set 1 to enable color matrix correction, 0 to disable.
+ * @dst_maxval: Maximum value of output pixel. Range: [0..0xFFFFFF].
+ *              Applicable to output of each process (digital amplifier,
+ *              demosaicing and color matrix correction) in L1ISP Main process.
+ * @colormat_param: see &struct viif_l1_color_matrix_correction
+ */
+struct viif_l1_main_process_config {
+	__u32 demosaic_mode;
+	__u32 damp_lsbsel;
+	__u32 colormat_enable;
+	__u32 dst_maxval;
+	struct viif_l1_color_matrix_correction colormat_param;
+};
+
+/**
+ * enum viif_l1_awb_mag - L1ISP signal magnification before AWB adjustment
+ *
+ * @VIIF_L1_AWB_ONE_SECOND: x 1/2
+ * @VIIF_L1_AWB_X1: 1 times
+ * @VIIF_L1_AWB_X2: 2 times
+ * @VIIF_L1_AWB_X4: 4 times
+ */
+enum viif_l1_awb_mag {
+	VIIF_L1_AWB_ONE_SECOND = 0,
+	VIIF_L1_AWB_X1 = 1,
+	VIIF_L1_AWB_X2 = 2,
+	VIIF_L1_AWB_X4 = 3,
+};
+
+/**
+ * enum viif_l1_awb_area_mode - L1ISP AWB detection target area
+ *
+ * @VIIF_L1_AWB_AREA_MODE0: only center area
+ * @VIIF_L1_AWB_AREA_MODE1: center area when uv is in square gate
+ * @VIIF_L1_AWB_AREA_MODE2: all area except center area
+ * @VIIF_L1_AWB_AREA_MODE3: all area
+ */
+enum viif_l1_awb_area_mode {
+	VIIF_L1_AWB_AREA_MODE0 = 0,
+	VIIF_L1_AWB_AREA_MODE1 = 1,
+	VIIF_L1_AWB_AREA_MODE2 = 2,
+	VIIF_L1_AWB_AREA_MODE3 = 3,
+};
+
+/**
+ * enum viif_l1_awb_restart_cond - L1ISP AWB adjustment restart conditions
+ *
+ * @VIIF_L1_AWB_RESTART_NO: no restart
+ * @VIIF_L1_AWB_RESTART_128FRAME: restart after 128 frame
+ * @VIIF_L1_AWB_RESTART_64FRAME: restart after 64 frame
+ * @VIIF_L1_AWB_RESTART_32FRAME: restart after 32 frame
+ * @VIIF_L1_AWB_RESTART_16FRAME: restart after 16 frame
+ * @VIIF_L1_AWB_RESTART_8FRAME: restart after 8 frame
+ * @VIIF_L1_AWB_RESTART_4FRAME: restart after 4 frame
+ * @VIIF_L1_AWB_RESTART_2FRAME: restart after 2 frame
+ */
+enum viif_l1_awb_restart_cond {
+	VIIF_L1_AWB_RESTART_NO = 0,
+	VIIF_L1_AWB_RESTART_128FRAME = 1,
+	VIIF_L1_AWB_RESTART_64FRAME = 2,
+	VIIF_L1_AWB_RESTART_32FRAME = 3,
+	VIIF_L1_AWB_RESTART_16FRAME = 4,
+	VIIF_L1_AWB_RESTART_8FRAME = 5,
+	VIIF_L1_AWB_RESTART_4FRAME = 6,
+	VIIF_L1_AWB_RESTART_2FRAME = 7,
+};
+
+/**
+ * struct viif_l1_awb - L1ISP AWB adjustment parameters
+ * for &struct viif_l1_awb_config
+ * @awhb_ygate_sel: 1:Enable/0:Disable to fix Y value at YUV conversion
+ * @awhb_ygate_data: Y value when Y value is fixed. Range: [64, 128, 256, 512].
+ * @awhb_cgrange: &enum viif_l1_awb_mag value.
+ *                Signal output magnification ratio before AWB adjustment.
+ * @awhb_ygatesw: 1:Enable/0:Disable settings of luminance gate
+ * @awhb_hexsw: 1:Enable/0:Disable settings of hexa-gate
+ * @awhb_areamode: &enum viif_l1_awb_area_mode value.
+ *                 Final selection of accumulation area for detection target area.
+ * @awhb_area_hsize: Horizontal size per block in central area.
+ *                   Range: [1..(Input image width -8)/8].
+ * @awhb_area_vsize: Vertical size per block in central area.
+ *                   Range: [1..(Input image height -4)/8].
+ * @awhb_area_hofs: Horizontal offset of block [0] in central area.
+ *                  Range: [0..(Input image width -9)].
+ * @awhb_area_vofs: Vertical offset of block [0] in central area.
+ *                  Range: [0..(Input image height -5)].
+ * @awhb_area_maskh: Setting 1:Enable/0:Disable of accumulated selection.
+ *                   Each bit corresponds to the following:
+ *                   [31:0] = {
+ *                   (7, 3),(6, 3),(5, 3),(4, 3),(3, 3),(2, 3),(1, 3),(0, 3),
+ *                   (7, 2),(6, 2),(5, 2),(4, 2),(3, 2),(2, 2),(1, 2),(0, 2),
+ *                   (7, 1),(6, 1),(5, 1),(4, 1),(3, 1),(2, 1),(1, 1),(0, 1),
+ *                   (7, 0),(6, 0),(5, 0),(4, 0),(3, 0),(2, 0),(1, 0),(0, 0)}
+ * @awhb_area_maskl: Setting 1:Enable/0:Disable of accumulated selection.
+ *                   Each bit corresponds to the following:
+ *                   [31:0] = {
+ *                   (7, 7),(6, 7),(5, 7),(4, 7),(3, 7),(2, 7),(1, 7),(0, 7),
+ *                   (7, 6),(6, 6),(5, 6),(4, 6),(3, 6),(2, 6),(1, 6),(0, 6),
+ *                   (7, 5),(6, 5),(5, 5),(4, 5),(3, 5),(2, 5),(1, 5),(0, 5),
+ *                   (7, 4),(6, 4),(5, 4),(4, 4),(3, 4),(2, 4),(1, 4),(0, 4)}
+ * @awhb_sq_sw: 1:Enable/0:Disable each square gate
+ * @awhb_sq_pol: 1:Enable/0:Disable to add accumulated gate for each square gate
+ * @awhb_bycut0p: U upper end value. Range: [0..127].
+ * @awhb_bycut0n: U lower end value. Range: [0..127].
+ * @awhb_rycut0p: V upper end value. Range: [0..127].
+ * @awhb_rycut0n: V lower end value. Range: [0..127].
+ * @awhb_rbcut0h: V-axis intercept upper end. Range: [-127..127].
+ * @awhb_rbcut0l: V-axis intercept lower end. Range: [-127..127].
+ * @awhb_bycut_h: U direction center value of each square gate. Range:  [-127..127].
+ * @awhb_bycut_l: U direction width of each square gate. Range: [0..127].
+ * @awhb_rycut_h: V direction center value of each square gate. Range: [-127..127].
+ * @awhb_rycut_l: V direction width of each square gate. Range: [0..127].
+ * @awhb_awbsftu: U gain offset. Range: [-127..127].
+ * @awhb_awbsftv: V gain offset. Range: [-127..127].
+ * @awhb_awbhuecor: 1:Enable/0:Disable setting of color correlation retention function
+ * @awhb_awbspd: UV convergence speed multiplier. Range: [0..15] (0 means "stop").
+ * @awhb_awbulv: U convergence point level. Range: [0..31].
+ * @awhb_awbvlv: V convergence point level. Range: [0..31].
+ * @awhb_awbondot: Accumulation operation stop pixel count threshold. Range: [0..1023].
+ * @awhb_awbfztim: &enum viif_l1_awb_restart_cond value. Condition to restart AWB process.
+ * @awhb_wbgrmax: B gain adjustment range (Width from center to upper limit).
+ *                Range: [0..255], Accuracy: 1/64.
+ * @awhb_wbgbmax: R gain adjustment range (Width from center to upper limit).
+ *                Range: [0..255], Accuracy: 1/64.
+ * @awhb_wbgrmin: B gain adjustment range (Width from center to lower limit).
+ *                Range: [0..255], Accuracy: 1/64.
+ * @awhb_wbgbmin: R gain adjustment range (Width from center to lower limit).
+ *                Range: [0..255], Accuracy: 1/64.
+ * @awhb_ygateh: Luminance gate maximum value. Range: [0..255].
+ * @awhb_ygatel: Luminance gate minimum value. Range: [0..255].
+ * @awhb_awbwait: Number of restart frames after UV convergence freeze. Range: [0..255].
+ */
+struct viif_l1_awb {
+	__u32 awhb_ygate_sel;
+	__u32 awhb_ygate_data;
+	__u32 awhb_cgrange;
+	__u32 awhb_ygatesw;
+	__u32 awhb_hexsw;
+	__u32 awhb_areamode;
+	__u32 awhb_area_hsize;
+	__u32 awhb_area_vsize;
+	__u32 awhb_area_hofs;
+	__u32 awhb_area_vofs;
+	__u32 awhb_area_maskh;
+	__u32 awhb_area_maskl;
+	__u32 awhb_sq_sw[3];
+	__u32 awhb_sq_pol[3];
+	__u32 awhb_bycut0p;
+	__u32 awhb_bycut0n;
+	__u32 awhb_rycut0p;
+	__u32 awhb_rycut0n;
+	__s32 awhb_rbcut0h;
+	__s32 awhb_rbcut0l;
+	__s32 awhb_bycut_h[3];
+	__u32 awhb_bycut_l[3];
+	__s32 awhb_rycut_h[3];
+	__u32 awhb_rycut_l[3];
+	__s32 awhb_awbsftu;
+	__s32 awhb_awbsftv;
+	__u32 awhb_awbhuecor;
+	__u32 awhb_awbspd;
+	__u32 awhb_awbulv;
+	__u32 awhb_awbvlv;
+	__u32 awhb_awbondot;
+	__u32 awhb_awbfztim;
+	__u8 awhb_wbgrmax;
+	__u8 awhb_wbgbmax;
+	__u8 awhb_wbgrmin;
+	__u8 awhb_wbgbmin;
+	__u8 awhb_ygateh;
+	__u8 awhb_ygatel;
+	__u8 awhb_awbwait;
+};
+
+/**
+ * struct viif_l1_awb_config - L1ISP AWB parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB`
+ * @enable: set 1 to enable AWB , 0 to disable
+ * @awhb_wbmrg: White balance adjustment R gain. Range: [64..1023], Accuracy: 1/256.
+ * @awhb_wbmgg: White balance adjustment G gain. Range: [64..1023], Accuracy: 1/256.
+ * @awhb_wbmbg: White balance adjustment B gain. Range: [64..1023], Accuracy: 1/256.
+ * @param: a &struct viif_l1_awb instance
+ */
+struct viif_l1_awb_config {
+	__u32 enable;
+	__u32 awhb_wbmrg;
+	__u32 awhb_wbmgg;
+	__u32 awhb_wbmbg;
+	struct viif_l1_awb param;
+};
+
+/**
+ * enum viif_l1_hdrc_tone_type - L1ISP HDRC tone type
+ *
+ * @VIIF_L1_HDRC_TONE_USER: User Tone
+ * @VIIF_L1_HDRC_TONE_PRESET: Preset Tone
+ */
+enum viif_l1_hdrc_tone_type {
+	VIIF_L1_HDRC_TONE_USER = 0,
+	VIIF_L1_HDRC_TONE_PRESET = 1,
+};
+
+/**
+ * struct viif_l1_hdrc - L1ISP HDRC parameters for &struct viif_l1_hdrc_config
+ * @hdrc_ratio: Data width of input image. Range: [10..24] bits.
+ * @hdrc_pt_ratio: Preset Tone curve slope. Range: [0..13].
+ * @hdrc_pt_blend: Preset Tone0 curve blend ratio. Range: [0..256], Accuracy: 1/256.
+ * @hdrc_pt_blend2: Preset Tone2 curve blend ratio. Range: [0..256], Accuracy: 1/256.
+ * @hdrc_tn_type: &enum viif_l1_hdrc_tone_type value. L1ISP HDRC tone type.
+ * @hdrc_utn_tbl: HDRC value of User Tone curve. Range: [0..0xFFFF].
+ * @hdrc_flr_val: Constant flare value. Range: [0..0xFFFFFF].
+ * @hdrc_flr_adp: set 1 to enable dynamic flare measurement, 0 to disable.
+ * @hdrc_ybr_off: set 1 to turn OFF bilateral luminance filter, 0 to turn ON.
+ * @hdrc_orgy_blend: Blend settings of luminance correction data after HDRC
+ *                   and data before luminance correction. Range: [0..16]
+ *                   (0:Luminance correction 100%, 8:Luminance correction 50%,
+ *                   16:Luminance correction 0%).
+ * @hdrc_pt_sat: Preset Tone saturation value. Range: [0..0xFFFF].
+ *
+ * Restrictions for parameters
+ *
+ * - hdrc_pt_blend + hdrc_pt_blend2 <= 256
+ * - input_image_height % 64 != {18, 20, 22, 24, 26}
+ *
+ *   - only when dynamic flare control is enabled
+ *   - note that the driver will not return error if this condition is not satisfied.
+ *
+ * - hdrc_utn_tbl[N] <= hdrc_utn_tbl[N+1]
+ *
+ *   - note that the driver will not return error if this condition is not satisfied.
+ */
+struct viif_l1_hdrc {
+	__u32 hdrc_ratio;
+	__u32 hdrc_pt_ratio;
+	__u32 hdrc_pt_blend;
+	__u32 hdrc_pt_blend2;
+	__u32 hdrc_tn_type;
+	__u16 hdrc_utn_tbl[20];
+	__u32 hdrc_flr_val;
+	__u32 hdrc_flr_adp;
+	__u32 hdrc_ybr_off;
+	__u32 hdrc_orgy_blend;
+	__u16 hdrc_pt_sat;
+};
+
+/**
+ * struct viif_l1_hdrc_config - L1ISP HDRC parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC`
+ * @enable: set 1 to enable HDR compression, 0 to disable
+ * @hdrc_thr_sft_amt: Amount of right shift in through mode (HDRC disabled). Range: [0..8].
+ *                    Should be 0 if HDRC is enabled
+ * @param: HDR compression parameter; see &struct viif_l1_hdrc
+ */
+struct viif_l1_hdrc_config {
+	__u32 enable;
+	__u32 hdrc_thr_sft_amt;
+	struct viif_l1_hdrc param;
+};
+
+/**
+ * struct viif_l1_hdrc_ltm_config - L1ISP HDRC LTM parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM`
+ * @tnp_max: Tone blend rate maximum value of LTM function.
+ *           Range: [0..4194303], Accuracy: 1/64. Set 0 to turn off LTM function.
+ * @tnp_mag: Intensity adjustment of LTM function. Range: [0..16383], Accuracy: 1/64.
+ * @tnp_fil: Smoothing filter coefficient. Range: [0..255].
+ *
+ * Restriction: (tmp_fil[1] + tnp_fil[2] + tnp_fil[3] + tnp_fil[4]) * 2 + tnp_fil[0] = 1024
+ */
+struct viif_l1_hdrc_ltm_config {
+	__u32 tnp_max;
+	__u32 tnp_mag;
+	__u8 tnp_fil[5];
+};
+
+/**
+ * struct viif_l1_gamma - L1ISP gamma correction parameters
+ * for &struct viif_l1_gamma_config
+ * @gam_p: Luminance value after gamma correction. Range: [0..8191].
+ * @blkadj: Black level adjustment value after gamma correction. Range: [0..65535].
+ */
+struct viif_l1_gamma {
+	__u16 gam_p[44];
+	__u16 blkadj;
+};
+
+/**
+ * struct viif_l1_gamma_config - L1ISP gamma correction parameters
+ * @enable: set 1 to enable gamma correction at L1ISP, 0 to disable.
+ * @param: see &struct viif_l1_gamma.
+ */
+struct viif_l1_gamma_config {
+	__u32 enable;
+	struct viif_l1_gamma param;
+};
+
+/**
+ * struct viif_l1_nonlinear_contrast -  L1ISP non-linear contrast parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @blk_knee: Black side peak luminance value. Range: [0..0xFFFF].
+ * @wht_knee: White side peak luminance value. Range: [0..0xFFFF].
+ * @blk_cont: Black side slope
+ * @wht_cont: White side slope
+ *
+ * Range, Accuracy and Index for {blk,wht}_cont is:
+ *
+ * - Range: [0..255]
+ * - Accuracy: 1/256
+ *
+ * - Index
+ *
+ *   - 0: the value at AG minimum
+ *   - 1: the value at AG less than 128
+ *   - 2: the value at AG equal to or more than 128
+ */
+struct viif_l1_nonlinear_contrast {
+	__u16 blk_knee;
+	__u16 wht_knee;
+	__u8 blk_cont[3];
+	__u8 wht_cont[3];
+};
+
+/**
+ * struct viif_l1_lum_noise_reduction -  L1ISP luminance noise reduction
+ * parameters for &struct viif_l1_img_quality_adjustment_config
+ * @gain_min: Minimum value of extracted noise gain. Range: [0..0xFFFF], Accuracy: 1/256
+ * @gain_max: Maximum value of extracted noise gain. Range: [0..0xFFFF], Accuracy: 1/256
+ * @lim_min: Minimum value of extracted noise limit. Range: [0..0xFFFF]
+ * @lim_max: Maximum value of extracted noise limit. Range: [0..0xFFFF]
+ *
+ * Constraint: "gain_min <= gain_max" and "lim_min <= lim_max"
+ *
+ */
+struct viif_l1_lum_noise_reduction {
+	__u16 gain_min;
+	__u16 gain_max;
+	__u16 lim_min;
+	__u16 lim_max;
+};
+
+/**
+ * struct viif_l1_edge_enhancement -  L1ISP edge enhancement parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @gain_min: Extracted edge gain minimum value. Range: [0..0xFFFF], Accuracy: 1/256
+ * @gain_max: Extracted edge gain maximum value. Range: [0..0xFFFF], Accuracy: 1/256
+ * @lim_min: Extracted edge limit minimum value. Range: [0..0xFFFF]
+ * @lim_max: Extracted edge limit maximum value. Range: [0..0xFFFF]
+ * @coring_min: Extracted edge coring threshold minimum value. Range: [0..0xFFFF]
+ * @coring_max: Extracted edge coring threshold maximum value. Range: [0..0xFFFF]
+ *
+ * Constraint: "gain_min <= gain_max" and "lim_min <= lim_max" and "coring_min <= coring_max"
+ */
+struct viif_l1_edge_enhancement {
+	__u16 gain_min;
+	__u16 gain_max;
+	__u16 lim_min;
+	__u16 lim_max;
+	__u16 coring_min;
+	__u16 coring_max;
+};
+
+/**
+ * struct viif_l1_uv_suppression -  L1ISP UV suppression parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @bk_mp: Black side slope. Range: [0..0x3FFF], Accuracy: 1/16384
+ * @black: Minimum black side gain. Range: [0..0x3FFF], Accuracy: 1/16384
+ * @wh_mp: White side slope. Range: [0..0x3FFF], Accuracy: 1/16384
+ * @white: Minimum white side gain. Range: [0..0x3FFF], Accuracy: 1/16384
+ * @bk_slv: Black side intercept. Range: [0..0xFFFF]
+ * @wh_slv: White side intercept. Range: [0..0xFFFF]
+ *
+ * Constraint: bk_slb < wh_slv
+ */
+struct viif_l1_uv_suppression {
+	__u32 bk_mp;
+	__u32 black;
+	__u32 wh_mp;
+	__u32 white;
+	__u16 bk_slv;
+	__u16 wh_slv;
+};
+
+/**
+ * struct viif_l1_coring_suppression -  L1ISP coring suppression parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @lv_min: Minimum coring threshold. Range: [0..0xFFFF]
+ * @lv_max: Maximum coring threshold. Range: [0..0xFFFF]
+ * @gain_min: Minimum gain. Range: [0..0xFFFF], Accuracy: 1/65536
+ * @gain_max: Maximum gain. Range: [0..0xFFFF], Accuracy: 1/65536
+ *
+ * Constraint: "lv_min <= lv_max" and "gain_min <= gain_max"
+ */
+struct viif_l1_coring_suppression {
+	__u16 lv_min;
+	__u16 lv_max;
+	__u16 gain_min;
+	__u16 gain_max;
+};
+
+/**
+ * struct viif_l1_edge_suppression -  L1ISP edge suppression parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @gain: Gain of edge color suppression. Range: [0..0xFFFF], Accuracy: 1/256
+ * @lim: Limiter threshold of edge color suppression. Range: [0..15]
+ */
+struct viif_l1_edge_suppression {
+	__u16 gain;
+	__u32 lim;
+};
+
+/**
+ * struct viif_l1_color_level -  L1ISP color level parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @cb_gain: U component gain
+ * @cr_gain: V component gain
+ * @cbr_mgain_min: UV component gain
+ * @cbp_gain_max: Positive U component gain
+ * @cbm_gain_max: Negative V component gain
+ * @crp_gain_max: Positive U component gain
+ * @crm_gain_max: Negative V component gain
+ *
+ * Range and Accuracy of parameters are:
+ *
+ * - Range: [0..0xFFF]
+ * - Accuracy: 1/2048
+ */
+struct viif_l1_color_level {
+	__u32 cb_gain;
+	__u32 cr_gain;
+	__u32 cbr_mgain_min;
+	__u32 cbp_gain_max;
+	__u32 cbm_gain_max;
+	__u32 crp_gain_max;
+	__u32 crm_gain_max;
+};
+
+/* MASKs for viif_l1_img_quality_adjustment_config::enable */
+#define VIIF_L1_IQA_NONLINEAR_CONTRAST_EN_MASK	  BIT(0)
+#define VIIF_L1_IQA_LUM_NOISE_REDUCTION_EN_MASK	  BIT(1)
+#define VIIF_L1_IQA_EDGE_ENHANCEMENT_EN_MASK	  BIT(2)
+#define VIIF_L1_IQA_UV_SUPPRESSION_EN_MASK	  BIT(3)
+#define VIIF_L1_IQA_CORING_SUPPRESSION_EN_MASK	  BIT(4)
+#define VIIF_L1_IQA_EDGE_SUPPRESSION_EN_MASK	  BIT(5)
+#define VIIF_L1_IQA_COLOR_LEVEL_EN_MASK		  BIT(6)
+#define VIIF_L1_IQA_COLOR_NOISE_REDUCTION_EN_MASK BIT(7)
+
+/**
+ * struct viif_l1_img_quality_adjustment_config -  L1ISP image quality
+ * adjustment parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT`
+ * @enable: | bit vector; set 1 to enable each function, 0 to disable.
+ *          | bit0: nonlinear_contrast
+ *          | bit1: lum_noise_reduction
+ *          | bit2: edge_enhancement
+ *          | bit3: uv_suppression
+ *          | bit4: coring_suppression
+ *          | bit5: edge_suppression
+ *          | bit6: color_level
+ *          | bit7: color_noise_reduction
+ * @coef_cb: Cb coefficient used in RGB to YUV conversion.
+ *           Range: [0..0xFFFF], Accuracy: 1/65536
+ * @coef_cr: Cr coefficient used in RGB to YUV conversion.
+ *           Range: [0..0xFFFF], Accuracy: 1/65536
+ * @brightness: Brightness adjustment value. Range: [-32768..32767] (0 to turn off)
+ * @linear_contrast: Linear contrast adjustment value.
+ *                   Range: [0..0xFF], Accuracy: 1/128 (128 to turn off)
+ * @nonlinear_contrast: see &struct viif_l1_nonlinear_contrast; controlled by bit0 of enable.
+ * @lum_noise_reduction: see &struct viif_l1_lum_noise_reduction; controlled by bit1 of enable.
+ * @edge_enhancement: see &struct viif_l1_edge_enhancement; controlled by bit2 of enable.
+ * @uv_suppression: see &struct viif_l1_uv_suppression: controlled by bit3 of enable.
+ * @coring_suppression: see &struct viif_l1_coring_suppression; controlled by bit4 of enable.
+ * @edge_suppression: see &struct viif_l1_edge_suppression; controlled by bit5 of enable.
+ * @color_level: see &struct viif_l1_color_level; controlled by bit6 of enable.
+ */
+struct viif_l1_img_quality_adjustment_config {
+	__u32 enable;
+	__u16 coef_cb;
+	__u16 coef_cr;
+	__s16 brightness;
+	__u8 linear_contrast;
+	struct viif_l1_nonlinear_contrast nonlinear_contrast;
+	struct viif_l1_lum_noise_reduction lum_noise_reduction;
+	struct viif_l1_edge_enhancement edge_enhancement;
+	struct viif_l1_uv_suppression uv_suppression;
+	struct viif_l1_coring_suppression coring_suppression;
+	struct viif_l1_edge_suppression edge_suppression;
+	struct viif_l1_color_level color_level;
+};
+
+/**
+ * struct viif_l1_avg_lum_generation_config - L1ISP average luminance generation configuration
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION`
+ * @enable: set 1 to enable aggregation of AVG LUM, 0 to disable
+ * @aexp_start_x: horizontal position of block 0. Range: [0.."width of input image - 1"]
+ * @aexp_start_y: vertical position of block 0. Range: [0.."height of input image - 1"]
+ * @aexp_block_width: width of one block.
+ *                    Range: [64.."width of input image"] (Should be multiple of 64)
+ * @aexp_block_height: height of one block.
+ *                     Range: [64.."height of input image"] (Should be multiple of 64)
+ * @aexp_weight: weight of each block. Range: [0..3].
+ *               Nested indices are: [y position][x position].
+ * @aexp_satur_ratio: threshold to judge whether saturated block or not. Range: [0..256]
+ * @aexp_black_ratio: threshold to judge whether black block or not. Range: [0..256]
+ * @aexp_satur_level: threshold to judge whether saturated pixel or not. Range: [0x0..0xffffff]
+ * @aexp_ave4linesy: vertical position of the initial line
+ *                   for 4-lines average luminance.
+ *                   Range: [0.."height of input image - 4"]
+ */
+struct viif_l1_avg_lum_generation_config {
+	__u32 enable;
+	__u32 aexp_start_x;
+	__u32 aexp_start_y;
+	__u32 aexp_block_width;
+	__u32 aexp_block_height;
+	__u32 aexp_weight[8][8];
+	__u32 aexp_satur_ratio;
+	__u32 aexp_black_ratio;
+	__u32 aexp_satur_level;
+	__u32 aexp_ave4linesy[4];
+};
+
+/**
+ * enum viif_l2_undist_mode - L2ISP undistortion mode
+ * @VIIF_L2_UNDIST_POLY: polynomial mode
+ * @VIIF_L2_UNDIST_GRID: grid table mode
+ * @VIIF_L2_UNDIST_POLY_TO_GRID: polynomial, then grid table mode
+ * @VIIF_L2_UNDIST_GRID_TO_POLY: grid table, then polynomial mode
+ */
+enum viif_l2_undist_mode {
+	VIIF_L2_UNDIST_POLY = 0,
+	VIIF_L2_UNDIST_GRID = 1,
+	VIIF_L2_UNDIST_POLY_TO_GRID = 2,
+	VIIF_L2_UNDIST_GRID_TO_POLY = 3,
+};
+
+/**
+ * struct viif_l2_undist - L2ISP UNDIST parameters
+ * for &struct viif_l2_undist_config
+ * @through_mode: 1:enable or 0:disable through mode of undistortion
+ * @roi_mode: &enum viif_l2_undist_mode value. Sets L2ISP undistortion mode.
+ * @sensor_crop_ofs_h: Horizontal start position of sensor crop area.
+ * @sensor_crop_ofs_v: Vertical start position of sensor crop area.
+ * @norm_scale: Normalization coefficient for distance from center
+ * @valid_r_norm2_poly: Setting target area for polynomial correction
+ * @valid_r_norm2_grid: Setting target area for grid table correction
+ * @roi_write_area_delta: Error adjustment value of forward function and
+ *                        inverse function for pixel position calculation
+ * @poly_write_g_coef: 10th-order polynomial coefficient for G write pixel position calculation
+ * @poly_read_b_coef: 10th-order polynomial coefficient for B read pixel position calculation
+ * @poly_read_g_coef: 10th-order polynomial coefficient for G read pixel position calculation
+ * @poly_read_r_coef: 10th-order polynomial coefficient for R read pixel position calculation
+ * @grid_node_num_h: Number of horizontal grids
+ * @grid_node_num_v: Number of vertical grids
+ * @grid_patch_hsize_inv: Inverse pixel size between horizontal grids
+ * @grid_patch_vsize_inv: Inverse pixel size between vertical grids
+ *
+ * Range and Accuracy of parameters are:
+ *
+ * - sensor_crop_ofs_{h,v}
+ *
+ *   - Range: [-4296..4296]
+ *   - Accuracy: 1/2
+ *
+ * - norm_scale
+ *
+ *   - Range: [0..1677721]
+ *   - Accuracy: 1/33554432
+ *
+ * - valid_r_norm2_{poly,grid}
+ *
+ *   - Range: [0..0x3FFFFFF]
+ *   - Accuracy: 1/33554432
+ *
+ * - roi_write_area_delta
+ *
+ *   - Range: [0..0x7FF]
+ *   - Accuracy: 1/1024
+ *
+ * - poly_write_g_coef, poly_read_{b,g,r}_coef
+ *
+ *   - Range: [-2147352576..2147352576]
+ *   - Accuracy: 1/131072
+ *
+ * - grid_node_num_{v.h}
+ *
+ *   - Range: [16..64]
+ *
+ * - grid_patch_{hsize,vsize}_inv
+ *
+ *   - Range: [0..0x7FFFFF]
+ *   - Accuracy: 1/8388608
+ */
+struct viif_l2_undist {
+	__u32 through_mode;
+	__u32 roi_mode[2];
+	__s32 sensor_crop_ofs_h;
+	__s32 sensor_crop_ofs_v;
+	__u32 norm_scale;
+	__u32 valid_r_norm2_poly;
+	__u32 valid_r_norm2_grid;
+	__u32 roi_write_area_delta[2];
+	__s32 poly_write_g_coef[11];
+	__s32 poly_read_b_coef[11];
+	__s32 poly_read_g_coef[11];
+	__s32 poly_read_r_coef[11];
+	__u32 grid_node_num_h;
+	__u32 grid_node_num_v;
+	__u32 grid_patch_hsize_inv;
+	__u32 grid_patch_vsize_inv;
+};
+
+/**
+ * struct viif_l2_undist_config - L2ISP UNDIST parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST`
+ * @param: &struct viif_l2_undist
+ * @write_g: write-G grid table.
+ * @read_b: read-B grid table.
+ * @read_g: read-G grid table.
+ * @read_r: read-R grid table.
+ * @size: Table size in bytes. Range: [1024..8192] or 0.
+ *        The value should be "grid_node_num_h * grid_node_num_v * 4".
+ *        See also &struct viif_l2_undist.
+ *
+ * The tables are referred when param.roi_mode[] is
+ * either of VIIF_L2_UNDIST_GRID, VIIF_L2_UNDIST_POLY_TO_GRID, VIIF_L2_UNDIST_GRID_TO_POLY
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the contents of specified grid table.
+ */
+struct viif_l2_undist_config {
+	struct viif_l2_undist param;
+	__u8 write_g[8192];
+	__u8 read_b[8192];
+	__u8 read_g[8192];
+	__u8 read_r[8192];
+	__u32 size;
+};
+
+/**
+ * struct viif_l2_roi_config - L2ISP ROI parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI`
+ * @roi_num:
+ *     1 when only capture path0 is activated,
+ *     2 when both capture path 0 and path 1 are activated.
+ * @roi_scale: Scale value for each ROI. Range: [32768..131072], Accuracy: 1/65536
+ * @roi_scale_inv: Inverse scale value for each ROI. Range: [32768..131072], Accuracy: 1/65536
+ * @corrected_wo_scale_hsize: Corrected image width for each ROI. Range: [128..8190]
+ * @corrected_wo_scale_vsize: Corrected image height for each ROI. Range: [128..4094]
+ * @corrected_hsize: Corrected and scaled image width for each ROI. Range: [128..8190]
+ * @corrected_vsize: Corrected and scaled image height for each ROI. Range: [128..4094]
+ */
+struct viif_l2_roi_config {
+	__u32 roi_num;
+	__u32 roi_scale[2];
+	__u32 roi_scale_inv[2];
+	__u32 corrected_wo_scale_hsize[2];
+	__u32 corrected_wo_scale_vsize[2];
+	__u32 corrected_hsize[2];
+	__u32 corrected_vsize[2];
+};
+
+/** enum viif_gamma_mode - Gamma correction mode
+ *
+ * @VIIF_GAMMA_COMPRESSED: compressed table mode
+ * @VIIF_GAMMA_LINEAR: linear table mode
+ */
+enum viif_gamma_mode {
+	VIIF_GAMMA_COMPRESSED = 0,
+	VIIF_GAMMA_LINEAR = 1,
+};
+
+/**
+ * struct viif_l2_gamma_config - L2ISP gamma correction parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA`
+ * @pathid: 0 for Capture Path 0, 1 for Capture Path 1.
+ * @table_en: 6bit vector to enable gamma table; all 0 to disable gamma correction
+ * @vsplit: Line switching position of first table and second table. Range: [0..4094].
+ *          Should set 0 in case 0 is set to @enable
+ * @mode: &enum viif_gamma_mode value.
+ *        Should set VIIF_GAMMA_COMPRESSED when 0 is set to @enable
+ * @table: gamma table for L2ISP gamma; 6 channels, each has __u16 typed 512 bytes.
+ *         [0]: G/Y(1st table), [1]: G/Y(2nd table), [2]: B/U(1st table)
+ *         [3]: B/U(2nd table), [4]: R/V(1st table), [5]: R/V(2nd table)
+ */
+struct viif_l2_gamma_config {
+	__u32 pathid;
+	__u32 table_en;
+	__u32 vsplit;
+	__u32 mode;
+	__u16 table[6][256];
+};
+
+/**
+ * struct viif_csi2rx_dphy_calibration_status - CSI2-RX D-PHY Calibration
+ * information for :ref:`V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS`
+ * @term_cal_with_rext: Result of termination calibration with rext
+ * @clock_lane_offset_cal: Result of offset calibration of clock lane
+ * @data_lane0_offset_cal: Result of offset calibration of data lane0
+ * @data_lane1_offset_cal: Result of offset calibration of data lane1
+ * @data_lane2_offset_cal: Result of offset calibration of data lane2
+ * @data_lane3_offset_cal: Result of offset calibration of data lane3
+ * @data_lane0_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane0
+ * @data_lane1_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane1
+ * @data_lane2_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane2
+ * @data_lane3_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane3
+ *
+ * Possible returned values for each member are:
+ *
+ * - -EAGAIN: calibration is not done
+ * - -EIO: calibration was failed
+ * - 0; calibration is succeeded
+ */
+struct viif_csi2rx_dphy_calibration_status {
+	__s32 term_cal_with_rext;
+	__s32 clock_lane_offset_cal;
+	__s32 data_lane0_offset_cal;
+	__s32 data_lane1_offset_cal;
+	__s32 data_lane2_offset_cal;
+	__s32 data_lane3_offset_cal;
+	__s32 data_lane0_ddl_tuning_cal;
+	__s32 data_lane1_ddl_tuning_cal;
+	__s32 data_lane2_ddl_tuning_cal;
+	__s32 data_lane3_ddl_tuning_cal;
+};
+
+/**
+ * struct viif_csi2rx_err_status - CSI2RX Error status parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS`
+ * @err_phy_fatal: D-PHY FATAL error.
+ *
+ *  - bit[3]: Start of transmission error on DATA Lane3.
+ *  - bit[2]: Start of transmission error on DATA Lane2.
+ *  - bit[1]: Start of transmission error on DATA Lane1.
+ *  - bit[0]: Start of transmission error on DATA Lane0.
+ * @err_pkt_fatal: Packet FATAL error.
+ *
+ *  - bit[16]: Header ECC contains 2 errors, unrecoverable.
+ *  - bit[3]: Checksum error detected on virtual channel 3.
+ *  - bit[2]: Checksum error detected on virtual channel 2.
+ *  - bit[1]: Checksum error detected on virtual channel 1.
+ *  - bit[0]: Checksum error detected on virtual channel 0.
+ * @err_frame_fatal: Frame FATAL error.
+ *
+ *  - bit[19]: Last received Frame, in virtual channel 3, has at least one CRC error.
+ *  - bit[18]: Last received Frame, in virtual channel 2, has at least one CRC error.
+ *  - bit[17]: Last received Frame, in virtual channel 1, has at least one CRC error.
+ *  - bit[16]: Last received Frame, in virtual channel 0, has at least one CRC error.
+ *  - bit[11]: Incorrect Frame Sequence detected in virtual channel 3.
+ *  - bit[10]: Incorrect Frame Sequence detected in virtual channel 2.
+ *  - bit[9]: Incorrect Frame Sequence detected in virtual channel 1.
+ *  - bit[8]: Incorrect Frame Sequence detected in virtual channel 0.
+ *  - bit[3]: Error matching Frame Start with Frame End for virtual channel 3.
+ *  - bit[2]: Error matching Frame Start with Frame End for virtual channel 2.
+ *  - bit[1]: Error matching Frame Start with Frame End for virtual channel 1.
+ *  - bit[0]: Error matching Frame Start with Frame End for virtual channel 0.
+ * @err_phy: D-PHY error.
+ *
+ *  - bit[19]: Escape Entry Error on Data Lane 3.
+ *  - bit[18]: Escape Entry Error on Data Lane 2.
+ *  - bit[17]: Escape Entry Error on Data Lane 1.
+ *  - bit[16]: Escape Entry Error on Data Lane 0.
+ *  - bit[3]: Start of Transmission Error on Data Lane 3 (synchronization can still be achieved).
+ *  - bit[2]: Start of Transmission Error on Data Lane 2 (synchronization can still be achieved).
+ *  - bit[1]: Start of Transmission Error on Data Lane 1 (synchronization can still be achieved).
+ *  - bit[0]: Start of Transmission Error on Data Lane 0 (synchronization can still be achieved).
+ * @err_pkt: Packet error.
+ *
+ *  - bit[19]: Header Error detected and corrected on virtual channel 3.
+ *  - bit[18]: Header Error detected and corrected on virtual channel 2.
+ *  - bit[17]: Header Error detected and corrected on virtual channel 1.
+ *  - bit[16]: Header Error detected and corrected on virtual channel 0.
+ *  - bit[3]: Unrecognized or unimplemented data type detected in virtual channel 3.
+ *  - bit[2]: Unrecognized or unimplemented data type detected in virtual channel 2.
+ *  - bit[1]: Unrecognized or unimplemented data type detected in virtual channel 1.
+ *  - bit[0]: Unrecognized or unimplemented data type detected in virtual channel 0.
+ * @err_line: Line error.
+ *
+ *  - bit[23]: Error in the sequence of lines for vc7 and dt7.
+ *  - bit[22]: Error in the sequence of lines for vc6 and dt6.
+ *  - bit[21]: Error in the sequence of lines for vc5 and dt5.
+ *  - bit[20]: Error in the sequence of lines for vc4 and dt4.
+ *  - bit[19]: Error in the sequence of lines for vc3 and dt3.
+ *  - bit[18]: Error in the sequence of lines for vc2 and dt2.
+ *  - bit[17]: Error in the sequence of lines for vc1 and dt1.
+ *  - bit[16]: Error in the sequence of lines for vc0 and dt0.
+ *  - bit[7]: Error matching Line Start with Line End for vc7 and dt7.
+ *  - bit[6]: Error matching Line Start with Line End for vc6 and dt6.
+ *  - bit[5]: Error matching Line Start with Line End for vc5 and dt5.
+ *  - bit[4]: Error matching Line Start with Line End for vc4 and dt4.
+ *  - bit[3]: Error matching Line Start with Line End for vc3 and dt3.
+ *  - bit[2]: Error matching Line Start with Line End for vc2 and dt2.
+ *  - bit[1]: Error matching Line Start with Line End for vc1 and dt1.
+ *  - bit[0]: Error matching Line Start with Line End for vc0 and dt0.
+ */
+struct viif_csi2rx_err_status {
+	__u32 err_phy_fatal;
+	__u32 err_pkt_fatal;
+	__u32 err_frame_fatal;
+	__u32 err_phy;
+	__u32 err_pkt;
+	__u32 err_line;
+};
+
+/**
+ * struct viif_l1_info - L1ISP AWB information
+ * for &struct viif_isp_capture_status
+ * @avg_lum_weight: weighted average luminance value at average luminance generation
+ * @avg_lum_block: average luminance of each block.
+ *                 Nested indices are: [y position][x position].
+ * @avg_lum_four_line_lum: 4-lines average luminance.
+ *                         avg_lum_four_line_lum[n] corresponds to aexp_ave4linesy[n]
+ * @avg_satur_pixnum: the number of saturated pixel at average luminance generation
+ * @avg_black_pixnum: the number of black pixel at average luminance generation
+ * @awb_ave_u: U average value of AWB adjustment
+ * @awb_ave_v: V average value of AWB adjustment
+ * @awb_accumulated_pixel: Accumulated pixel count of AWB adjustment
+ * @awb_gain_r: R gain used in the next frame of AWB adjustment
+ * @awb_gain_g: G gain used in the next frame of AWB adjustment
+ * @awb_gain_b: B gain used in the next frame of AWB adjustment
+ * @awb_status_u: boolean value of U convergence state of AWB adjustment
+ *                (0: not-converged, 1: converged)
+ * @awb_status_v: boolean value of V convergence state of AWB adjustment
+ *                (0: not-converged, 1: converged)
+ */
+struct viif_l1_info {
+	__u32 avg_lum_weight;
+	__u32 avg_lum_block[8][8];
+	__u32 avg_lum_four_line_lum[4];
+	__u32 avg_satur_pixnum;
+	__u32 avg_black_pixnum;
+	__u32 awb_ave_u;
+	__u32 awb_ave_v;
+	__u32 awb_accumulated_pixel;
+	__u32 awb_gain_r;
+	__u32 awb_gain_g;
+	__u32 awb_gain_b;
+	__u8 awb_status_u;
+	__u8 awb_status_v;
+};
+
+/**
+ * struct viif_isp_capture_status - L1ISP capture information
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS`
+ * @l1_info: L1ISP AWB information. Refer to &struct viif_l1_info
+ */
+struct viif_isp_capture_status {
+	struct viif_l1_info l1_info;
+};
+
+/**
+ * struct viif_reported_errors - Errors since last call
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS`
+ * @main: error flag value for capture device 0 and 1
+ * @sub: error flag value for capture device 2
+ * @csi2rx: error flag value for CSI2 receiver
+ */
+struct viif_reported_errors {
+	__u32 main;
+	__u32 sub;
+	__u32 csi2rx;
+};
+
+#endif /* __UAPI_VISCONTI_VIIF_H_ */
-- 
2.34.1


