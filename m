Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651807E11E3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 02:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjKEB1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 21:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjKEB1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 21:27:52 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E805E3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 18:27:50 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1f08758b52cso2014111fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 18:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699147669; x=1699752469;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fLBwfuHSTS0huTJxi972Yu3ZpUahtwAKJsZuM7vbeU=;
        b=qTNZttBXjLk885cR3Saxct2pY+tt0kTBd4U9Mg8M0eb3OGoMyDkx7Q2hH/aIjWUoXq
         2LgGaM7Lx+y53Nkbobolj6emPoVixR/UKRAu71s/MGTrVPSetYOCBXb92r+orBmz666w
         PcO6oWgC8Pr53cfcRmzbgAKY54btUDUJmVC0WATAN3KOhpCwEA2zdLMAo/sz8NXZgMSV
         LnWFS/HiSUpoeuU2AHqiPeFwCiH77wPkvAnxPqPEHE5VjxHUga1Gro9btB00Bbmq7eFn
         8QhKRsAyPQexRMnybKteITdakEpavLOSMK4hCqGy+mC/HFGD9TUH02tJ3YwX1vveM9Nh
         do7A==
X-Gm-Message-State: AOJu0Yy5v8dLol1xFBBl4/msZhRGk8Kg+MTmTEoD52wMdrWy7gau51mK
        XVzeFSWmQ641zesopnDxUc9i+sRmJU59zV3s/1t6xeBUsaT0aJM=
X-Google-Smtp-Source: AGHT+IGgV8usG9KZonGQGQlArc1TNxMThQc6Rj2XstsOE0BaqNGZ5xQx1myMrkZMt9eUkuRRfXRA4SbxjVR1qzfhRVI5Zy+aNaIl
MIME-Version: 1.0
X-Received: by 2002:a05:6871:711:b0:1e9:9b32:3e56 with SMTP id
 f17-20020a056871071100b001e99b323e56mr11800876oap.7.1699147669771; Sat, 04
 Nov 2023 18:27:49 -0700 (PDT)
Date:   Sat, 04 Nov 2023 18:27:49 -0700
In-Reply-To: <000000000000910ad106089f45eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000471df406095da542@google.com>
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
index 282cd7d24077..eb4015ae93a2 100644
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
+	spin_lock_irqsave(&ptp->tsevq_lock, flags);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	pccontext->private_clkdata = queue;
+	spin_unlock_irqrestore(&ptp->tsevq_lock, flags);
 
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
+		spin_lock_irqsave(&ptp->tsevq_lock, flags);
 		pccontext->private_clkdata = NULL;
-		spin_lock_irqsave(&queue->lock, flags);
 		list_del(&queue->qlist);
-		spin_unlock_irqrestore(&queue->lock, flags);
+		spin_unlock_irqrestore(&ptp->tsevq_lock, flags);
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
index 3d1b0a97301c..d813bf25dffc 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -247,6 +247,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (!queue)
 		goto no_memory_queue;
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
+	spin_lock_init(&ptp->tsevq_lock);
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

