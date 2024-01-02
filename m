Return-Path: <linux-kernel+bounces-14842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F76682231C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6E11C22B30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74DB1945B;
	Tue,  2 Jan 2024 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BuKTDh26"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE018EB4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bade847536so342478539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229740; x=1704834540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukfFPOjxIuuxKMITUORsVWUdW86ng+CgXwCq16suFWg=;
        b=BuKTDh26A6XoTsL9jU4OHGP74zfboMwfa682+h1xxyYoT9Wy7X034wmDLOa2XtgGHj
         JNnJTueHayzv1E/RFzT1boN8Y1067xCddRoyDnwSi86lGooWovPJ5qzmDFOKvWp7DZNC
         KTbZD5Zoa8/3Fc58AX59iHYNm4dEDn288uGp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229740; x=1704834540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukfFPOjxIuuxKMITUORsVWUdW86ng+CgXwCq16suFWg=;
        b=K52+dZkqcwUdL33k4c+ykNU8wUHeT5xaWGV5wZr90RMEwtUK5C+lS6ddG2qBcTVoLc
         JnLbkKCGkC4HMDLXSoBpTdF4EzRAxf3hYnQp5njVc0qO/4q4Co+NbrHaW6HKJEotwQb3
         Lf/E32cMk6D29mRWojNQhYZ0lytJ3aERZS3HM3sTTyxtfQ4ED+eyOVSLlumvPXoVGLrt
         Aa5ZFXB5qZKJ+4gtvm65AUFm06ZIoFJ49ZbO1viq/gWHS5tjc+tX/SkZmKowBjaXa2o3
         tML1v8HexstfoMTPIb5EFERjFoGljyudhNmLzxBFd8UwTWVr3hdMBtMLiWmCUgA1Fnsk
         8j6Q==
X-Gm-Message-State: AOJu0YyrsPQfNixsVE/3fKMIV3UOHfGgo038iL7ASkudUQW6aSh4A1sQ
	1zEQ88GMgKCNa9y3fe/ZzINBgUIbMYtK+KQVj/cM4ZK8A1+O
X-Google-Smtp-Source: AGHT+IHQLlMXlASfyYWPPcAmTYaHNcLGLWehburZ9CX9ch22O4LYpZP838Qcp2DVG1hld682ssfAhg==
X-Received: by 2002:a5d:9a17:0:b0:7bb:41bd:715f with SMTP id s23-20020a5d9a17000000b007bb41bd715fmr12202311iol.39.1704229739844;
        Tue, 02 Jan 2024 13:08:59 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:08:59 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v4 18/24] of: irq: add wake capable bit to of_irq_resource()
Date: Tue,  2 Jan 2024 14:07:42 -0700
Message-ID: <20240102140734.v4.18.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240102210820.2604667-1-markhas@chromium.org>
References: <20240102210820.2604667-1-markhas@chromium.org>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v4:
-Add Rob's Reviewed-by tag from v2
-Ignored Andy's Reviewed-by tag per his request:
https://lore.kernel.org/all/ZYxgQn8L7ENkc0AJ@smile.fi.intel.com/

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


