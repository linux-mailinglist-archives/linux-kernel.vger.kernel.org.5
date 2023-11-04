Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8947E1152
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 23:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjKDWSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 18:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjKDWSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 18:18:17 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000621718;
        Sat,  4 Nov 2023 15:17:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 4E3B960177;
        Sat,  4 Nov 2023 23:17:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699136273; bh=Q0Y5ACC0TCRNesSVVs/luWSfBi2RlRcN1YXtTxiIoHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uo/2zhce99IOQiAQB8o3zEYcldvA2ncIPBA+/ikrRYGwjNPN94UWrwDuP8YwKZkpJ
         Dl5ZxFG1sTvdnjWbDZKL9VZ6ktGHTfGY/dNWP4b80U/wqAMg3gD5XIp/kqEZzdwl5M
         guAHGqdHhJn90yNzH6Cc8QrjjGs1M5hQ2PH4mFNAHZQ9h1/4JMYkZLdCq2uPuitfdt
         SmYMMT6BUChAGo125vpgnZ5Eh0bbSh6PVbu9I1a0d4eF/dhQea3Rr2IS0C78HWZTtP
         kj7cJ0xD9XsQSiwjOIN/mRdmKAO1OWtNN+GuYMSUkuvA6cYvkDA1Dsr/yQnPrmHmKR
         MnLvMH3e7ndXw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ncAeqU03ugrV; Sat,  4 Nov 2023 23:17:50 +0100 (CET)
Received: from defiant.home (78-2-200-71.adsl.net.t-com.hr [78.2.200.71])
        by domac.alu.hr (Postfix) with ESMTPSA id DF90D60171;
        Sat,  4 Nov 2023 23:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699136270; bh=Q0Y5ACC0TCRNesSVVs/luWSfBi2RlRcN1YXtTxiIoHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BM3qBOKMoe5VTuI8UYLIBq7JC6IuBKQGoRhSdmMNh7Pwa2liVpTLUq+0LKsBH1Kqz
         6LlxO73Px4O9KumghXdf3z2eg8ek6geNewlK4SpvY7/RO5lC9ScrfX8ibzOXnc0co3
         q+A1oD1yORi9PP0jq9Wz9Qw/zl5l+VsZ6ols/jy/PVLPPcdwFnv3+VRtX0YM14wb4z
         h97bU3nVyzS1ySN4B8IhB9JLTAff0g5x4rDYqxKP2EyGAIqB7I8i07iLhnNTcJi015
         AG6c+UpglqsvcHhhv202+kwon+0vUZ8s9XKkbndXVaqoiRkRd/BuqwV9ZcNT9tZ8g+
         P/w0y+vCA3fyw==
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
Subject: [PATCH net-next v6 5/5] r8169: Coalesce mac ocp commands for rtl_hw_init_8125 to reduce spinlocks
Date:   Sat,  4 Nov 2023 23:15:21 +0100
Message-Id: <20231104221514.45821-6-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
References: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
the init sequence of the 8125 involve implicit spin_lock_irqsave() and
spin_unlock_irqrestore() on each invocation.

Coalesced with the corresponding helpers r8168_mac_ocp_write_seq() and
r8168_mac_ocp_modify_seq() into sequential write or modidy with a sinqle lock/unlock,
these calls reduce overall lock contention.

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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 056fe5b3930b..42f0a7486151 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5074,6 +5074,12 @@ static void rtl_hw_init_8168g(struct rtl8169_private *tp)
 
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
@@ -5083,9 +5089,7 @@ static void rtl_hw_init_8125(struct rtl8169_private *tp)
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

