Return-Path: <linux-kernel+bounces-104753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D7A87D318
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD49F1C20D54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BAB4F201;
	Fri, 15 Mar 2024 17:51:57 +0000 (UTC)
Received: from relay163.nicmail.ru (relay163.nicmail.ru [91.189.117.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E44DA08;
	Fri, 15 Mar 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525117; cv=none; b=ACfJvXF+YEQu+ev/wHcvS+qMAsCgGP13qZ+wd/YrnrIEkU2v1+1+nlK5WcjndqS9xq/ZbPym0UhJW82nCw+Gcj3mOPRiEZtdNUrN6xBrXUMbMqeaSbt91y8yiiu4rXIKqHUnhYqMA4oNlmM8SgOICw6qhl6DYtfSRTafToVutb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525117; c=relaxed/simple;
	bh=kB7dpmBv6Z1afxF2sKPJV10+Ol3WrAzuMADcOyDjF9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBvPfomhvIeBNM0OTmsoG7htUP81XuZ/E52hnIphIaumgy+KTJgA6CpqJRpSZXNRNKq2SiPWJmU/aAmRcTey5Iy4a6zh6x2eGo3mpfqtNCE0JfwQxnssh49wjmjJHfcGlHwJ91O6wNUd3bwH4H2tnDWfxfqrLyZA1I89Dqm0+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.136.255] (port=45346 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rlBiT-0002BV-A6;
	Fri, 15 Mar 2024 20:51:37 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1105.mail.hosting.nic.ru (Exim 5.55)
	with id 1rlBiT-0002Zm-05;
	Fri, 15 Mar 2024 20:51:37 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net] net: phy: fix phy_read_poll_timeout argument type in genphy_loopback
Date: Fri, 15 Mar 2024 20:50:52 +0300
Message-Id: <20240315175052.8049-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314164826.161bd398@kernel.org>
References: <20240314164826.161bd398@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

read_poll_timeout inside phy_read_poll_timeout can set val negative
in some cases (for example, __mdiobus_read inside phy_read can return
-EOPNOTSUPP).

Supposedly, commit 4ec732951702 ("net: phylib: fix phy_read*_poll_timeout()")
should fix problems with wrong-signed vals, but I do not see how
as val is sent to phy_read as is and __val = phy_read (not val)
is checked for sign.

Change val type for signed to allow better error handling as done in other
phy_read_poll_timeout callers. This will not fix any error handling
by itself, but allows, for example, to modify cond with appropriate
sign check or check resulting val separately.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 014068dcb5b1 ("net: phy: genphy_loopback: add link speed configuration")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
 drivers/net/phy/phy_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8297ef681bf5..6c6ec9475709 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2831,8 +2831,8 @@ EXPORT_SYMBOL(genphy_resume);
 int genphy_loopback(struct phy_device *phydev, bool enable)
 {
 	if (enable) {
-		u16 val, ctl = BMCR_LOOPBACK;
-		int ret;
+		u16 ctl = BMCR_LOOPBACK;
+		int ret, val;
 
 		ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
 
-- 
2.34.1


