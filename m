Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7F4761DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjGYPz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjGYPzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:55:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B0211F;
        Tue, 25 Jul 2023 08:55:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso3261407b3a.3;
        Tue, 25 Jul 2023 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690300548; x=1690905348;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNM2+wxeZARzSkQ/4NLBTlxq8VR/UGI6SEgq0/2JQvs=;
        b=N7ovGporZk8JwJJGCKYIxsLfzgG0Hy/tvkZM1AWWvqjNR91WDbugxebDEp+p9FIHwx
         /mBJpy6Tcn68qVbbzZuKmch4mEIc34xZCCAmOvLli5axEGU9kUf3q0HG6nSal9HRgd5a
         cC2GedWhNUg+S843Ab8GC7yqjwWn/0usLJlpyJ1myeOM8GF/VjfFxBARhXmxF+jbfMuq
         nzN7z/+UoPSp1n4K6HLS3jg6LJfFU2tfLKZKnhjOuMFFsKRY1Z51qqqkskSpyo3+ik2k
         C/NzkVpKKjUxKntfdxyQ3ZrqHSpXTsLImCM5so6QtE6IBjDv0vrKTmRrtu+7eptv7mOq
         t4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690300548; x=1690905348;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNM2+wxeZARzSkQ/4NLBTlxq8VR/UGI6SEgq0/2JQvs=;
        b=iFvCVEf1cNhusZhkGgsrbxgBLmY6jcSANNunaT02BeR2Ib+5IhOGGnHw90N04YqJ/X
         E0UXqj+LrwSByX+eFqME+sRKz10qKEzCEOn3+0MdbIEgRVNYhPyDdhX4PtWShMNkT4TW
         mWn8VtE/QhWgb6nAgEi55aIhEme18Z5QTSI65If+LkkgNqeRZpgRugwHevKBUDED1PjJ
         BvG0EVH4vOMFlqYteqGs7NfD1HruGzjl2BaLGU8n15H3BbZJc8JguP3wRGLJNAaIs2QO
         YORAZBo2IU4JmCbHdWO8XmBkoEMKVXB83Kxjg2KQdGybwvLbkjC4HKTdVj41i4nIOrlg
         TPaA==
X-Gm-Message-State: ABy/qLZsAcva+OEvX2zRk0R5K9u9Kr/e24ZEhYktXrTTdLp2USW49Zwi
        peSpxm37d24WEqEfP8/k+ro=
X-Google-Smtp-Source: APBJJlE2Y1a2Qg4Lsf93j71bQ101VaJxiNNcRXzRyJI2/0HGaT8uT36l8Y2ZRU7GrVkcRs+UwpKIyA==
X-Received: by 2002:a05:6a00:1484:b0:675:70d7:1eb4 with SMTP id v4-20020a056a00148400b0067570d71eb4mr9800163pfu.14.1690300548068;
        Tue, 25 Jul 2023 08:55:48 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id a18-20020a62bd12000000b0064fd4a6b306sm9777443pff.76.2023.07.25.08.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:55:47 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl, tiwai@suse.de
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] media: dvb-core: Fix potential deadlock on &dmxdevfilter->dev->lock
Date:   Tue, 25 Jul 2023 15:55:30 +0000
Message-Id: <20230725155530.63315-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &dmxdevfilter->dev->lock acquired by timer dvb_dmxdev_filter_timeout()
softirq context, other acquisition of the same lock under process context
should disable irq, otherwise deadlock could happen if the soft irq preempt
the execution while the lock is held in process context on the same CPU.

The dvb_dmxdev_section_callback() and dvb_dmxdev_ts_callback() callbacks
acquires the lock without disabling irq inside the function.

[Possible deadlock scenario]
dvb_dmxdev_section_callback()
    -> spin_lock(&dmxdevfilter->dev->lock);
        <timer interrupt>
        -> dvb_dmxdev_filter_timeout()
        -> spin_lock_irq(&dmxdevfilter->dev->lock);

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock.

The tentative patch fixes the potential deadlock by spin_lock_bh()
disable softirq.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/media/dvb-core/dmxdev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index 9ce5f010de3f..e4b6427230ed 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -386,9 +386,9 @@ static int dvb_dmxdev_section_callback(const u8 *buffer1, size_t buffer1_len,
 		wake_up(&dmxdevfilter->buffer.queue);
 		return 0;
 	}
-	spin_lock(&dmxdevfilter->dev->lock);
+	spin_lock_bh(&dmxdevfilter->dev->lock);
 	if (dmxdevfilter->state != DMXDEV_STATE_GO) {
-		spin_unlock(&dmxdevfilter->dev->lock);
+		spin_unlock_bh(&dmxdevfilter->dev->lock);
 		return 0;
 	}
 	del_timer(&dmxdevfilter->timer);
@@ -413,7 +413,7 @@ static int dvb_dmxdev_section_callback(const u8 *buffer1, size_t buffer1_len,
 		dmxdevfilter->buffer.error = ret;
 	if (dmxdevfilter->params.sec.flags & DMX_ONESHOT)
 		dmxdevfilter->state = DMXDEV_STATE_DONE;
-	spin_unlock(&dmxdevfilter->dev->lock);
+	spin_unlock_bh(&dmxdevfilter->dev->lock);
 	wake_up(&dmxdevfilter->buffer.queue);
 	return 0;
 }
@@ -430,9 +430,9 @@ static int dvb_dmxdev_ts_callback(const u8 *buffer1, size_t buffer1_len,
 #endif
 	int ret;
 
-	spin_lock(&dmxdevfilter->dev->lock);
+	spin_lock_bh(&dmxdevfilter->dev->lock);
 	if (dmxdevfilter->params.pes.output == DMX_OUT_DECODER) {
-		spin_unlock(&dmxdevfilter->dev->lock);
+		spin_unlock_bh(&dmxdevfilter->dev->lock);
 		return 0;
 	}
 
@@ -457,7 +457,7 @@ static int dvb_dmxdev_ts_callback(const u8 *buffer1, size_t buffer1_len,
 						  buffer_flags);
 	} else {
 		if (buffer->error) {
-			spin_unlock(&dmxdevfilter->dev->lock);
+			spin_unlock_bh(&dmxdevfilter->dev->lock);
 			wake_up(&buffer->queue);
 			return 0;
 		}
@@ -468,7 +468,7 @@ static int dvb_dmxdev_ts_callback(const u8 *buffer1, size_t buffer1_len,
 	}
 	if (ret < 0)
 		buffer->error = ret;
-	spin_unlock(&dmxdevfilter->dev->lock);
+	spin_unlock_bh(&dmxdevfilter->dev->lock);
 	wake_up(&buffer->queue);
 	return 0;
 }
-- 
2.17.1

