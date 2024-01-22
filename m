Return-Path: <linux-kernel+bounces-33365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C690D8368D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7453C282F43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1086A028;
	Mon, 22 Jan 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToaqCCPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5CF48CCD;
	Mon, 22 Jan 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935987; cv=none; b=a1ikKIyPL1YwOHWunNuOZcEq4FqlT/hGd1a8Kd2++UewZDMKMBaPXyg0BfOqdHIgTORmrpF9R2QDMGilbiLaNj/VWZc5vixYjxYJxvgFjE0SBLHfRbeyGS3LuC0+wh8QNuvFLniTSk6zaAkctBc6kNvJKqjXd6qvssRGRDUN5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935987; c=relaxed/simple;
	bh=rx4dgLUNkTDqsW33qsOd9iKztc0OWISm4z1ZSgDnIQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/HkxXg7jhB9b6D123j3Uqii6NYEhHEL+bI7jyjfmruGB4+6Fz8PXbV/58sOxcPTA6bkrv3XlTCLZ1J4nUiWpU3IZporXcNOb4MRe6s7korrOCrVJpKdso7QI7t+WuWbKQWI3UUPgrPWs6Kq9nuPQIzuybzculUkXWDduf8cVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToaqCCPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1021C433F1;
	Mon, 22 Jan 2024 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935986;
	bh=rx4dgLUNkTDqsW33qsOd9iKztc0OWISm4z1ZSgDnIQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToaqCCPsNh0GnjpeMUFr/52NHQakxumqsEDgNmL3KobqncDOapF91Rcg3rf0fife6
	 p5GPtQDYEgkfAaKJzR9D8TT1YZg9OIj8BBM97OvhC5odUeKYeAdYP5/yCKQu/shvI7
	 RxjNg5oykcCB6ZSZ4xbXkBp9w6fLibXYBAdbSZGaPKbnrrD+j1GjQLl8TlngUa8haR
	 nJb8M6J8S//VLTDIoY4i+pJH/JGakh1xHpGcGZbbbPH6dA0yz44v+oTbA27R3tnE2h
	 nEJPG52ahW/EXAkJ6ZEFaNG/Dkkm8bq83CTKYtd+fqBP5KA74cdXjpeZkCIN46T7k6
	 UeQDu+x+CS7hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alvin Lee <alvin.lee2@amd.com>,
	Jun Lei <jun.lei@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nevenko.stupar@amd.com,
	qingqing.zhuo@amd.com,
	Ilya.Bakoulin@amd.com,
	drv@mailo.com,
	Paul.Hsieh@amd.com,
	wenjing.liu@amd.com,
	hanghong.ma@amd.com,
	meera.patel@amd.com,
	Dillon.Varone@amd.com,
	srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 43/73] drm/amd/display: For prefetch mode > 0, extend prefetch if possible
Date: Mon, 22 Jan 2024 10:01:57 -0500
Message-ID: <20240122150432.992458-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit dd4e4bb28843393065eed279e869fac248d03f0f ]

[Description]
For mode programming we want to extend the prefetch as much as possible
(up to oto, or as long as we can for equ) if we're not already applying
the 60us prefetch requirement. This is to avoid intermittent underflow
issues during prefetch.

The prefetch extension is applied under the following scenarios:
1. We're in prefetch mode 1 (i.e. we don't support MCLK switch in blank)
2. We're using subvp or drr methods of p-state switch, in which case we
   we don't care if prefetch takes up more of the blanking time

Mode programming typically chooses the smallest prefetch time possible
(i.e. highest bandwidth during prefetch) presumably to create margin between
p-states / c-states that happen in vblank and prefetch. Therefore we only
apply this prefetch extension when p-state in vblank is not required (UCLK
p-states take up the most vblank time).

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        |  3 ++
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 33 +++++++++++++++----
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  1 +
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index cbdfb762c10c..6c84b0fa40f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -813,6 +813,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					(v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ||
 						v->DCFCLKPerState[mode_lib->vba.VoltageLevel] <= DCFCLK_FREQ_EXTRA_PREFETCH_REQ_MHZ) ?
 							mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
+					mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] > 0 || mode_lib->vba.DRAMClockChangeRequirementFinal == false,
+
 					/* Output */
 					&v->DSTXAfterScaler[k],
 					&v->DSTYAfterScaler[k],
@@ -3317,6 +3319,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->SwathHeightCThisState[k], v->TWait,
 							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= DCFCLK_FREQ_EXTRA_PREFETCH_REQ_MHZ) ?
 									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
+							mode_lib->vba.PrefetchModePerState[i][j] > 0 || mode_lib->vba.DRAMClockChangeRequirementFinal == false,
 
 							/* Output */
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTXAfterScaler[k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index ecea008f19d3..208b89d13d3f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -3423,6 +3423,7 @@ bool dml32_CalculatePrefetchSchedule(
 		unsigned int SwathHeightC,
 		double TWait,
 		double TPreReq,
+		bool ExtendPrefetchIfPossible,
 		/* Output */
 		double   *DSTXAfterScaler,
 		double   *DSTYAfterScaler,
@@ -3892,12 +3893,32 @@ bool dml32_CalculatePrefetchSchedule(
 			/* Clamp to oto for bandwidth calculation */
 			LinesForPrefetchBandwidth = dst_y_prefetch_oto;
 		} else {
-			*DestinationLinesForPrefetch = dst_y_prefetch_equ;
-			TimeForFetchingMetaPTE = Tvm_equ;
-			TimeForFetchingRowInVBlank = Tr0_equ;
-			*PrefetchBandwidth = prefetch_bw_equ;
-			/* Clamp to equ for bandwidth calculation */
-			LinesForPrefetchBandwidth = dst_y_prefetch_equ;
+			/* For mode programming we want to extend the prefetch as much as possible
+			 * (up to oto, or as long as we can for equ) if we're not already applying
+			 * the 60us prefetch requirement. This is to avoid intermittent underflow
+			 * issues during prefetch.
+			 *
+			 * The prefetch extension is applied under the following scenarios:
+			 * 1. We're in prefetch mode > 0 (i.e. we don't support MCLK switch in blank)
+			 * 2. We're using subvp or drr methods of p-state switch, in which case we
+			 *    we don't care if prefetch takes up more of the blanking time
+			 *
+			 * Mode programming typically chooses the smallest prefetch time possible
+			 * (i.e. highest bandwidth during prefetch) presumably to create margin between
+			 * p-states / c-states that happen in vblank and prefetch. Therefore we only
+			 * apply this prefetch extension when p-state in vblank is not required (UCLK
+			 * p-states take up the most vblank time).
+			 */
+			if (ExtendPrefetchIfPossible && TPreReq == 0 && VStartup < MaxVStartup) {
+				MyError = true;
+			} else {
+				*DestinationLinesForPrefetch = dst_y_prefetch_equ;
+				TimeForFetchingMetaPTE = Tvm_equ;
+				TimeForFetchingRowInVBlank = Tr0_equ;
+				*PrefetchBandwidth = prefetch_bw_equ;
+				/* Clamp to equ for bandwidth calculation */
+				LinesForPrefetchBandwidth = dst_y_prefetch_equ;
+			}
 		}
 
 		*DestinationLinesToRequestVMInVBlank = dml_ceil(4.0 * TimeForFetchingMetaPTE / LineTime, 1.0) / 4.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 592d174df6c6..5d34735df83d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -747,6 +747,7 @@ bool dml32_CalculatePrefetchSchedule(
 		unsigned int SwathHeightC,
 		double TWait,
 		double TPreReq,
+		bool ExtendPrefetchIfPossible,
 		/* Output */
 		double   *DSTXAfterScaler,
 		double   *DSTYAfterScaler,
-- 
2.43.0


