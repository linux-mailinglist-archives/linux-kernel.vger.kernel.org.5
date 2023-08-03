Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842EB76E7F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbjHCMK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjHCMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:10:53 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 05:10:50 PDT
Received: from mail-m11877.qiye.163.com (mail-m11877.qiye.163.com [115.236.118.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C798D2726;
        Thu,  3 Aug 2023 05:10:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.116.51.207])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 46F97400519;
        Thu,  3 Aug 2023 19:31:51 +0800 (CST)
From:   Huang Cun <huangcun@sangfor.com.cn>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     huangcun@sangfor.com.cn, dinghui@sangfor.com.cn,
        pengdonglin@sangfor.com.cn
Subject: [PATCH] scsi: scsi_dh_rdac: Avoid crash when a disk attach failed
Date:   Thu,  3 Aug 2023 19:28:41 +0800
Message-Id: <20230803112841.588822-1-huangcun@sangfor.com.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHx1DVklOT0IZTktJQkNPGlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSFVKSk1VTkpVSUtMWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
X-HM-Tid: 0a89bb2b1a3f2eb3kusn46f97400519
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6SQw5Tj1NNCgYDzQsEChO
        ERoKFC1VSlVKTUJKS01JSEpJSkJCVTMWGhIXVRMOGhUcGA4VOwgaFRwdFAlVGBQWVRgVRVlXWRIL
        WUFZSkpIVUpKTVVOSlVJS0xZV1kIAVlBSUNDQjcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a disk fails to attach, the struct rdac_dh_data is released,
but it is not removed from the ctlr->dh_list. When attaching another
disk, the released rdac_dh_data will be accessed and the following
BUG_ON() may be observed:

[  414.696167] scsi 5:0:0:7: rdac: Attach failed (8)
...
[  423.615364] kernel BUG at drivers/scsi/device_handler/scsi_dh_rdac.c:427!
[  423.615731] invalid opcode: 0000 [#1] SMP NOPTI
...
[  423.623247] Call Trace:
[  423.623598]  rdac_bus_attach+0x203/0x4c0
[  423.623949]  ? scsi_dh_handler_attach+0x2d/0x90
[  423.624300]  scsi_dh_handler_attach+0x2d/0x90
[  423.624652]  scsi_sysfs_add_sdev+0x88/0x270
[  423.625004]  scsi_probe_and_add_lun+0xc47/0xd50
[  423.625354]  scsi_report_lun_scan+0x339/0x3b0
[  423.625705]  __scsi_scan_target+0xe9/0x220
[  423.626056]  scsi_scan_target+0xf6/0x100
[  423.626404]  fc_scsi_scan_rport+0xa5/0xb0
[  423.626757]  process_one_work+0x15e/0x3f0
[  423.627106]  worker_thread+0x4c/0x440
[  423.627453]  ? rescuer_thread+0x350/0x350
[  423.627804]  kthread+0xf8/0x130
[  423.628153]  ? kthread_destroy_worker+0x40/0x40
[  423.628509]  ret_from_fork+0x1f/0x40

Fixes: 1a5dc166cd88 ("scsi_dh_rdac: update 'access_state' field")
Signed-off-by: Huang Cun <huangcun@sangfor.com.cn>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
---
 drivers/scsi/device_handler/scsi_dh_rdac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index c5538645057a..9d487c2b7708 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -762,8 +762,10 @@ static int rdac_bus_attach(struct scsi_device *sdev)
 
 clean_ctlr:
 	spin_lock(&list_lock);
+	list_del_rcu(&h->node);
 	kref_put(&h->ctlr->kref, release_controller);
 	spin_unlock(&list_lock);
+	synchronize_rcu();
 
 failed:
 	kfree(h);
-- 
2.27.0

