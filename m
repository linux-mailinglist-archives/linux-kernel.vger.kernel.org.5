Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41597F3A72
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjKUXro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjKUXrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:47:43 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D52D1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:47:39 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so2033650a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700610459; x=1701215259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMOStd9fJlE8YG4cHDAqOao79PB5giUTAvN4hSNTpow=;
        b=Uomp7nrdZ3nvrlUgQ0qBvW5GpSBTi60bLjaQ3lGURObcyyT+NNfxzHhdGVYMnJkMfN
         ULTzxEXxtvQTe2UNHpHyxDJ8oqlPGdrgjs32V8nbdIU302oDcmFYOJQIiIgSNZvzJfMe
         jI6ZdOBQEr/JcP4DzUFvjLoSZrno0IzasNpbK4s1yctRveHJcrnfCDYQKOXwqLb0XAxc
         9C7DtATowjbVWCJvwMDKdaNbc2Z4cvFvA27/6XzLQI7wRanY0RPnny4YsNWznxG0bSFr
         FJUkiMvKAKLEFyLiid4/2tOFivD6Gs3s1hu2GfQDy6AI19P9xT/slwXTfNM+jZkTOvCW
         +wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610459; x=1701215259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMOStd9fJlE8YG4cHDAqOao79PB5giUTAvN4hSNTpow=;
        b=jPAiIFv7reLh3K+YM0oIWKY/EQJodeNYThfFthEmHU8hub4ytBAlLY/BPTgAyBphaq
         SD/M9dwWwNnDZ1isgp1CmoquECq80NKkljmh9ItH/qRzpsisXPTWcG2KqqVHwOC6vEjM
         kP6Qp9G364Fa7AA6o+p97sWhmK9k5z9/+E4/gSU8sM0RtkN8xTG6npy28noCjKiMTBZL
         B09C77ZDaNlZuPrVTiCXmMmpYuF0JBLOZtv0pw5Rd2e5iKnmMsXkWMnrUXX4VbPYE4HP
         ZMgu+hc3FaoYGI3QtggrNvtHJAlumbMYfA5wdenzc6DqBRnb3A8C3SHmGYDmJx14vor8
         U7nQ==
X-Gm-Message-State: AOJu0YzaKj3FfCW+d7xcbcMab728vj3iMwUL7kY5abk1/5h4/R6gUKwO
        1FWRrzcvI+bZHOsbCnuenVU4uJ4axxenw2osgpA=
X-Google-Smtp-Source: AGHT+IFbfZAuqOej5wkX0K6/vS8Oyqjn7BLG0X6YPrfr8dn7T6pNtB3Wv/zbSWQDnxrj0rMNrcKVig==
X-Received: by 2002:a17:90b:4b0b:b0:281:1c2e:9e6a with SMTP id lx11-20020a17090b4b0b00b002811c2e9e6amr742314pjb.39.1700610459263;
        Tue, 21 Nov 2023 15:47:39 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090ace0800b002802d9d4e96sm82234pju.54.2023.11.21.15.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 15:47:38 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 1/3] riscv: Deduplicate code in setup_smp()
Date:   Tue, 21 Nov 2023 15:47:24 -0800
Message-ID: <20231121234736.3489608-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121234736.3489608-1-samuel.holland@sifive.com>
References: <20231121234736.3489608-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the ACPI and DT implementations contain some of the same code.
Move it to the calling function so it is not duplicated.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/smpboot.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index d162bf339beb..1c68e61fb852 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -125,18 +125,7 @@ static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const un
 
 static void __init acpi_parse_and_init_cpus(void)
 {
-	int cpuid;
-
-	cpu_set_ops(0);
-
 	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_rintc, 0);
-
-	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
-		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
-			cpu_set_ops(cpuid);
-			set_cpu_possible(cpuid, true);
-		}
-	}
 }
 #else
 #define acpi_parse_and_init_cpus(...)	do { } while (0)
@@ -150,8 +139,6 @@ static void __init of_parse_and_init_cpus(void)
 	int cpuid = 1;
 	int rc;
 
-	cpu_set_ops(0);
-
 	for_each_of_cpu_node(dn) {
 		rc = riscv_early_of_processor_hartid(dn, &hart);
 		if (rc < 0)
@@ -179,21 +166,25 @@ static void __init of_parse_and_init_cpus(void)
 	if (cpuid > nr_cpu_ids)
 		pr_warn("Total number of cpus [%d] is greater than nr_cpus option value [%d]\n",
 			cpuid, nr_cpu_ids);
-
-	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
-		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
-			cpu_set_ops(cpuid);
-			set_cpu_possible(cpuid, true);
-		}
-	}
 }
 
 void __init setup_smp(void)
 {
+	int cpuid;
+
+	cpu_set_ops(0);
+
 	if (acpi_disabled)
 		of_parse_and_init_cpus();
 	else
 		acpi_parse_and_init_cpus();
+
+	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
+		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
+			cpu_set_ops(cpuid);
+			set_cpu_possible(cpuid, true);
+		}
+	}
 }
 
 static int start_secondary_cpu(int cpu, struct task_struct *tidle)
-- 
2.42.0

