Return-Path: <linux-kernel+bounces-72445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B785B358
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5731C210ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DCF5A0F7;
	Tue, 20 Feb 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vMWloydP"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E153812;
	Tue, 20 Feb 2024 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412448; cv=none; b=Kh1R8Ak+hUxtHp0N4MH16RTxsgvGJtMoScPqujtVej0VAh3FYipOCws2L6jTFSEe6zKqM49u2MO1lLbOYSGZBEH5ychT8p9+js3kthq3+8I3XEwb8HPseNr1ZhuJ9QjncL/QYVasRJWqZSAT+BUrHGq71Qm5f8BAEyjmOvGAJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412448; c=relaxed/simple;
	bh=jxIlQYigUmHuOaov+aiNZ47WFgeZO8qV3VlbmDtBFLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ewSqBtWHBCb/l+Ml5gJWXLoCvYwhk5NFUzlZb5D0yGi03OJUDq6v9mfwzlJbsrkH3iGqB5WOKmZiDmAJsSNhFonMdvAwPvmKDORXVU6a3fl75JP2IS7tXKJ0EQ8QVAmNt0CW0q/LJWwOHyk4rojuJ76q6eyljIHyN0XXJlLJN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vMWloydP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K70Dja099600;
	Tue, 20 Feb 2024 01:00:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708412413;
	bh=eOu4aLrM1YRAOvpL6/4U7J43lEjo9JIYMBbcRY42UAE=;
	h=From:To:CC:Subject:Date;
	b=vMWloydP6ErKhsvUPQuMt0hrQgYukHQ23sX+50dmpC8cPe9RXmu5aQYFhH6XeO9Tb
	 rQOiarsVowLrA8pvVZV0fSKtB2SyGcIZOx5UolMt7DkHPsqEKN2dDZNmY5MduhRA4P
	 buNvqZDSMIDpDQp+v3NK48lJB96ufEkg1QEKwKjA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K70DYH029934
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 01:00:13 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 01:00:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 01:00:12 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K708WG049784;
	Tue, 20 Feb 2024 01:00:09 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <xiaoning.wang@nxp.com>, <wei.fang@nxp.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH net] net: phy: realtek: Fix rtl8211f_config_init() for RTL8211F(D)(I)-VD-CG PHY
Date: Tue, 20 Feb 2024 12:30:07 +0530
Message-ID: <20240220070007.968762-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Commit bb726b753f75 ("net: phy: realtek: add support for
RTL8211F(D)(I)-VD-CG") extended support of the driver from the existing
support for RTL8211F(D)(I)-CG PHY to the newer RTL8211F(D)(I)-VD-CG PHY.

While that commit indicated that the RTL8211F_PHYCR2 register is not
supported by the "VD-CG" PHY model and therefore updated the corresponding
section in rtl8211f_config_init() to be invoked conditionally, the call to
"genphy_soft_reset()" was left as-is, when it should have also been invoked
conditionally. This is because the call to "genphy_soft_reset()" was first
introduced by the commit 0a4355c2b7f8 ("net: phy: realtek: add dt property
to disable CLKOUT clock") since the RTL8211F guide indicates that a PHY
reset should be issued after setting bits in the PHYCR2 register.

As the PHYCR2 register is not applicable to the "VD-CG" PHY model, fix the
rtl8211f_config_init() function by invoking "genphy_soft_reset()"
conditionally based on the presence of the "PHYCR2" register.

Fixes: bb726b753f75 ("net: phy: realtek: add support for RTL8211F(D)(I)-VD-CG")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on Linux 6.8-rc5.

Regards,
Siddharth.

 drivers/net/phy/realtek.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 481c79fbd6eb..1fa70427b2a2 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -413,9 +413,11 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 				ERR_PTR(ret));
 			return ret;
 		}
+
+		return genphy_soft_reset(phydev);
 	}
 
-	return genphy_soft_reset(phydev);
+	return 0;
 }
 
 static int rtl821x_suspend(struct phy_device *phydev)
-- 
2.34.1


