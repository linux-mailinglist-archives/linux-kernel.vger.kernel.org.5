Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA937E0242
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjKCLgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjKCLgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:36:17 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B251BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:36:14 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b3f5a58408so2641924b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699011373; x=1699616173;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lItswbdny8h31vPMeYBzVueiX+EguB1Z+mEFADrYg+I=;
        b=WAgl53kwAz2JOSx0lWJxLM3JHpTpRR2B9uNwvPMDpdYtyYJKkVdBEGs+aCXaQDsniy
         tyVxCepgOsJQftoPRdyx/T5Ycmv+9UB91AvyAZzZQeuyAzOIvc4MTdBENsXw2qptGnmD
         ztf18tfmCYnL8Bd76sXMnpZS2IJH92u8YO4KMDbXxym8/DMqmenKvnnS1UlQvL/9ptKl
         YyLJ7NkNOI2DWJoyx66njS4wGWpkzfb569r8zHD7poFP9/58GQyhIEr+/CYFub1dfMy8
         oNVkmL7Ts64ANV7qSt+iwfU4XhrMkwZqBbPYviyRQsmzi4Y9qn3KdHF/PQuoANJzPLap
         K9jA==
X-Gm-Message-State: AOJu0Yzt5BD3TldTMPRskXoShXJa1ycRSJ/r9TmC7UCpKUTyjOW4Ijc6
        FEUOytIKnyL6z+7wcoUuhBNPk/qmAsl2E570cR49QgZCVRjoVM4=
X-Google-Smtp-Source: AGHT+IG/xQwhQ/Pdb6SdP4JtEZC+ERnNhHR6Mpte5rWWmK7yqlqn322gnbgYSWI9NzBIRQjWlIIasr7xy/vd5L0UUaiy9yoWZ61Z
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a03:b0:3ab:c19f:bdf8 with SMTP id
 bk3-20020a0568081a0300b003abc19fbdf8mr8546316oib.11.1699011373497; Fri, 03
 Nov 2023 04:36:13 -0700 (PDT)
Date:   Fri, 03 Nov 2023 04:36:13 -0700
In-Reply-To: <0000000000006655c10608ddfb6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063045b06093de946@google.com>
Subject: Re: [syzbot] [PATCH] Test for 2030579113a1
From:   syzbot <syzbot+ec9435c038e451be48ff@syzkaller.appspotmail.com>
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
index 282cd7d24077..6e9762a54b14 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -119,8 +119,13 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 	}
 	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
+	if (mutex_lock_interruptible(&ptp->tsevq_mux)) {
+		kfree(queue);
+		return -ERESTARTSYS;
+	}
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	pccontext->private_clkdata = queue;
+	mutex_unlock(&ptp->tsevq_mux);
 
 	/* Debugfs contents */
 	sprintf(debugfsname, "0x%p", queue);
@@ -138,14 +143,19 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 int ptp_release(struct posix_clock_context *pccontext)
 {
 	struct timestamp_event_queue *queue = pccontext->private_clkdata;
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 	unsigned long flags;
 
 	if (queue) {
+		if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
+			return -ERESTARTSYS;
 		debugfs_remove(queue->debugfs_instance);
 		pccontext->private_clkdata = NULL;
 		spin_lock_irqsave(&queue->lock, flags);
 		list_del(&queue->qlist);
 		spin_unlock_irqrestore(&queue->lock, flags);
+		mutex_unlock(&ptp->tsevq_mux);
 		bitmap_free(queue->mask);
 		kfree(queue);
 	}
@@ -585,7 +595,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3d1b0a97301c..7930db6ec18d 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -176,6 +176,7 @@ static void ptp_clock_release(struct device *dev)
 
 	ptp_cleanup_pin_groups(ptp);
 	kfree(ptp->vclock_index);
+	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
 	/* Delete first entry */
@@ -247,6 +248,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (!queue)
 		goto no_memory_queue;
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
+	mutex_init(&ptp->tsevq_mux);
 	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
 	if (!queue->mask)
 		goto no_memory_bitmap;
@@ -356,6 +358,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (ptp->kworker)
 		kthread_destroy_worker(ptp->kworker);
 kworker_err:
+	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
 	bitmap_free(queue->mask);
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 52f87e394aa6..1525bd2059ba 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -44,6 +44,7 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
+	struct mutex tsevq_mux; /* one process at a time reading the fifo */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
 	int defunct; /* tells readers to go away when clock is being removed */
-- 
2.25.1

