Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84623776DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjHJBwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjHJBwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:52:14 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC51210DA;
        Wed,  9 Aug 2023 18:52:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RLqfw0sCLz4f3lVW;
        Thu, 10 Aug 2023 09:52:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBH1qjHQtRk55ljAQ--.40856S4;
        Thu, 10 Aug 2023 09:52:09 +0800 (CST)
From:   linan666@huaweicloud.com
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH] scsi: ata: Fix a race condition between scsi error handler and ahci interrupt
Date:   Thu, 10 Aug 2023 09:48:48 +0800
Message-Id: <20230810014848.2148316-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH1qjHQtRk55ljAQ--.40856S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4kJF48uw4ktw43JF4Dtwb_yoW8CryDpF
        Z8ur9FgryDKFy2vanxZa13Za43GFW8AFyjgFyUJ34SqFZ8tFyrKrZ2y3909FyjkryUGry2
        qw4qgr18Cr48J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40E
        w7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwc_TUU
        UUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

interrupt                            scsi_eh

ahci_error_intr
  =>ata_port_freeze
    =>__ata_port_freeze
      =>ahci_freeze (turn IRQ off)
    =>ata_port_abort
      =>ata_port_schedule_eh
        =>shost->host_eh_scheduled++;
        host_eh_scheduled = 1
                                     scsi_error_handler
                                       =>ata_scsi_error
                                         =>ata_scsi_port_error_handler
                                           =>ahci_error_handler
                                           . =>sata_pmp_error_handler
                                           .   =>ata_eh_thaw_port
                                           .     =>ahci_thaw (turn IRQ on)
ahci_error_intr                            .
  =>ata_port_freeze                        .
    =>__ata_port_freeze                    .
      =>ahci_freeze (turn IRQ off)         .
    =>ata_port_abort                       .
      =>ata_port_schedule_eh               .
        =>shost->host_eh_scheduled++;      .
        host_eh_scheduled = 2              .
                                           =>ata_std_end_eh
                                             =>host->host_eh_scheduled = 0;

'host_eh_scheduled' is 0 and scsi eh thread will not be scheduled again,
and the ata port remain freeze and will never be enabled.

If EH thread is already running, no need to freeze port and schedule
EH again.

Reported-by: luojian <luojian5@huawei.com>
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/ata/libahci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e2bacedf28ef..0dfb0b807324 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1840,9 +1840,17 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
 	/* okay, let's hand over to EH */
 
-	if (irq_stat & PORT_IRQ_FREEZE)
+	if (irq_stat & PORT_IRQ_FREEZE) {
+		/*
+		 * EH already running, this may happen if the port is
+		 * thawed in the EH. But we cannot freeze it again
+		 * otherwise the port will never be thawed.
+		 */
+		if (ap->pflags & (ATA_PFLAG_EH_PENDING |
+			ATA_PFLAG_EH_IN_PROGRESS))
+			return;
 		ata_port_freeze(ap);
-	else if (fbs_need_dec) {
+	} else if (fbs_need_dec) {
 		ata_link_abort(link);
 		ahci_fbs_dec_intr(ap);
 	} else
-- 
2.39.2

