Return-Path: <linux-kernel+bounces-108169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E8288070C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671DF1C21D93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17C95FDB3;
	Tue, 19 Mar 2024 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HYuG4MNr"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5F5FB89
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885564; cv=none; b=FGb+qUbvCBZ5XpyCB7bQgf3MAWv/mv6WhLYXDqTO89XtquGbq8Xzss2LJdiEJgsINpBqyynpXmHR2sel0kqpZPtpK+seU/sy3LW32jga88cTgoY+Y0rin8dz7jDC8S1DFn3pDHOtow7xvvodrWPaf+shm3Js4uUqIN1MiFMMl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885564; c=relaxed/simple;
	bh=cEPz5xiSAtfk2P9aOMl8XYGHlXI3VdaxfNONGT1LKvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3HvDAhCPUouDtZw37v7ILzdcOywqxrbBZwaHaEy7AajEMcNODuVYfK7So6Lyi4YDFEE2hh0GDBJ6LTfyuJnW8SKnJt/uZeYtX1nut42JmNzInBN5IMIRlC9Pa1ON506YbEYYXoR3lRZr9B1lHZCPCYDMpNTs72f7xLSBgx5wPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HYuG4MNr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6f6d782e4so4000996b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710885562; x=1711490362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciVO7+10eZV72+E/ORaPRZFjospVEi/8CuyB7rGS1wk=;
        b=HYuG4MNrlbRtf7eMgMVlSp7YIFl/zaBSEkSN2nLCpeGaa8injNEpimcOM/pmORtX5B
         wkOgt2UsyMS3WNLkmjcb/Gls9H9TD8/S0QowXNmoCv3eR6hlnmr8g2IiuB/IXFDaU7es
         5mX/GEYb4GFWUw2LZbFjygdKRPnMyM32Mbxw6HutCpsebShXiv6ieP+MPHp0an8wp3Za
         7abnvPp3zhMmR7yeuciUt0UB7a0/XFuecp8aXpaaIjKRkzIu98vfGEmvacKWmHXUroSj
         tm8YNa5jd+eTdpe30nTHV38k5NCtSxDfj7gn3OOmbTKKR+E+wbVtmoYJ/6jo45BKSD1N
         r0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710885562; x=1711490362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciVO7+10eZV72+E/ORaPRZFjospVEi/8CuyB7rGS1wk=;
        b=RDPmUWu2/ooY7yz7cF+sH12T+kBEfxGsZo7KXKfc8F2BXtPS87NfDhBiXssM4tKTYD
         1oYZK8iNUdrh/khNOia5dgmqZZFtdNsYjUYGkqOB4HQWeRN0b2T4MUyxF60pyiOj9UxJ
         hmmc3XciintaXInYO+8jZaFD53R51QRYdgCee8GAfwPhaP8LpnyqKuh9V/0ln4fq73o0
         q7zo1Kd8Fd/OZmAWRDUAgK8sDc7ZY7CzOgBKt+/vtOedezAjmOqM2hfRor1CbvmbveG1
         48b21823YSQhOGr4iRYyk1WFrUrfA8LfrFmIdoHfJnyGcP35Bs+0nFI4vmUoa4TC3F5M
         Z57g==
X-Forwarded-Encrypted: i=1; AJvYcCX8UYVO0z4kMgfQRuLEE1N+5183p+ftwHCJnbD6N4CYEoIyG9GyuB2T3VjLGr4aWEGb5z9h1G5dr+lsswTc4ZxBcv8gQCI4IB4V/MsF
X-Gm-Message-State: AOJu0YwhJJIQXflf7ASBQOuE3FikqO1pEI29ht3wdKILnlXNjxNIE6ls
	WW2ThxZy01HyyIHufIN2a/w3Znwd5l/JITOh+JRZ/T6DYS/sJfzr5d/5HTkOTPc=
X-Google-Smtp-Source: AGHT+IFywIvk95HmWYC1ps8ZiAyORSpJBD5fZsHjoqcZoqHYlw5bVo0KamFA/Wgvuncr3jxrfpyfUQ==
X-Received: by 2002:a05:6a00:721c:b0:6e6:fcd4:4f44 with SMTP id lk28-20020a056a00721c00b006e6fcd44f44mr11479878pfb.16.1710885561953;
        Tue, 19 Mar 2024 14:59:21 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006e6c61b264bsm10273892pfn.32.2024.03.19.14.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:59:21 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	tech-j-ext@lists.risc-v.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: [RFC PATCH 4/9] riscv: Define is_compat_thread()
Date: Tue, 19 Mar 2024 14:58:30 -0700
Message-ID: <20240319215915.832127-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240319215915.832127-1-samuel.holland@sifive.com>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows checking if some thread other than current is 32-bit.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/compat.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
index 2ac955b51148..233c439c12d7 100644
--- a/arch/riscv/include/asm/compat.h
+++ b/arch/riscv/include/asm/compat.h
@@ -12,11 +12,18 @@
 #include <linux/sched/task_stack.h>
 #include <asm-generic/compat.h>
 
+#ifdef CONFIG_COMPAT
+
 static inline int is_compat_task(void)
 {
 	return test_thread_flag(TIF_32BIT);
 }
 
+static inline int is_compat_thread(struct thread_info *thread)
+{
+	return test_ti_thread_flag(thread, TIF_32BIT);
+}
+
 struct compat_user_regs_struct {
 	compat_ulong_t pc;
 	compat_ulong_t ra;
@@ -126,4 +133,13 @@ static inline void cregs_to_regs(struct compat_user_regs_struct *cregs,
 	regs->t6	= (unsigned long) cregs->t6;
 };
 
+#else
+
+static inline int is_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
+
+#endif
+
 #endif /* __ASM_COMPAT_H */
-- 
2.43.1


