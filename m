Return-Path: <linux-kernel+bounces-63420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F44852F08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE150B23A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ABA39852;
	Tue, 13 Feb 2024 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gINsw+/o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB038DDA;
	Tue, 13 Feb 2024 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823266; cv=none; b=ZQscZPzLNq2oBZh7VYnbg3w/Yht7Nms6KmQ1iWjUCF/I2srKqaI+/8yLDj43gqJzAsl5j9axaSRhTxQpO8KWvLpgtEPnVXn4xNZ124Zk4gKBDWGpcki5jw8B6Ws7bM+nTXcEuUPllmdUSmFEYB29dyxsq6yCOflG9/mPO/3t4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823266; c=relaxed/simple;
	bh=AJUvsaAkLNAUPAonfLONk+9L24hzUQDc/XjcjTFJY20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1MuamCcXdOxZmKYM+Lyh8Q3Sg/l04t/NrFhveaMwugPMA8vsvrDqzvKDdMwAw6b5+eLE8/mVRxlOFtjky2qqTsn2WxWMtvh+7JQH19V1eclpQ3rB+WtB+6aVDU2p1rReR2/wW4OTvuKBgEgAGbae9RiWFi8i0WusNngx86TBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gINsw+/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB56C433A6;
	Tue, 13 Feb 2024 11:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707823266;
	bh=AJUvsaAkLNAUPAonfLONk+9L24hzUQDc/XjcjTFJY20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gINsw+/oQJgINmHlycAYC0R3r8NXr5g9zkuO0zwnXp81idnMQ6otWGVm7Q/+FCgHt
	 G61Jbclb/g4gHqOCnRe9AXbhNSEhCReCkmBpGbQlZIIIRsIR+MayCmuj+Vc0MxCYQt
	 lWPKqsT0g9hWOk0HU2NapD7qTUdQgS4PVs0g9GIhvIoPVuAsk5OyWO8FXieT8bc982
	 7Kbp9CZhXD0CJhzuXT+s7/JBBoQw/dov5BDIb7nMJqX8LpepsnzvIcAmaShMFm1NrT
	 6tq6bPw4kOVN2ufsalsUHAvGj5nQagWvdzzo7RcFtN2+8XCv4rDqZPC5l/MkuRcNM2
	 EZe0QHRpWL1yA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH 3/7] EDAC/device: Remove edac_dev_sysfs_block_attribute::store()
Date: Tue, 13 Feb 2024 12:20:47 +0100
Message-ID: <20240213112051.27715-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213112051.27715-1-jirislaby@kernel.org>
References: <20240213112051.27715-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Noone uses this store hook (both BLOCK_ATTR() pass NULL). It actually
never was since its addition in fd309a9d8e63e (drivers/edac: fix leaf
sysfs attribute), so drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/edac_device.c       |  1 -
 drivers/edac/edac_device.h       |  9 +++------
 drivers/edac/edac_device_sysfs.c | 22 +++-------------------
 3 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 0e18729111d4..8c2aa5bcf1b7 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -160,7 +160,6 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 				 */
 				attrib->attr = attrib_spec[attr].attr;
 				attrib->show = attrib_spec[attr].show;
-				attrib->store = attrib_spec[attr].store;
 
 				edac_dbg(4, "alloc-attrib=%p attrib_name='%s' attrib-spec=%p spec-name=%s\n",
 					 attrib, attrib->attr.name,
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index c4704b5b1e9f..a39752432c90 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -95,16 +95,13 @@ struct edac_dev_sysfs_attribute {
  *
  *	used in leaf 'block' nodes for adding controls/attributes
  *
- *	each block in each instance of the containing control structure
- *	can have an array of the following. The show and store functions
- *	will be filled in with the show/store function in the
- *	low level driver.
+ *	each block in each instance of the containing control structure can
+ *	have an array of the following. The show function will be filled in
+ *	with the show function in the low level driver.
  */
 struct edac_dev_sysfs_block_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct kobject *, struct attribute *, char *);
-	ssize_t (*store)(struct kobject *, struct attribute *,
-			const char *, size_t);
 };
 
 /* device block control structure */
diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 237a542e045a..fcebc4ffea26 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -457,35 +457,19 @@ static ssize_t edac_dev_block_show(struct kobject *kobj,
 	return -EIO;
 }
 
-/* Function to 'store' fields into the edac_dev 'block' structure */
-static ssize_t edac_dev_block_store(struct kobject *kobj,
-				struct attribute *attr,
-				const char *buffer, size_t count)
-{
-	struct edac_dev_sysfs_block_attribute *block_attr;
-
-	block_attr = to_block_attr(attr);
-
-	if (block_attr->store)
-		return block_attr->store(kobj, attr, buffer, count);
-	return -EIO;
-}
-
 /* edac_dev file operations for a 'block' */
 static const struct sysfs_ops device_block_ops = {
 	.show = edac_dev_block_show,
-	.store = edac_dev_block_store
 };
 
-#define BLOCK_ATTR(_name,_mode,_show,_store)        \
+#define BLOCK_ATTR(_name,_mode,_show)        \
 static struct edac_dev_sysfs_block_attribute attr_block_##_name = {	\
 	.attr = {.name = __stringify(_name), .mode = _mode },   \
 	.show   = _show,                                        \
-	.store  = _store,                                       \
 };
 
-BLOCK_ATTR(ce_count, S_IRUGO, block_ce_count_show, NULL);
-BLOCK_ATTR(ue_count, S_IRUGO, block_ue_count_show, NULL);
+BLOCK_ATTR(ce_count, S_IRUGO, block_ce_count_show);
+BLOCK_ATTR(ue_count, S_IRUGO, block_ue_count_show);
 
 /* list of edac_dev 'block' attributes */
 static struct attribute *device_block_attrs[] = {
-- 
2.43.1


