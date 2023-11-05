Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D47E11E8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 02:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjKEBoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 21:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjKEBoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 21:44:13 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA20136
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 18:44:10 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1ef4f8d294eso4385705fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 18:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699148650; x=1699753450;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdpLV+fXp+ByW+6zM+A2ifiLfgNtDLP0g/LcyF+UEsk=;
        b=U5Rm5NJfjetR+m7cIeoeIeyKvOoFmLg8PG5jFp7U7sTlOpOqMW7cT+2CgWW+jX2vc/
         AagmhKtrD6WIxXg8ORWqDXgjWjLJAVdJ/bCQynuZlG/qYPYcH0Kqvc/QByyj8R2jkO+r
         ABrLsa5DvSXsjcqJvReHGBgy+MppX+69UJvJsP8dx5qQA4HZ/3PqIOaRlsDR9UHCDECu
         CZSKkLeyMsUAQcySNNg4LZ5sFfywl7wJKTc+nFFa0XMXcpqw/1KuMl4031Pr5PGC20fz
         S1lUAaDSm2mGCQqSVcORQ4Hi5QVj2xDcEKdOkatKBjcYw3vPIIPodsEZs9GBePemnrvu
         2f3A==
X-Gm-Message-State: AOJu0YzHrShQIrFj/w03SlCWzzUPTwG94TZm0iYOWll2/Q4jnk94Yxr/
        aZ4JyrdogUUEQMpXrm7jSHIvhkxTT3Taec/7bnm9QoZ6alW/Ehc=
X-Google-Smtp-Source: AGHT+IHnGXNtr5S1yCXZYG+oCE1dowqOE5j8q5Q4KvB08oq/NnVO/q4F5TqBT7ZmGS+h1TnHXikNzdLzT015/1mU4NqGO6y5HA4B
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9584:b0:1ef:bc4c:a0e6 with SMTP id
 k4-20020a056870958400b001efbc4ca0e6mr9453144oao.7.1699148650236; Sat, 04 Nov
 2023 18:44:10 -0700 (PDT)
Date:   Sat, 04 Nov 2023 18:44:10 -0700
In-Reply-To: <000000000000910ad106089f45eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7d1e906095ddfea@google.com>
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
index 282cd7d24077..31594f40a21e 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -108,6 +108,7 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 	char debugfsname[32];
+	unsigned long flags;
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
@@ -119,8 +120,10 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 	}
 	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
+	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	pccontext->private_clkdata = queue;
+	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 
 	/* Debugfs contents */
 	sprintf(debugfsname, "0x%p", queue);
@@ -139,13 +142,15 @@ int ptp_release(struct posix_clock_context *pccontext)
 {
 	struct timestamp_event_queue *queue = pccontext->private_clkdata;
 	unsigned long flags;
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 
 	if (queue) {
 		debugfs_remove(queue->debugfs_instance);
+		spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 		pccontext->private_clkdata = NULL;
-		spin_lock_irqsave(&queue->lock, flags);
 		list_del(&queue->qlist);
-		spin_unlock_irqrestore(&queue->lock, flags);
+		spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 		bitmap_free(queue->mask);
 		kfree(queue);
 	}
@@ -585,7 +590,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3d1b0a97301c..ea82648ad557 100644
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
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 52f87e394aa6..63af246f17eb 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -44,6 +44,7 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
+	spinlock_t tsevqs_lock; /* one process at a time writing the timestamp fifo list*/
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
 	int defunct; /* tells readers to go away when clock is being removed */
-- 
2.25.1

