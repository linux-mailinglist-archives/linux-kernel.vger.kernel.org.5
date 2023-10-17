Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47D87CC461
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjJQNQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343862AbjJQNPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C5128
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40837396b1eso511565e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548544; x=1698153344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AFw9z9dpP/ckJjbN9Tmyf7889lk/XiWzjzseb60llw=;
        b=jHVmk0FHiIh5Oh37fKBkZvvMfEpdaVj6/WkMAW9BqKeFICa1KyRaXQgSTrJLDNgN4s
         yxMSMgkTskVFuI+OZZRDUiJR/QeB180RHnVi+k0NuaIeGnXza6i04PrXay+ZRo6c3wSO
         u/8/ZFcn3hWaVjSkvj5EjcOg7g5j/plBKLsz71rYhDEB2qIwoPi5PwZUmKJ4dowpYpCp
         UokGFXUl9F/iyYhSOQAzyIPcd70uMg8mq4GJ/ctR93/7NvCLaJ/+T437PntroQ71u167
         8i0pBIUjTswX6qGUcsRym0zCvL4zUxqDBa/g8uHen87cULnV5U9kUH2wFtt72Q3GVW+d
         X5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548544; x=1698153344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AFw9z9dpP/ckJjbN9Tmyf7889lk/XiWzjzseb60llw=;
        b=wJ2QJHs+hJ0jWV9KequAMuBrV+EVynIB1xdYwleZgHRM1MmLZbpIglJSUSN20/R5Oz
         2KoAXwcDRiPiVAccu+rgAVY9y4ZojnYdM0lxPS1b7EiqTUclHrf8pSzhtCHjcx6jkewP
         odwoim0zzs2Fml8shY16FoLD0/t5ZSV2wJqj6XZiK4qWM6G10TQU2T7iXom5Iyoyfps4
         tFl4/a1XIiItDzYD9ES4XIqwqL7JyMLc47Wgig7kI/LDiZWfRPFg+N/seC/WRn4InWNQ
         799iI+GF1ucuAfzRdPVi/LzC0OdnZO2/UsIinHrTSXSmeP5NzmU0XVAefY8VVNYBx1MR
         UhVA==
X-Gm-Message-State: AOJu0Yw5OdEnmtQY5QyeuPsZnSe8U6+c63vCQaOzJ+D0TxhIthf0u7fN
        nPjGCSH5/IjYljEQkaBhOM4WwA==
X-Google-Smtp-Source: AGHT+IGD6k8FykqQQcX67hgxOWRNET24ch03mfUZpvzescEdSJ0tjByWo4qNt8mvukTxxj/gJ+XeOw==
X-Received: by 2002:a05:600c:150c:b0:405:38d1:621 with SMTP id b12-20020a05600c150c00b0040538d10621mr1641979wmg.3.1697548543538;
        Tue, 17 Oct 2023 06:15:43 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:42 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: [PATCH v2 17/19] riscv: add ISA extension parsing for Zfa
Date:   Tue, 17 Oct 2023 15:14:54 +0200
Message-ID: <20231017131456.2053396-18-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131456.2053396-1-cleger@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parsing for Zfa ISA extension [1] which were ratified in commit
056b6ff467c7 ("Zfa is ratified") of riscv-isa-manual[2].

Link: https://drive.google.com/file/d/1VT6QIggpb59-8QRV266dEE4T8FZTxGq4/view [1]
Link: https://github.com/riscv/riscv-isa-manual/commits/056b6ff467c7 [2]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index d9fb782f198d..8f324c646a73 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -84,6 +84,7 @@
 #define RISCV_ISA_EXT_ZIHINTNTL		66
 #define RISCV_ISA_EXT_ZVFH		67
 #define RISCV_ISA_EXT_ZVFHMIN		68
+#define RISCV_ISA_EXT_ZFA		69
 
 #define RISCV_ISA_EXT_MAX		128
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c70885f5014b..296cc0025734 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -245,6 +245,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
+	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
-- 
2.42.0

