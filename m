Return-Path: <linux-kernel+bounces-87082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBBC86CF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135F5288EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20C67A13C;
	Thu, 29 Feb 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLIYjEPx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E34AEC8;
	Thu, 29 Feb 2024 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224078; cv=none; b=J/WzwuCmrFng/7eUO2y79pMScFpcWZwc7HjDp24kXxZT4cundvi7mg74TLgMkURu7mUQYv3mA1gnF04Be1CI9Jjlw1mgR5bOAI1rU2x/LcZcjfgKZp13jNNqHeKcFrGpatBacSBY7Ghn2BMCyLgiPhodzUGW09OYpFSSrknm3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224078; c=relaxed/simple;
	bh=FWCxX58oaTp/I5tWymdZXgSX0/MgNSs17Vpy+x3zz+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx1hYF8rxB1zBjfoUHgPogyn2haoiybX29rHgFx2+bIpNF3xX1gqCP255YNHC15X9TPrW1nmX2rkSIUULOeW+MklGow5mP9te7b9alOoT3qPBzEhMQNe6d/+5emxrdR/MZb7pRTBdCiGzWJAQKNz0HQ5PwYfAuJnF+dqjygYS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLIYjEPx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709224076; x=1740760076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FWCxX58oaTp/I5tWymdZXgSX0/MgNSs17Vpy+x3zz+0=;
  b=mLIYjEPx7Lm9tqa7f8tPQNBAxUhupAkG/Vr03l2/D7nYI+2Q1h2OyBdL
   Dhfcm+lJjoewkKgbmuLGOBcUmfZK+05VVjxtKM1t8jVmOixnxZ5XAkylL
   EZMYeWNeD7gBZMGxAZSe8BKANnSDOcvfkhw4Imlr43M/dJcXRteYZUDHK
   v69w73caJePznmaNOTLqH0ITuPtU2ojgf9MGaSPDYuj16jM8VNnvCLW6H
   kgMVnoUIUWPdX5QHI8SyECyNz9veIp9J6F1bSpH8U6cPbvEP7eBiPPDNJ
   w0YejxSAzDXdVxFQbjgfOlLv/+CfBWnCvx+JlBRJ6jBOuYIcBt3nSEUlL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="6660694"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="6660694"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:27:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937036139"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036139"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 08:27:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A0C48476; Thu, 29 Feb 2024 18:27:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 2/4] driver core: Move fw_devlink stuff to where it belongs
Date: Thu, 29 Feb 2024 18:23:44 +0200
Message-ID: <20240229162741.3854912-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240229162741.3854912-1-andriy.shevchenko@linux.intel.com>
References: <20240229162741.3854912-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few APIs, i.e. fwnode_is_ancestor_of(), fwnode_get_next_parent_dev(),
and get_dev_from_fwnode(), that belong specifically to the fw_devlink APIs,
may be static, but they are not.

Resolve this mess by moving them to the driver/base/core where the all
users are being resided and make static.

No functional changes intended.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
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
index 53e42031c646..d983a4dea105 100644
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
index eefd662a2f9d..420420a1d8ad 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -157,11 +157,9 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);
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


