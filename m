Return-Path: <linux-kernel+bounces-7670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8657E81AB75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87CA1C20B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7627850243;
	Wed, 20 Dec 2023 23:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ieMQxj5w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94C4F5FA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35fc6eb9075so619165ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703116523; x=1703721323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKh5FX4xH2A55TvaLBm+1lswVT7mH5LMvN7VXVfLl8c=;
        b=ieMQxj5wfYGB1TiYeOYZCbjVxOt4Rz94IXWdMs4OMMQukhyWpk8iRfK8F32s6INq3n
         nP40GVvM2bHStM/qkxPwfs8LybFBxzjdxyP+k6qvzJhCaY3nSyE9tjr2weZMiifFyjrC
         QltXU3YE+xn5zUxK+U3RA6KCXBGJ2/y4ge17c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116523; x=1703721323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKh5FX4xH2A55TvaLBm+1lswVT7mH5LMvN7VXVfLl8c=;
        b=gNiCMIoyrWOv3BxpnxrCw5xBHUlyi/5hhjBjVsERQLh8DMTnkuvgNWlUim6eg6jDK2
         eVK8w+UVZ9XJjMg6yelzW7cHJwjcy/t0nTbefsOQR3/aTz9Ylayk9f5YunSA+fnOLOrA
         3+6ZnY36Ve6+ZEum91TFBFotzDsXtHL2xqc81XZCcWbZez8c9S0An0SeI+pWu9uLR7pE
         BRnVfYKKWCfH2rEZjDq0zwIm4z93NDFblYQ8Xw2pWCwAN7mYmM9cOgu7Tt9LXTC0iz2T
         O8WaX+K+uMqS0ThsnWxUm1XEt10mScZtf4Gw4XWsN+paiBOQwSfdFjI0trMFhNE+NXQI
         JgLw==
X-Gm-Message-State: AOJu0YxXcVg/l900N2OpKgXYvUtk/gVWuPMzEuCY4pgG893bp86Mrah7
	gWO5VKD42sxL0PlUdzsEfha0EiEJLiA6B/NaDBWIDxNjfQ==
X-Google-Smtp-Source: AGHT+IEmW9gIzUsmNqEyx5I4EH1A+yRQP7jOpEKHuyJqA2GJeCmFZb3fstaeE8sjWD7QqAT20uydcQ==
X-Received: by 2002:a05:6e02:1bc4:b0:35d:4463:5dd2 with SMTP id x4-20020a056e021bc400b0035d44635dd2mr2680020ilv.16.1703116523652;
        Wed, 20 Dec 2023 15:55:23 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056638441600b0046b39a6f404sm177805jab.17.2023.12.20.15.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:23 -0800 (PST)
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
	Frank Rowand <frowand.list@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 17/22] of: irq: add wake capable bit to of_irq_resource()
Date: Wed, 20 Dec 2023 16:54:31 -0700
Message-ID: <20231220165423.v2.17.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
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

Add wake capability information to the IRQ resource. Wake capability is
assumed based on conventions provided in the devicetree wakeup-source
binding documentation. An interrupt is considered wake capable if the
following are true:
1. A wakeup-source property exits in the same device node as the
   interrupt.
2. The IRQ is marked as dedicated by setting its interrupt-name to
   "wakeup".

The wakeup-source documentation states that dedicated interrupts can use
device specific interrupt names and device drivers are still welcome to
use their own naming schemes. This API is provided as a helper if one is
willing to conform to the above conventions.

The ACPI subsystems already provides similar APIs that allow one to
query the wake capability of an IRQ. This brings closer feature parity
to the devicetree.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v2:
-Update logic to return true only if wakeup-source property and
 "wakeup" interrupt-name are defined
-irq->IRQ, api->API

 drivers/of/irq.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 174900072c18c..7583adf386220 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -383,11 +383,39 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_one);
 
+/**
+ * __of_irq_wake_capable - Determine whether a given IRQ index is wake capable
+ *
+ * The IRQ is considered wake capable if the following are true:
+ * 1. wakeup-source property exists
+ * 2. provided IRQ index is labelled as a dedicated wakeirq
+ *
+ * This logic assumes the provided IRQ index is valid.
+ *
+ * @dev: pointer to device tree node
+ * @index: zero-based index of the IRQ
+ * Return: True if provided IRQ index for #dev is wake capable. False otherwise.
+ */
+static bool __of_irq_wake_capable(const struct device_node *dev, int index)
+{
+	int wakeindex;
+
+	if (!of_property_read_bool(dev, "wakeup-source"))
+		return false;
+
+	wakeindex = of_property_match_string(dev, "interrupt-names", "wakeup");
+	return wakeindex >= 0 && wakeindex == index;
+}
+
 /**
  * of_irq_to_resource - Decode a node's IRQ and return it as a resource
  * @dev: pointer to device tree node
- * @index: zero-based index of the irq
+ * @index: zero-based index of the IRQ
  * @r: pointer to resource structure to return result into.
+ *
+ * Return: Linux IRQ number on success, or 0 on the IRQ mapping failure, or
+ * -EPROBE_DEFER if the IRQ domain is not yet created, or error code in case
+ * of any other failure.
  */
 int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 {
@@ -411,6 +439,8 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 
 		r->start = r->end = irq;
 		r->flags = IORESOURCE_IRQ | irqd_get_trigger_type(irq_get_irq_data(irq));
+		if (__of_irq_wake_capable(dev, index))
+			r->flags |= IORESOURCE_IRQ_WAKECAPABLE;
 		r->name = name ? name : of_node_full_name(dev);
 	}
 
-- 
2.43.0.472.g3155946c3a-goog


