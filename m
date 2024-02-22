Return-Path: <linux-kernel+bounces-76693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B35C85FB14
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19273286FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78364148FF5;
	Thu, 22 Feb 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oKYbvdUT"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C514691D;
	Thu, 22 Feb 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611755; cv=none; b=iOzVHcl6dLDGWH8HS8s2wxNBEBlGuAapEGETaWqZDO8FVJs2EQgU9zrMGGFhi06G5/6Xa/nq3Q2eG4DissGXRj0eTaPqSgS2olohz4XAww7mURVaYR6dXqWroRIi8fZL4tbzgmR2su6oojWwkIyIgpOMbKC6u9C28LBWjAGsw74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611755; c=relaxed/simple;
	bh=Qvy5YIlLldiX0R7wIDqtJBVKHeubDCELaurFbpCFnp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3EtjMKLJKIWJSJj8nUBLf8nsykWod1zx9+scJPwSJrf6O6Afbp5mlyUQmSMSoLLIpUz+Ut7S/Z/H0PbjiVZ6+y98mrDXEEcaH40xws11f4w6H2NX1TwWhG0/BlS/w8PwqpE/ChL/168lSp8ekdDplFelP5+Rp9koOzWIQSZzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oKYbvdUT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 3482D1BF213;
	Thu, 22 Feb 2024 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708611752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opmB03pxVbtCj6pvCgp5nhczC3sDrqxdKFiEeY7PEsQ=;
	b=oKYbvdUTtTtpgJ62BTj+M4DjQ3ezGFhDyNQ7x5TE+txi5GALaL8yVOAPG4pPyTtzvnuQ5E
	eTOAZUdbnuAVcz1DdYo36ikvTFPlKPkJ2prWz2rovgDfED6QUBBkJNtE2fhZT2/8T2qkgQ
	GESq+BBc+qir7D1z6TXttZNvtCLmY5XtZcGG6SUnkQyewGme+LeL5TU/sYRf9y61bAnVjd
	JzehvR94BB924pINVS1MR4axB0CquXDicw4t+r8eimWnVbAFYPSXaYXshm6b6vBFAj/iYG
	ER5lmkTdPch9pAVDIC3P7lGDSANifAr4cLntA5/jk63CxYP/tvNqHIuOQMOcJg==
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
Subject: [PATCH v4 2/5] MAINTAINERS: Add the Freescale QMC HDLC driver entry
Date: Thu, 22 Feb 2024 15:22:15 +0100
Message-ID: <20240222142219.441767-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222142219.441767-1-herve.codina@bootlin.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
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


