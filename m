Return-Path: <linux-kernel+bounces-62989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9DB85288D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E44C1F250F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871741756E;
	Tue, 13 Feb 2024 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pyvpYYSN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7937914F86
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707804031; cv=none; b=QWYS38ZLnfLQX7fi7ryH87ZAiFyEw7UyKZSla00f4PbLEjnYCDAsl5JINQm5UsDgkotRggR6XrZbGbVtUcK+NKFQUPHf7jZVqbzXIZxU0gcCx4fh1TYdZAlBr4iKih9l1mU7/RbYhAS2fxdQf9mfgLFXyymy7Qh3mUQlZCwobBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707804031; c=relaxed/simple;
	bh=vy2BiWXYPK56LaanMkdunBiBshvbeV4PGbJwLHDWoeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BciKJDv2FEai6NAuDJl4IWppP8S6Gl49gbAdLJCLWQrmBy9rK+V7NFraBMZewWNO8fHuVMVWAUpbw0gMatuqYFn96Za8aytwwyxTEb/Ja+8QSoLdzXPD4G1hI8Ddo/nj6+s5dLbboZmPmINufcNEw+BpTwZ0ub5KM+k6cvf7Ylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pyvpYYSN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IKBLt5egnDc4D9pBQ3cAmoTpmQYqa60LxJWwLiHkbVs=; b=pyvpYYSNNYBvHziRNAzzDcwkl8
	6s/Ksm7lwA5llVqidegyj7CDaY5PgNR/usUHzY50VCv1jh4gW1dMbKwAe4/o2SvrGFiIMVVhlxhOZ
	y44YiNC2cj7/OeG5if7yDRtbmpNnMqu7TesKSZctx/wI8QBe9v0S2qP83tO9hhqx9Mw/xHSy9wv3j
	Vrcb2Z5edQlC7jOFh804P9CD2/zpiAqUWui3HKK41co74Z2/bM5tj3hKRnpJxYiYym/gaUJiUtjbD
	DMVJS393k4I8Ob/+HVQiBHuXrfEdmHwK/Qxjke89agDeWlTWwgY9YcbGssmdj2MpjBTUgF58wgiMP
	bM8shJfA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZlqH-000000083hY-0mD5;
	Tue, 13 Feb 2024 06:00:29 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Marc Zyngier <maz@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Rosin <peda@axentia.se>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] extcon: max8997: select IRQ_DOMAIN instead of depending on it
Date: Mon, 12 Feb 2024 22:00:28 -0800
Message-ID: <20240213060028.9744-1-rdunlap@infradead.org>
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

Therefore, change EXTCON_MAX8997's use of "depends on" for
IRQ_DOMAIN to "select".

Fixes: dca1a71e4108 ("extcon: Add support irq domain for MAX8997 muic")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Rosin <peda@axentia.se>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: drop Cc: Donggeun Kim <dg77.kim@samsung.com> (bounced)

 drivers/extcon/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -116,7 +116,8 @@ config EXTCON_MAX77843
 
 config EXTCON_MAX8997
 	tristate "Maxim MAX8997 EXTCON Support"
-	depends on MFD_MAX8997 && IRQ_DOMAIN
+	depends on MFD_MAX8997
+	select IRQ_DOMAIN
 	help
 	  If you say yes here you get support for the MUIC device of
 	  Maxim MAX8997 PMIC. The MAX8997 MUIC is a USB port accessory

