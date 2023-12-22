Return-Path: <linux-kernel+bounces-9316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE3E81C3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F7A1C20BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F3539F;
	Fri, 22 Dec 2023 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qGy5QGaF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711B5395;
	Fri, 22 Dec 2023 04:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from HP-EliteBook-x360-830-G8-Notebook-PC.. (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A9F334137C;
	Fri, 22 Dec 2023 04:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703219657;
	bh=cq3bS43kQ1OV36R627XQD8f9TpMkA/PC5nZ9emNcAsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=qGy5QGaF7gYWurnr7jkmMMi9LB145iqDV/c8NTEgZ6+iSzvuG/9jSQ4AFGTGh3mv9
	 lZgThBY8uC7bvoGaYSWc6xcoCkHK6xPND4AbPASorMZpuDbe0FbBKxI7aCTN3tvUd+
	 BTlFZNqsGnMIKwwvB3wx24vhmlK3PaM/ZgAl2+LyR/htE7PUnS7LbJCFY0l+B5eYMZ
	 7ox3rw3qzljQRQmtswrNJCcYLx7jf7qE2+re1blk8U3njgfBtm0Ua+Zu9IGoPNCJxB
	 L6pq8fxFGfTTtwaMZGGGrhSeZ1IhHWht1SOGE3sF8212T1EGW5iL9zJJQVvFuZe6x2
	 fxBHk0YNQLn6A==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: hkallweit1@gmail.com,
	nic_swsd@realtek.com
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] r8169: Fix PCI error on system resume
Date: Fri, 22 Dec 2023 12:34:09 +0800
Message-Id: <20231222043410.464730-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some r8168 NICs stop working upon system resume:

[  688.051096] r8169 0000:02:00.1 enp2s0f1: rtl_ep_ocp_read_cond == 0 (loop: 10, delay: 10000).
[  688.175131] r8169 0000:02:00.1 enp2s0f1: Link is Down
...
[  691.534611] r8169 0000:02:00.1 enp2s0f1: PCI error (cmd = 0x0407, status_errs = 0x0000)

Not sure if it's related, but those NICs have a BMC device at function
0:
02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Realtek RealManage BMC [10ec:816e] (rev 1a)

Trial and error shows that increase the loop wait on
rtl_ep_ocp_read_cond to 30 can eliminate the issue, so let
rtl8168ep_driver_start() to wait a bit longer.

Fixes: e6d6ca6e1204 ("r8169: Add support for another RTL8168FP")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Wording
 - Add Fixes tag
 - Denote 'net' in subject

v2:
 - Wording

 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index bb787a52bc75..81fd31f6fac4 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1211,7 +1211,7 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
 {
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
-	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 10);
+	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
 }
 
 static void rtl8168_driver_start(struct rtl8169_private *tp)
-- 
2.34.1


