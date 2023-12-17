Return-Path: <linux-kernel+bounces-2783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAAE8161C8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6D1282C6B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA833481C0;
	Sun, 17 Dec 2023 19:31:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7B481AA
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrg-0007Ge-RU; Sun, 17 Dec 2023 20:31:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrg-00GXTk-9S; Sun, 17 Dec 2023 20:31:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrg-004ow4-0B; Sun, 17 Dec 2023 20:31:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] memory: emif: Simplify code handling CONFIG_DEBUG_FS
Date: Sun, 17 Dec 2023 20:31:31 +0100
Message-ID:  <2c7dd66d4a101b74b16e7e1839e30f3c88510c33.1702829744.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702829744.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702829744.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=cNuwKEMd45aqzupPi2qb5vZR8pJEhJctqL+QHzyhSEI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlf0yWF5TzdWoQllzg7+AC3DhtgKGmIgXjLgmM2 nhM6Lyqop2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX9MlgAKCRCPgPtYfRL+ TnL/CACL53V7d3OibbYPPfpyRIZAN/rX79i1zHBITtLob3jyamjbQGQsed30mABSa9VnIaUJS7j ne4+gx7tcKMm26iiEpRPRa26zpgYdbk5rKMuuELqVlX0dBCOrZJn3tvC49m28hOr8BhlWnA5yMa EUl4kblSnepsLENREKrwRn2qjJPbuuwVe1i+xD6DVFQKhuOKlfEq1t2Z0lhNcqAsMwmrZUVDJzP KVCTVBwPYKK0TgKD7/GOPB6lfb60rdGwi/+E9Ur5euJnPRMFYBoEp4RE5dIAvFTk7cZHs39YsaR 7U6CMcIk9uQbqtvF0u4eg3KseftHaYvqRzvIiF3WWRnY4XXD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Instead of using #ifdef make use of IS_ENABLED().

According to bloat-o-meter this patch doesn't change code sizes with
CONFIG_DEBUG_FS=n.

Also change emif_debugfs_init() to return void. The only caller doesn't
check the return value anyhow.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/memory/emif.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index f305643209f0..dd1d87f8fdc8 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -72,7 +72,6 @@ static DEFINE_SPINLOCK(emif_lock);
 static unsigned long	irq_state;
 static LIST_HEAD(device_list);
 
-#ifdef CONFIG_DEBUG_FS
 static void do_emif_regdump_show(struct seq_file *s, struct emif_data *emif,
 	struct emif_regs *regs)
 {
@@ -140,31 +139,24 @@ static int emif_mr4_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(emif_mr4);
 
-static int __init_or_module emif_debugfs_init(struct emif_data *emif)
+static void __init_or_module emif_debugfs_init(struct emif_data *emif)
 {
-	emif->debugfs_root = debugfs_create_dir(dev_name(emif->dev), NULL);
-	debugfs_create_file("regcache_dump", S_IRUGO, emif->debugfs_root, emif,
-			    &emif_regdump_fops);
-	debugfs_create_file("mr4", S_IRUGO, emif->debugfs_root, emif,
-			    &emif_mr4_fops);
-	return 0;
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		emif->debugfs_root = debugfs_create_dir(dev_name(emif->dev), NULL);
+		debugfs_create_file("regcache_dump", S_IRUGO, emif->debugfs_root, emif,
+				    &emif_regdump_fops);
+		debugfs_create_file("mr4", S_IRUGO, emif->debugfs_root, emif,
+				    &emif_mr4_fops);
+	}
 }
 
 static void __exit emif_debugfs_exit(struct emif_data *emif)
 {
-	debugfs_remove_recursive(emif->debugfs_root);
-	emif->debugfs_root = NULL;
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		debugfs_remove_recursive(emif->debugfs_root);
+		emif->debugfs_root = NULL;
+	}
 }
-#else
-static inline int __init_or_module emif_debugfs_init(struct emif_data *emif)
-{
-	return 0;
-}
-
-static inline void __exit emif_debugfs_exit(struct emif_data *emif)
-{
-}
-#endif
 
 /*
  * Get bus width used by EMIF. Note that this may be different from the
-- 
2.42.0


