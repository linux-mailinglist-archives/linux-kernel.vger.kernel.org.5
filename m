Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831297E0D5C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjKDCnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 22:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDCnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 22:43:11 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD51D44
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 19:43:09 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b3f5a58408so3620835b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 19:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699065788; x=1699670588;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKrKGR53LfDUt2P+5C7knLNdT0onP9ZMnHmJT/homWc=;
        b=nsbO8eTzqyW9s3zlEaPm3SBL+AQjZ6V2HjkOH2FlEuKsrUXeSb+oCUBAP5JBkRActD
         Bzdx6zB1QhN8z69LrUryTGQ00joAAmcqfoCSR9FT8SqQ/Vdbw5TeFjps6wDDS6yU46iz
         6CBf5VGsOehjgqoCLpINmqDzGSkfCvH960L40i8veenW1a40JH4xFPt8ohF/mBEVjZdc
         kU1qRrdzgQtNJr0R3aFY6N3mAvy0gfuN7p4HNfger+P8DOIEnx/xUk5fPUb3ZDzrmUIT
         dMkvN3DLlMDEDiR/+qNuqkOGcASkM1NGSw1RTQi+mSi1D8I2CGjKTmyMo4uinAgnoJNP
         kVoA==
X-Gm-Message-State: AOJu0YxoWY1XUJCtSN4DOcZllHAttcIa0uQ//ShQfkRffb0+yNDwBj2x
        TpHmBJb55GjKSLlyVXiuSr8HSZ68NDKwI4MjVrXIS7GUloa5Fmw=
X-Google-Smtp-Source: AGHT+IGDuBhI2reX4VT9Y3sqtRB/kWCX0Lrq6KEkolukT5u8j7wWrdrSS8CGYeAH6V6eexewsmTr8pvNDxqYdbaUC2Xxh3cZzZMp
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1892:b0:3b2:e2b6:75a3 with SMTP id
 bi18-20020a056808189200b003b2e2b675a3mr9619982oib.6.1699065788441; Fri, 03
 Nov 2023 19:43:08 -0700 (PDT)
Date:   Fri, 03 Nov 2023 19:43:08 -0700
In-Reply-To: <000000000000910ad106089f45eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c52b9206094a94fc@google.com>
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
index 282cd7d24077..ba035d6c81ae 100644
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
@@ -138,14 +143,16 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 int ptp_release(struct posix_clock_context *pccontext)
 {
 	struct timestamp_event_queue *queue = pccontext->private_clkdata;
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 	unsigned long flags;
 
 	if (queue) {
+		mutex_lock(&ptp->tsevq_mux);
 		debugfs_remove(queue->debugfs_instance);
 		pccontext->private_clkdata = NULL;
-		spin_lock_irqsave(&queue->lock, flags);
 		list_del(&queue->qlist);
-		spin_unlock_irqrestore(&queue->lock, flags);
+		mutex_unlock(&ptp->tsevq_mux);
 		bitmap_free(queue->mask);
 		kfree(queue);
 	}
@@ -585,7 +592,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
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
index 52f87e394aa6..7d82960fd946 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -44,6 +44,7 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
+	struct mutex tsevq_mux; /* one process at a time writing the timestamp fifo list */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
 	int defunct; /* tells readers to go away when clock is being removed */
-- 
2.25.1

