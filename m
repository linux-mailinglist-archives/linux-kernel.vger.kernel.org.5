Return-Path: <linux-kernel+bounces-102001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152DC87AD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68DE281504
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C4E14BD5B;
	Wed, 13 Mar 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2F7ZTtG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599814AD3F;
	Wed, 13 Mar 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348213; cv=none; b=PD22/Bxi1/pZopX+hlZMXlM4i2bhXwTXx9a5KpNnP5HTtIvsdFV+psyA+yFmi4YBbtuMygDO6nfTIt7/KRrn8IZHKszwTSzMEoYpHAJsSX3QqnN+XWnoJbnDBvJY8jdr65fHm5KdzcoEBAy3pRvVM5IncUo52rqZ6kqqzLdkQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348213; c=relaxed/simple;
	bh=xWXNefaQZBQdWGtaZwmaLJIxt24HwXX91agyZD8u11Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NshoR0LX6sE239jYs90G58dpYi3G+ZFNWlBN+/JyhLwatBnyKVDAeI6poaH4cPBEMlsYlFVbzbS4VtcD1wIKPWJdHEUPlcvj5tg9OvvjFxp0bx+FOZH+7GBG8Em7fyhXOxIZCt4eGJkEtzkfGYjz5XzvdKLlTRnAR9H0siRs4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2F7ZTtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68672C433F1;
	Wed, 13 Mar 2024 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348212;
	bh=xWXNefaQZBQdWGtaZwmaLJIxt24HwXX91agyZD8u11Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2F7ZTtGXi1HXtMmTOeSQt0s8qJBdKMM2ygvyFkrDCDZccgClqFjImR91PBv5IFcT
	 iaB6t4CkYUNl9Ywnu0AwkUJkD/AWnrlvmy2DGWKlu4Q3YgoiDW37HzxoTRdDw2c05G
	 I7gH75RiCDKDYIICubIAyYDVTKHal0wnph0+FY9rxJcNqa//BhGQDoHIgbCWIkcokX
	 oAro/1yxG5p/rcSURHeaSA/URpINx7h6kMWGoNamh/k+I2YmDjJBaY6346oBNfGJbx
	 8QFegkD1tHZHkc0/OPVEWLW1EJIIv+IR++i4i5FiFKiuIAGBmJiO5h4eCG1Jbc4ren
	 vLbSddt8uyTkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 59/76] drm/amd/display: Increase frame-larger-than for all display_mode_vba files
Date: Wed, 13 Mar 2024 12:42:06 -0400
Message-ID: <20240313164223.615640-60-sashal@kernel.org>
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

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit e63e35f0164c43fbc1adb481d6604f253b9f9667 ]

After a recent change in LLVM, allmodconfig (which has CONFIG_KCSAN=y
and CONFIG_WERROR=y enabled) has a few new instances of
-Wframe-larger-than for the mode support and system configuration
functions:

  drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:3393:6: error: stack frame size (2144) exceeds limit (2048) in 'dml20v2_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
   3393 | void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        |      ^
  1 error generated.

  drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:3520:6: error: stack frame size (2192) exceeds limit (2048) in 'dml21_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
   3520 | void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        |      ^
  1 error generated.

  drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3286:6: error: stack frame size (2128) exceeds limit (2048) in 'dml20_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
   3286 | void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        |      ^
  1 error generated.

Without the sanitizers enabled, there are no warnings.

This was the catalyst for commit 6740ec97bcdb ("drm/amd/display:
Increase frame warning limit with KASAN or KCSAN in dml2") and that same
change was made to dml in commit 5b750b22530f ("drm/amd/display:
Increase frame warning limit with KASAN or KCSAN in dml") but the
frame_warn_flag variable was not applied to all files. Do so now to
clear up the warnings and make all these files consistent.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issue/1990
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 93cc3086783fa..96e70832c7423 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -59,11 +59,11 @@ CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 ifdef CONFIG_DRM_AMD_DC_DCN
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
-- 
2.43.0


