Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEA798FBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbjIHTee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjIHTeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:34:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A41BF5;
        Fri,  8 Sep 2023 12:34:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2330BC4AF6F;
        Fri,  8 Sep 2023 19:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201580;
        bh=wgz3VInpTZXOJ0IT8rln9c8uTobUqTSN4k5Jsfw0xi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+4rjWqf/vgVnVdgs0EteCfA2pNfeljC1k7M65oEt9sHkj6v55hK95+Swl4vSZaLS
         sELejNz0LsA3tnshccN36AV4CQhMGYY4C7TEBMVQXg6gWfnOeXyDnijp2tOmQiV16H
         qOE+bpYms/l5iOKroZdauru5ydvLC2RL3NdoDct2LMG3ZFrsEqR+Db6MlvG2eDfP1o
         F+qEmyZVoLv70DLbzvvatvrDbB7G8I6SpJBLVen1MmfYVIJVfU8jRMmciyNWBUP0/O
         /T+0043mFbnw9nhvlTMiDlg7QArsf4Z0n74BJjH607bM4xIZ3vMn3MdszeumXGzmk/
         wV1kXRX89+Cbw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leo Ma <hanghong.ma@amd.com>,
        Dillon Varone <dillon.varone@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Alvin.Lee2@amd.com, Jun.Lei@amd.com,
        george.shen@amd.com, nathan@kernel.org, chris.park@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 13/31] drm/amd/display: Fix underflow issue on 175hz timing
Date:   Fri,  8 Sep 2023 15:31:42 -0400
Message-Id: <20230908193201.3462957-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193201.3462957-1-sashal@kernel.org>
References: <20230908193201.3462957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Ma <hanghong.ma@amd.com>

[ Upstream commit 735688eb905db529efea0c78466fccc1461c3fde ]

[Why]
Screen underflows happen on 175hz timing for 3 plane overlay case.

[How]
Based on dst y prefetch value clamp to equ or oto for bandwidth
calculation.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dml/dcn32/display_mode_vba_util_32.c    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 61cc4904ade41..4c645854b263b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -3463,6 +3463,7 @@ bool dml32_CalculatePrefetchSchedule(
 	double TimeForFetchingMetaPTE = 0;
 	double TimeForFetchingRowInVBlank = 0;
 	double LinesToRequestPrefetchPixelData = 0;
+	double LinesForPrefetchBandwidth = 0;
 	unsigned int HostVMDynamicLevelsTrips;
 	double  trip_to_mem;
 	double  Tvm_trips;
@@ -3892,11 +3893,15 @@ bool dml32_CalculatePrefetchSchedule(
 			TimeForFetchingMetaPTE = Tvm_oto;
 			TimeForFetchingRowInVBlank = Tr0_oto;
 			*PrefetchBandwidth = prefetch_bw_oto;
+			/* Clamp to oto for bandwidth calculation */
+			LinesForPrefetchBandwidth = dst_y_prefetch_oto;
 		} else {
 			*DestinationLinesForPrefetch = dst_y_prefetch_equ;
 			TimeForFetchingMetaPTE = Tvm_equ;
 			TimeForFetchingRowInVBlank = Tr0_equ;
 			*PrefetchBandwidth = prefetch_bw_equ;
+			/* Clamp to equ for bandwidth calculation */
+			LinesForPrefetchBandwidth = dst_y_prefetch_equ;
 		}
 
 		*DestinationLinesToRequestVMInVBlank = dml_ceil(4.0 * TimeForFetchingMetaPTE / LineTime, 1.0) / 4.0;
@@ -3904,7 +3909,7 @@ bool dml32_CalculatePrefetchSchedule(
 		*DestinationLinesToRequestRowInVBlank =
 				dml_ceil(4.0 * TimeForFetchingRowInVBlank / LineTime, 1.0) / 4.0;
 
-		LinesToRequestPrefetchPixelData = *DestinationLinesForPrefetch -
+		LinesToRequestPrefetchPixelData = LinesForPrefetchBandwidth -
 				*DestinationLinesToRequestVMInVBlank - 2 * *DestinationLinesToRequestRowInVBlank;
 
 #ifdef __DML_VBA_DEBUG__
-- 
2.40.1

