Return-Path: <linux-kernel+bounces-73310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0179785C0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805991F22595
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8411C763E5;
	Tue, 20 Feb 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2eGfgcZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC932627EA;
	Tue, 20 Feb 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445429; cv=none; b=qwyHh55XcjG++vgRY3Ti7EH/PTh7JeSuF2FCd2LjZQ6DRN6ukXBn9tXMfk+eXrLI2yq0IxkJixLcNru9XGB9UwynIaXM/yc1g4UA7WXEZkOEyP2fQh1MlLwDMXhPRiZ8UEyotvKYYJlCSEw+Jda7DIBz/S1N0+ymuTnEbQQ4eFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445429; c=relaxed/simple;
	bh=CNzdBA3r+z7b6taDaXcDPHncmnNZV0qgR86e1jL2Ve4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfAfWGBM29SvQHlLi68i/9QvC42L0pT9uBXL+UTjVghGo8viV/TJydT5mk2TlWa2GSAGv/a+ejEj+1ILhzzDRsTJdZrv27VmtAOn93gNdT90hOAuF4B9LEkQCrEzJv77tvlbf2g5+Y2YQiNAQAKoX89d4RKPAMc9jqwWWpjZCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2eGfgcZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708445428; x=1739981428;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CNzdBA3r+z7b6taDaXcDPHncmnNZV0qgR86e1jL2Ve4=;
  b=Y2eGfgcZLHAyEUIpZHYcN03MVPzYRnlIAvRdnx1rWLHZxRg4/RhrMmvL
   qPYD+Mw7pHqp5zRFsoeOzhgseDGMV/tpwsaRHlDbvlT/10ToYn/PdVTfz
   U42RJR1USRPEhQVyqKaPTLKAwJiJMKm0PnPs6UqhCDgjd638+vrO6ByHK
   qk7YU+v06uXQCxDb2PbKSkH5jb8KuqHhJf7WtJiRSrvb6Jt39KXOo/RYh
   /AnzWk/jCTErTL63KzghhuHeBQkfwgcwyjUHVrMlFd64y9dUm73xmYr9v
   eXJnhNNxsn8nxj5+baU4GVU9sXxYFntOTsOjvnBeSc8xDx+kICe9vuIBd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2667275"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2667275"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 08:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="936471641"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="936471641"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2024 08:10:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EC77C305; Tue, 20 Feb 2024 18:10:03 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Subject: [PATCH v1 1/1] driver core: Move fw_devlink stuff to where it belongs
Date: Tue, 20 Feb 2024 18:10:02 +0200
Message-ID: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
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

Fixes: b5d3e2fbcb10 ("device property: Add fwnode_is_ancestor_of() and fwnode_get_next_parent_dev()")
Fixes: 372a67c0c5ef ("driver core: Add fwnode_to_dev() to look up device from fwnode")
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
index 0428942093a7..4228c45d5ccc 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -193,7 +193,6 @@ struct fwnode_operations {
 		if (fwnode_has_op(fwnode, op))				\
 			(fwnode)->ops->op(fwnode, ## __VA_ARGS__);	\
 	} while (false)
-#define get_dev_from_fwnode(fwnode)	get_device((fwnode)->dev)
 
 static inline void fwnode_init(struct fwnode_handle *fwnode,
 			       const struct fwnode_operations *ops)
diff --git a/include/linux/property.h b/include/linux/property.h
index 07fbebc73243..1f0135e24d00 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -150,11 +150,9 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);
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


