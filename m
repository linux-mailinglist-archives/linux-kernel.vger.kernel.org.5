Return-Path: <linux-kernel+bounces-119693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9115888CC1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29591325F97
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C539B129A6B;
	Tue, 26 Mar 2024 18:36:28 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19AE3A8D0;
	Tue, 26 Mar 2024 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478188; cv=none; b=Duerj2upjLj+AiJJ5cFOhMk8QFIH7pBWqq8hTjnVFakGle0n8gDLV6BptzAje71n8NXMw/186PdxGl2PH8H90tDY3zQoQSe5BffFsMy9YYgIGMeiKW27of0tgx9BDRzPxwlEm0Z/S0QTb0ZNR95vpFVe0fURd4odBQn2cqjDyBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478188; c=relaxed/simple;
	bh=mDWXRQ8ZzX76CYWDD/Ykq1EyZvATxuBthrWSTS+LGWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoGlqaExB6ugDXsEuHaoccWWK5EEIymv8EYlW/8kyp3x5g4Nt7YbXgIi0X3ZGc8VEn4xXFUwB1IZr5WSRHfQmKh7F2FLZehab+WAlmGp8eHOTexJEjvDynfqXeGMxGsVkp9w0cbaIqRN+Bw+HSMut0R3XZ1f5+k1kmqSad5OAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.136.255] (port=4158 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rpBeh-00037a-6Q;
	Tue, 26 Mar 2024 21:36:16 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1105.mail.hosting.nic.ru (Exim 5.55)
	with id 1rpBeh-002Uj1-2q;
	Tue, 26 Mar 2024 21:36:15 +0300
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
Subject: [PATCH net-next v2] tg3: Remove residual error handling in tg3_suspend
Date: Tue, 26 Mar 2024 21:35:44 +0300
Message-Id: <20240326183544.488242-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACKFLikPmtbkvVFerB0WNvLN3w=ia_vd6fUAo8iWpAqNsegMaQ@mail.gmail.com>
References: 
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

Remove (now unreachable) code for simplification and change
tg3_power_down_prepare to a void function as its result is no more checked.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c866b7eac073 ("tg3: Do not use legacy PCI power management")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Change tg3_power_down_prepare() to a void function
as Michael Chan <michael.chan@broadcom.com> suggested.
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


