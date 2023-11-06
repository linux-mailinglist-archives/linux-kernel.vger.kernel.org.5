Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E4E7E2633
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjKFN6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjKFN6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:58:31 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DBABF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:58:28 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ce279b7033so6326885a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699279107; x=1699883907;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmJ5nIlMxF28FJhyykq3vMhb+/ix0tM1zEFy6b8QVYk=;
        b=qBKdT9ZDkGehbQgbONpe4SBImg49xEjcvbfBel7NumP8zGNOGE8rVN55b29LD3xevm
         HQeTZVtCAwPZklxxbBbhraxNA/Pb2PJb2veRfPT5JoNvRNrbQaSw5OAOXOjDRtbnyJ0L
         qH5lFHxzsI4OXTPEmFZ6fVqp6410UX41fkKtmITOvCefy4SY6169EJhcakMcAgTW03bw
         5GYXvHRKQBMiLtBwnsQZ6EG+rruYno6kFs6NWdVYXhD4MJ+PfnQUF8FDHuSBqsTJVk+y
         M8GAyejQd1NIw53GddOFfW+X0r8GR0riNz2o/oYaTvqIDnssYWzY0po99b84h+GZP+dO
         ZBlg==
X-Gm-Message-State: AOJu0YwXB3kqAQS0aAX0qjMtpbzUfXTrL9PXC0ePdmchB08kjYuvA7Ez
        A1vPv+ZnQjofSJs+2tRfNbP+V7hCT8kEJ1oCE0HBaJXFCS4+EjM=
X-Google-Smtp-Source: AGHT+IGJlGdvinj4mr3yhNKM7KheutmiblZYqiheT61vmHetUkc5rkKmuoLRMJj7C+d9PJmZroXrBeQmXPi0mUdjMkYwJprqUvNs
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1249:b0:6b2:a87b:e441 with SMTP id
 s9-20020a056830124900b006b2a87be441mr7973161otp.3.1699279107771; Mon, 06 Nov
 2023 05:58:27 -0800 (PST)
Date:   Mon, 06 Nov 2023 05:58:27 -0800
In-Reply-To: <000000000000910ad106089f45eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097d22506097c3fce@google.com>
Subject: Re: [syzbot] [PATCH] Test for 2030579113a1
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Test for 2030579113a1
Author: eadavis@qq.com

please test BUG: corrupted list in ptp_open

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 2dac75696c6d

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..473b6d992507 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -108,6 +108,7 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 	char debugfsname[32];
+	unsigned long flags;
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
@@ -119,7 +120,9 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 	}
 	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
+	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
+	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 	pccontext->private_clkdata = queue;
 
 	/* Debugfs contents */
@@ -139,16 +142,16 @@ int ptp_release(struct posix_clock_context *pccontext)
 {
 	struct timestamp_event_queue *queue = pccontext->private_clkdata;
 	unsigned long flags;
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 
-	if (queue) {
-		debugfs_remove(queue->debugfs_instance);
-		pccontext->private_clkdata = NULL;
-		spin_lock_irqsave(&queue->lock, flags);
-		list_del(&queue->qlist);
-		spin_unlock_irqrestore(&queue->lock, flags);
-		bitmap_free(queue->mask);
-		kfree(queue);
-	}
+	debugfs_remove(queue->debugfs_instance);
+	pccontext->private_clkdata = NULL;
+	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
+	list_del(&queue->qlist);
+	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
+	bitmap_free(queue->mask);
+	kfree(queue);
 	return 0;
 }
 
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3d1b0a97301c..b901f2910963 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -179,11 +179,11 @@ static void ptp_clock_release(struct device *dev)
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
 	/* Delete first entry */
+	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 	tsevq = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
 				 qlist);
-	spin_lock_irqsave(&tsevq->lock, flags);
 	list_del(&tsevq->qlist);
-	spin_unlock_irqrestore(&tsevq->lock, flags);
+	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 	bitmap_free(tsevq->mask);
 	kfree(tsevq);
 	debugfs_remove(ptp->debugfs_root);
@@ -247,6 +247,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (!queue)
 		goto no_memory_queue;
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
+	spin_lock_init(&ptp->tsevqs_lock);
 	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
 	if (!queue->mask)
 		goto no_memory_bitmap;
@@ -407,6 +408,7 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 {
 	struct timestamp_event_queue *tsevq;
 	struct pps_event_time evt;
+	unsigned long flags;
 
 	switch (event->type) {
 
@@ -415,10 +417,12 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 
 	case PTP_CLOCK_EXTTS:
 		/* Enqueue timestamp on selected queues */
+		spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
 			if (test_bit((unsigned int)event->index, tsevq->mask))
 				enqueue_external_timestamp(tsevq, event);
 		}
+		spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 		wake_up_interruptible(&ptp->tsev_wq);
 		break;
 
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 52f87e394aa6..35fde0a05746 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -44,6 +44,7 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
+	spinlock_t tsevqs_lock; /* protects tsevqs from concurrent access */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
 	int defunct; /* tells readers to go away when clock is being removed */
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 473b6d992507..3f7a74788802 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -588,7 +588,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
-- 
2.25.1

