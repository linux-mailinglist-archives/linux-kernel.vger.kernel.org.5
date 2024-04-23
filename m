Return-Path: <linux-kernel+bounces-155713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B290E8AF609
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B8D285957
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EACE142902;
	Tue, 23 Apr 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkB2Yai4"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1213E3EF;
	Tue, 23 Apr 2024 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895165; cv=none; b=Pqhb39qyzAfrvsRxcqkSu3LujHFfUEbinLgWEv0/wZ4wl5cJBX4wudwKgeBpGGbxPh+x0f0WHDumngFiovjDG+Bmc5HZ0Hzqg/CnKB3iJY/9u5KzA4CtbHJFRB5fQmFWLNKmQHqSY7C7w7mJrj7IJvmLbVJh7+sfmSE+S6jbsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895165; c=relaxed/simple;
	bh=gdVRy4l+0rPCzzeaDtUAxHoTiZ9wS43BkviQ1INDWkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDjKGDQE2ortOshGWvjh1G9+KNY8ganvigMWFP+YjOK3bEi2sHKGW4o2bGNzMeRUz52HTZ7vz0+RkCrgI4oYhQ25O+ljuVliasMDZsqOiT5hTkOV/UIr1sqR8WFESLdhRYyO4oMdZko3nKn8sjWSdfuA/nynsBza3nafWWHLmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkB2Yai4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a77836f16so18041075e9.3;
        Tue, 23 Apr 2024 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895162; x=1714499962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEG9OgVQaChXDQKIKqAoHsUK5uRo77wy78qh/m7RZcI=;
        b=FkB2Yai43whREWJOWVv6N7vpr92YUx91xiS5QmR/dn8lZ/Dx6451xfrxzWIYvtU82V
         mpZRBUgpI0d9EIjgZ20T61+/W6o9wfPpaq5sgqIkn1B5gzX1uHcK5e747zmOo41q+4BW
         fZSChzANEl2ZMsYxIRx9pOilT7wuut911Uz0YYhy8tSqh79E4buoNFnzH00qY5orlduY
         7izpZdDmZcCQnDg1ntEau1eM7fpoJTFe1N0Hmp3sTU6AQzmYh8UHTCSFg5431Bgvy+lh
         mgsQogbUS7jFhjaY88LG4N0cHoQqotlljdLN8FNSdWzvxnON5WFnh/zNsEH0sG4pXcWo
         lSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895162; x=1714499962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEG9OgVQaChXDQKIKqAoHsUK5uRo77wy78qh/m7RZcI=;
        b=aNZRT8FFUxv4LXEL7L9mJ1N1C29JuQVvrEQYxLkXuXZh6pzdjeL7ToNeZOGt2iVHJA
         v9HoLhH866Duz7b+2DRtenCdY3q/SSyM9/YSffBf3s6BJMN9kE7JlIOCxelgkt2/Tuuc
         OfUIShGPC2nrzW2BiCeU5dFCYIUSRUgCeZDEF1LjAL7CDfBqpye9HR7U7Vj2cepLoLtn
         nmC7dRCl4DgdTaKBDXXTRVsnwvdMfWbwDvc1qAPZkDATKdI/HRogHq/SUqmwKfG6Jna0
         uv2R7z9hPO5zcQaAy0IP0WAW+Mde4N5waM/4BJ/xy/g4oKQEkMubJnouIJXDQT0LUeae
         DnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvkeRIEdfmIqXGgbU+pIroGCew7+nLwziHma0pRhGpDQL27GhGFPnLofS9fiH9hAphhG1LOYmP4/yzQCV2vY8+H/7M2DEtROgKf9d0M+K8jBfvJD17eY03fB4Raw30vYy5f9TVNkAAiYG0bzQgTfe3aVHXo7Ng+ooVx32df7TyKwozoYLWnzujKxz3
X-Gm-Message-State: AOJu0YxqV9eXnjJfo2b7GI+ntZkUkYW5kb8rdr+FDdpdb97wkluce3fJ
	jKyZYugtsA88VT3haui77uBBhKVVgtMo0k18djtAit9vLq0awbHh
X-Google-Smtp-Source: AGHT+IHWr2BeP4XN9iE6LQhCrMLzqJBljW2jJRq6LLReqsyv2Rh9c0wyoN6zxyG/fvvQyFzu1oEn5g==
X-Received: by 2002:a05:600c:1d93:b0:41a:bfc4:e9a9 with SMTP id p19-20020a05600c1d9300b0041abfc4e9a9mr32748wms.4.1713895162205;
        Tue, 23 Apr 2024 10:59:22 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:21 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 06/13] pinctrl: renesas: pinctrl-rzg2l: Add function pointers for locking/unlocking the PFC register
Date: Tue, 23 Apr 2024 18:58:53 +0100
Message-Id: <20240423175900.702640-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On the RZ/G2L SoC, the PFCWE bit controls writing to PFC registers.
However, on the RZ/V2H(P) SoC, the PFCWE (REGWE_A on RZ/V2H) bit controls
writing to both PFC and PMC registers. Additionally, BIT(7) B0WI is
undocumented for the PWPR register on RZ/V2H(P) SoC. To accommodate these
differences across SoC variants, introduce the set_pfc_mode() and
pm_set_pfc() function pointers.

Note, in rzg2l_pinctrl_set_pfc_mode() the pwpr_pfc_unlock() call is now
called before PMC read/write and pwpr_pfc_lock() call is now called after
PMC read/write this is to keep changes minimal for RZ/V2H(P).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- Introduced function pointer for (un)lock
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 51 ++++++++++++++++---------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index bec4685b4681..0840fda7ca69 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -246,6 +246,8 @@ struct rzg2l_variable_pin_cfg {
 	u64 pin:3;
 };
 
+struct rzg2l_pinctrl;
+
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u64 *port_pin_configs;
@@ -256,6 +258,8 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_hwcfg *hwcfg;
 	const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
+	void (*pwpr_pfc_unlock)(struct rzg2l_pinctrl *pctrl);
+	void (*pwpr_pfc_lock)(struct rzg2l_pinctrl *pctrl);
 };
 
 /**
@@ -462,7 +466,6 @@ static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg[] = {
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
-	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
 	unsigned long flags;
 	u32 reg;
 
@@ -473,27 +476,23 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	reg &= ~(PM_MASK << (pin * 2));
 	writew(reg, pctrl->base + PM(off));
 
+	pctrl->data->pwpr_pfc_unlock(pctrl);
+
 	/* Temporarily switch to GPIO mode with PMC register */
 	reg = readb(pctrl->base + PMC(off));
 	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
 
-	/* Set the PWPR register to allow PFC register to write */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
-	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=0, PFCWE=1 */
-
 	/* Select Pin function mode with PFC register */
 	reg = readl(pctrl->base + PFC(off));
 	reg &= ~(PFC_MASK << (pin * 4));
 	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
 
-	/* Set the PWPR register to be write-protected */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
-	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=1, PFCWE=0 */
-
 	/* Switch to Peripheral pin function with PMC register */
 	reg = readb(pctrl->base + PMC(off));
 	writeb(reg | BIT(pin), pctrl->base + PMC(off));
 
+	pctrl->data->pwpr_pfc_lock(pctrl);
+
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 };
 
@@ -2519,12 +2518,8 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
 {
 	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
-	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
-	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 
-	/* Set the PWPR register to allow PFC register to write. */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
-	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=0, PFCWE=1 */
+	pctrl->data->pwpr_pfc_unlock(pctrl);
 
 	/* Restore port registers. */
 	for (u32 port = 0; port < nports; port++) {
@@ -2567,9 +2562,7 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
 		}
 	}
 
-	/* Set the PWPR register to be write-protected. */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
-	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=1, PFCWE=0 */
+	pctrl->data->pwpr_pfc_lock(pctrl);
 }
 
 static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
@@ -2631,6 +2624,24 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static void rzg2l_pwpr_pfc_unlock(struct rzg2l_pinctrl *pctrl)
+{
+	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
+
+	/* Set the PWPR register to allow PFC register to write */
+	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
+	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=0, PFCWE=1 */
+}
+
+static void rzg2l_pwpr_pfc_lock(struct rzg2l_pinctrl *pctrl)
+{
+	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
+
+	/* Set the PWPR register to be write-protected */
+	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
+	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=1, PFCWE=0 */
+}
+
 static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 	.regs = {
 		.pwpr = 0x3014,
@@ -2688,6 +2699,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.variable_pin_cfg = r9a07g043f_variable_pin_cfg,
 	.n_variable_pin_cfg = ARRAY_SIZE(r9a07g043f_variable_pin_cfg),
 #endif
+	.pwpr_pfc_unlock = &rzg2l_pwpr_pfc_unlock,
+	.pwpr_pfc_lock = &rzg2l_pwpr_pfc_lock,
 };
 
 static struct rzg2l_pinctrl_data r9a07g044_data = {
@@ -2699,6 +2712,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
 		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
 	.hwcfg = &rzg2l_hwcfg,
+	.pwpr_pfc_unlock = &rzg2l_pwpr_pfc_unlock,
+	.pwpr_pfc_lock = &rzg2l_pwpr_pfc_lock,
 };
 
 static struct rzg2l_pinctrl_data r9a08g045_data = {
@@ -2709,6 +2724,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.n_port_pins = ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg3s_dedicated_pins),
 	.hwcfg = &rzg3s_hwcfg,
+	.pwpr_pfc_unlock = &rzg2l_pwpr_pfc_unlock,
+	.pwpr_pfc_lock = &rzg2l_pwpr_pfc_lock,
 };
 
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
-- 
2.34.1


