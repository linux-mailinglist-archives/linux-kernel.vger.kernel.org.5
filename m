Return-Path: <linux-kernel+bounces-120339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC7288D603
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124741F2833A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A725C17BB3;
	Wed, 27 Mar 2024 05:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YnnqYZ9l"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB336B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518341; cv=none; b=cjVbx/bZOmaWriEahKCCK+rRG7DZhG2QAyjcGYOW6pFG7LQa7R8X0gzD1nO145apwsZz8TAmX2SOtxyaWIYqiEzwC8bkdnN80yXaBefAzLcN5XdNHYIQohKg4DDfaEP1HiSTYQcTLTZJy2wZV2BKVw6nwmveIiA92zLIkv4Oyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518341; c=relaxed/simple;
	bh=gyzBAXo8TOJa26FGELfGqRg9U8m2VQvA8aa7sqIBDNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1Gtg03uXybcVwpJCKmpvgIoYabaF31CL1dq3PO9JnucfNasBxhR8JYA1SajhXTcwY6pQfjf5eat/v3FCMhJ2oEQwZvTKlbIWRJ5l8TimN5Q4q0+LJDcBzI9tXQno4hutJuiaXD573ri0EFLx04oLIxnuJyD7pusD5kVjpWD7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YnnqYZ9l; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a5272035d3so2338300eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711518339; x=1712123139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1O4HrXUCV4MTrLSUHq40tp2u1LonHFNpKtBMnLkU4Q=;
        b=YnnqYZ9lh7hNmsMBudDG5Ez+gKIZw4IrQYYF0YzpFQhYa5Dw1OBnXoU+4YeMDskYNR
         3NN7GpZVjf6DzmTCFoHEYnMauG6lTEvdbLIgUpFcaoIyjiL6jwcvY3lMpIw2pXfjwmxa
         2zzyK1oOgvYgRBN13Mf0M+oRknOi80zx4MpiNBoYAy0LkSGIPQ0vxEURkJkuRk77yJHj
         vKH5F/lBKO8IR7Nu0sCMyzVLtWfKvPezu6k6YnI0DlrjCGgpd+EvVBfvXkStss6b8qb+
         DkvicPkFVQxbzxtpUhe6uETeZdCA+3x34wOsBmKcObt4pABrKpAgUzDV3NaSnNKBTRYg
         SiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711518339; x=1712123139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1O4HrXUCV4MTrLSUHq40tp2u1LonHFNpKtBMnLkU4Q=;
        b=m01R06KZ6zIIuk05lVWLr88UVPIbZIVdMCFwYaoPwmu0tQqNDBBLmXHDsZg3pCo528
         zePP3i5DtGyhFUbO09ilgW5FDaoaujY3MQh2NsXkexq3QSrcPunGiiem1JPlXjvWm5BZ
         SFdh1hNxhHBkNysTW3DPH9Xc1ez3U8Laqvc/WuCsDSHiFjoDOwbA49/jorvj+CxzG7oi
         J99qVxRq+YH2oMDMhUIADcn9XVG+0g33doqT/VbbiAtxISSfztRu0PEO056awRXxRj3U
         zMZKYp716ODNFDlBunXsntQ85UitN2zi/f1blkl1HcPq7i6kQvoSe17K+7CCGbjGcfLj
         cB/g==
X-Forwarded-Encrypted: i=1; AJvYcCUhCaja5fldA2Wrz9d0yclGgoXpA3sMtkXq+pqyOcFsc/u371Tv6F3W7gIfghGO+tf6HujSErNSeQf7qm4fiOWcDcJpb9ZHHIbrFDH+
X-Gm-Message-State: AOJu0YzkXK0nVSEsV3yUKFcYLQFV1EglX4pvyY7pgCsuXhQrKo2I5r+B
	4E5/3Wful8xTb7cLAYVeL5+rs+8aHJRQZzDCC1plXLz+34rkdXq3DEnZKKg39d55ONiFp6utptl
	W
X-Google-Smtp-Source: AGHT+IH6LKE2qtw8a/Zvce9y/zXj8SNbfYrNTQipSKpUP4GisfAUe9jdUYEsOKlSbpnzK8+jvoSQ1g==
X-Received: by 2002:a05:6358:2d8d:b0:17f:8831:2b7c with SMTP id m13-20020a0563582d8d00b0017f88312b7cmr3720954rwn.25.1711518339245;
        Tue, 26 Mar 2024 22:45:39 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id v62-20020a632f41000000b005cf450e91d2sm7405772pgv.52.2024.03.26.22.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 22:45:38 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Conor Dooley <conor@kernel.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] cache: sifive_ccache: Partially convert to a platform driver
Date: Tue, 26 Mar 2024 22:45:24 -0700
Message-ID: <20240327054537.424980-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a
platform driver") broke ccache initialization because the PLIC IRQ
domain is no longer available during an arch_initcall:

  [    0.087229] irq: no irq domain found for interrupt-controller@c000000 !
  [    0.087255] CCACHE: Could not request IRQ 0

Fix this by moving the IRQ handling code to a platform driver.

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/cache/sifive_ccache.c | 72 ++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/cache/sifive_ccache.c b/drivers/cache/sifive_ccache.c
index 89ed6cd6b059..e9cc8b4786fb 100644
--- a/drivers/cache/sifive_ccache.c
+++ b/drivers/cache/sifive_ccache.c
@@ -15,6 +15,8 @@
 #include <linux/of_address.h>
 #include <linux/device.h>
 #include <linux/bitfield.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <asm/cacheflush.h>
 #include <asm/cacheinfo.h>
 #include <asm/dma-noncoherent.h>
@@ -247,13 +249,49 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	return IRQ_HANDLED;
 }
 
+static int sifive_ccache_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	unsigned long quirks;
+	int intr_num, rc;
+
+	quirks = (unsigned long)device_get_match_data(dev);
+
+	intr_num = platform_irq_count(pdev);
+	if (!intr_num)
+		return dev_err_probe(dev, -ENODEV, "No interrupts property\n");
+
+	for (int i = 0; i < intr_num; i++) {
+		if (i == DATA_UNCORR && (quirks & QUIRK_BROKEN_DATA_UNCORR))
+			continue;
+
+		g_irq[i] = platform_get_irq(pdev, i);
+		if (g_irq[i] < 0)
+			return g_irq[i];
+
+		rc = devm_request_irq(dev, g_irq[i], ccache_int_handler, 0, "ccache_ecc", NULL);
+		if (rc)
+			return dev_err_probe(dev, rc, "Could not request IRQ %d\n", g_irq[i]);
+	}
+
+	return 0;
+}
+
+static struct platform_driver sifive_ccache_driver = {
+	.probe	= sifive_ccache_probe,
+	.driver	= {
+		.name		= "sifive_ccache",
+		.of_match_table	= sifive_ccache_ids,
+	},
+};
+
 static int __init sifive_ccache_init(void)
 {
 	struct device_node *np;
 	struct resource res;
-	int i, rc, intr_num;
 	const struct of_device_id *match;
 	unsigned long quirks;
+	int rc;
 
 	np = of_find_matching_node_and_match(NULL, sifive_ccache_ids, &match);
 	if (!np)
@@ -277,28 +315,6 @@ static int __init sifive_ccache_init(void)
 		goto err_unmap;
 	}
 
-	intr_num = of_property_count_u32_elems(np, "interrupts");
-	if (!intr_num) {
-		pr_err("No interrupts property\n");
-		rc = -ENODEV;
-		goto err_unmap;
-	}
-
-	for (i = 0; i < intr_num; i++) {
-		g_irq[i] = irq_of_parse_and_map(np, i);
-
-		if (i == DATA_UNCORR && (quirks & QUIRK_BROKEN_DATA_UNCORR))
-			continue;
-
-		rc = request_irq(g_irq[i], ccache_int_handler, 0, "ccache_ecc",
-				 NULL);
-		if (rc) {
-			pr_err("Could not request IRQ %d\n", g_irq[i]);
-			goto err_free_irq;
-		}
-	}
-	of_node_put(np);
-
 #ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
 	if (quirks & QUIRK_NONSTANDARD_CACHE_OPS) {
 		riscv_cbom_block_size = SIFIVE_CCACHE_LINE_SIZE;
@@ -315,11 +331,15 @@ static int __init sifive_ccache_init(void)
 #ifdef CONFIG_DEBUG_FS
 	setup_sifive_debug();
 #endif
+
+	rc = platform_driver_register(&sifive_ccache_driver);
+	if (rc)
+		goto err_unmap;
+
+	of_node_put(np);
+
 	return 0;
 
-err_free_irq:
-	while (--i >= 0)
-		free_irq(g_irq[i], NULL);
 err_unmap:
 	iounmap(ccache_base);
 err_node_put:
-- 
2.43.1


