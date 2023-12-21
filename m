Return-Path: <linux-kernel+bounces-7843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F2481AE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A451C22BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D2C8F54;
	Thu, 21 Dec 2023 04:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Jom2FVD6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4F8C00;
	Thu, 21 Dec 2023 04:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (1.general.khfeng.us.vpn [10.172.68.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 822213F190;
	Thu, 21 Dec 2023 04:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703133958;
	bh=Ms5XvmPjSd/k+uCiWY9ikDcpwA4sQ2wt27jGDkni5Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Jom2FVD6ZbpsXTTnIGmxm3zkJeXBMF/EbBcGO8td0JSoYLgrG0X4TJFbA+IQtrFuY
	 hSmZHaFqvuoeqQJqN+ldfcJ0k1w/pNTzLPHjlGqxuk4Y9TKrREhiFGq2eYpIG7HuI2
	 TlLLze9d+ZO/qxyyvlW6rqPoxnb5ieaiAtBmwxLFgqBDIFdglzAvwNo7fT1JoVd0nm
	 FsL4JmDFw/ePBDdFeNBqs1lymQZk4spBJHpEt3hreBrIWEM0sP7V1kh+Wzgq2GnoSm
	 vMG7ZGYxhEF1P42S6MNVOkzD6dGjJTmVuKTEnDBUbyUC1WtBL5NIitAFAuQzZV7nqA
	 MmfpxzP6agpGg==
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
Subject: [PATCH] r8169: Fix PCI error on system resume
Date: Thu, 21 Dec 2023 12:43:50 +0800
Message-Id: <20231221044350.441285-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[  688.051096] r8169 0000:02:00.1 enp2s0f1: rtl_ep_ocp_read_cond == 0 (loop: 10, delay: 10000).
[  688.175131] r8169 0000:02:00.1 enp2s0f1: Link is Down
...
[  691.534611] r8169 0000:02:00.1 enp2s0f1: PCI error (cmd = 0x0407, status_errs = 0x0000)

Since increase the loop wait on rtl_ep_ocp_read_cond can eliminate the
issue, so let rtl8168ep_driver_start() to wait a bit longer.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
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


