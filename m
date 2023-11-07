Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313DF7E3EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbjKGMlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344065AbjKGMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:39:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50CC9015;
        Tue,  7 Nov 2023 04:28:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735C0C433C7;
        Tue,  7 Nov 2023 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360131;
        bh=X226EpgIEneFaPqtTSC31tllmiqpBdJiVVgarJUWHJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KnkB1pXWG88IPvIXW6XtKDeavM7h3IJQO8bX1lhpp2bmVmr2+ECe2vG7aCTyRJbPh
         L7GQqbrYqO6ffCbwlrhYmmW33nkklz/cfRbzawBhJmdK+0LJaHR+FIRX6z7F+BVZG9
         x6eXICGURKy5YNZC5Gk4fxGibs+oB/K7jNE9t5ODUwo4qD/P3S4fEvLRgQYjv0VoNt
         yXoku3ehWu7jVgKo5NzsQyisaYxjYAbNuI7goh2h0RS3laS8uYFvPhzFfcyUus5iHQ
         t4zYJmhQGv8c38f3PTooMl0v/P6KHSTJoJggY/g/q2NoEBzA74sjd12W8z7PkD98B3
         r9DxAMtT16u1A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Stanley.Yang" <Stanley.Yang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        mario.limonciello@amd.com, Hawking.Zhang@amd.com,
        lijo.lazar@amd.com, candice.li@amd.com, le.ma@amd.com,
        shashank.sharma@amd.com, andrealmeid@igalia.com,
        srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 16/25] drm/amdgpu: Fix potential null pointer derefernce
Date:   Tue,  7 Nov 2023 07:26:55 -0500
Message-ID: <20231107122745.3761613-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122745.3761613-1-sashal@kernel.org>
References: <20231107122745.3761613-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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

From: "Stanley.Yang" <Stanley.Yang@amd.com>

[ Upstream commit 80285ae1ec8717b597b20de38866c29d84d321a1 ]

The amdgpu_ras_get_context may return NULL if device
not support ras feature, so add check before using.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 92fa2faf63e41..dc61cc1659326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5330,7 +5330,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * Flush RAM to disk so that after reboot
 	 * the user can read log and see why the system rebooted.
 	 */
-	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
+	if (need_emergency_restart && amdgpu_ras_get_context(adev) &&
+		amdgpu_ras_get_context(adev)->reboot) {
 		DRM_WARN("Emergency reboot.");
 
 		ksys_sync_helper();
-- 
2.42.0

