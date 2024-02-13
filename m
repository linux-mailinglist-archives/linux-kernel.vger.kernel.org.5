Return-Path: <linux-kernel+bounces-62914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C088527CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796D4284989
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D323101F1;
	Tue, 13 Feb 2024 03:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Uxs9ickc"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE5BAD2C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707795471; cv=none; b=aS1CulKG3wy7vImo/YeUnisML4mbrIE05iHEYd6p3bQ5DVlFR8RrLULJ6iqydaIZ6Quir6Ia5VQgm4ZaWuPXULA9V0KKkz06Os0RCCu+0r5tDq1rGbwZjEK8vNeNzH4hu9mMXzBcipMMlx3WR9V/E2usgoH4zfxa84A/LyARqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707795471; c=relaxed/simple;
	bh=SMCn7g12fMC2sDrQkk/bPAiYh0jF4g8+5rw2D33BJQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e41ybtwORMf7WK2+PFYcGfciCWf0pvK5DdRHVamrsV9gU1cnS1XF6D51ud1snfkVhKpvSAN2JcWRPwp+LzfdZCjdiHsNEnd1RwWtzLD371OZQI1CZYM4wA9tHE8f7H/kKWRWXVe4dq7K7kQ+wx8VQCasYzOu+Uk36aAhaK4IVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Uxs9ickc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e0fc87fc2dso27084b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707795469; x=1708400269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK79X93EtBW9qJrpk3LrvTi516ybVeRsHV0te+WOVM0=;
        b=Uxs9ickch7LGzdLRkWzSwGyM5NtdG0Jg99PABSkPo6fqeimF8pquOFC5+X83S8YpWg
         q9sHIW7ziNBEjoliIQRokMprDPT0IIxcXB/nokCTgleg4piXQlGbuXGNDya70/hVSASJ
         VL8c4OaXc4Lw3697jDAVBLyAegw+tIzX6715duXESRfqSzJ8omB6YTm/v4dagjzTjuSY
         oy6yoLnNc9k7ErVT/RAxeqfMZh1nAIQu+cycWITgbI+rW80jUEY8QWACI1eeepXFREv5
         fcv2NdM+ex6efqDPmyDU7MgxkvOVRmc1WODr2Pm5sxbKfyLXw03QwwCkH4BVYggXHsfL
         UJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707795469; x=1708400269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK79X93EtBW9qJrpk3LrvTi516ybVeRsHV0te+WOVM0=;
        b=WncrKR6OICs9chRxosjUZqNkcMz4qbHwjY5E9y/qIv/hfOE6qnZm35NZLAroki1jgB
         wmDMiOpihKfe5UHCU07K5/uDOH4ANm6iYU18hfiLLMhOtQ5Wjwf+TNHIOZ4RM911FKxd
         qYQAag2cDAbZEBSsIB8q+kUsxKgp3T1O/ym9GrMsTORL529TvuSzI9TpdvcYw2gst+fb
         ZKW8GsAiHio+PnVDYqU9sC7iKikNCBKFoIO/J3TdHUAi1FvR0CHHNvUK4erR15LuAanX
         JmOL/02gLpjGko9niDTOJ2bRd1RawYHP2T2sgTI6cG3Tkrv3sxQ3Zy4ddTkDBc1T8F+z
         67Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWrzbnL8//s65+LFmDEobu2FgX00X9eLp3f21jjE7lmAz1BHR8OQevuYr8QlVFw8yyIcdIII2g/3rrUvTfl6FRke3y3/uCvTFhrDcpv
X-Gm-Message-State: AOJu0Yxv4my7f5R/d0f+QQjOlunHDpRk8z4r7wmUw2d6FIjkn02PiYyQ
	yl71qLJFNjDmTj0W9Ek/sImZXzwvURJIHlRI/CuLeDnTwHi1/Ii0/kEOcazPVcSQoyG9Sk9M1V3
	2
X-Google-Smtp-Source: AGHT+IE1f48UdkFqKO1xCaun/zy54ImvbzLVNqfi6oeRp+4H1Zh+DSqHGiI3HcT/8D8HMS0DDClSGQ==
X-Received: by 2002:a05:6a00:189c:b0:6e0:31c4:3f09 with SMTP id x28-20020a056a00189c00b006e031c43f09mr9843628pfh.3.1707795469256;
        Mon, 12 Feb 2024 19:37:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU80nXNvG9IvTEkeb+gI3X5g1/YZ1z9f+aFTwEsVZd0YtQwmVXoa/KRvIon26KAt5cNSlHOeF71a2FjUjqRP5PAlJ+nc8CF55EDOUaiOA/PhkgZtMyNbXe6JSVbSCfvp7M3BnJ0NMLC4buORby3LxdT+OtSBYTQh5DYywQasxUalqsHQ7bHg8gdayxPwY7rNeHYSVcWKeeIrg6JNnJHFCh85OAs1TwkJJvw1jzosIxo0AzhuK8B
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006e0334e3dd9sm6188633pfu.76.2024.02.12.19.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 19:37:48 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH -fixes v2 3/4] riscv: Add ISA extension parsing for Sm and Ss
Date: Mon, 12 Feb 2024 19:37:34 -0800
Message-ID: <20240213033744.4069020-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213033744.4069020-1-samuel.holland@sifive.com>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, all extension version numbers were ignored. However, the
version number is important for these two extensions. The simplest way
to implement this is to use a separate bitmap bit for each supported
version, with each successive version implying all of the previous ones.
This allows alternatives and riscv_has_extension_[un]likely() to work
naturally.

To avoid duplicate extensions in /proc/cpuinfo, the new successor_id
field allows hiding all but the newest implemented version of an
extension.

Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 arch/riscv/include/asm/cpufeature.h |  1 +
 arch/riscv/include/asm/hwcap.h      |  8 ++++++
 arch/riscv/kernel/cpu.c             |  5 ++++
 arch/riscv/kernel/cpufeature.c      | 42 +++++++++++++++++++++++++----
 4 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 0bd11862b760..ac71384e7bc4 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -61,6 +61,7 @@ struct riscv_isa_ext_data {
 	const char *property;
 	const unsigned int *subset_ext_ids;
 	const unsigned int subset_ext_size;
+	const unsigned int successor_id;
 };
 
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5340f818746b..5b51aa1db15b 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -80,13 +80,21 @@
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
+#define RISCV_ISA_EXT_SM1p11		74
+#define RISCV_ISA_EXT_SM1p12		75
+#define RISCV_ISA_EXT_SS1p11		76
+#define RISCV_ISA_EXT_SS1p12		77
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
 
 #ifdef CONFIG_RISCV_M_MODE
+#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SM1p11
+#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SM1p12
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
 #else
+#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SS1p11
+#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SS1p12
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
 #endif
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index d11d6320fb0d..2e6b90ed0d51 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -215,6 +215,11 @@ static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
 		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
 			continue;
 
+		/* Only show the newest implemented version of an extension */
+		if (riscv_isa_ext[i].successor_id != RISCV_ISA_EXT_INVALID &&
+		    __riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].successor_id))
+			continue;
+
 		/* Only multi-letter extensions are split by underscores */
 		if (strnlen(riscv_isa_ext[i].name, 2) != 1)
 			seq_puts(f, "_");
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c5b13f7dd482..8e10b50120e9 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -113,23 +113,29 @@ static bool riscv_isa_extension_check(int id)
 	return true;
 }
 
-#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
+#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _successor) {	\
 	.name = #_name,								\
 	.property = #_name,							\
 	.id = _id,								\
 	.subset_ext_ids = _subset_exts,						\
-	.subset_ext_size = _subset_exts_size					\
+	.subset_ext_size = _subset_exts_size,					\
+	.successor_id = _successor,						\
 }
 
-#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
+#define __RISCV_ISA_EXT_DATA(_name, _id) \
+	_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, RISCV_ISA_EXT_INVALID)
 
 /* Used to declare pure "lasso" extension (Zk for instance) */
 #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
-	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
+	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, \
+			    _bundled_exts, ARRAY_SIZE(_bundled_exts), RISCV_ISA_EXT_INVALID)
 
 /* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
 #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
-	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
+	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), RISCV_ISA_EXT_INVALID)
+
+#define __RISCV_ISA_EXT_VERSION(_name, _id, _preds, _preds_size, _successor) \
+	_RISCV_ISA_EXT_DATA(_name, _id, _preds, _preds_size, _successor)
 
 static const unsigned int riscv_zk_bundled_exts[] = {
 	RISCV_ISA_EXT_ZBKB,
@@ -201,6 +207,16 @@ static const unsigned int riscv_zvbb_exts[] = {
 	RISCV_ISA_EXT_ZVKB
 };
 
+static const unsigned int riscv_sm_ext_versions[] = {
+	RISCV_ISA_EXT_SM1p11,
+	RISCV_ISA_EXT_SM1p12,
+};
+
+static const unsigned int riscv_ss_ext_versions[] = {
+	RISCV_ISA_EXT_SS1p11,
+	RISCV_ISA_EXT_SS1p12,
+};
+
 /*
  * The canonical order of ISA extension names in the ISA string is defined in
  * chapter 27 of the unprivileged specification.
@@ -299,8 +315,16 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
 	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
 	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
+	__RISCV_ISA_EXT_VERSION(sm1p11, RISCV_ISA_EXT_SM1p11, riscv_sm_ext_versions, 0,
+				RISCV_ISA_EXT_SM1p12),
+	__RISCV_ISA_EXT_VERSION(sm1p12, RISCV_ISA_EXT_SM1p12, riscv_sm_ext_versions, 1,
+				RISCV_ISA_EXT_INVALID),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
+	__RISCV_ISA_EXT_VERSION(ss1p11, RISCV_ISA_EXT_SS1p11, riscv_ss_ext_versions, 0,
+				RISCV_ISA_EXT_SS1p12),
+	__RISCV_ISA_EXT_VERSION(ss1p12, RISCV_ISA_EXT_SS1p12, riscv_ss_ext_versions, 1,
+				RISCV_ISA_EXT_INVALID),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
@@ -414,6 +438,14 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 				;
 
 			++ext_end;
+
+			/*
+			 * As a special case for the Sm and Ss extensions, where the version
+			 * number is important, include it in the extension name.
+			 */
+			if (ext_end - ext == 2 && tolower(ext[0]) == 's' &&
+			    (tolower(ext[1]) == 'm' || tolower(ext[1]) == 's'))
+				ext_end = isa;
 			break;
 		default:
 			/*
-- 
2.43.0


