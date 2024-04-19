Return-Path: <linux-kernel+bounces-151048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045D58AA857
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDBF281C16
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF16D268;
	Fri, 19 Apr 2024 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gPhxO6vM"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE6BE49
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713507581; cv=none; b=uoVDWGq5sv+1UMfjiOvNGUlGalaaSBsMP4X2HRmRANN1fHBNh4Q+hxC+P163xI9FK9aRLD4zUKMK6vbLWfBRml7XBai8e9YAy99IqGC0z6FI1uMFORQ8KzznF1bVlq0CAuwwntKDQ0gkCFy6mSeRMJBj4leCXI2RDsrbHjeysmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713507581; c=relaxed/simple;
	bh=vaoFx8rbE+/vHCI1FihLLacdyluledX4OyjZ/J1iRfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FES+lVRUttum7gKB5Jqsy4WFdC0tGiZJ5OjFl7T3pfujpBB074rbay+VL8IlD+4lY2yM7Zm0kW8K+jJjwVXhtCXfDxHpEZ65/wANKPf1t2KjDM6IidQGRkQFlsiwccmkhdaPzXpoH6QTLFPvl3At93V7YUy7WbcWwrXtmUIdSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gPhxO6vM; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so2396338a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713507577; x=1714112377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zChC2XDsDI5Ah8bNA8dPVgVBQVKq5xeUehrSiQnngTk=;
        b=gPhxO6vML+PlpwaekkP8sfyvKtjzWjLOgy7s6jkYv3Gt9NBafMyQnm7JKLomxUMfAc
         X1UvwosUSMZgsoVnFLTbyNhg/M1SZkI/NmdfPpepo+2Ep9Z9IGSMEnujiI2t7HF03k9u
         Q6oWYCmbHsuCse1tV0CnSinKYKVz6f0qiT46YcVd066j9bFv6qZpegsXVjI+UbAH1EVl
         qdxmMudIrHEJcXwlDcCAHTmMNy3glEhd5CfXOPiY/7de9c/M9ahFQJtc1XJBOsCgB653
         Oa8DsdBBDdeIBxSVQCN+m3X5gW7n7FZlHdyzXAuA3PmDPxYiPCWz86yuuMi4NHv6/wqA
         kO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713507577; x=1714112377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zChC2XDsDI5Ah8bNA8dPVgVBQVKq5xeUehrSiQnngTk=;
        b=LCl4nf/HiwV9D688JOViaXHNOhLmlDocczFa6LoDbyY3nn9k5gF9XHuuge597ieew3
         6ltjA3ciVYwW4ki9XUwfqRBNCDXYGaMy5+eWiGXXAkDqtXFhtrA8DuRIuCIAOS/S50zR
         7RNkjCZKSqVHN32pXuXUvTJb7oCLp77e+AanQwQqrXKEsN3P5CLX0ay/jkEHdLA2ppt/
         bJklgOtzh37yKgqSr6txlZ+juEVVmxvTEYXMTOrrqN3X2lvtGoi4qQ/NNmvz7DQiuRIO
         sl7x2hzp2mFr1Jx3i5Lmy/byABQ/yEKlw6gfz0qZtZV1CiU+9Jg1cKfIepTuxnUBjCE0
         eR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXptkVOx42sxZV/DkInw7lJTBZWPEeO8G0Ix2sIcKlTo1b7FUdRYytLGTCW48Ny/kpqC/MbvG8B2yX2dGWXaoJPIaQDFXLqHRGmKKfM
X-Gm-Message-State: AOJu0Yzqen0w3/c8cS/eV4p49khItmeM5mKNb23HIZnxfzkBKt/xu5Hc
	Y2oTFfBwNxP/ygTCBZSU1ktpx1ZB+T49BxYTW1cjWV3sNAiItCklxbhJ6j1v6RM=
X-Google-Smtp-Source: AGHT+IHyl278IrvxXKkNFcB/lbp76vS0EdeltovBWNosOdxm88e/bktWgiecN97W3uyDlaj9aKKxiA==
X-Received: by 2002:a50:8e0e:0:b0:56d:f78f:8747 with SMTP id 14-20020a508e0e000000b0056df78f8747mr966336edw.16.1713507577563;
        Thu, 18 Apr 2024 23:19:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id k4-20020a50cb84000000b005705bb48307sm1721233edi.42.2024.04.18.23.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:19:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	tglx@linutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3] pinctrl: renesas: rzg2l: Configure the interrupt type on resume
Date: Fri, 19 Apr 2024 09:19:24 +0300
Message-Id: <20240419061924.3363667-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
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

Changes in v3:
- moved dev_crit() out of critical section

Changes in v2:
- none; this patch was part of series at [1] and added in v2 of that
  series

[1] https://lore.kernel.org/all/20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 93916553bcc7..20425afc6b33 100644
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
@@ -2063,17 +2065,18 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
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
+		if (!ret && !irqd_irq_disabled(data))
 			rzg2l_gpio_irq_enable(data);
-			raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
-		}
+		raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
+
+		if (ret)
+			dev_crit(pctrl->dev, "Failed to set IRQ type for virq=%u\n", virq);
 	}
 }
 
-- 
2.39.2


