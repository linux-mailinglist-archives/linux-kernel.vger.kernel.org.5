Return-Path: <linux-kernel+bounces-85979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D47086BDFD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5416B2499D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FE154F9D;
	Thu, 29 Feb 2024 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AelzPRJ8"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582B53E1E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168525; cv=none; b=WZp49oP7ndOgWBa702eQsRPhhfa8eHlth80R1DHvIh9dvsbhMr0OiAZPZd9oQBoNZTV2KB+5mWTF1+Hox2RdZGZ9eKrPH551HxJyY4DTXHOPSNHcLO0rnmI1rixlOoEPFmEn2ZSgVe5uac1oLw/ZqcsfXfKtnycB72Jaf4E4zJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168525; c=relaxed/simple;
	bh=xRr1u8MM3L2hXdWDoveV/cK9kuDJMxf793j/MouCLbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WvR942JfPMdhAGWkJp2MvrVmrW/JAqrAPrculkTfikYSEzLzsbRDzNMoSxPkOlT2dQOPYEL55FSqAI9j72+yHe2a3ehzo9/rmfENSYQzTICyYfzqLFPcZ+th4AzJwL27PHhjUGxrVDzVl53gw3d/c9jWSq1JlEvb6+2n7RSi+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AelzPRJ8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so3642305ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709168522; x=1709773322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD/948XWBq0x/qa95YGc01R9c0TbIYHVZYjMe5MrY6w=;
        b=AelzPRJ8E4msCcBCgMaU9VWJyFj9bc+F/sUy2VNTUQg/+heJ/RkHYDrGVz5mo/WFxr
         ymy1NGjv/QXYBemtt4zRKdvA/s2zSBOyQ30X17sE+9YrmawyKqLgVjF6aRDosy2mZ9lC
         jM1YymmuD4WYqLndWpBNGkzTgTuEGOC/Cjnf+jtXkpm665vUhP1gxBptAk7hU0+22txs
         nRSawTDhpx3yZRFkc+sjYUv6/wdPTX6iIhG5gShUyJ42wFMJM3+cz25awol6fFWX6soq
         LzuBPSzDo0vU1kbMXhozpMsJs5BE3lUdw1TxgkfYx0DszKxMEToPr+M9IKHv3J7mVC27
         RtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168522; x=1709773322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD/948XWBq0x/qa95YGc01R9c0TbIYHVZYjMe5MrY6w=;
        b=e+UDdm1JHRUMtO5iBp/wDSFHjj2EGonehwoAv3JTOr1tNBxxHonoZe+I4LFxlQG09x
         ipTroIfZAOB31DySLXz9uIR8OFYyLPDb0cRbqWj/69oQ6CCjx93Xm0edXXAEJ1OM7l/t
         n0gzQp5ITwqIvep4rEOC5pLmYcyLfRMygiKVhfve7Pce99MdSMJpUwgAdMvpy0LOQiZX
         Sgj4ebjd2vIP0URIBstiNKeBBVeYR0i7vmaFNwJkyFzarbtflwRAC1YiVVWXXEvXRNtM
         Wi8Nrz6Ae5Y5q8GlOpAmMIwVux/PI8TEDVrWKyxkbl9yifx2jTH1KHulCXHuS7LBPaue
         gU8Q==
X-Gm-Message-State: AOJu0YzShU3QANaOorAwUm6JsxPJ5xvGkbyfMvXMlypmlQbrxYVg6izG
	zH8IlJXaM0pqECkdSK6pjUcWA/Gx99+yzRWd8eAm0Ygh9UulebDyR3JpAGbbwWZNXTiCiLG2jpD
	/
X-Google-Smtp-Source: AGHT+IECcPOsQd/Wcs/NXzfGXSpVCP5gcdN7koVt3lBZSHounAjkyFjG1eItkUqy7PPWX4hGVp9DAA==
X-Received: by 2002:a17:902:db0a:b0:1dc:38c7:ba1a with SMTP id m10-20020a170902db0a00b001dc38c7ba1amr731926plx.25.1709168522225;
        Wed, 28 Feb 2024 17:02:02 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc8d6a9d40sm78043plx.144.2024.02.28.17.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:02:01 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v4 12/15] KVM: riscv: selftests: Add SBI PMU extension definitions
Date: Wed, 28 Feb 2024 17:01:27 -0800
Message-Id: <20240229010130.1380926-13-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229010130.1380926-1-atishp@rivosinc.com>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI PMU extension definition is required for upcoming SBI PMU
selftests.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../selftests/kvm/include/riscv/processor.h   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index f75c381fa35a..a49a39c8e8d4 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -169,17 +169,84 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector, exception_handl
 enum sbi_ext_id {
 	SBI_EXT_BASE = 0x10,
 	SBI_EXT_STA = 0x535441,
+	SBI_EXT_PMU = 0x504D55,
 };
 
 enum sbi_ext_base_fid {
 	SBI_EXT_BASE_PROBE_EXT = 3,
 };
 
+enum sbi_ext_pmu_fid {
+	SBI_EXT_PMU_NUM_COUNTERS = 0,
+	SBI_EXT_PMU_COUNTER_GET_INFO,
+	SBI_EXT_PMU_COUNTER_CFG_MATCH,
+	SBI_EXT_PMU_COUNTER_START,
+	SBI_EXT_PMU_COUNTER_STOP,
+	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
+	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
+};
+
+union sbi_pmu_ctr_info {
+	unsigned long value;
+	struct {
+		unsigned long csr:12;
+		unsigned long width:6;
+#if __riscv_xlen == 32
+		unsigned long reserved:13;
+#else
+		unsigned long reserved:45;
+#endif
+		unsigned long type:1;
+	};
+};
+
 struct sbiret {
 	long error;
 	long value;
 };
 
+/** General pmu event codes specified in SBI PMU extension */
+enum sbi_pmu_hw_generic_events_t {
+	SBI_PMU_HW_NO_EVENT			= 0,
+	SBI_PMU_HW_CPU_CYCLES			= 1,
+	SBI_PMU_HW_INSTRUCTIONS			= 2,
+	SBI_PMU_HW_CACHE_REFERENCES		= 3,
+	SBI_PMU_HW_CACHE_MISSES			= 4,
+	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
+	SBI_PMU_HW_BRANCH_MISSES		= 6,
+	SBI_PMU_HW_BUS_CYCLES			= 7,
+	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
+	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
+	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
+
+	SBI_PMU_HW_GENERAL_MAX,
+};
+
+/* SBI PMU counter types */
+enum sbi_pmu_ctr_type {
+	SBI_PMU_CTR_TYPE_HW = 0x0,
+	SBI_PMU_CTR_TYPE_FW,
+};
+
+/* Flags defined for config matching function */
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
+#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
+#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
+
+/* Flags defined for counter start function */
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
+#define SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT BIT(1)
+
+/* Flags defined for counter stop function */
+#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
+#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
+
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
-- 
2.34.1


