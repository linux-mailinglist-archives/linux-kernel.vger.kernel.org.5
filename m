Return-Path: <linux-kernel+bounces-84580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AF886A897
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6AA1C24054
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B9B24B34;
	Wed, 28 Feb 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fnl/Tedv"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DED522F0E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709103367; cv=none; b=TTcWmYqxf0tbDHMCc5vo0mWWhpRCZ4NGXc1534Mo1Y3878sYB+bNj0aGIVxzmVtLQS1dAICWQ7f7wVD2ACn3fKZKwd7BeNLmXP+YHH1aNniWKdYttNRioW5R9xmoWtFeDXirzDx1Wnpw5BAQ/aGTWnWFGTeOp3tuwNex3IaT6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709103367; c=relaxed/simple;
	bh=xTb1dPQYXT3wKImjGSHyQAkc7DbxWJHBELId/zBPW5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8hvC+uPbJsFcz3i5FbPoy8fnpyNBM/ElY376r/wlr2XPgVrknFaxGTfSeu/XLG9bGsjFGH1tYoaa7KXhIWRxrogoDi8+xUptww9PL76U3Ll+X7t2lLTa7sI/IcINptc37BilXFEM7EiOL/nqwFwkH0f+r5/MLOnSiVfeiNvgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fnl/Tedv; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e47498f4a2so2433639a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709103364; x=1709708164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nifjTiVnKPzVz5Xx9U5qG6fvYEiI7lPtCucGoxbvIpQ=;
        b=fnl/TedvuLO5jBuqUWMTFKeYfTLwox8KspHIhvPDNwfkC4XTzen70LHw6uipOkkTf1
         1B3tY2ZNoeNDEH+KHIg0JabKJbfu/CjD2cAut7PJXKFzYKyy0QXP4MWoLxKUpVhqHfdt
         CWfXcCNLyQDK7lgQIxMuXytytd8VDEuLSuXu2uh/7lI/liZGY18blcizpLBur0587Ki/
         rg36oPMby7JVhVpFtmOQ3zJsOhlE3GmK64gH4ceqS1aJY1sNsxt3gxNo6msfp8qE80tg
         flILJNy7fEM06EuGU1kxUBN1lCbj+ycTgx1nNDZDqVfLQEe6mpy5E+D/SwJhOlSYB1h0
         sLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709103364; x=1709708164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nifjTiVnKPzVz5Xx9U5qG6fvYEiI7lPtCucGoxbvIpQ=;
        b=vYJMDUPztEh85nkARKNsBdrDRIuLejef1ZSFkbNLyB25U/0I7dYFNiQbv7ztwkVLUA
         QnQjD5VupCBhGb0IdeCMdfhXYBC7U0VIRNgJSgCZUpf9mjGyBY29hIB47DcPXtlgYH5v
         ICOf6L9uGusNDb9RLLDmb6n+D6kpnL8IOiRezTYYJ8snGXW9Jm08vEDQ5tfi/JjTQ1YC
         KVI3QBA04cWsFkwHA6PlaxB2SxMIt4Kp6soaVGGxh3ssjdXA+JcIaWFjkoa9EmoYSO0V
         PhGyJ/uB3d7VvgmT/V45/6Ph5S9B5CilgyvBHi0AXTZ7WVslbyier1NkaZY649+nWady
         lOsA==
X-Forwarded-Encrypted: i=1; AJvYcCX1EvVvL9sUPUvUYW9b0mTyo1p3Ou6GHuNMZScRRrzhK5zPxlaQ9R9SZwwgbaX8yAOlHPWYPV2f9Oiauk5Em/3LocR5kp6IGqXTmmpL
X-Gm-Message-State: AOJu0Yy5D+XX0FhcAMS1Xk+dtsHWfaysXICiVdgUJuD8HErXCgDXWH9y
	O6E4gFy6eZFf6BdOF5WDB7nWCh8k0gy4XaDWVEJOfrzfQ5c9e7TVCRubLXg86wo+UYl+qEiVVX1
	H
X-Google-Smtp-Source: AGHT+IH4U8aBkFA2SKkKEolatXoRyjbjHcx5laQ73wGPgxVUxDCeFNHOySd/fRV8xKBko/SIfS+RIA==
X-Received: by 2002:a05:6870:e2d3:b0:21f:aa70:4c2b with SMTP id w19-20020a056870e2d300b0021faa704c2bmr13648589oad.12.1709103364136;
        Tue, 27 Feb 2024 22:56:04 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e12-20020a62aa0c000000b006e5590729aasm1010112pff.89.2024.02.27.22.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 22:56:03 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH -fixes v4 2/3] riscv: Add a custom ISA extension for the [ms]envcfg CSR
Date: Tue, 27 Feb 2024 22:55:34 -0800
Message-ID: <20240228065559.3434837-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240228065559.3434837-1-samuel.holland@sifive.com>
References: <20240228065559.3434837-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The [ms]envcfg CSR was added in version 1.12 of the RISC-V privileged
ISA (aka S[ms]1p12). However, bits in this CSR are defined by several
other extensions which may be implemented separately from any particular
version of the privileged ISA (for example, some unrelated errata may
prevent an implementation from claiming conformance with Ss1p12). As a
result, Linux cannot simply use the privileged ISA version to determine
if the CSR is present. It must also check if any of these other
extensions are implemented. It also cannot probe the existence of the
CSR at runtime, because Linux does not require Sstrict, so (in the
absence of additional information) it cannot know if a CSR at that
address is [ms]envcfg or part of some non-conforming vendor extension.

Since there are several standard extensions that imply the existence of
the [ms]envcfg CSR, it becomes unwieldy to check for all of them
wherever the CSR is accessed. Instead, define a custom Xlinuxenvcfg ISA
extension bit that is implied by the other extensions and denotes that
the CSR exists as defined in the privileged ISA, containing at least one
of the fields common between menvcfg and senvcfg.

This extension does not need to be parsed from the devicetree or ISA
string because it can only be implemented as a subset of some other
standard extension.

Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - New patch for v4

 arch/riscv/include/asm/hwcap.h |  2 ++
 arch/riscv/kernel/cpufeature.c | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5340f818746b..1f2d2599c655 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,8 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 
+#define RISCV_ISA_EXT_XLINUXENVCFG	127
+
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c5b13f7dd482..dacffef68ce2 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -201,6 +201,16 @@ static const unsigned int riscv_zvbb_exts[] = {
 	RISCV_ISA_EXT_ZVKB
 };
 
+/*
+ * While the [ms]envcfg CSRs were not defined until version 1.12 of the RISC-V
+ * privileged ISA, the existence of the CSRs is implied by any extension which
+ * specifies [ms]envcfg bit(s). Hence, we define a custom ISA extension for the
+ * existence of the CSR, and treat it as a subset of those other extensions.
+ */
+static const unsigned int riscv_xlinuxenvcfg_exts[] = {
+	RISCV_ISA_EXT_XLINUXENVCFG
+};
+
 /*
  * The canonical order of ISA extension names in the ISA string is defined in
  * chapter 27 of the unprivileged specification.
@@ -250,8 +260,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
 	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
-	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
-	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
+	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
-- 
2.43.1


