Return-Path: <linux-kernel+bounces-96099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5507875713
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3C51F2469B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096421369A9;
	Thu,  7 Mar 2024 19:24:13 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA48135417;
	Thu,  7 Mar 2024 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839452; cv=none; b=FfA6u7ZKpqqH7RjJqKTg8va5l1fxW49pF92mBWj4Mn7SnzGoxWrMrVZNM4bHeMitHbir46H5mOr8xhQQMAAhY72UUgcBb3etp+TvR1HxUVRuw4bocHeBaI0d74zyMpzLTicuPl1AeRybII6uCPjzUmx/q/GlsElCb8Y/gNS7trU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839452; c=relaxed/simple;
	bh=jFrJQ5q+lLh31/DXkoXXkSOYb6P8Rtp/T0yXSgyT6W8=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=iZTiRF/P3Dv+hIMeiypP+nq0WPdXHWF6YlVAqjluqP1OvoB6TCh7M5US6E3z48sHzuN7zHDBJtSDtn5Ah08hXG3czUQYF/4vU3uY0c3pWBt8Hp7uNBkbP6lZ4gcpTTmYYUu3Fm1E6WKfXFXEEi7uB8kDYNdMPdnkd0PQMJUT6Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.152] (port=10898 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1riJLO-0002QA-4t;
	Thu, 07 Mar 2024 22:23:54 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1riJLO-006yUJ-1R;
	Thu, 07 Mar 2024 22:23:54 +0300
Message-ID: <4e7e11f8-03b5-4289-9475-d3b4e105d40a@ancud.ru>
Date: Thu, 7 Mar 2024 22:23:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] tg3: Remove residual error handling in tg3_suspend
References: <>
Content-Language: en-US
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <mchan@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1


As of now, tg3_power_down_prepare always ends with success, but
the error handling code from former tg3_set_power_state call is still here.

Remove (now unreachable) code for simplification.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c866b7eac073 ("tg3: Do not use legacy PCI power management")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/net/ethernet/broadcom/tg3.c | 26 ++------------------------
  1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c 
b/drivers/net/ethernet/broadcom/tg3.c
index 04964bbe08cf..400451e10f77 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
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


