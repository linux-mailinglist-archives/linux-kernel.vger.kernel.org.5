Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1194D7636E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjGZM5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGZM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:57:07 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D597;
        Wed, 26 Jul 2023 05:57:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb893e6365so23464565ad.2;
        Wed, 26 Jul 2023 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690376223; x=1690981023;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ySvdAORBId7F6tM0o+hWAYYE6qPXhCxs/coJ5dfIDU=;
        b=plSKqzIj3VTiPf1pRRh7Dx/AN128Sdh2M3LyWi8KBEXvvoPl0Nx8r0bJ6Z+at1W7qS
         M6UuLVG3Mf+HBdSQEgTLVrr9g4pSQzRKq66GA51BtwLRKAbJn0F6T9QX9hpMeEEWrRNB
         8eROU9GxSUvEe/BqlqaJi5OJa84+qnxL/bkVgvnQA5GzoaFBcaK7XW0v6ECcOoN3GUKT
         IAu8qr3WPUoKXCuyiZ2wMYxoJ1Y2GpbtZlI+YOosKc7hdMs6WK549m/UqzpROLNPP+Lk
         f98XRZirBpLr4eMSNvRFYArhahMD2XpFGEEtwEPtpLMkC/BIcRognyq9y9tDguFMFj6Y
         rPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690376223; x=1690981023;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ySvdAORBId7F6tM0o+hWAYYE6qPXhCxs/coJ5dfIDU=;
        b=bXtqfZ+7AZ4/f6kfEUA498NargIzYnenGgrDm+2ERju0BwcF1+b+WQambBUA+bXexm
         xI0UKkkqTwcXLhJC5vv8Fdz5CHhM1rW8X31PlQRbIp6nOcDPYTYLWebaTxRDlUWH6koi
         amCTnwavrVFTlUE+uclFwucNL1ZPyj0SyoCC3dwDcP17q05i56zL2KhzI6tYKTkAZilX
         IWtWbjtKKnOk7GpDfIMeO72yIteOhfmzZlmc/G+/9VLZgLx/NRadujHjlYALZEFhy3pq
         VPf4JDynCQKJ89qEiy8nRyQqX3S7FyMrV6s/Dw5yxR2JfJYcrQJIX4IPc5Kp2IezepcU
         U6ig==
X-Gm-Message-State: ABy/qLbhAIeHAccKu76JmFuT4xQw+74hsSoZklm43b+zkVCtSzPZFmnV
        w0dpViMefdMrydnvHWPctLs=
X-Google-Smtp-Source: APBJJlH6mHo3jfZaGLh7lyBpVf7ybSIoJL1f5lSops/1NB++3TvGV0N+22403rCO+5r2/bvMK04zhg==
X-Received: by 2002:a17:902:c212:b0:1bb:a056:2c5f with SMTP id 18-20020a170902c21200b001bba0562c5fmr1365382pll.7.1690376222926;
        Wed, 26 Jul 2023 05:57:02 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id jc11-20020a17090325cb00b001b9bebbc621sm13040647plb.136.2023.07.26.05.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:57:02 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
Date:   Wed, 26 Jul 2023 12:56:55 +0000
Message-Id: <20230726125655.4197-1-dg573847474@gmail.com>
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

As &qedi_percpu->p_work_lock is acquired by hard irq qedi_msix_handler(),
other acquisition of the same lock under process context should disable
irq, otherwise deadlock could happen if the irq preempt the execution
while the lock is held in process context on the same CPU.

qedi_cpu_offline() is one such function acquires the lock on process
context.

[Deadlock Scenario]
qedi_cpu_offline()
    ->spin_lock(&p->p_work_lock)
        <irq>
        ->qedi_msix_handler()
        ->edi_process_completions()
        ->spin_lock_irqsave(&p->p_work_lock, flags); (deadlock here)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_irqsave()
under process context.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/scsi/qedi/qedi_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 450522b204d6..77a56a136678 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1976,8 +1976,9 @@ static int qedi_cpu_offline(unsigned int cpu)
 	struct qedi_percpu_s *p = this_cpu_ptr(&qedi_percpu);
 	struct qedi_work *work, *tmp;
 	struct task_struct *thread;
+	unsigned long flags;
 
-	spin_lock_bh(&p->p_work_lock);
+	spin_lock_irqsave(&p->p_work_lock, flags);
 	thread = p->iothread;
 	p->iothread = NULL;
 
@@ -1988,7 +1989,7 @@ static int qedi_cpu_offline(unsigned int cpu)
 			kfree(work);
 	}
 
-	spin_unlock_bh(&p->p_work_lock);
+	spin_unlock_irqrestore(&p->p_work_lock, flags);
 	if (thread)
 		kthread_stop(thread);
 	return 0;
-- 
2.17.1

