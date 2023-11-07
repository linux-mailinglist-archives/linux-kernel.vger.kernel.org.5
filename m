Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244927E3A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjKGK4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjKGK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:56:10 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB34E122
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:56:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32f831087c6so1250673f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699354561; x=1699959361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWXszjrW0mqtPT5ge0XuiGQJ6aaCxrPofMKEXjPvYnQ=;
        b=c4wX3fG5F8aKGGSfMvLi2Y10+n1g6YLC+lOXGQAKQwVD0nXggrkTKAPvnjXEHsPpLi
         Tv4HM0vAaLODqcka4Ei5ysUBLc1Yv9aFeOGTq9LxzeXy98reED89s/UFBrluLK6VpMHo
         Y7eJNQhTTPwtkWSQy482lR8DOlQkpvD6uSqKqnSH6t37wdnzgWpAMBTXewPWMX1k75TQ
         J3yG0alz4pmsuQ3f5xZK7wdfCUOfEttBddRUyrnKDuHqAarzm6ZHy9RHovNXQiOQ5bTK
         mvC6s5xAnAaRHmqcbIxLkhLl2Z1wRY4yx9TD2unBfEC0Lx+i+avJ7H6cqhWSZMM+kN8c
         dECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354561; x=1699959361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWXszjrW0mqtPT5ge0XuiGQJ6aaCxrPofMKEXjPvYnQ=;
        b=PHfczgiKzSW14Dhe8ZIeicdcVEhGh0vqdrKVr/Yrp2/9zZvuar+d6dA2SqYvWEtPMQ
         eFaAPae/y6in35FLYf05M5F2MPI+Ye4AonA3u2F2IeP/1yTZZL/q6eiwmTh+KFwHJolP
         oHU8QxjpR3pNmEiZMSLmcR8rTOTr2YJNm4irgdrYqACvxuLwhVFZMru99TCimXvqinBn
         y5pqudzOTZ38H+KXrOTh8U0l374gGuTX2We4f3LgpkBktf9aw+0R8xwSuT/d2rCH89Jv
         objaLVc2UlmuA66DDSIgY4d+tKwv0CicW99WeSLpXqPC/FhMCskb54JInIK5wuIec1Rn
         yV4g==
X-Gm-Message-State: AOJu0YymQ2ATm41fqpelZYMXrYyJ4CROEE43n0qJruIGgBFgwgURdDNA
        JK3fu7i+DIjiSkXswpG2a1AqyQ==
X-Google-Smtp-Source: AGHT+IGuavTtsmwxI8/q0+XaTOH3JqZmAYfCgV3LA6iUJWNnV+0tLfzziM9Sx1y+OIsrf624uUG+Gg==
X-Received: by 2002:a05:600c:418a:b0:3fe:d637:7b25 with SMTP id p10-20020a05600c418a00b003fed6377b25mr25010147wmh.0.1699354561462;
        Tue, 07 Nov 2023 02:56:01 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7db3:bdd9:4cab:2ee3])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b00405442edc69sm15396853wmr.14.2023.11.07.02.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:56:00 -0800 (PST)
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
Subject: [PATCH v3 01/20] riscv: hwprobe: factorize hwprobe ISA extension reporting
Date:   Tue,  7 Nov 2023 11:55:37 +0100
Message-ID: <20231107105556.517187-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107105556.517187-1-cleger@rivosinc.com>
References: <20231107105556.517187-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factorize ISA extension reporting by using a macro rather than
copy/pasting extension names. This will allow adding new extensions more
easily.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 arch/riscv/kernel/sys_riscv.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index b651ec698a91..49aa4e82797c 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -145,20 +145,24 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 	for_each_cpu(cpu, cpus) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 
-		if (riscv_isa_extension_available(isainfo->isa, ZBA))
-			pair->value |= RISCV_HWPROBE_EXT_ZBA;
-		else
-			missing |= RISCV_HWPROBE_EXT_ZBA;
-
-		if (riscv_isa_extension_available(isainfo->isa, ZBB))
-			pair->value |= RISCV_HWPROBE_EXT_ZBB;
-		else
-			missing |= RISCV_HWPROBE_EXT_ZBB;
-
-		if (riscv_isa_extension_available(isainfo->isa, ZBS))
-			pair->value |= RISCV_HWPROBE_EXT_ZBS;
-		else
-			missing |= RISCV_HWPROBE_EXT_ZBS;
+#define CHECK_ISA_EXT(__ext)							\
+		do {								\
+			if (riscv_isa_extension_available(isainfo->isa, __ext))	\
+				pair->value |= RISCV_HWPROBE_EXT_##__ext;	\
+			else							\
+				missing |= RISCV_HWPROBE_EXT_##__ext;		\
+		} while (false)
+
+		/*
+		 * Only use CHECK_ISA_EXT() for extensions which are usable by
+		 * userspace with respect to the kernel current configuration.
+		 * For instance, ISA extensions that use float operations
+		 * should not be exposed when CONFIG_FPU is not enabled.
+		 */
+		CHECK_ISA_EXT(ZBA);
+		CHECK_ISA_EXT(ZBB);
+		CHECK_ISA_EXT(ZBS);
+#undef CHECK_ISA_EXT
 	}
 
 	/* Now turn off reporting features if any CPU is missing it. */
-- 
2.42.0

