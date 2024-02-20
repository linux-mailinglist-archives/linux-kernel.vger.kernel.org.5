Return-Path: <linux-kernel+bounces-73305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E96885C0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038761F2479C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878A77624;
	Tue, 20 Feb 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e9VXrQs1"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228E763F7;
	Tue, 20 Feb 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445055; cv=none; b=jbPkDCckNe4Lo5ip1GodcJgFVz8AuJ1ht1YJUmOC/qMsdK+aPyh1Mn3RAgrrlz+Hn4H1SIbWHzZ8b8llWvWxQShgcRob1MGE1qL+1Jz1hokY9bnM72b0YWgp4H4L0ZaYVVEfblPI8NJgoEXpjdKy51HBhYCh8N67ym5CmFdmUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445055; c=relaxed/simple;
	bh=e41ssPMtOCWf4hbqr3GXct4QQnRw3mF4E7IEVePoDhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JD0zUEtVTcd56k+h0snKjtXOQ5Z1SHrJNRBUQkzI4kGVcL5qEuDszatnOpNWpQ84UnG7A1dIGv/fI2eFpmyU74/hcodXgtkLRgwd8PgDgHHQZ9BGb1HSJVzYfL+pcbyQFA7Awd7tYAculxshTo0nCfjkK66GRd25c+YAFK81pHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e9VXrQs1; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4A73FF80F;
	Tue, 20 Feb 2024 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708445050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0j6vyH8gSlQbmr8S5of7XqDa6oIEuqXtwYh8mWu5L1k=;
	b=e9VXrQs18lCFf1/zRSAhj5sva9sLY6gW28X4oZhRCpaATEU01ZwKgzaPAE7osDAQOLL+Zk
	rc9n54imIh0tbLeo21+VkT2DxsiOfIYCVWRsF2KMsV8G9Ykbg6PNKi7R2h5tP/sM8wHmkP
	t7S7Ex42lpQN1tr4r3ERIft66lrT4qpo+7JXIoU1gOig6hP8SZ2G3jTn/KY1hoDIKgd8TO
	G5WEbBVw1xPk23qy6zKyVAnITo6Xhel8WHfoVbA+IksW+vSi6rssx/3+/6gGPboTmQgxDN
	EV+vRk/fNKvqKB9W71mZ4AM4oZ2K2lpMb5421VrUi2f26CI0uC5AERxea+kWcw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next 1/2] doc: sfp-phylink: drop the mention to phylink_config->pcs_poll
Date: Tue, 20 Feb 2024 17:04:03 +0100
Message-ID: <20240220160406.3363002-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220160406.3363002-1-maxime.chevallier@bootlin.com>
References: <20240220160406.3363002-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

commit 64b4a0f8b51b ("net: phylink: remove phylink_config's pcs_poll")
dropped the phylink_config->pcs_poll field, which is no longer required
to be set by MAC drivers. Remove that mention in the phylink porting
guide.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/networking/sfp-phylink.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/networking/sfp-phylink.rst b/Documentation/networking/sfp-phylink.rst
index 8054d33f449f..bc3365bbf096 100644
--- a/Documentation/networking/sfp-phylink.rst
+++ b/Documentation/networking/sfp-phylink.rst
@@ -264,8 +264,7 @@ this documentation.
 	phylink_mac_change(priv->phylink, link_is_up);
 
     where ``link_is_up`` is true if the link is currently up or false
-    otherwise. If a MAC is unable to provide these interrupts, then
-    it should set ``priv->phylink_config.pcs_poll = true;`` in step 9.
+    otherwise.
 
 11. Verify that the driver does not call::
 
-- 
2.43.2


