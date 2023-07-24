Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7400075E615
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGXBOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGXBOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:14:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F05E10EC;
        Sun, 23 Jul 2023 18:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08A3D60EFB;
        Mon, 24 Jul 2023 01:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BE0C433CA;
        Mon, 24 Jul 2023 01:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161243;
        bh=/OAx81oXf+Sgc5G8llzSkZ0rBNM5DS8RqudljSSGI5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otEOWpT0q9zh3T/2TUmanhK4EiaW3IvJwDwmoT3FSDJSXpZmYRYCtekArAzbqDkuY
         wSj2nA/o8r50Vdg/k0vsIywN/oVcUFF+KiaVXlvZaexZCIwpB/eu8spR4+3OCvfQuE
         5OBn0OD324Q0Ag9b/v8MCSH+fpFr8OKLonzMfNivdi5EroX5kdti76PmRQKWd9Y5xq
         6x0nAtk4/TefAp1ioqqj0jOw2I9y6EiGh6FZlBwbHvBPwueKFWw4JDirZJwWS7RkRJ
         NRFNkFXf3jnXV7UJRVhsvWLZlBG4lka4XkQ79Ik0jBIn5nmsUmrD+bkjGZTlw882fU
         fWAP3yWIa+AXQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jack Xiao <Jack.Xiao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Victor.Zhao@amd.com, luben.tuikov@amd.com, Jiadong.Zhu@amd.com,
        bas@basnieuwenhuizen.nl, srinivasan.shanmugam@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 07/58] drm/amdgpu: fix memory leak in mes self test
Date:   Sun, 23 Jul 2023 21:12:35 -0400
Message-Id: <20230724011338.2298062-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Xiao <Jack.Xiao@amd.com>

[ Upstream commit 31d7c3a4fc3d312a0646990767647925d5bde540 ]

The fences associated with mes queue have to be freed
up during amdgpu_ring_fini.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 49de3a3eebc78..de04606c2061e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -361,6 +361,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 		amdgpu_bo_free_kernel(&ring->ring_obj,
 				      &ring->gpu_addr,
 				      (void **)&ring->ring);
+	} else {
+		kfree(ring->fence_drv.fences);
 	}
 
 	dma_fence_put(ring->vmid_wait);
-- 
2.39.2

