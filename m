Return-Path: <linux-kernel+bounces-101997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8452F87AD71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81271C22492
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08B14A4D3;
	Wed, 13 Mar 2024 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKZv2gZH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADB14A0B6;
	Wed, 13 Mar 2024 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348209; cv=none; b=SOSmZCZQ3BKshTIaWwwOwZ6d2h2MiMkdzcAwG5Us+QkrIndMxXqRUJwMzJKfqD60Bw6PaP68dKZv8ar+8o/KJ72cNYxJQT9ZMwdVBIrrhoQxeYcrt5HG52faELYa6WgBEgSclLMf4u4mD0RWafGgRkOxjqoQeXrbCL41exNU9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348209; c=relaxed/simple;
	bh=Fd4BmX0q2dviXv8ZBe0IndRZBVtCPxqAMvzM1rbIf+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di8ff25M9bLZC6conCUzk9e4PnqPf2VI7AZp4lbG/SsuvX0iFJqeWDty4bW4G6S4raKLpXpsgeYImOPJj7Hx9h3vfNGoIXo5tzWQJpQ6H5zHt4BLfPWSj0K2lfY3Hkf1DE1G67/wYao2Ag6mwFFVm6zyGiBfhsq3L0F7nxmNpJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKZv2gZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC52C43390;
	Wed, 13 Mar 2024 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348208;
	bh=Fd4BmX0q2dviXv8ZBe0IndRZBVtCPxqAMvzM1rbIf+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKZv2gZHAfQDcBItrinvlIU3M3f0oNH2Onwdpn4W4KzhUb2iINBuCZigIiQ/JerId
	 QJq4VUeY721XkonVqFVd8el9Dm0bOUw2seN5p4F/zM4R85zf+h1wFxVGkwcBNXKJe4
	 NsB3fo1dnUhKInyBEZB+UvI32VVbEIWQLLSKBAzE6ozOS6+MsF8K1MR+h10plFL4Ww
	 69FwM4UYdQO5whUSiwHuSVKuAnlLZqCmZ7zfw97Z0gt96Zo3mGRsVogG+pOBgQPBdV
	 1F19rAa+ZocGoh81DKsEc6esgGK5U7qghsdwL6A6fGg+EVnp8CGA9ZF0EJL2uc3ddh
	 JoSzQZ+oQArEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Solomon Chiu <solomon.chiu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 56/76] drm/amd/display: Re-arrange FPU code structure for dcn2x
Date: Wed, 13 Mar 2024 12:42:03 -0400
Message-ID: <20240313164223.615640-57-sashal@kernel.org>
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

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[ Upstream commit ee37341199c61558b73113659695c90bf4736eb2 ]

[Why]
Current FPU code for DCN2x is located under dml/dcn2x.
This is not aligned with DC's general source tree
structure.

[How]
Move FPU code for DCN2x to dml/dcn20.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: e63e35f0164c ("drm/amd/display: Increase frame-larger-than for all display_mode_vba files")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c              | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile                 | 4 ++--
 .../amd/display/dc/dml/{dcn2x/dcn2x.c => dcn20/dcn20_fpu.c} | 2 +-
 .../amd/display/dc/dml/{dcn2x/dcn2x.h => dcn20/dcn20_fpu.h} | 6 +++---
 6 files changed, 9 insertions(+), 9 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/dml/{dcn2x/dcn2x.c => dcn20/dcn20_fpu.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/dml/{dcn2x/dcn2x.h => dcn20/dcn20_fpu.h} (94%)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index b1bf80da3a55f..ab0c6d1910382 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -52,7 +52,7 @@ static DEFINE_PER_CPU(int, fpu_recursion_depth);
  * This function tells if the code is already under FPU protection or not. A
  * function that works as an API for a set of FPU operations can use this
  * function for checking if the caller invoked it after DC_FP_START(). For
- * example, take a look at dcn2x.c file.
+ * example, take a look at dcn20_fpu.c file.
  */
 inline void dc_assert_fp_enabled(void)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index ede11eb120d4f..04b370e7e732e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -35,7 +35,7 @@
 #include "include/irq_service_interface.h"
 #include "dcn20/dcn20_resource.h"
 
-#include "dml/dcn2x/dcn2x.h"
+#include "dml/dcn20/dcn20_fpu.h"
 
 #include "dcn10/dcn10_hubp.h"
 #include "dcn10/dcn10_ipp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 5b8274b8c3845..7c5c1414b7a1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -35,7 +35,7 @@
 #include "include/irq_service_interface.h"
 #include "dcn20/dcn20_resource.h"
 
-#include "dml/dcn2x/dcn2x.h"
+#include "dml/dcn20/dcn20_fpu.h"
 
 #include "clk_mgr.h"
 #include "dcn10/dcn10_hubp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 9009b92490f34..e7bb69ec99b66 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -58,7 +58,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
@@ -95,8 +95,8 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_rcflags)
 DML = display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
 
 ifdef CONFIG_DRM_AMD_DC_DCN
+DML += dcn20/dcn20_fpu.o
 DML += display_mode_vba.o dcn20/display_rq_dlg_calc_20.o dcn20/display_mode_vba_20.o
-DML += dcn2x/dcn2x.o
 DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
 DML += dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
 DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.c
rename to drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index c58522436291a..d590dc9173637 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -26,7 +26,7 @@
 
 #include "resource.h"
 
-#include "dcn2x.h"
+#include "dcn20_fpu.h"
 
 /**
  * DOC: DCN2x FPU manipulation Overview
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.h b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
similarity index 94%
rename from drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.h
rename to drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
index 331547ba07132..36f26126d574b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
@@ -24,11 +24,11 @@
  *
  */
 
-#ifndef __DCN2X_H__
-#define __DCN2X_H__
+#ifndef __DCN20_FPU_H__
+#define __DCN20_FPU_H__
 
 void dcn20_populate_dml_writeback_from_context(struct dc *dc,
 					       struct resource_context *res_ctx,
 					       display_e2e_pipe_params_st *pipes);
 
-#endif /* __DCN2X_H__ */
+#endif /* __DCN20_FPU_H__ */
-- 
2.43.0


