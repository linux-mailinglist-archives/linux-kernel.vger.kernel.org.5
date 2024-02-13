Return-Path: <linux-kernel+bounces-63771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049A85343C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D019A1F2673B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE88605CC;
	Tue, 13 Feb 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PytGMhye"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F535F87A;
	Tue, 13 Feb 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836688; cv=none; b=SymAh0aH9qPRN3hD6Yyq4c0HoIKECiLs34A8hGDeinHsBOjBF9Owqq1EOtvYD0Z85Ts6yFIiITS2E9eD7FX9LNDNRbpBMGHunlxarG8OL29V6bHKZbrKVNTLfXhG9aaH7sozqjCjKDuNa8CRfqN8+WFPI97F1DK8A9z+dlFscoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836688; c=relaxed/simple;
	bh=57X+EBrpaLE/1lkDUXRPxy6Yx07hO3FWy/vn76Y07Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBpy/++YD34xLYh+ZLmgkxeyfYbQWY4xT2b/ql/15o/xdVaehEYNcg/v1klC4Z06oweS4OMx69pq1BIk15TeG1P5BGetusTPGF64ObZMXiQzxWjHkhMxRM4Z7EW9LKTxdpduC7/xF7Qy7jnuJZLAQSAbBD96pwiWY9c6ipTiGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PytGMhye; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E56C1BF213;
	Tue, 13 Feb 2024 15:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707836684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwIX7+El5QmnjROakdN4myLsb1ax3viGLX6LhH3RGqg=;
	b=PytGMhyeOYM5jYUaEKRjAOI2GSDCVx7LRSQT5UzLNj3dTIysGD8dOOKCCRRdZ/YR9a8hLu
	JNCEPcEhYlYIhc2xtZVXuA5tlCsQ6nZEF9CowAush5Zb1AyscTgYUAwyLt5O9hWvSWW5pi
	FO6U+VVobe5VnwlEj5ag02QxY9oqAdIG9TWAljjHcERdIxvII1VEWCA+fTjlq8wJ9CfqV7
	cKAC3siHAnVOKj7n5ApO8V2qLOyrpaCE8nNMXJdCBIu+1RMNjVl4yqOFQOWPvc/fbZT6up
	u6EV0oq68SBcB/v8Oy0QaVzcWsAg6/SUuA2PaP47ZihNTb1gXQsIyZ/mZwwVjA==
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
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org
Subject: [PATCH net-next v7 06/13] netlink: specs: add phy-index as a header parameter
Date: Tue, 13 Feb 2024 16:04:23 +0100
Message-ID: <20240213150431.1796171-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213150431.1796171-1-maxime.chevallier@bootlin.com>
References: <20240213150431.1796171-1-maxime.chevallier@bootlin.com>
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
V7: No changes
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


