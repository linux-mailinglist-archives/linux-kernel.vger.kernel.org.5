Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DD87D6F83
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbjJYO3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344943AbjJYO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:28:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F51A99
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:28:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6be0277c05bso4686986b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698244128; x=1698848928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KBK3NZC+n7aQ9gEOFAwoNpYjPv+cjuqYwdG+XSaoH8=;
        b=BavMbCpphcFIUwz1RVi2TDeIwmJeuAt3HhJZH3vBAq877YqpibcGcwpWFsGDJBQQGI
         gp3odMjce4EgaoPYz4DWfexUHOewu9FWRSHHFAMJeinPl/L55LCFRK8oY47fmeIBpPGN
         bCFdWVaSnE4pldMYk0H1DlZB7s1aBApXdAHC6vYcL5Ww5dP+FiNl2IdwJVsOmekDkpOO
         lXszh6cM//cRWcTI5olxcQCKqS6UWAd+LVNi23ys8DVrOL5Hfz+kBSL1DJPOUVY1JsFO
         g9ap90ecc3J9Z5lOe4US5CiNgdyki/Z1sQ6k8bSpvtVu2+EzND/SJXXcPR9bdZeq/8me
         D+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698244128; x=1698848928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KBK3NZC+n7aQ9gEOFAwoNpYjPv+cjuqYwdG+XSaoH8=;
        b=e+BJrFAVjxefQz6ZEIKHMPaCAOLxmZzhEscTJY+Ckvn6ZN1L36FUTczYHAUz+7ec7K
         7NaWA4ujLKktWGQ7ROC9Gwv2QkDfZlcPEq5tS45RdQkl2paSykS+IinE8YrxyHlZCMmx
         dQY6ee4QQgvXB9RsNfGV329FMXnrtqn+heNBNmFvwGrxYd27Zasd2Zx6jxbwF/JwlxeY
         GrbkqkO3VziQM6PMTbeNNluW1k0ae1F9gYmRbhl4nfJGAWk4kQzvmAH1L2hIZRRp0fj6
         lt34RqczftYjS1mvrmnpz6g9PMC2pT9rPaKZLAYCs6jPyx4mJu4eImsJ3N90FnJ0AtjA
         vmvQ==
X-Gm-Message-State: AOJu0YxIHhjLImLykWBEhZVKL2KrjEsjTZqBG0HWHJrEBR9hUJLB30zn
        9xz1TLRREW0DiIgecT7YAUUpSw==
X-Google-Smtp-Source: AGHT+IHf5xLTf1KfVLoRMBRais+yDi8I/s1NVEGKVd+AFMTt9BY+nGX8/ulLd9cgkH/b1pX/mifhiw==
X-Received: by 2002:a05:6a00:2308:b0:6be:367a:2a71 with SMTP id h8-20020a056a00230800b006be367a2a71mr15594745pfh.16.1698244127853;
        Wed, 25 Oct 2023 07:28:47 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id g2-20020aa796a2000000b0068ff6d21563sm9817411pfk.148.2023.10.25.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:28:47 -0700 (PDT)
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
Subject: [PATCH 2/3] of: property: Add fw_devlink support for msi-parent
Date:   Wed, 25 Oct 2023 19:58:19 +0530
Message-Id: <20231025142820.390238-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025142820.390238-1-apatel@ventanamicro.com>
References: <20231025142820.390238-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

