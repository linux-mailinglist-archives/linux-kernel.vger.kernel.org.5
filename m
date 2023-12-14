Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECCF813064
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573056AbjLNMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573121AbjLNMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:42:13 -0500
X-Greylist: delayed 987 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Dec 2023 04:42:19 PST
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AF6129;
        Thu, 14 Dec 2023 04:42:19 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4SrWkd4XgVz1kvF0;
        Thu, 14 Dec 2023 20:24:41 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
        by mail.maildlp.com (Postfix) with ESMTPS id DCEEE1A0190;
        Thu, 14 Dec 2023 20:25:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 20:25:49 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] scsi: core: add CMD_LAST flag for error handle scsi command
Date:   Thu, 14 Dec 2023 20:29:19 +0800
Message-ID: <20231214122919.985087-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI error handle will send scsi command bypass block layer. After commit
8930a6c20791 scsi support request batching. Some LLD only writing the hardware
doorbell when necessary, after the last request was prepared.
For scsi error handle, each command waits synchronously. So each scsi command
is both the beginning and the end. So add CMD_LAST flag for error handle scsi
command.

Fixes: 8930a6c20791 ("scsi: core: add support for request batching")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/scsi_error.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 1bac12ef238e..9e79047a1250 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1147,6 +1147,7 @@ static enum scsi_disposition scsi_send_eh_cmnd(struct scsi_cmnd *scmd,
 	const unsigned long stall_for = msecs_to_jiffies(100);
 	int rtn;
 
+	scmd->flags |= SCMD_LAST;
 retry:
 	scsi_eh_prep_cmnd(scmd, &ses, cmnd, cmnd_size, sense_bytes);
 	shost->eh_action = &done;
-- 
2.31.1

