Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53D07AEB07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjIZLEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjIZLEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:04:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E593E95;
        Tue, 26 Sep 2023 04:03:53 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690d2441b95so6291929b3a.1;
        Tue, 26 Sep 2023 04:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695726233; x=1696331033; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfI3/3LVivFD+ycaQCKtXt9/80PRWkq6i+B9OsvgUoQ=;
        b=bzci90ACmcptF/MQKv5EkyN4cbSOgieX17pjigBppRjlLjcHw1l1DD5LF/PO6CIYzH
         Hjt6FRx3O07cRk8gv9M5t/q5kt2NDlgOl3yn3HorLE7PL3bRY7Uo2Jw+na0KwfWWCB76
         HlW/jU2sKCgkdeTiK+m5m3rGNddVqj8vNL1gfZvJj7/hEOKcs8HEZAVf15m/GnhF12rL
         8KwdnLgSLC4Gp060DW7XWMlbx2eP+s2WYJUSbQDTfpBFlZykrptgrEFFezY5djzQ2+Wi
         AWKGnjAcm9t2K01jGNpAkLBHwK5wtohfMPZiqAYYL1il4xx3K7Bkk1l/vYX8GjV563Ns
         9dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695726233; x=1696331033;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfI3/3LVivFD+ycaQCKtXt9/80PRWkq6i+B9OsvgUoQ=;
        b=aXy9XlECA7xVqiNIJak7b6c+80KvP6ydmI/KsjBRgFuB3F9HWOlfNFp4AKvIH0+tkb
         zl9SHWsDpq+LJWBHSQhHb7/kkwcYhZd1YnbNTFMyw5VoaE9j6gE+FpvGL7YTlemIoOls
         NpQLGImqXVfSN1mt6VG/jIoDz83W2jGMmgRQdpFYtW6DCOHBGKihyRFZ8Zm+ggYdX/82
         tf4m/Ny/wF2vvD9piY+eDcl9ZyLj/GE1B7kiRioJ/RLK+GitvZ/X/juFOhdLsQ7z+Fiy
         08QAMxPrjllBFzuhEkImMCTVMpS3HOcGugr0NhQcuok818kLxw8Huat47Ytxm/nPlDnr
         jkuw==
X-Gm-Message-State: AOJu0Yzx99HEaYIxK+UQeqoS42KDz6yYXGgo4bmqur2ahITt3Dk7t3m9
        4p5vg/WglqdC29Rm1Dy7XhY=
X-Google-Smtp-Source: AGHT+IG0VffM5J+dFIO8rNJNuwQ3gHpDzkP1TUkNwlndvy9Ikb+nOCeOkU0giVf3RFGo/Sw4uxvCgg==
X-Received: by 2002:a05:6a21:18f:b0:134:73f6:5832 with SMTP id le15-20020a056a21018f00b0013473f65832mr3951818pzb.16.1695726233284;
        Tue, 26 Sep 2023 04:03:53 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78545000000b0068fd653321esm9717263pfn.58.2023.09.26.04.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:03:52 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     aacraid@microsemi.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] scsi: ips: Fix potential deadlock on host->host_lock
Date:   Tue, 26 Sep 2023 11:03:41 +0000
Message-Id: <20230926110341.12028-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hard interrupt do_ipsintr() could introduce double locks on
host->host_lock.

<Deadlock #1>
ips_eh_abort()
--> spin_loc(host->host_lock)
<interrupt>
   --> do_ipsintr()
   --> spin_lock(host->host_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch use spin_lock_irqsave()
on host->host_lock.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/scsi/ips.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index bb206509265e..3caab8233d68 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -776,6 +776,8 @@ int ips_eh_abort(struct scsi_cmnd *SC)
 {
 	ips_ha_t *ha;
 	ips_copp_wait_item_t *item;
+	unsigned long flags;
+
 	int ret;
 	struct Scsi_Host *host;
 
@@ -793,7 +795,7 @@ int ips_eh_abort(struct scsi_cmnd *SC)
 	if (!ha->active)
 		return (FAILED);
 
-	spin_lock(host->host_lock);
+	spin_lock_irqsave(host->host_lock, flags);
 
 	/* See if the command is on the copp queue */
 	item = ha->copp_waitlist.head;
@@ -814,7 +816,7 @@ int ips_eh_abort(struct scsi_cmnd *SC)
 		ret = (FAILED);
 	}
 
-	spin_unlock(host->host_lock);
+	spin_unlock_irqrestore(host->host_lock, flags);
 	return ret;
 }
 
-- 
2.17.1

