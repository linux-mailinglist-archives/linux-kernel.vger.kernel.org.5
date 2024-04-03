Return-Path: <linux-kernel+bounces-129288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778B0896842
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8361F20C34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2D813CAA1;
	Wed,  3 Apr 2024 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtN/IBEm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39B126F37;
	Wed,  3 Apr 2024 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131755; cv=none; b=TRkwSB3bdhaBgrN6tHfZIS3OElV9f+vqBUTJcRfqdlQVnwiEJgpwqt0M/Zc6d06JTDqiHPoXK+9ugLlKlLBet+Nn2iZOEFZlqQHxJePkKaovXZYOmwHVDLDGeR863fZ3n2frj0E82dfWIB8AHu1xihmPXwqjQCCbZ+AduCLb00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131755; c=relaxed/simple;
	bh=1sDt+GFLOqYMSNPiXKXTrVCa07EMAL7XEpWDHoi1E8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzxZ2rosO4i1QAkKN2PRb+04PXmzOSf1e5iDcl8nIKtH8B8580UqNkwV/jE346wfEgDKS7b0+r0gGz5Cs5jSQiq29KOcElGr5jRmzPFA4iCnBwhB1cFU5DSeZM4f57dDsaaMPH9v+fwDMgsZbKF4diJO/paPzmKug/KX0TGY1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtN/IBEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E18C433F1;
	Wed,  3 Apr 2024 08:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131755;
	bh=1sDt+GFLOqYMSNPiXKXTrVCa07EMAL7XEpWDHoi1E8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtN/IBEmKR0kEELjtE64b9uYo33VFmQOEro53HsVUA5Tyk7u0mWyol3wogPq9Fmcv
	 DxV3tU7nrmvfPvlj1OMmFtaCqVnVCouebduRKnGB+rXPui7AqMcmxAlWWfkTFJfirI
	 auVbOPJriA8k8ROu4MVheOykXM0g4lnjLBQST2LgW9QYYV3A5c3x/Gz8mdkpeYt+n8
	 RGiU0WI+IX7osDfLOUYBnXgzMbyWd3pNOdwlKEOTYA+bXo/jriPzeSppwnYI7iKQJ6
	 NYh2trfpcwzr7tZKY2pwMaSjYYwagNaYOMKWGyjoTSqAWdF/OV7Re79mSjPGWXGe99
	 1qB6PyGHlcjMw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Tero Kristo <kristo@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-omap@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 11/34] clk: ti: dpll: fix incorrect #ifdef checks
Date: Wed,  3 Apr 2024 10:06:29 +0200
Message-Id: <20240403080702.3509288-12-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows warnings about unused const variables like this one:

drivers/clk/ti/dpll.c:99:29: error: unused variable 'omap3_dpll_core_ck_ops' [-Werror,-Wunused-const-variable]
static const struct clk_ops omap3_dpll_core_ck_ops = {};

The problem is that the #ifdef checks for some of the structures in this
file have gone out of sync with the code referencing them. Update these
to match the current usage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/ti/dpll.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 403ec81f561b..3386bd1903df 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -34,8 +34,6 @@ static const struct clk_ops dpll_m4xen_ck_ops = {
 	.save_context	= &omap3_core_dpll_save_context,
 	.restore_context = &omap3_core_dpll_restore_context,
 };
-#else
-static const struct clk_ops dpll_m4xen_ck_ops = {};
 #endif
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4) || \
@@ -95,11 +93,7 @@ static const struct clk_ops omap3_dpll_core_ck_ops = {
 	.recalc_rate	= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 };
-#else
-static const struct clk_ops omap3_dpll_core_ck_ops = {};
-#endif
 
-#ifdef CONFIG_ARCH_OMAP3
 static const struct clk_ops omap3_dpll_ck_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
@@ -137,9 +131,13 @@ static const struct clk_ops omap3_dpll_per_ck_ops = {
 };
 #endif
 
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+        defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM33XX) || \
+	defined(CONFIG_SOC_AM43XX)
 static const struct clk_ops dpll_x2_ck_ops = {
 	.recalc_rate	= &omap3_clkoutx2_recalc,
 };
+#endif
 
 /**
  * _register_dpll - low level registration of a DPLL clock
-- 
2.39.2


