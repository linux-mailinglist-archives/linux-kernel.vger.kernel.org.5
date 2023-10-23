Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0377D3D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjJWR2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjJWR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:28:25 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8FC10E5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso2977123b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698082100; x=1698686900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KBK3NZC+n7aQ9gEOFAwoNpYjPv+cjuqYwdG+XSaoH8=;
        b=BEMqgJW1giecH+Qg+10tx56SP5QCEtK0Nj3o9nQbSnTLH3aDdpA84jT10NNlE4YAy9
         UdLspmpuLRQ+A8LWjghcAVNwmJhPpr07q7TI9aMrbqThlqnaoTEFeAuThgRyqfHdgMQN
         ttyhRajUhTPlitVuNIr81zsdVkNour8DxeTTdrWK08atoSFJtgMgUGUUQhqpwZmtmETD
         Xa3BZ+/2SiXpozlN+WBRYpzD0isKHVQ+6j8Y5sbEBWH51ZbHFp2DGw5/Iv0ReMxJjAfo
         eyW+e/aGa8ncH+3GoCPyMiMqpBJNxLrYFR8pYrexOO9bMvbYjq47PNAbCpXHLi4c6oqf
         gq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082100; x=1698686900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KBK3NZC+n7aQ9gEOFAwoNpYjPv+cjuqYwdG+XSaoH8=;
        b=eGdZ9auIq6FJ2ngjPCajGMDfsLrCyZ1vMMRJd2K5VOE13tefHmNF6Supk6j1ZhYhFd
         7NaoMp0xf2AYkl54SMI1z9ECJ9pRG6aCZD0VGkVFjMuuMnLWhcixMLbOcu3yWUL3Rhlt
         Lkagl6OJoLJhxnDUOF5aslhI/y9uYtsqpCr1+Vfg4XGVfCW/alLQOKfykt7DYZBb/EvM
         r1Pmnq0UaTOy8xS/6Q0qwELpMXj+4jJckYR0X2Fs8AhWbHpvomwHS4Fr86RVkNvoeVUQ
         Ly/QduBzaD/dsTtwLbS/EZhqW1di1LyppjpW73eDJtQPtGFGea+tiswgdHaxdRYiyu8Y
         pF5w==
X-Gm-Message-State: AOJu0YxEXGaPbRjcceb2ypPnvEAzO+GLn99a6uhDuHUC9g2ScLzGl7E1
        S5Su2IYsz6XGCpXjaNg7j7AZcg==
X-Google-Smtp-Source: AGHT+IEhamlczERwlzDzetrJnAlZ5sdu84K72HLg62pHuk1whfdxvOWdFru0gvqURGDGnkMiM0yB5g==
X-Received: by 2002:a05:6a20:4323:b0:15d:1646:285a with SMTP id h35-20020a056a20432300b0015d1646285amr279865pzk.21.1698082100040;
        Mon, 23 Oct 2023 10:28:20 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.9])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm6473194pfr.92.2023.10.23.10.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:28:19 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v11 02/14] of: property: Add fw_devlink support for msi-parent
Date:   Mon, 23 Oct 2023 22:57:48 +0530
Message-Id: <20231023172800.315343-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023172800.315343-1-apatel@ventanamicro.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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

