Return-Path: <linux-kernel+bounces-35713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6448395E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E95B2E7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EBC86AE6;
	Tue, 23 Jan 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pXurEaxh"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868B7F7D7;
	Tue, 23 Jan 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028566; cv=none; b=aKS4gKK+cK+hHaGAVOLpEMRMzqCfSW24UjzM7GfbZurI+4ODH4Hx+lnadw9nzHAOBbCX/tI4IrSYEEvkuyxvUBKKan9KV4zJAWdSuQZ18k907fa98xM/jtSlzXc0cYiZbxjrXplgaPyToixkMc1Smj6bKTMXQ1nFMQzzSlH80kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028566; c=relaxed/simple;
	bh=Qvy5YIlLldiX0R7wIDqtJBVKHeubDCELaurFbpCFnp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poSCazHnHeDqUYC8Y2TcpcImZs/H+83TCxQEzwyyX5S3EBxD4actFIq4X5BL/MsaR4O7XI4mW/aBU4XTAtKdj9VgUgwzekJkG/Fu5hVqdI4Rgze21gGbbC6qRQGSxqaGHg0dLzHHzTC/+gtfVkISQWf5j1LRCgtDeBqgH0gNupI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pXurEaxh; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8B55820008;
	Tue, 23 Jan 2024 16:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706028562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opmB03pxVbtCj6pvCgp5nhczC3sDrqxdKFiEeY7PEsQ=;
	b=pXurEaxhxst3J2DTZkfiIU8pDjEQSk5qJd3opGmByu0NtbkalsMVoVTw6RWZ4bLYGvHnNB
	ByTMRQD1v78NcjqRpSbH7o9AFXXVrogQRUPOHHl1VWOTIAAHvXnJUYscFAoBUfFWdBipho
	NQQLKy/C1Z0o83Tv2Q+tDS8GEsLS7DRwvHmDLtz4WL7yyc6aI9gkdrn2SnBIF90kQaaohp
	n3luQCHnCY6gEOPdoN5X4znruvryToUzIkvbaJH/4RAr4d+tYldV1HLq57jHs7yMHUVobb
	kM3fMLU2HfMXFP7cr0gvp/bR2s9Ji4TXMFVkmvQGY4Wplh1xyxNFWwTW/j2EtA==
From: Herve Codina <herve.codina@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH 2/4] MAINTAINERS: Add the Freescale QMC HDLC driver entry
Date: Tue, 23 Jan 2024 17:49:07 +0100
Message-ID: <20240123164912.249540-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123164912.249540-1-herve.codina@bootlin.com>
References: <20240123164912.249540-1-herve.codina@bootlin.com>
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


