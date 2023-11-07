Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA69A7E3EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjKGMmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjKGMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:41:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3592D67;
        Tue,  7 Nov 2023 04:29:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDF6C433C7;
        Tue,  7 Nov 2023 12:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360185;
        bh=RQBd2PXDrZbS8s6bkX523kM3pf4EKY4c7HeXttE7ZVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7T7YBNjDZk1h8TW22AXdNGP/pZMC6FSTVVcQCOF9jpWgWVrZM0BF3brL656CEwdu
         DpUzbXWK47TixMZI+2jbSM9cvmi6rTKvF5v2rN+AWzfxt80AybXBkmCVERrffecVEj
         WvF9i42YC3thMZKG/+uFu6lmW7ZuFi2qol2vvwsnJqqKqPPKqPdS/IGzW4ulf40fTQ
         WrY9+YrMTy80XIwY+aNcJcnEDduWPMxJrLPXmQLBTfeK9IZDMLLqjqY4OPkVcPGYUz
         GoAURA1UKFPV+Bxk2Dd/imziaw6WHA6ncyfEgX9BfXMLJMisezrlBOi9wmGq0RP/2h
         eEcGXZV8tpaQw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiaogang Chen <xiaogang.chen@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Jesse Zhang <Jesse.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Felix.Kuehling@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 02/20] drm/amdkfd: Fix a race condition of vram buffer unref in svm code
Date:   Tue,  7 Nov 2023 07:28:56 -0500
Message-ID: <20231107122940.3762228-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122940.3762228-1-sashal@kernel.org>
References: <20231107122940.3762228-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

[ Upstream commit 709c348261618da7ed89d6c303e2ceb9e453ba74 ]

prange->svm_bo unref can happen in both mmu callback and a callback after
migrate to system ram. Both are async call in different tasks. Sync svm_bo
unref operation to avoid random "use-after-free".

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Tested-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 22a70aaccf13c..b7d32a5062b6c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -550,8 +550,15 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
 
 void svm_range_vram_node_free(struct svm_range *prange)
 {
-	svm_range_bo_unref(prange->svm_bo);
-	prange->ttm_res = NULL;
+	/* serialize prange->svm_bo unref */
+	mutex_lock(&prange->lock);
+	/* prange->svm_bo has not been unref */
+	if (prange->ttm_res) {
+		prange->ttm_res = NULL;
+		mutex_unlock(&prange->lock);
+		svm_range_bo_unref(prange->svm_bo);
+	} else
+		mutex_unlock(&prange->lock);
 }
 
 struct amdgpu_device *
-- 
2.42.0

