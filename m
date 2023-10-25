Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A340B7D6EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344929AbjJYO2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344931AbjJYO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:28:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C819D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:28:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso4772858b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698244121; x=1698848921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYhetJOGeGWONv0pBZCT4Mywf3EBvVtv+lOqGOUogJM=;
        b=mCzYS6nDySUvdJr17CiMC67ONyFIfKc1V5K91Ov1W62LK4H8TQYXMePBuad7GtJg8b
         Zz4XbiMb/+jWfcwqiBFhPNuzIH5F2ycKnO5Tv/xhu1nSCPyZj/nPuOPOvnX4AuNyHAZ0
         eJiGEY7Q43B+GIPYD+a4Dqt+4i6bHsGxxVuEFOydjy83bPdJYB30sXDpatFNNduYBO2k
         5T+b3v4/kJEHvPLFDB6BbB7SkZNDpxvomge/NhqDA8vjrEdMvZNspz3DWef8XHqRyo7v
         mA+5B7tJ9fsPUrdVeJj02nAvYPRJfna8ZMv6jChb355PLdMf77ET6Ebg7dqV67dMbcPk
         jxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698244121; x=1698848921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYhetJOGeGWONv0pBZCT4Mywf3EBvVtv+lOqGOUogJM=;
        b=T2ockJrsBGlYacOQzoUAZw+Iu3IYsRiVdjImO8tR5obNkQgDd+jBizXQIgGyhk33jy
         m+pA+ZBcVUEbGTuPwfZ+Ol9JJ2N0U89z1I8lffOlUdM5jSDjDp4+Mccgk6y8FvIukQe/
         bmZuTogfhUoCX4rj6qrwl9239J15omn5eqhlMQDo7S4dHw+s1sGGPjImh9CoskMqt0BY
         S2yJ+MM/VsaQwpvDRZ7iIZpAM7AsAJg/L3FGCbjLRuKHpMAuaFDPunpEddoowXA4IbjL
         QwAQa7UkLfq9z3LwzINRzKUVeOEHyIniyq7Mriu7YiMm8SJtqk/5m8OTAPJtq5rnr62g
         fDGw==
X-Gm-Message-State: AOJu0Yzf7P9u47D9hLFDP9pK4MMZb+5ufQ3cpqH+mK6gN9v3wWrl+68i
        WNvwjRNVpSfJ658GETINQZJxag==
X-Google-Smtp-Source: AGHT+IFQNbBr+sMT3u5z/l+o0iF+ppZGPFxjQxnFACN4M50PeyfMhxm13pEjMBXrYf9gZntSp2P55w==
X-Received: by 2002:a05:6a00:985:b0:68e:417c:ed5c with SMTP id u5-20020a056a00098500b0068e417ced5cmr14915842pfg.32.1698244121321;
        Wed, 25 Oct 2023 07:28:41 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id g2-20020aa796a2000000b0068ff6d21563sm9817411pfk.148.2023.10.25.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:28:40 -0700 (PDT)
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
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH 1/3] RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs
Date:   Wed, 25 Oct 2023 19:58:18 +0530
Message-Id: <20231025142820.390238-2-apatel@ventanamicro.com>
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

