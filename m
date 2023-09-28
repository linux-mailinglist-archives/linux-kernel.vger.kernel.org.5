Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85CC7B1262
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjI1GMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjI1GMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:12:43 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC47A3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:12:40 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79f9acc857cso392313039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695881560; x=1696486360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVI3E1Wd+EtlgSmILdTG/g7O9SZ2R+Drh6P8ny9RejA=;
        b=GHaRpvckD+TRFbmfY/KuDyJXXCDwLYQT++2vWddGrAih4Y4o5N+OFRb+zwkv947O8V
         5m+XPvd1rC/zA+6SwD1+oFBVQVzwsN9QWBTGlOiRsMYJu/JBWc+lUOm5/4v71RBlAtKq
         vxb4YH8Wl3qB+HSINg5X5ClX3JxzZXu4BlBIrY9KfGPioSkyl3OkyCGVj0T/6+vzdfxk
         aAmtgZSvRgRsr2wD0WUrg7XxsMQFzf/oxxv/OblxkHjnJA6BoSRLBZTmMgLOn/be29Fy
         X8v2ojR9CFd5IMfW5dU8saEbmYeZynhUQT4JWph3OKtpxyHyK+rAeKelpdEu9DDvdXzf
         bgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695881560; x=1696486360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVI3E1Wd+EtlgSmILdTG/g7O9SZ2R+Drh6P8ny9RejA=;
        b=PvWXXhmo709X4xvsF3kCgMy+Nz1xuy8EdHRnS6PAG4KreIgBQdJd2ZKK4KOLk6cYNs
         RaBAQ7CCk49K13afZUAjV/XhTjVuoOT9HUTZ4SmeBxEhcdNMzPHbAT43R6w98GJIQhM5
         odMF4kU1JmieR+aND+pDHuZka0uG7eGuFwjuT5o3z0HAD9GOZnWGVPQyOvbGOIlM+DHp
         +T4/2TEBd4uiG260efACug/Js2domLGrUS6uiZNTiFboC7df8McgmnCuvwISCKGZzBpG
         4TyNUETW+okvWBxYadSx81fC7AORfEO7LFrN5x/t7mRx/sac0ZJJ3vKlAdaV9y/AcP8+
         8XcQ==
X-Gm-Message-State: AOJu0Yw9vE+qQoMojG3sd5KHd4qUd8ZzBRBj+ZV4NsQ2KmCN6eVbSqQQ
        t3+Nq1J7yoJ3gFxZDIeU9Inr/A==
X-Google-Smtp-Source: AGHT+IHxgTAD2C+h+2iRuALF/AignSrzhlWjU3CVwyaBIt0/qhlbz/Hw89uJisFxnDDxg1j5YAH3aQ==
X-Received: by 2002:a05:6e02:1c8e:b0:34d:ea35:842b with SMTP id w14-20020a056e021c8e00b0034dea35842bmr279993ill.27.1695881559675;
        Wed, 27 Sep 2023 23:12:39 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id x6-20020a92d306000000b003506f457d70sm4774467ila.63.2023.09.27.23.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:12:39 -0700 (PDT)
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
Subject: [PATCH v9 02/15] of: property: Add fw_devlink support for msi-parent
Date:   Thu, 28 Sep 2023 11:41:54 +0530
Message-Id: <20230928061207.1841513-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928061207.1841513-1-apatel@ventanamicro.com>
References: <20230928061207.1841513-1-apatel@ventanamicro.com>
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

