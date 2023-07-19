Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C99759448
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGSLgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjGSLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:36:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6832F170E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:36:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666edfc50deso508384b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689766565; x=1690371365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASJ6N1f2HtTSaai3pJY5ayecgWjGnn9m1BypIphubd8=;
        b=FNUJTTod8d8lkD0j2EWesqH3a2UI3TMHlDsCBF6GwyZAmOkXqcKEwV7u2/cVonYeiR
         LtQRO9edVmljFnQKOqJNIrd/xe/R1sZZY6PKCdm7l8CcXkLO6A6iBBF0RnhZVFiBd8mc
         GykZ3jM3Fzm8Ki7dKbZCksXdykfCpHEuNvd9ISOUhYa7AA9t5Ur7F+PhTagSyDzVY0YL
         nAdfgFdS9Plri5I+ku5NEbfrmRLqqU8vDErM99MLo9OJGBN1a6ecXpUCbScUtYV2Z8iD
         3TfS7WUMdTk+iEHmSEo09Vbj5bGCfWrfXuGhWNZxFCOnVEWA+eQS0RnS2dZu9bj4BK1R
         CEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766565; x=1690371365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASJ6N1f2HtTSaai3pJY5ayecgWjGnn9m1BypIphubd8=;
        b=QGI9/mKNPo/u8acCEcVzSm/+r5Q+0aELF+EuC+pdm9UQmBqHDn6lni+/38XucUBl7d
         WQXCOWIifyoYx8vHKgNvjstp2berfmOXKm/9QJui4+44Zjp8UoaoyUxtY81SoGjXQqcb
         WA1zNqBVgfSRa3S3ErKtfo3VFO685NYeIjrR250DTpB0jm3dF5QTCotIm3ah1DYvgLgQ
         KMgDdi2m5I9gJ2sDy21eBk7gxbUoCEJPwUIm754peeauQAVgoojzW6HanIkM7U+AwNv5
         HVyB2LxU/SLwpRIMB0AUh5kpujHnhHnRXKkzGvHFj49qNLTvj3tiMgVfrurXAhSQ2ZBy
         TiNg==
X-Gm-Message-State: ABy/qLZIC+BKzVJSgw7XTJndH7ReIVKcVgrXfrKXdvjbn19Au/4/FbhN
        HMJwc2JRN52/wyd27QLVxlJ8YA==
X-Google-Smtp-Source: APBJJlEt5NjiDD+SV5jYFnNxnx7P2kahDiZ6mEz+7XT5lgFV80n26BTX/gkKnX0j6e8fR7eYiMB7uQ==
X-Received: by 2002:a05:6a20:430f:b0:f0:50c4:4c43 with SMTP id h15-20020a056a20430f00b000f050c44c43mr2313038pzk.5.1689766564723;
        Wed, 19 Jul 2023 04:36:04 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.130])
        by smtp.gmail.com with ESMTPSA id j10-20020aa783ca000000b00669c99d05fasm3050408pfn.150.2023.07.19.04.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 04:36:04 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 02/14] of: property: Add fw_devlink support for msi-parent
Date:   Wed, 19 Jul 2023 17:05:30 +0530
Message-Id: <20230719113542.2293295-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719113542.2293295-1-apatel@ventanamicro.com>
References: <20230719113542.2293295-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows fw_devlink to create device links between consumers of
a MSI and the supplier of the MSI.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/of/property.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index ddc75cd50825..e4096b79a872 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1325,6 +1325,37 @@ static struct device_node *parse_interrupts(struct device_node *np,
 	return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
 }
 
+static struct device_node *parse_msi_parent(struct device_node *np,
+					    const char *prop_name, int index)
+{
+	struct of_phandle_args sup_args;
+	struct device_node *msi_np;
+
+	if (!IS_ENABLED(CONFIG_OF_IRQ))
+		return NULL;
+
+	if (strcmp(prop_name, "msi-parent"))
+		return NULL;
+
+	msi_np = of_parse_phandle(np, prop_name, 0);
+	if (msi_np) {
+		if (!of_property_read_bool(msi_np, "#msi-cells")) {
+			if (index) {
+				of_node_put(msi_np);
+				return NULL;
+			}
+			return msi_np;
+		}
+		of_node_put(msi_np);
+	}
+
+	if (of_parse_phandle_with_args(np, prop_name, "#msi-cells", index,
+				       &sup_args))
+		return NULL;
+
+	return sup_args.np;
+}
+
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
@@ -1359,6 +1390,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
+	{ .parse_prop = parse_msi_parent, },
 	{}
 };
 
-- 
2.34.1

