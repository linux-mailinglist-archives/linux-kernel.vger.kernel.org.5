Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241987DADC6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjJ2SoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjJ2SoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:44:15 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580BDF4;
        Sun, 29 Oct 2023 11:44:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A332560186;
        Sun, 29 Oct 2023 19:44:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698605050; bh=lWCoCvbUwweuJllhVc2Ec84nBLwDbguF5xGDvVkqiA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItLZKwEh5QuJQNa21MHspcbicxZ1+MvUztWkwbqtHypzFHAhdJUTfhCfcUPTCtDch
         OtDEP/cymvaZd4mkI57TSrDr7TNamyi+YFE56FafqhKlD0207S2gkPQYHhAuTuvDrO
         gYnLeDCIefuDYO2dfW/wWz8wX8hwvEHX4h7wTn8b2SI4kx5135P0Z6td5OQ+v34m7q
         WAmKvTacH6SmawU2Q+AaO0TyO3MaxxSR8bYc3SGFBywZr4//RiRgKmTe6JGz5fysQr
         0c6/yb5Ior4xkCzCf8brBibhSsP8uH4wEZa/WC7PaLb9PBTdM2PpVObK16lFC/7EHC
         XVDjOuGHs45WA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qBPRaj9kwNHs; Sun, 29 Oct 2023 19:44:08 +0100 (CET)
Received: from defiant.home (78-3-40-247.adsl.net.t-com.hr [78.3.40.247])
        by domac.alu.hr (Postfix) with ESMTPSA id 2427160182;
        Sun, 29 Oct 2023 19:44:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698605048; bh=lWCoCvbUwweuJllhVc2Ec84nBLwDbguF5xGDvVkqiA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxnHPYwqS+I/I2+wn2jv1AIZiOgO2Z9+UthCCwYm3ryH1ttBb61EGGCA1e3alUJEa
         pPNSWPVWp+Rf/Au6alR6nfkdaLhiaOwOffpV6N8Mon9zwT8EGoXIHxaVeQGEv2KJNW
         Y34F+RGpyxneER1gkJeg9i40fRRWX915Jgz9Y2SQSVnrh5Rn0L9nsSqI5DtrsEYYT1
         ZRSdIN+q2iXOcn3kXGW7qqLJssrtT5gYajtnIF5JKrv1DmQPgEmj8uPaaJx6KvVR2I
         t3RHhyUcVWxQBExcY5t4/dl9xl+/nZaiaT6y4i/jkJfLV/t8ZhKmxXYaaSy4jfyCO6
         TcLKyZavVu0lw==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Marco Elver <elver@google.com>
Subject: [PATCH v5 7/7] r8169: Coalesce mac ocp write and modify for rtl_hw_init_8125 to reduce spinlock contention
Date:   Sun, 29 Oct 2023 19:36:07 +0100
Message-Id: <20231029183600.451694-7-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
References: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
the init sequence of the 8125 involve implicit spin_lock_irqsave() and
spin_unlock_irqrestore() on each invocation.

Coalesced with the corresponding helpers r8168_mac_ocp_write_seq() and
r8168_mac_ocp_modify_seq() into sequential write or modidy with a sinqle
pair of spin_lock_irqsave() and spin_unlock_irqrestore(), these calls
reduce overall lock contention.

Fixes: f1bce4ad2f1ce ("r8169: add support for RTL8125")
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
---
v5:
 added unlocked primitives to allow mac ocs modify grouping
 applied coalescing of mac ocp writes/modifies for 8168ep and 8117
 some formatting fixes to please checkpatch.pl

v4:
 fixed complaints as advised by Heiner and checkpatch.pl
 split the patch into five sections to be more easily manipulated and reviewed
 introduced r8168_mac_ocp_write_seq()
 applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B

v3:
 removed register/mask pair array sentinels, so using ARRAY_SIZE().
 avoided duplication of RTL_W32() call code as advised by Heiner.

 drivers/net/ethernet/realtek/r8169_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 0778cd0ba2e0..76f0f1e13909 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5089,6 +5089,12 @@ static void rtl_hw_init_8168g(struct rtl8169_private *tp)
 
 static void rtl_hw_init_8125(struct rtl8169_private *tp)
 {
+	static const struct e_info_regdata hw_init_8125_1[] = {
+		{ 0xc0aa, 0x07d0 },
+		{ 0xc0a6, 0x0150 },
+		{ 0xc01e, 0x5555 },
+	};
+
 	rtl_enable_rxdvgate(tp);
 
 	RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) & ~(CmdTxEnb | CmdRxEnb));
@@ -5098,9 +5104,7 @@ static void rtl_hw_init_8125(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe8de, BIT(14), 0);
 	r8168g_wait_ll_share_fifo_ready(tp);
 
-	r8168_mac_ocp_write(tp, 0xc0aa, 0x07d0);
-	r8168_mac_ocp_write(tp, 0xc0a6, 0x0150);
-	r8168_mac_ocp_write(tp, 0xc01e, 0x5555);
+	r8168_mac_ocp_write_seq(tp, hw_init_8125_1);
 	r8168g_wait_ll_share_fifo_ready(tp);
 }
 
-- 
2.34.1

