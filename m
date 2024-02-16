Return-Path: <linux-kernel+bounces-69135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6CE8584E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9626F285067
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBCE146008;
	Fri, 16 Feb 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9pIx/ug"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9C1468F5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106808; cv=none; b=ALdeQdmWMdEyyla9Y6gSC5topGx2sMMKaxb/4EAqYOFQiQr0lsRQYKnR5OJn6YheZ3J770gBboRXcxONzbZsuy/jRlBvYDPp/GvnWw8uskc9p9nFdenzbVcc+xy87KMFNOqNCr4AcOikVCi6LRPSlKbMII4DW3JFh40FJ+TiZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106808; c=relaxed/simple;
	bh=nDGxDIbhTaR2385iAsGzN/VEKZ6fYazF2B4H7Rt3wtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bd3OA9LS0eLf1fIUqqHgLfNlAtP4x+Nh5wYDPS90uJAsetLf3iZKJU2TX+5Lysudh4cX/VS9o6OM6GZ97dYl2FEtrEZNQytEiqC1EnSF4ZiDCr4SPAwotvg+n/KGrOyoe95HrMsHSKarLroMAcFNSxVQ+OUvWzv8w8y+HR7ku3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9pIx/ug; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e146dcf0b0so412648b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106805; x=1708711605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znKiBDk/+YyZPZxI19sZt/T09kGaOnS9hAUBe89oizg=;
        b=k9pIx/ugoIt20QG9bkv9o6CbPC13piaH+sCfvcGIXrrGjvxeQ/WHOXdzR0M+2uMnmJ
         cExWXXtM7A7e9dzpCxs+ZlSAonEb0U/doDO8e6FEZ2bc4sPnSEEWTf+rGwVtQfAtshT5
         jpyCk5nJBDabiC/rrsGbggD8umjGY6n+1StRYIsZ5zaGdmJvXDLQf/bUSGSSfmbMCtPO
         D5IhLpjE01TZvZWBk3nMkI2btOJjTqq1fiihIt4Z4L4bgY7A43zJHpPj/IgkuuiGprGg
         7M80rPhD4QqG7kNBFo8Pr+YZCqG8LTdU7mQOHeYcgxcPtPd1e6fUdRT2+FUBEvGkZ2Jv
         CVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106805; x=1708711605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znKiBDk/+YyZPZxI19sZt/T09kGaOnS9hAUBe89oizg=;
        b=e/K1nxoUTsngxr9JVhlDwvSp/mBnS/P1lklEFNUoELjpoUVvnzls9Upqg1isyshtXV
         zeDOJaYrPRGWYs055fCeYUHbkSlVa3fsxnAC3GeT0pwtOfJy+qpivvECDrH4aYwC0Ayf
         7P0F0ABfnE3xbsQKz9EQcSRQ0seL9sOEacEwV+Xh1+vSOlEizxOp9aC7rY4lQposL33C
         EGzPM+bwqr0eqQsU8ntmSbsFimNyuHfUiz04T16PJ2dXuvqsuV46NXLkNKYENn5heMka
         nqTxxFe12Ph9EvmZ8y9HuTFgNg/yCRhRet5NCHb4yR+1OcvF55E6gujq9N1QwXlcipuW
         Fisg==
X-Forwarded-Encrypted: i=1; AJvYcCVJo4TCNzkOEaDWsfsU/OsNhjDxrI3g6tFSIAbMhT2s0qSmpvBqI5gHU74LKP1cTGZaHAZLla0SNXCt9nABxj836rnhd8IAMxpWvwue
X-Gm-Message-State: AOJu0Yx4h85gAf4pWOQONjNn0Iuqb0rMt/5BfcPJ7lCoRJBOeThMzzqC
	JLVzWL01kv9rO9/go3fB7VvISTOxltSR9/fWSQC74UURKZb1YzOmqrv53zdmigY=
X-Google-Smtp-Source: AGHT+IHqhiXS/GRh7fFD9SzYc7JX8hcPCGbK6RmS6Gkfzmb98UHxFsazokcuuSmhPwlXG+lg6icRMA==
X-Received: by 2002:aa7:824f:0:b0:6e1:1e05:e0f5 with SMTP id e15-20020aa7824f000000b006e11e05e0f5mr5430985pfn.12.1708106804488;
        Fri, 16 Feb 2024 10:06:44 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id x40-20020a056a0018a800b006e0503f467bsm243908pfh.39.2024.02.16.10.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 17/17] r8152: Convert from tasklet to BH workqueue
Date: Fri, 16 Feb 2024 08:04:58 -1000
Message-ID: <20240216180559.208276-18-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216180559.208276-1-tj@kernel.org>
References: <20240216180559.208276-1-tj@kernel.org>
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


