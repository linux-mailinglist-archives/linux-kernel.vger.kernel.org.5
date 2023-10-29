Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9465B7DADC2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjJ2Snv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjJ2Snt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:43:49 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233B7D3;
        Sun, 29 Oct 2023 11:43:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B166F60182;
        Sun, 29 Oct 2023 19:43:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698605025; bh=WtQ0K7++ytbFBVwISz9KquDCSJEBxV2WigbuQjUKAto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmpvM7s8By0xhPMAWEDqKCod/3e0d+u/QW5C1Gci8lviQyMiNdnS2+gqErs2C7ol8
         zygD0ZJB1cJ3OxBJuDBBygedJHUpqwlYnYxqfFonIVbI07PD7rDpdKgBYXBqPCiqpP
         KHyr6fYaGRUC7MwZlQmBgP85K+kri1Mr/SkEZirJkrxt9KJ/2K4ezIk/624O5v1Jjb
         rrBzh5fZtg1cZYA6QhR/OF8zlRPoW+Yr97IArS5/vZuKGIi+vOTL7jl9pErbBBs5W1
         h/3PASI2AkLyCoqD24Hujne0ibc5DGlvfo0oS6uclSetLgjR+Nwm8wuYsTQsnF2QzP
         9QprPCb2VguIQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6UjbwLRJhPwx; Sun, 29 Oct 2023 19:43:43 +0100 (CET)
Received: from defiant.home (78-3-40-247.adsl.net.t-com.hr [78.3.40.247])
        by domac.alu.hr (Postfix) with ESMTPSA id 2608E60173;
        Sun, 29 Oct 2023 19:43:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698605023; bh=WtQ0K7++ytbFBVwISz9KquDCSJEBxV2WigbuQjUKAto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTrGCIbME3W1vrfK1FslEJ4+oAaUJvWh2dClppr3l1KGBmx+QtQRPPCPCckoJOpp3
         3QWgPPz4ZT/eO4ABt429pIj9jgKyWgmYHDS+PrpDBAwx93N6V/ji6yO0cj9GliWlhb
         CXLrsTOdaIhg3WHpAM/+PoxJMMr+XbV9MUxLXafRre6ekM+O9GFwbP8xCM8ynEIabi
         jW9JKorSpICtAVzhQycyUV03SLWltj0wJmpvcATl+N8iv7RfLVgsZZ7YCm8x3m445E
         k+jMQcphJrt93BP0C/OtxBfoQC+IwuLBn8zUCLtesxsINMz3weHCv3gtqtQyptlGhJ
         W02IYziuhuQEA==
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
Subject: [PATCH v5 5/7] r8169: Reduce spinlock contention for the start of RTL8117
Date:   Sun, 29 Oct 2023 19:36:03 +0100
Message-Id: <20231029183600.451694-5-mirsad.todorovac@alu.unizg.hr>
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

Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify()
in the startup of RTL8168ep involve implicit spin_lock_irqsave() and
spin_unlock_irqrestore() on each invocation.

This is avoided by grouping unlocked __r8168_mac_ocp_write() and
__r8168_mac_ocp_modify() primitives enclosed in the explicit
spin_lock_irqsave()/spin_unlock_irqrestore() pair.

Even if the lock is not contended, the check requires a LOCK CMPXCHG
or a similar instruction, which prevents all cores from accessing the
memory bus.

Fixes: 1287723aa139b ("r8169: add support for RTL8117")
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

 drivers/net/ethernet/realtek/r8169_main.c | 24 ++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 27016aaeb6a0..50fbacb05953 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3348,7 +3348,15 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 		{ 0x19, 0x0040,	0x1100 },
 		{ 0x59, 0x0040,	0x1100 },
 	};
+
+	static const struct e_info_regdata e_info_8117_wr_1[] = {
+		{ 0xe63e, 0x0001 },
+		{ 0xe63e, 0x0000 },
+		{ 0xc094, 0x0000 },
+		{ 0xc09e, 0x0000 },
+	};
 	int rg_saw_cnt;
+	unsigned long flags;
 
 	rtl8168ep_stop_cmac(tp);
 	rtl_ephy_init(tp, e_info_8117);
@@ -3388,15 +3396,13 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
 	}
 
-	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
-	r8168_mac_ocp_write(tp, 0xea80, 0x0003);
-	r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
-	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
-
-	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
-	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
-	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
-	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
+	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	__r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
+	__r8168_mac_ocp_write(tp, 0xea80, 0x0003);
+	__r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
+	__r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
+	__r8168_mac_ocp_write_seq(tp, e_info_8117_wr_1);
+	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
 
 	/* firmware is for MAC only */
 	r8169_apply_firmware(tp);
-- 
2.34.1

