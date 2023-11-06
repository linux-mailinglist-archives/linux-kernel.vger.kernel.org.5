Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA577E1F46
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjKFLFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFLFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:05:19 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0698
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:05:16 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b2e7b41beaso6296731b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 03:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699268716; x=1699873516;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4WrInhgn1slSzPkxe5Hf57cTocmvPMzjXvDetJR8Dc=;
        b=T6wnSpbAgnI4qSVYcKX1FQEGZotunOilL4imEbmQTpbvIpCgSCvqBY/K0Ge8HuRRj6
         mIoAlIt1K1FpFtYNJyz4bdgIqJ3GLLrplkFRbaT90ZbhSV9Al00t+o1JuvbGjiQ1B9fm
         1M6DY9XbEhwe+y003NuJ4iL1Byo36m4mkhB0fX/rF3sARZ8wm/4YpFUsehnWS3pZQRTk
         0jPToxmBA1ggp0N0slDWZAQs5CoiwrW9t+f+ajlYtKz2lDOuTs6WGVLfX1cmVmhqOsVc
         UJhWF9OXL3jU9o1nHq+RBIQm35uIYk7z68thGf9FCmF+HQ8RXBZc0SxQsoxPe8QDoins
         LQ7A==
X-Gm-Message-State: AOJu0YxGVtz6h1/TemLQSUA3paHgOUNtUbRFB65Tjg8HYMw2/Jq3sSYd
        fXpjUINdv7ilLrpROWzNcvGiC9K+oxlsQayjzZS3Hx320lm09xk=
X-Google-Smtp-Source: AGHT+IH220mff9/nUmWtiiwPvvpOTsem5XSXlBiK+utk5EXA4JLSYf6D5RnVk4OVWWuS5CLF6JhBQt2RO4zpv0voE5ludTVkBTY1
MIME-Version: 1.0
X-Received: by 2002:a05:6808:20a6:b0:3a9:b9eb:9990 with SMTP id
 s38-20020a05680820a600b003a9b9eb9990mr3816830oiw.0.1699268715895; Mon, 06 Nov
 2023 03:05:15 -0800 (PST)
Date:   Mon, 06 Nov 2023 03:05:15 -0800
In-Reply-To: <000000000000910ad106089f45eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000306327060979d4bc@google.com>
Subject: Re: [syzbot] [PATCH] Test for 2030579113a1
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
index 282cd7d24077..3f7a74788802 100644
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
 
@@ -585,7 +588,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3d1b0a97301c..41b68568811a 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
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
-- 
2.25.1

