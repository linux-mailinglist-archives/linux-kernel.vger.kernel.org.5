Return-Path: <linux-kernel+bounces-14843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5669182231E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D9C1F23700
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9541947D;
	Tue,  2 Jan 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jd+OrY9Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350218ECB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-35fe47edd2eso20695865ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229740; x=1704834540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrqyCRQGWqtYZon/B8x6Cl4Beyi5N2srdFtijVb67bM=;
        b=Jd+OrY9YWz3i/Dgd40CfK61o+Ojf3v5aYpvPs2XixprcNnM76DiksrFsbbvnYCw1F/
         NsxXHGO/4IdweWWLAfvIFHf3LCILdaCKVxlgufoMIRO5YwRMy8+w1Zs+GD/2UzJNi/6Q
         4C4KqXzv4tj0m1mlNjS+7c7LM29ibY27GoC8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229740; x=1704834540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrqyCRQGWqtYZon/B8x6Cl4Beyi5N2srdFtijVb67bM=;
        b=g99TlKcnX2a86hOv18ZUq9wlLTmnot74zH2AdQJ4aL/2MTgEyF8k6ibq6n7BWpsgFq
         HB3PazDILxhqh8o2rhVNNKXWJeB3cqO4iw71chEnGSAI9UmdAKzDbeZsNgGeAlLX/Vjo
         XBisXZV7DvUWbL/gDmmWKPfgWcgYcCptlhDY7OTMb2Jq4cC80XmDzDQpjkWTBAC9GwIl
         Ip7DfbcTWu6poRw0pI37vkmu9Fir6vnlB3fZhAIQ29YfMBzwg6i1ImPuLW/mU8zYYeK2
         EPmEmkZY+/SyubtfDpwnOGLWNx17dpMWL1RETthERuM2g48k4ytHRvHAPo1U+hXW+mNm
         S/Kg==
X-Gm-Message-State: AOJu0YywHGWtmbFru5tYoH3HFXKCU2rmaYNrC6nlF9JtrLoOAT6vTtxa
	VFnx/RhGR6HzYnyVOVlm5tx9OlcnfESFZ0U3jK1rjGzFQNBL
X-Google-Smtp-Source: AGHT+IFQzUcaDIy67wDz2ySoGOwpwi0H1El9nejGF4EWnyK78NzOzFm7YOjrdDK8vQhhffUOy1ZGCw==
X-Received: by 2002:a05:6e02:1a0e:b0:35d:59b3:2f7d with SMTP id s14-20020a056e021a0e00b0035d59b32f7dmr40919ild.18.1704229740602;
        Tue, 02 Jan 2024 13:09:00 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:09:00 -0800 (PST)
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
Subject: [PATCH v4 19/24] of: irq: Add default implementation for of_irq_to_resource()
Date: Tue,  2 Jan 2024 14:07:43 -0700
Message-ID: <20240102140734.v4.19.I31d4dd6a7e5a3e5eee05c87b358e63cd1aa0e467@changeid>
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

Similar to of_irq_to_resource_table(), add a default implementation of
of_irq_to_resource() for systems that don't have CONFIG_OF_IRQ defined.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v4:
-Add Rob's Ack tag from v2

 include/linux/of_irq.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index d6d3eae2f1452..0d73b2ca92d31 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -34,8 +34,6 @@ static inline int of_irq_parse_oldworld(const struct device_node *device, int in
 
 extern int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq);
 extern unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data);
-extern int of_irq_to_resource(struct device_node *dev, int index,
-			      struct resource *r);
 
 #ifdef CONFIG_OF_IRQ
 extern void of_irq_init(const struct of_device_id *matches);
@@ -44,6 +42,7 @@ extern int of_irq_parse_one(struct device_node *device, int index,
 extern int of_irq_count(struct device_node *dev);
 extern int of_irq_get(struct device_node *dev, int index);
 extern int of_irq_get_byname(struct device_node *dev, const char *name);
+extern int of_irq_to_resource(struct device_node *dev, int index, struct resource *r);
 extern int of_irq_to_resource_table(struct device_node *dev,
 		struct resource *res, int nr_irqs);
 extern struct device_node *of_irq_find_parent(struct device_node *child);
@@ -76,6 +75,11 @@ static inline int of_irq_get_byname(struct device_node *dev, const char *name)
 {
 	return 0;
 }
+static inline int of_irq_to_resource(struct device_node *dev, int index,
+			      struct resource *r)
+{
+	return 0;
+}
 static inline int of_irq_to_resource_table(struct device_node *dev,
 					   struct resource *res, int nr_irqs)
 {
-- 
2.43.0.472.g3155946c3a-goog


