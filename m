Return-Path: <linux-kernel+bounces-66954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A08BC856439
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904B2B25CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978212FF64;
	Thu, 15 Feb 2024 13:07:25 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568712F58B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002444; cv=none; b=ge8n2BWATRW1qqdk3pkuhexNAJRbZfSPat8CmEk/1okGf43rkeIG3+OHDhapQ3ADnVvaWc1u/5rtMNpRmbfqh6SptlS1beaDAwIhPKEmVE4RlXnVMAiDflt90r668+NoW7uZi3ciQOifNah5lEHTfPfNqHRJvPZJa5trnFL89Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002444; c=relaxed/simple;
	bh=fMYvOK1mdXbFO86G56O8JeErF+gEsuTl0jzDCigw+k0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BsLnCLSAMvky6FlaiBboJPIaU89wi4GGvzKv74s/3M0YzqAQBXwy7oQ/IGQNHRzqp65t+xkeSjziMnvU2LEtGD3u1AdJ61joErw86IfWY/niWZNujj6bp7IpVKY7e6oQLkKeai/EMzUWq03jV8EYuZQPjPvHE0bhn3mh+LkXW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by andre.telenet-ops.be with bizsmtp
	id nR7E2B00G0LVNSS01R7EfC; Thu, 15 Feb 2024 14:07:14 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabSF-000gxH-3w;
	Thu, 15 Feb 2024 14:07:14 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabSM-00HYeO-Fd;
	Thu, 15 Feb 2024 14:07:14 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] mfd: mc13xxx: Use bitfield helpers
Date: Thu, 15 Feb 2024 14:07:13 +0100
Message-Id: <ef7d5fc3d867338520392417cdf2b67ba19aecde.1708002264.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the FIELD_GET() helper, instead of defining a custom macro
implementing the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/mfd/mc13xxx-core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 1000572761a84afa..920797b806ced8b9 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -7,6 +7,7 @@
  * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -174,28 +175,27 @@ int mc13xxx_irq_free(struct mc13xxx *mc13xxx, int irq, void *dev)
 }
 EXPORT_SYMBOL(mc13xxx_irq_free);
 
-#define maskval(reg, mask)	(((reg) & (mask)) >> __ffs(mask))
 static void mc13xxx_print_revision(struct mc13xxx *mc13xxx, u32 revision)
 {
 	dev_info(mc13xxx->dev, "%s: rev: %d.%d, "
 			"fin: %d, fab: %d, icid: %d/%d\n",
 			mc13xxx->variant->name,
-			maskval(revision, MC13XXX_REVISION_REVFULL),
-			maskval(revision, MC13XXX_REVISION_REVMETAL),
-			maskval(revision, MC13XXX_REVISION_FIN),
-			maskval(revision, MC13XXX_REVISION_FAB),
-			maskval(revision, MC13XXX_REVISION_ICID),
-			maskval(revision, MC13XXX_REVISION_ICIDCODE));
+			FIELD_GET(MC13XXX_REVISION_REVFULL, revision),
+			FIELD_GET(MC13XXX_REVISION_REVMETAL, revision),
+			FIELD_GET(MC13XXX_REVISION_FIN, revision),
+			FIELD_GET(MC13XXX_REVISION_FAB, revision),
+			FIELD_GET(MC13XXX_REVISION_ICID, revision),
+			FIELD_GET(MC13XXX_REVISION_ICIDCODE, revision));
 }
 
 static void mc34708_print_revision(struct mc13xxx *mc13xxx, u32 revision)
 {
 	dev_info(mc13xxx->dev, "%s: rev %d.%d, fin: %d, fab: %d\n",
 			mc13xxx->variant->name,
-			maskval(revision, MC34708_REVISION_REVFULL),
-			maskval(revision, MC34708_REVISION_REVMETAL),
-			maskval(revision, MC34708_REVISION_FIN),
-			maskval(revision, MC34708_REVISION_FAB));
+			FIELD_GET(MC34708_REVISION_REVFULL, revision),
+			FIELD_GET(MC34708_REVISION_REVMETAL, revision),
+			FIELD_GET(MC34708_REVISION_FIN, revision),
+			FIELD_GET(MC34708_REVISION_FAB, revision));
 }
 
 /* These are only exported for mc13xxx-i2c and mc13xxx-spi */
-- 
2.34.1


