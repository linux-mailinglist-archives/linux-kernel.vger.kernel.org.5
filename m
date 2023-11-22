Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1277F4900
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjKVOdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjKVOdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:33:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42C5D5C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700663590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DZFOSfIM7TPtd3vStgatz2Vc2HN+6585nrKoz3NT+MI=;
        b=aXQIxUQl3wlQ3yhNsUi5kn+bYU1p9O/DfUvxmVo3xjMvUCoJuZvS32RW1sIiwvSe1iBxsG
        DgguowqbDYEXO2Gjm8UPqttF+TSgDQoSjV8mNS0BOI1ww/cZo4hdnaCa1eGhjC2xx0HPwh
        4UUvHLT+snJxeWFuKQTE+IoyX+kCj2U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-RUJ8uCMUNjOpuZUNnHVBxg-1; Wed, 22 Nov 2023 09:33:08 -0500
X-MC-Unique: RUJ8uCMUNjOpuZUNnHVBxg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-421b20c9893so94839691cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700663588; x=1701268388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZFOSfIM7TPtd3vStgatz2Vc2HN+6585nrKoz3NT+MI=;
        b=AqvCynrQozKLZVpEdpU5GScwEhv4V9phVkD+098mHHKavEanMNgU8msJPQw5tlRPJf
         /l/GBT3pWo1BPRLsgASX+vthsLxRsyBpTL+Ic/HgqYIQGIrA6cAdIYkNAHiaaEQtzA2Z
         GF/ZFMQx3HU2QsC0yCd10Dkpv5wq2F/LRSqIuaULlsxip+D/aCu9ayucfXXFP1BpRXCu
         J1QtTmAWE4YzXCQbWS275Y/L40aShinAGl6JRDhk12KDHiShKPHBGQyvAKwpfK+WfOie
         68z6QbcRQ2+5tezWjzWrqaZuNR3sOOuJS5lexDW3UhOy8MtGR/8LsMP9X9o8uhJOZz65
         nxHQ==
X-Gm-Message-State: AOJu0Yx4SZRZfB2d00DM5AxPNNWXKv4f+x/wsqmogC4+6tsLv/fG8euT
        y5O5ydW8zPfGpOo6snFagNECvr1e9izoOwOhr835pRgyZX+FVU/ebYtgt0oqX5Hd6/LxeJcrEpR
        DQpfjAcBtP3tx3AcxInz/mrk=
X-Received: by 2002:ac8:7f82:0:b0:417:d340:c426 with SMTP id z2-20020ac87f82000000b00417d340c426mr2710695qtj.9.1700663587712;
        Wed, 22 Nov 2023 06:33:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+VKezDiPMwB09AoFaLVNXlCjJFB3AaOFjc1WBPZePAd7tIVJqYUk/IfQO1lX6kerNxmAjrg==
X-Received: by 2002:ac8:7f82:0:b0:417:d340:c426 with SMTP id z2-20020ac87f82000000b00417d340c426mr2710678qtj.9.1700663587434;
        Wed, 22 Nov 2023 06:33:07 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id v7-20020ac87487000000b0041950c7f6d8sm4430101qtq.60.2023.11.22.06.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:33:07 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 1/2] fpga: add a module owner field to fpga_manager and fpga_manager_ops
Date:   Wed, 22 Nov 2023 15:32:51 +0100
Message-ID: <20231122143252.181680-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122143252.181680-1-marpagan@redhat.com>
References: <20231122143252.181680-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
while unloading the low-level control module, the fpga_mgr_get() and
fpga_mgr_put() methods are protected with a mutex.

Other changes: moved put_device() form __fpga_mgr_get() to
fpga_mgr_get() and of_fpga_mgr_get() to improve code clarity.

Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-mgr.c       | 56 +++++++++++++++++++++++++----------
 include/linux/fpga/fpga-mgr.h |  4 +++
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 06651389c592..f76be7e2f722 100644
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
 
@@ -727,8 +746,12 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
  */
 void fpga_mgr_put(struct fpga_manager *mgr)
 {
-	module_put(mgr->dev.parent->driver->owner);
+	mutex_lock(&mgr_lock);
+
+	module_put(mgr->owner);
 	put_device(&mgr->dev);
+
+	mutex_unlock(&mgr_lock);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
 
@@ -806,6 +829,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 
 	mgr->name = info->name;
 	mgr->mops = info->mops;
+	mgr->owner = info->mops->owner;
 	mgr->priv = info->priv;
 	mgr->compat_id = info->compat_id;
 
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

