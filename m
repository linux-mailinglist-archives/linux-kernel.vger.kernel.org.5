Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0325480F92A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377584AbjLLVZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377566AbjLLVZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:25:19 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57E5BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:25:23 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id DAFkr5m2Q8sqPDAFkrjhwF; Tue, 12 Dec 2023 22:25:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702416321;
        bh=xpWYbHV+Zc60bOBgrL8BoxkuvgOfsZpbRV1LTv1K99o=;
        h=From:To:Cc:Subject:Date;
        b=dOlEDMCfGy6oyhcN71SyY0UC1uniOSPcCj8dGJ3xvnA0SNrc23NXBqau4z3ZwJ1n+
         NotE7DtXrPePRBNAKY+PCmSfSNX5yrMG9Y4rPERkwkKHJMeh3xUWXfxkmpXqknNwVQ
         x4BBduVuQGFZPk90tdSEhuhEEshkPO6rFNn1IflOfHHu9IPTjB/Z5qmv+aOr/oXvri
         9Paxfew/tW9h6zxZP2MnD+3aTCgqd8dXvHHhCbISNY1y5tYB/3ibjodhl5GHZggrXi
         RTpLXvOgFV1RCjaqhmJhg0V01gfCZ08ZZsUOxsSfRobqf8WCSPqKZCGkLIKQ60xvNL
         AwZX3yrbUgTDQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Dec 2023 22:25:21 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org
Subject: [PATCH v2] scsi: myrb: Fix a potential string truncation in rebuild_show() and use sysfs_emit()
Date:   Tue, 12 Dec 2023 22:25:09 +0100
Message-Id: <d2b2a961aa599f509b0903f8dcd331f659a1b562.1702411083.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"physical device - not rebuilding\n" is 34 bytes long. When written in
'buf' with a limit of 32 bytes, it is truncated.

When building with W=1, it leads to:
   drivers/scsi/myrb.c: In function 'rebuild_show':
   drivers/scsi/myrb.c:1906:24: error: 'physical device - not rebuil...' directive output truncated writing 33 bytes into a region of size 32 [-Werror=format-truncation=]
    1906 |                 return snprintf(buf, 32, "physical device - not rebuilding\n");
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/myrb.c:1906:24: note: 'snprintf' output 34 bytes into a destination of size 32


In order to fix it and to avoid hard-coded limits in all _show() functions, use
the preferred sysfs_emit() that knows better about it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v2:
  - Merge patch 1/2 and 2/2

v1:
  https://lore.kernel.org/all/cover.1702411083.git.christophe.jaillet@wanadoo.fr/


Note that there is another warning when building with W=1:
    1051 |                 "%u.%02u-%c-%02u",
         |                 ^~~~~~~~~~~~~~~~~
   drivers/scsi/myrb.c:1050:9: note: 'snprintf' output between 10 and 14 bytes into a destination of size 12

but I think that it is a false positive because snprintf() in Linux does not
strickly folows the standard C behavior of sn

---
 drivers/scsi/myrb.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index ca2380d2d6d3..06a5e6fb9f99 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1767,7 +1767,7 @@ static ssize_t raid_state_show(struct device *dev,
 	int ret;
 
 	if (!sdev->hostdata)
-		return snprintf(buf, 16, "Unknown\n");
+		return sysfs_emit(buf, "Unknown\n");
 
 	if (sdev->channel == myrb_logical_channel(sdev->host)) {
 		struct myrb_ldev_info *ldev_info = sdev->hostdata;
@@ -1775,10 +1775,10 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrb_devstate_name(ldev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = sysfs_emit(buf, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
-				       ldev_info->state);
+			ret = sysfs_emit(buf, "Invalid (%02X)\n",
+					 ldev_info->state);
 	} else {
 		struct myrb_pdev_state *pdev_info = sdev->hostdata;
 		unsigned short status;
@@ -1796,10 +1796,10 @@ static ssize_t raid_state_show(struct device *dev,
 		else
 			name = myrb_devstate_name(pdev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = sysfs_emit(buf, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
-				       pdev_info->state);
+			ret = sysfs_emit(buf, "Invalid (%02X)\n",
+					 pdev_info->state);
 	}
 	return ret;
 }
@@ -1886,11 +1886,11 @@ static ssize_t raid_level_show(struct device *dev,
 
 		name = myrb_raidlevel_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
-					ldev_info->state);
-		return snprintf(buf, 32, "%s\n", name);
+			return sysfs_emit(buf, "Invalid (%02X)\n",
+					  ldev_info->state);
+		return sysfs_emit(buf, "%s\n", name);
 	}
-	return snprintf(buf, 32, "Physical Drive\n");
+	return sysfs_emit(buf, "Physical Drive\n");
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1903,17 +1903,17 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < myrb_logical_channel(sdev->host))
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return sysfs_emit(buf, "physical device - not rebuilding\n");
 
 	status = myrb_get_rbld_progress(cb, &rbld_buf);
 
 	if (rbld_buf.ldev_num != sdev->id ||
 	    status != MYRB_STATUS_SUCCESS)
-		return snprintf(buf, 32, "not rebuilding\n");
+		return sysfs_emit(buf, "not rebuilding\n");
 
-	return snprintf(buf, 32, "rebuilding block %u of %u\n",
-			rbld_buf.ldev_size - rbld_buf.blocks_left,
-			rbld_buf.ldev_size);
+	return sysfs_emit(buf, "rebuilding block %u of %u\n",
+			  rbld_buf.ldev_size - rbld_buf.blocks_left,
+			  rbld_buf.ldev_size);
 }
 
 static ssize_t rebuild_store(struct device *dev,
@@ -2140,7 +2140,7 @@ static ssize_t ctlr_num_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrb_hba *cb = shost_priv(shost);
 
-	return snprintf(buf, 20, "%u\n", cb->ctlr_num);
+	return sysfs_emit(buf, "%u\n", cb->ctlr_num);
 }
 static DEVICE_ATTR_RO(ctlr_num);
 
@@ -2150,7 +2150,7 @@ static ssize_t firmware_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrb_hba *cb = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", cb->fw_version);
+	return sysfs_emit(buf, "%s\n", cb->fw_version);
 }
 static DEVICE_ATTR_RO(firmware);
 
@@ -2160,7 +2160,7 @@ static ssize_t model_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrb_hba *cb = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", cb->model_name);
+	return sysfs_emit(buf, "%s\n", cb->model_name);
 }
 static DEVICE_ATTR_RO(model);
 
-- 
2.34.1

