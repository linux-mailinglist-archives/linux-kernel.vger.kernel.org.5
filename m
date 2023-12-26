Return-Path: <linux-kernel+bounces-11648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D9481E967
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03384280FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD991A70F;
	Tue, 26 Dec 2023 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fCnWs/2R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572718EDA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b7fe0ae57bso282940339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618539; x=1704223339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGEOA7VnVi81L2sEgap1qKk2oI4GW7FWt/PKKqipwFA=;
        b=fCnWs/2RPcwyS4r+8mm40SUREOvOYuS/hgHs9WpcYGgE4tILMBxqFZOHCUfFGmgH6e
         w5qyDxkpcAaDNhixYqLnFqBdEVug3YZaAgU+FS4j+ckG0UZqSJR7L9F42PnvQzlyLdk9
         E2iSsyTZxGk+YyqkX/vaCWu0U3VPmwz/r4hLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618539; x=1704223339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGEOA7VnVi81L2sEgap1qKk2oI4GW7FWt/PKKqipwFA=;
        b=wwxbMHWX0+Z6IujyVBBS+QlGwClEo9XjOQcvDSDL5AeKy/JCGBYSj/j+bjZO3nLTJ5
         61rA59qutvB9DRgzlF1QY/oGTJOJekYLHDJf+03rOT99Fd6DnDVAZGd/jhlfkxgSi3lM
         qIpDc77UgWYWxvtZu/8w4e01SSVn1uJMkVIP+VOAOZitQJcgoaLzkBvQiLr6CakleiLU
         9sHSnhredBapwLLioyKFMJm+fMU+zoQfUJOj8BT8ZDi9265xHo0Q/lScyk1PdVMpEQ+U
         Fb8S1deIu0pnzDPPSS8zVkVRAKvusk7GhX+GIWBT1r8KXroJQcBBgbFdcC/AdoroovjG
         HK3g==
X-Gm-Message-State: AOJu0Yy0wDgjw8eRlN0uBLU4Wyegg4JFc0CQXX2Twx2d1pUWcSdy1PmF
	Ke2fcrA9OydO4aNowJxfkC62SPvpBqDbq1cTu/3AgW5ecM+l
X-Google-Smtp-Source: AGHT+IGwo5chhqjsS60uLPxsZz7Aue5NMBmLwETHgxYW043SgR4k4mm2O7+bTWAEs3KDxRW8UynYJQ==
X-Received: by 2002:a05:6602:1492:b0:7ba:9707:67ad with SMTP id a18-20020a056602149200b007ba970767admr14464146iow.28.1703618539365;
        Tue, 26 Dec 2023 11:22:19 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:19 -0800 (PST)
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
Subject: [PATCH v3 20/24] of: irq: Remove extern from function declarations
Date: Tue, 26 Dec 2023 12:21:24 -0700
Message-ID: <20231226122113.v3.20.I319e781c11e6352eb5b6c408dc20bd54a720edbf@changeid>
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

The extern keyword is implicit for function declarations.
Remove it where possible and adjust the line wrapping accordingly.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

(no changes since v2)

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


