Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA68C7DAC14
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 12:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjJ2LMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 07:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2LMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 07:12:22 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E31C6;
        Sun, 29 Oct 2023 04:12:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 178E060182;
        Sun, 29 Oct 2023 12:12:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698577937; bh=Xx9ViACHZVW255zW2vq4zwUoDX0YuwgJy1XCvVN1gGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFyX/nmhWu/BT6Q2NDpt/TVMG95IYlDRKls1iWo3iDkkJEHThDII5DDicb7Z3/Ce8
         LyQzAGTxmcqoneW4J2+TQ7k7tiJae0TgmJe7/GvoRz4fin4JlSGGFErTbKdGBuZyhO
         zxRMP2n589mJPYQ1fmmuHW1B+lK5sjcqOjtzqVnYkkSn3JCwvCzYtac3vaw/gY9+B9
         ZE8yt/yvj2sP7FPFpBG3j6ZlRcjlRcZPf62LxzubCbike0Lmv8sfy1k1OLMEkPbthe
         RkvQ+mAMZDhHfdgMXNdnsuLkotHosOxEEJW0TWAAlLnnQi5TRPJipJcIQciJw53r3r
         /JqjsAx5r1/Kg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2iQHhhvWbuPE; Sun, 29 Oct 2023 12:12:14 +0100 (CET)
Received: from defiant.home (78-3-40-247.adsl.net.t-com.hr [78.3.40.247])
        by domac.alu.hr (Postfix) with ESMTPSA id 91E9D60173;
        Sun, 29 Oct 2023 12:12:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698577934; bh=Xx9ViACHZVW255zW2vq4zwUoDX0YuwgJy1XCvVN1gGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erTsa0mgD/HLpAcnUdMeqRZzwMc4NLw7pbv73Ubk8vgPlUAzwcSGu6C/zfa00WJms
         qS/o9Plhg4qL11m7oFxIBdUFOHU8cPLngPkiP4AhQXtHLU2zZ+V1HC5ei1HcAvIv18
         /Gc7ctU5mjp6gNBoxVXhyGVgqyYfEoVL2YMqfFcjj4dqSAd0UERxQOXEPNI3f4Bmmn
         bXLtYuC+Sv2sEuBPd4SZx6w+vohes0B4u7VnDaqZjWSprcwDylgJHsT65ZFGUTbw1a
         XtXcxcktb5hd2H/jD5hfV6n0XR1cwsZ6AKnuEM+l+2zU9ySTFju7GYBsowE/UPj0PE
         sRcKclb3fjRYg==
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
Subject: [PATCH v4 3/5] r8169: Coalesce mac ocp write and modify for 8168H start to reduce spinlocks
Date:   Sun, 29 Oct 2023 12:04:43 +0100
Message-Id: <20231029110442.347448-3-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
References: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
the startup of 8168H involve implicit spin_lock_irqsave() and spin_unlock_irqrestore()
on each invocation.

Coalesced with the corresponding helpers, r8168_mac_ocp_write_seq() and
r8168_mac_ocp_modify_seq() with a sinqle lock/unlock, these calls reduce overall
lock contention.

Fixes: ef712ede3541d ("r8169: add helper r8168_mac_ocp_modify")
Fixes: 6e1d0b8988188 ("r8169:add support for RTL8168H and RTL8107E")
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
v4:
 fixed complaints as advised by Heiner and checkpatch.pl.
 split the patch into five sections to be more easily manipulated and reviewed
 introduced r8168_mac_ocp_write_seq()
 applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B

v3:
 removed register/mask pair array sentinels, so using ARRAY_SIZE().
 avoided duplication of RTL_W32() call code as advised by Heiner.

 drivers/net/ethernet/realtek/r8169_main.c | 26 +++++++++++++++--------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3dae924a6ca3..cbaac4675bd2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3227,6 +3227,21 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 		{ 0x04, 0xffff,	0x854a },
 		{ 0x01, 0xffff,	0x068b }
 	};
+
+	static const struct e_info_regmaskset e_info_regmaskset_8168h_1[] = {
+		{ 0xe056, 0x00f0, 0x0070 },
+		{ 0xe052, 0x6000, 0x8008 },
+		{ 0xe0d6, 0x01ff, 0x017f },
+		{ 0xd420, 0x0fff, 0x047f },
+	};
+
+	static const struct e_info_regdata e_info_regdata_8168h_1[] = {
+		{ 0xe63e, 0x0001 },
+		{ 0xe63e, 0x0000 },
+		{ 0xc094, 0x0000 },
+		{ 0xc09e, 0x0000 },
+	};
+
 	int rg_saw_cnt;
 
 	rtl_ephy_init(tp, e_info_8168h_1);
@@ -3267,15 +3282,8 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
 	}
 
-	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
-	r8168_mac_ocp_modify(tp, 0xe052, 0x6000, 0x8008);
-	r8168_mac_ocp_modify(tp, 0xe0d6, 0x01ff, 0x017f);
-	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
-
-	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
-	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
-	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
-	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
+	r8168_mac_ocp_modify_seq(tp, e_info_regmaskset_8168h_1);
+	r8168_mac_ocp_write_seq(tp, e_info_regdata_8168h_1);
 }
 
 static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
-- 
2.34.1

