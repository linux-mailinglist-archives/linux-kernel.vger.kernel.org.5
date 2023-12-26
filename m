Return-Path: <linux-kernel+bounces-11647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4113681E965
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DF31F21A21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B20199D7;
	Tue, 26 Dec 2023 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FO7BKyE9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC018EAB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7ba737ee9b5so363194539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618538; x=1704223338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhThlCXf4PlI+V7Ie+OwgPGYRnxlVhq49B6FDf9+u+w=;
        b=FO7BKyE98Gq3AYO7PzsQI/wCt5Fz/LrbnBEKuzwakCl+pkyybFs7CUNCaGd3TF72oQ
         JiOazGyCpAzTT3+W1sbfFQZ08usWpnx/aon3JYjtPiGCUOx0AX7FI4ZjjIoU4zo0Nkeg
         TC46+hRik18wYf5firvJfO0CTQexqeO01Hqnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618538; x=1704223338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhThlCXf4PlI+V7Ie+OwgPGYRnxlVhq49B6FDf9+u+w=;
        b=c91oyDi8qAHL1owWhjyjVwGYoJqmvjns8WPkjK1faHkH3axW8TG+iQ0XVjj/dtksLc
         CTTw6DfeYJDbtSRlM5lZusYPSIb0HB444EKITgYEiZIcmoy1kJRDuByTdiNzz9PuHiFD
         lpk3kBAcvCnuD4KyGzl0Xdj/YFAbfyzz6WZjU5WQH96q5aIbz1DOfMSqqcUtU0nxfAFP
         oE/mrLnfbr5On27FgfnSRAw9zKS6fSCHPIjS03qS+MUwAARqKoR0feswkPHoSaij5M78
         DQWGfyvNRNYi8jhSnU8VNyKZuZ75FGDgucfqZy8w2W/YcS9TI59YmTSDglFnTirQ9Q6N
         bzVA==
X-Gm-Message-State: AOJu0Yxp4fLoG0+dZvb1ZO90F1B7BM0qSRr46ulUujliz6ZIJuqXWnnl
	BgMoC0E/l2eMrpg86rk1V5aFVGqOs3+hwWUl+iitpykKwu10
X-Google-Smtp-Source: AGHT+IG+oBvf736p4CYnXNTAe9f7VKS0Qra4N66ekMcdhT2xg9kaGf/7l7hmK3fXMidgrhCoUTrIkQ==
X-Received: by 2002:a6b:e80d:0:b0:7b3:9356:665 with SMTP id f13-20020a6be80d000000b007b393560665mr10502815ioh.4.1703618538568;
        Tue, 26 Dec 2023 11:22:18 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:18 -0800 (PST)
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
Subject: [PATCH v3 19/24] of: irq: Add default implementation for of_irq_to_resource()
Date: Tue, 26 Dec 2023 12:21:23 -0700
Message-ID: <20231226122113.v3.19.I31d4dd6a7e5a3e5eee05c87b358e63cd1aa0e467@changeid>
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

Similar to of_irq_to_resource_table(), add a default implementation of
of_irq_to_resource() for systems that don't have CONFIG_OF_IRQ defined.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

(no changes since v2)

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


