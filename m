Return-Path: <linux-kernel+bounces-108801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18D1881031
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FF2284AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3AB3BB4B;
	Wed, 20 Mar 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ln0jnrwZ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3BF38F96
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931415; cv=none; b=rs+CO6AqWeeaMR5EvXNutwO5aMxZY0E4Do2r241TUVhVlDEL9tQHHNIVEqFX01UqyHLZDj4bqb+QOt9ahKri43xxER8iGxtfcYZVPNsyDOsUwFp8MVT/J+6hWxeevKOFTmMsa74f3bdekyBt7/PYcht1exHCrD+g3WY4KKcij0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931415; c=relaxed/simple;
	bh=QKzDcHkcQRIpFqamU9V3UGClYgEa7TjD2keY4AvFTp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NMMLzCUdOcSn2VuxdQUrD1bMQyZH5G6L8GFI1b6QlOgV6KGPM8L/KfVkUr7e85PPuGCW3ZO+gUll3/HD8yW1mWxadNn3UR6s3M3aQOvopM0OFizSqlOJY2XsRkKhzTKDTZTgf6shHiQf+nIp/o5d8U3qeLRb/pY8DtLtUs53nHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ln0jnrwZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44ad785a44so782016266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710931411; x=1711536211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9vEMO0oObvX6A3lGCcBDddPOw0Lk5Ue/zalyjwjvDs=;
        b=ln0jnrwZC6xeWVMTQG4rQ+TpdeoUzMtCl5tcQioIo5ba8xanUTd08heSvIJ3l75wME
         WJFDZjvFUPRISE/JzC9DJCS0vM6rPJbtZUwwey/H0L35hXkZYhosmlgiBdzj48jlLgW1
         YGKfdqkkLytDBVUuxieGMt3bTGBWbO/xGyPHdQZuWMpg2RAW7Lsb87I0FLAQOJ6QnSPm
         hW+KVYB3k+TWVj7HHxq5WJNiQl/UfHVCSphTmNtIfelZTBlewn87w1jAKBOs9nlJncPp
         qNfEkSC5/f31I/11hgcryTh+j3tsZyADoVnJKwqj/HZ6BV9BH3EdlAUBuVijJPfRR3Tf
         phsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710931411; x=1711536211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9vEMO0oObvX6A3lGCcBDddPOw0Lk5Ue/zalyjwjvDs=;
        b=DOnQ1oKlwkCVv+7Nuc0HGqxiIjIXxJmxP2lA/Y0BuJRBdBTAWuONpDkgsoFBHvjjAH
         b72G71qHZuBGn5DO8tny6EJddbNdnJJHY7UsnnCd3zhCBNL7CQnctXwzJRm3qPBgHpkq
         VKySZTp1NAQfIDg/0om13c9ImIKcTA59hytfJmoTNXKbF7GXb9nQydfbAfUHzv9QemdP
         bJOYMyj1KvaV/2x0Xcd2JHQ4nZp/N0FSEOF2Hse7qgPGzM3ZBrnsfheF6h9jitgP8zbo
         W3uXniwlc+knrfhjzUyto9DTiSAnEcvoSMkjHqoFvDb0DkYsj984tVADOOt48UPeTCrZ
         /iMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzfRtK72jRG8PClQ8cwQB3+3jKttZFkYg0wkObqG6FDMxVhKjf9B2r3d/wIKOwY0Xwj7NFrO7yYsBf0GU5Zq5na778J0GPZWrVCrns
X-Gm-Message-State: AOJu0YwRAz3OTnIara4P0Mx6D95mpSv7xwFYUI/NffugO6dOV54dyJ80
	3xTINjxL2lHhOOLKEMJI0/s8C6mxfxTKiCjrBSOD3jxDsJCsugu2Jnc7SBLWyy4=
X-Google-Smtp-Source: AGHT+IEGXW7GOajlc4OJ+pw4llUEbCf2kM5xIPQ7EBC2bj7pvQ2hEFUGwk1xgTBleHZc5deIrbnz9A==
X-Received: by 2002:a17:907:807:b0:a46:c09b:f1f3 with SMTP id wv7-20020a170907080700b00a46c09bf1f3mr7304405ejb.41.1710931411392;
        Wed, 20 Mar 2024 03:43:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id o20-20020a170906289400b00a45ffe583acsm7092081ejd.187.2024.03.20.03.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:43:31 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	linus.walleij@linaro.org,
	tglx@linutronix.de,
	biju.das.jz@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 2/2] pinctrl: renesas: rzg2l: Configure the interrupt type on resume
Date: Wed, 20 Mar 2024 12:42:30 +0200
Message-Id: <20240320104230.446400-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Commit dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT
source at the same time") removed the setup of TINT from
rzg2l_irqc_irq_enable(). To address the spourious interrupt issue the setup
of TINT has been moved in rzg2l_tint_set_edge() though
rzg2l_disable_tint_and_set_tint_source(). With this, the interrupts are
not properly re-configured after a suspend-to-RAM cycle. To address
this issue and avoid spurious interrupts while resumming set the
interrupt type before enabling it.

Fixes: dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 93916553bcc7..4fee3b0e6c5e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2045,7 +2045,9 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 
 	for (unsigned int i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
 		struct irq_data *data;
+		unsigned long flags;
 		unsigned int virq;
+		int ret;
 
 		if (!pctrl->hwirq[i])
 			continue;
@@ -2063,17 +2065,17 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 			continue;
 		}
 
-		if (!irqd_irq_disabled(data)) {
-			unsigned long flags;
-
-			/*
-			 * This has to be atomically executed to protect against a concurrent
-			 * interrupt.
-			 */
-			raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
+		/*
+		 * This has to be atomically executed to protect against a concurrent
+		 * interrupt.
+		 */
+		raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
+		ret = rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
+		if (ret)
+			dev_crit(pctrl->dev, "Failed to set IRQ type for virq=%u\n", virq);
+		else if (!irqd_irq_disabled(data))
 			rzg2l_gpio_irq_enable(data);
-			raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
-		}
+		raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
 	}
 }
 
-- 
2.39.2


