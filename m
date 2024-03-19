Return-Path: <linux-kernel+bounces-108167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14945880708
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2CD284824
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450135A78E;
	Tue, 19 Mar 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Wy6ouxak"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206524F206
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885561; cv=none; b=dN1eDNI230mjwM0M40KDQaCWNoDDn0EXo7/CKCZhmmWptlTT/BnnYfCMYZeYSQv/1Skid/sBXlWEbyEnKR9ws2oSGBoEdkWui9NVlxHzaDaPjN2nka/MTgqy3ehWi/QSg3gYcwYm4WRKU5fovGZdyio5NV2QCoSXA+7/l+Sz09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885561; c=relaxed/simple;
	bh=kAR0DtDOBT+X3Ohv9I8L8o3jkb/tW/yP6d8rUFDrFog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBS6OI+RpucSfo7pTh+pxgi9p9sRHAg4CVnE0pObZd5u92l7q6GNz65VuxE/hIXZfRD/SPgz89LgnNjCRbHTH3aeIAy677FvXV5aT3uf1rmyNoM3mJgjvH52wi6yaP7SUpRas8uWk/E6TlhMw+kWNOggg0na996+QXo+Xa76KWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Wy6ouxak; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so4683400b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710885559; x=1711490359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egqW9CgCHR/h+XnNBIYYSLcc7kf3PBZY4lOdjowA6vA=;
        b=Wy6ouxakPyhqgssdMf0ecXwPbn/60j2b7LQ5/VCh3otGpaEH2AVu4jDV14ur1K6klo
         mVCBoB33JXEcmlJKezmN+mj95WdUXUakBLinw1dgiY/UI5hRh2JGH8Lf9UplCLuLXxhM
         jjhdvSgSFynB27KKXed/sEWTB7pWK6j8RVfSzk+4qMCEeh8Gm+RGpko8daYh0sbFfOMr
         6RVbAz/O1EIQfQrk7/h88Ql2013I8aUHSZtEbLCevuuKknTSOwCgL8xVYXvnR1dy2IVF
         heN6OuxBnFVmhrVJve73Ge++z0L6s3EKGkVTuW2A6KnLAzECjLHH7bGIZh7vkBVN+Yj2
         zZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710885559; x=1711490359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egqW9CgCHR/h+XnNBIYYSLcc7kf3PBZY4lOdjowA6vA=;
        b=Ev7lz3Z/4CkW1rqElu8RypnavMMbiTR+1mP82eT8Znocf0oT+XOV3GJH+puEko7HiS
         ZdNDd85ZErjUVn9Xw4tFi8Ri59/dk33xgXZK0qCAGBRNl9YTtEzlvK8639XKR1CjRw5m
         2wKYWUPDgp6ZPuIF5t1p58eMoMMazT+IhkRz0rKgLcY+URx1uPyMT1AqXFe+3BMe6URl
         EAGEPSYDjQ0YFJfim7jwrnXSSel8XHvkf/9cCX0GLBi0lWDWYGrl12/KAPalLt7O/ZUW
         upW6Jvx2Lk/d6hm8J68V9854Xma/wDNwSCT/XntW1F21zgTUP7JgO0a3XgoPMUgk5J+3
         Rt6g==
X-Forwarded-Encrypted: i=1; AJvYcCWIEWDj6a51LXK5pD2fTDXXsWY/eeBnaphSCDeY+wsmgqPcZWVNMkWMDWSTyyjNaeSqRmGvyI14cwNOGumBWGvPN7k0cakl3cV+RWOo
X-Gm-Message-State: AOJu0YxhSyLPpnHHUQLnmq4iO4fUdlx8UpGGk0l+vTXrNJG9p2NBzwvG
	2cFfz136SAd9OVDpqBH0A7llUhoblo+JDgGS+/Q8h0NeVe5TlBmzVR7QK4oCcV0=
X-Google-Smtp-Source: AGHT+IHiAdEaZGvoCjNSk/dkwDMZl0Qwbws/pc2s32fXcllKuOrTTy4J+408sRjDB0ufVB39xHFOUg==
X-Received: by 2002:a05:6a20:9f8f:b0:1a3:60cb:8172 with SMTP id mm15-20020a056a209f8f00b001a360cb8172mr9089470pzb.39.1710885559375;
        Tue, 19 Mar 2024 14:59:19 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006e6c61b264bsm10273892pfn.32.2024.03.19.14.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:59:19 -0700 (PDT)
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
	Andrew Jones <ajones@ventanamicro.com>
Subject: [RFC PATCH 2/9] riscv: Add ISA extension parsing for pointer masking
Date: Tue, 19 Mar 2024 14:58:28 -0700
Message-ID: <20240319215915.832127-3-samuel.holland@sifive.com>
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

The RISC-V Pointer Masking specification defines three extensions:
Smmpm, Smnpm, and Ssnpm. Add support for parsing each of them.

Smmpm implies the existence of the mseccfg CSR. As it is the only user
of this CSR so far, there is no need for an Xlinuxmseccfg extension.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/hwcap.h | 5 +++++
 arch/riscv/kernel/cpufeature.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 1f2d2599c655..1a21dfc47f08 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -80,6 +80,9 @@
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
+#define RISCV_ISA_EXT_SMMPM		74
+#define RISCV_ISA_EXT_SMNPM		75
+#define RISCV_ISA_EXT_SSNPM		76
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
@@ -88,8 +91,10 @@
 
 #ifdef CONFIG_RISCV_M_MODE
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
+#define RISCV_ISA_EXT_SxNPM		RISCV_ISA_EXT_SMNPM
 #else
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
+#define RISCV_ISA_EXT_SxNPM		RISCV_ISA_EXT_SSNPM
 #endif
 
 #endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 79a5a35fab96..d1846aab1f78 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -311,9 +311,12 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
 	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
+	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
-- 
2.43.1


