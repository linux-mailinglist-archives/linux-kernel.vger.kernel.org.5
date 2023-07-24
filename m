Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96D975E6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGXBXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGXBWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:22:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E7E70;
        Sun, 23 Jul 2023 18:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE9BF60F1B;
        Mon, 24 Jul 2023 01:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0349AC433C7;
        Mon, 24 Jul 2023 01:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161693;
        bh=41akV9aCIbb+q0fXnma+2Q7+GIaQ0GcY2524wd7N22E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjZw/+nr8hi3liKiDvGCwEoZan/qFk6yZ2I7IWhoJ/4HqkoxqE6S6p2NrrT2XezdD
         zRdJtwJlgngLuF0y3uNGaeDUIPLqYHjV6ofwiZ6PCAxmKkWuR23jcGMGzY+i0S7j1d
         89MvM4AC6P4P2VGxK6P5DOGg7DdpnFXcAK6VEbWp5S/AqHI7HZbTC2AsJxHsUugIFR
         QsvuRQO+jaFK3zRutwl2ZXGMC60bcS1Uw8IzMp8X2/IbJmRLRS5W1jPtD+d4+xVdLr
         tmiTxw1fI/dKc91nB52XeNIPF4bzMuC+DreZmTAz+fYiYkZ5uTH4mLw7gQsxGdLvB5
         0Xfcwa/LgEDqw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     hackyzh002 <hackyzh002@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, luben.tuikov@amd.com,
        Felix.Kuehling@amd.com, dongchenchen2@huawei.com,
        Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 04/41] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
Date:   Sun, 23 Jul 2023 21:20:37 -0400
Message-Id: <20230724012118.2316073-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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

From: hackyzh002 <hackyzh002@gmail.com>

[ Upstream commit 87c2213e85bd81e4a9a4d0880c256568794ae388 ]

The type of size is unsigned int, if size is 0x40000000, there will
be an integer overflow, size will be zero after size *= sizeof(uint32_t),
will cause uninitialized memory to be referenced later.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 365e3fb6a9e5b..34a64493bfe2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -188,7 +188,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	uint64_t *chunk_array_user;
 	uint64_t *chunk_array;
 	uint32_t uf_offset = 0;
-	unsigned int size;
+	size_t size;
 	int ret;
 	int i;
 
-- 
2.39.2

