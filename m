Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4017D9D38
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346149AbjJ0Pn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346205AbjJ0PnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:43:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA85E1B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:43:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c8a1541232so19797235ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698421399; x=1699026199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KBK3NZC+n7aQ9gEOFAwoNpYjPv+cjuqYwdG+XSaoH8=;
        b=T0LJAPNB19x+3cmpdpCBFxa32T0bxfaocCYvLabqvXPV9ZjGHp+oLN1bwZ9aCEqMCS
         G1gtQiVWX7fYCtaN+EneO+PwtFwtKiTC9OycHz37V+/RPHJFNLWumK4yJ4WlyF9X6R/2
         es5UTdClqdZUdwQPm2APlb/8jUCXRv+7q5Q2sy+DQiOZ9LzrAYkNb6PyDoaPFLxJ8Nir
         vviSUJR4zf6R4KDBinF1/oFme7+MCiQ3PPiRbGMzWjpww/JEwYzMBeGg7uPZW6VhDJrk
         16hwGHiKxzSlYJdYdUqMiJp7716cGCBSZbdOYioVuMBcnsrYvf16WsRiZxz0kVcBthPs
         xnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421399; x=1699026199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KBK3NZC+n7aQ9gEOFAwoNpYjPv+cjuqYwdG+XSaoH8=;
        b=TEqEVYmdZwq2oIHil3fEJfxHenswfhlfdD20i3ScGv5AG6u74rIjuGskdVLIH+SHiA
         O/JF/ljHiS7gupei192BRMO5IpQA0Uoh28v2ArCgpFK7FTomMdZ84oytHjbFpAyAhD4B
         PryS4lzipL6CrMAaubGZAgKCWYIwXobeSQQjWIzYwlk/TTfn8pIOOicRE7P/1Wp5iZRV
         4SUOG4kdPWeD3qP0up+Hv+YP1Cp672hpYCgo8psCsu2LPxRiJJ7FX2iS8p4AbZ1GdxkV
         3PCtNVBKl11VGjeLGbQIhQZ7AHF5dTJw66Z/Y8joMJ65dDWiB3aSAAHS3DjQzPu7r+BL
         ZHIA==
X-Gm-Message-State: AOJu0YzuZAZcwpz1L40mJ3lmwr6VLP96YIXRtaSwr3hKh7j3xL4tHxJd
        5hitA00NeJ/65WQrQZZGFHuArA==
X-Google-Smtp-Source: AGHT+IE0WwiuMIrwwFj9qaBNO8bS08eHPy8xyS/b27ydVSLkLsZB0Im99FCLmBi5mGjBXe6UHnkgtw==
X-Received: by 2002:a17:902:6acb:b0:1c6:a0b:7b9a with SMTP id i11-20020a1709026acb00b001c60a0b7b9amr2905659plt.3.1698421399249;
        Fri, 27 Oct 2023 08:43:19 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001b9e9edbf43sm1729246plh.171.2023.10.27.08.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:43:18 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/2] of: property: Add fw_devlink support for msi-parent
Date:   Fri, 27 Oct 2023 21:12:54 +0530
Message-Id: <20231027154254.355853-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027154254.355853-1-apatel@ventanamicro.com>
References: <20231027154254.355853-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows fw_devlink to create device links between consumers of
a MSI and the supplier of the MSI.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index cf8dacf3e3b8..afdaefbd03f6 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1267,6 +1267,7 @@ DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
 DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
 DEFINE_SIMPLE_PROP(panel, "panel", NULL)
+DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1356,6 +1357,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_leds, },
 	{ .parse_prop = parse_backlight, },
 	{ .parse_prop = parse_panel, },
+	{ .parse_prop = parse_msi_parent, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_regulators, },
-- 
2.34.1

