Return-Path: <linux-kernel+bounces-50730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A0847D5B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B231C22416
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD5A12D74E;
	Fri,  2 Feb 2024 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dK0QIZAc"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9912C81D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917568; cv=none; b=isF0Dtlbs5wf7Dw3pNaUEMECof8nhHuBcmgj/KJPaKC6OBicaUbxRg+bGj+y/xTjGc9jxWWDrWxodpmt2QUvvmQKA7CqgAJbwZS2bvJ1NQXn1UPzIJJaagedK8bVxpztY04qTla5N/wd4PeMCkqmpxtCJjkamIDQ+876a72GuKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917568; c=relaxed/simple;
	bh=tCKrGRW7WN608392SeATTvTDea2Xb4gjQNimEpRumEo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tuMKEY+EuGst2pWQeWs3zAYifL7fCdNj+h/7bx8K5Agf8Sfv6QXg81Ysevlueafiulf9/7p8Q1hm7d0QhOpbUvwlXaRmjiYLzVwygA/iKIK7SKQP1Ev5YP9WDPAsSLl1zSDlzz0hblaIoY3d/r9Hbo5Nolb/9pqEPWlbQBp0fLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dK0QIZAc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ca4ee5b97aso2449926a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917566; x=1707522366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CadysjImRodM1JigoHu7x5dfRmrUFHW93Rcy1yZ8LIM=;
        b=dK0QIZAc2XbvzNlQa1FDCQoZISNfEi3cH0gikXWt3KJzxmAFuF6IRJ7YzZqSw+DxFM
         KLzeOltbdjYEqoUUTECoedMDxxSfS0643hhlQWk79Bl9GLczh3czu/dR3wREtZpFgjtv
         amZChyTRGyZE5DMreSnJWN6ivRH6AqtcTIf4DLQ1BDfeyaMR6jaJuy4c+cqS5XmBryur
         4E4T6BSmoM28v7Q3Qmq0iW0JjKRO373q5DiYJQGmGjXkfF+xtGHQNpOZuufLINMv8eoX
         wIS5/Hl0mY49dVqsBPeXfFjYiR5VXt811rri6H8GuwOZwsjdR0oVwO4ko7VYMigKJVcU
         x9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917566; x=1707522366;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CadysjImRodM1JigoHu7x5dfRmrUFHW93Rcy1yZ8LIM=;
        b=agZu1h+Wg1Y1ZBu/1sHsKSq9gtfBbdN02BMr0idJUhtHvvxx616lJu0yrctPvFdLts
         cjPLaZuRxLRAFK19YCni9Zqzc+sLlt6m1QC+43q8tkPt2U/tuLZLI5hJa5/uMKK+PhIV
         +jWL6x122fNsAsU1ikDfWYw8m6i1ZZzMB+jGToL5l7Qp0GgtNktNkLbIpkBiFxEHqBIv
         pOT7fh1x1ud0lVBynULIkhGY1YA8M3aVhkd/laHcygZa9MMmHEOSPy3/eCb50FP+6yLV
         62yxlu4P2/k+ho2V54ngH6j6p9C99xFtNfIRCUo/i0NpbacAA5yyu7Ouuh/yXGDMR0G1
         iXgA==
X-Gm-Message-State: AOJu0YwaJcxNYJPvcWu+9UszbR5SkEisyQwa5ZlIhmZCv1zRe6ct3ebJ
	Qwe4n+Du+bUZ01f5Rs5NeBPI6lEaTuSAlXO14P5UoDQubFlwottvflVUkE8sHkbZzT7TgPxhgw/
	A2g==
X-Google-Smtp-Source: AGHT+IHHsr4NU54NohTBduBzv4jpgrZuqG+/Ora3WvFzNYKUDGxh0aFGIwr7FvvMQVezeC1vmX7Awhvls+8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6e85:0:b0:5ca:439c:86ac with SMTP id
 bm5-20020a656e85000000b005ca439c86acmr132167pgb.8.1706917566148; Fri, 02 Feb
 2024 15:46:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Feb 2024 15:46:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202234603.366925-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Fix GUEST_PRINTF() format warnings in ARM code
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a pile of -Wformat warnings in the KVM ARM selftests code, almost all
of which are benign "long" versus "long long" issues (selftests are 64-bit
only, and the guest printf code treats "ll" the same as "l").  The code
itself isn't problematic, but the warnings make it impossible to build ARM
selftests with -Werror, which does detect real issues from time to time.

Opportunistically have GUEST_ASSERT_BITMAP_REG() interpret set_expected,
which is a bool, as an unsigned decimal value, i.e. have it print '0' or
'1' instead of '0x0' or '0x1'.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Compile tested only, mainly because I'm rushing through things on Friday
afternoon, not because testing on ARM is actually problematic for me.

 tools/testing/selftests/kvm/aarch64/arch_timer.c     |  4 ++--
 .../testing/selftests/kvm/aarch64/debug-exceptions.c |  2 +-
 tools/testing/selftests/kvm/aarch64/hypercalls.c     |  4 ++--
 .../testing/selftests/kvm/aarch64/page_fault_test.c  |  2 +-
 .../selftests/kvm/aarch64/vpmu_counter_access.c      | 12 ++++++------
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 274b8465b42a..d5e8f365aa01 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -158,9 +158,9 @@ static void guest_validate_irq(unsigned int intid,
 
 	/* Basic 'timer condition met' check */
 	__GUEST_ASSERT(xcnt >= cval,
-		       "xcnt = 0x%llx, cval = 0x%llx, xcnt_diff_us = 0x%llx",
+		       "xcnt = 0x%lx, cval = 0x%lx, xcnt_diff_us = 0x%lx",
 		       xcnt, cval, xcnt_diff_us);
-	__GUEST_ASSERT(xctl & CTL_ISTATUS, "xcnt = 0x%llx", xcnt);
+	__GUEST_ASSERT(xctl & CTL_ISTATUS, "xcnt = 0x%lx", xcnt);
 
 	WRITE_ONCE(shared_data->nr_iter, shared_data->nr_iter + 1);
 }
diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
index 866002917441..2582c49e525a 100644
--- a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
+++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
@@ -365,7 +365,7 @@ static void guest_wp_handler(struct ex_regs *regs)
 
 static void guest_ss_handler(struct ex_regs *regs)
 {
-	__GUEST_ASSERT(ss_idx < 4, "Expected index < 4, got '%u'", ss_idx);
+	__GUEST_ASSERT(ss_idx < 4, "Expected index < 4, got '%lu'", ss_idx);
 	ss_addr[ss_idx++] = regs->pc;
 	regs->pstate |= SPSR_SS;
 }
diff --git a/tools/testing/selftests/kvm/aarch64/hypercalls.c b/tools/testing/selftests/kvm/aarch64/hypercalls.c
index 31f66ba97228..c62739d897d6 100644
--- a/tools/testing/selftests/kvm/aarch64/hypercalls.c
+++ b/tools/testing/selftests/kvm/aarch64/hypercalls.c
@@ -105,12 +105,12 @@ static void guest_test_hvc(const struct test_hvc_info *hc_info)
 		case TEST_STAGE_HVC_IFACE_FEAT_DISABLED:
 		case TEST_STAGE_HVC_IFACE_FALSE_INFO:
 			__GUEST_ASSERT(res.a0 == SMCCC_RET_NOT_SUPPORTED,
-				       "a0 = 0x%lx, func_id = 0x%x, arg1 = 0x%llx, stage = %u",
+				       "a0 = 0x%lx, func_id = 0x%x, arg1 = 0x%lx, stage = %u",
 					res.a0, hc_info->func_id, hc_info->arg1, stage);
 			break;
 		case TEST_STAGE_HVC_IFACE_FEAT_ENABLED:
 			__GUEST_ASSERT(res.a0 != SMCCC_RET_NOT_SUPPORTED,
-				       "a0 = 0x%lx, func_id = 0x%x, arg1 = 0x%llx, stage = %u",
+				       "a0 = 0x%lx, func_id = 0x%x, arg1 = 0x%lx, stage = %u",
 					res.a0, hc_info->func_id, hc_info->arg1, stage);
 			break;
 		default:
diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index 08a5ca5bed56..7bbd9fb5c8d6 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -292,7 +292,7 @@ static void guest_code(struct test_desc *test)
 
 static void no_dabt_handler(struct ex_regs *regs)
 {
-	GUEST_FAIL("Unexpected dabt, far_el1 = 0x%llx", read_sysreg(far_el1));
+	GUEST_FAIL("Unexpected dabt, far_el1 = 0x%lx", read_sysreg(far_el1));
 }
 
 static void no_iabt_handler(struct ex_regs *regs)
diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
index 9d51b5691349..f8f0c655c723 100644
--- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
@@ -195,11 +195,11 @@ struct pmc_accessor pmc_accessors[] = {
 										 \
 	if (set_expected)							 \
 		__GUEST_ASSERT((_tval & mask),					 \
-				"tval: 0x%lx; mask: 0x%lx; set_expected: 0x%lx", \
+				"tval: 0x%lx; mask: 0x%lx; set_expected: %u",	 \
 				_tval, mask, set_expected);			 \
 	else									 \
 		__GUEST_ASSERT(!(_tval & mask),					 \
-				"tval: 0x%lx; mask: 0x%lx; set_expected: 0x%lx", \
+				"tval: 0x%lx; mask: 0x%lx; set_expected: %u",	 \
 				_tval, mask, set_expected);			 \
 }
 
@@ -286,7 +286,7 @@ static void test_access_pmc_regs(struct pmc_accessor *acc, int pmc_idx)
 	acc->write_typer(pmc_idx, write_data);
 	read_data = acc->read_typer(pmc_idx);
 	__GUEST_ASSERT(read_data == write_data,
-		       "pmc_idx: 0x%lx; acc_idx: 0x%lx; read_data: 0x%lx; write_data: 0x%lx",
+		       "pmc_idx: 0x%x; acc_idx: 0x%lx; read_data: 0x%lx; write_data: 0x%lx",
 		       pmc_idx, PMC_ACC_TO_IDX(acc), read_data, write_data);
 
 	/*
@@ -297,14 +297,14 @@ static void test_access_pmc_regs(struct pmc_accessor *acc, int pmc_idx)
 
 	/* The count value must be 0, as it is disabled and reset */
 	__GUEST_ASSERT(read_data == 0,
-		       "pmc_idx: 0x%lx; acc_idx: 0x%lx; read_data: 0x%lx",
+		       "pmc_idx: 0x%x; acc_idx: 0x%lx; read_data: 0x%lx",
 		       pmc_idx, PMC_ACC_TO_IDX(acc), read_data);
 
 	write_data = read_data + pmc_idx + 0x12345;
 	acc->write_cntr(pmc_idx, write_data);
 	read_data = acc->read_cntr(pmc_idx);
 	__GUEST_ASSERT(read_data == write_data,
-		       "pmc_idx: 0x%lx; acc_idx: 0x%lx; read_data: 0x%lx; write_data: 0x%lx",
+		       "pmc_idx: 0x%x; acc_idx: 0x%lx; read_data: 0x%lx; write_data: 0x%lx",
 		       pmc_idx, PMC_ACC_TO_IDX(acc), read_data, write_data);
 }
 
@@ -379,7 +379,7 @@ static void guest_code(uint64_t expected_pmcr_n)
 	int i, pmc;
 
 	__GUEST_ASSERT(expected_pmcr_n <= ARMV8_PMU_MAX_GENERAL_COUNTERS,
-			"Expected PMCR.N: 0x%lx; ARMv8 general counters: 0x%lx",
+			"Expected PMCR.N: 0x%lx; ARMv8 general counters: 0x%x",
 			expected_pmcr_n, ARMV8_PMU_MAX_GENERAL_COUNTERS);
 
 	pmcr = read_sysreg(pmcr_el0);

base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.43.0.594.gd9cf4e227d-goog


