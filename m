Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6968079D7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjILRun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbjILRul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:50:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A33710C9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:50:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c39bc0439bso739355ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694541037; x=1695145837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yJEEb56ymg39YALnwyrySa9js/OLlIbNxAluFRWmmE=;
        b=dMxc9F4pitexwe3ahC6PFnOzexdamCvBXYNk+ppx7sYcke5Bt6keJv4UTam+QjCwnP
         ltnM1XWjDX/YEoI+VVoXFnyQI1WLBvUuklFDxGlXDJtndShy09jKuL7ZxD8V7J2qsjp+
         Twyjt9bYTbHLYGLMxIa23oItPYbAzyyJ3SyLWEJyQxWkFdOzD672o/EGG4Hy3jXA98pm
         B+ni5KmPmUzM0LYiwDvZ3wGuvBdkpm0evN5TI2wrJ7Uh3dxqXgVvd6VOKNqkceIrhn2L
         BhvEmmOunQ8HqU204KOJ7/Nw0w6pkFEi9id1kIL/ZRqiAPnd7Iei7oELcM0Fvw2v5tCG
         XDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541037; x=1695145837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yJEEb56ymg39YALnwyrySa9js/OLlIbNxAluFRWmmE=;
        b=TG30BcDid0fT3J6uoKByY/jdnlQQ/wFvFDAr+03R1Yt1G+nDf533a/v1HhFQRW/Md8
         DIQMxoHfA0M1xOUVhcoDNvkalohvZfodAkxyOoZwU/YdX3sis6E0DmqTbU7ild/PgIL6
         yL8YrzQo406PtfU9+gn691kS6RijdOFJ41NAHPZxGY/MoEL1hWOQqm4dY4dYI1Pe1Lds
         BDxROHYT+zsVAz/ihkasuJmuUA98FjoFlVV5HfeRZ74hh9lv9ZF/dX8Qte4U48Si3lPl
         /EgtgHCju4hZ0LK6U64N6mzioRPx+ZaqqYA88VF1x5fdwAFZPchHaGid2hped/Bro85m
         ra0Q==
X-Gm-Message-State: AOJu0YzD6wvH5gLG4x7jw7BsswvIIjszEW4h/ghrGEU2vr++a+vNqexs
        ooreAgmmT0zPwal+T1tlY9LVzA==
X-Google-Smtp-Source: AGHT+IHKvRNi6YOGIT3wdmpnSjIEAM3T0v9PHxMuDSYllDIMa60ow+WAwlzZGKgKrVexZ9AYeemUIA==
X-Received: by 2002:a17:902:ce90:b0:1bf:7aeb:c488 with SMTP id f16-20020a170902ce9000b001bf7aebc488mr386820plg.29.1694541036636;
        Tue, 12 Sep 2023 10:50:36 -0700 (PDT)
Received: from localhost.localdomain ([171.76.81.83])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902a40c00b001b891259eddsm8691440plq.197.2023.09.12.10.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:50:36 -0700 (PDT)
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
Subject: [PATCH v8 03/16] of: property: Add fw_devlink support for msi-parent
Date:   Tue, 12 Sep 2023 23:19:15 +0530
Message-Id: <20230912174928.528414-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912174928.528414-1-apatel@ventanamicro.com>
References: <20230912174928.528414-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index cf8dacf3e3b8..758ea822e46d 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1267,6 +1267,7 @@ DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
 DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
 DEFINE_SIMPLE_PROP(panel, "panel", NULL)
+DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1361,6 +1362,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
+	{ .parse_prop = parse_msi_parent, },
 	{}
 };
 
-- 
2.34.1

