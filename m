Return-Path: <linux-kernel+bounces-101998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30D87AD74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9F31F2AF19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449614AD0C;
	Wed, 13 Mar 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV5hAjE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9FA14A4E1;
	Wed, 13 Mar 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348210; cv=none; b=CKkJAy0A7OczjkSYVlSDEjQpPA8rLyk4eK2aiWEAz9y6GrqMOUFT38p7hEqhJM5Ro+Dg32pl7z2RlpsHgw57jTWb9gXrvXgwwbAEUeUZId45JWVUPgyApk7DDq9uWeyvjP0oeLXUG3NbmLI6B/po4xd8fCLkh96WqUDIH3h3KQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348210; c=relaxed/simple;
	bh=83vlgMjnqg6tqbJqt+QGuUIjPsYAVxfIo9ttAP0BEtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxaIHlCWOD/hi1T5PIfmRutbZTFWiw3Lnxe2Dc7rJSgzzfu0rzWEe66U+sgORmxD0fu57bjemu2H26uXJuMOHza4npds2nk4Wmrz0QNhS8j52UYW814YZHbopfBmEDibWNMYfeXIVhjHSKcHey4P0UbDVLWueu58XY1n6muqrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV5hAjE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20117C433F1;
	Wed, 13 Mar 2024 16:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348209;
	bh=83vlgMjnqg6tqbJqt+QGuUIjPsYAVxfIo9ttAP0BEtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fV5hAjE+tONfKljMLrw8OFh3F2jlgLUY3qVqiNutO1ga2KOmRj+c6+ivAJlc/vtRO
	 VR0mnoboujmvKfM2zCuWE3pmiZ/PSbXDryhYoIUnskYejH8GIwNCHShy6Iv9N2zqwX
	 YorYip1E1KZbrDyWxqRuVeKkhZSefA/xeKpbl1t4SY4Us+zHwCzM7WTr7HNwpUT7th
	 uKgxFWDfjQWFq9XeyNsT3Ikgl4Mh9r9l3osgK3B4LgUSYBrGVwpWQBJVaCX0jxqUOw
	 iNMjbNrHVU+ZoXAb1m9ypwy9sAZ5LNkEvly5rpW/bAATjr2Ny5WFcQBeij+uEKpqgs
	 4KLsTdoHhbUsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Isabella Basso <isabbasso@riseup.net>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 57/76] drm/amd/display: move calcs folder into DML
Date: Wed, 13 Mar 2024 12:42:04 -0400
Message-ID: <20240313164223.615640-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Isabella Basso <isabbasso@riseup.net>

[ Upstream commit 552b7cb0eed12c184b3bdfcc262e96a954a2bc86 ]

The calcs folder has FPU code on it, which should be isolated inside the
DML folder as per https://patchwork.freedesktop.org/series/93042/.

This commit aims single-handedly to correct the location of such FPU
code and does not refactor any functions.

Changes since v2:
- Corrected problems to compile when DCN was disabled.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Isabella Basso <isabbasso@riseup.net>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: e63e35f0164c ("drm/amd/display: Increase frame-larger-than for all display_mode_vba files")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  4 +-
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 68 -------------------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 10 ++-
 .../amd/display/dc/{ => dml}/calcs/bw_fixed.c |  0
 .../display/dc/{ => dml}/calcs/calcs_logger.h |  0
 .../display/dc/{ => dml}/calcs/custom_float.c |  0
 .../display/dc/{ => dml}/calcs/dce_calcs.c    |  0
 .../dc/{ => dml}/calcs/dcn_calc_auto.c        |  0
 .../dc/{ => dml}/calcs/dcn_calc_auto.h        |  0
 .../dc/{ => dml}/calcs/dcn_calc_math.c        |  0
 .../display/dc/{ => dml}/calcs/dcn_calcs.c    |  0
 11 files changed, 11 insertions(+), 71 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/calcs/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/bw_fixed.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/calcs_logger.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/custom_float.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dce_calcs.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calc_auto.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calc_auto.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calc_math.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calcs.c (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 943fcb164876c..d82574f379119 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -23,12 +23,12 @@
 # Makefile for Display Core (dc) component.
 #
 
-DC_LIBS = basics bios calcs clk_mgr dce gpio irq virtual
+DC_LIBS = basics bios clk_mgr dce dml gpio irq virtual
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 DC_LIBS += dcn20
 DC_LIBS += dsc
-DC_LIBS += dcn10 dml
+DC_LIBS += dcn10
 DC_LIBS += dcn21
 DC_LIBS += dcn30
 DC_LIBS += dcn301
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
deleted file mode 100644
index f3c00f479e1cb..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ /dev/null
@@ -1,68 +0,0 @@
-#
-# Copyright 2017 Advanced Micro Devices, Inc.
-# Copyright 2019 Raptor Engineering, LLC
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
-# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-# OTHER DEALINGS IN THE SOFTWARE.
-#
-#
-# Makefile for the 'calcs' sub-component of DAL.
-# It calculates Bandwidth and Watermarks values for HW programming
-#
-
-ifdef CONFIG_X86
-calcs_ccflags := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-calcs_ccflags := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-calcs_ccflags += -mpreferred-stack-boundary=4
-else
-calcs_ccflags += -msse2
-endif
-endif
-
-CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calcs.o := $(calcs_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o := $(calcs_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calcs.o := $(calcs_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o := $(calcs_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o := $(calcs_rcflags)
-
-BW_CALCS = dce_calcs.o bw_fixed.o custom_float.o
-
-ifdef CONFIG_DRM_AMD_DC_DCN
-BW_CALCS += dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o
-endif
-
-AMD_DAL_BW_CALCS = $(addprefix $(AMDDALPATH)/dc/calcs/,$(BW_CALCS))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_BW_CALCS)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index e7bb69ec99b66..c97fdfc36d0fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -72,6 +72,9 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(fram
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
@@ -91,10 +94,14 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
 
-DML = display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
+DML = calcs/dce_calcs.o calcs/custom_float.o calcs/bw_fixed.o
 
 ifdef CONFIG_DRM_AMD_DC_DCN
+DML += display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o
 DML += dcn20/dcn20_fpu.o
 DML += display_mode_vba.o dcn20/display_rq_dlg_calc_20.o dcn20/display_mode_vba_20.o
 DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
@@ -102,6 +109,7 @@ DML += dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
 DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
 DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
 DML += dsc/rc_calc_fpu.o
+DML += calcs/dcn_calcs.o calcs/dcn_calc_math.o calcs/dcn_calc_auto.o
 endif
 
 AMD_DAL_DML = $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h b/drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/custom_float.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/custom_float.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
-- 
2.43.0


