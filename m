Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBA07C6BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377950AbjJLLCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378062AbjJLLCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:02:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADB5E9;
        Thu, 12 Oct 2023 04:02:38 -0700 (PDT)
Received: from localhost (dynamic-002-247-255-251.2.247.pool.telefonica.de [2.247.255.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A0B1B66071F8;
        Thu, 12 Oct 2023 12:02:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697108557;
        bh=If4vu2Ws8/gwGYsmHKm3MkWRUPRVWs7H1YZDOH40N14=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=h6Ef6UWLwVJ6yiJuLW+FmS8o0iaJa29Ptb/fLoPlgOvetYrWefRL+1zQ6CKeIQp6V
         1vhiGzL/CgI9ejbZmLE8GWxsI20UoKol82r2SjrkY4Po3+awX2VmrWhGLage8N3SuV
         tfYgnN22agdjn61QbnveNFw6IMEvoIXRMxq3LkZYe8Eu9QbMV1gDTq6uSJkNYY2CEc
         krX0+rm2k/VstndQjBHW8mYRdRGYqvsu+P5n+FR1ojIHdidk8O6nObtj5+xy4rrpMg
         426obGLT82JxoHIwboEhljLf5K88BKCdP7Z6VaktKuwQHbfVTuc6l/3kkhmDL5sEHc
         U2o13VwoyVkpg==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Oct 2023 13:01:01 +0200
Subject: [PATCH v13 3/8] media: platform: chips-media: Move Coda to separate folder
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-wave5_v13_media_master-v13-3-5ac60ccbf2ce@collabora.com>
References: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
In-Reply-To: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Darren Etheridge <detheridge@ti.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697108536; l=8113;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=If4vu2Ws8/gwGYsmHKm3MkWRUPRVWs7H1YZDOH40N14=;
 b=jkoSjofGP7sk1Tvjtx01w4YsmvcMp/Wi4WMDtPo4eypMyl+y+fOoL9p68IwyNs64E6P4FtSdEEOy
 m71VVRWYA13o/uSj7ETUFGlXsHg4ePyddR8v7o9rR+J+PpJAR6O0
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the folder structure for a second Chips&Media driver.
Move the Coda driver to a sub-directory.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 MAINTAINERS                                            |  2 +-
 drivers/media/platform/chips-media/Kconfig             | 17 +----------------
 drivers/media/platform/chips-media/Makefile            |  5 +----
 drivers/media/platform/chips-media/coda/Kconfig        | 18 ++++++++++++++++++
 drivers/media/platform/chips-media/coda/Makefile       |  6 ++++++
 .../media/platform/chips-media/{ => coda}/coda-bit.c   |  0
 .../platform/chips-media/{ => coda}/coda-common.c      |  0
 .../media/platform/chips-media/{ => coda}/coda-gdi.c   |  0
 .../media/platform/chips-media/{ => coda}/coda-h264.c  |  0
 .../media/platform/chips-media/{ => coda}/coda-jpeg.c  |  0
 .../media/platform/chips-media/{ => coda}/coda-mpeg2.c |  0
 .../media/platform/chips-media/{ => coda}/coda-mpeg4.c |  0
 drivers/media/platform/chips-media/{ => coda}/coda.h   |  0
 .../media/platform/chips-media/{ => coda}/coda_regs.h  |  0
 .../media/platform/chips-media/{ => coda}/imx-vdoa.c   |  0
 .../media/platform/chips-media/{ => coda}/imx-vdoa.h   |  0
 drivers/media/platform/chips-media/{ => coda}/trace.h  |  2 +-
 17 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..063a11791bbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5093,7 +5093,7 @@ M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/coda.yaml
-F:	drivers/media/platform/chips-media/
+F:	drivers/media/platform/chips-media/coda
 
 CODE OF CONDUCT
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/drivers/media/platform/chips-media/Kconfig b/drivers/media/platform/chips-media/Kconfig
index 57f8f8a22df8..f87a0d693df7 100644
--- a/drivers/media/platform/chips-media/Kconfig
+++ b/drivers/media/platform/chips-media/Kconfig
@@ -2,19 +2,4 @@
 
 comment "Chips&Media media platform drivers"
 
-config VIDEO_CODA
-	tristate "Chips&Media Coda multi-standard codec IP"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && OF && (ARCH_MXC || COMPILE_TEST)
-	select SRAM
-	select VIDEOBUF2_DMA_CONTIG
-	select VIDEOBUF2_VMALLOC
-	select V4L2_JPEG_HELPER
-	select V4L2_MEM2MEM_DEV
-	select GENERIC_ALLOCATOR
-	help
-	   Coda is a range of video codec IPs that supports
-	   H.264, MPEG-4, and other video formats.
-
-config VIDEO_IMX_VDOA
-	def_tristate VIDEO_CODA if SOC_IMX6Q || COMPILE_TEST
+source "drivers/media/platform/chips-media/coda/Kconfig"
diff --git a/drivers/media/platform/chips-media/Makefile b/drivers/media/platform/chips-media/Makefile
index bbb16425a875..5ee693f651c1 100644
--- a/drivers/media/platform/chips-media/Makefile
+++ b/drivers/media/platform/chips-media/Makefile
@@ -1,6 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-coda-vpu-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
-
-obj-$(CONFIG_VIDEO_CODA) += coda-vpu.o
-obj-$(CONFIG_VIDEO_IMX_VDOA) += imx-vdoa.o
+obj-y += coda/
diff --git a/drivers/media/platform/chips-media/coda/Kconfig b/drivers/media/platform/chips-media/coda/Kconfig
new file mode 100644
index 000000000000..cb7b66c71380
--- /dev/null
+++ b/drivers/media/platform/chips-media/coda/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config VIDEO_CODA
+	tristate "Chips&Media Coda multi-standard codec IP"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && OF && (ARCH_MXC || COMPILE_TEST)
+	select SRAM
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	select V4L2_JPEG_HELPER
+	select V4L2_MEM2MEM_DEV
+	select GENERIC_ALLOCATOR
+	help
+	   Coda is a range of video codec IPs that supports
+	   H.264, MPEG-4, and other video formats.
+
+config VIDEO_IMX_VDOA
+	def_tristate VIDEO_CODA if SOC_IMX6Q || COMPILE_TEST
diff --git a/drivers/media/platform/chips-media/coda/Makefile b/drivers/media/platform/chips-media/coda/Makefile
new file mode 100644
index 000000000000..bbb16425a875
--- /dev/null
+++ b/drivers/media/platform/chips-media/coda/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+coda-vpu-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
+
+obj-$(CONFIG_VIDEO_CODA) += coda-vpu.o
+obj-$(CONFIG_VIDEO_IMX_VDOA) += imx-vdoa.o
diff --git a/drivers/media/platform/chips-media/coda-bit.c b/drivers/media/platform/chips-media/coda/coda-bit.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-bit.c
rename to drivers/media/platform/chips-media/coda/coda-bit.c
diff --git a/drivers/media/platform/chips-media/coda-common.c b/drivers/media/platform/chips-media/coda/coda-common.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-common.c
rename to drivers/media/platform/chips-media/coda/coda-common.c
diff --git a/drivers/media/platform/chips-media/coda-gdi.c b/drivers/media/platform/chips-media/coda/coda-gdi.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-gdi.c
rename to drivers/media/platform/chips-media/coda/coda-gdi.c
diff --git a/drivers/media/platform/chips-media/coda-h264.c b/drivers/media/platform/chips-media/coda/coda-h264.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-h264.c
rename to drivers/media/platform/chips-media/coda/coda-h264.c
diff --git a/drivers/media/platform/chips-media/coda-jpeg.c b/drivers/media/platform/chips-media/coda/coda-jpeg.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-jpeg.c
rename to drivers/media/platform/chips-media/coda/coda-jpeg.c
diff --git a/drivers/media/platform/chips-media/coda-mpeg2.c b/drivers/media/platform/chips-media/coda/coda-mpeg2.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-mpeg2.c
rename to drivers/media/platform/chips-media/coda/coda-mpeg2.c
diff --git a/drivers/media/platform/chips-media/coda-mpeg4.c b/drivers/media/platform/chips-media/coda/coda-mpeg4.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-mpeg4.c
rename to drivers/media/platform/chips-media/coda/coda-mpeg4.c
diff --git a/drivers/media/platform/chips-media/coda.h b/drivers/media/platform/chips-media/coda/coda.h
similarity index 100%
rename from drivers/media/platform/chips-media/coda.h
rename to drivers/media/platform/chips-media/coda/coda.h
diff --git a/drivers/media/platform/chips-media/coda_regs.h b/drivers/media/platform/chips-media/coda/coda_regs.h
similarity index 100%
rename from drivers/media/platform/chips-media/coda_regs.h
rename to drivers/media/platform/chips-media/coda/coda_regs.h
diff --git a/drivers/media/platform/chips-media/imx-vdoa.c b/drivers/media/platform/chips-media/coda/imx-vdoa.c
similarity index 100%
rename from drivers/media/platform/chips-media/imx-vdoa.c
rename to drivers/media/platform/chips-media/coda/imx-vdoa.c
diff --git a/drivers/media/platform/chips-media/imx-vdoa.h b/drivers/media/platform/chips-media/coda/imx-vdoa.h
similarity index 100%
rename from drivers/media/platform/chips-media/imx-vdoa.h
rename to drivers/media/platform/chips-media/coda/imx-vdoa.h
diff --git a/drivers/media/platform/chips-media/trace.h b/drivers/media/platform/chips-media/coda/trace.h
similarity index 99%
rename from drivers/media/platform/chips-media/trace.h
rename to drivers/media/platform/chips-media/coda/trace.h
index 19f98e6dafb9..abc6a01a74e9 100644
--- a/drivers/media/platform/chips-media/trace.h
+++ b/drivers/media/platform/chips-media/coda/trace.h
@@ -167,7 +167,7 @@ DEFINE_EVENT(coda_buf_class, coda_jpeg_done,
 #endif /* __CODA_TRACE_H__ */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH ../../drivers/media/platform/chips-media
+#define TRACE_INCLUDE_PATH ../../drivers/media/platform/chips-media/coda
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace
 

-- 
2.25.1
