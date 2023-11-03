Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDDB7E0235
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjKCL31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjKCL30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:29:26 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7653134
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:29:23 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d31f3feb10so2385142a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010963; x=1699615763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lItswbdny8h31vPMeYBzVueiX+EguB1Z+mEFADrYg+I=;
        b=ErmUxG38UTflHlQoL3EEhDCGuYcgnl9EVT15lF058wiP9L7bV8MzwO9X8QxeVT7C2D
         Zv4LwLuz+RzFOoarePO1KcHD8Q249LyNoM5w37VsbA/qLW6XtFSkuOgLLD90BlyHQK88
         Y/jHIFz845FjtlbzVPNLS7cKav5bkPwHdRNI0+f3bQ39U25McfwuTFeCK9XlND2wAuyg
         zstGDiAR1ykPY2jJlxxPYZuJH6O8eMhe396IXHhmi6XEcWpmaMUvw1GJybaykhhz11/H
         ooPqqBx0IkAiyi3irGmM3yBqzt/f2ijlFLSbIxWwiVrm7Wa9pyFWPiBWzpVNv+SK00TW
         OGrQ==
X-Gm-Message-State: AOJu0YylBahZnBWGOjAynNer/uaEaQGhVkzt1GgMiyqU9QRwAiJFk0/z
        MVeD0bKZ/Kx/KwW3nJujKFUt5jIRjq8T4HIlN51lQLiCPQfjUWc=
X-Google-Smtp-Source: AGHT+IGzz8Z0Zg4yE/8CYnZNqoSN5xNWQ2Jh6xRgVm/iMLvcvH0jkFsUNvSH48zHQFT1FXsPaepcvssNSemSX9ZtZTHtw6bxYLVn
MIME-Version: 1.0
X-Received: by 2002:a9d:4043:0:b0:6bf:12:518b with SMTP id o3-20020a9d4043000000b006bf0012518bmr5766803oti.3.1699010963067;
 Fri, 03 Nov 2023 04:29:23 -0700 (PDT)
Date:   Fri, 03 Nov 2023 04:29:23 -0700
In-Reply-To: <000000000000910ad106089f45eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec590706093dd043@google.com>
Subject: Re: [syzbot] [PATCH] Test for 2030579113a1
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

