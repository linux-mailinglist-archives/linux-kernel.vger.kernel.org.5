Return-Path: <linux-kernel+bounces-61165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A940850E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0A71C2146C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75810976;
	Mon, 12 Feb 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MzYU1wXM"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1B79E1;
	Mon, 12 Feb 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724634; cv=none; b=cYi/k1nN7O0bu9xfvk3pUOD8bkDFyo1z2sBvYKkBLFbZJ66V3MIgLzvEoSe85BnpYw9TGvTfOKmTDgB6nsFW9o51RsRIbzJ2Lr8s0m8WU1vxGaqBpByMbdxOqFxbX7DC1uz9Zz/3iOhX8j5t31aFNfbByMvJFPPswDqt7xhVfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724634; c=relaxed/simple;
	bh=Qvy5YIlLldiX0R7wIDqtJBVKHeubDCELaurFbpCFnp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0AfiZvoPoSH5L1tV9hpoGz1CmKmLzX3RCdFPaOkRBKLYIzCwoQz7mFkaQH68+l66tlYmVxiHr0j/7Y/jtyrxZ8O9bMq8C9CZySrLzsSosX/28SAvqAGcoS/DwoUMvq2PXb5rd/B6geELwHUfs//rmxy0zYthChYOQaE7NQC0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MzYU1wXM; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id C8CD140014;
	Mon, 12 Feb 2024 07:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707724629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opmB03pxVbtCj6pvCgp5nhczC3sDrqxdKFiEeY7PEsQ=;
	b=MzYU1wXM1GGxq6AOxEnTOcYsLAvdRMfolwWcOEA51YpjcTseBGJm6ExlyHlUxko3+0S4Rv
	x5vCTulTS8uRZ/8cXIaX7Vox1tb+8rwQ82mdTDybFvYSXQIxEiukf6rIRe7Xxzmg8LBfAK
	1OW8d8aHvnhv+glWM26DE51UZFa0r4UL41wOneWRQfY8frUQmvWAF3H6TW/WJJSaaMOGUD
	gyZyt4/nwowMQNkmp90iQ0I7rV26/4r1jijAfe+bfm9RIfsjczlcunHGXocAd5wnxOUEq+
	UAL4sY1ot/paNpNoIQIKbwvUlhtzGci+zDQjyuUWp34XGfA8V0wnMnbv4JHdxA==
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [RESEND PATCH v3 2/6] MAINTAINERS: Add the Freescale QMC HDLC driver entry
Date: Mon, 12 Feb 2024 08:56:37 +0100
Message-ID: <20240212075646.19114-10-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212075646.19114-1-herve.codina@bootlin.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

After contributing the driver, add myself as the maintainer for the
Freescale QMC HDLC driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..15cd3a8e5866 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8584,6 +8584,13 @@ F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
 F:	drivers/soc/fsl/qe/qmc.c
 F:	include/soc/fsl/qe/qmc.h
 
+FREESCALE QUICC ENGINE QMC HDLC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	netdev@vger.kernel.org
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	drivers/net/wan/fsl_qmc_hdlc.c
+
 FREESCALE QUICC ENGINE TSA DRIVER
 M:	Herve Codina <herve.codina@bootlin.com>
 L:	linuxppc-dev@lists.ozlabs.org
-- 
2.43.0


