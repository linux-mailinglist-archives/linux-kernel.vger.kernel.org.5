Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFCD76D0D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjHBPBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjHBPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:00:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE49C2102
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:00:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so44617745ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690988447; x=1691593247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPuFg1jno1oVTGYezxwpn/gD6ksCLDxjcobGXZlcbfU=;
        b=XEBv/c1fA3WSJR0RHnowCFL9E23UkdXWnc8vmmLd9kUwgXAdf9RaxT93aYIdiD7mrH
         vDJl37gsBjWDjtvDHSmqVesgl0I2i2SMglefm0Nz6sdiWrCKSb0TE76hZbp72z8zOPlM
         KxjLbyjySxoLvzt85UXNgKRPfYOhWLKfdKXpXhlhhh43SuA6aHHgwS8CkDLz/JnsHC04
         p8lHVR6OjQYKUeokFmm4ucSnn83S1kbUP2/NkRKR3kAsCvdGXiYmOBfixYle8IdOPBqK
         hrhLJnvL1kXjkeqPjvOQUZgAfNOQe9RAaqRdEPHAO72+J4N1iClEMq/PLqRPkn8z39ny
         /zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988447; x=1691593247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPuFg1jno1oVTGYezxwpn/gD6ksCLDxjcobGXZlcbfU=;
        b=Y8YpFtmLB3lJTGmN6yR18myJAxh47N/j4zZVk3o0iaHieD21aUdcZZUZOigVZW53DN
         Nl1n7IIlWtxYq+l5FWBtq5/oSQCKPBZY7pmO7fkHjIpCkvDnNsGrp66JHsty064Xq3X/
         z4wjlEs2wv/9tlwkciKC68RxLjUrhlPge8VU6cJUKNE+9MalC8tReSn3ozt61OU63Ee9
         Jy49YU+LwnHGUNSO1b03N7EayAZGrkNm0zQZi+dt8lNKq/Plwpa6HT31K9In1EBPZXt9
         VcIu3rlUt0OX3LNnx/kOgZIzsm0awAn06pE6I8woCGjroOXq2w0K2OSBx7VgQJuT/fXc
         9CnQ==
X-Gm-Message-State: ABy/qLZKKh4Xiw9yqDOq5haNJrsarW4EzU1YGhtMSVBpQ+tPZ61w9Sro
        +7Xn377MIApcgEysD+lqFdgLmg==
X-Google-Smtp-Source: APBJJlHfD1Cnw+bROUs5JbYT1+t6D+D+RNpsuGnDKaOUE/NC6yxGNju+iQRoLPFBgRFtbdfnwJF0wg==
X-Received: by 2002:a17:902:c20d:b0:1bb:9bc8:d22d with SMTP id 13-20020a170902c20d00b001bb9bc8d22dmr14426201pll.16.1690988447086;
        Wed, 02 Aug 2023 08:00:47 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001bb99e188fcsm12503963plo.194.2023.08.02.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:00:46 -0700 (PDT)
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
Subject: [PATCH v7 02/15] of: property: Add fw_devlink support for msi-parent
Date:   Wed,  2 Aug 2023 20:30:05 +0530
Message-Id: <20230802150018.327079-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802150018.327079-1-apatel@ventanamicro.com>
References: <20230802150018.327079-1-apatel@ventanamicro.com>
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
index ddc75cd50825..bc20535deed7 100644
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
+	if (IS_ENABLED(CONFIG_SPARC))
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

