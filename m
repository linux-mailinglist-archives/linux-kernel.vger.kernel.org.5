Return-Path: <linux-kernel+bounces-21402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18BC828EA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042B31C241E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C1E3D99A;
	Tue,  9 Jan 2024 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="aoRbrk/G"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA253D0B9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=nAIjW3Vd6AO7np
	gt9Xb/HqJrmYFkWeDl3YQgZw/BnJA=; b=aoRbrk/G0kEMU3fMqSP/zuBGxnipqQ
	W/IL/0pu0zKEh5gwSrc2625INKWMeAdvM0BCmicDgZkqT3l+FOGPeNwdU4Paw4cJ
	FCWb6LG2qB2FiCHDinX3nkuJ5VXk64DDa44Rfr3kTw+GDaXvtTPHBk2VQhuSRgCW
	rHr6S4uRQ9fggP+cWqWU7BGb4d1HbYj5CXn345uOHizdf26IMVFlwAKNZAwXUT5b
	vXauhpOxhixgq0zt62ge8Az5TABXH90s8QTQDrRFWP+sal4V3FKBhJE7N9ccYd3x
	BqRbakLoAeT0c1ILGMmOZJ4TMKw8I6niTxRbs9Xybfr5HiIfMMG32QHQ==
Received: (qmail 354471 invoked from network); 9 Jan 2024 21:52:45 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jan 2024 21:52:45 +0100
X-UD-Smtp-Session: l3s3148p1@Ly0Of4kOTpRehhrQ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] net: phy: micrel: reset KSZ9x31 when resuming
Date: Tue,  9 Jan 2024 21:52:22 +0100
Message-Id: <20240109205223.40219-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a Renesas Ebisu board, the KSZ9031 PHY is stalled after resuming if
the interface has not been brought up before suspending. If it had been
brought up before, phylib ensures that reset is asserted before
suspending. But if it had never been brought up, there is no instance
which could ensure that reset is asserted. And upon resume, the PHY is
in an unknown state without reset being asserted. To bring it back to a
known state, simply reset it when it is about to be resumed.

This likely also helps another issue [1] where a KSZ9131 can be powered
using regulators. After switching power on again in resume, a reset is
also needed.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20211214121638.138784-4-philippe.schenker@toradex.com/

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This is a different solution to a problem I already tried to solve
here[2]. Back then, I added code to the MAC, but I now believe it should
be solved on PHY level. We never saw the problem with other PHYs.
Looking at [1], it seems that KSZ9x31 is also sensitive to being
powered down without reset being asserted. I know it is not a perfect
proof, but I guess these assumptions are all we have.

Philippe, Francesco: do you still have access to machines with this
issue? Could you kindly test if so?

Patch is based on 6.7. Looking forward for comments if this is the
correct layer to tackle the problem. Thanks!


[2] https://lore.kernel.org/all/20230321103357.18940-1-wsa+renesas@sang-engineering.com/

 drivers/net/phy/micrel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 08e3915001c3..c38d7982c06c 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1984,6 +1984,14 @@ static int kszphy_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz9x31_resume(struct phy_device *phydev)
+{
+	phy_device_reset(phydev, 1);
+	phy_device_reset(phydev, 0);
+
+	return kszphy_resume(phydev);
+}
+
 static int kszphy_probe(struct phy_device *phydev)
 {
 	const struct kszphy_type *type = phydev->drv->driver_data;
@@ -4778,7 +4786,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
 	.suspend	= kszphy_suspend,
-	.resume		= kszphy_resume,
+	.resume		= ksz9x31_resume,
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
 }, {
@@ -4851,7 +4859,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
 	.suspend	= kszphy_suspend,
-	.resume		= kszphy_resume,
+	.resume		= ksz9x31_resume,
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
 	.get_features	= ksz9477_get_features,
-- 
2.39.2


