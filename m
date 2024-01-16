Return-Path: <linux-kernel+bounces-27791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0B82F5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8550F1C2410D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028242262F;
	Tue, 16 Jan 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DePdQQ0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105D722609;
	Tue, 16 Jan 2024 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434205; cv=none; b=UPXjfxKr+cXuQRY5pqCj1gDmGadWW6vdNGY2JM3+em5UgjRjjfMWpIsJLZD1jX49rAAoKU9//uzqCD0yrsadHgaYPUQ6v25tKWhh1sQz36xzHsNdJJ803JK8vbwfCNoy1bDg400iswYTVoHCx9nh4xO7dK/Dt+HyYP5hbTTj8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434205; c=relaxed/simple;
	bh=JQTSvyhGhyIvw5sMNaIm/ldCP9cT/YgtoiaApiRMfb0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=LqPryQJmqtNDpwaX8xH5N3W+6BB2btDoLAAmluveMaM0Jir2UYlpwETFu2t9voVzVU6/sChS2voGWDWgVClGwDkaEMAgYF2sFLjyzSt3yjKO15rPNNAQjhtpOLA/LarB46M+MxJcJpjKAdp9YnViszcRXT3JuWmALgKujr+Wm+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DePdQQ0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2484AC433B1;
	Tue, 16 Jan 2024 19:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434204;
	bh=JQTSvyhGhyIvw5sMNaIm/ldCP9cT/YgtoiaApiRMfb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DePdQQ0F2/AUiPtUsL9z2uQbs2ttHKjH23gZQjMWF3LICILBdmX62+f/xxlmMMoWy
	 FdgvpJl9HQ4VKcnlPhUQSd2ptYI4vY0tcjeyeVqZfnbm3ZNLOdFwqG2IjREt3709+r
	 CPBgMovjEh3wCXn1fYxVzeZj/CnUfDk7WbTtyLiakOkvYNcOH17nedDkvjGYdQRx8p
	 dfS7lDM7cUYlDE2KsrzyA4N72dVBaRwdoRpLm/CL+vBIzGDcgSpdLaVYu8oCadB/TW
	 37KCoxdEheE3LoGskMu7FQ9yflTh4rEVlZolYckKsOfzMl5fEbusXRH7bD1k4uUv7l
	 1k/bLNKV4rghg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	nic_swsd@realtek.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 021/108] r8169: improve RTL8411b phy-down fixup
Date: Tue, 16 Jan 2024 14:38:47 -0500
Message-ID: <20240116194225.250921-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 055dd7511f675d26fa283b35bb3dadfc7f77ed97 ]

Mirsad proposed a patch to reduce the number of spinlock lock/unlock
operations and the function code size. This can be further improved
because the function sets a consecutive register block.

Suggested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 139 +++++-----------------
 1 file changed, 28 insertions(+), 111 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 81fd31f6fac4..1664ca8fa14f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3106,6 +3106,33 @@ static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
 	rtl_ephy_init(tp, e_info_8168g_2);
 }
 
+static void rtl8411b_fix_phy_down(struct rtl8169_private *tp)
+{
+	static const u16 fix_data[] = {
+/* 0xf800 */ 0xe008, 0xe00a, 0xe00c, 0xe00e, 0xe027, 0xe04f, 0xe05e, 0xe065,
+/* 0xf810 */ 0xc602, 0xbe00, 0x0000, 0xc502, 0xbd00, 0x074c, 0xc302, 0xbb00,
+/* 0xf820 */ 0x080a, 0x6420, 0x48c2, 0x8c20, 0xc516, 0x64a4, 0x49c0, 0xf009,
+/* 0xf830 */ 0x74a2, 0x8ca5, 0x74a0, 0xc50e, 0x9ca2, 0x1c11, 0x9ca0, 0xe006,
+/* 0xf840 */ 0x74f8, 0x48c4, 0x8cf8, 0xc404, 0xbc00, 0xc403, 0xbc00, 0x0bf2,
+/* 0xf850 */ 0x0c0a, 0xe434, 0xd3c0, 0x49d9, 0xf01f, 0xc526, 0x64a5, 0x1400,
+/* 0xf860 */ 0xf007, 0x0c01, 0x8ca5, 0x1c15, 0xc51b, 0x9ca0, 0xe013, 0xc519,
+/* 0xf870 */ 0x74a0, 0x48c4, 0x8ca0, 0xc516, 0x74a4, 0x48c8, 0x48ca, 0x9ca4,
+/* 0xf880 */ 0xc512, 0x1b00, 0x9ba0, 0x1b1c, 0x483f, 0x9ba2, 0x1b04, 0xc508,
+/* 0xf890 */ 0x9ba0, 0xc505, 0xbd00, 0xc502, 0xbd00, 0x0300, 0x051e, 0xe434,
+/* 0xf8a0 */ 0xe018, 0xe092, 0xde20, 0xd3c0, 0xc50f, 0x76a4, 0x49e3, 0xf007,
+/* 0xf8b0 */ 0x49c0, 0xf103, 0xc607, 0xbe00, 0xc606, 0xbe00, 0xc602, 0xbe00,
+/* 0xf8c0 */ 0x0c4c, 0x0c28, 0x0c2c, 0xdc00, 0xc707, 0x1d00, 0x8de2, 0x48c1,
+/* 0xf8d0 */ 0xc502, 0xbd00, 0x00aa, 0xe0c0, 0xc502, 0xbd00, 0x0132
+	};
+	unsigned long flags;
+	int i;
+
+	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	for (i = 0; i < ARRAY_SIZE(fix_data); i++)
+		__r8168_mac_ocp_write(tp, 0xf800 + 2 * i, fix_data[i]);
+	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
+}
+
 static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
 {
 	static const struct ephy_info e_info_8411_2[] = {
@@ -3139,117 +3166,7 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
 	mdelay(3);
 	r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
 
-	r8168_mac_ocp_write(tp, 0xF800, 0xE008);
-	r8168_mac_ocp_write(tp, 0xF802, 0xE00A);
-	r8168_mac_ocp_write(tp, 0xF804, 0xE00C);
-	r8168_mac_ocp_write(tp, 0xF806, 0xE00E);
-	r8168_mac_ocp_write(tp, 0xF808, 0xE027);
-	r8168_mac_ocp_write(tp, 0xF80A, 0xE04F);
-	r8168_mac_ocp_write(tp, 0xF80C, 0xE05E);
-	r8168_mac_ocp_write(tp, 0xF80E, 0xE065);
-	r8168_mac_ocp_write(tp, 0xF810, 0xC602);
-	r8168_mac_ocp_write(tp, 0xF812, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF814, 0x0000);
-	r8168_mac_ocp_write(tp, 0xF816, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF818, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF81A, 0x074C);
-	r8168_mac_ocp_write(tp, 0xF81C, 0xC302);
-	r8168_mac_ocp_write(tp, 0xF81E, 0xBB00);
-	r8168_mac_ocp_write(tp, 0xF820, 0x080A);
-	r8168_mac_ocp_write(tp, 0xF822, 0x6420);
-	r8168_mac_ocp_write(tp, 0xF824, 0x48C2);
-	r8168_mac_ocp_write(tp, 0xF826, 0x8C20);
-	r8168_mac_ocp_write(tp, 0xF828, 0xC516);
-	r8168_mac_ocp_write(tp, 0xF82A, 0x64A4);
-	r8168_mac_ocp_write(tp, 0xF82C, 0x49C0);
-	r8168_mac_ocp_write(tp, 0xF82E, 0xF009);
-	r8168_mac_ocp_write(tp, 0xF830, 0x74A2);
-	r8168_mac_ocp_write(tp, 0xF832, 0x8CA5);
-	r8168_mac_ocp_write(tp, 0xF834, 0x74A0);
-	r8168_mac_ocp_write(tp, 0xF836, 0xC50E);
-	r8168_mac_ocp_write(tp, 0xF838, 0x9CA2);
-	r8168_mac_ocp_write(tp, 0xF83A, 0x1C11);
-	r8168_mac_ocp_write(tp, 0xF83C, 0x9CA0);
-	r8168_mac_ocp_write(tp, 0xF83E, 0xE006);
-	r8168_mac_ocp_write(tp, 0xF840, 0x74F8);
-	r8168_mac_ocp_write(tp, 0xF842, 0x48C4);
-	r8168_mac_ocp_write(tp, 0xF844, 0x8CF8);
-	r8168_mac_ocp_write(tp, 0xF846, 0xC404);
-	r8168_mac_ocp_write(tp, 0xF848, 0xBC00);
-	r8168_mac_ocp_write(tp, 0xF84A, 0xC403);
-	r8168_mac_ocp_write(tp, 0xF84C, 0xBC00);
-	r8168_mac_ocp_write(tp, 0xF84E, 0x0BF2);
-	r8168_mac_ocp_write(tp, 0xF850, 0x0C0A);
-	r8168_mac_ocp_write(tp, 0xF852, 0xE434);
-	r8168_mac_ocp_write(tp, 0xF854, 0xD3C0);
-	r8168_mac_ocp_write(tp, 0xF856, 0x49D9);
-	r8168_mac_ocp_write(tp, 0xF858, 0xF01F);
-	r8168_mac_ocp_write(tp, 0xF85A, 0xC526);
-	r8168_mac_ocp_write(tp, 0xF85C, 0x64A5);
-	r8168_mac_ocp_write(tp, 0xF85E, 0x1400);
-	r8168_mac_ocp_write(tp, 0xF860, 0xF007);
-	r8168_mac_ocp_write(tp, 0xF862, 0x0C01);
-	r8168_mac_ocp_write(tp, 0xF864, 0x8CA5);
-	r8168_mac_ocp_write(tp, 0xF866, 0x1C15);
-	r8168_mac_ocp_write(tp, 0xF868, 0xC51B);
-	r8168_mac_ocp_write(tp, 0xF86A, 0x9CA0);
-	r8168_mac_ocp_write(tp, 0xF86C, 0xE013);
-	r8168_mac_ocp_write(tp, 0xF86E, 0xC519);
-	r8168_mac_ocp_write(tp, 0xF870, 0x74A0);
-	r8168_mac_ocp_write(tp, 0xF872, 0x48C4);
-	r8168_mac_ocp_write(tp, 0xF874, 0x8CA0);
-	r8168_mac_ocp_write(tp, 0xF876, 0xC516);
-	r8168_mac_ocp_write(tp, 0xF878, 0x74A4);
-	r8168_mac_ocp_write(tp, 0xF87A, 0x48C8);
-	r8168_mac_ocp_write(tp, 0xF87C, 0x48CA);
-	r8168_mac_ocp_write(tp, 0xF87E, 0x9CA4);
-	r8168_mac_ocp_write(tp, 0xF880, 0xC512);
-	r8168_mac_ocp_write(tp, 0xF882, 0x1B00);
-	r8168_mac_ocp_write(tp, 0xF884, 0x9BA0);
-	r8168_mac_ocp_write(tp, 0xF886, 0x1B1C);
-	r8168_mac_ocp_write(tp, 0xF888, 0x483F);
-	r8168_mac_ocp_write(tp, 0xF88A, 0x9BA2);
-	r8168_mac_ocp_write(tp, 0xF88C, 0x1B04);
-	r8168_mac_ocp_write(tp, 0xF88E, 0xC508);
-	r8168_mac_ocp_write(tp, 0xF890, 0x9BA0);
-	r8168_mac_ocp_write(tp, 0xF892, 0xC505);
-	r8168_mac_ocp_write(tp, 0xF894, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF896, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF898, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF89A, 0x0300);
-	r8168_mac_ocp_write(tp, 0xF89C, 0x051E);
-	r8168_mac_ocp_write(tp, 0xF89E, 0xE434);
-	r8168_mac_ocp_write(tp, 0xF8A0, 0xE018);
-	r8168_mac_ocp_write(tp, 0xF8A2, 0xE092);
-	r8168_mac_ocp_write(tp, 0xF8A4, 0xDE20);
-	r8168_mac_ocp_write(tp, 0xF8A6, 0xD3C0);
-	r8168_mac_ocp_write(tp, 0xF8A8, 0xC50F);
-	r8168_mac_ocp_write(tp, 0xF8AA, 0x76A4);
-	r8168_mac_ocp_write(tp, 0xF8AC, 0x49E3);
-	r8168_mac_ocp_write(tp, 0xF8AE, 0xF007);
-	r8168_mac_ocp_write(tp, 0xF8B0, 0x49C0);
-	r8168_mac_ocp_write(tp, 0xF8B2, 0xF103);
-	r8168_mac_ocp_write(tp, 0xF8B4, 0xC607);
-	r8168_mac_ocp_write(tp, 0xF8B6, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF8B8, 0xC606);
-	r8168_mac_ocp_write(tp, 0xF8BA, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF8BC, 0xC602);
-	r8168_mac_ocp_write(tp, 0xF8BE, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF8C0, 0x0C4C);
-	r8168_mac_ocp_write(tp, 0xF8C2, 0x0C28);
-	r8168_mac_ocp_write(tp, 0xF8C4, 0x0C2C);
-	r8168_mac_ocp_write(tp, 0xF8C6, 0xDC00);
-	r8168_mac_ocp_write(tp, 0xF8C8, 0xC707);
-	r8168_mac_ocp_write(tp, 0xF8CA, 0x1D00);
-	r8168_mac_ocp_write(tp, 0xF8CC, 0x8DE2);
-	r8168_mac_ocp_write(tp, 0xF8CE, 0x48C1);
-	r8168_mac_ocp_write(tp, 0xF8D0, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF8D2, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF8D4, 0x00AA);
-	r8168_mac_ocp_write(tp, 0xF8D6, 0xE0C0);
-	r8168_mac_ocp_write(tp, 0xF8D8, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF8DA, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF8DC, 0x0132);
+	rtl8411b_fix_phy_down(tp);
 
 	r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
 
-- 
2.43.0


