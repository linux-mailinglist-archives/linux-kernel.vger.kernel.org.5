Return-Path: <linux-kernel+bounces-14844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D8282231F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6F21C22B70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE52199BF;
	Tue,  2 Jan 2024 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PcMWXXwG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E2818ED5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b7fb34265fso491742739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229741; x=1704834541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuhkCzL2l+Es2a6yZtXMYTtf834z1coLX69xx0eVIxw=;
        b=PcMWXXwGKxi3lOnc4PVx41Mbqm//fWa3Q8P5FK/aWfOfM4ABtshA+gXmY6cY5tkNqe
         A8sIKKRrVMk2Wgz+YPZcl7R+2GAF0KdMU6rHV5xr1AJt55NCYK65MqZ7LBZzmpSh0iC2
         qwsim/jG2f+82HVKObdmWlOw9oG0hMp41Y5Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229741; x=1704834541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuhkCzL2l+Es2a6yZtXMYTtf834z1coLX69xx0eVIxw=;
        b=KnLDm2vCvl/Dffv31Fzhgn3E3Ebwy5BFAsVPRgvRjLgx9YQLn9wygLexpPtVpOTHmv
         fInLxsbP9NPEBz3uaJNUgPAQuqOtLXNwJD7dccFMII7R7hvYa244haA0TFR6ViKXk8R6
         dYKQco9l9tEl4fvQzhnXC1cmxeRx4XX58iD2MCsUextUWxp27N+vhBjvLHoi0N0r3sZ9
         o0np4GRQaJGxKk1NSM7IAjJMQFOKr5Bha1/yyxbFWuvdDcWAHlzjhaWdI3x5mJrAyTrT
         wuRjRvZA5EP8MDLggyTBiR+wYzb/TMWYouSsngtFAqdV0wBd0g/8Yuge/J+PpC6DNTN8
         +xLg==
X-Gm-Message-State: AOJu0YwH0eHZPn4HmfdGE7wRDcNKOLK/up3uX8QNg0h8eTjgoqZRbNZr
	axCY05uiQfuGod8we9ms/xqY3dstBMIAkStE+48Au/u7qjOZ
X-Google-Smtp-Source: AGHT+IFp2QttZwtW1kCru0qHHoHoT70NG6O1ERnMyBH3znA+Ew+qlRfeZfzdwG/Vk/iKKPZKXXki8w==
X-Received: by 2002:a05:6602:1492:b0:7b7:be85:23c with SMTP id a18-20020a056602149200b007b7be85023cmr25585003iow.30.1704229741350;
        Tue, 02 Jan 2024 13:09:01 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:09:01 -0800 (PST)
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
Subject: [PATCH v4 20/24] of: irq: Remove extern from function declarations
Date: Tue,  2 Jan 2024 14:07:44 -0700
Message-ID: <20240102140734.v4.20.I319e781c11e6352eb5b6c408dc20bd54a720edbf@changeid>
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

The extern keyword is implicit for function declarations.
Remove it where possible and adjust the line wrapping accordingly.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v4:
-Add Rob's Ack tag from v2

Changes in v2:
-New patch

 include/linux/of_irq.h | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 0d73b2ca92d31..a130dcbc4bb45 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -32,27 +32,26 @@ static inline int of_irq_parse_oldworld(const struct device_node *device, int in
 }
 #endif /* CONFIG_PPC32 && CONFIG_PPC_PMAC */
 
-extern int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq);
-extern unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data);
+int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq);
+unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data);
 
 #ifdef CONFIG_OF_IRQ
-extern void of_irq_init(const struct of_device_id *matches);
-extern int of_irq_parse_one(struct device_node *device, int index,
-			  struct of_phandle_args *out_irq);
-extern int of_irq_count(struct device_node *dev);
-extern int of_irq_get(struct device_node *dev, int index);
-extern int of_irq_get_byname(struct device_node *dev, const char *name);
-extern int of_irq_to_resource(struct device_node *dev, int index, struct resource *r);
-extern int of_irq_to_resource_table(struct device_node *dev,
-		struct resource *res, int nr_irqs);
-extern struct device_node *of_irq_find_parent(struct device_node *child);
-extern struct irq_domain *of_msi_get_domain(struct device *dev,
+void of_irq_init(const struct of_device_id *matches);
+int of_irq_parse_one(struct device_node *device, int index,
+		    struct of_phandle_args *out_irq);
+int of_irq_count(struct device_node *dev);
+int of_irq_get(struct device_node *dev, int index);
+int of_irq_get_byname(struct device_node *dev, const char *name);
+int of_irq_to_resource(struct device_node *dev, int index, struct resource *r);
+int of_irq_to_resource_table(struct device_node *dev, struct resource *res,
+			    int nr_irqs);
+struct device_node *of_irq_find_parent(struct device_node *child);
+struct irq_domain *of_msi_get_domain(struct device *dev,
 					    struct device_node *np,
 					    enum irq_domain_bus_token token);
-extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
-							u32 id,
-							u32 bus_token);
-extern void of_msi_configure(struct device *dev, struct device_node *np);
+struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
+					       u32 bus_token);
+void of_msi_configure(struct device *dev, struct device_node *np);
 u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
 #else
 static inline void of_irq_init(const struct of_device_id *matches)
@@ -117,7 +116,7 @@ static inline u32 of_msi_map_id(struct device *dev,
  * implements it differently.  However, the prototype is the same for all,
  * so declare it here regardless of the CONFIG_OF_IRQ setting.
  */
-extern unsigned int irq_of_parse_and_map(struct device_node *node, int index);
+unsigned int irq_of_parse_and_map(struct device_node *node, int index);
 
 #else /* !CONFIG_OF && !CONFIG_SPARC */
 static inline unsigned int irq_of_parse_and_map(struct device_node *dev,
-- 
2.43.0.472.g3155946c3a-goog


