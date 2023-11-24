Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6470C7F78E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjKXQ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKXQ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:28:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196E6D41
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700843315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g//rHl/LxpwQpXoYOYg3bTjSPJ3DCs9GAcBjIJBfkM0=;
        b=YtaAeyYzEveB5AO62HFun3cRg8YNwl7kTuJRwYDq9vtjAuNbddy22LquGxu+Te4Sh3L+dh
        WAS0ElKrYuw5edQdqjx4DBwSGvHoiNOib8OiCL813kGUa0wRJsMLejKL34MiV0IiIXiBL9
        VBBMRXC/s2XXf3vODsNbAJpR+df6/Mk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-yR1BhhoiMjCB5r_REKE94g-1; Fri, 24 Nov 2023 11:28:34 -0500
X-MC-Unique: yR1BhhoiMjCB5r_REKE94g-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-778915a0c73so185527385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700843314; x=1701448114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g//rHl/LxpwQpXoYOYg3bTjSPJ3DCs9GAcBjIJBfkM0=;
        b=JLjG/YDNtJHls4ZxeSP8+8cIdqaTPXkrrjA0Vyp3oB/u5kSwXd2K+rmcKtN10ExT13
         MJTvwJxgiKq1kjXBpZ1dF0Z8tWeTdMghFc7zYUSDlVvQ2rkZ/ODniYuKhlNh8F5o2O2s
         tJe31y1Bh1/VzPYf21tajfdsy9nJraZmgV7o4PTfuw8hMpENBjxih7coX5SJndsteZRa
         KPzumU3peC8wetd4vATqObWueE2NE8IsqGf/833E/NgHMMJ6M0eVV7C6B4QA5tRaW70m
         WZ3qgpQ6oXib8SXfB2UO5EqyaQiCatZoSmcgHCnyC05YpMCTXimrdoHTkK006WM35atK
         AfGQ==
X-Gm-Message-State: AOJu0YwzSMDO9HG5/JXU9ofYlSxwZ3j7ZmyjLAaRdIfthJJuNqWtFOvZ
        znPYp43OfpsRUxoAwdTXfEkZwF63yBilqxOUfJSYavFWQlZrN5WW18CaNsYm1k3Yu1T+rOEfFpb
        dL0SMqsWp6lg1HBkhFtCwwms=
X-Received: by 2002:a05:620a:4711:b0:77d:855c:a6e6 with SMTP id bs17-20020a05620a471100b0077d855ca6e6mr1495287qkb.71.1700843313781;
        Fri, 24 Nov 2023 08:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaiDGTsLVegsksyPwraDyUBIau7vhJ/WK7lTIkfdLbVknISlWFOwZbPEH8uq2bEspg84PwsA==
X-Received: by 2002:a05:620a:4711:b0:77d:855c:a6e6 with SMTP id bs17-20020a05620a471100b0077d855ca6e6mr1495254qkb.71.1700843313472;
        Fri, 24 Nov 2023 08:28:33 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id rk4-20020a05620a900400b007676f3859fasm1327608qkn.30.2023.11.24.08.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 08:28:33 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v2 1/2] fpga: add a module owner field to fpga_manager and fpga_manager_ops
Date:   Fri, 24 Nov 2023 17:28:06 +0100
Message-ID: <20231124162807.238724-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124162807.238724-1-marpagan@redhat.com>
References: <20231124162807.238724-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a module *owner field to the fpga_manager_ops and fpga_manager
structs to protect the fpga manager against the unloading of the
low-level control module while someone is holding a reference to the
manager device. Low-level control modules should statically set the
owner field of the fpga_manager_ops struct to THIS_MODULE. Then, when
the manager is registered using fpga_mgr_register(), the value is copied
into the owner field of the fpga_manager struct (that contains the
device context). In this way, the manager can later use it in
fpga_mgr_get() to take the low-level module's refcount. To prevent races
while unloading the low-level control module, fpga_mgr_get() and part of
the fpga_mgr_unregister() methods are protected with a mutex.

Other changes: move put_device() from __fpga_mgr_get() to fpga_mgr_get()
and of_fpga_mgr_get() to improve code clarity.

Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-mgr.c       | 56 +++++++++++++++++++++++++----------
 include/linux/fpga/fpga-mgr.h |  4 +++
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 06651389c592..608605d59860 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -21,6 +21,8 @@
 static DEFINE_IDA(fpga_mgr_ida);
 static const struct class fpga_mgr_class;
 
+static DEFINE_MUTEX(mgr_lock);
+
 struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
 };
@@ -667,17 +669,15 @@ ATTRIBUTE_GROUPS(fpga_mgr);
 static struct fpga_manager *__fpga_mgr_get(struct device *dev)
 {
 	struct fpga_manager *mgr;
+	struct module *owner;
 
 	mgr = to_fpga_manager(dev);
+	owner = mgr->owner;
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_dev;
+	if (owner && !try_module_get(owner))
+		mgr = ERR_PTR(-ENODEV);
 
 	return mgr;
-
-err_dev:
-	put_device(dev);
-	return ERR_PTR(-ENODEV);
 }
 
 static int fpga_mgr_dev_match(struct device *dev, const void *data)
@@ -693,12 +693,22 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
  */
 struct fpga_manager *fpga_mgr_get(struct device *dev)
 {
-	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
-						   fpga_mgr_dev_match);
+	struct fpga_manager *mgr = ERR_PTR(-ENODEV);
+	struct device *mgr_dev;
+
+	mutex_lock(&mgr_lock);
+
+	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
 	if (!mgr_dev)
-		return ERR_PTR(-ENODEV);
+		goto out;
+
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
 
-	return __fpga_mgr_get(mgr_dev);
+out:
+	mutex_unlock(&mgr_lock);
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_get);
 
@@ -711,13 +721,22 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
  */
 struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 {
-	struct device *dev;
+	struct fpga_manager *mgr = ERR_PTR(-ENODEV);
+	struct device *mgr_dev;
+
+	mutex_lock(&mgr_lock);
+
+	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
+	if (!mgr_dev)
+		goto out;
 
-	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
-	if (!dev)
-		return ERR_PTR(-ENODEV);
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
 
-	return __fpga_mgr_get(dev);
+out:
+	mutex_unlock(&mgr_lock);
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
 
@@ -727,7 +746,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
  */
 void fpga_mgr_put(struct fpga_manager *mgr)
 {
-	module_put(mgr->dev.parent->driver->owner);
+	module_put(mgr->owner);
 	put_device(&mgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
@@ -806,6 +825,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 
 	mgr->name = info->name;
 	mgr->mops = info->mops;
+	mgr->owner = info->mops->owner;
 	mgr->priv = info->priv;
 	mgr->compat_id = info->compat_id;
 
@@ -888,7 +908,11 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 	 */
 	fpga_mgr_fpga_remove(mgr);
 
+	mutex_lock(&mgr_lock);
+
 	device_unregister(&mgr->dev);
+
+	mutex_unlock(&mgr_lock);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
 
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 54f63459efd6..eaf6e072dbc0 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -162,6 +162,7 @@ struct fpga_manager_info {
  * @write_complete: set FPGA to operating state after writing is done
  * @fpga_remove: optional: Set FPGA into a specific state during driver remove
  * @groups: optional attribute groups.
+ * @owner: owner module.
  *
  * fpga_manager_ops are the low level functions implemented by a specific
  * fpga manager driver.  The optional ones are tested for NULL before being
@@ -184,6 +185,7 @@ struct fpga_manager_ops {
 			      struct fpga_image_info *info);
 	void (*fpga_remove)(struct fpga_manager *mgr);
 	const struct attribute_group **groups;
+	struct module *owner;
 };
 
 /* FPGA manager status: Partial/Full Reconfiguration errors */
@@ -201,6 +203,7 @@ struct fpga_manager_ops {
  * @state: state of fpga manager
  * @compat_id: FPGA manager id for compatibility check.
  * @mops: pointer to struct of fpga manager ops
+ * @owner: owner module.
  * @priv: low level driver private date
  */
 struct fpga_manager {
@@ -210,6 +213,7 @@ struct fpga_manager {
 	enum fpga_mgr_states state;
 	struct fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
+	struct module *owner;
 	void *priv;
 };
 
-- 
2.42.0

