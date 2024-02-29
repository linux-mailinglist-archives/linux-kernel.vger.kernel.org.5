Return-Path: <linux-kernel+bounces-85968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6A86BDDC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5F81C231FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1C6446AE;
	Thu, 29 Feb 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IoK//gjw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CEA249ED
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168506; cv=none; b=DIR5GIwImWHUOyeJTJdIqEOTJrXAjczBDa5u3XHFmMh7KiKgZcYmOdaWZtGaMYQaK3LUb9bSXwpQE+ebPOClfX+d2ZMhM6NKZZextPhImpjJ6EMXzHqDMayuLm/mAv6GbyH1ugJ8sjcQiCKgPxpB1BHQjLOcLcfBiBaVbvIfpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168506; c=relaxed/simple;
	bh=sofJnMZcl8hQjOX/gFTKlCCw6YYdT3jB7PUh6wxX4R8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PM1mZeRAaveSWLOPiEshWMWAya3vFsI3FH91Sa73IunK4EqmrZ7c5FUPsjPT09AvaqJxZGlAVPZrvBRNwaCaL/dkD+cVVfKeYfZe6JAMVjFCJv/mxijM55+UvgsIkVJKcZxoT8YkpWNy99MyFtt3xExzyBIxYfXmNR6WdJCp8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IoK//gjw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc96f64c10so4033545ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709168503; x=1709773303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SchlyZ4UU3SdoafkJQBbnMQVK65WVY/e6Ayv+xuGpWo=;
        b=IoK//gjwUiOYb+Esw9RAZOx+xHR2i6F6M60HewrN4Y9wqUNIhItSeuomVlSMv5njr8
         xBCwfmj2MeMNjMwygSlWTcdPIQKwCw1pFBr/9hBIXS//Z9+k26vwEJiaDROnd9m8Mc1j
         xlQFM26aUOhs7Sm3c/vkTOtcx0WdxGQNgPzThhz7FnuUuc1/JecUSKYyKewVkEbZLW7C
         Y35p6IisI2y1GX4tMTLqktTCSqi9N7vhA6QO0QZsMFV+lqof5qFeLPhU5UtDwvTQGOG7
         ySg+bAxooi4via9On91x6aHO0EbY8CeLdpdMWgSKyygpNL1GiOynS8AvFtpcJSfFmbWy
         ITTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168503; x=1709773303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SchlyZ4UU3SdoafkJQBbnMQVK65WVY/e6Ayv+xuGpWo=;
        b=SORPgw1znNb9fA/ynTO0+CmhtmvV/WgoozASxR8DWSZe3U64xKkbBg2s4/jyPowXox
         X5Ibzj3ljCdccmzW3W9mH40LuXidBPcjRQKVQ3f61P75HSzQeI9HtErtmqJeVlRQa6G1
         BOTN92nOlOrq432h/TcazMZWrc5w4h6jYSJk/jlfZtvg1LxlKM90xFg0UCGQ8GKzzLhG
         UfxiMgFMAcCdaQ/DwVbvJlLf9CgUqE0UtcqWHafSo+xc5wUOlEHO520bcmzZRxMyRiWO
         4j3Jh4opFpV4D5hOfe+Y11HdVaSCzG/bFhBp7hXHDyhBLtdoHBdkKHeAVyUb/b/bxn3d
         pGmg==
X-Gm-Message-State: AOJu0YzBvydZk0+d4T/r//sVVz5dXyqQmtu3jAHkxJcQwRvmPSyQFy3y
	SY0iF9znMaboUgcVggUZUdPLaF5fq0pu3BjnBLpmZUzCTJmqCMKWVY0f4RsHeybPjolZ5Vh2jQ2
	h
X-Google-Smtp-Source: AGHT+IF8AP5yy874viGgSFlHQ/GFryEr73kxAAM+WTYHUlwXxC8mSK1Ci2PYhqwM33S+1LfQNiTK8g==
X-Received: by 2002:a17:902:f54f:b0:1dc:cb84:d8d5 with SMTP id h15-20020a170902f54f00b001dccb84d8d5mr788795plf.50.1709168503594;
        Wed, 28 Feb 2024 17:01:43 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc8d6a9d40sm78043plx.144.2024.02.28.17.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:01:43 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@atishpatra.org>,
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
Subject: [PATCH v4 01/15] RISC-V: Fix the typo in Scountovf CSR name
Date: Wed, 28 Feb 2024 17:01:16 -0800
Message-Id: <20240229010130.1380926-2-atishp@rivosinc.com>
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

The counter overflow CSR name is "scountovf" not "sscountovf".

Fix the csr name.

Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h         | 2 +-
 arch/riscv/include/asm/errata_list.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 510014051f5d..603e5a3c61f9 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -281,7 +281,7 @@
 #define CSR_HPMCOUNTER30H	0xc9e
 #define CSR_HPMCOUNTER31H	0xc9f
 
-#define CSR_SSCOUNTOVF		0xda0
+#define CSR_SCOUNTOVF		0xda0
 
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index ea33288f8a25..cd49eb025ddf 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -114,7 +114,7 @@ asm volatile(ALTERNATIVE(						\
 
 #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
 asm volatile(ALTERNATIVE(						\
-	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
+	"csrr %0, " __stringify(CSR_SCOUNTOVF),				\
 	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
 		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
 		CONFIG_ERRATA_THEAD_PMU)				\
-- 
2.34.1


