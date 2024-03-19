Return-Path: <linux-kernel+bounces-107902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9788034C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBFD3B22074
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF7B19BDC;
	Tue, 19 Mar 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7E5y/Pr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C49017C8B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868846; cv=none; b=qoHO+uD1u0RQg+/IjldAXdjnV+BhjN8LVnbng4ncB6dMy+mvSLVix+wYOIzW9iRbOlfznq7s7nPPW45bXz0SA9q6FJmxlXVVGLDpWj7mCJwD4vazsLeux07gh6SFixohuMI/dKJ1XTH0RYW0e4H8necWYLya/omdP0yyah6gHYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868846; c=relaxed/simple;
	bh=Vh9lCoaKMDmTBh3akSE8GiDLO339gYIbqJ18ntD/V64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTAvmrudiX0700Fgn2aoaidqL8u67dVjGZNSwUSYR6snrebCzgvSKn4o/+hgH/ScZUKiqLQuAg6aPZeYiaTVfeQH4P7sGUWK1I40GRvT337HIYF73f/cOx8J8vAceZMhw1912+J3tEGifFP/yRnfrGgTfvuihSdcsgSItA0RLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7E5y/Pr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710868844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8ztau3JQ36amubeJuz0wWTtDljNmlC67km863EzzBpM=;
	b=i7E5y/PrgFyQWjTSj1zwHOrTYwxa85LgunrISBwuCvMv5w5j77V+y+BAhc1G8lluRWyrGV
	9F64VLgb+YyUpA7eHwum0Oew188+ScKWNDTvJLDvXvapsl5y2Pzl7Mel83zbutugead3eg
	7/gGyjKsp/S3Qw3lFSrWzkFvdrWLG8k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-j4iA9mOENiqRIbXi8tbOnw-1; Tue, 19 Mar 2024 13:20:41 -0400
X-MC-Unique: j4iA9mOENiqRIbXi8tbOnw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ec604d3b3so3927777f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710868841; x=1711473641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ztau3JQ36amubeJuz0wWTtDljNmlC67km863EzzBpM=;
        b=RoT0Z0nwNcvoLo3Z6wu72HmHA2fTS5W8zKXSKVf2n5rwHaORrIWl3Kx+gHUp+24npd
         tfZXg7pB2AAUfc6LLePHA01TKYQfJEW96nrVoaammXL33ntfz1AYHzobrryeqveIxcpH
         VnGZ/CbqmV9kUoDPHZFxpA/87I6wszpkGXw7mo9SZv6OK+H7LtaCS5H3c5uKxz2SuY1Y
         fEXVpyGHU91V19znUcJq90cZFdZ9U1QiZku2wixawUPEJxt3d723697Ab9JYhkAH318w
         wjGbUOwk3OCzd9AW4dYXZpIdanOo34DObCIs/buyaghHSHgExJrrmi/d94fGKcFFRIgW
         YNUw==
X-Forwarded-Encrypted: i=1; AJvYcCWaV6bFvxhIPXaLE565DuSFPnkAhLSDjWBsJCUn8okeW7LwVoBxKDgU2yVI85+NBjLB5OaU7T65xWKJtm3vyq/U+lnEuPFzfYzYZ/1E
X-Gm-Message-State: AOJu0Yzlcd0f4HQFRIORrMaYUsUdSWfFAH17Uuwh+3GkutTZHP8cg/v3
	/Cj5QlG6nh5rYNVzVjpsvuFEE6SEeMkLWhw2o04l92m1Q6za6yAVIEkjluqrOBJWIRDV0aUagf1
	xzctQXe1Tn9sDCcyNCg3A22z+1FlhjNBSVTxdGwz3oP4Bwb91BIL14Q9SumMu
X-Received: by 2002:adf:f483:0:b0:33e:7f5c:a75c with SMTP id l3-20020adff483000000b0033e7f5ca75cmr10435300wro.47.1710868840693;
        Tue, 19 Mar 2024 10:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx2PQc7A0h2l5AD0StizMnjKmdjOFZhxuFssnLI/hnV0ZMoZOE2qNPVg/1en+Qbw0s7fX2rg==
X-Received: by 2002:adf:f483:0:b0:33e:7f5c:a75c with SMTP id l3-20020adff483000000b0033e7f5ca75cmr10435275wro.47.1710868840241;
        Tue, 19 Mar 2024 10:20:40 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-89.cust.vodafonedsl.it. [2.34.30.89])
        by smtp.gmail.com with ESMTPSA id g4-20020adfe404000000b0033dd2a7167fsm12804568wrm.29.2024.03.19.10.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:20:39 -0700 (PDT)
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
Subject: [PATCH v2] fpga: bridge: add owner module and take its refcount
Date: Tue, 19 Mar 2024 18:20:24 +0100
Message-ID: <20240319172026.76142-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of the fpga bridge assumes that the low-level
module registers a driver for the parent device and uses its owner pointer
to take the module's refcount. This approach is problematic since it can
lead to a null pointer dereference while attempting to get the bridge if
the parent device does not have a driver.

To address this problem, add a module owner pointer to the fpga_bridge
struct and use it to take the module's refcount. Modify the function for
registering a bridge to take an additional owner module parameter and
rename it to avoid conflicts. Use the old function name for a helper macro
that automatically sets the module that registers the bridge as the owner.
This ensures compatibility with existing low-level control modules and
reduces the chances of registering a bridge without setting the owner.

Also, update the documentation to keep it consistent with the new interface
for registering an fpga bridge.

Other changes: opportunistically move put_device() from __fpga_bridge_get()
to fpga_bridge_get() and of_fpga_bridge_get() to improve code clarity since
the bridge device is taken in these functions.

Fixes: 21aeda950c5f ("fpga: add fpga bridge framework")
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---

v2:
- Split out protection against races while taking the mod's refcount
---
 Documentation/driver-api/fpga/fpga-bridge.rst |  7 ++-
 drivers/fpga/fpga-bridge.c                    | 57 ++++++++++---------
 include/linux/fpga/fpga-bridge.h              | 10 +++-
 3 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index 604208534095..d831d5ab6b0d 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -6,9 +6,12 @@ API to implement a new FPGA bridge
 
 * struct fpga_bridge - The FPGA Bridge structure
 * struct fpga_bridge_ops - Low level Bridge driver ops
-* fpga_bridge_register() - Create and register a bridge
+* __fpga_bridge_register() - Create and register a bridge
 * fpga_bridge_unregister() - Unregister a bridge
 
+The helper macro ``fpga_bridge_register()`` automatically sets
+the module that registers the bridge as the owner.
+
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
    :functions: fpga_bridge
 
@@ -16,7 +19,7 @@ API to implement a new FPGA bridge
    :functions: fpga_bridge_ops
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_register
+   :functions: __fpga_bridge_register
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
    :functions: fpga_bridge_unregister
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 79c473b3c7c3..8ef395b49bf8 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -55,33 +55,26 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_disable);
 
-static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
+static struct fpga_bridge *__fpga_bridge_get(struct device *bridge_dev,
 					     struct fpga_image_info *info)
 {
 	struct fpga_bridge *bridge;
-	int ret = -ENODEV;
 
-	bridge = to_fpga_bridge(dev);
+	bridge = to_fpga_bridge(bridge_dev);
 
 	bridge->info = info;
 
-	if (!mutex_trylock(&bridge->mutex)) {
-		ret = -EBUSY;
-		goto err_dev;
-	}
+	if (!mutex_trylock(&bridge->mutex))
+		return ERR_PTR(-EBUSY);
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_ll_mod;
+	if (!try_module_get(bridge->br_ops_owner)) {
+		mutex_unlock(&bridge->mutex);
+		return ERR_PTR(-ENODEV);
+	}
 
 	dev_dbg(&bridge->dev, "get\n");
 
 	return bridge;
-
-err_ll_mod:
-	mutex_unlock(&bridge->mutex);
-err_dev:
-	put_device(dev);
-	return ERR_PTR(ret);
 }
 
 /**
@@ -98,13 +91,18 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
 struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 				       struct fpga_image_info *info)
 {
-	struct device *dev;
+	struct fpga_bridge *bridge;
+	struct device *bridge_dev;
 
-	dev = class_find_device_by_of_node(&fpga_bridge_class, np);
-	if (!dev)
+	bridge_dev = class_find_device_by_of_node(&fpga_bridge_class, np);
+	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_bridge_get(dev, info);
+	bridge = __fpga_bridge_get(bridge_dev, info);
+	if (IS_ERR(bridge))
+		put_device(bridge_dev);
+
+	return bridge;
 }
 EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
 
@@ -125,6 +123,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 struct fpga_bridge *fpga_bridge_get(struct device *dev,
 				    struct fpga_image_info *info)
 {
+	struct fpga_bridge *bridge;
 	struct device *bridge_dev;
 
 	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
@@ -132,7 +131,11 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
 	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_bridge_get(bridge_dev, info);
+	bridge = __fpga_bridge_get(bridge_dev, info);
+	if (IS_ERR(bridge))
+		put_device(bridge_dev);
+
+	return bridge;
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_get);
 
@@ -146,7 +149,7 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
 	dev_dbg(&bridge->dev, "put\n");
 
 	bridge->info = NULL;
-	module_put(bridge->dev.parent->driver->owner);
+	module_put(bridge->br_ops_owner);
 	mutex_unlock(&bridge->mutex);
 	put_device(&bridge->dev);
 }
@@ -316,18 +319,19 @@ static struct attribute *fpga_bridge_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_bridge);
 
 /**
- * fpga_bridge_register - create and register an FPGA Bridge device
+ * __fpga_bridge_register - create and register an FPGA Bridge device
  * @parent:	FPGA bridge device from pdev
  * @name:	FPGA bridge name
  * @br_ops:	pointer to structure of fpga bridge ops
  * @priv:	FPGA bridge private data
+ * @owner:	owner module containing the br_ops
  *
  * Return: struct fpga_bridge pointer or ERR_PTR()
  */
 struct fpga_bridge *
-fpga_bridge_register(struct device *parent, const char *name,
-		     const struct fpga_bridge_ops *br_ops,
-		     void *priv)
+__fpga_bridge_register(struct device *parent, const char *name,
+		       const struct fpga_bridge_ops *br_ops,
+		       void *priv, struct module *owner)
 {
 	struct fpga_bridge *bridge;
 	int id, ret;
@@ -357,6 +361,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 
 	bridge->name = name;
 	bridge->br_ops = br_ops;
+	bridge->br_ops_owner = owner;
 	bridge->priv = priv;
 
 	bridge->dev.groups = br_ops->groups;
@@ -386,7 +391,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_bridge_register);
+EXPORT_SYMBOL_GPL(__fpga_bridge_register);
 
 /**
  * fpga_bridge_unregister - unregister an FPGA bridge
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index 223da48a6d18..94c4edd047e5 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -45,6 +45,7 @@ struct fpga_bridge_info {
  * @dev: FPGA bridge device
  * @mutex: enforces exclusive reference to bridge
  * @br_ops: pointer to struct of FPGA bridge ops
+ * @br_ops_owner: module containing the br_ops
  * @info: fpga image specific information
  * @node: FPGA bridge list node
  * @priv: low level driver private date
@@ -54,6 +55,7 @@ struct fpga_bridge {
 	struct device dev;
 	struct mutex mutex; /* for exclusive reference to bridge */
 	const struct fpga_bridge_ops *br_ops;
+	struct module *br_ops_owner;
 	struct fpga_image_info *info;
 	struct list_head node;
 	void *priv;
@@ -79,10 +81,12 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
 			       struct fpga_image_info *info,
 			       struct list_head *bridge_list);
 
+#define fpga_bridge_register(parent, name, br_ops, priv) \
+	__fpga_bridge_register(parent, name, br_ops, priv, THIS_MODULE)
 struct fpga_bridge *
-fpga_bridge_register(struct device *parent, const char *name,
-		     const struct fpga_bridge_ops *br_ops,
-		     void *priv);
+__fpga_bridge_register(struct device *parent, const char *name,
+		       const struct fpga_bridge_ops *br_ops, void *priv,
+		       struct module *owner);
 void fpga_bridge_unregister(struct fpga_bridge *br);
 
 #endif /* _LINUX_FPGA_BRIDGE_H */

base-commit: b1a91ca25f15b6d7b311de4465854a5981dee3d3
-- 
2.44.0


