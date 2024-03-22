Return-Path: <linux-kernel+bounces-111864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C878871DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C4F1C21F61
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16805FBB3;
	Fri, 22 Mar 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDMJis2F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF85FB87
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127983; cv=none; b=NOk/cY0mB9IXJvOkJL7iD6f30t1U31bvkPBDiYgXnQTVqVzEGNJ3sgKDEGugE+ijTSRAdJmX5NBbT+ThoLzmKXAZPsCfv/++EZEK2Ag2B80AsW+DiyHZjjyqf2FAeV161tk/tOLQyvY46a450EQq+H0M1MWQXPqGTgMs04m69aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127983; c=relaxed/simple;
	bh=N12qxl7UniMfe2hGoj4B6CkxZ8ZOxaE6F3rVFsWYNT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgIkwUkDCP4q0uIWzGiSsnRUH+NsHlSHlgFmp254Bc+40WNZuUwjvj4wHxchMy8HEpfmohAB+5LggM/CIqgKkinyjx2gKg2Zx43GDF10Qmmy2D7WDHj0g33qrNaFitEuW/23/z5NjzlhTvegm4k88+dklvgzSEF5dxdQPY+feUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDMJis2F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711127980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Znd9bvJpXZqv0gP8cnRrbafHHMAOq6Zc/ABI3BUxAgM=;
	b=RDMJis2FW7G0nTsSAGMU0MsPZUtdnKxaIChnr9UyPAUE6VBvbJTNEdAwReqWbALD5T+udA
	xKYxG0qf25mT3lFfLPDqTE+/oB8bEMpWGRXp/1IbVKx9dIk+SJ43i6Fjryx2qnvXSUJrab
	bvZ6d7whqlD/Ny8FxRRMGqxVKmplkt0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-wFKjvd_RNQ-5N_M_fCny4A-1; Fri, 22 Mar 2024 13:19:38 -0400
X-MC-Unique: wFKjvd_RNQ-5N_M_fCny4A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4147f96f58aso522055e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127977; x=1711732777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Znd9bvJpXZqv0gP8cnRrbafHHMAOq6Zc/ABI3BUxAgM=;
        b=Pz8ImXJ4E6u4WCMf2hrtIBzAzx64g4dmuOXwonhS3kMeZ2mYYNSZi+qqj3u5U1g76P
         8Gt8RoA2aWTgOSGxD9IiK4zFWUwxT0sFcaAzZaNaliS0A8migY+JiA4xmRC8R+zU+BMY
         86V2K4l5h1EO00NiFKwJAZsCqcZ5wlnnaD94MUVuNo0070tg1hLd3PxnIPHkhZy+20Ze
         VofVi9Mh/Bu04Ft8Sb752hSmWUtULn2te5r8cuGnSB45mlRgnm/u4Hu8GkAz/8Py0LOt
         OW7GJVOHGlrrbmGsp/pJ/i+YNTUkqkphC19WwXOzvn2nmwIpY40Ivx+Vw0z+V2fiy5KR
         eSpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6SLysERTTwD4KM6nnkCJOWztL2LR/Ki3B8JxSoFe8Wq3uI68H3HQzdFt5c/LR76NGH4zicDyOZQc0Amy5u7ur0j1SkYjX0p0baGhr
X-Gm-Message-State: AOJu0YymVWCKU/Ea+PkPgk+fnkFFnUZyfHWiyVCwwffvWeGhvI1vMKKm
	wJ7isPsbc4ny4xuf2fRiuBGyW4k7sDLiGXykXzu7794xBBZvudfqrgcniddR49iSicwrhJkbF0z
	Do9gtB6Btm7LJRFVSQHbbpNXbeSqxLcxReZc6xYw0/kGwknYQlHiHkdyKKyQ+
X-Received: by 2002:a05:600c:4506:b0:412:d149:254c with SMTP id t6-20020a05600c450600b00412d149254cmr2494926wmo.17.1711127977621;
        Fri, 22 Mar 2024 10:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTVRYieHvrhfiR3LmpB8SUStyTUc3TVhXdFgAuI0jVQGPxt85gJndrv0pcDiqiXOY3AktC/w==
X-Received: by 2002:a05:600c:4506:b0:412:d149:254c with SMTP id t6-20020a05600c450600b00412d149254cmr2494915wmo.17.1711127977256;
        Fri, 22 Mar 2024 10:19:37 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-89.cust.vodafonedsl.it. [2.34.30.89])
        by smtp.gmail.com with ESMTPSA id hg9-20020a05600c538900b004101f27737asm72953wmb.29.2024.03.22.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:19:36 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alan Tull <atull@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: region: add owner module and take its refcount
Date: Fri, 22 Mar 2024 18:19:30 +0100
Message-ID: <20240322171931.233925-1-marpagan@redhat.com>
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

Other changes: unlock the mutex before calling put_device() in
fpga_region_put() to avoid potential use after release issues.

Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 Documentation/driver-api/fpga/fpga-region.rst | 13 ++++++----
 drivers/fpga/fpga-region.c                    | 26 +++++++++++--------
 include/linux/fpga/fpga-region.h              | 13 +++++++---
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index dc55d60a0b4a..3aff5199b6d8 100644
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
+automatically sets the module that registers the FPGA region as the owner.
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
index b364a929425c..f8bbda024d59 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
 	}
 
 	get_device(dev);
-	if (!try_module_get(dev->parent->driver->owner)) {
+	if (!try_module_get(region->get_br_owner)) {
 		put_device(dev);
 		mutex_unlock(&region->mutex);
 		return ERR_PTR(-ENODEV);
@@ -75,9 +75,9 @@ static void fpga_region_put(struct fpga_region *region)
 
 	dev_dbg(dev, "put\n");
 
-	module_put(dev->parent->driver->owner);
-	put_device(dev);
+	module_put(region->get_br_owner);
 	mutex_unlock(&region->mutex);
+	put_device(dev);
 }
 
 /**
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
+	region->get_br_owner = owner;
 
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
index 9d4d32909340..87da2dfada8f 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -36,6 +36,7 @@ struct fpga_region_info {
  * @mgr: FPGA manager
  * @info: FPGA image info
  * @compat_id: FPGA region id for compatibility check.
+ * @get_br_owner: module containing the get_bridges function
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
  */
@@ -46,6 +47,7 @@ struct fpga_region {
 	struct fpga_manager *mgr;
 	struct fpga_image_info *info;
 	struct fpga_compat_id *compat_id;
+	struct module *get_br_owner;
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


