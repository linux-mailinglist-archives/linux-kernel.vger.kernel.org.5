Return-Path: <linux-kernel+bounces-138235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D989EE89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE6DB2376C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6BC15F3F7;
	Wed, 10 Apr 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rURAKkLA"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C115ECD7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740286; cv=none; b=rChwYmCar19fil8m+2XwPMUnFow9C4maXdTRPyst2UXRoZRQvMziiUgOy29jZs/fi4YnFEfMSpv4TwsRk/OtWQVCLmHA+HqrONb82Zdv0ECEW0geVpDcSQDbri+Ywcnyl9POoRcRSaO2B0j5js3CZmtxv9D+8o0CwyK9eVQp+Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740286; c=relaxed/simple;
	bh=VBYIkTZIleyOsUo3Vs7GTW09WzwtONhQK0/AstEMTYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQ3fX+blUQKJQJpjsYfb14OrHfSmt9gm1Q5EeTnRwEv1A0yBPkWDeAG6XbnUNPeO+7ZPSRXqNzwhPEvqhvySOmGZ6nrMTK1SolFZIfTuAYRUibUe0GSYX0p8WMPmEhxZ9qmYSJ9ZucseDwvPwc8akcdaDR5LTynwAv89YAOapbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rURAKkLA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346407b8c9aso516613f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712740281; x=1713345081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdCfPjm06PN8DLWdVlWU7iGB8QhHqS8f5T3HQCXkkpY=;
        b=rURAKkLAJayoYMZmBWpG7FHBtQg6jl2K3leOahNRXDAY4m33zhBke182MWQowzMAMe
         PAblFOE+HRE2eqyemvWVgZ+8Bdv3qYrtIOEpB34q2y8ksesCErcBIk+a6S+aWEq80YWr
         T5R5Iam5LQYimS+hduyUboWljva20ji5R42Br+Gt3HmpMH/pVA3d6i8dNPp7VU0vHKav
         dJXCFsivvEFUuKs5CPEseJKheKF+96hKMT0JkdIe5Rn+b4BnaP7UJsvt2/mWdBegQVSu
         epKKZezClXlaVZ6pH5sEvdwFQjL+kmsxX+3QBGvzmtHRcrmiiJv9kALNXnizz0OdMCkz
         v+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740281; x=1713345081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdCfPjm06PN8DLWdVlWU7iGB8QhHqS8f5T3HQCXkkpY=;
        b=D7JBko3EDX5IrJvKL5WNAbiT9bLpWZojHpPT2BvPivIyw5eQwOVkNc2T81pVKYgqKJ
         HDAF3Wt4QgGsjYnE6IkHO3THDojjxpZt55qWt7wUNNq1L8B7kog78qrRzELniMvUg4MZ
         +4GE42qyD1aNfNlNhPMqIQq1eODUI6D3RfvmKBkKUrfGE21AEbBzpRPP8gqM5keNJ4nL
         XTTU0cLf13sfJczh9HmD5Q1IgV3rzHhKJS9yDnl6iYy5/pWIaGRPgAvKULIq5B16ovkl
         f2XzqCK3q7gLp8qAq6mMs+U5OK829hRwiY2xD9Uz8U3vTnsNms7NWjeGppcD4dFMDdgW
         X8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgmG4rprc6mZKxD+X5C8b1VN8Bc0oy/AOBB7N2roE1uyXorKRznUCkwhsGdBriH9RwGgoaMBSLMM5/pEjNC5Zu1OrDxyzFcsGYacgC
X-Gm-Message-State: AOJu0Yy9fQl0Desgi9YfaIYvLZWe+oDNfv0gsjmvWOsSmNRx+gTVKhL5
	GvQrKrXYrl0LIPr4ueZWd/7SiawGMC/V//F2byl1hQDqF02rjnv5PboCfrh10AM=
X-Google-Smtp-Source: AGHT+IFQJ5p7pLG6t5Azs3+BcKGV7vPPdom5bcR5KV8gVA1LUcuSXTuOIz79sOe0bN9WIkFT5A1jwg==
X-Received: by 2002:a5d:47a4:0:b0:343:39d8:bf3a with SMTP id 4-20020a5d47a4000000b0034339d8bf3amr1645951wrb.4.1712740281298;
        Wed, 10 Apr 2024 02:11:21 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003456c693fa4sm9079086wrx.93.2024.04.10.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:11:20 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 08/10] riscv: hwprobe: export Zcmop ISA extension
Date: Wed, 10 Apr 2024 11:11:01 +0200
Message-ID: <20240410091106.749233-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410091106.749233-1-cleger@rivosinc.com>
References: <20240410091106.749233-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export Zcmop ISA extension through hwprobe.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 4 ++++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index bf96b4e8ba3b..e3187659a077 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -212,6 +212,10 @@ The following keys are defined:
        ("Zcf doesn't exist on RV64 as it contains no instructions") of
        riscv-code-size-reduction.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZCMOP`: The Zcmop May-Be-Operations extension is
+       supported as defined in the RISC-V ISA manual starting from commit
+       c732a4f39a4 ("Zcmop is ratified/1.0").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index dd4ad77faf49..d97ac5436447 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -64,6 +64,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCB		(1ULL << 38)
 #define		RISCV_HWPROBE_EXT_ZCD		(1ULL << 39)
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 40)
+#define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 41)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 2ffa0fe5101e..9457231bd1c0 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -114,6 +114,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZIMOP);
 		EXT_KEY(ZCA);
 		EXT_KEY(ZCB);
+		EXT_KEY(ZCMOP);
 
 		if (has_vector()) {
 			EXT_KEY(ZVBB);
-- 
2.43.0


