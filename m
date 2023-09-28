Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055A07B1260
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjI1GMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjI1GMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:12:36 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68225B7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:12:33 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fe6da0095so148669339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695881553; x=1696486353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYhetJOGeGWONv0pBZCT4Mywf3EBvVtv+lOqGOUogJM=;
        b=PlodMKv/rFj2ODyvAQQek2bouvKZBfmlU4e0xvzriXcXWdrlzzx6KDgPOXrPDvPIBj
         2LuEVcSoTorVVbihpg/dQKAAeXkqcHyj9FYJwkl/snUHE1r05AfOg5UKgtzoeshBHg4L
         9weypclvICOrsBP19YH9TAuBMBgGciAYWQfWmCWUD2ED+KrlIRT2uhqpkWR+AgTm6q1d
         akrTB3WlgIL5Cu2qWvKXU1tUdwGfk3f5U4c6hP3n3D1NxTn/4tRVPkjur7Snx5/NQTJS
         +oLKwcSuK7vQE0POBFTHMr9tcJpS8RXVzB2Zzrc97+ous+6Qo+qJA0AtQ9v4/iEQ+7g/
         3wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695881553; x=1696486353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYhetJOGeGWONv0pBZCT4Mywf3EBvVtv+lOqGOUogJM=;
        b=neQvxFOSUY75SfEAfLxPjGIy/HF3IiEtTLcDV58pK6HKxGnTY7t2qR1wWr/mUjlycz
         gkgnibgqZo4tqQrF0tTRpjer5//qzuhhr42H3T2gBMsgfYrg5Haq07mIv8UED/WyhMks
         WVbp/gdIWdGUuSeazqewqLBqZG52gYqdxrrwXpPuZa0OJIVJ2Z/+y4w6mq0mmNopyDKJ
         0pvyn2TwVgFOyOZxLtr4vRHMo60MbTn4Mu2nOB0XdQCrUX2DXe/uUbPIRk05CFc8Yn/N
         PUpUiTLjgnT5GeZzxYvg7WIFaC1YAe06kNXc6EpSgFSe7Ua8Kvxs0D9moR8f+CcEdOS6
         ljLw==
X-Gm-Message-State: AOJu0YzAKYrdJHpBwsqrl5Pdqb/WfRva3EwYtypvdHdfDA9V5lJfeO+9
        cyzyWsR8j6JW2E9ZtD+5W63h8A==
X-Google-Smtp-Source: AGHT+IHAVpjATHjbTVjN16DaPrQVI+srvJfDxutjkjnncDxheqgApaY+Jepb7zaoJHV9lXFsV/v2qQ==
X-Received: by 2002:a92:c7d1:0:b0:34f:b296:168d with SMTP id g17-20020a92c7d1000000b0034fb296168dmr311802ilk.26.1695881552635;
        Wed, 27 Sep 2023 23:12:32 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id x6-20020a92d306000000b003506f457d70sm4774467ila.63.2023.09.27.23.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:12:32 -0700 (PDT)
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
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v9 01/15] RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs
Date:   Thu, 28 Sep 2023 11:41:53 +0530
Message-Id: <20230928061207.1841513-2-apatel@ventanamicro.com>
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

The riscv_of_processor_hartid() used by riscv_of_parent_hartid() fails
for HARTs disabled in the DT. This results in the following warning
thrown by the RISC-V INTC driver for the E-core on SiFive boards:

[    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interrupt-controller

The riscv_of_parent_hartid() is only expected to read the hartid from
the DT so we should directly call of_get_cpu_hwid() instead of calling
riscv_of_processor_hartid().

Fixes: ad635e723e17 ("riscv: cpu: Add 64bit hartid support on RV64")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index c17dacb1141c..157ace8b262c 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -125,13 +125,14 @@ int __init riscv_early_of_processor_hartid(struct device_node *node, unsigned lo
  */
 int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 {
-	int rc;
-
 	for (; node; node = node->parent) {
 		if (of_device_is_compatible(node, "riscv")) {
-			rc = riscv_of_processor_hartid(node, hartid);
-			if (!rc)
-				return 0;
+			*hartid = (unsigned long)of_get_cpu_hwid(node, 0);
+			if (*hartid == ~0UL) {
+				pr_warn("Found CPU without hart ID\n");
+				return -ENODEV;
+			}
+			return 0;
 		}
 	}
 
-- 
2.34.1

