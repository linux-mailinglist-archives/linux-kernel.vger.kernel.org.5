Return-Path: <linux-kernel+bounces-130184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FE89751B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFD31F28899
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B520715099C;
	Wed,  3 Apr 2024 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T+d+H1gL"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B092E14F13F;
	Wed,  3 Apr 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161393; cv=none; b=pxmRuKul+qmZAy1YggcsEbNFWP0C8EwXuQvuYfgmH49mfmfqyf/2g434YXmNAQLl/tQb6AXt1X9pC2O94lUU7YWQ4ptrsN2Ax4Wrka9xF92xdqZ9oU4BAHekBNHpWqZpXXjfdvZU6HVkYJOS+duYVhXsWrudhL91yAp3QCuDJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161393; c=relaxed/simple;
	bh=4JxhJtzFlUJ7J6jhZOstSwknN6UF4hCbKXWi39bQteg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SXNMIk4ZtNTXmG35Pqb54kG/yskI1xWtDwhoy7sVHImpQFWocswEpM97NQFCgd14Da6xj0KlieyfzY+4r3ICcTZrED8s6yM6GpYApwZRr/iSlIf1Lj3MxE9XjufSi0Y0qx+Wfj5/0jw4303FXr+lRu1R4PzhvOFw+98yYzBtZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T+d+H1gL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4E7BC20E8CB1;
	Wed,  3 Apr 2024 09:23:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E7BC20E8CB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712161391;
	bh=r+IUSp/rqY0+2Xhato4K1hvCDcdMpatgTirLLrUCDeE=;
	h=From:To:Cc:Subject:Date:From;
	b=T+d+H1gLPOQsaOBde3rNHlo3DBg6hOuFl3vtMo5jphW5zJiO7NyITjISjsejTQMjA
	 FYJGC1KV0yw3ADX5HL3wukaiVxOh8V3+4mcFx+yDZC4R/BMZnTjGTlEXKBe7hOLOc1
	 3KJo6FPXtms2VevW/Ggn1nlMSo9cO5x7uhJG6+M0=
From: Allen Pais <apais@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	keescook@chromium.org,
	m.grzeschik@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH] archnet: Convert from tasklet to BH workqueue
Date: Wed,  3 Apr 2024 16:23:06 +0000
Message-Id: <20240403162306.20258-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws. To
replace tasklets, BH workqueue support was recently added. A BH workqueue
behaves similarly to regular workqueues except that the queued work items
are executed in the BH context.

This patch converts drivers/net/archnet/* from tasklet to BH workqueue.

Based on the work done by Tejun Heo <tj@kernel.org>
Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/arcnet/arcdevice.h |  3 ++-
 drivers/net/arcnet/arcnet.c    | 11 ++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index b54275389f8a..bee60b377d7c 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -16,6 +16,7 @@
 
 #ifdef __KERNEL__
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 
 /*
  * RECON_THRESHOLD is the maximum number of RECON messages to receive
@@ -268,7 +269,7 @@ struct arcnet_local {
 
 	struct net_device *dev;
 	int reply_status;
-	struct tasklet_struct reply_tasklet;
+	struct work_struct reply_work;
 
 	/*
 	 * Buffer management: an ARCnet card has 4 x 512-byte buffers, each of
diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 166bfc3c8e6c..530c15d6a5eb 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -54,6 +54,7 @@
 #include <linux/errqueue.h>
 
 #include <linux/leds.h>
+#include <linux/workqueue.h>
 
 #include "arcdevice.h"
 #include "com9026.h"
@@ -424,9 +425,9 @@ static void reset_device_work(struct work_struct *work)
 	rtnl_unlock();
 }
 
-static void arcnet_reply_tasklet(struct tasklet_struct *t)
+static void arcnet_reply_work(struct work_struct *t)
 {
-	struct arcnet_local *lp = from_tasklet(lp, t, reply_tasklet);
+	struct arcnet_local *lp = from_work(lp, t, reply_work);
 
 	struct sk_buff *ackskb, *skb;
 	struct sock_exterr_skb *serr;
@@ -527,7 +528,7 @@ int arcnet_open(struct net_device *dev)
 		arc_cont(D_PROTO, "\n");
 	}
 
-	tasklet_setup(&lp->reply_tasklet, arcnet_reply_tasklet);
+	INIT_WORK(&lp->reply_work, arcnet_reply_work);
 
 	arc_printk(D_INIT, dev, "arcnet_open: resetting card.\n");
 
@@ -620,7 +621,7 @@ int arcnet_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	netif_carrier_off(dev);
 
-	tasklet_kill(&lp->reply_tasklet);
+	cancel_work_sync(&lp->reply_work);
 
 	/* flush TX and disable RX */
 	lp->hw.intmask(dev, 0);
@@ -984,7 +985,7 @@ irqreturn_t arcnet_interrupt(int irq, void *dev_id)
 						->ack_tx(dev, ackstatus);
 				}
 				lp->reply_status = ackstatus;
-				tasklet_hi_schedule(&lp->reply_tasklet);
+				queue_work(system_bh_highpri_wq, &lp->reply_work);
 			}
 			if (lp->cur_tx != -1)
 				release_arcbuf(dev, lp->cur_tx);
-- 
2.17.1


