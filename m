Return-Path: <linux-kernel+bounces-92884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E0987278A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A112BB2355A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D9E433C0;
	Tue,  5 Mar 2024 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NygMETtB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28822CCD3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666978; cv=none; b=ps9Q57nDQM2XMZ14O0F+NK19GvlX/FhmvihDPkF+M29no3iuEwURTBQYMuu3O8/DZ6JwuiO/XkafqSaF/2jJ56/iRkAEu+CiadfSA77OSD8Sp7M2qMIB+onjsoNEdR+DgbJoEcV5HW8TcTdsnf9oFfdso9pY7Xn9nQLkUq53PGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666978; c=relaxed/simple;
	bh=ssfHvI3PdVFTlI1Hudg8G2iWRrUy4dO/pOmlHiKneuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJF2sEsLd0Ohb8EacpbkAHeoje9jqJFYkSmYJLuW8NkgWvgDSOJtGi8oDxh8ogi+WOdJbAVWJ12+hIG8Q0MXcwmREWnz+XALdCEIp9e5lQwKzNjzytpRVyUgN0N4AzfoMprvReFIy/NyV3NvbOVNQOi1kLhGCU0RyAVslHmRjNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NygMETtB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709666974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MsLmeEDDRautWLVWhy7nZWLo1w0biW+49BFJ3rP2YaY=;
	b=NygMETtBqxHODGDZyTSOkckAceiWWgmcoBMXY5WJhEoEYDObdGN38nZgOJAcJck6Hy15ec
	P8JdV8d3HqMqDB6K0RAI4xgiat3yFUYxf3qt+4UYKA6iy4G8nO/WDFsTKHN1wzsrwQCJP0
	jy6V7QAUWSk6MBGnqaFED/VIh4NY2DQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-dRWKj-xrMnaZuIf0gOy59g-1; Tue, 05 Mar 2024 14:29:33 -0500
X-MC-Unique: dRWKj-xrMnaZuIf0gOy59g-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6e0ee5097feso7158077a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709666972; x=1710271772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsLmeEDDRautWLVWhy7nZWLo1w0biW+49BFJ3rP2YaY=;
        b=sxjI+aLeojBx77+Q2dPg1Nkl5GmKXr+j0kBDVFumNsmIoUhbEiUMV6GyQDMX79gMo6
         snY+bPERLsYDoXrsDrhV/AePhoTtOrUr7uVK+jCVrjef2W/L8cJX1uJvIQGu+MmrdbXV
         jR2VJklE0MQl5/sgdwfvl+wJ+PKmA9YDQuWszkAXywXPvjgTN5X0FPf8ZynpNnmw0ROT
         s5hPEY8/XHCkZQnLG0Z3VXoDEy3tlzi0uB2aiMZ5DaE8WCdMmCxnIWDCF1ZJszmJ36BU
         bN3r7FVwWFJDSH4/y3pdtf7ohPtG36O5+StY0kNdHvUTaGj4ln1V48IapWmosJGwnDHr
         N+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUrwrG9FDHWKSm2YqTHRl3pdCWUDaNZdUS2BmCj9a+EoBPP03R2h1nILZkIkko6aIkqn37TvAia96rGefiMZeQs+rlqjatNZZZWp4a8
X-Gm-Message-State: AOJu0YxaK4pY3Moa378lKVghrcunhXJaIL5trypCvzi5OP2u88IxLB1g
	+1dbYvLEPylzOsqW89nr1XY+T5E5/qpu15401s2yug2OnpZcF5tobuykVYghF+uwGRqajMEWrWf
	Qu4b9Fy+Lxei3VYQ9Y4QRc/uWD7nshyffaGCdj03XUqjdzrgWf1Mn/67LNyKinS1VgOiN
X-Received: by 2002:a05:6870:249c:b0:221:1f78:563f with SMTP id s28-20020a056870249c00b002211f78563fmr3105955oaq.2.1709666972224;
        Tue, 05 Mar 2024 11:29:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUddroAJ9Zuif3frVwkR0AZHih7biF91mvnZ/RgbfULxqOo1rQccouZZK5SKKa+piHIfB1Ag==
X-Received: by 2002:a05:6870:249c:b0:221:1f78:563f with SMTP id s28-20020a056870249c00b002211f78563fmr3105932oaq.2.1709666971937;
        Tue, 05 Mar 2024 11:29:31 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-28-168.cust.vodafonedsl.it. [2.34.28.168])
        by smtp.gmail.com with ESMTPSA id vr1-20020a05620a55a100b007881e40ce0bsm3432992qkn.83.2024.03.05.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:29:31 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [PATCH v6] fpga: manager: add owner module and take its refcount
Date: Tue,  5 Mar 2024 20:29:26 +0100
Message-ID: <20240305192926.84886-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of the fpga manager assumes that the low-level
module registers a driver for the parent device and uses its owner pointer
to take the module's refcount. This approach is problematic since it can
lead to a null pointer dereference while attempting to get the manager if
the parent device does not have a driver.

To address this problem, add a module owner pointer to the fpga_manager
struct and use it to take the module's refcount. Modify the functions for
registering the manager to take an additional owner module parameter and
rename them to avoid conflicts. Use the old function names for helper
macros that automatically set the module that registers the manager as the
owner. This ensures compatibility with existing low-level control modules
and reduces the chances of registering a manager without setting the owner.

Also, update the documentation to keep it consistent with the new interface
for registering an fpga manager.

Other changes: opportunistically move put_device() from __fpga_mgr_get() to
fpga_mgr_get() and of_fpga_mgr_get() to improve code clarity since the
manager device is taken in these functions.

Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---

v6:
- Split out protection against races while taking the mod's refcount
v5:
- Updated the documentation
- Removed kernel-doc comments for helper macros
v4:
- Use helper macros to set the owner module
v3:
- Improved locking
v2:
- Fixed protection against races during module removal
---
 Documentation/driver-api/fpga/fpga-mgr.rst | 34 +++++----
 drivers/fpga/fpga-mgr.c                    | 82 +++++++++++++---------
 include/linux/fpga/fpga-mgr.h              | 26 +++++--
 3 files changed, 89 insertions(+), 53 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 49c0a9512653..8d2b79f696c1 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -24,7 +24,8 @@ How to support a new FPGA device
 --------------------------------
 
 To add another FPGA manager, write a driver that implements a set of ops.  The
-probe function calls fpga_mgr_register() or fpga_mgr_register_full(), such as::
+probe function calls ``fpga_mgr_register()`` or ``fpga_mgr_register_full()``,
+such as::
 
 	static const struct fpga_manager_ops socfpga_fpga_ops = {
 		.write_init = socfpga_fpga_ops_configure_init,
@@ -69,10 +70,11 @@ probe function calls fpga_mgr_register() or fpga_mgr_register_full(), such as::
 	}
 
 Alternatively, the probe function could call one of the resource managed
-register functions, devm_fpga_mgr_register() or devm_fpga_mgr_register_full().
-When these functions are used, the parameter syntax is the same, but the call
-to fpga_mgr_unregister() should be removed. In the above example, the
-socfpga_fpga_remove() function would not be required.
+register functions, ``devm_fpga_mgr_register()`` or
+``devm_fpga_mgr_register_full()``.  When these functions are used, the
+parameter syntax is the same, but the call to ``fpga_mgr_unregister()`` should be
+removed. In the above example, the ``socfpga_fpga_remove()`` function would not be
+required.
 
 The ops will implement whatever device specific register writes are needed to
 do the programming sequence for this particular FPGA.  These ops return 0 for
@@ -125,15 +127,19 @@ API for implementing a new FPGA Manager driver
 * struct fpga_manager -  the FPGA manager struct
 * struct fpga_manager_ops -  Low level FPGA manager driver ops
 * struct fpga_manager_info -  Parameter structure for fpga_mgr_register_full()
-* fpga_mgr_register_full() -  Create and register an FPGA manager using the
+* __fpga_mgr_register_full() -  Create and register an FPGA manager using the
   fpga_mgr_info structure to provide the full flexibility of options
-* fpga_mgr_register() -  Create and register an FPGA manager using standard
+* __fpga_mgr_register() -  Create and register an FPGA manager using standard
   arguments
-* devm_fpga_mgr_register_full() -  Resource managed version of
-  fpga_mgr_register_full()
-* devm_fpga_mgr_register() -  Resource managed version of fpga_mgr_register()
+* __devm_fpga_mgr_register_full() -  Resource managed version of
+  __fpga_mgr_register_full()
+* __devm_fpga_mgr_register() -  Resource managed version of __fpga_mgr_register()
 * fpga_mgr_unregister() -  Unregister an FPGA manager
 
+Helper macros ``fpga_mgr_register_full()``, ``fpga_mgr_register()``,
+``devm_fpga_mgr_register_full()``, and ``devm_fpga_mgr_register()`` are available
+to ease the registration.
+
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
    :functions: fpga_mgr_states
 
@@ -147,16 +153,16 @@ API for implementing a new FPGA Manager driver
    :functions: fpga_manager_info
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register_full
+   :functions: __fpga_mgr_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register
+   :functions: __fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_register_full
+   :functions: __devm_fpga_mgr_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_register
+   :functions: __devm_fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_unregister
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 06651389c592..0f4035b089a2 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -664,20 +664,16 @@ static struct attribute *fpga_mgr_attrs[] = {
 };
 ATTRIBUTE_GROUPS(fpga_mgr);
 
-static struct fpga_manager *__fpga_mgr_get(struct device *dev)
+static struct fpga_manager *__fpga_mgr_get(struct device *mgr_dev)
 {
 	struct fpga_manager *mgr;
 
-	mgr = to_fpga_manager(dev);
+	mgr = to_fpga_manager(mgr_dev);
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_dev;
+	if (!try_module_get(mgr->mops_owner))
+		mgr = ERR_PTR(-ENODEV);
 
 	return mgr;
-
-err_dev:
-	put_device(dev);
-	return ERR_PTR(-ENODEV);
 }
 
 static int fpga_mgr_dev_match(struct device *dev, const void *data)
@@ -693,12 +689,18 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
  */
 struct fpga_manager *fpga_mgr_get(struct device *dev)
 {
-	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
-						   fpga_mgr_dev_match);
+	struct fpga_manager *mgr;
+	struct device *mgr_dev;
+
+	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
 	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_mgr_get(mgr_dev);
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
+
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_get);
 
@@ -711,13 +713,18 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
  */
 struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 {
-	struct device *dev;
+	struct fpga_manager *mgr;
+	struct device *mgr_dev;
 
-	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
-	if (!dev)
+	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
+	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_mgr_get(dev);
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
+
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
 
@@ -727,7 +734,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
  */
 void fpga_mgr_put(struct fpga_manager *mgr)
 {
-	module_put(mgr->dev.parent->driver->owner);
+	module_put(mgr->mops_owner);
 	put_device(&mgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
@@ -766,9 +773,10 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
 EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
 
 /**
- * fpga_mgr_register_full - create and register an FPGA Manager device
+ * __fpga_mgr_register_full - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
+ * @owner:	owner module containing the ops
  *
  * The caller of this function is responsible for calling fpga_mgr_unregister().
  * Using devm_fpga_mgr_register_full() instead is recommended.
@@ -776,7 +784,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
  * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
 struct fpga_manager *
-fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
+__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			 struct module *owner)
 {
 	const struct fpga_manager_ops *mops = info->mops;
 	struct fpga_manager *mgr;
@@ -804,6 +813,8 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 
 	mutex_init(&mgr->ref_mutex);
 
+	mgr->mops_owner = owner;
+
 	mgr->name = info->name;
 	mgr->mops = info->mops;
 	mgr->priv = info->priv;
@@ -841,14 +852,15 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
+EXPORT_SYMBOL_GPL(__fpga_mgr_register_full);
 
 /**
- * fpga_mgr_register - create and register an FPGA Manager device
+ * __fpga_mgr_register - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
+ * @owner:	owner module containing the ops
  *
  * The caller of this function is responsible for calling fpga_mgr_unregister().
  * Using devm_fpga_mgr_register() instead is recommended. This simple
@@ -859,8 +871,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
  * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
 struct fpga_manager *
-fpga_mgr_register(struct device *parent, const char *name,
-		  const struct fpga_manager_ops *mops, void *priv)
+__fpga_mgr_register(struct device *parent, const char *name,
+		    const struct fpga_manager_ops *mops, void *priv, struct module *owner)
 {
 	struct fpga_manager_info info = { 0 };
 
@@ -868,9 +880,9 @@ fpga_mgr_register(struct device *parent, const char *name,
 	info.mops = mops;
 	info.priv = priv;
 
-	return fpga_mgr_register_full(parent, &info);
+	return __fpga_mgr_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(fpga_mgr_register);
+EXPORT_SYMBOL_GPL(__fpga_mgr_register);
 
 /**
  * fpga_mgr_unregister - unregister an FPGA manager
@@ -900,9 +912,10 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
 }
 
 /**
- * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
+ * __devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
+ * @owner:	owner module containing the ops
  *
  * Return:  fpga manager pointer on success, negative error code otherwise.
  *
@@ -910,7 +923,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
  * function will be called automatically when the managing device is detached.
  */
 struct fpga_manager *
-devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
+__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			      struct module *owner)
 {
 	struct fpga_mgr_devres *dr;
 	struct fpga_manager *mgr;
@@ -919,7 +933,7 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
 	if (!dr)
 		return ERR_PTR(-ENOMEM);
 
-	mgr = fpga_mgr_register_full(parent, info);
+	mgr = __fpga_mgr_register_full(parent, info, owner);
 	if (IS_ERR(mgr)) {
 		devres_free(dr);
 		return mgr;
@@ -930,14 +944,15 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
 
 	return mgr;
 }
-EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
+EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register_full);
 
 /**
- * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
+ * __devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
  * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
+ * @owner:	owner module containing the ops
  *
  * Return:  fpga manager pointer on success, negative error code otherwise.
  *
@@ -946,8 +961,9 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
  * device is detached.
  */
 struct fpga_manager *
-devm_fpga_mgr_register(struct device *parent, const char *name,
-		       const struct fpga_manager_ops *mops, void *priv)
+__devm_fpga_mgr_register(struct device *parent, const char *name,
+			 const struct fpga_manager_ops *mops, void *priv,
+			 struct module *owner)
 {
 	struct fpga_manager_info info = { 0 };
 
@@ -955,9 +971,9 @@ devm_fpga_mgr_register(struct device *parent, const char *name,
 	info.mops = mops;
 	info.priv = priv;
 
-	return devm_fpga_mgr_register_full(parent, &info);
+	return __devm_fpga_mgr_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
+EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register);
 
 static void fpga_mgr_dev_release(struct device *dev)
 {
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 54f63459efd6..0d4fe068f3d8 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -201,6 +201,7 @@ struct fpga_manager_ops {
  * @state: state of fpga manager
  * @compat_id: FPGA manager id for compatibility check.
  * @mops: pointer to struct of fpga manager ops
+ * @mops_owner: module containing the mops
  * @priv: low level driver private date
  */
 struct fpga_manager {
@@ -210,6 +211,7 @@ struct fpga_manager {
 	enum fpga_mgr_states state;
 	struct fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
+	struct module *mops_owner;
 	void *priv;
 };
 
@@ -230,18 +232,30 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
 
 void fpga_mgr_put(struct fpga_manager *mgr);
 
+#define fpga_mgr_register_full(parent, info) \
+	__fpga_mgr_register_full(parent, info, THIS_MODULE)
 struct fpga_manager *
-fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
+__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			 struct module *owner);
 
+#define fpga_mgr_register(parent, name, mops, priv) \
+	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
 struct fpga_manager *
-fpga_mgr_register(struct device *parent, const char *name,
-		  const struct fpga_manager_ops *mops, void *priv);
+__fpga_mgr_register(struct device *parent, const char *name,
+		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
+
 void fpga_mgr_unregister(struct fpga_manager *mgr);
 
+#define devm_fpga_mgr_register_full(parent, info) \
+	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
 struct fpga_manager *
-devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
+__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			      struct module *owner);
+#define devm_fpga_mgr_register(parent, name, mops, priv) \
+	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
 struct fpga_manager *
-devm_fpga_mgr_register(struct device *parent, const char *name,
-		       const struct fpga_manager_ops *mops, void *priv);
+__devm_fpga_mgr_register(struct device *parent, const char *name,
+			 const struct fpga_manager_ops *mops, void *priv,
+			 struct module *owner);
 
 #endif /*_LINUX_FPGA_MGR_H */

base-commit: b1a91ca25f15b6d7b311de4465854a5981dee3d3
-- 
2.44.0


