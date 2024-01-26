Return-Path: <linux-kernel+bounces-40505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D2D83E1B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103A128380B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED9225CB;
	Fri, 26 Jan 2024 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l1R7pzuq"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D822307;
	Fri, 26 Jan 2024 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294347; cv=none; b=RqT293Oabz2Z8IQlIq8eSSjiQAZhje9v6XXxXYwbRXmtLei0AS1P7333fuOy5ABIHpjYOzGlLmyCyTtHI7D8yFcrlKcF6i0SMPLPK+pdKIiaui1JkFhMBeCLIMiGfUychscN13Ax6inrJ8lh6MR2Pao/0JNlHHeuJ7aYR7H9y7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294347; c=relaxed/simple;
	bh=6bq2A7yWxXO60DDbnJ5MDs6AhRaolkFAslIffwbnQOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwSAlYuVorcRMNIRfxHp3Ituu/5JmW3E7FDJjWlH1rmi6r4Xr675AId0ulw+/aW6NX74gH0JTvFJ93CTbfzcwnKVBp3jsWoTyoiYJVLnmHh8B/gATMIEvTGaAys92pm4p/yKU6j3063g0ZQOCA2NvxM6ImSP8h3XIvM6l/YdCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l1R7pzuq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B9B5FF803;
	Fri, 26 Jan 2024 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706294342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VA4LXOq+DUE3/vzctPspi/ENCsHhbSNqzTsn2IgL8M=;
	b=l1R7pzuqM3U3MOw7clg7hzvDwj2rP83LJ5H5On74QWR2tsPh6XRnlRQr8P7j+Cq74vY1z9
	plozEnDfbLeL9EJCeXiXYdNb0CmoEdCm6bhaFVQSlq7vynUDvnodjivQNDI4CwwbLX277r
	NTJEbT0Ly+v21tF0qrLOy5Vlmh4R/1JpWPavDv7gc5sspzaj6TEMcz8uw1arjuU9LNoHdI
	LX8lyx9nY/XG00vACTf3rfF80zQez7nImIUNoVgveFUCloAwHkxL1BBzuGLDmrPjyizJIM
	a9zdWI5C873b59aq9evl76W+H2qHJoz0Qp6vw07jB845bCwaaAVrqZfMsPQfrQ==
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
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v6 06/13] netlink: specs: add phy-index as a header parameter
Date: Fri, 26 Jan 2024 19:38:43 +0100
Message-ID: <20240126183851.2081418-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
References: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Update the spec to take the newly introduced phy-index as a generic
request parameter.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
V6: No changes
V5: Added Andrew's R-b
V4: Ditch the ethtool-user generated code
V3: New patch

 Documentation/netlink/specs/ethtool.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 197208f419dc..bb6e1dc6d1c5 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -30,6 +30,9 @@ attribute-sets:
       -
         name: flags
         type: u32
+      -
+        name: phy-index
+        type: u32
 
   -
     name: bitset-bit
-- 
2.43.0


