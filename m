Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A009F811BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378818AbjLMSBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjLMSBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:01:32 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07A510A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:01:38 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35f71face1bso4229275ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702490498; x=1703095298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W+jCmhtVUK3Oan20pcyAoaX1l8QrXEMpfoAzq+htTI=;
        b=K3uuzmd2WbSz2A8XCRYtvEjPlaG28elxyT2ZLFTIIkr/wVGwhpPttmE4sc45Yul2l1
         Mu09fcLdOaHgpRyCeFEW0nInQYk8IhvmCIUrmlzehtkTpv9e8DgAca8nShBj6BRarEZm
         1qyT5jSkVXLDbTm9jcz9q9IogBPwKcLYoQ2Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490498; x=1703095298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W+jCmhtVUK3Oan20pcyAoaX1l8QrXEMpfoAzq+htTI=;
        b=LrqnMV8pxJveLHvwEKlsM7I0zXL2vjb0IuyxZtEqW8l+SDiiqj7T9PSXM62oYVeY1E
         KKxxO1JVzin2L4QuDYj3m8r4iuA9cONTKe6JTgXXVyNMDduvRi+BdwyF5Az22E+TtAER
         7jCHBEQTEHhqeQW0Lf+AYEDXWo1n9AF+ZUVkbIJrKJjHA43X4zc02zIs9fSAB/KltKFl
         FkEtoxizUm9gkTICCAYLHd7ZI7r+AU9UZnwH4lPtnbhNq2tTnGRZnDwYauRnCY8zmCqk
         WUDbXwkdcZWlllivqIlgxBJC6BeTb6bjmX29CxnDKKELmkIT1xH3QtNshyt8aUEUhwST
         ZeKw==
X-Gm-Message-State: AOJu0Yx00sQOJ6vUxVaIECmDa+UgZZfakmkKa7nl4ljGq9T9DY6PsuaD
        +nPN+/puX4V/cXMAnxmZSQzZEamAJ/S6PpcyWmY=
X-Google-Smtp-Source: AGHT+IELI/uKSCSYhwonacNwShqkQmhJaxoyNT51dJ3J3dNXC38tVsj6RuB0i9ZNNb0xs8/VHJAoXg==
X-Received: by 2002:a92:d948:0:b0:35d:59a2:92ab with SMTP id l8-20020a92d948000000b0035d59a292abmr7913891ilq.63.1702490497991;
        Wed, 13 Dec 2023 10:01:37 -0800 (PST)
Received: from markhas1.corp.google.com ([100.107.108.224])
        by smtp.gmail.com with ESMTPSA id o28-20020a02cc3c000000b0046671f9717csm3161206jap.109.2023.12.13.10.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:01:37 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v1 4/6] of: irq: Add default implementation for of_irq_to_resource()
Date:   Wed, 13 Dec 2023 11:00:22 -0700
Message-ID: <20231213110009.v1.4.I31d4dd6a7e5a3e5eee05c87b358e63cd1aa0e467@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to of_irq_to_resource_table(), add a default implementation of
of_irq_to_resource() for systems that don't have CONFIG_OF_IRQ defined.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 include/linux/of_irq.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index d6d3eae2f1452..817c7510082cb 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -34,8 +34,6 @@ static inline int of_irq_parse_oldworld(const struct device_node *device, int in
 
 extern int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq);
 extern unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data);
-extern int of_irq_to_resource(struct device_node *dev, int index,
-			      struct resource *r);
 
 #ifdef CONFIG_OF_IRQ
 extern void of_irq_init(const struct of_device_id *matches);
@@ -44,6 +42,8 @@ extern int of_irq_parse_one(struct device_node *device, int index,
 extern int of_irq_count(struct device_node *dev);
 extern int of_irq_get(struct device_node *dev, int index);
 extern int of_irq_get_byname(struct device_node *dev, const char *name);
+extern int of_irq_to_resource(struct device_node *dev, int index,
+			      struct resource *r);
 extern int of_irq_to_resource_table(struct device_node *dev,
 		struct resource *res, int nr_irqs);
 extern struct device_node *of_irq_find_parent(struct device_node *child);
@@ -76,6 +76,11 @@ static inline int of_irq_get_byname(struct device_node *dev, const char *name)
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

