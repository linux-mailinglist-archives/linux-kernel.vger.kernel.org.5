Return-Path: <linux-kernel+bounces-44154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0F841E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD50B2489A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A43858112;
	Tue, 30 Jan 2024 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aUnvWw+S"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A145645F;
	Tue, 30 Jan 2024 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604057; cv=none; b=t64Gr5Zw54igc4R5LqCpCgT88RAqsHhgwt7Qpy/L+X3fcfteQlm/wl5LklzHo7r1DLz+3OqgpnN6g549NMkuCes7JWWljfQ1PkhzEaa4ehQb+Z42R/HkESC8cIbKB/t4hO/zA+nXgiLrXtJ7q6KfYj1tFwyamkfATKzrEZdfMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604057; c=relaxed/simple;
	bh=Qvy5YIlLldiX0R7wIDqtJBVKHeubDCELaurFbpCFnp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuc2b8Bm9okljBv8e1VPnPb+W9VcYMyCRpyn9qWq74V5zrtvvNUio843WG3CVoR86eHiw21914CHTrse6yfwnvDob0mtaMkxhR6fG5oIETuoHrzksz/RMmIv1bIj3mAGPzumJw+lvKcRr4yovyg4EgeDOLNlv1RywhQgAaQkxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aUnvWw+S; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 166DD6000C;
	Tue, 30 Jan 2024 08:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706604047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opmB03pxVbtCj6pvCgp5nhczC3sDrqxdKFiEeY7PEsQ=;
	b=aUnvWw+Sif48HwC03muNUyJ46k83JmJIqcHyF8tHiNSYxV449Nbu8KkNsjIQkjq0BnHDsR
	mIS45MqKu/3wrR1a27mttIxlGpnKqVtjZjyBOgmi5mTMZDrOcD8semM9tqWqx6ueVIVaJL
	+TM8zN1+lqHSPZGNYF0hrBfWaWZtenC/itCemBJRMyTgxJHib4LDBPL8eO0GtGPElBxe+z
	/B6es6ytb2SBaA76kRkHwQGWpihnQqKBhjs027ojv0YCPonjOCGfFMU3r5SYTQ/gwR7u3h
	MVUKycmHrdFtmUBBfSFb8Zr2C4ZhPrTn/mZ8xCTsQsFfZC/AvqKWEE/qDOWFWA==
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 2/6] MAINTAINERS: Add the Freescale QMC HDLC driver entry
Date: Tue, 30 Jan 2024 09:40:17 +0100
Message-ID: <20240130084035.115086-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130084035.115086-1-herve.codina@bootlin.com>
References: <20240130084035.115086-1-herve.codina@bootlin.com>
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


