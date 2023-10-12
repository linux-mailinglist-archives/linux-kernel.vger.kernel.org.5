Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEDD7C7A67
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443118AbjJLX30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443107AbjJLX3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:29:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0615BBE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:29:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9a1762b43so12879695ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697153359; x=1697758159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlboVPPH070OagvlhKhz0n6waemv7KPXuN+LiDEoXiU=;
        b=AlxbnNYiJ3Uw1wzItYX1xaVf8V5UFTjAcLUoNgjdJ9KqZ8z2KYQQEtcAATHA2POruG
         OWg1c2E+/TWrAKEWQOpHZpQ8+Vrq6orWhSbzupL5h882gbZ3VHtoF3dl/A/kB2ZeVBdD
         sj7CJiWl1OuQoBlWdN0/0zF57Itx7ON9UCw74yuwIwEJ5ACg1YRDQyf1zsWM3lOpJlUO
         UWXotCZFb0bPssIe6fH/+c1tMDb78GYFaG7egABKwTPFZkZcRRspzcQN04LpldrJwcCO
         IKMMQGX02ZWI0iuELi9TApNobnPaF7KiUWrpqBDDDnghyY8hvdzufXptMyld3hzTXSUx
         cLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697153359; x=1697758159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlboVPPH070OagvlhKhz0n6waemv7KPXuN+LiDEoXiU=;
        b=qXvjPEos8CtqS/JFahO69LhDwspslLnwMm+kJQrPdtRQPplf8lgxLGR+S8lmW8qPrj
         hlePzriHUxJkK9vGP1myzt8PfNE/j1FZALBKcSOC2E+m3kVZLtXAosH5QAPc8uOJT4+H
         svRAp3Db0qV9lOKUDnhzuspjikHT3uIV/0k6Frv7j6MwVBtO/izxx48o5elnmhufmjNp
         VYNEY7VRlxd/WGYBgoaRpzaSxp0r0yTu5xEGW5AeiC9of5mA0xM9ejW2Tml87cYGxTzX
         pZ8TkkF3a64PJoe1l6EChnUT+Jw7d/4HrSLZXT3KA5jy594senhgrDw2nJOTrpqyLlCe
         lPzQ==
X-Gm-Message-State: AOJu0YwIC+tRhIQaYm/NLhnwxLwKnAtEYBJpyHkm5jQScdMJD4gji2PT
        nSBHFkZ49x8t/NMwVw2IC2e6za2tDX8jgQ==
X-Google-Smtp-Source: AGHT+IEikXob9hAVsKvXb/4Fcn/oTZF0vIojmHK4J1oWfygDpBqQhxUXzcC9HJpGB7mG7WXjlfy3RQ==
X-Received: by 2002:a17:903:11d2:b0:1c7:2697:ec0a with SMTP id q18-20020a17090311d200b001c72697ec0amr29082570plh.30.1697153359510;
        Thu, 12 Oct 2023 16:29:19 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b001c619fbd5fbsm2534402plb.298.2023.10.12.16.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:29:19 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Micky Ching <micky_ching@realsil.com.cn>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Soumya Negi <soumya.negi97@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v2 2/2] staging: rts5208: Remove macros scsi_lock(), scsi_unlock()
Date:   Thu, 12 Oct 2023 16:29:06 -0700
Message-ID: <75a5990190cf7a5d20d1c27237b90b583e68ced8.1697152251.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697152251.git.soumya.negi97@gmail.com>
References: <cover.1697152251.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scsi_lock() and scsi_unlock() macros protect the sm_state and the
single queue element srb for write access in the driver. As suggested,
these names are very generic. Remove the macros from header file and call
spin_lock_irq() & spin_unlock_irq() directly instead.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/rts5208/rtsx.c | 24 ++++++++++++------------
 drivers/staging/rts5208/rtsx.h |  7 -------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 08543a3936da..86d32e3b3282 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -117,7 +117,7 @@ static int slave_configure(struct scsi_device *sdev)
 	} while (0)
 
 /* queue a command */
-/* This is always called with scsi_lock(host) held */
+/* This is always called with spin_lock_irq(host->host_lock) held */
 static int queuecommand_lck(struct scsi_cmnd *srb)
 {
 	void (*done)(struct scsi_cmnd *) = scsi_done;
@@ -159,18 +159,18 @@ static int command_abort(struct scsi_cmnd *srb)
 	struct rtsx_dev *dev = host_to_rtsx(host);
 	struct rtsx_chip *chip = dev->chip;
 
-	scsi_lock(host);
+	spin_lock_irq(host->host_lock);
 
 	/* Is this command still active? */
 	if (chip->srb != srb) {
-		scsi_unlock(host);
+		spin_unlock_irq(host->host_lock);
 		dev_info(&dev->pci->dev, "-- nothing to abort\n");
 		return FAILED;
 	}
 
 	rtsx_set_stat(chip, RTSX_STAT_ABORT);
 
-	scsi_unlock(host);
+	spin_unlock_irq(host->host_lock);
 
 	/* Wait for the aborted command to finish */
 	wait_for_completion(&dev->notify);
@@ -366,7 +366,7 @@ static int rtsx_control_thread(void *__dev)
 		}
 
 		/* lock access to the state */
-		scsi_lock(host);
+		spin_lock_irq(host->host_lock);
 
 		/* has the command aborted ? */
 		if (rtsx_chk_stat(chip, RTSX_STAT_ABORT)) {
@@ -374,7 +374,7 @@ static int rtsx_control_thread(void *__dev)
 			goto skip_for_abort;
 		}
 
-		scsi_unlock(host);
+		spin_unlock_irq(host->host_lock);
 
 		/* reject the command if the direction indicator
 		 * is UNKNOWN
@@ -402,7 +402,7 @@ static int rtsx_control_thread(void *__dev)
 		}
 
 		/* lock access to the state */
-		scsi_lock(host);
+		spin_lock_irq(host->host_lock);
 
 		/* did the command already complete because of a disconnect? */
 		if (!chip->srb)
@@ -424,7 +424,7 @@ static int rtsx_control_thread(void *__dev)
 
 		/* finished working on this command */
 		chip->srb = NULL;
-		scsi_unlock(host);
+		spin_unlock_irq(host->host_lock);
 
 		/* unlock the device pointers */
 		mutex_unlock(&dev->dev_mutex);
@@ -603,9 +603,9 @@ static void quiesce_and_remove_host(struct rtsx_dev *dev)
 	 * interrupt a SCSI-scan or device-reset delay
 	 */
 	mutex_lock(&dev->dev_mutex);
-	scsi_lock(host);
+	spin_lock_irq(host->host_lock);
 	rtsx_set_stat(chip, RTSX_STAT_DISCONNECT);
-	scsi_unlock(host);
+	spin_unlock_irq(host->host_lock);
 	mutex_unlock(&dev->dev_mutex);
 	wake_up(&dev->delay_wait);
 	wait_for_completion(&dev->scanning_done);
@@ -621,10 +621,10 @@ static void quiesce_and_remove_host(struct rtsx_dev *dev)
 	mutex_lock(&dev->dev_mutex);
 	if (chip->srb) {
 		chip->srb->result = DID_NO_CONNECT << 16;
-		scsi_lock(host);
+		spin_lock_irq(host->host_lock);
 		scsi_done(dev->chip->srb);
 		chip->srb = NULL;
-		scsi_unlock(host);
+		spin_unlock_irq(host->host_lock);
 	}
 	mutex_unlock(&dev->dev_mutex);
 
diff --git a/drivers/staging/rts5208/rtsx.h b/drivers/staging/rts5208/rtsx.h
index ea29646b8c38..ec6f5b07390b 100644
--- a/drivers/staging/rts5208/rtsx.h
+++ b/drivers/staging/rts5208/rtsx.h
@@ -108,13 +108,6 @@ static inline struct rtsx_dev *host_to_rtsx(struct Scsi_Host *host)
 	return (struct rtsx_dev *)host->hostdata;
 }
 
-/*
- * The scsi_lock() and scsi_unlock() macros protect the sm_state and the
- * single queue element srb for write access
- */
-#define scsi_unlock(host)	spin_unlock_irq(host->host_lock)
-#define scsi_lock(host)		spin_lock_irq(host->host_lock)
-
 #define lock_state(chip)	spin_lock_irq(&((chip)->rtsx->reg_lock))
 #define unlock_state(chip)	spin_unlock_irq(&((chip)->rtsx->reg_lock))
 
-- 
2.42.0

