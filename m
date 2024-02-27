Return-Path: <linux-kernel+bounces-83730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D03869DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6411F226B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C0714A4C9;
	Tue, 27 Feb 2024 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAtYfpe6"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4F152E15
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054948; cv=none; b=ZOQm3/L9xKs/9VjQter9QooEVuneuWiymGTIpckKYFabFwO0ih4U1voI1jJ1uNbqS2c9FA27NyFp25xUNI628dixzFj9UfuE4SAo/I8EWQfpOXdBUsByWUhdUFxOJtjx1TNiNWuDlrLY0CyypJDjh3LYnwOK7E7y2+PjpvVHDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054948; c=relaxed/simple;
	bh=nDGxDIbhTaR2385iAsGzN/VEKZ6fYazF2B4H7Rt3wtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHRjVkAC3RgVYyRdFkwA9XF6stwYpT2wdOyRZ0U/jXy0bQ1FU64SeouzFC84sM/ZTKoGU1aJJ6zVilJSDigNhZ5IkB/EJrKukNSxcnmRt0rJJVGrXtzHL9sMgrcr1w2Jy9OOJWElgo6cWjn+Wd4FPFEFxI/PfudTUXv1iBYo764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAtYfpe6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dca1efad59so4257398a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709054946; x=1709659746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znKiBDk/+YyZPZxI19sZt/T09kGaOnS9hAUBe89oizg=;
        b=hAtYfpe6maCwWI7nkMej5Wg4K+PbFvn8jnBL2dsBmRwzub1TtMxIn5OfyUOcjmTABw
         Uypy0qSQNavvLSq8rnuX/M79KQMbipIB+XQF4hJkFmOTQaBQhFurIFtxtcD77PcTMs3W
         VWrC0UCCq1A81yMAo2qLoTy4dH9xjvNEsJkiao3G+wMfrIfoJrDD5udu0PJNkyign/Ti
         1dFOkh5MpmkSnpjziEvsYlcDnTrloYEIiQhT97XQ6lUT+iuOenvH2Q2Gt7Aq41shE+8h
         KwBvK0dNZ6QylQPYgi2g//bEWkAgs+lqB9N4IMMSpHFz2GElG6DZ+W2S42etbq9uTyaV
         BXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054946; x=1709659746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znKiBDk/+YyZPZxI19sZt/T09kGaOnS9hAUBe89oizg=;
        b=h9XM+vErg9OOyeq+uhXaN5kOlleFFbQaL+tAarT/1XckgUlUHZRj86TVU2EHgpqpkW
         k5P92otI2nGHZ6mPuV0xLWrl36RDeEMOWuuCbpM9VDecng+5shEc7j8q1kG8dU5+CKIn
         Wo09Ex043cidqBRh8xqtmoLwKW8yancaQM9GFDcsWV8Gbn76nnUw0BflkwVwRVo3Iw3f
         TjrS6Al03in7JDCaCcgR9eZBC684h+j9X+pIOfe5Hcp6FZlpPFQaylsNjByZSW6hjnQp
         msc8uRGGIr2PpPFGx90i0vR4uRsfPmKK+1EkKfm6O2iWIGcM3H5/3wm4UQAvjzbKRGct
         0vEg==
X-Forwarded-Encrypted: i=1; AJvYcCUAxiIw67/MU/AzkZTAxDhC1i4fY5vp6YAnh5foxjt9ytlaogZzDbSyZw0oSAHc2Qp4FAmia0QyKwGTIN+NtDVsL9K1HU1lIO+S+BkP
X-Gm-Message-State: AOJu0Yxzjisp/PvkzILdqrL9obaqsAeNVVmguy+iU6IHAJYEo+iznK97
	6ogd2VGrZa3TqtQl8xOVMmOd6GwkMMAILEykAxN+P3qRjwFK4NAz
X-Google-Smtp-Source: AGHT+IFkj+Mw5clXxdtZCclQkvmeFtrbGuicLN7eYl1DfWYG99qAXAUPOrywmUjwtmnBTj8z2z43bA==
X-Received: by 2002:a17:902:a386:b0:1dc:ad9d:9e7b with SMTP id x6-20020a170902a38600b001dcad9d9e7bmr4198872pla.59.1709054945777;
        Tue, 27 Feb 2024 09:29:05 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id x21-20020a1709027c1500b001dbc3f2e7e8sm1775141pll.98.2024.02.27.09.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:29:05 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	boqun.feng@gmail.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	romain.perier@gmail.com,
	mingo@kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] r8152: Convert from tasklet to BH workqueue
Date: Tue, 27 Feb 2024 07:28:17 -1000
Message-ID: <20240227172852.2386358-7-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227172852.2386358-1-tj@kernel.org>
References: <20240227172852.2386358-1-tj@kernel.org>
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


