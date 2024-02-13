Return-Path: <linux-kernel+bounces-64498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7AD853F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2172128671E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783BE6280D;
	Tue, 13 Feb 2024 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vyivi4l3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FBB629E3;
	Tue, 13 Feb 2024 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864984; cv=none; b=s8hhWYE+H/NQlzKuN9pHjSbWCvByyjRRXgyJrMaW0iTI1zWnQco7ztyybamXLGmE38w44K03xFdPefiaaiUmEGL4zseUajMeruT4B2wAQwnzOjSZBXQdXMzukwDi7tvRAB5U/m0X0iE4N/IP2pzJJrEjEgnEU9/P63UO3dNsawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864984; c=relaxed/simple;
	bh=kQBIMbkQ/cFGFHAymRMtaRiM8GO2JKPBgI/mNvZsgYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrWgAJJCP0yUiGG0n2ShCYxh2u/olhdjX1gkPrFzcAxdEXyUkEkDeH7lZsfvcgdv2YcR4gE1vPFOHIBj5e3s3WHIatecOKOu83vvcExRElq0c9srdwIJT5ugwIhoAup/uizGfYLJsJTv8/xsggVkZEuhnvUandU/wskkdU+1v0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vyivi4l3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wy6heJa7Ut654C3QHTTlQbb4DZypUdZ0Hs04M2BHvRw=; b=vyivi4l3WzwptNPmQRXcnUrPcr
	ryCBBjD/01OBxD/Wj2btsSqByFtqipUCuCnIAii9TI07uhaTqYh9REssEtbBreuMKL75zF26hgG6a
	iPOKJL3Ua4nXdKD1Nl6EApst3SKeTiBnfWnXqZdGq7uQAYkFoScKcHhI4Vh6dgBzqKPdUepEFt2hn
	lPWIujtfvlq3KH4nDuj0PdS+2zXkCs2u8SNn141en+Ekkee0AJvwLfE8F6DgQwW1Zo2sj3RXVottm
	wXsNWpoizBUkf0cI1IV9n05hcIe6SAlt07sKiM7ln2Dk25ZH1ah++gGzNAd4hHmGjgmmobUIwKQcB
	PYocyBhA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra1hN-0000000B9zN-0o8e;
	Tue, 13 Feb 2024 22:56:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Rosin <peda@axentia.se>,
	devicetree@vger.kernel.org
Subject: [PATCH v2] of: OF_IRQ: select IRQ_DOMAIN instead of depending on it
Date: Tue, 13 Feb 2024 14:56:19 -0800
Message-ID: <20240213225619.11726-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set
it directly thru "make *config", so drivers should select it instead
of depending on it if they need it.
Relying on it being set for a dependency is risky.

Consistently using "select" or "depends on" can also help reduce
Kconfig circular dependency issues.

Therefore, change OF_IRQ's use of "depends on" to "select".

This patch reduces one Kconfig circular dependency in
drivers/mux/Kconfig when MUX_MMIO attempts to select REGMAP (a failed
patch), which that driver needs (but does not completely resolve that
issue). [1]

before this patch: (10 lines of detail)
drivers/net/ethernet/arc/Kconfig:19:error: recursive dependency detected!
drivers/net/ethernet/arc/Kconfig:19:	symbol ARC_EMAC_CORE is selected by ARC_EMAC
drivers/net/ethernet/arc/Kconfig:26:	symbol ARC_EMAC depends on OF_IRQ
drivers/of/Kconfig:81:	symbol OF_IRQ depends on IRQ_DOMAIN
kernel/irq/Kconfig:60:	symbol IRQ_DOMAIN is selected by REGMAP
drivers/base/regmap/Kconfig:6:	symbol REGMAP is selected by MUX_MMIO
drivers/mux/Kconfig:48:	symbol MUX_MMIO depends on MULTIPLEXER
drivers/mux/Kconfig:6:	symbol MULTIPLEXER is selected by MDIO_BUS_MUX_MULTIPLEXER
drivers/net/mdio/Kconfig:275:	symbol MDIO_BUS_MUX_MULTIPLEXER depends on MDIO_DEVICE
drivers/net/mdio/Kconfig:6:	symbol MDIO_DEVICE is selected by PHYLIB
drivers/net/phy/Kconfig:16:	symbol PHYLIB is selected by ARC_EMAC_CORE

after this patch: (5 lines of detail)
drivers/mux/Kconfig:6:error: recursive dependency detected!
drivers/mux/Kconfig:6:	symbol MULTIPLEXER is selected by MDIO_BUS_MUX_MULTIPLEXER
drivers/net/mdio/Kconfig:275:	symbol MDIO_BUS_MUX_MULTIPLEXER depends on MDIO_BUS
drivers/net/mdio/Kconfig:13:	symbol MDIO_BUS is selected by REGMAP
drivers/base/regmap/Kconfig:6:	symbol REGMAP is selected by MUX_MMIO
drivers/mux/Kconfig:48:	symbol MUX_MMIO depends on MULTIPLEXER

[1] https://lore.kernel.org/lkml/20230210115625.GA30942@pengutronix.de/

Fixes: 63c60e3a6dc3 ("of: OF_IRQ should depend on IRQ_DOMAIN")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Rosin <peda@axentia.se>
Cc: devicetree@vger.kernel.org
---
v2: update patch description, rebase & resend

 drivers/of/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/of/Kconfig b/drivers/of/Kconfig
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -80,7 +80,8 @@ config OF_ADDRESS
 
 config OF_IRQ
 	def_bool y
-	depends on !SPARC && IRQ_DOMAIN
+	depends on !SPARC
+	select IRQ_DOMAIN
 
 config OF_RESERVED_MEM
 	def_bool OF_EARLY_FLATTREE

