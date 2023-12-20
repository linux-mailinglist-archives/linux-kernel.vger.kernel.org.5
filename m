Return-Path: <linux-kernel+bounces-7671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DAF81AB77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887961F24299
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8A5026E;
	Wed, 20 Dec 2023 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RTult0R2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA94F892
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7b7fbe3db16so8312739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703116524; x=1703721324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGuZXGW/tZ1AN0p557o5C5f/tYqgvv6aKKeuF8fEKW0=;
        b=RTult0R2kNN/Ah8ueZDjGp0VS3HMqdkRL4Yn56i2O4KqPkVI9buwRJFYTAzWF6kU5l
         GaM4S3MtRxWGfsrGfiW/a0b7YgCnBjx4sqbmrHECczjC5BG7w7onpDYatWzGs5W+1ACQ
         It9z4KD2cNV7srisn0btvOR1nbuAGs7t6Lm5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116524; x=1703721324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGuZXGW/tZ1AN0p557o5C5f/tYqgvv6aKKeuF8fEKW0=;
        b=A/rqU4dj2Sz5Gc3urbyZtqun/BVGJNnYfGaW3QpwiBG1ctLlWekBtYn5PgwAYcB5mQ
         21Gs6bQLyc1w1UCnKN12VCkpYcYYNPxMwHXg85iAsx/xGfE078tCdk9dXZKLjrxYWtY0
         UmgEsnjErgxLEK2wYtoQiBPbda/KqkM3Xt6xOxdnCIYas3yiY9TBeTBNObH6rrTn4QJl
         mAZbopDiEeC9RUtitAUxAvGp7ZRMVnwCAuFgj6Ybk5FEi7c1IXpUBzJB+1u7uhvqfH+q
         QIiPMDMtvL8aSh9SbATA90wtwJ8nsYZ8SDXO3PIWFNACPcfDIjZjR4sOUAwDx9bHVItF
         3GNg==
X-Gm-Message-State: AOJu0YyAyFaawPeJAGu3f3NTjaDh5N43q0Xo7shRCnfj0F1vIR3Lja33
	b1eYfgeP1+gDz2Fvd6hZjOQFQf9f1a+J3fTpuZM=
X-Google-Smtp-Source: AGHT+IHwsyDhLKH4KCjyu9wSKyc/C2kTcwRhw8xhhn17ISW39v1/k+XbVmie3GgkSnB8nUOY8TufEQ==
X-Received: by 2002:a6b:7305:0:b0:7b9:c344:6e77 with SMTP id e5-20020a6b7305000000b007b9c3446e77mr2318247ioh.8.1703116524433;
        Wed, 20 Dec 2023 15:55:24 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056638441600b0046b39a6f404sm177805jab.17.2023.12.20.15.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:24 -0800 (PST)
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
Subject: [PATCH v2 18/22] of: irq: Add default implementation for of_irq_to_resource()
Date: Wed, 20 Dec 2023 16:54:32 -0700
Message-ID: <20231220165423.v2.18.I31d4dd6a7e5a3e5eee05c87b358e63cd1aa0e467@changeid>
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

Similar to of_irq_to_resource_table(), add a default implementation of
of_irq_to_resource() for systems that don't have CONFIG_OF_IRQ defined.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v2:
-None

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


