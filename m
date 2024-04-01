Return-Path: <linux-kernel+bounces-126980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D27B89455B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8D21C218C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF353360;
	Mon,  1 Apr 2024 19:14:39 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BE7F9DF;
	Mon,  1 Apr 2024 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998879; cv=none; b=H70dkixAJa95aQtKsrv09XirPpneP7kGE7cQ48L6aH4dXKMF7D80Kt934ZqR4TiFJHwKsQvEb3/POSTK4hhKkKmPWGWmmsaV8KOxtDVZmP/Q04KOxDW66DrS09n0X/eWmkFzR0d1VAEohmtExBd4LwSJ63VFyP/d72kGkRGpUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998879; c=relaxed/simple;
	bh=YR6SwtEB9iVv8d+5rPYbn/tSsvDoRzDhnJ5NJNFiXlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BDQ+j6Solqp7p8QyND4STNEJMbHTLU/ZeOgxim8bmgIvSlQwbqCUQibIsRIiODGUxHXlHSuJRGftUJtpCszR/VbWsSY1oeSNejzxlh0f5qhHduxJfxe2u2pKpXsxf9LWJWAA8DvHhf2DFDn6Zu1sEFvFLnGE8rIOXMYTY3AptFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.148] (port=9468 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rrN6s-0004bm-4Y;
	Mon, 01 Apr 2024 22:14:22 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1101.mail.hosting.nic.ru (Exim 5.55)
	with id 1rrN6s-009QGW-0v;
	Mon, 01 Apr 2024 22:14:22 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Michael Chan <mchan@broadcom.com>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net-next v3] tg3: Remove residual error handling in tg3_suspend
Date: Mon,  1 Apr 2024 22:14:18 +0300
Message-Id: <20240401191418.361747-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

As of now, tg3_power_down_prepare always ends with success, but
the error handling code from former tg3_set_power_state call is still here.

This code became unreachable in commit c866b7eac073 ("tg3: Do not use
legacy PCI power management").

Remove (now unreachable) error handling code for simplification and change
tg3_power_down_prepare to a void function as its result is no more checked.

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
---
v3:
  - Change commit message wording as
    Jakub Kicinski <kuba@kernel.org> requested
v2: https://lore.kernel.org/netdev/a6f3f931-17eb-4e53-9220-f81e7b311a8c@ancud.ru/
  - Change tg3_power_down_prepare() to a void function as
    Michael Chan <michael.chan@broadcom.com> suggested
v1: https://lore.kernel.org/netdev/4e7e11f8-03b5-4289-9475-d3b4e105d40a@ancud.ru/
 drivers/net/ethernet/broadcom/tg3.c | 30 ++++-------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 04964bbe08cf..bc36926a57cf 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -4019,7 +4019,7 @@ static int tg3_power_up(struct tg3 *tp)
 
 static int tg3_setup_phy(struct tg3 *, bool);
 
-static int tg3_power_down_prepare(struct tg3 *tp)
+static void tg3_power_down_prepare(struct tg3 *tp)
 {
 	u32 misc_host_ctrl;
 	bool device_should_wake, do_low_power;
@@ -4263,7 +4263,7 @@ static int tg3_power_down_prepare(struct tg3 *tp)
 
 	tg3_ape_driver_state_change(tp, RESET_KIND_SHUTDOWN);
 
-	return 0;
+	return;
 }
 
 static void tg3_power_down(struct tg3 *tp)
@@ -18090,7 +18090,6 @@ static int tg3_suspend(struct device *device)
 {
 	struct net_device *dev = dev_get_drvdata(device);
 	struct tg3 *tp = netdev_priv(dev);
-	int err = 0;
 
 	rtnl_lock();
 
@@ -18114,32 +18113,11 @@ static int tg3_suspend(struct device *device)
 	tg3_flag_clear(tp, INIT_COMPLETE);
 	tg3_full_unlock(tp);
 
-	err = tg3_power_down_prepare(tp);
-	if (err) {
-		int err2;
-
-		tg3_full_lock(tp, 0);
-
-		tg3_flag_set(tp, INIT_COMPLETE);
-		err2 = tg3_restart_hw(tp, true);
-		if (err2)
-			goto out;
-
-		tg3_timer_start(tp);
-
-		netif_device_attach(dev);
-		tg3_netif_start(tp);
-
-out:
-		tg3_full_unlock(tp);
-
-		if (!err2)
-			tg3_phy_start(tp);
-	}
+	tg3_power_down_prepare(tp);
 
 unlock:
 	rtnl_unlock();
-	return err;
+	return 0;
 }
 
 static int tg3_resume(struct device *device)
-- 
2.34.1


