Return-Path: <linux-kernel+bounces-147423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B01D8A73CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186851F2193E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03CC146D7F;
	Tue, 16 Apr 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gDiR/Hb7"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0B145FFA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293118; cv=none; b=FQUEUWIZeczpkptS4bUDqq275Om4AjiQjK06IDD+TQbCrEDGCqfx/0e6eGz0mG0X2ZmUwwbTtfLNIP/EAc5m8Gv9ql/7/iQ/VFE5U9aL1Jjq9VF7aYrfrT/K4xvYmo0S1NDG9QVwa5+opqMIw5bR9APEnz2mspuZl+6+VPgCzfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293118; c=relaxed/simple;
	bh=4h0IzOtLBFbHmqIztYQtJnRQ5i+JxAIa21rlgcy6DFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=invkQfMW8+ciSdxuq8XHXLlu/kMcV4V2HuizVu8Ssc5LRNfkBvHo6KX8MfPY9PVSGuBqsKUP2BRO0gMLmGwJ+GaqsXN8jWo3xzeTzGeyHZcgf/BypykC1BddMF7Q/CAp5xwim0PhhnDQ533659Kc0TQnmoaVh5IbZWazEMA5duQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gDiR/Hb7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a2d248a2e1so48786a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293116; x=1713897916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8dppvgVnh54sEjPJluz+VPGn0XVIgbI5aDFYcuHKMk=;
        b=gDiR/Hb7dfZWte/qAVI7hwrqpsxUDO9Y6vLg5/aP2wlJOeuMhrIGJNIAG/C3KvorM2
         ATqjJ5wyUXjjmLXdYpCQ8cOM6SqAu6hwBKL0RLLD4vitoI2Re6fwY32WO2ebzQEweVX1
         2wVWzJLs+Q8bMYGNFOtNTNFYvx+VVFC1nZMw+2z5eUv1oeBoWhakxYlHNkpIItYX0x30
         imIyUqmkuNE5hAUS9rI/ES1mfjnnttRstTd9QVRzN+kx42Rlz7h+FCfI8lDqllxGfHtl
         +UGiqTnouub2dQQsjAm4FpMGRzMU39wmt8p7FHJOa1AxnsIID8D4guTtMhYNanx7TfnN
         +4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293116; x=1713897916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8dppvgVnh54sEjPJluz+VPGn0XVIgbI5aDFYcuHKMk=;
        b=N3WSSP68xeCcbxCJG+bYZmnzspaJS8D79Cz3t/ELSS+ZZ2mfsF8QgeusUwD5+b5owd
         SkvYK+wZMF/YuuSwde/MxHnhnMTpxTWiX4nNqjsLG/gHKAtutqBm1vGp+JzL1oZZMY9l
         4EbWNRtWsusuay5Kz8hpnFsuFG3OxEMEDgxUieG3hOry0PsNXiwYHnU5c+73Pc+zjCh1
         Xw83Oq2eJ+xZLpNe5KiQ3pRa2ZTbQJco9elMQB0vT4gVPkrJ8flOZao5MNKlEEW5JOoG
         nn0xwpVB+tvB+6gMG2ugV1YU1jFNIYB0DOyxG2asEa7UDlcFScP1HA434rersFrpHsrF
         rFaQ==
X-Gm-Message-State: AOJu0YxAlvooni8fbv2ZbiSZjemrJuY/hU0fFtR4pv/UTNFH7D3+TCqU
	BCVaX0KxRISGyOc6hLMl4wKdV+DDt7pWV34oK/W7H1K83h8IeM0cZBFhSl3Uj16uCBXaWr9HMcF
	0
X-Google-Smtp-Source: AGHT+IHzc2MYBxQtrmJtlm+A3Ba+b1xBo3biutdeONIY5AZoPZgv68J1XHzbTpk7PKvAcyeeK8RTRQ==
X-Received: by 2002:a17:90b:1a88:b0:2a2:faf4:71da with SMTP id ng8-20020a17090b1a8800b002a2faf471damr4887452pjb.10.1713293115724;
        Tue, 16 Apr 2024 11:45:15 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:45:15 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v7 24/24] KVM: riscv: selftests: Add commandline option for SBI PMU test
Date: Tue, 16 Apr 2024 11:44:21 -0700
Message-Id: <20240416184421.3693802-25-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SBI PMU test comprises of multiple tests and user may want to run
only a subset depending on the platform. The most common case would
be to run all to validate all the tests. However, some platform may
not support all events or all ISA extensions.

The commandline option allows user to disable any set of tests if
they want to.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../selftests/kvm/riscv/sbi_pmu_test.c        | 73 ++++++++++++++++---
 1 file changed, 64 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 0fd9b76ae838..69bb94e6b227 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -33,6 +33,13 @@ static unsigned long counter_mask_available;
 
 static bool illegal_handler_invoked;
 
+#define SBI_PMU_TEST_BASIC	BIT(0)
+#define SBI_PMU_TEST_EVENTS	BIT(1)
+#define SBI_PMU_TEST_SNAPSHOT	BIT(2)
+#define SBI_PMU_TEST_OVERFLOW	BIT(3)
+
+static int disabled_tests;
+
 unsigned long pmu_csr_read_num(int csr_num)
 {
 #define switchcase_csr_read(__csr_num, __val)		{\
@@ -608,19 +615,67 @@ static void test_vm_events_overflow(void *guest_code)
 	test_vm_destroy(vm);
 }
 
-int main(void)
+static void test_print_help(char *name)
+{
+	pr_info("Usage: %s [-h] [-d <test name>]\n", name);
+	pr_info("\t-d: Test to disable. Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
+	pr_info("\t-h: print this help screen\n");
+}
+
+static bool parse_args(int argc, char *argv[])
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, "hd:")) != -1) {
+		switch (opt) {
+		case 'd':
+			if (!strncmp("basic", optarg, 5))
+				disabled_tests |= SBI_PMU_TEST_BASIC;
+			else if (!strncmp("events", optarg, 6))
+				disabled_tests |= SBI_PMU_TEST_EVENTS;
+			else if (!strncmp("snapshot", optarg, 8))
+				disabled_tests |= SBI_PMU_TEST_SNAPSHOT;
+			else if (!strncmp("overflow", optarg, 8))
+				disabled_tests |= SBI_PMU_TEST_OVERFLOW;
+			else
+				goto done;
+			break;
+		case 'h':
+		default:
+			goto done;
+		}
+	}
+
+	return true;
+done:
+	test_print_help(argv[0]);
+	return false;
+}
+
+int main(int argc, char *argv[])
 {
-	test_vm_basic_test(test_pmu_basic_sanity);
-	pr_info("SBI PMU basic test : PASS\n");
+	if (!parse_args(argc, argv))
+		exit(KSFT_SKIP);
+
+	if (!(disabled_tests & SBI_PMU_TEST_BASIC)) {
+		test_vm_basic_test(test_pmu_basic_sanity);
+		pr_info("SBI PMU basic test : PASS\n");
+	}
 
-	test_vm_events_test(test_pmu_events);
-	pr_info("SBI PMU event verification test : PASS\n");
+	if (!(disabled_tests & SBI_PMU_TEST_EVENTS)) {
+		test_vm_events_test(test_pmu_events);
+		pr_info("SBI PMU event verification test : PASS\n");
+	}
 
-	test_vm_events_snapshot_test(test_pmu_events_snaphost);
-	pr_info("SBI PMU event verification with snapshot test : PASS\n");
+	if (!(disabled_tests & SBI_PMU_TEST_SNAPSHOT)) {
+		test_vm_events_snapshot_test(test_pmu_events_snaphost);
+		pr_info("SBI PMU event verification with snapshot test : PASS\n");
+	}
 
-	test_vm_events_overflow(test_pmu_events_overflow);
-	pr_info("SBI PMU event verification with overflow test : PASS\n");
+	if (!(disabled_tests & SBI_PMU_TEST_OVERFLOW)) {
+		test_vm_events_overflow(test_pmu_events_overflow);
+		pr_info("SBI PMU event verification with overflow test : PASS\n");
+	}
 
 	return 0;
 }
-- 
2.34.1


