Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE780F78D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjLLUJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377223AbjLLUJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:09:31 -0500
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAC7106
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:09:37 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id D94JrCWy533VXD94SrOSjJ; Tue, 12 Dec 2023 21:09:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702411777;
        bh=rzREpo573xITBwLatd+AesvCg1dKu2ILxitSwm0Do8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RGxW9X+6QDlJlLBQUcA0lWPDbyVrN+Ae0d6pwDAbQdujnkefi4YWvtQbTzqxFptlB
         FKOmfm705tYk4vrD31LDkEgjlMBPgwlE6UTx7d8+vgYO1dEw/eq7bDtk1i0rJSJN+B
         8+LRn+HcTE2JeRN3Q2AMeZJOzLejifNqiBHw/MWY+Ue0EN0An9XxI1IUca3HK0Vu/O
         hTj7Oh+4SAeo2VeUragI2IzNfRbc82l8/yTrEzzM8MtUJ8RyXxapru+nZ+PvWtlxAN
         n0OZzi5Jn4CbcBdpMh4yjQXIvw223y4YIJ3jGi+IkO4ZwWgJz8Qu3m0cy7XAc8DRsz
         KFi9s/7B3Kvbg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Dec 2023 21:09:37 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hare@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     hare@suse.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] scsi: myrb: Fix a potential string truncation in rebuild_show()
Date:   Tue, 12 Dec 2023 21:09:10 +0100
Message-Id: <2d3096dd4b1b6e758287e4062e3147c57c007eaa.1702411083.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1702411083.git.christophe.jaillet@wanadoo.fr>
References: <cover.1702411083.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"physical device - not rebuilding\n" is 34 bytes long. When written in
'buf' with a limit of 32 bytes, it is truncated.

When building with W=1, it leads to:
   drivers/scsi/myrb.c: In function ‘rebuild_show’:
   drivers/scsi/myrb.c:1906:24: error: ‘physical device - not rebuil...’ directive output truncated writing 33 bytes into a region of size 32 [-Werror=format-truncation=]
    1906 |                 return snprintf(buf, 32, "physical device - not rebuilding\n");
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/myrb.c:1906:24: note: ‘snprintf’ output 34 bytes into a destination of size 32

Change the allowed size to 64 to fix the issue.

Fixes: 081ff398c56c ("scsi: myrb: Add Mylex RAID controller (block interface)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/myrb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index ca2e932dd9b7..ca2380d2d6d3 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1903,15 +1903,15 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < myrb_logical_channel(sdev->host))
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return snprintf(buf, 64, "physical device - not rebuilding\n");
 
 	status = myrb_get_rbld_progress(cb, &rbld_buf);
 
 	if (rbld_buf.ldev_num != sdev->id ||
 	    status != MYRB_STATUS_SUCCESS)
-		return snprintf(buf, 32, "not rebuilding\n");
+		return snprintf(buf, 64, "not rebuilding\n");
 
-	return snprintf(buf, 32, "rebuilding block %u of %u\n",
+	return snprintf(buf, 64, "rebuilding block %u of %u\n",
 			rbld_buf.ldev_size - rbld_buf.blocks_left,
 			rbld_buf.ldev_size);
 }
-- 
2.34.1

