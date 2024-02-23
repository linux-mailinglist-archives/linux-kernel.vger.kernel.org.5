Return-Path: <linux-kernel+bounces-78652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD2986168F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9415F283753
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1800383CB8;
	Fri, 23 Feb 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1BXG7/B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94882C94;
	Fri, 23 Feb 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703868; cv=none; b=aF3EI00sD3Deq0hEigsrYuSdykV3BlcBcANZ4AvyIVXqUM2gzlfkaBVKnG/7FBVEsDJZhoY+3YAc+YhCZHDr//FcEuAMCkrGgz5VoJr3BPTThzqNci0imla61FXoqif+xBicwaUBfvhmOvThztWfwswQDFkmxJbg1XZQ87oalwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703868; c=relaxed/simple;
	bh=gqrb+PGYOs5LLfSJLIoNp2Y40YeJ+CmorKnMSDQ5124=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hj4dFTk1hxFdE5xMpKqqqnJRg/qSNNM/O9FOTWmag+lW72NlQxnEjGWQzTgqzP8mhz0WAzwZ+V0GmUvSLAC8oQMDihD5AsG5qdiDowiOxQ222KKMG/XJswRFhm+ph7hmvsyFxEIk/OXRFZItgDujV8cCeazFf1cEETfKn8AIS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1BXG7/B; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703867; x=1740239867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqrb+PGYOs5LLfSJLIoNp2Y40YeJ+CmorKnMSDQ5124=;
  b=e1BXG7/BR0FwHA5zlSBrY6vGKPhCYvjUd3rT544mRebBn2ZjwXccK952
   B1g+eyCIvpfU6kuWgGshKs2AG7NXBL3jenQS6/yv3uW+tqyVOT3xKivFn
   5n++o03lWq7T6rwarwV41Pk0KjETrNtw0G+2l106qV3AYSY1Abed2K9zp
   RPTo3Jh2a7xs85ok4VAMiMxaW/K64x9oQGcjz9CDVolo8oosIvCPalfoe
   wNi+v9Nd1lQsN8uR+WA23i8OW1t1wqYNKoQ42i3hYXyGdDYiob0whsZQd
   RXirpt/DS6l2NIEclZ7byGlFaBF8JnMn/AWVorXD8z+hnKzLE6Pww1K+O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3187534"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3187534"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025346"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025346"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 07:57:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1F1E34F1; Fri, 23 Feb 2024 17:57:40 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 2/4] driver core: Move fw_devlink stuff to where it belongs
Date: Fri, 23 Feb 2024 17:54:37 +0200
Message-ID: <20240223155731.858412-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240223155731.858412-1-andriy.shevchenko@linux.intel.com>
References: <20240223155731.858412-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few APIs that belong specifically to the fw_devlink APIs
- are exposed to others without need
- prevents device property code to be cleaned up in the future

Resolve this mess by moving fw_devlink code to where it belongs
and hide from others.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c      | 58 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/property.c  | 56 --------------------------------------
 include/linux/fwnode.h   |  1 -
 include/linux/property.h |  2 --
 4 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 9828da9b933c..35ccd8bb2c9b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1871,6 +1871,7 @@ static void fw_devlink_unblock_consumers(struct device *dev)
 	device_links_write_unlock();
 }
 
+#define get_dev_from_fwnode(fwnode)	get_device((fwnode)->dev)
 
 static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
 {
@@ -1901,6 +1902,63 @@ static bool fwnode_ancestor_init_without_drv(struct fwnode_handle *fwnode)
 	return false;
 }
 
+/**
+ * fwnode_is_ancestor_of - Test if @ancestor is ancestor of @child
+ * @ancestor: Firmware which is tested for being an ancestor
+ * @child: Firmware which is tested for being the child
+ *
+ * A node is considered an ancestor of itself too.
+ *
+ * Return: true if @ancestor is an ancestor of @child. Otherwise, returns false.
+ */
+static bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor,
+				  const struct fwnode_handle *child)
+{
+	struct fwnode_handle *parent;
+
+	if (IS_ERR_OR_NULL(ancestor))
+		return false;
+
+	if (child == ancestor)
+		return true;
+
+	fwnode_for_each_parent_node(child, parent) {
+		if (parent == ancestor) {
+			fwnode_handle_put(parent);
+			return true;
+		}
+	}
+	return false;
+}
+
+/**
+ * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
+ * @fwnode: firmware node
+ *
+ * Given a firmware node (@fwnode), this function finds its closest ancestor
+ * firmware node that has a corresponding struct device and returns that struct
+ * device.
+ *
+ * The caller is responsible for calling put_device() on the returned device
+ * pointer.
+ *
+ * Return: a pointer to the device of the @fwnode's closest ancestor.
+ */
+static struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent;
+	struct device *dev;
+
+	fwnode_for_each_parent_node(fwnode, parent) {
+		dev = get_dev_from_fwnode(parent);
+		if (dev) {
+			fwnode_handle_put(parent);
+			return dev;
+		}
+	}
+	return NULL;
+}
+
 /**
  * __fw_devlink_relax_cycles - Relax and mark dependency cycles.
  * @con: Potential consumer device.
diff --git a/drivers/base/property.c b/drivers/base/property.c
index a1b01ab42052..afa1bf2b3c5a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -699,34 +699,6 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
 
-/**
- * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
- * @fwnode: firmware node
- *
- * Given a firmware node (@fwnode), this function finds its closest ancestor
- * firmware node that has a corresponding struct device and returns that struct
- * device.
- *
- * The caller is responsible for calling put_device() on the returned device
- * pointer.
- *
- * Return: a pointer to the device of the @fwnode's closest ancestor.
- */
-struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fwnode)
-{
-	struct fwnode_handle *parent;
-	struct device *dev;
-
-	fwnode_for_each_parent_node(fwnode, parent) {
-		dev = get_dev_from_fwnode(parent);
-		if (dev) {
-			fwnode_handle_put(parent);
-			return dev;
-		}
-	}
-	return NULL;
-}
-
 /**
  * fwnode_count_parents - Return the number of parents a node has
  * @fwnode: The node the parents of which are to be counted
@@ -773,34 +745,6 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 
-/**
- * fwnode_is_ancestor_of - Test if @ancestor is ancestor of @child
- * @ancestor: Firmware which is tested for being an ancestor
- * @child: Firmware which is tested for being the child
- *
- * A node is considered an ancestor of itself too.
- *
- * Return: true if @ancestor is an ancestor of @child. Otherwise, returns false.
- */
-bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor, const struct fwnode_handle *child)
-{
-	struct fwnode_handle *parent;
-
-	if (IS_ERR_OR_NULL(ancestor))
-		return false;
-
-	if (child == ancestor)
-		return true;
-
-	fwnode_for_each_parent_node(child, parent) {
-		if (parent == ancestor) {
-			fwnode_handle_put(parent);
-			return true;
-		}
-	}
-	return false;
-}
-
 /**
  * fwnode_get_next_child_node - Return the next child node handle for a node
  * @fwnode: Firmware node to find the next child node for.
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2d23a14857c7..416cbe72f0c7 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -187,7 +187,6 @@ struct fwnode_operations {
 		if (fwnode_has_op(fwnode, op))				\
 			(fwnode)->ops->op(fwnode, ## __VA_ARGS__);	\
 	} while (false)
-#define get_dev_from_fwnode(fwnode)	get_device((fwnode)->dev)
 
 static inline void fwnode_init(struct fwnode_handle *fwnode,
 			       const struct fwnode_operations *ops)
diff --git a/include/linux/property.h b/include/linux/property.h
index e6516d0b7d52..284ff79ebf03 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -156,11 +156,9 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);
 	for (parent = fwnode_get_parent(fwnode); parent;	\
 	     parent = fwnode_get_next_parent(parent))
 
-struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fwnode);
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
 					    unsigned int depth);
-bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor, const struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
-- 
2.43.0.rc1.1.gbec44491f096


