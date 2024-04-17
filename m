Return-Path: <linux-kernel+bounces-148326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA358A80FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00989281E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102EF13C802;
	Wed, 17 Apr 2024 10:31:09 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E14F13C3C4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349868; cv=none; b=pOnYgYudrgbQpzJ6L5cmZvSSi5XuDlcL/SXkgNM6sk2cUR4kxmeF88IUcqxhMIH6EUZcUjhsBqModRfxjhst4ApUqog19PMEsHoFVC040nMF54w8JRNbHcyFHg0xDFWlrrqBzQAxMTZOAoR0jCdot63u/dtyiXqLAVEsJAIUQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349868; c=relaxed/simple;
	bh=VYGYacanQjsqexakylgPmDCVpmOxfFn9P+P9QCnq0fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YuRE0Um00rm7viRR1OCbvqGOD7K96+H2mkbeWtpkUf2LhBaYnZ6DiWOP9yemQ/CTt151kJ5lHBQgGLQYU4hSnEGZ/upW2S5DoSJO3ZZT+XwRZ/4VWEX1y0ytrwCacYO3Q9QjASkIBFqqUByC6q0aiHFsN/CxSKtuGxUmXdFPG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by xavier.telenet-ops.be with bizsmtp
	id CAX42C0010SSLxL01AX4DW; Wed, 17 Apr 2024 12:31:04 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rx2Yd-009LEI-Tx;
	Wed, 17 Apr 2024 12:31:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rx2Xe-00FLS0-CU;
	Wed, 17 Apr 2024 12:29:26 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] pmdomain: renesas: rcar-sysc: Absorb rcar_sysc_ch into rcar_sysc_pd
Date: Wed, 17 Apr 2024 12:29:22 +0200
Message-Id: <672805a8c52ce63200e342212bbe6f84a445397b.1713348705.git.geert+renesas@glider.be>
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

Until commit 7e8a50df26f4e700 ("soc: renesas: rcar-sysc: Drop legacy
handling") in v4.19, the rcar_sysc_ch structure was part of the API for
legacy board code not yet using DT.  Since then, there is no longer a
reason to keep it as a separate structure.

Moreover, a future quirk handling will need access to the rcar_sysc_pd
structure's flags member in rcar_sysc_pwr_on_off().  Hence absorb the
rcar_sysc_ch structure into the rcar_sysc_pd structure, and pass around
the latter instead of the former.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/rcar-sysc.c | 54 +++++++++++++---------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index 35d9aa0dfab867fc..a60ce08e7d3b09cb 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -56,17 +56,20 @@
 
 #define RCAR_PD_ALWAYS_ON	32	/* Always-on power area */
 
-struct rcar_sysc_ch {
+struct rcar_sysc_pd {
+	struct generic_pm_domain genpd;
 	u16 chan_offs;
 	u8 chan_bit;
 	u8 isr_bit;
+	unsigned int flags;
+	char name[];
 };
 
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 static u32 rcar_sysc_extmask_offs, rcar_sysc_extmask_val;
 
-static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch, bool on)
+static int rcar_sysc_pwr_on_off(const struct rcar_sysc_pd *pd, bool on)
 {
 	unsigned int sr_bit, reg_offs;
 	u32 val;
@@ -88,16 +91,15 @@ static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch, bool on)
 		return -EAGAIN;
 
 	/* Submit power shutoff or power resume request */
-	iowrite32(BIT(sysc_ch->chan_bit),
-		  rcar_sysc_base + sysc_ch->chan_offs + reg_offs);
+	iowrite32(BIT(pd->chan_bit), rcar_sysc_base + pd->chan_offs + reg_offs);
 
 	return 0;
 }
 
-static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
+static int rcar_sysc_power(const struct rcar_sysc_pd *pd, bool on)
 {
-	unsigned int isr_mask = BIT(sysc_ch->isr_bit);
-	unsigned int chan_mask = BIT(sysc_ch->chan_bit);
+	unsigned int isr_mask = BIT(pd->isr_bit);
+	unsigned int chan_mask = BIT(pd->chan_bit);
 	unsigned int status, k;
 	unsigned long flags;
 	int ret;
@@ -125,12 +127,11 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 
 	/* Submit power shutoff or resume request until it was accepted */
 	for (k = 0; k < PWRER_RETRIES; k++) {
-		ret = rcar_sysc_pwr_on_off(sysc_ch, on);
+		ret = rcar_sysc_pwr_on_off(pd, on);
 		if (ret)
 			goto out;
 
-		status = ioread32(rcar_sysc_base +
-				  sysc_ch->chan_offs + PWRER_OFFS);
+		status = ioread32(rcar_sysc_base + pd->chan_offs + PWRER_OFFS);
 		if (!(status & chan_mask))
 			break;
 
@@ -158,28 +159,21 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 	spin_unlock_irqrestore(&rcar_sysc_lock, flags);
 
 	pr_debug("sysc power %s domain %d: %08x -> %d\n", on ? "on" : "off",
-		 sysc_ch->isr_bit, ioread32(rcar_sysc_base + SYSCISR), ret);
+		 pd->isr_bit, ioread32(rcar_sysc_base + SYSCISR), ret);
 	return ret;
 }
 
-static bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
+static bool rcar_sysc_power_is_off(const struct rcar_sysc_pd *pd)
 {
 	unsigned int st;
 
-	st = ioread32(rcar_sysc_base + sysc_ch->chan_offs + PWRSR_OFFS);
-	if (st & BIT(sysc_ch->chan_bit))
+	st = ioread32(rcar_sysc_base + pd->chan_offs + PWRSR_OFFS);
+	if (st & BIT(pd->chan_bit))
 		return true;
 
 	return false;
 }
 
-struct rcar_sysc_pd {
-	struct generic_pm_domain genpd;
-	struct rcar_sysc_ch ch;
-	unsigned int flags;
-	char name[];
-};
-
 static inline struct rcar_sysc_pd *to_rcar_pd(struct generic_pm_domain *d)
 {
 	return container_of(d, struct rcar_sysc_pd, genpd);
@@ -190,7 +184,7 @@ static int rcar_sysc_pd_power_off(struct generic_pm_domain *genpd)
 	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
 
 	pr_debug("%s: %s\n", __func__, genpd->name);
-	return rcar_sysc_power(&pd->ch, false);
+	return rcar_sysc_power(pd, false);
 }
 
 static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
@@ -198,7 +192,7 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
 	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
 
 	pr_debug("%s: %s\n", __func__, genpd->name);
-	return rcar_sysc_power(&pd->ch, true);
+	return rcar_sysc_power(pd, true);
 }
 
 static bool has_cpg_mstp;
@@ -252,12 +246,12 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 		goto finalize;
 	}
 
-	if (!rcar_sysc_power_is_off(&pd->ch)) {
+	if (!rcar_sysc_power_is_off(pd)) {
 		pr_debug("%s: %s is already powered\n", __func__, genpd->name);
 		goto finalize;
 	}
 
-	rcar_sysc_power(&pd->ch, true);
+	rcar_sysc_power(pd, true);
 
 finalize:
 	error = pm_genpd_init(genpd, &simple_qos_governor, false);
@@ -412,9 +406,9 @@ static int __init rcar_sysc_pd_init(void)
 
 		memcpy(pd->name, area->name, n);
 		pd->genpd.name = pd->name;
-		pd->ch.chan_offs = area->chan_offs;
-		pd->ch.chan_bit = area->chan_bit;
-		pd->ch.isr_bit = area->isr_bit;
+		pd->chan_offs = area->chan_offs;
+		pd->chan_bit = area->chan_bit;
+		pd->isr_bit = area->isr_bit;
 		pd->flags = area->flags;
 
 		error = rcar_sysc_pd_setup(pd);
@@ -473,10 +467,10 @@ static int rcar_sysc_power_cpu(unsigned int idx, bool on)
 			continue;
 
 		pd = to_rcar_pd(genpd);
-		if (!(pd->flags & PD_CPU) || pd->ch.chan_bit != idx)
+		if (!(pd->flags & PD_CPU) || pd->chan_bit != idx)
 			continue;
 
-		return rcar_sysc_power(&pd->ch, on);
+		return rcar_sysc_power(pd, on);
 	}
 
 	return -ENOENT;
-- 
2.34.1


