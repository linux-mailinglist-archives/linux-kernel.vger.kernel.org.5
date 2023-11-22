Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08967F4B27
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344757AbjKVPkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344624AbjKVPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:39:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD80E30E7;
        Wed, 22 Nov 2023 07:35:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126DFC43391;
        Wed, 22 Nov 2023 15:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667334;
        bh=LzY7NWgh+XafFmfyFm953AoJ3tAYaXRj6+4vA4H+S04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISWdRBknALd6dFgzpu+KTzHd2/3YhVs8K3Xecm+D+jUcV8B7oOWnweL++b8g9dtvY
         39NXqWfeZxTVg1J2HQAtaPumgUuatuTOgCeYgDKQocJoETPbsXs89ciFZ0BNedfJIV
         KX8cpPYlcAxGjvu2JgW+2cXV1GF/LoRcC5YbyivMumGrk0ijJahX9l9rYKvuqqI1Av
         tYXDGIIuqJy1fpI2tQWflbguxCTOZ0Pg8+RVR/tZ5n5FtKlKidmXRf/t7Xawi2Kxdn
         jS+vBkVLImjextUmgEC3R2HwPb3/wKh6gdyyYErt8gKuSxSUIO+7n23imfp5anTLaF
         LiaPpugQVdJsg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YuanShang <YuanShang.Mao@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, guchun.chen@amd.com,
        luben.tuikov@amd.com, srinivasan.shanmugam@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 7/7] drm/amdgpu: correct chunk_ptr to a pointer to chunk.
Date:   Wed, 22 Nov 2023 10:35:07 -0500
Message-ID: <20231122153512.853015-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153512.853015-1-sashal@kernel.org>
References: <20231122153512.853015-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.139
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
index 2d8f71dde9803..f293d0dfec613 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -142,7 +142,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	}
 
 	for (i = 0; i < p->nchunks; i++) {
-		struct drm_amdgpu_cs_chunk __user **chunk_ptr = NULL;
+		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
 		uint32_t __user *cdata;
 
-- 
2.42.0

