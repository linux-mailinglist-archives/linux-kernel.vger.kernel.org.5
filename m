Return-Path: <linux-kernel+bounces-31970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81FA835495
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6941F22BFB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D486A364B2;
	Sun, 21 Jan 2024 05:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="znEoVl01"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8CD364A6;
	Sun, 21 Jan 2024 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705814325; cv=none; b=TLo1P0S5KUlyGN8fHo8x6M0sOUGlARiuv5/qO/+Ciq2orAAMLp6KoceuciI7rMAz6fvkMfOigUdJ3q0VrTtadhibEmtVh2YNAwhl7d6DIrxrNUTK8zY7Av9t6egCZwVwXk4Gih5xDAx+l/EvNV87joiETabOPM9FW2YwBRvANVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705814325; c=relaxed/simple;
	bh=UFTWkqX6bnktQloDzscK9PYzEVaNTQz67zW0Sog3Ui8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2w9v5ItA37wTLutiFKk/GoQdZ+tpgPa8Vcb+2XnvPhk+8eYnabJn2fZMnthfVFlT9AQGdKaDgrP9y+DXJ5TeHhIfeqCeGJBsylQTYzGr96XkImShrfGzYDrwPPJAVahK/NhuH+0gfTeOKsde1CXvPr61wNCZkINgwSOdbsQwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=znEoVl01; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EpNABUkQ/ZpQnYGH4JyM/iICjAozI40BQcRt+WngSNU=; b=znEoVl0105CY16oSOWr1I1fFXh
	TQkHYZeFXRMclH0WBPFsfm2i6Msf+8Q1hUdj6ngm7FWKGuGXvPKd1Ks7XmPPfLleU0nUHj3zv6OSm
	E8Slr9DuSaXFDMk9VW2xAehPlo7hoKcfAFDqPSmQ+TbYlyZjG1g3FT/StW257jw4ds2lfiC1M2B2p
	3CgweM7Y7HTWf4YAIbWZ7raZ2lyv5Q9ZfT0P+N6iL1S4LGLnEz9pfnp3D2X1BwYbh/GSR+Wjpp3pk
	MIgNf7ZxEB3BJW6ovyZ8AAllwWlCdVM4OhoKH7rLpdgn1TejzDECrj7jKWxyeKZUQDcrKD4mYOWdH
	K3f0mu0g==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRQEA-008uL5-2x;
	Sun, 21 Jan 2024 05:18:38 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH] clk: sunxi: a20-gmac: fix kernel-doc warnings
Date: Sat, 20 Jan 2024 21:18:35 -0800
Message-ID: <20240121051837.17564-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the function kernel-doc comment to be immediately before the
function implementation, then add a function parameter description
to prevent kernel-doc warnings:

clk-a20-gmac.c:43: warning: expecting prototype for sun7i_a20_gmac_clk_setup(). Prototype was for SUN7I_A20_GMAC_GPIT() instead
clk-a20-gmac.c:53: warning: Function parameter or struct member 'node' not described in 'sun7i_a20_gmac_clk_setup'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Emilio López <emilio@elopez.com.ar>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
---
 drivers/clk/sunxi/clk-a20-gmac.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff -- a/drivers/clk/sunxi/clk-a20-gmac.c b/drivers/clk/sunxi/clk-a20-gmac.c
--- a/drivers/clk/sunxi/clk-a20-gmac.c
+++ b/drivers/clk/sunxi/clk-a20-gmac.c
@@ -15,8 +15,19 @@
 
 static DEFINE_SPINLOCK(gmac_lock);
 
+
+#define SUN7I_A20_GMAC_GPIT	2
+#define SUN7I_A20_GMAC_MASK	0x3
+#define SUN7I_A20_GMAC_PARENTS	2
+
+static u32 sun7i_a20_gmac_mux_table[SUN7I_A20_GMAC_PARENTS] = {
+	0x00, /* Select mii_phy_tx_clk */
+	0x02, /* Select gmac_int_tx_clk */
+};
+
 /**
  * sun7i_a20_gmac_clk_setup - Setup function for A20/A31 GMAC clock module
+ * @node: &struct device_node for the clock
  *
  * This clock looks something like this
  *                               ________________________
@@ -39,16 +50,6 @@ static DEFINE_SPINLOCK(gmac_lock);
  * enable/disable this clock to configure the required state. The clock
  * driver then responds by auto-reparenting the clock.
  */
-
-#define SUN7I_A20_GMAC_GPIT	2
-#define SUN7I_A20_GMAC_MASK	0x3
-#define SUN7I_A20_GMAC_PARENTS	2
-
-static u32 sun7i_a20_gmac_mux_table[SUN7I_A20_GMAC_PARENTS] = {
-	0x00, /* Select mii_phy_tx_clk */
-	0x02, /* Select gmac_int_tx_clk */
-};
-
 static void __init sun7i_a20_gmac_clk_setup(struct device_node *node)
 {
 	struct clk *clk;

