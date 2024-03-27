Return-Path: <linux-kernel+bounces-121944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD2388EFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057061F3142B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D244315445C;
	Wed, 27 Mar 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WXTcuH8u"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200B153BFC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569736; cv=none; b=KPUAX2zJ9G4M1/c1sGNbHr1GYcsQvQUwHyN0kxb9Q2ogHbspTUU/sH9u6fgj4u33band9AOZK1lle6dDPYBnCFOKMt495SK0iFRxhT7x8R/LYoofTf9NM6Sm9Weh5Xd0niJWFHDfYcZoU8RhMVovL/5cEoE16z60ZmCk1gVf1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569736; c=relaxed/simple;
	bh=91qMtAnZtTeg2i7QDjR/G11+PwQHwDTtJmPnZfMaIks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frTmfFEugeve8drbntCOy7TPniY+9Gkp/G5XzYbZcD+Nw5AO5J49t3EkJxV4MsV2560f8Oh0WQ63eKrdZNMeTLf7iMX79SnLkcWG5YBD95SBkjxkaAoOKL0HLt7J3//tROzR2e8Jiq/TbiK/yensAf1ldlYEF/J9bHJwExrFaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WXTcuH8u; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0bec01232so2084635ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569734; x=1712174534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kt5T6f5KKlAqEBrctbVWHiZ4yWz8xGfDOuoPShtqdto=;
        b=WXTcuH8uUzuIGT/od+Pd8SV6DHBLHYq6QrHDL02qsGiRffe0oX3Jpkfs+M46K7JwfD
         WRsTlx6HRVC7APzTJW/wRCnrTd5GXjwlg7v0uFo+TfKce6H1BoQ8B8svLFUdK9BEYKVr
         Ic1RYgatbgyzR68zJCvF39324ViwBqzBhx0dvzYyCpb6qJKhijMhAtAzRiGmi02FS+kj
         eF9k18UeRb7P8ff3pjkI3DiSxFBI0hkr6wZkgltf7ZC1QnOPkVKWs+gdneJDEWXExaxE
         RuLRzMJAS1KkJ+B/qHgk3o9K/8UJAC6E/Q4KLxlgr/zXJ7wegzC3XueOJoJ6hL4f+Kg5
         +PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569734; x=1712174534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kt5T6f5KKlAqEBrctbVWHiZ4yWz8xGfDOuoPShtqdto=;
        b=cp7mHXMLxA+ijdvVIQPBlUc9/lDccRnAqtXusbKJEC+EeguppX3Td6dj8dJtoc/fQ4
         a0BiVlw8groKiat6lu1lQAOi+cSxYGhv0NreVIiIFj0VVOcpFahvo9XcuGQzLPDiihmr
         M2DGcRH+Uxmwtl7ezEj4R7pQXBVmX/uhdtmMKdGtTWKsjS+qNgCNeDfGbJtIYT3Inu19
         27Xk8Cw1mprk9vky9A+qp8vl9HnaH+X9KJpvBO0mYiaSqYC+upgM3e4ugkJjzeWEWSAm
         T0HQ9dYxsq5+y68LhJOBrWe2WRgVPFTZKxIh3S1Daytu29LVJ0RneB4Kn/pwd1a3Zp/N
         I07A==
X-Gm-Message-State: AOJu0YwngoOpyXnPBgnwVpVXYQr7cxL+F+rDMN/RB0gwef3HJWW4bWRy
	n+Tw03xFGwDnSIyu81KaSY8aqcmQvuU+s0chIgbw28hwIo5DBeuxuMNko3b3Nzp5V495dRKxSKh
	r
X-Google-Smtp-Source: AGHT+IGvbXfMD3NpHBvc61C4JrxkXrP2UbmyeCXEZSqIACFIDKyEi0FLcpBAl7w+qDDaJ12IbzUk9g==
X-Received: by 2002:a17:903:1211:b0:1e0:afa0:cc9c with SMTP id l17-20020a170903121100b001e0afa0cc9cmr851093plh.2.1711569733842;
        Wed, 27 Mar 2024 13:02:13 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:13 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alex Deucher <alexander.deucher@amd.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 11/14] drm/amd/display: Only use hard-float, not altivec on powerpc
Date: Wed, 27 Mar 2024 13:00:42 -0700
Message-ID: <20240327200157.1097089-12-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327200157.1097089-1-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

The compiler flags enable altivec, but that is not required; hard-float
is sufficient for the code to build and function.

Drop altivec from the compiler flags and adjust the enable/disable code
to only enable FPU use.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 12 ++----------
 drivers/gpu/drm/amd/display/dc/dml/Makefile    |  2 +-
 drivers/gpu/drm/amd/display/dc/dml2/Makefile   |  2 +-
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 4ae4720535a5..0de16796466b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -92,11 +92,7 @@ void dc_fpu_begin(const char *function_name, const int line)
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_begin();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP))
-			enable_kernel_vsx();
-		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
-			enable_kernel_altivec();
-		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
+		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			enable_kernel_fp();
 #elif defined(CONFIG_ARM64)
 		kernel_neon_begin();
@@ -125,11 +121,7 @@ void dc_fpu_end(const char *function_name, const int line)
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_end();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP))
-			disable_kernel_vsx();
-		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
-			disable_kernel_altivec();
-		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
+		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			disable_kernel_fp();
 #elif defined(CONFIG_ARM64)
 		kernel_neon_end();
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index c4a5efd2dda5..59d3972341d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -31,7 +31,7 @@ dml_ccflags := $(dml_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64
-dml_ccflags := -mhard-float -maltivec
+dml_ccflags := -mhard-float
 endif
 
 ifdef CONFIG_ARM64
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index acff3449b8d7..7b51364084b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -30,7 +30,7 @@ dml2_ccflags := $(dml2_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64
-dml2_ccflags := -mhard-float -maltivec
+dml2_ccflags := -mhard-float
 endif
 
 ifdef CONFIG_ARM64
-- 
2.43.1


