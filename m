Return-Path: <linux-kernel+bounces-110781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97248863DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF7D1C21B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB599479;
	Thu, 21 Mar 2024 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j6p7vQFa"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9451B592
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711062558; cv=none; b=TU4mOKCUFZGr+/+KaCKjMpgqL+QOWBrbkkMzIAy4XlEjRY5tgY5h6569p6wcRjdaIChXxT0loJBrcibpZ3rbDsp5zhwtq+HzO3wYO4EXrrRNIOalLAPWBw408wSyIJteALXH4iDmI2Vv4rrJCO7lOMKp2b4d/VIkuoo3xEp9ohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711062558; c=relaxed/simple;
	bh=n7xQqZqUl4kv50Nr07azm40NZTB1kOsTNps43RcbT/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dd4q8ec0NNu/oGIrbfOibZD2C16cB3Wvc6GEL6XIi5z793lMGQi2xgyNf73PMnzF5tWgGHTWKMaFBCWnDrmPgX498AxXg0h39GOHw+oqBEpKM449UK8yrmesBoj6LBa8nKOxwGZex79RrG6Ko+NsXw9/K+ScFnL1om5zyp3fO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=j6p7vQFa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ea7f2d093aso408589b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711062556; x=1711667356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2g6BoqLKj372/A/Rp4yX95Q1DYjG7vH04Tm1sPT6Ptc=;
        b=j6p7vQFaIl8f7e9Hync9P0Hs94KDf5hPrVciqDwiBg/4pMnLW6y08n6h/s22jDQ9Ry
         lrWD12bS0fQZr0Nzulj60+Y3LphZX6myWjFrwNVYCue1jPc8IXHbxG+dJGszxI+Pmfve
         t7VYhIzLEMk3SkaHhYv26P0B7KPSnYjVOP2NetJYwCES4ZOdlJPikKxtrK16kEVXTlLg
         3X5kTIvHjwNjWNZQ+6RpySFQp9FR3bwXlWRYuWVzNaiif/lOe/nKP+waAz/jTOHAcooF
         gOq7QjYWAtYtGmY1taZ3vFBOuTyqDVS8KWqOhaCuTbRFE4oc5+aC2i/YJNLObLnU3KfE
         gwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711062556; x=1711667356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2g6BoqLKj372/A/Rp4yX95Q1DYjG7vH04Tm1sPT6Ptc=;
        b=VHrTQrLFVbMK+ZSHNukCXalpNX+f4exTTM1yenTsOUYLmmLBCSCSFF6nF38xVNU0Rn
         KahCZC+AjX4l0LBdIdxC5V7JfS0mMmh07iAtdY7lpybsaVFTbuIMPlCWkCWJT/OyVYEK
         +36mOdSOc8fnHNQSqT0h+4iEkgpSyyu+KC6qkfqqn7FAtG1zxOborVvvqTF+SPIQw6tK
         Siuc8CN/Xxtegfhk5I59xTffYDC1eK03UJVkTMt5usjIsMMxoP1swkN7ySf3jPIs1awj
         6NbSPR38QHHUaXvFeP2l+IA1+Vk8cNNYHIC+Eg8tRHu5pBT6WXdcnBNeB4+pmBQOOTu/
         Xq6A==
X-Forwarded-Encrypted: i=1; AJvYcCWy76pgBx0lYHl3EnJF+WgvTmma0cFDm5AjLfhhSqqbwTD2jjgFdAK9SaMM9uWlsASoMb6KavYe09ycUuaudn0lgyazJko7Cyq1nNc7
X-Gm-Message-State: AOJu0Yz6X9LYB3iZ7aDzgJS/Ra8l71Ja7LQSZFY2X1ytW8DFvNoibAxq
	ZXbRs9eVCgdDxAFZkd78r5YGp0q8IsL1fcjT6OkfiRG1rjfao4IXToPspzweFlIKba9O0NNXiyB
	K
X-Google-Smtp-Source: AGHT+IHIoIGMfAMpYRB/firUliTLDlGtLCx6TBBwf1mVlVbKPjyICGbmWA2wnx86gggF4keCKftKfg==
X-Received: by 2002:a05:6a20:9f95:b0:1a3:8904:1fc9 with SMTP id mm21-20020a056a209f9500b001a389041fc9mr1145120pzb.41.1711062093305;
        Thu, 21 Mar 2024 16:01:33 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id h16-20020aa786d0000000b006e6baf14752sm369511pfo.58.2024.03.21.16.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 16:01:32 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: Add tracepoints for SBI calls and returns
Date: Thu, 21 Mar 2024 16:01:25 -0700
Message-ID: <20240321230131.1838105-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are useful for measuring the latency of SBI calls. The SBI HSM
extension is excluded because those functions are called from contexts
such as cpuidle where instrumentation is not allowed.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Remove some blank lines

 arch/riscv/include/asm/trace.h | 54 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/sbi.c        |  7 +++++
 2 files changed, 61 insertions(+)
 create mode 100644 arch/riscv/include/asm/trace.h

diff --git a/arch/riscv/include/asm/trace.h b/arch/riscv/include/asm/trace.h
new file mode 100644
index 000000000000..6151cee5450c
--- /dev/null
+++ b/arch/riscv/include/asm/trace.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM riscv
+
+#if !defined(_TRACE_RISCV_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RISCV_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT_CONDITION(sbi_call,
+	TP_PROTO(int ext, int fid),
+	TP_ARGS(ext, fid),
+	TP_CONDITION(ext != SBI_EXT_HSM),
+
+	TP_STRUCT__entry(
+		__field(int, ext)
+		__field(int, fid)
+	),
+
+	TP_fast_assign(
+		__entry->ext = ext;
+		__entry->fid = fid;
+	),
+
+	TP_printk("ext=0x%x fid=%d", __entry->ext, __entry->fid)
+);
+
+TRACE_EVENT_CONDITION(sbi_return,
+	TP_PROTO(int ext, long error, long value),
+	TP_ARGS(ext, error, value),
+	TP_CONDITION(ext != SBI_EXT_HSM),
+
+	TP_STRUCT__entry(
+		__field(long, error)
+		__field(long, value)
+	),
+
+	TP_fast_assign(
+		__entry->error = error;
+		__entry->value = value;
+	),
+
+	TP_printk("error=%ld value=0x%lx", __entry->error, __entry->value)
+);
+
+#endif /* _TRACE_RISCV_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+
+#define TRACE_INCLUDE_PATH asm
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index e66e0999a800..a1d21d8f5293 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -14,6 +14,9 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
+#define CREATE_TRACE_POINTS
+#include <asm/trace.h>
+
 /* default SBI version is 0.1 */
 unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
@@ -31,6 +34,8 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 {
 	struct sbiret ret;
 
+	trace_sbi_call(ext, fid);
+
 	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
 	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
 	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
@@ -46,6 +51,8 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 	ret.error = a0;
 	ret.value = a1;
 
+	trace_sbi_return(ext, ret.error, ret.value);
+
 	return ret;
 }
 EXPORT_SYMBOL(sbi_ecall);
-- 
2.43.1


