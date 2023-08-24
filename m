Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7BB7868B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbjHXHiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbjHXHi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176AC173F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A324465D8A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06097C433CC;
        Thu, 24 Aug 2023 07:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692862701;
        bh=XMLhGP3gS/GA5ugfwBvBA9rFCKno1toIUnNgJ1XxmRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfHCZhGIEbSono5ZPGTva+4svqck8IBZDnL/u9eLKYfW1VIZSZxjrA7vkzj4DvJ1m
         qJYJ4KNKn1Doi63djOyJ3wu3g4PRXvFX2o8vOw/+qRmmbMgLGnUFwG1nvAcgtRvJ5b
         e9oSsvjdTUwAQejOWe9yRaCNWjn3pAW2dNYz+5EIcEaJGO3g/07RkI0Q3VSFqaiRrZ
         qRz/wS4Z65fKN5ogo6pg0Vc4zsRvDrX8pYHWOwL4YzPHaAKEdNUqJ+ZUr3y7FKYdrd
         0+Vfq9nkp0ps8vzcVR3p2bbMJ/ituWnRr28BsSrxh7L0PtNt+2KxaxC1Jz7w3vihxa
         raVHq0iG30JWQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 19/20] drm/amd/amdgpu/amdgpu_sdma: Increase buffer size to account for all possible values
Date:   Thu, 24 Aug 2023 08:37:04 +0100
Message-ID: <20230824073710.2677348-20-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824073710.2677348-1-lee@kernel.org>
References: <20230824073710.2677348-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c: In function ‘amdgpu_sdma_init_microcode’:
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:217:64: warning: ‘.bin’ directive output may be truncated writing 4 bytes into a region of size between 0 and 32 [-Wformat-truncation=]
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:217:17: note: ‘snprintf’ output between 13 and 52 bytes into a destination of size 40
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:215:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:215:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40

Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index e2b9392d7f0de..572f861e3f706 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -208,7 +208,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 	const struct sdma_firmware_header_v2_0 *sdma_hdr;
 	uint16_t version_major;
 	char ucode_prefix[30];
-	char fw_name[40];
+	char fw_name[52];
 
 	amdgpu_ucode_ip_version_decode(adev, SDMA0_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	if (instance == 0)
-- 
2.42.0.rc1.204.g551eb34607-goog

