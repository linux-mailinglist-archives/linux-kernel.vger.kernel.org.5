Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C02A75E946
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjGXBuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjGXBtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:49:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E6746B4;
        Sun, 23 Jul 2023 18:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F5AC60F5B;
        Mon, 24 Jul 2023 01:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CBBC433C7;
        Mon, 24 Jul 2023 01:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162539;
        bh=3b5m24aNDedcg8G6NTX+DMnLf9Y2l++WmDBaV7lwolk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6qXjPz3GL85YHGazFej+LQUucxKZ+N7/t2B6OTRo+R+TfgQ91FalsiyNJA8GqJqZ
         Tk1ywWh16SqGqglciE+SUzU5NeXf8HnUFRu1ZHKrcaFDP1GCkEP10kUm1+YErfGynr
         E3/wFMi2Wql5YIcz59DBblw6YB6BPzim+RA/Ld8zMz24ikEpED3ufrJ31w+l436mNV
         lS++bHfgE3SQb4JB8IqXhi4MsQrh4P4pntSVxtbIDs+ShFy6mPU696g+vRtyFE4AO0
         bjR/LUuC8ZZI6Xwf4ck1rG/QTQCdgk9dTm7sYWwiCGDScSNxmKrPqLdXz2BDefhbdm
         7CtmDgt0rbvpg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     shanzhulig <shanzhulig@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 9/9] drm/amdgpu: Fix potential fence use-after-free v2
Date:   Sun, 23 Jul 2023 21:34:45 -0400
Message-Id: <20230724013445.2334326-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013445.2334326-1-sashal@kernel.org>
References: <20230724013445.2334326-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.288
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: shanzhulig <shanzhulig@gmail.com>

[ Upstream commit 2e54154b9f27262efd0cb4f903cc7d5ad1fe9628 ]

fence Decrements the reference count before exiting.
Avoid Race Vulnerabilities for fence use-after-free.

v2 (chk): actually fix the use after free and not just move it.

Signed-off-by: shanzhulig <shanzhulig@gmail.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e667bcf64bc7f..70e446c2acf82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1502,15 +1502,15 @@ static int amdgpu_cs_wait_all_fences(struct amdgpu_device *adev,
 			continue;
 
 		r = dma_fence_wait_timeout(fence, true, timeout);
+		if (r > 0 && fence->error)
+			r = fence->error;
+
 		dma_fence_put(fence);
 		if (r < 0)
 			return r;
 
 		if (r == 0)
 			break;
-
-		if (fence->error)
-			return fence->error;
 	}
 
 	memset(wait, 0, sizeof(*wait));
-- 
2.39.2

