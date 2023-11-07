Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD007E3EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjKGMk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343683AbjKGMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:39:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFC193E1;
        Tue,  7 Nov 2023 04:27:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A6CC433C8;
        Tue,  7 Nov 2023 12:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360075;
        bh=br1Im9wcZxU3TPWiSFZhB/V0bOGJWTYQFux3oKMhmhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkKcuwRuQjqlVLipb47LjhDjEiXjsytJ+WT6pvySAhpqhXOwHxAMrzW8PPQCT4NP6
         eqMCdzA1lxpOCGjxx9gd6kdtocGElmmajhYeLYw5tU93dOSli88Jpkl4tV8Jk9uSby
         zwLZKcCM5glBtxXjjcfNYTfSdBTXaxa6UJXOozwrHXNyPltGimX/eO/rO8OyQtk0Cj
         VZMJVxlRjw449ZRIAJInVzsetadmTgsQOx/yu/1rosXRGOKwqst2//SzEFMGANzkOE
         uwt8IxBesr5ep4LbXxg+A8wa/9VY5dc0i2G19GoKoGCuVaSnlXlez09uZrewIkzDbf
         ldncFutk6oT+A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
        Leo Liu <leo.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        James.Zhu@amd.com, tao.zhou1@amd.com, saleemkhan.jamadar@amd.com,
        gpiccoli@igalia.com, srinivasan.shanmugam@amd.com,
        Hongkun.Zhang@amd.com, mario.limonciello@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 03/25] drm/amdgpu: not to save bo in the case of RAS err_event_athub
Date:   Tue,  7 Nov 2023 07:26:42 -0500
Message-ID: <20231107122745.3761613-3-sashal@kernel.org>
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
index 5c1193dd7d88c..48e612023d0c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -391,8 +391,15 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
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

