Return-Path: <linux-kernel+bounces-38016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D2583B9C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555BE283855
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5A11705;
	Thu, 25 Jan 2024 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0vS8AnvS"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AE18035
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164171; cv=none; b=cCdpDpGlpHTJ86aq+gQSCohvUIHoS3clAF8GsWfRJcsLbRIVN9PAh/NnrLhVa0xQu7bnhPNbZsdbZ8RmOx695D7s9x1zU3JVAvLCu4fwsOJApuoI3Tn2S1628OIPt5IgRraSiDHPZ+86YRUVXj2f7KBTjtw/yxNwF1u6vj0LsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164171; c=relaxed/simple;
	bh=lvcSUefbZKHEgU2X9J/Gr99to8gQ98mqsIy51a0c5ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4kimY0vT5VIFF+3o15DGSUW+2edqC5P4AO+wA+fLl6CvpIrCKUdHxsCHFoYey0GhS8LvY2vpbXf8tP2VhCh7a0Y7X/SMkF+P7GUP3G6t3WOgoGjQv4RrpC4fUldeGVtQ22ibnRjVfXp+Dhvyrt7zO+09+kWsvH35cqnKcx3RhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0vS8AnvS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddd19552e6so80421b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164168; x=1706768968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N8f26gdn2cRJikP5qLVCVRN7EIk5o+zwHdVnNZOBlE=;
        b=0vS8AnvSi1MTDIkuSVLuuUcRwXb9m8jAT5iy3tKgMJg3QTQuaSYCDKrsJhmNg+q1ee
         wZYPie7lrLfn7iZAOmlfyEvT+3geeWtFyquw2BIHZxsU4TIvjmtQHFUd3cPRv+/yS0Bv
         TuSQkkhOlAnG1i8aZcU+1NV+BTQuVrdThMldpKTn7wFHXB0JVUQXJKfTo3XNaZhYSWzY
         S1oR75N5UT0fIUUS6WhZz1P1wBt6tjlHIArByYKIUVAFUoqlSCVsx2vmboUQsvrajXs3
         ePvDn373XujWUYCHpIMzpm2K06jURGUK9pv83llIGNzaV+BZI+fF++jT7IxKNC8kWmjA
         tkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164168; x=1706768968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N8f26gdn2cRJikP5qLVCVRN7EIk5o+zwHdVnNZOBlE=;
        b=DlkRzgMp2H0b9ZS6WinWyVzRo2x6vX5u+dm9oCvoMLPiagajH84QyNmLNGfG3Oq3f8
         DfSVR5RdxDjnEOETt5/MlYKNovfhjqkdLPpQRHwAoQPbL1nmDjvJazSX0B9vZbnM2XNQ
         t5YdnA3bcWjB66Wc3S98EIc8//vuqvBSltUeYVPa8T/ZAseBSGpdZLwEnrQCgxpvq/U9
         Yf+qcmjffsDm8p4EjZlK0LXEjOP8Z6T1+utKXnv1SfuIbMf3D57kukKsCE1gsBHRCE3e
         zji2KRZT/hpZ59pc7sPHHzesTpWUk6Ck7eGUA7CULm13JR73F0Y1H6G2ismpVIlI7XFo
         CwdA==
X-Gm-Message-State: AOJu0YyU7jl0M3PcSCf0XiPYhULSmsAZAJtWpXYsWZLa2SOPkgIufnU6
	7f3C3KuaVuKk5904bx3JP0QyB6YXyv3IKFzIkgNhjgrIveP7lEY2frl1MbvMv6A=
X-Google-Smtp-Source: AGHT+IHrQQhht3UiJlyKEtEWAFFtcgqnTtiAl+0dT+6axrsGaLK/T90q0i7kfWmqNxjWPLmEJD8+XA==
X-Received: by 2002:a05:6a00:3d04:b0:6dd:a004:c195 with SMTP id lo4-20020a056a003d0400b006dda004c195mr250813pfb.60.1706164168419;
        Wed, 24 Jan 2024 22:29:28 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:29:28 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 10/28] riscv/mm : Introducing new protection flag "PROT_SHADOWSTACK"
Date: Wed, 24 Jan 2024 22:21:35 -0800
Message-ID: <20240125062739.1339782-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

x86 and arm64 are using VM_SHADOW_STACK (which actually is VM_HIGH_ARCH_5)
vma flag and thus restrict it to 64bit implementation only. RISC-V is choosing
to encode presence of only VM_WRITE in vma flags as shadow stack vma. This allows
32bit RISC-V ecosystem leverage shadow stack as well.
This means that existing users of `do_mmap` who had been using `VM_WRITE` and
expecting read and write permissions will break.
Thus introducing `PROT_SHADOWSTACK` to allow `do_mmap` disambiguate between
read write v/s shadow stack mappings. Thus any kernel driver/module using `do_mmap`
and only passing `VM_WRITE` would still get read-write mappings. Although any user
of `do_mmap` intending to map a shaodw stack should pass `PROT_SHADOWSTACK` to get
a shadow stack mapping.

Although for userspace still want to rely on `map_shadow_stack` and not expose
`PROT_SHADOWSTACK` to userspace and that's why this prot flag is not exposed in uapi
headers.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mman.h | 25 +++++++++++++++++++++++++
 mm/mmap.c                     |  1 +
 2 files changed, 26 insertions(+)
 create mode 100644 arch/riscv/include/asm/mman.h

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
new file mode 100644
index 000000000000..4902d837e93c
--- /dev/null
+++ b/arch/riscv/include/asm/mman.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <uapi/asm/mman.h>
+
+/*
+ * Major architectures (x86, aarch64, riscv) have shadow stack now. x86 and
+ * arm64 choose to use VM_SHADOW_STACK (which actually is VM_HIGH_ARCH_5) vma
+ * flag, however that restrict it to 64bit implementation only. risc-v shadow
+ * stack encodings in page tables is PTE.R=0, PTE.W=1, PTE.D=1 which used to be
+ * reserved until now. risc-v is choosing to encode presence of only VM_WRITE in
+ * vma flags as shadow stack vma. However this means that existing users of mmap
+ * (and do_mmap) who were relying on passing only PROT_WRITE (or VM_WRITE from
+ * kernel driver) but still getting read and write mappings, should still work.
+ * x86 and arm64 followed the direction of a new system call `map_shadow_stack`.
+ * risc-v would like to converge on that so that shadow stacks flows are as much
+ * arch agnostic. Thus a conscious decision to define PROT_XXX definition for
+ * shadow stack here (and not exposed to uapi)
+ */
+#define PROT_SHADOWSTACK	0x40
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/mm/mmap.c b/mm/mmap.c
index 1971bfffcc03..fab2acf21ce9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
 #include <linux/ksm.h>
+#include <linux/processor.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
-- 
2.43.0


