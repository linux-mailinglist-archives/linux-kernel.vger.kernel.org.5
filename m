Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760547D3D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjJWR2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjJWR2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:28:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF68A10A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso2876097b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698082095; x=1698686895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYhetJOGeGWONv0pBZCT4Mywf3EBvVtv+lOqGOUogJM=;
        b=Y3P9zZQge6Shvk4IfBExdqFHq3Zv9iYUhBdmxzNAc3jURzuxoD30dw/JXK8uywOYjq
         8gmO4fUXPcDONlMvUj55EGYpAgR6q0vFP9YKQzxmam6ULYMuygYyqUp60CsSNqENYsKl
         765MU/TZHgRHQRxIofTpr8vcPuRAvPQq20l6iDOPlKrkftrk/mxsgB3iMoVVFCsKmgku
         G2aJMZRSMBlVZghMdch1UKnE9syiwn5AKt44Nh/sYqqgIYk05PsTHX+/JoJUM3pEDQCw
         EJeHtvL3FrBK3nGHQ03JBqEBcLOxAXsuXfCZQpm0S3htF9yFCRjejtuQcWjCCVboR5C4
         va0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082095; x=1698686895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYhetJOGeGWONv0pBZCT4Mywf3EBvVtv+lOqGOUogJM=;
        b=FdsZrvaupwfvgqk0eyFne1QWbDeKTW2IX023E0KO3cA3bqTPlCbrDPe6V1ANBQqgeA
         mfg0tN5caZmKRxKB8tWgzik6z6FufxYGs4KXtfj0Wkz5YMs4nuDtGSZLKZ04u4LV2m99
         4wND7FMqhpGWP+3Wr8hBe8K5fqPy+qLWFSKUt5R/KFsqQ5mPhnIYRcMzsvflDNsRFWln
         dYMcaFk8SAw+Mu7dSQg7Tz/nsZ+TiAdlCs1h5ySC8CfapixagzBEZbmNZl9pnFeUcNl+
         gmLzIA6So+bWQEonrw4LBPPAUOwXwta8CbUx2lXNtvFoiNPTCczG/DckdmU5G1DUn7ot
         pBlw==
X-Gm-Message-State: AOJu0YwliqUMq51RpngrZJfaExVQpz0MRDHWhMdoPdwrLwqdWo38e0Wa
        62p6WiQICtD48LXiNAXLHqij6Q==
X-Google-Smtp-Source: AGHT+IGu+lXy4fpqCbUHElQhH8GUD5tz2EcwDu9oUNJjJ7mXrjL2i+iM+REgc4LlydXeHpBqkSNcvQ==
X-Received: by 2002:a05:6a00:248a:b0:68f:ece2:ac2a with SMTP id c10-20020a056a00248a00b0068fece2ac2amr7867812pfv.27.1698082094881;
        Mon, 23 Oct 2023 10:28:14 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.9])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm6473194pfr.92.2023.10.23.10.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:28:14 -0700 (PDT)
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
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v11 01/14] RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs
Date:   Mon, 23 Oct 2023 22:57:47 +0530
Message-Id: <20231023172800.315343-2-apatel@ventanamicro.com>
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

