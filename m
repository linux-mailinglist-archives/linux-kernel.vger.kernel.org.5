Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CBC75E926
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjGXBro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjGXBrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA59F5BAB;
        Sun, 23 Jul 2023 18:39:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 738C861049;
        Mon, 24 Jul 2023 01:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91EDC433AB;
        Mon, 24 Jul 2023 01:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162481;
        bh=5u/MPRip0GYP74lNh3itFrtvy/KBx9XpRw6JHaGgqPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvtCddGjWb/8snwY5uVBn24Uu3B+Imq7QKhsqhwgv5Pc0fhh8wuQrPK4USSQEyUXV
         5SKs7dFHXOpGa/Mesb+ksboTC1mD8lU9SZGtwk4MSv6jSB3Kv8NaqYICyQwAwQQynw
         icqRLRO/P1BiT85u3JNimcTQPhK/ndJg/1KslyhYIJMfjbq5tPwuvkXw28jWwAHX4b
         D3fULjFjiqbrZpT6kbTPvRu6ctc/xQxYFe2Lc0llSBXdBMTLuOoP26u02OnFNn3OLI
         U45EkXorumfgDXxZNHCvfUF15sTTeABAj8S0bzUmD6hveUfDaqs3QLiXhovk2u3Faq
         DMOrW7oGWzBtg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     shanzhulig <shanzhulig@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 10/12] drm/amdgpu: Fix potential fence use-after-free v2
Date:   Sun, 23 Jul 2023 21:34:23 -0400
Message-Id: <20230724013426.2333833-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013426.2333833-1-sashal@kernel.org>
References: <20230724013426.2333833-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.249
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
index 7eeb98fe50ed7..0e478d4d830c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1575,15 +1575,15 @@ static int amdgpu_cs_wait_all_fences(struct amdgpu_device *adev,
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

