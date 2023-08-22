Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAC783F86
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjHVLiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjHVLh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C6CCDB;
        Tue, 22 Aug 2023 04:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FE646539B;
        Tue, 22 Aug 2023 11:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D640CC433CA;
        Tue, 22 Aug 2023 11:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704223;
        bh=O7mF0Tijmt3RWdKGKnZR/QXw0XBqAWxLI4DCpREKLLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBvPEh94F6GakLTBGhQLnD3DLb2c3k2KP5pxIENUQa3UEJwgNxbna+ePA/HZEBz9x
         WCNUyZDdcQzTZde2JN62aqHyuSlbuKmXRvxeuCeWWTiDBXwoutFlhvKv0IkgIGHMDW
         wL0cNvQf+3l7ahv12G/jCTBPGtDg7ML7JfFj0ViWIzBKAvvJgDHnRSoq5eauBuSGgQ
         mOOo0EEIl25bIm+kZlhnaHCamU/j7sD9Q5+RGiuB9E2oOiw1VvdIiLY/HduK9NygA1
         9wuIJvCNJll5zYj0fhsVd+hgnV73M7xAkvbUxoN9Vp+/Rn+mM3DR2H9x93RdXdBn+O
         7cPE8o9rTDAGg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengfeng Ye <dg573847474@gmail.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, njavali@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/6] scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
Date:   Tue, 22 Aug 2023 07:36:55 -0400
Message-Id: <20230822113658.3551550-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113658.3551550-1-sashal@kernel.org>
References: <20230822113658.3551550-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.127
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
index d2fe8ae97abc9..b36edbef5b82f 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1979,8 +1979,9 @@ static int qedi_cpu_offline(unsigned int cpu)
 	struct qedi_percpu_s *p = this_cpu_ptr(&qedi_percpu);
 	struct qedi_work *work, *tmp;
 	struct task_struct *thread;
+	unsigned long flags;
 
-	spin_lock_bh(&p->p_work_lock);
+	spin_lock_irqsave(&p->p_work_lock, flags);
 	thread = p->iothread;
 	p->iothread = NULL;
 
@@ -1991,7 +1992,7 @@ static int qedi_cpu_offline(unsigned int cpu)
 			kfree(work);
 	}
 
-	spin_unlock_bh(&p->p_work_lock);
+	spin_unlock_irqrestore(&p->p_work_lock, flags);
 	if (thread)
 		kthread_stop(thread);
 	return 0;
-- 
2.40.1

