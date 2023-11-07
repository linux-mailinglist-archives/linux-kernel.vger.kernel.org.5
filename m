Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CCA7E3D92
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjKGM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjKGM25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:28:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A951A34896;
        Tue,  7 Nov 2023 04:19:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A4CC43395;
        Tue,  7 Nov 2023 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359573;
        bh=TZlEhB+YjBjV3vX8NIwK7ntLlJoBAsRXJDR6c8tgAUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cp5OWrE3lzkTly09yQQpdi4Yj9FqVWQTGBmwNqkugG0Jqg+rbN9SDqIS7djlS/lnd
         /TWxDVCW2vD4w8Eh18Ek8JZG407VsHl0RHwnYdu41caFsm5dws+kT8PE5ZmEzRxBYa
         PnWlnDFN8VTa0UCnoZmiD3scKlnTj9BWxbtevkzPTET08bIQqXzD3aQmHCJtLHW8FR
         4orR7c191EcnlQXfYUbnxJkTkxdpAJii0+eLPan90UvH1XUZnyquPl75xeMYVd99ID
         P1qULB6cFZyQh4lKKZJa6NApBm3rdtTpuv6cVT26nq0kF9DNMNjq6EEVIuI5KN87I/
         D63F5LQJfCtvA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
        Leo Liu <leo.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        James.Zhu@amd.com, tao.zhou1@amd.com, saleemkhan.jamadar@amd.com,
        gpiccoli@igalia.com, Hongkun.Zhang@amd.com,
        mario.limonciello@amd.com, srinivasan.shanmugam@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 09/40] drm/amdgpu: not to save bo in the case of RAS err_event_athub
Date:   Tue,  7 Nov 2023 07:16:11 -0500
Message-ID: <20231107121837.3759358-9-sashal@kernel.org>
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

From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>

[ Upstream commit fa1f1cc09d588a90c8ce3f507c47df257461d148 ]

err_event_athub will corrupt VCPU buffer and not good to
be restored in amdgpu_vcn_resume() and in this case
the VCPU buffer needs to be cleared for VCN firmware to
work properly.

Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 36b55d2bd51a9..03b4bcfca1963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -292,8 +292,15 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 	void *ptr;
 	int i, idx;
 
+	bool in_ras_intr = amdgpu_ras_intr_triggered();
+
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
+	/* err_event_athub will corrupt VCPU buffer, so we need to
+	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
+	if (in_ras_intr)
+		return 0;
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-- 
2.42.0

