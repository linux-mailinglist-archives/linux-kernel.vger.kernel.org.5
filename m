Return-Path: <linux-kernel+bounces-93466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39DE873037
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE2F2854CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954525D8E4;
	Wed,  6 Mar 2024 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i9Pm4iO2"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31E25C907;
	Wed,  6 Mar 2024 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712477; cv=none; b=mUOzda4wAN9VlbIDtUySjDPdnpNWWveOQ8iSiCjneQdmSw8i8hbwskhipoWWxvynCvwvJ1ui/umkem6KqtEfSbPldlKKutP/l9CkB3CvUcKBx8ydAjfKwu8H3mpOxAxlmTjUHalpfzkhTnOm1pqk0/EAg8cPlkw7wKRhEkcW7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712477; c=relaxed/simple;
	bh=Qvy5YIlLldiX0R7wIDqtJBVKHeubDCELaurFbpCFnp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0HjHTEX6kgOdjdArdKM9hof2fagRAwtAh+Svzto87sJXlVScpa/CiqiN4qarwKhfExCNKXPIJeVPsAiwqpd7x+M17wSPSPszBD8Zre0xUuVpRhmEylVhnxF9vJdyJIuPdLyCCilcOJPn4KS21wILlP8evxDRZRzgeecopd7yYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i9Pm4iO2; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7B39120015;
	Wed,  6 Mar 2024 08:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709712468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opmB03pxVbtCj6pvCgp5nhczC3sDrqxdKFiEeY7PEsQ=;
	b=i9Pm4iO25hv4/SdpjxNmBdokSgvrOesGHuTMNiE/6jp/bBiSPKRkA1T/rgK2tBpxkwYiG3
	baZalS3TIqrLdeA+RXB5KNEXArPuG9IPAcSliA9cKfLIDGVyU8jBznYKYWadR4ZgtKqLHk
	DUSLGOO29E3a83eBYlutphCv6OiG6szlvjaZ9WjzuBP1QFmD3JyjvYREA1oT3jFeChOrHT
	+PzRB0J5yuuEdpiYLb+e/A2EpNlJDMkUsd4uEnAmN+mrBHHV6CD8cXb91n+owFnj/+4xz5
	tGV7AYr1oAuY+R2lfg3+ZyvSU+kCzeB/OdOWop365m3oCIItvlnfEXll8BIvdA==
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
Subject: [PATCH v6 2/5] MAINTAINERS: Add the Freescale QMC HDLC driver entry
Date: Wed,  6 Mar 2024 09:07:18 +0100
Message-ID: <20240306080726.167338-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306080726.167338-1-herve.codina@bootlin.com>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
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


