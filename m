Return-Path: <linux-kernel+bounces-129993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF53E8972F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E80F1C26D2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D720D148853;
	Wed,  3 Apr 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqVO8mi6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9C3D96B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155586; cv=none; b=Gq9es2ukOI4M9Yl5mCu0k4sYjmAywNZdL2oxWJiCXJEieTwCeYsUdKcpNUeWg/KIQQNdOtpbODYIeWPeUh96Giv6hfasd1m10cRzXZU5xwyO9qfs2HRinbOBeVqhZ99nawfJ9YKZmMUKOOhXZsltk4kOUXI61OYQNEN28PxmiWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155586; c=relaxed/simple;
	bh=iXfkn6tlzHgEi8p4fcrD1FqQo5QaWYTavx5IREW3bL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3VPWjgvJAPPe/42horwCnI3mnNDbOh5Ej8c2qQ4jnx7qJwKJ684SPMNOz7J4q00Bx+gnZfuLSr+eaNjC2E4AjlyvJXQt8zO03rZXwKmURu/U0z1eTd+eV3Zz4DPvWyPw2H5ANb41eS7/U32TtV2LM5xHQyagJBQsjSrUXv7M0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqVO8mi6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712155584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=36rgHUW4mlS5CJzuprxEn9XLg/nzSBTDLDteo2oJtSc=;
	b=CqVO8mi6DmEZl5WL6ymihiJmhx25kZJw51O5HLXlsCcC3KcJYK0xmkgpUGFxixSILkcyDb
	gwgt3eAE3ellpDSgVhiFyCcbDZsTAgFaWcpKYuRrbH5Y+0xSSkr09qELBunsPN3fO6qmmX
	0b7GlY+4NNY4QMAtunIcS9HjwMbL47s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-DlZYsypINWu1BiSvaYhAug-1; Wed, 03 Apr 2024 10:46:21 -0400
X-MC-Unique: DlZYsypINWu1BiSvaYhAug-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d83d5ea8dfso7266531fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712155580; x=1712760380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36rgHUW4mlS5CJzuprxEn9XLg/nzSBTDLDteo2oJtSc=;
        b=Ilv/l1ME9mtNU1OXMB+VmaeJvQtvu4CKVAIdF9VWOuhrGeRVfDGBy7OJzRI7A0EfvJ
         6IrOkSu6FIFxvoRz+f/8vmlfohULcy567nBuLLC+Joe1oA9mCFSmO6yEITlEDV+etijU
         mo0z1pkluAwxPNJxSR1wx2Kae4UQGe279EiCz79e2B3gN8EMUnUyS/dMwcxva/lIrv5e
         3JMC/D7tbEQkYT0ked/GftcA7SaujoCeLrgWrmkwqF6oNSUDRMgga/Hmjk6Vn57tCY3B
         YlyFuxH9qn5Spt+SbClg9y96gGfXXLzcQkX5ZtdUYjKAtlMJgrlxJQMZkdFA4cyQQyJx
         VVsw==
X-Forwarded-Encrypted: i=1; AJvYcCWVZTdijOM08Fzsflb3tTEjbctl2767DPekF2WynHL9u4G1vHh1eCQy02yf1C2HRRBO8IpSRp2uL2ChlQgszXT3fabnIqjn/q9ApY5S
X-Gm-Message-State: AOJu0Yy1QbyDgbrrnx1VYIYmhvP44bzanAblN50VpnlfygR/Ked2WHAK
	KDfWrVFh3HjxA9mBbNZ0xcTD86PEH9479e5BbK/eAWqifPT5yohEBZJZglFApNZ228RnpoSd6Xv
	ayMxh1/aW4Z6OQUaDhnNNAF5HZKYWM8Gf0W+XhpTWmIpVFTzvLhu1KUsjXkAe
X-Received: by 2002:a2e:a7c3:0:b0:2d6:b0b5:bb12 with SMTP id x3-20020a2ea7c3000000b002d6b0b5bb12mr11892051ljp.18.1712155580143;
        Wed, 03 Apr 2024 07:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN7xtuA8RNSKVqk3Sryc3NUfsO3fn1pbRL8NonlS1IrROaX3XH0jdDaZ8DczfFifHlrJHalg==
X-Received: by 2002:a2e:a7c3:0:b0:2d6:b0b5:bb12 with SMTP id x3-20020a2ea7c3000000b002d6b0b5bb12mr11892032ljp.18.1712155579609;
        Wed, 03 Apr 2024 07:46:19 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-25-239.cust.vodafonedsl.it. [2.34.25.239])
        by smtp.gmail.com with ESMTPSA id l10-20020a1c790a000000b0041622c5c5d5sm1412636wme.1.2024.04.03.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:46:19 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alan Tull <atull@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	Russ Weight <russ.weight@linux.dev>,
	linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] fpga: region: add owner module and take its refcount
Date: Wed,  3 Apr 2024 16:46:09 +0200
Message-ID: <20240403144611.65507-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of the fpga region assumes that the low-level
module registers a driver for the parent device and uses its owner pointer
to take the module's refcount. This approach is problematic since it can
lead to a null pointer dereference while attempting to get the region
during programming if the parent device does not have a driver.

To address this problem, add a module owner pointer to the fpga_region
struct and use it to take the module's refcount. Modify the functions for
registering a region to take an additional owner module parameter and
rename them to avoid conflicts. Use the old function names for helper
macros that automatically set the module that registers the region as the
owner. This ensures compatibility with existing low-level control modules
and reduces the chances of registering a region without setting the owner.

Also, update the documentation to keep it consistent with the new interface
for registering an fpga region.

Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Russ Weight <russ.weight@linux.dev>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---

v4:
- Split out the swap between put_device() and mutex_unlock() while
  releasing the region to avoid potential use after release issues
v3:
- Add reviewed-by Russ Weight
v2:
- Fixed typo in the documentation sets -> set
- Renamed owner pointer get_br_owner -> br_owner
---
 Documentation/driver-api/fpga/fpga-region.rst | 13 ++++++----
 drivers/fpga/fpga-region.c                    | 24 +++++++++++--------
 include/linux/fpga/fpga-region.h              | 13 +++++++---
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index dc55d60a0b4a..77190a5ef330 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -46,13 +46,16 @@ API to add a new FPGA region
 ----------------------------
 
 * struct fpga_region - The FPGA region struct
-* struct fpga_region_info - Parameter structure for fpga_region_register_full()
-* fpga_region_register_full() -  Create and register an FPGA region using the
+* struct fpga_region_info - Parameter structure for __fpga_region_register_full()
+* __fpga_region_register_full() -  Create and register an FPGA region using the
   fpga_region_info structure to provide the full flexibility of options
-* fpga_region_register() -  Create and register an FPGA region using standard
+* __fpga_region_register() -  Create and register an FPGA region using standard
   arguments
 * fpga_region_unregister() -  Unregister an FPGA region
 
+Helper macros ``fpga_region_register()`` and ``fpga_region_register_full()``
+automatically set the module that registers the FPGA region as the owner.
+
 The FPGA region's probe function will need to get a reference to the FPGA
 Manager it will be using to do the programming.  This usually would happen
 during the region's probe function.
@@ -82,10 +85,10 @@ following APIs to handle building or tearing down that list.
    :functions: fpga_region_info
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_register_full
+   :functions: __fpga_region_register
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_register
+   :functions: __fpga_region_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_unregister
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index b364a929425c..d50ab1509989 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
 	}
 
 	get_device(dev);
-	if (!try_module_get(dev->parent->driver->owner)) {
+	if (!try_module_get(region->br_owner)) {
 		put_device(dev);
 		mutex_unlock(&region->mutex);
 		return ERR_PTR(-ENODEV);
@@ -75,7 +75,7 @@ static void fpga_region_put(struct fpga_region *region)
 
 	dev_dbg(dev, "put\n");
 
-	module_put(dev->parent->driver->owner);
+	module_put(region->br_owner);
 	put_device(dev);
 	mutex_unlock(&region->mutex);
 }
@@ -181,14 +181,16 @@ static struct attribute *fpga_region_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_region);
 
 /**
- * fpga_region_register_full - create and register an FPGA Region device
+ * __fpga_region_register_full - create and register an FPGA Region device
  * @parent: device parent
  * @info: parameters for FPGA Region
+ * @owner: owner module containing the get_bridges function
  *
  * Return: struct fpga_region or ERR_PTR()
  */
 struct fpga_region *
-fpga_region_register_full(struct device *parent, const struct fpga_region_info *info)
+__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
+			    struct module *owner)
 {
 	struct fpga_region *region;
 	int id, ret = 0;
@@ -213,6 +215,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
 	region->compat_id = info->compat_id;
 	region->priv = info->priv;
 	region->get_bridges = info->get_bridges;
+	region->br_owner = owner;
 
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
@@ -241,13 +244,14 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_region_register_full);
+EXPORT_SYMBOL_GPL(__fpga_region_register_full);
 
 /**
- * fpga_region_register - create and register an FPGA Region device
+ * __fpga_region_register - create and register an FPGA Region device
  * @parent: device parent
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
+ * @owner: owner module containing get_bridges function
  *
  * This simple version of the register function should be sufficient for most users.
  * The fpga_region_register_full() function is available for users that need to
@@ -256,17 +260,17 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
  * Return: struct fpga_region or ERR_PTR()
  */
 struct fpga_region *
-fpga_region_register(struct device *parent, struct fpga_manager *mgr,
-		     int (*get_bridges)(struct fpga_region *))
+__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		       int (*get_bridges)(struct fpga_region *), struct module *owner)
 {
 	struct fpga_region_info info = { 0 };
 
 	info.mgr = mgr;
 	info.get_bridges = get_bridges;
 
-	return fpga_region_register_full(parent, &info);
+	return __fpga_region_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(fpga_region_register);
+EXPORT_SYMBOL_GPL(__fpga_region_register);
 
 /**
  * fpga_region_unregister - unregister an FPGA region
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 9d4d32909340..d175babc3d68 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -36,6 +36,7 @@ struct fpga_region_info {
  * @mgr: FPGA manager
  * @info: FPGA image info
  * @compat_id: FPGA region id for compatibility check.
+ * @br_owner: module containing the get_bridges function
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
  */
@@ -46,6 +47,7 @@ struct fpga_region {
 	struct fpga_manager *mgr;
 	struct fpga_image_info *info;
 	struct fpga_compat_id *compat_id;
+	struct module *br_owner;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
 };
@@ -58,12 +60,17 @@ fpga_region_class_find(struct device *start, const void *data,
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
+#define fpga_region_register_full(parent, info) \
+	__fpga_region_register_full(parent, info, THIS_MODULE)
 struct fpga_region *
-fpga_region_register_full(struct device *parent, const struct fpga_region_info *info);
+__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
+			    struct module *owner);
 
+#define fpga_region_register(parent, mgr, get_bridges) \
+	__fpga_region_register(parent, mgr, get_bridges, THIS_MODULE)
 struct fpga_region *
-fpga_region_register(struct device *parent, struct fpga_manager *mgr,
-		     int (*get_bridges)(struct fpga_region *));
+__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		       int (*get_bridges)(struct fpga_region *), struct module *owner);
 void fpga_region_unregister(struct fpga_region *region);
 
 #endif /* _FPGA_REGION_H */

base-commit: b1a91ca25f15b6d7b311de4465854a5981dee3d3
-- 
2.44.0


