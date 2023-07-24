Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23775E692
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGXBVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjGXBV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:21:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A273710CF;
        Sun, 23 Jul 2023 18:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C334060E9C;
        Mon, 24 Jul 2023 01:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24678C433C8;
        Mon, 24 Jul 2023 01:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161587;
        bh=ImR3UXOF6VoJ4MCSRQKC8RpuOKabCwM5SEE6az3qi4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lnNL3juETAkL/MregViThrRq3lZKODkzvjEvU++yTSkC9ueMDBXvzBaAnVsmC3JrS
         1Em+GkbgyFO11Zj19A+xlrxSgfpQJQpCi7dt+bR9Je79JN8VEU/9XgaRg4BgwzKR0v
         svOiCa6W4Ab4DhcZv6ZGJyPYrNSOqLtfip3fWAoDgU/Dan7bNPLCDA1REfWmbP/nfn
         H/neKJ9dSnjTMD+zv6Z5C5FkYA1f3E5lW0Th4IYebjUvAq3zyHKjl8Qko0e80defVO
         OSwlXCn3NEgT0Us3beaks26NINYCMEDD5otA14nXB7c3Sts37m4YX/q6gJp9llfYOg
         LAL7mWF7l1FUw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alvin Lee <alvin.lee2@amd.com>,
        Nevenko Stupar <nevenko.stupar@amd.com>,
        Jun Lei <jun.lei@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Dillon.Varone@amd.com, nathan@kernel.org,
        Ilya.Bakoulin@amd.com, Nevenko.Stupar@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 41/58] drm/amd/display: Apply 60us prefetch for DCFCLK <= 300Mhz
Date:   Sun, 23 Jul 2023 21:13:09 -0400
Message-Id: <20230724011338.2298062-41-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit 7e60ab4eb3e4ba2adac46d737fdbbc5732bebd58 ]

[Description]
- Previously we wanted to apply extra 60us of prefetch for min DCFCLK
  (200Mhz), but DCFCLK can be calculated to be 201Mhz which underflows
  also without the extra prefetch
- Instead, apply the the extra 60us prefetch for any DCFCLK freq <=
  300Mhz

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c    | 4 ++--
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index d75248b6cae99..9a5150e96017a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -811,7 +811,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->SwathHeightC[k],
 					TWait,
 					(v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ||
-						v->DCFCLKPerState[mode_lib->vba.VoltageLevel] <= MIN_DCFCLK_FREQ_MHZ) ?
+						v->DCFCLKPerState[mode_lib->vba.VoltageLevel] <= DCFCLK_FREQ_EXTRA_PREFETCH_REQ_MHZ) ?
 							mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 					/* Output */
 					&v->DSTXAfterScaler[k],
@@ -3311,7 +3311,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->swath_width_chroma_ub_this_state[k],
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k], v->TWait,
-							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= MIN_DCFCLK_FREQ_MHZ) ?
+							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= DCFCLK_FREQ_EXTRA_PREFETCH_REQ_MHZ) ?
 									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 
 							/* Output */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
index d98e36a9a09cc..c4745d63039bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
@@ -53,7 +53,7 @@
 #define BPP_BLENDED_PIPE 0xffffffff
 
 #define MEM_STROBE_FREQ_MHZ 1600
-#define MIN_DCFCLK_FREQ_MHZ 200
+#define DCFCLK_FREQ_EXTRA_PREFETCH_REQ_MHZ 300
 #define MEM_STROBE_MAX_DELIVERY_TIME_US 60.0
 
 struct display_mode_lib;
-- 
2.39.2

