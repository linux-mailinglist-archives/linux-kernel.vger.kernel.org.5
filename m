Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD09F7B6015
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbjJCEow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 00:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239090AbjJCEot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:44:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38751D7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 21:44:44 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-577fff1cae6so324021a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 21:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696308283; x=1696913083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KBK3NZC+n7aQ9gEOFAwoNpYjPv+cjuqYwdG+XSaoH8=;
        b=A+C8NvPobBJU4BzQY8nusqME44W3wFPQ0giTDNyX8c1ss4Agalg9UoIUWbSvetO+RI
         fWgmgNwbC/Ig9WZ8J8H7p0IPnw0uQ/Eea3ByPzWrQD+ug6UFf4SuYpgiYCoigFJu3V6m
         WAYkNacl9ewRKOc4lE4ZLRuGwVoIOQpaT4qvljvTGJP9TfzSIuELoDgtC1NOVE1XLMm/
         0TsRFwuuZI6pqnKeTraVzTykKlmhI+YTGVXwgpODOjS6MvwwHeZ4VstdBBz5LQ+ajFR0
         KaFx2NzXqHZvnrsc0pH3DwczXvcvFoPHFz33E1WUoRyygYItiKO+UvQJdY6lO2Mwl//l
         ZNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696308283; x=1696913083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KBK3NZC+n7aQ9gEOFAwoNpYjPv+cjuqYwdG+XSaoH8=;
        b=OAQ5n9ST8JiYssB+r140fmb8vAFhyJnXHbgphMmVEItxm7SVzzirRpE8ickh/fIGfm
         ytuRLWAfgZ/es47KYvk5VC64Hibo3ZAFcZFaegpp5kCF/wqHbnHEoFHjrNA1FLc2yj0v
         h0vSiBINHyt7+Q8EeVTWuv84jCCm6Lg0e48QX7ZYT8tO6tv9uGvMdeGPQ2+HkA57uRsC
         uxIZEtxr6z7tVETUUteiV6WMHjj0mtwt03gfsHOMg4T5We7+t3aaRLLaYqz4jf8vuy8W
         x1krLOSktsvFuFLT2klo/CTSPohfGlJ4HBTNa1RaEoNsq5vGIZhbIwz7C3Es2bD/p2ie
         nqQA==
X-Gm-Message-State: AOJu0YzzWqI3jI+buvjbXUYB1RUM/fcEIvjNlABd0FWP7XNuDcdLeKAQ
        1Jfd1/chyfK/8hSwJRXBK5zovQ==
X-Google-Smtp-Source: AGHT+IFGg/K6YXM3J+EKrEFvni3eUnfBZxPN5GQXl30b0bUztVZt5cBa2cf9Hxdefsa/91znIXj0mQ==
X-Received: by 2002:a05:6a21:3395:b0:14e:2208:d62f with SMTP id yy21-20020a056a21339500b0014e2208d62fmr2942718pzb.22.1696308283477;
        Mon, 02 Oct 2023 21:44:43 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.132])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0068e49cb1692sm346421pfo.1.2023.10.02.21.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 21:44:43 -0700 (PDT)
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
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 02/15] of: property: Add fw_devlink support for msi-parent
Date:   Tue,  3 Oct 2023 10:13:50 +0530
Message-Id: <20231003044403.1974628-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003044403.1974628-1-apatel@ventanamicro.com>
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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

