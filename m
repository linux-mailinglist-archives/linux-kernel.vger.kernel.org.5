Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3079D7F4B28
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344578AbjKVPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344631AbjKVPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:39:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D83D49C4;
        Wed, 22 Nov 2023 07:37:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0BDC433CB;
        Wed, 22 Nov 2023 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667431;
        bh=iqmGAQ90O89w0fdshBkivkNhkoMkooUfoJ/1xS+9voA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dmy8jgGgeBuTJ9/5DjVbw46sbvEQuIJpXAEeqHoSVaEhhL8o8M1npYyfxKb0l9GpM
         iON2oqp8scpuwI57qkJ7yy+T8rOkM1cQRHN3GjIHlYwP/LbThbjaJGcWsjcazhB9jd
         Y6uHkpUuMaiF07FcD5gyF2A8ONE82JvrmB+MPmoi6vL9QTFNb+xn+3Nfp65B1pU/R3
         /e7zh2uccrWEdKuXx0qn2LvXYxewT1SG6Je4G4Lj0qKaQ3i/DYF6n3XFDYC2+RI3A6
         BOGs9nWpUYP0AdPKA0/vqx+fnUj7MIhV/iimNW1OO6dHZ7xtbGVP0Bvo4947K17YT3
         lz1MFcQ8+tMWA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YuanShang <YuanShang.Mao@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, guchun.chen@amd.com,
        luben.tuikov@amd.com, srinivasan.shanmugam@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 3/3] drm/amdgpu: correct chunk_ptr to a pointer to chunk.
Date:   Wed, 22 Nov 2023 10:36:55 -0500
Message-ID: <20231122153658.853640-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153658.853640-1-sashal@kernel.org>
References: <20231122153658.853640-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.330
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
index 7bad519aaae08..d24ef103471b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -113,7 +113,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, void *data)
 	}
 
 	for (i = 0; i < p->nchunks; i++) {
-		struct drm_amdgpu_cs_chunk __user **chunk_ptr = NULL;
+		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
 		uint32_t __user *cdata;
 
-- 
2.42.0

