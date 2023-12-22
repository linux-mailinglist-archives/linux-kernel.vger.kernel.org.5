Return-Path: <linux-kernel+bounces-10099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41981CFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A4F1F23EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D0339BC;
	Fri, 22 Dec 2023 22:51:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A682F845
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMN-0005ZT-6G; Fri, 22 Dec 2023 23:51:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMJ-000qus-6T; Fri, 22 Dec 2023 23:51:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMK-000Ff0-0a;
	Fri, 22 Dec 2023 23:51:12 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	kernel@pengutronix.de
Subject: [PATCH 00/13] irqchip: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:31 +0100
Message-ID: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2268; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=v7ypKlogWSytD7lf1SVbYFZwVbn6mIgx5yAUcapzsz0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhhK27tJuAJCvbukbs16KJeuc3ApgCd8jJ8GTK l8H4WsKneuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYYStgAKCRCPgPtYfRL+ TkK3CACh/9LhWoUb7uG4ZFk74M/1Wv7x80WVfz/wC3medJ17C55KyYQ/zbGzeV3ZqDEs8dkKGRr H1kdYdtDzZ6UbfeMGe77IfZiVoG3qmk1nV6i/EAugMPQlwLXhUXnFV3TORzeXtLyW57YO1slDs8 TnBRPg9ewko76aj9/nV+RSjsNZqjULCDuEEuTM/l9BowT+eLuFEINuiXBqBKjpSuSlbjXq0xWdF MWtK8hBR+9mWftaTGWNXGJjhfYw+MuIgj67jPhies0kQdC4wzpgDeZMG9Oh7fZhhVUVRoBol+cn xAN1YXJwjax3mT9f8wCFhZ8G61WtWZe8UShwnwTp48ztg9Ik
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

this series converts all drivers below drivers/irqchip to use
.remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
callback that returns no value") for an extended explanation and the
eventual goal. The TL;DR; is to make it harder for driver authors to
leak resources.

The drivers touched here are all fine though and don't return early in
.remove(). So all conversions in this series are trivial.

Best regards
Uwe

Uwe Kleine-König (13):
  irqchip/imgpdc: Convert to platform remove callback returning void
  irqchip/imx-intmux: Convert to platform remove callback returning void
  irqchip/imx-irqsteer: Convert to platform remove callback returning void
  irqchip/keystone: Convert to platform remove callback returning void
  irqchip/ls-scfg-msi: Convert to platform remove callback returning void
  irqchip/madera: Convert to platform remove callback returning void
  irqchip/mvebu-pic: Convert to platform remove callback returning void
  irqchip/pruss-intc: Convert to platform remove callback returning void
  irqchip/renesas-intc-irqpin: Convert to platform remove callback returning void
  irqchip/renesas-irqc: Convert to platform remove callback returning void
  irqchip/renesas-rza1: Convert to platform remove callback returning void
  irqchip/stm32-exti: Convert to platform remove callback returning void
  irqchip/ts4800: Convert to platform remove callback returning void

 drivers/irqchip/irq-imgpdc.c              | 5 ++---
 drivers/irqchip/irq-imx-intmux.c          | 6 ++----
 drivers/irqchip/irq-imx-irqsteer.c        | 6 ++----
 drivers/irqchip/irq-keystone.c            | 5 ++---
 drivers/irqchip/irq-ls-scfg-msi.c         | 6 ++----
 drivers/irqchip/irq-madera.c              | 6 ++----
 drivers/irqchip/irq-mvebu-pic.c           | 6 ++----
 drivers/irqchip/irq-pruss-intc.c          | 6 ++----
 drivers/irqchip/irq-renesas-intc-irqpin.c | 5 ++---
 drivers/irqchip/irq-renesas-irqc.c        | 5 ++---
 drivers/irqchip/irq-renesas-rza1.c        | 5 ++---
 drivers/irqchip/irq-stm32-exti.c          | 5 ++---
 drivers/irqchip/irq-ts4800.c              | 6 ++----
 13 files changed, 26 insertions(+), 46 deletions(-)

base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
-- 
2.42.0


