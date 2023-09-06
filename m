Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FE979356C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbjIFGi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjIFGi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:38:26 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95CBCDB;
        Tue,  5 Sep 2023 23:38:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RgXkb39rfz4f3nTG;
        Wed,  6 Sep 2023 14:38:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBH1qhXHvhkRnj0CQ--.13688S4;
        Wed, 06 Sep 2023 14:38:16 +0800 (CST)
From:   linan666@huaweicloud.com
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH v3] ata: libata-eh: Honor all EH scheduling requests
Date:   Wed,  6 Sep 2023 14:33:21 +0800
Message-Id: <20230906063321.905103-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH1qhXHvhkRnj0CQ--.13688S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45Zry3JFy5GrWUZr13Jwb_yoW5Wr1rpF
        Z8Xw1DWryDtry0vr4qvF1rZryrGay8Gay2qFyDGw1fZw4qk34rtrs7CF9I9Fyakr97XF17
        Za1jq3sxCF18urJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

If a disk is removed and quickly inserted when an I/O error is processing,
the disk may not be able to be re-added. The function call timeline is as
follows:

  interrupt                            scsi_eh

  ahci_error_intr
   ata_port_freeze
    __ata_port_freeze
     =>ahci_freeze (turn IRQ off)
    ata_port_abort
     ata_do_link_abort
      ata_port_schedule_eh
       =>ata_std_sched_eh
        ata_eh_set_pending
	 set EH_PENDING
        scsi_schedule_eh
         shost->host_eh_scheduled++ (=1)
                                       scsi_error_handler
                                        =>ata_scsi_error
                                         ata_scsi_port_error_handler
					  clear EH_PENDING
                                          =>ahci_error_handler
                                          . sata_pmp_error_handler
                                          .  ata_eh_reset
                                          .   ata_eh_thaw_port
                                          .   . =>ahci_thaw (turn IRQ on)
  ahci_error_intr			  .   .
   ata_port_freeze			  .   .
    __ata_port_freeze			  .   .
     =>ahci_freeze (turn IRQ off)	  .   .
    ...					  .   .
        ata_eh_set_pending		  .   .
	 set EH_PENDING			  .   .
        scsi_schedule_eh		  .   .
         shost->host_eh_scheduled++ (=2)  .   .
					  .   clear EH_PENDING
					  check EH_PENDING
                                          =>ata_std_end_eh
                                           host->host_eh_scheduled = 0;

'host_eh_scheduled' is 0 and scsi eh thread will not be scheduled again.
The ata port remains frozen and will never be enabled.

To fix this issue, decrease 'host_eh_scheduled' instead of setting it to 0
so that EH is scheduled again to re-enable the port. Also move the update
of 'nr_active_links' to 0 when 'host_eh_scheduled' is 0 to
ata_scsi_port_error_handler().

Reported-by: luojian <luojian5@huawei.com>
Signed-off-by: Li Nan <linan122@huawei.com>
---
Changes in v3:
 - change patch title, previously it was: "scsi: ata: Fix a race condition
   between scsi error handler and ahci interrupt".
 - drop the variable 'host' in ata_std_end_eh().
 - improve commit message.

 drivers/ata/libata-eh.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 159ba6ba19eb..2d5ecd68b7e0 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -735,6 +735,12 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 	 */
 	ap->ops->end_eh(ap);
 
+	if (!ap->scsi_host->host_eh_scheduled) {
+		/* make sure nr_active_links is zero after EH */
+		WARN_ON(ap->nr_active_links);
+		ap->nr_active_links = 0;
+	}
+
 	spin_unlock_irqrestore(ap->lock, flags);
 	ata_eh_release(ap);
 
@@ -946,9 +952,7 @@ EXPORT_SYMBOL_GPL(ata_std_sched_eh);
  */
 void ata_std_end_eh(struct ata_port *ap)
 {
-	struct Scsi_Host *host = ap->scsi_host;
-
-	host->host_eh_scheduled = 0;
+	ap->scsi_host->host_eh_scheduled--;
 }
 EXPORT_SYMBOL(ata_std_end_eh);
 
@@ -3922,10 +3926,6 @@ void ata_eh_finish(struct ata_port *ap)
 			}
 		}
 	}
-
-	/* make sure nr_active_links is zero after EH */
-	WARN_ON(ap->nr_active_links);
-	ap->nr_active_links = 0;
 }
 
 /**
-- 
2.39.2

