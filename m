Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AEB7E3D97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjKGM3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjKGM3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:29:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EAD348A9;
        Tue,  7 Nov 2023 04:19:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B36C433D9;
        Tue,  7 Nov 2023 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359580;
        bh=Q6YYRvqRyl++sOeRzoU6OTGe8lg1e6BT3F7TEeVdgxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nd/Pk/F0YLDc0RBg2YWCH2ICD9kWUdyGb7Qygs5RIoDggA08chcfbqeheeeQXjHVv
         k6Tjcrk3ADvRh6aapm0nGw2LCWT/9kjmzReKjjOVVdqcpzHhg4qIExYOQ/5EQ9cRaU
         zEZN9hdyyUZlfUMnCWnBNuR/pbWclypqnn02vjjV9p/QD1/0p0WAtzXSXghC+uMvdm
         ENlBJVwVijKJMO3be/jjoU3EQu0ISJA7AMSdWC2EA4Hozli0PI/rtpUoro/PwMz2pg
         C2n9GuAicqRIIPf/3u0ovnza5c1F9ArRdEBI2AJ25+SajmhZ7gft7Oln3rlBzuV0Yl
         5xsPZI27TbgXw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tao Zhou <tao.zhou1@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        lijo.lazar@amd.com, asad.kamal@amd.com, candice.li@amd.com,
        YiPeng.Chai@amd.com, mario.limonciello@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 11/40] drm/amdgpu: update retry times for psp vmbx wait
Date:   Tue,  7 Nov 2023 07:16:13 -0500
Message-ID: <20231107121837.3759358-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Zhou <tao.zhou1@amd.com>

[ Upstream commit fc598890715669ff794b253fdf387cd02b9396f8 ]

Increase the retry loops and replace the constant number with macro.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 469eed084976c..52d80f286b3dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -59,6 +59,9 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 /* Read USB-PD from LFB */
 #define GFX_CMD_USB_PD_USE_LFB 0x480
 
+/* Retry times for vmbx ready wait */
+#define PSP_VMBX_POLLING_LIMIT 20000
+
 /* VBIOS gfl defines */
 #define MBOX_READY_MASK 0x80000000
 #define MBOX_STATUS_MASK 0x0000FFFF
@@ -138,7 +141,7 @@ static int psp_v13_0_wait_for_vmbx_ready(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 	int retry_loop, ret;
 
-	for (retry_loop = 0; retry_loop < 70; retry_loop++) {
+	for (retry_loop = 0; retry_loop < PSP_VMBX_POLLING_LIMIT; retry_loop++) {
 		/* Wait for bootloader to signify that is
 		   ready having bit 31 of C2PMSG_33 set to 1 */
 		ret = psp_wait_for(
-- 
2.42.0

