Return-Path: <linux-kernel+bounces-139556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D958A045C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DAA1C21BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073D8C13;
	Thu, 11 Apr 2024 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vsPMk+2X"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA752563
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794092; cv=none; b=Kkrhk1KNK/zNQRsD2DhMvYy6Ok9Pmfx01Pp9BOIEaVH6ZSHmYpq8uzFMd6d0b0q25Th5V4/O6VcnFp3R1sWpSRpnMriK3HjzC68RucOk0HD6xSD1K2rsBnGsYVOihbWZKxmeyLii9RSgN0WO3/HcV8NXcEbKaLNIZN8e/F4Vbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794092; c=relaxed/simple;
	bh=QPSBE9QZ9I3ka5tiVYaLmRJclnGfjz8CpXpruGJQvzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fruvP1J0AmCnwTZCv1Q2Dy9wWWQQy81FyE7AZDyDGJ3sebG/ORsoCxO8WVlf/SeEzEg92rFzHt41LegmUp/3mCapBhEpInaE9vEfDLqAqpfxe1NK+C+9zHa3dxAgiNWygIl1FCs8UQ+nEZ4X9G4uSXMcrTILNyYgQmAmRTgjADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vsPMk+2X; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so4133585b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794090; x=1713398890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk9dPs2pdPMy/ouYyBMSDOPD1OQUOIvovvehkpc98kM=;
        b=vsPMk+2X2FVx90FlD6FnN68OKmY238Yr+X/4CiKXJu9dSsSIaGu8tbpCvJUXlwvDs/
         KI0SMLwAFWFB+cGVoF6Pll60QRcWC2x0TVTATbZADCQQ1ALIMhXQ+LPchyTIQhmn6Umi
         535lEJ0/sWeRny5fcbTfm19hNt8Pv8J7DhCqbHp3dQ4O8tuqYmXZW/pwJ1DwwJ/xwOVn
         OldY6nW6FkWvHJG49ZeRpSPbD0Nl7xC8czvtt4lTNqzm4JbAf2p6hyo2nMUtTVU5iu4v
         cNzGeI6k5mKVEWyOYDVuL5CtYVc9H4N08L9/XHil4Iiv08DOSRvBDU2PveC26bvyk0VT
         kFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794090; x=1713398890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk9dPs2pdPMy/ouYyBMSDOPD1OQUOIvovvehkpc98kM=;
        b=IqzLWLU6+uPm4UbWPwPN3ckN82d8n/1l6I2RRnlVAivHzEvVUzuhCDJLMoOKRP0TKQ
         63+gVJVEgl1Uaeohj8CleR4yIQyXWIG14ZL0bTyNcu+0cccY/hOihSRVIWh1kAqFH2ti
         1Y+RLCMu1HuGaeq8nPpUawo2tPlUD9CkQV3ISw4ppZMKk751Nzix1rFb1L8eRcGO534N
         RG/5d6tVZ647tC2BEW/f5bph+j8KrWzxVl4sI1VzKmIUxGepmfg4HkD+6K6GwMTyzT6+
         J+XD5nPIGnzvVKN/YmSHKtH8RwKdOoZjGM5Fb+CHwq41f0YUBLHAXCV83oyQ6VrTKQh4
         XnuQ==
X-Gm-Message-State: AOJu0YwL3qaqcNQ20NjyrZYFzFW1ttAZcnD5SsEI6hOMrCnUUxulD7/H
	ErBSDgOEr5o7lVR7D3U6lc4UAGB5x3wxiD038V+j4MrCqbjsKP0YbP5N8hhdH4ZpEpd9P37/LYj
	5
X-Google-Smtp-Source: AGHT+IEUlLK4WAkAvm3dQl//UcwbrhAG4hAU1Ze/VITIGy9xvn1rUCggLrBxo4kkHL3eR04eJnJL9Q==
X-Received: by 2002:a05:6a20:2d06:b0:1a9:4343:7649 with SMTP id g6-20020a056a202d0600b001a943437649mr5367555pzl.56.1712794089923;
        Wed, 10 Apr 2024 17:08:09 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:08 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 01/24] RISC-V: Fix the typo in Scountovf CSR name
Date: Wed, 10 Apr 2024 17:07:29 -0700
Message-Id: <20240411000752.955910-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The counter overflow CSR name is "scountovf" not "sscountovf".

Fix the csr name.

Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 2 +-
 drivers/perf/riscv_pmu_sbi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2468c55933cd..9d1b07932794 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -281,7 +281,7 @@
 #define CSR_HPMCOUNTER30H	0xc9e
 #define CSR_HPMCOUNTER31H	0xc9f
 
-#define CSR_SSCOUNTOVF		0xda0
+#define CSR_SCOUNTOVF		0xda0
 
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8cbe6e5f9c39..3e44d2fb8bf8 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -27,7 +27,7 @@
 
 #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
 asm volatile(ALTERNATIVE_2(						\
-	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
+	"csrr %0, " __stringify(CSR_SCOUNTOVF),				\
 	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
 		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
 		CONFIG_ERRATA_THEAD_PMU,				\
-- 
2.34.1


