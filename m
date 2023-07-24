Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B30175E7AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjGXB3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjGXB22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A985E212E;
        Sun, 23 Jul 2023 18:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62E9160F7B;
        Mon, 24 Jul 2023 01:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5D3C433C9;
        Mon, 24 Jul 2023 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161892;
        bh=3ASJJggsxaos/WuiwhkJ0XLXgPLaNAuVAqbfvrCOV8A=;
        h=From:To:Cc:Subject:Date:From;
        b=GwrV7vYKkI2+HIH58UjSlUNOuvTqKo/0R0UEbuZXIXLHaKbttjV3B4pFPjHIfehW6
         R/PJn+WzFZt6JGKVoQrP88mzfKtClqNCNYmwLxQ34L79VDzb1agjxKNjqeYg+lyg1j
         zYftE9hx+kpEASqYSjE3m8DWA/2JLVzWsnGh/NHMH8FGvzddV0ghnund+WcZbYhDOE
         d0gsCyX/th2bXBZ3IbXfk2qZCJLYuyDBat08NMPA9OtW8l0m0L1b8h0ossAmXiXl7C
         q9WaMNIKXeZ5pPKhxMGX3mvXX/Ka5gOYo+0EAJT2ug2hOaqxQx2RrYA7WgJ7i3U53D
         foa6hOBbpoNkQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     hackyzh002 <hackyzh002@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 1/9] drm/radeon: Fix integer overflow in radeon_cs_parser_init
Date:   Sun, 23 Jul 2023 21:24:35 -0400
Message-Id: <20230724012450.2320077-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.320
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

[ Upstream commit f828b681d0cd566f86351c0b913e6cb6ed8c7b9c ]

The type of size is unsigned, if size is 0x40000000, there will be an
integer overflow, size will be zero after size *= sizeof(uint32_t),
will cause uninitialized memory to be referenced later

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index 1ae31dbc61c64..5e61abb3dce5c 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -265,7 +265,8 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
 {
 	struct drm_radeon_cs *cs = data;
 	uint64_t *chunk_array_ptr;
-	unsigned size, i;
+	u64 size;
+	unsigned i;
 	u32 ring = RADEON_CS_RING_GFX;
 	s32 priority = 0;
 
-- 
2.39.2

