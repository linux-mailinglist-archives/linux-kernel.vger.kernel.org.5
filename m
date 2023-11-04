Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C37A7E1151
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 23:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjKDWST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 18:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjKDWSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 18:18:16 -0400
Received: from domac.alu.hr (unknown [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B903A10DE;
        Sat,  4 Nov 2023 15:17:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 681D26016E;
        Sat,  4 Nov 2023 23:17:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699136265; bh=afuU7Prqj4wOBRLyInMGwaCWEP50viSnxn1+X6zq8OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teoOEoJwaIFLTMbt+esAYqsyDhjbMbppoq7N18uZTdd36itghdKot/TJ3wtQWvrPu
         tScbMa0hCXnxaXMo7DNKCpQVIpKYs6jv6dPQQxPJp7PGm6jDMhLDzNwaSO0P2VNac0
         Xl2xBD2nMWvJkKT9cq8M0LEMWpfPKymKGVtOSkwepbldMUGVCRTD0AOiFVpfS5Qo23
         jfNhjENc4h16z4dos5rDVzs+r9NaNRB9YzCOEQMyBd4sGIqRROCGDyz0oOvlGLzuRM
         9H3ROOKtRnr4bouEIFXFOsVVCtoza6lBRMCjBoEs/fbM8tzwGDAwO1NOB/WHWxMq2K
         N3pbuOiL8F2Fw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JHWuG4qTpnak; Sat,  4 Nov 2023 23:17:43 +0100 (CET)
Received: from defiant.home (78-2-200-71.adsl.net.t-com.hr [78.2.200.71])
        by domac.alu.hr (Postfix) with ESMTPSA id 83BD460177;
        Sat,  4 Nov 2023 23:17:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699136262; bh=afuU7Prqj4wOBRLyInMGwaCWEP50viSnxn1+X6zq8OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HU1gKuTMJn7yZh/M4rdgA30WcfIqWkfeW8sP2RZm6t21k4B/+Q6Km7HPKRWT7f1H0
         5422PWSFYZzmPtlijSU4Bx2lKpCQOvIxiPMviKhwgLYM/8ej6HvOZmKeRqdwXK77eh
         zuZfFJJ/8jsSa59SbLY9qkYOshFhN2DQkQETDv26w39QVJoo7iI5LmImfaMYOjAiJm
         azxvID2kr7+mRJFiGGRXGpYn6OxCGXk7TOwUOnbWX52F2fG8CUQzFE95Bwcxz/dLJ/
         SxDNKSss5mxGbKcxHpiWfoVtvj5Vfol299uMFh3EeAOGZbajfpwfZ+QchPolieK5jy
         36RA+mO13mivw==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Marco Elver <elver@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v6 4/5] r8169: Coalesce mac ocp commands for 8125 and 8125B start to reduce spinlock contention
Date:   Sat,  4 Nov 2023 23:15:19 +0100
Message-Id: <20231104221514.45821-5-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
References: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
the startup of 8125 and 8125B involve implicit spin_lock_irqsave() and
spin_unlock_irqrestore() on each invocation.

Coalesced with the corresponding helpers r8168_mac_ocp_write_seq() and
r8168_mac_ocp_modify_seq() into sequential write or modidy with a sinqle lock/unlock,
these calls reduce overall lock contention.

Fixes: f1bce4ad2f1ce ("r8169: add support for RTL8125")
Fixes: 0439297be9511 ("r8169: add support for RTL8125B")
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Marco Elver <elver@google.com>
Cc: nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 38 ++++++++++++++---------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 0fb34d217205..056fe5b3930b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3539,6 +3539,27 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
 
 static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 {
+
+	static const struct e_info_regmaskset e_info_8125_common_1[] = {
+		{ 0xd3e2, 0x0fff, 0x03a9 },
+		{ 0xd3e4, 0x00ff, 0x0000 },
+		{ 0xe860, 0x0000, 0x0080 },
+	};
+
+	static const struct e_info_regmaskset e_info_8125_common_2[] = {
+		{ 0xc0b4, 0x0000, 0x000c },
+		{ 0xeb6a, 0x00ff, 0x0033 },
+		{ 0xeb50, 0x03e0, 0x0040 },
+		{ 0xe056, 0x00f0, 0x0030 },
+		{ 0xe040, 0x1000, 0x0000 },
+		{ 0xea1c, 0x0003, 0x0001 },
+		{ 0xe0c0, 0x4f0f, 0x4403 },
+		{ 0xe052, 0x0080, 0x0068 },
+		{ 0xd430, 0x0fff, 0x047f },
+		{ 0xea1c, 0x0004, 0x0000 },
+		{ 0xeb54, 0x0000, 0x0001 },
+	};
+
 	rtl_pcie_state_l2l3_disable(tp);
 
 	RTL_W16(tp, 0x382, 0x221b);
@@ -3553,9 +3574,7 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	r8168_mac_ocp_write(tp, 0xc140, 0xffff);
 	r8168_mac_ocp_write(tp, 0xc142, 0xffff);
 
-	r8168_mac_ocp_modify(tp, 0xd3e2, 0x0fff, 0x03a9);
-	r8168_mac_ocp_modify(tp, 0xd3e4, 0x00ff, 0x0000);
-	r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
+	r8168_mac_ocp_modify_seq(tp, e_info_8125_common_1);
 
 	/* disable new tx descriptor format */
 	r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
@@ -3570,18 +3589,7 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	else
 		r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0020);
 
-	r8168_mac_ocp_modify(tp, 0xc0b4, 0x0000, 0x000c);
-	r8168_mac_ocp_modify(tp, 0xeb6a, 0x00ff, 0x0033);
-	r8168_mac_ocp_modify(tp, 0xeb50, 0x03e0, 0x0040);
-	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
-	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
-	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
-	r8168_mac_ocp_modify(tp, 0xe0c0, 0x4f0f, 0x4403);
-	r8168_mac_ocp_modify(tp, 0xe052, 0x0080, 0x0068);
-	r8168_mac_ocp_modify(tp, 0xd430, 0x0fff, 0x047f);
-
-	r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
-	r8168_mac_ocp_modify(tp, 0xeb54, 0x0000, 0x0001);
+	r8168_mac_ocp_modify_seq(tp, e_info_8125_common_2);
 	udelay(1);
 	r8168_mac_ocp_modify(tp, 0xeb54, 0x0001, 0x0000);
 	RTL_W16(tp, 0x1880, RTL_R16(tp, 0x1880) & ~0x0030);
-- 
2.34.1

