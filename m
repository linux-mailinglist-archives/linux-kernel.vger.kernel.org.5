Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94197F4AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjKVPhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344495AbjKVPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:36:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8E53253;
        Wed, 22 Nov 2023 07:35:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F10C433AD;
        Wed, 22 Nov 2023 15:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667306;
        bh=64yzNvnyKELDguf9FSj/slACkU5gTeVie9YoAqI6GdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2lwG3p7PHcRXLEjXz6O9Xtq6wOu4ZbYUVXpZr71aSWFklhe2qxvFnNBEyzfsIUN9
         1iG6QndBFIg0lg3qHpOGfv/l9nZGlyaXFPoX2J9UZKqhGyBxpbxdZn0CcTpIvkQ7Kd
         Fvb3wbyvvfjgSeDFYdr856xCL2dq/ypZDTWyBU4EPrRsQ06S6MH2LaaAECaBVgs/c9
         uwoffDrH9YQ9rfs69LcdOonmu9G4PLGWpUnxT59NBruh7f5bbZecTb1Oqv5xyYJ9sw
         psaMuVhr8BS2H3sfePOvULi4KBmYtszy63EWoPw6bRQsyYkx1JIZLT/oZq8BKqq1Ms
         nsRtuSGscIZSA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YuanShang <YuanShang.Mao@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, guchun.chen@amd.com,
        srinivasan.shanmugam@amd.com, luben.tuikov@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 9/9] drm/amdgpu: correct chunk_ptr to a pointer to chunk.
Date:   Wed, 22 Nov 2023 10:34:33 -0500
Message-ID: <20231122153440.852807-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153440.852807-1-sashal@kernel.org>
References: <20231122153440.852807-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.63
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YuanShang <YuanShang.Mao@amd.com>

[ Upstream commit 50d51374b498457c4dea26779d32ccfed12ddaff ]

The variable "chunk_ptr" should be a pointer pointing
to a struct drm_amdgpu_cs_chunk instead of to a pointer
of that.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 4624160315648..26b55cca27680 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -201,7 +201,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	}
 
 	for (i = 0; i < p->nchunks; i++) {
-		struct drm_amdgpu_cs_chunk __user **chunk_ptr = NULL;
+		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
 		uint32_t __user *cdata;
 
-- 
2.42.0

