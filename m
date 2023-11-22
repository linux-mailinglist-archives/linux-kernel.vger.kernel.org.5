Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A787F4B13
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbjKVPid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344614AbjKVPiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:38:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F3C3A8C;
        Wed, 22 Nov 2023 07:36:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA7AC4339A;
        Wed, 22 Nov 2023 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667364;
        bh=rJOX84CDt/E/AgosK1OJaG1ChjuMZ8MKMVMSJkx7YiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJKYxaSIJgRJ1yN2c0dniJopejkfCvpEhFd5N/s+fq8KWlT9vvPpk+MmogjA4CmjS
         E4Y5ItrDH0ImU7CCQOQUmE25tQJkQlFhusvJmEjJo/5EsGPUxAZfvaLZUneXI+dwtb
         l+o5eP9IT5Qj642HJsYSuIbbzHdQPnAXCdjYuCgmObL9tfyE59sMgtEzTMvN3OexXf
         SWYNHOL7cso6TiiBnMyNBnH+OBISLBt6o2wc/kZj57RvRF5wBRP2ladBzDqJcXbjFS
         i+NKfNiO4RZqjf1eg5ZzZzYr/jqY28YOcp7h+MtYANK8JuYxV5EcYMq0QooUrbeMJe
         n1/hlD61i/Nvg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YuanShang <YuanShang.Mao@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, guchun.chen@amd.com,
        srinivasan.shanmugam@amd.com, luben.tuikov@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 7/7] drm/amdgpu: correct chunk_ptr to a pointer to chunk.
Date:   Wed, 22 Nov 2023 10:35:35 -0500
Message-ID: <20231122153541.853179-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153541.853179-1-sashal@kernel.org>
References: <20231122153541.853179-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.201
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
index 7f2adac82e3a6..addeda42339fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -143,7 +143,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	}
 
 	for (i = 0; i < p->nchunks; i++) {
-		struct drm_amdgpu_cs_chunk __user **chunk_ptr = NULL;
+		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
 		uint32_t __user *cdata;
 
-- 
2.42.0

