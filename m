Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC53178C5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjH2NeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbjH2Ndf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA081A1;
        Tue, 29 Aug 2023 06:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 492166576C;
        Tue, 29 Aug 2023 13:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5DBC433CD;
        Tue, 29 Aug 2023 13:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315964;
        bh=jZegXIIn8Oj2fKnJ4hWfaOM4zH4yTa4YiBJUT2sLx6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNnOtgKMFelz3cbUkYYn+TxX3cqHUD5Qoc1qkRnNXfZNxcj8UUAm8vFVdfUrU8bZ1
         FUeFnINsDDGotrs6ncoASi7nRFmqf0nMChrac7k7p8XfGF8sUH7OB82IeqbaLHM/1Z
         QUpqQLdmBl4He5iNZwgY2IzFxrNASd2CvTsqoUYjX+QlBGr2ih0ZOo7vBLY3uDtHTn
         YpfEG+PkNTsxi0KdH9GZVdeSG20aB+AG2wcxGN33OVUTpvDsU3yRrjRtAkdflxzpEa
         RTHzNgwzdqbhBsQ/BFdotc7LIMOIdqTc5Wtc02hMcJr26bc0ogP2E9N36TOyYFcGvg
         F9Fsm9uGtd/4w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lijo Lazar <lijo.lazar@amd.com>,
        Yang Wang <kevinyang.wang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, evan.quan@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 17/17] drm/amd/pm: Fix temperature unit of SMU v13.0.6
Date:   Tue, 29 Aug 2023 09:32:04 -0400
Message-Id: <20230829133211.519957-17-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 8d036427f0042a91136e6f19a39542eedec4e96c ]

Temperature needs to be reported in millidegree Celsius.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c9093517b1bda..bfa020fe0d4fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -697,16 +697,19 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 		*value = SMUQ10_TO_UINT(metrics->SocketPower) << 8;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = SMUQ10_TO_UINT(metrics->MaxSocketTemperature);
+		*value = SMUQ10_TO_UINT(metrics->MaxSocketTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = SMUQ10_TO_UINT(metrics->MaxHbmTemperature);
+		*value = SMUQ10_TO_UINT(metrics->MaxHbmTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	/* This is the max of all VRs and not just SOC VR.
 	 * No need to define another data type for the same.
 	 */
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = SMUQ10_TO_UINT(metrics->MaxVrTemperature);
+		*value = SMUQ10_TO_UINT(metrics->MaxVrTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
 		*value = smu_v13_0_6_get_throttler_status(smu, metrics);
-- 
2.40.1

