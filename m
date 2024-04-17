Return-Path: <linux-kernel+bounces-148328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1A8A80FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFDD1F21142
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C217713C838;
	Wed, 17 Apr 2024 10:31:09 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9C84D21
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349869; cv=none; b=rAWbbx848oxGNKnxi+8HfVwH2BPy5Cm2sRladiaGAPFCV46pu1lZwU4ugeLCNZ3HceSh7GlTYnsIa4VQQsriYv4fUjJVI7xb2TlqR3YKdNJ/S0GweQb7juZLepOMd6WYWdbFmnHhLe+2L31SRDbfJGa1ZIsTmtHSfOKBPQ2a/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349869; c=relaxed/simple;
	bh=JmN3ov/nWWxkMqZnFvvpCKbxW2JVrc7zlR+YNMFMDVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaRmhdKCsLAvz+Ktr3Z5lbN1A2o/xlG1CUfnsume5uAufXKcPvmqrlqmnk9cuT/tupzyZOOTTyeDVL610wpHzYei6pXnWJOvDD5sTngNSnaV+ZA2lEHhfRAsYnMB/+cY7wtV7PiERoKniPJ5gr2RCMZyOiZ5oxzIFq3OWXcPTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by albert.telenet-ops.be with bizsmtp
	id CAX32C00P0SSLxL06AX3Va; Wed, 17 Apr 2024 12:31:04 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rx2Yd-009LE9-M6;
	Wed, 17 Apr 2024 12:31:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rx2Xe-00FLSF-Fd;
	Wed, 17 Apr 2024 12:29:26 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] pmdomain: renesas: rcar-sysc: Add R-Car M3-W power-off delay quirk
Date: Wed, 17 Apr 2024 12:29:25 +0200
Message-Id: <ecbc3465c598084c904dd3714e2894463094ed9a.1713348705.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713348705.git.geert+renesas@glider.be>
References: <cover.1713348705.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

R-Car M3-W needs a delay of 1 µs before powering off the A3IR and A3VC
power domains.  Add support for this using a new flag, which indicates
that a power area is subject to this quirk.

Inspired by a patch in the BSP by Dien Pham.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes compared to the BSP:
  - Use a new flag in the SoC-specific area description instead of
    comparing PM Domain names (which applied the quirk to all SoCs),
  - Support for R-Car H3 ES1.x was dropped in v6.4, so it no longer
    needs handling.
---
 drivers/pmdomain/renesas/r8a77960-sysc.c | 6 ++++--
 drivers/pmdomain/renesas/rcar-sysc.c     | 4 ++++
 drivers/pmdomain/renesas/rcar-sysc.h     | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/r8a77960-sysc.c b/drivers/pmdomain/renesas/r8a77960-sysc.c
index e6f2c3f961255f40..2ab3f565d2b0f889 100644
--- a/drivers/pmdomain/renesas/r8a77960-sysc.c
+++ b/drivers/pmdomain/renesas/r8a77960-sysc.c
@@ -32,12 +32,14 @@ static const struct rcar_sysc_area r8a77960_areas[] __initconst = {
 	{ "ca53-cpu3",	0x200, 3, R8A7796_PD_CA53_CPU3,	R8A7796_PD_CA53_SCU,
 	  PD_CPU_NOCR },
 	{ "cr7",	0x240, 0, R8A7796_PD_CR7,	R8A7796_PD_ALWAYS_ON },
-	{ "a3vc",	0x380, 0, R8A7796_PD_A3VC,	R8A7796_PD_ALWAYS_ON },
+	{ "a3vc",	0x380, 0, R8A7796_PD_A3VC,	R8A7796_PD_ALWAYS_ON,
+	  PD_OFF_DELAY },
 	{ "a2vc0",	0x3c0, 0, R8A7796_PD_A2VC0,	R8A7796_PD_A3VC },
 	{ "a2vc1",	0x3c0, 1, R8A7796_PD_A2VC1,	R8A7796_PD_A3VC },
 	{ "3dg-a",	0x100, 0, R8A7796_PD_3DG_A,	R8A7796_PD_ALWAYS_ON },
 	{ "3dg-b",	0x100, 1, R8A7796_PD_3DG_B,	R8A7796_PD_3DG_A },
-	{ "a3ir",	0x180, 0, R8A7796_PD_A3IR,	R8A7796_PD_ALWAYS_ON },
+	{ "a3ir",	0x180, 0, R8A7796_PD_A3IR,	R8A7796_PD_ALWAYS_ON,
+	  PD_OFF_DELAY },
 };
 
 
diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index a9d92e38fcee902c..b99326917330f5f1 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -90,6 +90,10 @@ static int rcar_sysc_pwr_on_off(const struct rcar_sysc_pd *pd, bool on)
 	if (ret)
 		return -EAGAIN;
 
+	/* Power-off delay quirk */
+	if (!on && (pd->flags & PD_OFF_DELAY))
+		udelay(1);
+
 	/* Submit power shutoff or power resume request */
 	iowrite32(BIT(pd->chan_bit), rcar_sysc_base + pd->chan_offs + reg_offs);
 
diff --git a/drivers/pmdomain/renesas/rcar-sysc.h b/drivers/pmdomain/renesas/rcar-sysc.h
index 8c4ec36ed7da2f9d..07ffce310686b2ce 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.h
+++ b/drivers/pmdomain/renesas/rcar-sysc.h
@@ -16,6 +16,7 @@
 #define PD_CPU		BIT(0)	/* Area contains main CPU core */
 #define PD_SCU		BIT(1)	/* Area contains SCU and L2 cache */
 #define PD_NO_CR	BIT(2)	/* Area lacks PWR{ON,OFF}CR registers */
+#define PD_OFF_DELAY	BIT(3)	/* Area is subject to power-off delay quirk */
 
 #define PD_CPU_CR	PD_CPU		  /* CPU area has CR (R-Car H1) */
 #define PD_CPU_NOCR	PD_CPU | PD_NO_CR /* CPU area lacks CR (R-Car Gen2/3) */
-- 
2.34.1


