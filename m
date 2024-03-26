Return-Path: <linux-kernel+bounces-120052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A063F88D0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177B21F27284
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABBE13F45F;
	Tue, 26 Mar 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAu4Ayjy"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68413DDAA;
	Tue, 26 Mar 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492213; cv=none; b=Zkv8oqm3kA/DMJhma3LuJzLZPQCTaet08y4enWQG97cWSbu5DJmQo8mUe/s4N0r3Yl7zDFkvu5klNPWrvDdfzIU38uXSAffEqVhB1KpY4OIHdhyoMe6x//vasd6mTmWGEdVTyPkVgJnUgo5n22ZIFxLxfxRm4KMNedvRYxWk9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492213; c=relaxed/simple;
	bh=fJZONua1k722F9DXtUVDTt7l/NoLflwhpFArfpFPmMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mVL9eOTjooXYnu1dACkQ18NgDiALFSxEAvCW8dmP+xn1aTxBjMO53QDK4JEHF/Wl4HbRuc6ruS/f8xV6HmMp4uJGW323XDWHNBP0FaU/WDWDh1ChZ8VN6IO/uZmwlQm6GHxj+Ne2i7/Jl/k0soswBrE6DoHXWnX0HA88lspkgYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAu4Ayjy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ed4d8e9edso4466493f8f.2;
        Tue, 26 Mar 2024 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492210; x=1712097010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa48IttRtjWW//hX/ph7skdP07JnPzQIrLm9sytmiaY=;
        b=VAu4AyjyvdhyGcQIfxQRawVrY6KxWKD9HpKI5S/0/XuNLK+xnAdMV+GZw33SLBiRWw
         NGGPigMbP1IhPaYhytdzD5AhsHhGPMO3ao0cAuQO4zua+mFo3XgxSPqVGqI4Y/wVmQNS
         7l31c2NHpaKLR8km1r+MnNLqVaRwFV+dW0RcGauoY1dFyo2YNQi1T2uDeTMShV3sK7KM
         m1hLnApMKCCRzteaJtcF/M7frwSF2rvV6vXya6t8vQ+eOe/SdrV/cT1QSwSMSLNW7ZwT
         jOfO/7HdaISpeE4rmWtfbAjYEJtuTgLSQBadK/pETJtNvLVeh+xnfQ+CwRfxQ5L+2tpw
         hKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492210; x=1712097010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa48IttRtjWW//hX/ph7skdP07JnPzQIrLm9sytmiaY=;
        b=bJGoFp4DffcFqQucoU+G+t/dgPEYl51lRhgBm7tqrRQ3J1mAgZFzxch3Mul8S/8Aa7
         mJsBUhnz5HflsjJS/HO+UxjEtsGoYii+RnVOp7XXez/Eqf7fXQvuD12Y9Xo0TC/RtjIu
         uSeFykBHKZzBXI1wzG9eLJWxGy6wUWCha+EOs9A9p0PS6qrHQsBdLLxCyWYEF86jyOLU
         Gh4aVDrjtrWqaQVjdce3LSHwEOla807FfMgc0zQKEOsgWpO3zVHdZ8QqrE9BzUZxm9Gg
         RD4BOzgzP4SzupkK82N6u5KCaK4GRFKrYeI3muVSBnfAkpiI/+60GpZekxb9yTxHftDH
         qn4w==
X-Forwarded-Encrypted: i=1; AJvYcCV52Y16zkUxvvR4kFZGJoAniNW7BQfBeaeob5f2IAdS87AxSUdetVCAzmSgVJrbSCBJZr0f2Tx/11I5NuRFd5JTbWAk02TcDIlQp9C3OP6iiQ2p+3ansNvrLZYEi9GzPkDoOBqPOPV40zvDDXO5pD4C/iZAmrT+QsxzDb9peezI3yj1Ew8=
X-Gm-Message-State: AOJu0YyGb4ataGUtivsbCGNDzapcoRrPb+225EuB1RR+SxYUIlHmVLP3
	Kof72MtEPLaaOb10U6C1eCbgUkUjrnq/o8up0gru+laOFnmCmwWu
X-Google-Smtp-Source: AGHT+IHNJXnk4Rb+kaIaJJ+gRnAXbAhv2vuLHJntLquc7vC7kHATLeErtiNu0Kn1h5Z4T7ckZVFdGQ==
X-Received: by 2002:adf:f412:0:b0:33d:64c7:5619 with SMTP id g18-20020adff412000000b0033d64c75619mr2673028wro.70.1711492209711;
        Tue, 26 Mar 2024 15:30:09 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:30:09 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 09/13] pinctrl: renesas: pinctrl-rzg2l: Add function pointer for writing to PMC register
Date: Tue, 26 Mar 2024 22:28:40 +0000
Message-Id: <20240326222844.1422948-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This patch introduces a function pointer, pmc_writeb(), in the
struct rzg2l_pinctrl_data to facilitate writing to the PMC register. On
the RZ/V2H(P) SoC, unlocking the PWPR.REGWE_A bit before writing to PMC
registers is required, whereas this is not the case for the existing
RZ/G2L family. This addition enables the reuse of existing code for
RZ/V2H(P). Additionally, this patch populates this function pointer with
appropriate data for existing SoCs.

Note that this functionality is only handled in rzg2l_gpio_request(), as
PMC unlock/lock during PFC setup will be taken care of in the
set_pfc_mode/pm_set_pfc callbacks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 4cdebdbd8a04..3de97d5e198a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -260,6 +260,7 @@ struct rzg2l_pinctrl_data {
 	unsigned int n_variable_pin_cfg;
 	void (*set_pfc_mode)(struct rzg2l_pinctrl *pctrl, u8 pin, u8 off, u8 func);
 	void (*pm_set_pfc)(struct rzg2l_pinctrl *pctrl);
+	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr);
 };
 
 /**
@@ -463,6 +464,11 @@ static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg[] = {
 };
 #endif
 
+static void rzg2l_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr)
+{
+	writeb(val, addr);
+}
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -1413,7 +1419,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	/* Select GPIO mode in PMC Register */
 	reg8 = readb(pctrl->base + PMC(off));
 	reg8 &= ~BIT(bit);
-	writeb(reg8, pctrl->base + PMC(off));
+	pctrl->data->pmc_writeb(pctrl, reg8, pctrl->base + PMC(off));
 
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
@@ -2678,6 +2684,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 #endif
 	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
 	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
+	.pmc_writeb = &rzg2l_pmc_writeb,
 };
 
 static struct rzg2l_pinctrl_data r9a07g044_data = {
@@ -2691,6 +2698,7 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.hwcfg = &rzg2l_hwcfg,
 	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
 	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
+	.pmc_writeb = &rzg2l_pmc_writeb,
 };
 
 static struct rzg2l_pinctrl_data r9a08g045_data = {
@@ -2703,6 +2711,7 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.hwcfg = &rzg3s_hwcfg,
 	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
 	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
+	.pmc_writeb = &rzg2l_pmc_writeb,
 };
 
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
-- 
2.34.1


