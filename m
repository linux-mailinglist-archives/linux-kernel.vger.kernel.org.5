Return-Path: <linux-kernel+bounces-148324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E08A80FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEB41F21B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7B813C3CD;
	Wed, 17 Apr 2024 10:31:08 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31041132803
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349868; cv=none; b=Cn1xPVgh1AQdsv8lU3a5VowbIlBiIcYMgNZp1p3A9AzT3HzVAoZ3KCrzKL78KYkKklavX6kW8bXeQeslMVqfa5MEanM5vUEgU9RMFj22u0DINehikQH2Biy1H1ROLes12WBWc5tPjQLMRD06fIWUsXd7fHiZ07c4ZgUQiA8E2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349868; c=relaxed/simple;
	bh=mYXDeWa0is90dtQWkZlkBo5+hUVUrlkI/UDefX6ZN08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Emr+gOmXKRmyAHx2Y2I8PtJ50rjbgmSBafTCzpOpSpy9AvKhbymfMgUFAUr2pmD0oO2RJ4ZqfSsdj0tnDJ1iFjfJuAtmCzHHiGhqx0lIEWgXl6/juxrECuw8kiefbjF8bmz35xB7gKD4N5/RanALioxs7+Dnhsv/gPrNapRYcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by michel.telenet-ops.be with bizsmtp
	id CAX32C00c0SSLxL06AX3rz; Wed, 17 Apr 2024 12:31:04 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rx2Yd-009LEF-QF;
	Wed, 17 Apr 2024 12:31:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rx2Xe-00FLS5-DY;
	Wed, 17 Apr 2024 12:29:26 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] pmdomain: renesas: rcar-sysc: Split R-Car M3-W and M3-W+ sub-drivers
Date: Wed, 17 Apr 2024 12:29:23 +0200
Message-Id: <a416e2bae7227c08d7e7d158366ab021f4d6cc18.1713348705.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713348705.git.geert+renesas@glider.be>
References: <cover.1713348705.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently R-Car M3-W and M3-W+ are handled by a single sub-driver,
but using separate Kconfig symbols and separate rcar_sysc_info
structures, and fixup code to handle the remaining differences.

Prepare for handling more differences by splitting them in two separate
sub-drivers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/Makefile             |  4 +--
 .../{r8a7796-sysc.c => r8a77960-sysc.c}       | 28 +++----------------
 .../{r8a7796-sysc.c => r8a77961-sysc.c}       | 28 +++----------------
 3 files changed, 10 insertions(+), 50 deletions(-)
 copy drivers/pmdomain/renesas/{r8a7796-sysc.c => r8a77960-sysc.c} (69%)
 rename drivers/pmdomain/renesas/{r8a7796-sysc.c => r8a77961-sysc.c} (69%)

diff --git a/drivers/pmdomain/renesas/Makefile b/drivers/pmdomain/renesas/Makefile
index 89180f19c23be732..0391e6e67440a786 100644
--- a/drivers/pmdomain/renesas/Makefile
+++ b/drivers/pmdomain/renesas/Makefile
@@ -14,8 +14,8 @@ obj-$(CONFIG_SYSC_R8A7791)	+= r8a7791-sysc.o
 obj-$(CONFIG_SYSC_R8A7792)	+= r8a7792-sysc.o
 obj-$(CONFIG_SYSC_R8A7794)	+= r8a7794-sysc.o
 obj-$(CONFIG_SYSC_R8A7795)	+= r8a7795-sysc.o
-obj-$(CONFIG_SYSC_R8A77960)	+= r8a7796-sysc.o
-obj-$(CONFIG_SYSC_R8A77961)	+= r8a7796-sysc.o
+obj-$(CONFIG_SYSC_R8A77960)	+= r8a77960-sysc.o
+obj-$(CONFIG_SYSC_R8A77961)	+= r8a77961-sysc.o
 obj-$(CONFIG_SYSC_R8A77965)	+= r8a77965-sysc.o
 obj-$(CONFIG_SYSC_R8A77970)	+= r8a77970-sysc.o
 obj-$(CONFIG_SYSC_R8A77980)	+= r8a77980-sysc.o
diff --git a/drivers/pmdomain/renesas/r8a7796-sysc.c b/drivers/pmdomain/renesas/r8a77960-sysc.c
similarity index 69%
copy from drivers/pmdomain/renesas/r8a7796-sysc.c
copy to drivers/pmdomain/renesas/r8a77960-sysc.c
index 471bd5b3b6ada18d..e6f2c3f961255f40 100644
--- a/drivers/pmdomain/renesas/r8a7796-sysc.c
+++ b/drivers/pmdomain/renesas/r8a77960-sysc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Renesas R-Car M3-W/W+ System Controller
+ * Renesas R-Car M3-W System Controller
  *
  * Copyright (C) 2016 Glider bvba
  * Copyright (C) 2018-2019 Renesas Electronics Corporation
@@ -13,7 +13,7 @@
 
 #include "rcar-sysc.h"
 
-static struct rcar_sysc_area r8a7796_areas[] __initdata = {
+static const struct rcar_sysc_area r8a77960_areas[] __initconst = {
 	{ "always-on",	    0, 0, R8A7796_PD_ALWAYS_ON,	-1, PD_ALWAYS_ON },
 	{ "ca57-scu",	0x1c0, 0, R8A7796_PD_CA57_SCU,	R8A7796_PD_ALWAYS_ON,
 	  PD_SCU },
@@ -41,27 +41,7 @@ static struct rcar_sysc_area r8a7796_areas[] __initdata = {
 };
 
 
-#ifdef CONFIG_SYSC_R8A77960
 const struct rcar_sysc_info r8a77960_sysc_info __initconst = {
-	.areas = r8a7796_areas,
-	.num_areas = ARRAY_SIZE(r8a7796_areas),
+	.areas = r8a77960_areas,
+	.num_areas = ARRAY_SIZE(r8a77960_areas),
 };
-#endif /* CONFIG_SYSC_R8A77960 */
-
-#ifdef CONFIG_SYSC_R8A77961
-static int __init r8a77961_sysc_init(void)
-{
-	rcar_sysc_nullify(r8a7796_areas, ARRAY_SIZE(r8a7796_areas),
-			  R8A7796_PD_A2VC0);
-
-	return 0;
-}
-
-const struct rcar_sysc_info r8a77961_sysc_info __initconst = {
-	.init = r8a77961_sysc_init,
-	.areas = r8a7796_areas,
-	.num_areas = ARRAY_SIZE(r8a7796_areas),
-	.extmask_offs = 0x2f8,
-	.extmask_val = BIT(0),
-};
-#endif /* CONFIG_SYSC_R8A77961 */
diff --git a/drivers/pmdomain/renesas/r8a7796-sysc.c b/drivers/pmdomain/renesas/r8a77961-sysc.c
similarity index 69%
rename from drivers/pmdomain/renesas/r8a7796-sysc.c
rename to drivers/pmdomain/renesas/r8a77961-sysc.c
index 471bd5b3b6ada18d..a1155068ee7a60b8 100644
--- a/drivers/pmdomain/renesas/r8a7796-sysc.c
+++ b/drivers/pmdomain/renesas/r8a77961-sysc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Renesas R-Car M3-W/W+ System Controller
+ * Renesas R-Car M3-W+ System Controller
  *
  * Copyright (C) 2016 Glider bvba
  * Copyright (C) 2018-2019 Renesas Electronics Corporation
@@ -13,7 +13,7 @@
 
 #include "rcar-sysc.h"
 
-static struct rcar_sysc_area r8a7796_areas[] __initdata = {
+static const struct rcar_sysc_area r8a77961_areas[] __initconst = {
 	{ "always-on",	    0, 0, R8A7796_PD_ALWAYS_ON,	-1, PD_ALWAYS_ON },
 	{ "ca57-scu",	0x1c0, 0, R8A7796_PD_CA57_SCU,	R8A7796_PD_ALWAYS_ON,
 	  PD_SCU },
@@ -33,35 +33,15 @@ static struct rcar_sysc_area r8a7796_areas[] __initdata = {
 	  PD_CPU_NOCR },
 	{ "cr7",	0x240, 0, R8A7796_PD_CR7,	R8A7796_PD_ALWAYS_ON },
 	{ "a3vc",	0x380, 0, R8A7796_PD_A3VC,	R8A7796_PD_ALWAYS_ON },
-	{ "a2vc0",	0x3c0, 0, R8A7796_PD_A2VC0,	R8A7796_PD_A3VC },
 	{ "a2vc1",	0x3c0, 1, R8A7796_PD_A2VC1,	R8A7796_PD_A3VC },
 	{ "3dg-a",	0x100, 0, R8A7796_PD_3DG_A,	R8A7796_PD_ALWAYS_ON },
 	{ "3dg-b",	0x100, 1, R8A7796_PD_3DG_B,	R8A7796_PD_3DG_A },
 	{ "a3ir",	0x180, 0, R8A7796_PD_A3IR,	R8A7796_PD_ALWAYS_ON },
 };
 
-
-#ifdef CONFIG_SYSC_R8A77960
-const struct rcar_sysc_info r8a77960_sysc_info __initconst = {
-	.areas = r8a7796_areas,
-	.num_areas = ARRAY_SIZE(r8a7796_areas),
-};
-#endif /* CONFIG_SYSC_R8A77960 */
-
-#ifdef CONFIG_SYSC_R8A77961
-static int __init r8a77961_sysc_init(void)
-{
-	rcar_sysc_nullify(r8a7796_areas, ARRAY_SIZE(r8a7796_areas),
-			  R8A7796_PD_A2VC0);
-
-	return 0;
-}
-
 const struct rcar_sysc_info r8a77961_sysc_info __initconst = {
-	.init = r8a77961_sysc_init,
-	.areas = r8a7796_areas,
-	.num_areas = ARRAY_SIZE(r8a7796_areas),
+	.areas = r8a77961_areas,
+	.num_areas = ARRAY_SIZE(r8a77961_areas),
 	.extmask_offs = 0x2f8,
 	.extmask_val = BIT(0),
 };
-#endif /* CONFIG_SYSC_R8A77961 */
-- 
2.34.1


