Return-Path: <linux-kernel+bounces-11646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6057C81E963
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41681F22883
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBB19456;
	Tue, 26 Dec 2023 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RWv8qcAs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351618C3B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b7fdde8b54so249164339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618538; x=1704223338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxmhdaZ3UzecFQENHodwfGETPRP37VNTRDU74oHDCzk=;
        b=RWv8qcAs2uBHdnfNlufkkGBYghPrJw7pIP95YqvmnCsSj9ZAyAWarxzYnpCBXmFXbX
         h1MDQjxJ0jj61vXii4tPNSxKf6iZXuBfIsQdjnUP6h1YFAvTEECp2LxBDKCqxY0858at
         +n9Y3NMZCiH+aUDbdu6pOy918M9OHUaloCqkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618538; x=1704223338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxmhdaZ3UzecFQENHodwfGETPRP37VNTRDU74oHDCzk=;
        b=bvO2lf2eUpYoeEzKzMpVCqPgVHFINVDc5BYW6eXOqI/TrNyVlDd2F87Je7gcTPgQgl
         Sl9+OWVl7cVCUDG6bG0MPm+rpnzp+vuBMUifwnXB/7m5ZlLn1tqD/NNWZjryDM9hN8JO
         Q8WArxTbHCJnsPVUDwwKV/+z+tOaoCymrLVrWia1AviX+2t5gX2OxGYMJaOgeKCu9aNU
         TFtBTxjfxKha2a4swtJZjVkXgNgBZ+v0Aa4O0laKF2Ndq/o04OIiI0FZkL6GM66gFsHp
         o+8zb8pEEuswR6nNvW+SBltWHQRxcLnxa6lQ3rBdyqwzOHxnTIRehvtDq5w+i7GeSUAr
         yD2Q==
X-Gm-Message-State: AOJu0Yy1t2qJ9aE7oI/B3Qjf1VXLm7XQ2WNAPY9Q8uachI3NTc1jG6eA
	SJURI25Ww23+TQuNLqrOkr3VzOmwOIJy7iNg7DW3B/RBAVht
X-Google-Smtp-Source: AGHT+IEqSgC8hhnx7dR56hSUAn0xu8OJZ2XCJkAuVfhkLlOJtzedd7KZq8eCLrxJSgwWJ7fRF/1kIg==
X-Received: by 2002:a05:6602:4908:b0:7ba:b173:502b with SMTP id ef8-20020a056602490800b007bab173502bmr10010919iob.24.1703618537789;
        Tue, 26 Dec 2023 11:22:17 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:17 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 18/24] of: irq: add wake capable bit to of_irq_resource()
Date: Tue, 26 Dec 2023 12:21:22 -0700
Message-ID: <20231226122113.v3.18.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231226192149.1830592-1-markhas@chromium.org>
References: <20231226192149.1830592-1-markhas@chromium.org>
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

Changes in v3:
-Use DEFINE_RES_IRQ_NAMED_FLAGS macro

Changes in v2:
-Update logic to return true only if wakeup-source property and
 "wakeup" interrupt-name are defined
-irq->IRQ, api->API

 drivers/of/irq.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 174900072c18c..cdecdc3515f88 100644
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
@@ -399,6 +427,7 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 	/* Only dereference the resource if both the
 	 * resource and the irq are valid. */
 	if (r && irq) {
+		u32 irq_flags;
 		const char *name = NULL;
 
 		memset(r, 0, sizeof(*r));
@@ -409,9 +438,11 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 		of_property_read_string_index(dev, "interrupt-names", index,
 					      &name);
 
-		r->start = r->end = irq;
-		r->flags = IORESOURCE_IRQ | irqd_get_trigger_type(irq_get_irq_data(irq));
-		r->name = name ? name : of_node_full_name(dev);
+		irq_flags = irqd_get_trigger_type(irq_get_irq_data(irq));
+		if (__of_irq_wake_capable(dev, index))
+			irq_flags |= IORESOURCE_IRQ_WAKECAPABLE;
+
+		*r = DEFINE_RES_IRQ_NAMED_FLAGS(irq, name ?: of_node_full_name(dev), irq_flags);
 	}
 
 	return irq;
-- 
2.43.0.472.g3155946c3a-goog


