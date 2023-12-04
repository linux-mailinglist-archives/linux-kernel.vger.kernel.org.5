Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CC6803FC8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346090AbjLDUfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjLDUfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:35:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9942B2133
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:34:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175EEC433CA;
        Mon,  4 Dec 2023 20:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722066;
        bh=cq6q6SprEF7TJmOidVjn7rV5ZJdddDKd2dLoRMiSmoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uDlYXIPH9DbNeq9VNJJD0VyE1rVxcOQ2qb7hrlojgSvYw6RuQdVIyx7+yag1i629i
         5tfkVwFZtFe/iP8n+Panfat4rI5wYcv3M6SRF06IFZq/hBI2H/Be2prtisLUukh2Ji
         XYfBQhV84rWs6qoknLbsuvh2T82K1dWv/xa2+qecdtYbWjL2Y/CvV/fNOGOgVsxzIw
         LB3BvCqHGiN7mqPFuCL+YGzYDbYSqzT+HLpKSOBxSKJky17WuVp6IqDidK9wObwwx+
         323DflnPy6vug4u1yGQXRfiIqvTZiDyUM73YM8UIYmNM6dXtuiZOD7Tq0mDsNbC85/
         Dgn/DUfKCCWxg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hawking Zhang <Hawking.Zhang@amd.com>,
        Stanley Yang <Stanley.Yang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        lijo.lazar@amd.com, le.ma@amd.com, Felix.Kuehling@amd.com,
        James.Zhu@amd.com, tao.zhou1@amd.com, asad.kamal@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 23/32] drm/amdgpu: Do not issue gpu reset from nbio v7_9 bif interrupt
Date:   Mon,  4 Dec 2023 15:32:43 -0500
Message-ID: <20231204203317.2092321-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

[ Upstream commit 884e9b0827e889a8742e203ccd052101fb0b945d ]

In nbio v7_9, host driver should not issu gpu reset

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley Yang <Stanley.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index f85eec05d2181..ae45656eb8779 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -604,11 +604,6 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 
 		dev_info(adev->dev, "RAS controller interrupt triggered "
 					"by NBIF error\n");
-
-		/* ras_controller_int is dedicated for nbif ras error,
-		 * not the global interrupt for sync flood
-		 */
-		amdgpu_ras_reset_gpu(adev);
 	}
 }
 
-- 
2.42.0

