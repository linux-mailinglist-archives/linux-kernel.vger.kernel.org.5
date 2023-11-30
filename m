Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329D37FEFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjK3NEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjK3NEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:04:11 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C7F10D1;
        Thu, 30 Nov 2023 05:04:17 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SgxBW1K0WzsRS5;
        Thu, 30 Nov 2023 21:00:35 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Thu, 30 Nov 2023 21:04:15 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wubo40@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH] scsi: libsas: Put the disk offline if all recovery actions fail
Date:   Thu, 30 Nov 2023 13:01:18 +0000
Message-ID: <20231130130118.14367-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, after all recovery actions in sas_eh_handle_sas_errors() fail
for sas disk, we just clear all IO, but the disk is still online. Perhaps
we should continue the subsequent recovery process for IO that cannot be
processed. If it still fails, the disk will be offline in
scsi_eh_ready_devs().

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Bo Wu <wubo40@huawei.com>
---
 drivers/scsi/libsas/sas_scsi_host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 9047cfcd1072..3f9b99fa1769 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -637,8 +637,8 @@ static void sas_eh_handle_sas_errors(struct Scsi_Host *shost, struct list_head *
 			       SAS_ADDR(task->dev->sas_addr),
 			       cmd->device->lun);
 
-			sas_eh_finish_cmd(cmd);
-			goto clear_q;
+			list_move_tail(&cmd->eh_entry, work_q);
+			goto out;
 		}
 	}
  out:
-- 
2.17.1

