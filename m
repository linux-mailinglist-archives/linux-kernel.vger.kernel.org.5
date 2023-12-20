Return-Path: <linux-kernel+bounces-7673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CD381AB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F5AB24E70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589F751C34;
	Wed, 20 Dec 2023 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DBrtxpTc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD915026B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7b7a9f90ee9so9156839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703116526; x=1703721326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AD3TjuZ8z4szpVAtqglArcudpEVksAT0HzSeLd2B1Dk=;
        b=DBrtxpTcnWV8jJoVK8EtiBjFz+EPD3xtKcLBwoTfNlBPWsK1A4Fzq9E18e5j7elPzU
         Zd6UA/5o/0m78Y/o+pP3RWuO8hJbT56ii+w98WnFABSYqxBP9/QaXc6P+GsTGSdlC+tm
         RnxxyvOCbJOwrrsH00wHPTj5aGMsYVYYvJIZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116526; x=1703721326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AD3TjuZ8z4szpVAtqglArcudpEVksAT0HzSeLd2B1Dk=;
        b=b0ALlXEJAv9glRMVg3uT2IM2wnJ4HK7nf+gb6/apelHljKHod7xWLfobg23LYzjtZ4
         8EbK1Zti2z+doOHWPQcsT97NNOZBXGvDFhQ550rHp2gC6Ay8Ga98Q94WXASaEO1b93wH
         mTjN8Xq6Q0j4f2dxxNRMgC0buw4i27LbKnkcLkHqyh/iytSijmuLb8JWtbVLrkbz+QKz
         58vzlVkrKzQffdrSw1+ILqB6VWTEL38Bcxecekz9zK3jZN06rPpVowTRMOiyyNazvDzn
         BcSrc29mE1vLrZv6gqYj5U5YyjQr6RPifklskWz47DuoiY7TzTmD3aqQ6GXzbk2PY8Bz
         ld6Q==
X-Gm-Message-State: AOJu0YzKcU7RmqVRrHJTi6SIW8zqqNdvHvp9o+negcG1diCs9NphoH+S
	NclxPbdC3h/Wv8cUrRumrzMeWbeb32ki8EbmX3k=
X-Google-Smtp-Source: AGHT+IH9IT/zBs5lX+0g5tONOHtbi6Aq3OWE6gxs1xgyqopxLZmR5hvRwzgJx1wf6Aqp8B2g+WHCgQ==
X-Received: by 2002:a5d:8c83:0:b0:7b7:fe6c:e6d3 with SMTP id g3-20020a5d8c83000000b007b7fe6ce6d3mr2659307ion.2.1703116526320;
        Wed, 20 Dec 2023 15:55:26 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056638441600b0046b39a6f404sm177805jab.17.2023.12.20.15.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:26 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Hasemeyer <markhas@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 20/22] device property: Modify fwnode irq_get() to use resource
Date: Wed, 20 Dec 2023 16:54:34 -0700
Message-ID: <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231220235459.2965548-1-markhas@chromium.org>
References: <20231220235459.2965548-1-markhas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The underlying ACPI and OF subsystems provide their own APIs which
provide IRQ information as a struct resource. This allows callers to get
more information about the IRQ by looking at the resource flags.  For
example, whether or not an IRQ is wake capable.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v2:
-New patch

 drivers/acpi/property.c  | 11 +++++------
 drivers/base/property.c  | 24 +++++++++++++++++++++---
 drivers/of/property.c    |  8 ++++----
 include/linux/fwnode.h   |  8 +++++---
 include/linux/property.h |  2 ++
 5 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a6ead5204046b..259869987ffff 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1627,17 +1627,16 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
-static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
-			       unsigned int index)
+static int acpi_fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
+					unsigned int index, struct resource *r)
 {
-	struct resource res;
 	int ret;
 
-	ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, &res);
+	ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, r);
 	if (ret)
 		return ret;
 
-	return res.start;
+	return r->start;
 }
 
 #define DECLARE_ACPI_FWNODE_OPS(ops) \
@@ -1664,7 +1663,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
 			acpi_graph_get_remote_endpoint,			\
 		.graph_get_port_parent = acpi_fwnode_get_parent,	\
 		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
-		.irq_get = acpi_fwnode_irq_get,				\
+		.irq_get_resource = acpi_fwnode_irq_get_resource,	\
 	};								\
 	EXPORT_SYMBOL_GPL(ops)
 
diff --git a/drivers/base/property.c b/drivers/base/property.c
index a1b01ab420528..4f5d5ab5ab8cf 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1047,23 +1047,41 @@ void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
 EXPORT_SYMBOL(fwnode_iomap);
 
 /**
- * fwnode_irq_get - Get IRQ directly from a fwnode
+ * fwnode_irq_get_resource - Get IRQ directly from a fwnode and populate
+ *			     the resource struct
  * @fwnode:	Pointer to the firmware node
  * @index:	Zero-based index of the IRQ
+ * @r:		Pointer to resource to populate with IRQ information.
  *
  * Return: Linux IRQ number on success. Negative errno on failure.
  */
-int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
+int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
+			    unsigned int index, struct resource *r)
 {
 	int ret;
 
-	ret = fwnode_call_int_op(fwnode, irq_get, index);
+	ret = fwnode_call_int_op(fwnode, irq_get_resource, index, r);
 	/* We treat mapping errors as invalid case */
 	if (ret == 0)
 		return -EINVAL;
 
 	return ret;
 }
+EXPORT_SYMBOL(fwnode_irq_get_resource);
+
+/**
+ * fwnode_irq_get - Get IRQ directly from a fwnode
+ * @fwnode:	Pointer to the firmware node
+ * @index:	Zero-based index of the IRQ
+ *
+ * Return: Linux IRQ number on success. Negative errno on failure.
+ */
+int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
+{
+	struct resource r;
+
+	return fwnode_irq_get_resource(fwnode, index, &r);
+}
 EXPORT_SYMBOL(fwnode_irq_get);
 
 /**
diff --git a/drivers/of/property.c b/drivers/of/property.c
index afdaefbd03f61..864ea5fa5702b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1425,10 +1425,10 @@ static void __iomem *of_fwnode_iomap(struct fwnode_handle *fwnode, int index)
 #endif
 }
 
-static int of_fwnode_irq_get(const struct fwnode_handle *fwnode,
-			     unsigned int index)
+static int of_fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
+				      unsigned int index, struct resource *r)
 {
-	return of_irq_get(to_of_node(fwnode), index);
+	return of_irq_to_resource(to_of_node(fwnode), index, r);
 }
 
 static int of_fwnode_add_links(struct fwnode_handle *fwnode)
@@ -1469,7 +1469,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
 	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
 	.iomap = of_fwnode_iomap,
-	.irq_get = of_fwnode_irq_get,
+	.irq_get_resource = of_fwnode_irq_get_resource,
 	.add_links = of_fwnode_add_links,
 };
 EXPORT_SYMBOL_GPL(of_fwnode_ops);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2a72f55d26eb8..716ed863acde0 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -9,10 +9,11 @@
 #ifndef _LINUX_FWNODE_H_
 #define _LINUX_FWNODE_H_
 
-#include <linux/types.h>
-#include <linux/list.h>
 #include <linux/bits.h>
 #include <linux/err.h>
+#include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/types.h>
 
 struct fwnode_operations;
 struct device;
@@ -164,7 +165,8 @@ struct fwnode_operations {
 	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
 				    struct fwnode_endpoint *endpoint);
 	void __iomem *(*iomap)(struct fwnode_handle *fwnode, int index);
-	int (*irq_get)(const struct fwnode_handle *fwnode, unsigned int index);
+	int (*irq_get_resource)(const struct fwnode_handle *fwnode,
+				unsigned int index, struct resource *r);
 	int (*add_links)(struct fwnode_handle *fwnode);
 };
 
diff --git a/include/linux/property.h b/include/linux/property.h
index e6516d0b7d52a..685ba72a8ce9e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -190,6 +190,8 @@ struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
+int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
+			    unsigned int index, struct resource *r);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
 unsigned int device_get_child_node_count(const struct device *dev);
-- 
2.43.0.472.g3155946c3a-goog


