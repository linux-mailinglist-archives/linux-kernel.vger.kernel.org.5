Return-Path: <linux-kernel+bounces-100797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E36F879D67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EFEB226A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71FA143736;
	Tue, 12 Mar 2024 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kBC1xJIQ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFDF142913
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278685; cv=none; b=rdygqFBUnYviDbQZ268EVoFpvD+rp3XXIGWNgpzOKAwJWT8rCTpHoTWoXMveRZJwXMSgbfPNJlSZmn1f68YFNmWF/NFMTkiLYwdidkZhNAMq+lnh1GKdtNuG1SaNrw3XF2P6HTPeR5P4k2OPSPbj9jPMu7/vlorH1Bt+o4UFUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278685; c=relaxed/simple;
	bh=F0sqTGMrHxdHeDg55as8YijyH+ZlgfiEJaxaOVwAX/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tncGXln3u6VcptElL4QpFf/KWkkTutCF6AzeAX4WMP3dQvB7XU/52SwEIewj/FCJFzQynM5Dd+VF9cWebhT8fSqqqst+FkICkUMHTvxy7T0up6lHLyafYv+/lsP9kroRfFclAhBm/tIu6iYcQbKJXVHnETmtClKAQzbliEoYsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kBC1xJIQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc75972f25so3097485ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710278682; x=1710883482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=POJmgEct7odPCU2lHiEFfrvljmEVEMGIYXU9CkBwZGw=;
        b=kBC1xJIQIlRVxinsBAEZg8lBM7UtWvjzOgCMhpwPcliEwfDCx6h/5e26I4zFUGZ9Bd
         AZ8E9jkRgKNAGqxYIMXpp7cSlIAiIHtappGM/UaKOWXJQQfqZ1EJ0v0ISkI6WX970z92
         VmyWkay78THZ1WReXWaB2gMlkKbJaAsgzeoUkh8eJDhRIMgs2kOu+9ye4b2fWvok1Yyr
         hDvGc+zjZva/11d/O6j/Sw+vm4vJcTgbBHNJfjWwNZEgy2ZBAnH6dZaVvTMw8z0EmJVN
         bjqF4cIlWLZVOAE2w3vEp+ctQm5MLLvTl6eXfUVeltXtiyxDL8UCrRY0nWEc+6tQonAi
         li2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710278682; x=1710883482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POJmgEct7odPCU2lHiEFfrvljmEVEMGIYXU9CkBwZGw=;
        b=HM54esWXQAauEZFoopBNs06UshFdCuLh4N1JNQzR6w3qF8UqExQ9yZE+PaR3fl7FfR
         eNIO0aGlMI0MSE876zP2Fy9kQDoGhsEetZXqCEn4AkM9jStHRUMSamvdPzaPBbTcJhbB
         BOCKN4HFyQoEVgdn2C4uJYJ5z/DWw6ACxQOcQGyuIl62vYPwWDP5aiqyj3trMYuUITva
         brcNNzj44x0mqg/hMQ0iS3F+g1D+stds5rycB6TIUhOHh2WnWNUtQFNMuFEHL0v6DAq8
         Eej7oDWGeqLaDYq696FPxklIQnmYWwM6AqPrWTUFdiJ4jJMHSgPEM0iVQ1WdcuABduap
         8vUg==
X-Forwarded-Encrypted: i=1; AJvYcCUA+n0RBNwPz3g9EU06s0571rBzmq+dSgyn212hbMzGbt8xvO5FrrUiwL+mYdrV1oBDqpy6jfYJC/1pxXlXyROV5i16k92evt56fO7L
X-Gm-Message-State: AOJu0Yz4hsuNpuljQUwIEoqSgbTrUCE9e5byQ6o9xs++F3nAhLSvEJwk
	NvZKfgmm5i72UE6IP9f/fwKh3jkmKlW+7OMTqP9asiQoh92PCWeT5dAf3vs7paA=
X-Google-Smtp-Source: AGHT+IEwScSJtysO1OwJWcVDCi/FLHLz22ZYjopeyUGf6UmugoZJ0G9YjmPWpPXpJ6LYpcSejUezgw==
X-Received: by 2002:a17:903:4292:b0:1dd:6fc5:1c5c with SMTP id ju18-20020a170903429200b001dd6fc51c5cmr3880349plb.52.1710278682675;
        Tue, 12 Mar 2024 14:24:42 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902f68500b001dca99546d2sm7148489plg.70.2024.03.12.14.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:24:42 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Add tracepoints for SBI calls and returns
Date: Tue, 12 Mar 2024 14:23:34 -0700
Message-ID: <20240312212441.2322765-1-samuel.holland@sifive.com>
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

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/trace.h | 60 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/sbi.c        |  7 ++++
 2 files changed, 67 insertions(+)
 create mode 100644 arch/riscv/include/asm/trace.h

diff --git a/arch/riscv/include/asm/trace.h b/arch/riscv/include/asm/trace.h
new file mode 100644
index 000000000000..f96091f83c25
--- /dev/null
+++ b/arch/riscv/include/asm/trace.h
@@ -0,0 +1,60 @@
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
+
+	TP_PROTO(int ext, int fid),
+
+	TP_ARGS(ext, fid),
+
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
+
+	TP_PROTO(int ext, long error, long value),
+
+	TP_ARGS(ext, error, value),
+
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


