Return-Path: <linux-kernel+bounces-99150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27608878419
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D032F282D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A073E44C6C;
	Mon, 11 Mar 2024 15:45:49 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF43446B8;
	Mon, 11 Mar 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171949; cv=none; b=M7QidVB28BdpBnTKoWRW+ryo9eufZxjkk8X5/yLDclOGPqitFklT7VOQrAuxQv4udZ5/FgMwCLpoKLG2cDiHasZU8gbucAMkuKzmcf1q7iib02XoJb5U7qFTuGljEGvBL5mumuOrQMqJkbiIMHgJiMsLaJNJ8F6bsl9ylC0D7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171949; c=relaxed/simple;
	bh=ZM6xMKvwuswUXIWt85Xm1hwgjLqWcGqZLtRZ6XP/j8o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ntNFhl2YUNoZywz/ABu6I14ILAo+mU0XecNTDWtiURYnYLO5vmlLJSBIMtQ/08MWiTYCdOAKN435epfWWywUvGxgmVmzZDEwmEUBPpInF8wfFy0G77EEI+rGU6oEIzkIb/wSQjnQKPaOJeNgU10Uvnk5petC326Z6rTop2PvC9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.152] (port=33148 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rjhqF-0002ng-3H;
	Mon, 11 Mar 2024 18:45:31 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1rjhqE-003xOp-31;
	Mon, 11 Mar 2024 18:45:30 +0300
Message-ID: <a6f3f931-17eb-4e53-9220-f81e7b311a8c@ancud.ru>
Date: Mon, 11 Mar 2024 18:45:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH v2] tg3: Remove residual error handling in tg3_suspend
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <CACKFLinzJjqe0j4OFkcCV+FyH0JiUpnj3j2azZkGaC9jfvFXrQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACKFLinzJjqe0j4OFkcCV+FyH0JiUpnj3j2azZkGaC9jfvFXrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1


As of now, tg3_power_down_prepare always ends with success, but
the error handling code from former tg3_set_power_state call is still here.

Remove (now unreachable) code for simplification and change
tg3_power_down_prepare to a void function as its result is no more checked.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c866b7eac073 ("tg3: Do not use legacy PCI power management")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
v2: Change tg3_power_down_prepare() to a void function
as Michael Chan <michael.chan@broadcom.com> suggested.
  drivers/net/ethernet/broadcom/tg3.c | 30 ++++-------------------------
  1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c 
b/drivers/net/ethernet/broadcom/tg3.c
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


