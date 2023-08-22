Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C18783FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbjHVLig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjHVLiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DA0E6C;
        Tue, 22 Aug 2023 04:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E38C36538F;
        Tue, 22 Aug 2023 11:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E44C433CB;
        Tue, 22 Aug 2023 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704259;
        bh=28dopH/9gA+1tqzVakq4FVJFAhk5Y4JfAi/XUlsF/f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZJiZW76yiG6O11M/20YrhCJtBh65jOcAYC8EyR/iX2GDRTQp2DiYs5jGP7+RgY5y
         BEC0tQ8xxqASqF7tVeakntMR/Xd7q7JmvIYZOMH4r+kSFOIEEe2jut3l3QzwM0P5lw
         SKa9cw9UTKQoyU6OQ5rtBi7h959oM7eokLPQdxy7kz9DnSQRw8wmFTM+XGuN6Wlpsk
         oUH8PMngulhOXU2Wqyk+2Uwj62eyLRJtnp6abPr8A8DmzeYMZjctH9jtLvnoGXPPwX
         eas+rZeMXzv9QjeDM9RO0p6SOSfavdwLV0Rmp9rei63i0WxHiHCrl83jOdBhmc2gHb
         rIVceH0ie6XQw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengfeng Ye <dg573847474@gmail.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, njavali@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 2/2] scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
Date:   Tue, 22 Aug 2023 07:37:34 -0400
Message-Id: <20230822113735.3551762-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113735.3551762-1-sashal@kernel.org>
References: <20230822113735.3551762-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.323
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengfeng Ye <dg573847474@gmail.com>

[ Upstream commit dd64f80587190265ca8a0f4be6c64c2fda6d3ac2 ]

As &qedi_percpu->p_work_lock is acquired by hard IRQ qedi_msix_handler(),
other acquisitions of the same lock under process context should disable
IRQ, otherwise deadlock could happen if the IRQ preempts the execution
while the lock is held in process context on the same CPU.

qedi_cpu_offline() is one such function which acquires the lock in process
context.

[Deadlock Scenario]
qedi_cpu_offline()
    ->spin_lock(&p->p_work_lock)
        <irq>
        ->qedi_msix_handler()
        ->edi_process_completions()
        ->spin_lock_irqsave(&p->p_work_lock, flags); (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for IRQ-related deadlocks.

The tentative patch fix the potential deadlock by spin_lock_irqsave()
under process context.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Link: https://lore.kernel.org/r/20230726125655.4197-1-dg573847474@gmail.com
Acked-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 09f57ef35990c..b8b177018031c 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1669,8 +1669,9 @@ static int qedi_cpu_offline(unsigned int cpu)
 	struct qedi_percpu_s *p = this_cpu_ptr(&qedi_percpu);
 	struct qedi_work *work, *tmp;
 	struct task_struct *thread;
+	unsigned long flags;
 
-	spin_lock_bh(&p->p_work_lock);
+	spin_lock_irqsave(&p->p_work_lock, flags);
 	thread = p->iothread;
 	p->iothread = NULL;
 
@@ -1681,7 +1682,7 @@ static int qedi_cpu_offline(unsigned int cpu)
 			kfree(work);
 	}
 
-	spin_unlock_bh(&p->p_work_lock);
+	spin_unlock_irqrestore(&p->p_work_lock, flags);
 	if (thread)
 		kthread_stop(thread);
 	return 0;
-- 
2.40.1

