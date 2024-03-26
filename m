Return-Path: <linux-kernel+bounces-120085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE388D15A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3DB5B24AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDCE13DBBE;
	Tue, 26 Mar 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds06LGvP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598113E8B1;
	Tue, 26 Mar 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492863; cv=none; b=NglonPSZUhmJasQqAmSjxpZKqKDtlNR7/gR/hl+TOV1OjV0hnSUfL7cq1LmVxmxQmqfV7vVENyPLpYPPKVVJBEncwJq+RjXT3YKGgUwIhH08GJByYog1hFwqrV7AFxqIJUqhedvvlOcboLOBmVAGp1v4z8+8EzkvmVaAbN+mpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492863; c=relaxed/simple;
	bh=6TL/XYClRKFhuMXHi313KECyg4EV2GY5zSWVL7+tLGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THVvTA0Ih/Z4P5dc8Xhfxhqmk3o0y3MlQCOdAaqmD4wK9bHKvFbIjxKiL++EGNnSeuDetyygGCM/ZV2/1DWdzP1mKpn2iKVe63/7Crexf3Dr1xEir7ZUiCVaTyhWcAVOQSMP+gGfMuP2O5zRAG/Gy4zn5jGEYQRtaCR7FrVG9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds06LGvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96523C433F1;
	Tue, 26 Mar 2024 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492863;
	bh=6TL/XYClRKFhuMXHi313KECyg4EV2GY5zSWVL7+tLGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ds06LGvPd0l5RyCqb2XiZaemnyLBs7bntJWrcE60bd+e+5O1j618Bs5AN5pwQYxJx
	 +283FYQcjVlCmDxzYOTgFn1rQPMlRcae2Y3CyhyoFU9hsdsLCOzJXb5khUoM2xv8rh
	 vk07jEb4jHFQP0OUU28CdxwlNZw5mi0pf+gY46qDsDeeKNzGZjZsGsPm9xX2obyxmZ
	 9DIxU7gT1623GFxIg+5+mM3k8KlUKcR7lVVsfbB58t2vKI6af8ISvFmxE9hcJavJEU
	 MK0nDJL894ramgqgz2ODdI/AbbQWQTC+XNPcGObZ/NP1R2tZqtV9kthus38o+3jJgD
	 L8XXjEpouITTA==
From: Arnd Bergmann <arnd@kernel.org>
To: llvm@lists.linux.dev,
	Hannes Reinecke <hare@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] scsi: mylex: fix sysfs buffer lengths
Date: Tue, 26 Mar 2024 23:38:06 +0100
Message-Id: <20240326223825.4084412-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The myrb and myrs drivers use an odd way of implementing their sysfs files,
calling snprintf() with a fixed length of 32 bytes to print into a page
sized buffer. One of the strings is actually longer than 32 bytes, which
clang can warn about:

drivers/scsi/myrb.c:1906:10: error: 'snprintf' will always be truncated; specified size is 32, but format string expands to at least 34 [-Werror,-Wformat-truncation]
drivers/scsi/myrs.c:1089:10: error: 'snprintf' will always be truncated; specified size is 32, but format string expands to at least 34 [-Werror,-Wformat-truncation]

These could all be plain sprintf() without a length as the buffer is
always long enough. On the other hand, sysfs files should not be overly
long either, so just double the length to make sure the longest strings
don't get truncated here.

Fixes: 77266186397c ("scsi: myrs: Add Mylex RAID controller (SCSI interface)")
Fixes: 081ff398c56c ("scsi: myrb: Add Mylex RAID controller (block interface)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/myrb.c | 20 ++++++++++----------
 drivers/scsi/myrs.c | 24 ++++++++++++------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index ca2e932dd9b7..f684eb5e0489 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1775,9 +1775,9 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrb_devstate_name(ldev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       ldev_info->state);
 	} else {
 		struct myrb_pdev_state *pdev_info = sdev->hostdata;
@@ -1796,9 +1796,9 @@ static ssize_t raid_state_show(struct device *dev,
 		else
 			name = myrb_devstate_name(pdev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       pdev_info->state);
 	}
 	return ret;
@@ -1886,11 +1886,11 @@ static ssize_t raid_level_show(struct device *dev,
 
 		name = myrb_raidlevel_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
+			return snprintf(buf, 64, "Invalid (%02X)\n",
 					ldev_info->state);
-		return snprintf(buf, 32, "%s\n", name);
+		return snprintf(buf, 64, "%s\n", name);
 	}
-	return snprintf(buf, 32, "Physical Drive\n");
+	return snprintf(buf, 64, "Physical Drive\n");
 }
 static DEVICE_ATTR_RO(raid_level);
 
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
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index a1eec65a9713..e824be9d9bbb 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -947,9 +947,9 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrs_devstate_name(ldev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       ldev_info->dev_state);
 	} else {
 		struct myrs_pdev_info *pdev_info;
@@ -958,9 +958,9 @@ static ssize_t raid_state_show(struct device *dev,
 		pdev_info = sdev->hostdata;
 		name = myrs_devstate_name(pdev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       pdev_info->dev_state);
 	}
 	return ret;
@@ -1066,13 +1066,13 @@ static ssize_t raid_level_show(struct device *dev,
 		ldev_info = sdev->hostdata;
 		name = myrs_raid_level_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
+			return snprintf(buf, 64, "Invalid (%02X)\n",
 					ldev_info->dev_state);
 
 	} else
 		name = myrs_raid_level_name(MYRS_RAID_PHYSICAL);
 
-	return snprintf(buf, 32, "%s\n", name);
+	return snprintf(buf, 64, "%s\n", name);
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1086,7 +1086,7 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return snprintf(buf, 64, "physical device - not rebuilding\n");
 
 	ldev_info = sdev->hostdata;
 	ldev_num = ldev_info->ldev_num;
@@ -1098,11 +1098,11 @@ static ssize_t rebuild_show(struct device *dev,
 		return -EIO;
 	}
 	if (ldev_info->rbld_active) {
-		return snprintf(buf, 32, "rebuilding block %zu of %zu\n",
+		return snprintf(buf, 64, "rebuilding block %zu of %zu\n",
 				(size_t)ldev_info->rbld_lba,
 				(size_t)ldev_info->cfg_devsize);
 	} else
-		return snprintf(buf, 32, "not rebuilding\n");
+		return snprintf(buf, 64, "not rebuilding\n");
 }
 
 static ssize_t rebuild_store(struct device *dev,
@@ -1190,7 +1190,7 @@ static ssize_t consistency_check_show(struct device *dev,
 	unsigned short ldev_num;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not checking\n");
+		return snprintf(buf, 64, "physical device - not checking\n");
 
 	ldev_info = sdev->hostdata;
 	if (!ldev_info)
@@ -1198,11 +1198,11 @@ static ssize_t consistency_check_show(struct device *dev,
 	ldev_num = ldev_info->ldev_num;
 	myrs_get_ldev_info(cs, ldev_num, ldev_info);
 	if (ldev_info->cc_active)
-		return snprintf(buf, 32, "checking block %zu of %zu\n",
+		return snprintf(buf, 64, "checking block %zu of %zu\n",
 				(size_t)ldev_info->cc_lba,
 				(size_t)ldev_info->cfg_devsize);
 	else
-		return snprintf(buf, 32, "not checking\n");
+		return snprintf(buf, 64, "not checking\n");
 }
 
 static ssize_t consistency_check_store(struct device *dev,
-- 
2.39.2


