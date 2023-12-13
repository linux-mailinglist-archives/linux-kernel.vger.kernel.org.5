Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A53D811BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378917AbjLMSBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjLMSBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:01:31 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3E783
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:01:37 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35d67aa6951so20728525ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702490497; x=1703095297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IE6mE6pjbGov9LkkEhCEwGDUbXlSJbMapTwV75Z3EGc=;
        b=eSF3iGXXOC2kQ3n5Nvjxs6TXImtBZ+93Z/bZSIAOBmGzEVcfVUtzn/EVhDmjEsflaq
         MZmH+PNqez1eEtLBjr+QZtLdrvyS19dkt6p8/fahgjp3jxHcDCYZUNQo9zxtMR7vDHe5
         Bncbrq6uoJ/qVNICvi3OH76+02VUHERHM3VFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490497; x=1703095297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IE6mE6pjbGov9LkkEhCEwGDUbXlSJbMapTwV75Z3EGc=;
        b=aaD6mzys0O/aqEXtnIbECOwKbdTr0LjdpKdhmg+7WodoLIzWSm8PmXTKajWhhLgb+j
         z6FilWaSUCC7+SGBwQMycWb4KRaXhxbVJ0JVMx1zFxun2DT4+owQYVsrzvRQdCb8OxKG
         2MTc3L0z7GM+MP3/oUh2aTSs11KMdmp1ZQvpEOdTim7IrGntq1fALcnHdJgGpsjpGqZe
         8kKx1bFMafmKMEFJJyEk/yI8E2nhoHFo5S6dO6KSHkuqxL8nuta5lKfGUYHIUVRX6KJZ
         96JhrBeY75S4tH62aV6d/cm75B6xQkp9BoST1gn6brdOCVXwMF2Np2BN2CgClVUksuol
         vfGg==
X-Gm-Message-State: AOJu0Yz2CZFBTE5UmP5ppiXeCITMKEy17lgmjFEwjgHdIAmya2cmJO62
        y2xPFjgv5SesesiNSO9/1ntu4639zJrfux3YTcI=
X-Google-Smtp-Source: AGHT+IFwHjqRnv3J268uplXRN6NW6wDD9LjTDk7o/KlDkWoKhoyaIiSuqY/p3e4OsbxoyoSGIJpY3Q==
X-Received: by 2002:a05:6e02:b45:b0:35d:59b3:2f86 with SMTP id f5-20020a056e020b4500b0035d59b32f86mr7479369ilu.27.1702490496668;
        Wed, 13 Dec 2023 10:01:36 -0800 (PST)
Received: from markhas1.corp.google.com ([100.107.108.224])
        by smtp.gmail.com with ESMTPSA id o28-20020a02cc3c000000b0046671f9717csm3161206jap.109.2023.12.13.10.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:01:36 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v1 3/6] of: irq: add wake capable bit to of_irq_resource()
Date:   Wed, 13 Dec 2023 11:00:21 -0700
Message-ID: <20231213110009.v1.3.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wake capability information to the irq resource. Wake capability is
assumed based on conventions provided in the devicetree wakeup-source
binding documentation. An interrupt is considered wake capable if the
following are true:
1. a wakeup-source property exits in the same device node as the
   interrupt.
2. No dedicated irq is defined, or the irq is marked as dedicated by
   setting its interrupt-name to "wakeup".

The wakeup-source documentation states that dedicated interrupts can use
device specific interrupt names and device drivers are still welcome to
use their own naming schemes. This api is provided as a helper if one is
willing to conform to the above conventions.

The ACPI subsystems already provides similar apis that allow one to
query the wake capability of an irq. This brings feature parity to the
devicetree.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 drivers/of/irq.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 174900072c18c..633711bc32953 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -383,11 +383,39 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_one);
 
+/**
+ * __of_irq_wake_capable - Determine whether a given irq index is wake capable
+ *
+ * The irq is considered wake capable if the following are true:
+ * 1. wakeup-source property exists
+ * 2. no dedicated wakeirq exists OR provided irq index is a dedicated wakeirq
+ *
+ * This logic assumes the provided irq index is valid.
+ *
+ * @dev: pointer to device tree node
+ * @index: zero-based index of the irq
+ * Return: True if provided irq index for #dev is wake capable. False otherwise.
+ */
+static bool __of_irq_wake_capable(const struct device_node *dev, int index)
+{
+	int wakeindex;
+
+	if (!of_property_read_bool(dev, "wakeup-source"))
+		return false;
+
+	wakeindex = of_property_match_string(dev, "interrupt-names", "wakeup");
+	return wakeindex < 0 || wakeindex == index;
+}
+
 /**
  * of_irq_to_resource - Decode a node's IRQ and return it as a resource
  * @dev: pointer to device tree node
  * @index: zero-based index of the irq
  * @r: pointer to resource structure to return result into.
+ *
+ * Return: Linux IRQ number on success, or 0 on the IRQ mapping failure, or
+ * -EPROBE_DEFER if the IRQ domain is not yet created, or error code in case
+ * of any other failure.
  */
 int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 {
@@ -411,6 +439,8 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 
 		r->start = r->end = irq;
 		r->flags = IORESOURCE_IRQ | irqd_get_trigger_type(irq_get_irq_data(irq));
+		if (__of_irq_wake_capable(dev, index))
+			r->flags |= IORESOURCE_IRQ_WAKECAPABLE;
 		r->name = name ? name : of_node_full_name(dev);
 	}
 
-- 
2.43.0.472.g3155946c3a-goog

