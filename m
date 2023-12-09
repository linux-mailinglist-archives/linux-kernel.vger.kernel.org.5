Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D6180B3ED
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 12:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjLILTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 06:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLILTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 06:19:18 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B92910D8;
        Sat,  9 Dec 2023 03:19:23 -0800 (PST)
Received: from localhost.localdomain (unknown [46.242.8.170])
        by mail.ispras.ru (Postfix) with ESMTPSA id 61BDE400CBDC;
        Sat,  9 Dec 2023 11:19:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 61BDE400CBDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1702120760;
        bh=odq4MrakWESK/R0F/Uy9J0JMTX/2+rbQ0CI8lN5aBHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=I+zLitdMGwY0lck2CkXo2mrldGQO4nakM7w/WDRRft6Py2+4wvuucp5bPls9vgdDf
         2Oha2DFT77/GNJoLVxFC7w1uTEPKoE1sk3AiPcJx0+ckXqcOudEwAznuz1/rmNcnbz
         SeQ4W7SfQ1C7n41e/c1slG0BMdLTI+snqwGXSAgk=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Don Brace <don.brace@microchip.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alex Chiang <achiang@hp.com>,
        Mike Miller <mikem@beardog.cce.hp.com>,
        "Stephen M. Cameron" <scameron@beardog.cce.hp.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] scsi: hpsa: prevent memory leak in hpsa_big_passthru_ioctl
Date:   Sat,  9 Dec 2023 14:18:56 +0300
Message-ID: <20231209111857.19393-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case copy_from_user() fails during the buffers allocating loop inside
hpsa_big_passthru_ioctl(), the last allocated buffer (accessed by sg_used
index) is not freed on cleanup1 error path as sg_used index has not been
incremented yet.

Free the last allocated buffer directly if copy_from_user() fails.

Found by Linux Verification Center (linuxtesting.org).

Fixes: edd163687ea5 ("[SCSI] hpsa: add driver for HP Smart Array controllers.")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/scsi/hpsa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..897f9ee3c004 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6536,6 +6536,7 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h,
 		if (ioc->Request.Type.Direction & XFER_WRITE) {
 			if (copy_from_user(buff[sg_used], data_ptr, sz)) {
 				status = -EFAULT;
+				kfree(buff[sg_used]);
 				goto cleanup1;
 			}
 		} else
-- 
2.43.0

