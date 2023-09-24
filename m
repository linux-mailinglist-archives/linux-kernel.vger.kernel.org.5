Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD4A7AC8F8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjIXNVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjIXNVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:21:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B9030E6;
        Sun, 24 Sep 2023 06:18:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEEDC433C7;
        Sun, 24 Sep 2023 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561517;
        bh=m8A5qV2svXzJAoVYad/DEMOjC6iKCTNtquyMarD5SsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsJz6OxNjgZ6Ges+Wq8rr8x2kklbDti+PSyQ+ZrmtYmUoLeEROxefnboCK3aNYy8M
         UhRX/S/5jQe+mExvqhkbY+yxkHwYknksTvW+vyXquSv2pz92N1J2pszpmkusdbYbZp
         5XaL8uCIEhD/3EPch6JqXasi3YIrGl8AbSnz84rc+xL/94UP+FYWn49o099OM60pqp
         Carde3CZkkJt1h+44VNFYO8jaSGENA4KKBP5W1DB5H3QE4kgoTDMroR2/YtV2jqe4F
         RYmaxHdXO/fyrsUFba6kn3xI+mgGoD/eirHkcTUFAdfobuYiddwWmk/HTLJ7gpYEZK
         u7MXBTPPhN8/A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Timmy Tsai <timmtsai@amd.com>, Sasha Levin <sashal@kernel.org>,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, Likun.Gao@amd.com, kenneth.feng@amd.com,
        aaron.liu@amd.com, veerabadhran.gopalakrishnan@amd.com,
        sonny.jiang@amd.com, Jane.Jian@amd.com, shane.xiao@amd.com,
        sunran001@208suo.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 21/28] drm/amdgpu/soc21: don't remap HDP registers for SR-IOV
Date:   Sun, 24 Sep 2023 09:17:38 -0400
Message-Id: <20230924131745.1275960-21-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 1832403cd41ca6b19b24e9d64f79cb08d920ca44 ]

This matches the behavior for soc15 and nv.

Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Timmy Tsai <timmtsai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d150a90daa403..56af7b5abac14 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -755,7 +755,7 @@ static int soc21_common_hw_init(void *handle)
 	 * for the purpose of expose those registers
 	 * to process space
 	 */
-	if (adev->nbio.funcs->remap_hdp_registers)
+	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	soc21_enable_doorbell_aperture(adev, true);
-- 
2.40.1

