Return-Path: <linux-kernel+bounces-75218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EFA85E4D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA6E282B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4848595C;
	Wed, 21 Feb 2024 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdawC/qZ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2F85941
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537435; cv=none; b=VIp4fCE+9XR+d1nQgnlaC1l12SQ+5zPm5RrbAkw+4lrPtaXFwURz4Urb9hz7ejXjGSWczu3JdvX9zNAAm+OxsQhBjY6Ub3aNJmVp1AiTeeTzLfAWR9PsqVCn42BWY0xaOyA0Si8L1ht3AfedKCn6jaaGJNvuT7er3BQmFKuYKJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537435; c=relaxed/simple;
	bh=nDGxDIbhTaR2385iAsGzN/VEKZ6fYazF2B4H7Rt3wtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnmN2weZwWzLQZ10Fka5b/jDxP5CAM0RErIkLVfCX/Jk0wP3Kg04jMG2E9FoS9u9BGKK+D8IwGKLOKl6T4qImr4kCPFUverkndRSmqpXIzFhHb6HGO/9O/9EqjQJWRaxlYWMcsvvsmz3A9Mb5Cc6OzRsHkZlGDHajpv8ffcNef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdawC/qZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d932f6ccfaso58133185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708537433; x=1709142233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znKiBDk/+YyZPZxI19sZt/T09kGaOnS9hAUBe89oizg=;
        b=MdawC/qZOx84L2opbGvypjX1H1LQ2ZDt7UcAlR0TGLmi2OXGHvodx8YZDWtfVqRJ+H
         5nI5TlCf+88CCuBNstmyM0eHD1SMRQ9ciwV9v/dUOYM1ogcZmB7HgHFpyltv7HkDB8PD
         ZtAySxptTjG9iKyptCRU1pgvw7OUv7F5U3URL/ABDoBWWpfG8UWonKEfKhwokfVcat/u
         1elWJsNhE5mgR+gwrX/Tf0d6/UjNDRi6Av0HR+mPz0JAElHkrv9UsgsZbc4sjFfEsdwm
         UpUklXHI/H5uw/Z19QWdZH4UbQTOT36+xVhy5ZpxBay+Dj4HvrQrY5hhoythE7Y5HfEU
         i03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537433; x=1709142233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znKiBDk/+YyZPZxI19sZt/T09kGaOnS9hAUBe89oizg=;
        b=QmiO84yeNYiYCSyiFOYGFHD+7g6RstRhYnV9OhcO+NB5w6Fyn5SQW3XtgnA+wueowD
         N/htzZEo960qv3RI/a+A9HQJst2KKslXCKuqX2szzzvB9MocId4OtjE6mf0owbS70pxz
         jZPzUxRAHmtY9UR6zkeWQ6MamHfUshpWvjKparW5urovUc0fzrGyhVzQR43wx7/CpHny
         nf9Aop5KqLZfxw7tbO5/6pVi/BWYpNUAUOIGhyBNC8xoRFRfDlYCax8Q56joFGoT2aYb
         3RqQ3I8s+GBZdlTMOS9jDsUFV87V9zdsvijJe8exnD5Pc2TLISioAFmtzc+dp7gd/4QM
         bQUw==
X-Forwarded-Encrypted: i=1; AJvYcCVtUCBaaqMTpGmRxWQHZL61TSfeac1jUUmTrqjWRu0Vse4k/VNBTPSoCaeer1HOrIYuBdUjyn/LnuvP5u972WMXS7Jbpv/aNoFaPAh6
X-Gm-Message-State: AOJu0YymrAQTyWFNfMlMQYu0eDZBXqSVum0MIbW9CdsPVIIAh583zj2W
	IieVzRgr1insMpLdo+rGNAmHiMBkTBnmOfHcd4LnXSxHpCmW4DzF
X-Google-Smtp-Source: AGHT+IFQIuQlQeBIM3ScQdkxzMkuftZLoJnvrOFKnXM9lVfAGk/ppIFaquV50VnhZrBy+m2vzsyu0g==
X-Received: by 2002:a17:902:e951:b0:1db:aa56:11f7 with SMTP id b17-20020a170902e95100b001dbaa5611f7mr16810187pll.39.1708537433145;
        Wed, 21 Feb 2024 09:43:53 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170902fb4800b001db5ea825b2sm8393814plb.123.2024.02.21.09.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:43:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/7] r8152: Convert from tasklet to BH workqueue
Date: Wed, 21 Feb 2024 07:43:05 -1000
Message-ID: <20240221174333.700197-8-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221174333.700197-1-tj@kernel.org>
References: <20240221174333.700197-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tasklet is being replaced by BH workqueue. No noticeable behavior or
performance changes are expected. The following is how the two APIs map:

- tasklet_setup/init()		-> INIT_WORK()
- tasklet_schedule()		-> queue_work(system_bh_wq, ...)
- tasklet_hi_schedule()		-> queue_work(system_bh_highpri_wq, ...)
- tasklet_disable_nosync()	-> disable_work()
- tasklet_disable[_in_atomic]()	-> disable_work_sync()
- tasklet_enable()		-> enable_work() + queue_work()
- tasklet_kill()		-> cancel_work_sync()

Note that unlike tasklet_enable(), enable_work() doesn't queue the work item
automatically according to whether the work item was queued while disabled.
While the caller can track this separately, unconditionally scheduling the
work item after enable_work() returns %true should work for most users.

r8152 conversion has been tested by repeatedly forcing the device to go
through resets using usbreset under iperf3 generated traffic.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/net/usb/r8152.c | 44 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 9bf2140fd0a1..24e284b9eb38 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -882,7 +882,7 @@ struct r8152 {
 #ifdef CONFIG_PM_SLEEP
 	struct notifier_block pm_notifier;
 #endif
-	struct tasklet_struct tx_tl;
+	struct work_struct tx_work;
 
 	struct rtl_ops {
 		void (*init)(struct r8152 *tp);
@@ -1948,7 +1948,7 @@ static void write_bulk_callback(struct urb *urb)
 		return;
 
 	if (!skb_queue_empty(&tp->tx_queue))
-		tasklet_schedule(&tp->tx_tl);
+		queue_work(system_bh_wq, &tp->tx_work);
 }
 
 static void intr_callback(struct urb *urb)
@@ -2746,9 +2746,9 @@ static void tx_bottom(struct r8152 *tp)
 	} while (res == 0);
 }
 
-static void bottom_half(struct tasklet_struct *t)
+static void bottom_half(struct work_struct *work)
 {
-	struct r8152 *tp = from_tasklet(tp, t, tx_tl);
+	struct r8152 *tp = container_of(work, struct r8152, tx_work);
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
@@ -2942,7 +2942,7 @@ static netdev_tx_t rtl8152_start_xmit(struct sk_buff *skb,
 			schedule_delayed_work(&tp->schedule, 0);
 		} else {
 			usb_mark_last_busy(tp->udev);
-			tasklet_schedule(&tp->tx_tl);
+			queue_work(system_bh_wq, &tp->tx_work);
 		}
 	} else if (skb_queue_len(&tp->tx_queue) > tp->tx_qlen) {
 		netif_stop_queue(netdev);
@@ -6824,11 +6824,12 @@ static void set_carrier(struct r8152 *tp)
 	} else {
 		if (netif_carrier_ok(netdev)) {
 			netif_carrier_off(netdev);
-			tasklet_disable(&tp->tx_tl);
+			disable_work_sync(&tp->tx_work);
 			napi_disable(napi);
 			tp->rtl_ops.disable(tp);
 			napi_enable(napi);
-			tasklet_enable(&tp->tx_tl);
+			enable_work(&tp->tx_work);
+			queue_work(system_bh_wq, &tp->tx_work);
 			netif_info(tp, link, netdev, "carrier off\n");
 		}
 	}
@@ -6864,7 +6865,7 @@ static void rtl_work_func_t(struct work_struct *work)
 	/* don't schedule tasket before linking */
 	if (test_and_clear_bit(SCHEDULE_TASKLET, &tp->flags) &&
 	    netif_carrier_ok(tp->netdev))
-		tasklet_schedule(&tp->tx_tl);
+		queue_work(system_bh_wq, &tp->tx_work);
 
 	if (test_and_clear_bit(RX_EPROTO, &tp->flags) &&
 	    !list_empty(&tp->rx_done))
@@ -6971,7 +6972,7 @@ static int rtl8152_open(struct net_device *netdev)
 		goto out_unlock;
 	}
 	napi_enable(&tp->napi);
-	tasklet_enable(&tp->tx_tl);
+	enable_work(&tp->tx_work);
 
 	mutex_unlock(&tp->control);
 
@@ -6999,7 +7000,7 @@ static int rtl8152_close(struct net_device *netdev)
 #ifdef CONFIG_PM_SLEEP
 	unregister_pm_notifier(&tp->pm_notifier);
 #endif
-	tasklet_disable(&tp->tx_tl);
+	disable_work_sync(&tp->tx_work);
 	clear_bit(WORK_ENABLE, &tp->flags);
 	usb_kill_urb(tp->intr_urb);
 	cancel_delayed_work_sync(&tp->schedule);
@@ -8421,7 +8422,7 @@ static int rtl8152_pre_reset(struct usb_interface *intf)
 		return 0;
 
 	netif_stop_queue(netdev);
-	tasklet_disable(&tp->tx_tl);
+	disable_work_sync(&tp->tx_work);
 	clear_bit(WORK_ENABLE, &tp->flags);
 	usb_kill_urb(tp->intr_urb);
 	cancel_delayed_work_sync(&tp->schedule);
@@ -8466,7 +8467,8 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 	}
 
 	napi_enable(&tp->napi);
-	tasklet_enable(&tp->tx_tl);
+	enable_work(&tp->tx_work);
+	queue_work(system_bh_wq, &tp->tx_work);
 	netif_wake_queue(netdev);
 	usb_submit_urb(tp->intr_urb, GFP_KERNEL);
 
@@ -8625,12 +8627,13 @@ static int rtl8152_system_suspend(struct r8152 *tp)
 
 		clear_bit(WORK_ENABLE, &tp->flags);
 		usb_kill_urb(tp->intr_urb);
-		tasklet_disable(&tp->tx_tl);
+		disable_work_sync(&tp->tx_work);
 		napi_disable(napi);
 		cancel_delayed_work_sync(&tp->schedule);
 		tp->rtl_ops.down(tp);
 		napi_enable(napi);
-		tasklet_enable(&tp->tx_tl);
+		enable_work(&tp->tx_work);
+		queue_work(system_bh_wq, &tp->tx_work);
 	}
 
 	return 0;
@@ -9387,11 +9390,12 @@ static int rtl8152_change_mtu(struct net_device *dev, int new_mtu)
 		if (netif_carrier_ok(dev)) {
 			netif_stop_queue(dev);
 			napi_disable(&tp->napi);
-			tasklet_disable(&tp->tx_tl);
+			disable_work_sync(&tp->tx_work);
 			tp->rtl_ops.disable(tp);
 			tp->rtl_ops.enable(tp);
 			rtl_start_rx(tp);
-			tasklet_enable(&tp->tx_tl);
+			enable_work(&tp->tx_work);
+			queue_work(system_bh_wq, &tp->tx_work);
 			napi_enable(&tp->napi);
 			rtl8152_set_rx_mode(dev);
 			netif_wake_queue(dev);
@@ -9819,8 +9823,8 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 	mutex_init(&tp->control);
 	INIT_DELAYED_WORK(&tp->schedule, rtl_work_func_t);
 	INIT_DELAYED_WORK(&tp->hw_phy_work, rtl_hw_phy_work_func_t);
-	tasklet_setup(&tp->tx_tl, bottom_half);
-	tasklet_disable(&tp->tx_tl);
+	INIT_WORK(&tp->tx_work, bottom_half);
+	disable_work(&tp->tx_work);
 
 	netdev->netdev_ops = &rtl8152_netdev_ops;
 	netdev->watchdog_timeo = RTL8152_TX_TIMEOUT;
@@ -9954,7 +9958,7 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 	unregister_netdev(netdev);
 
 out1:
-	tasklet_kill(&tp->tx_tl);
+	cancel_work_sync(&tp->tx_work);
 	cancel_delayed_work_sync(&tp->hw_phy_work);
 	if (tp->rtl_ops.unload)
 		tp->rtl_ops.unload(tp);
@@ -10010,7 +10014,7 @@ static void rtl8152_disconnect(struct usb_interface *intf)
 		rtl_set_unplug(tp);
 
 		unregister_netdev(tp->netdev);
-		tasklet_kill(&tp->tx_tl);
+		cancel_work_sync(&tp->tx_work);
 		cancel_delayed_work_sync(&tp->hw_phy_work);
 		if (tp->rtl_ops.unload)
 			tp->rtl_ops.unload(tp);
-- 
2.43.2


