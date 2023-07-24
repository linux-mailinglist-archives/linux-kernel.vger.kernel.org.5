Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B4975E8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjGXBpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjGXBnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:43:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C2430F0;
        Sun, 23 Jul 2023 18:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AC5961006;
        Mon, 24 Jul 2023 01:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F331FC433C7;
        Mon, 24 Jul 2023 01:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162430;
        bh=j/inPhAJbq/AI9Jk+HeW4401HKZVfSwN8Xb4vFhq9iE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=huobI+SKnPLd3MoBsytz8XNvljnOQmfQt4FZJp6uBZWZO3Ej1zV5AfOtc3XAPevkv
         ldZ7yrYK/cLLoLV7r80qtjCjwH8fNcKMqia0e3cRiZQe+DoUETxPXrPRfME24fJcV4
         3zMwm5bSmVk45N4VwZ+bMvChucbnL0wKXmmbY5rAf9kcc69G8oAnqWvj0Ej4E/LO3a
         ALMTKXz8Ogwz9vhg59cO8M1yCR37yXG/O8T2U4rJx1JwAV6nkF3vKfhpBdl64Z0el+
         +S8PBEjArhk7PUtl2WklN+VZ66N2znBPr8y2pqw+EF7VI85gvVIFEo30QHyxAFEMz+
         PUWax3jsH2Dqw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     shanzhulig <shanzhulig@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 17/24] drm/amdgpu: Fix potential fence use-after-free v2
Date:   Sun, 23 Jul 2023 21:33:18 -0400
Message-Id: <20230724013325.2332084-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013325.2332084-1-sashal@kernel.org>
References: <20230724013325.2332084-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
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
index 2fd4d8ad7e40d..4b01188385b28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1541,15 +1541,15 @@ static int amdgpu_cs_wait_all_fences(struct amdgpu_device *adev,
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

