Return-Path: <linux-kernel+bounces-103246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2488487BCE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F73B20FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0454653E2D;
	Thu, 14 Mar 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bd4SJ205"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FA2581;
	Thu, 14 Mar 2024 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419637; cv=none; b=oONlBMo4Kt2O6S1I2NbrHOIYHoA26Z52I9qbwNtlrfCIsU1bmqleNb2qcv/ldULnTvOPyALUgIxvzWImxQKpwuyRoOua3sW0pRgWRus9Y/TbO8WMi3czTVCWpNhfKxv8ow8t5wH7DzdPlOeI8F8Rv0nZkQCxPr9s9TswiXmn12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419637; c=relaxed/simple;
	bh=eOILbvhVjxTSdQCJYFJD/gXXjuXv/ep0xzuGvycuRTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JpqjPQ3TUtLb4SY7ZOpKlbs0z4nGkXZcGvXTV5FHfdyawRicZPB1DB8QfIisaCBofGbxlZvZgRm3vfGhvtk44EeLbipq8RQ0efwXqoFwdzuFbhLEk+4qVi6HSKj+ALpYGz3ukmX2cJJhEuy00REifBvGqBpV/kkMNU37bGtKUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bd4SJ205; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 50D1BE000B;
	Thu, 14 Mar 2024 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710419632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vmS6pTNpvnT/R21GkQzH7oBRj9ygun2hL3GsI2Prl7k=;
	b=Bd4SJ2052tDvqmPvwvYDCWFxDOPB/uPi0aNi9qDO27H3vwbviwTbcoJHZOzjFbK+CjEU7X
	wB9bNmnYTzmhxegXTFhGucB/tqAB6sqmnT7QRhpGkdShDRykrBqNTAyzBbHu+PCJ/jUsDB
	0bmcsLfMSe5AJtreGLtuzOo2zg/xa0gIfiz2RjJMUNu91ufYz06T+erwYijk3HH/wnEYz7
	KJxBFx4fCqkN0aE1wtWWYJpKMvqq5Dss6mNZoOMpxsNKlK3K1JVB84dGFLNQ3tN85+phO5
	Q4ybimPoXRvfNhQMWJrRmDMNZor+f7DA+lOxGgtCK2ybxVygKtleWTlvr6da3w==
From: Herve Codina <herve.codina@bootlin.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] net: wan: fsl_qmc_hdlc: Fix module compilation
Date: Thu, 14 Mar 2024 13:33:46 +0100
Message-ID: <20240314123346.461350-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The fsl_qmc_driver does not compile as module:
  error: ‘qmc_hdlc_driver’ undeclared here (not in a function);
    405 | MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
        |                         ^~~~~~~~~~~~~~~

Fix the typo.

Fixes: b40f00ecd463 ("net: wan: Add support for QMC HDLC")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Closes: https://lore.kernel.org/linux-kernel/87ttl93f7i.fsf@mail.lhotse/
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/net/wan/fsl_qmc_hdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
index 960371df470a..f69b1f579a0c 100644
--- a/drivers/net/wan/fsl_qmc_hdlc.c
+++ b/drivers/net/wan/fsl_qmc_hdlc.c
@@ -780,7 +780,7 @@ static const struct of_device_id qmc_hdlc_id_table[] = {
 	{ .compatible = "fsl,qmc-hdlc" },
 	{} /* sentinel */
 };
-MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
+MODULE_DEVICE_TABLE(of, qmc_hdlc_id_table);
 
 static struct platform_driver qmc_hdlc_driver = {
 	.driver = {
-- 
2.44.0


