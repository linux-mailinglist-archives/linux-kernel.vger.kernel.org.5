Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836E77E3ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjKGMmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjKGMmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:42:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164F128FDD;
        Tue,  7 Nov 2023 04:30:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FD0C433C9;
        Tue,  7 Nov 2023 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360201;
        bh=oEW4teOA0IO0tNyBhZ2GCZBK0Z+6b+0Q+RkNcTqwzwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDvPj5tI+kZfWlN8PJHjDRENEuEV+e3KjCG9jgdYU2arLupqalMd3nssTMwO83VlB
         jlNaoIoHJ1uO4nYPEdv1ChylKoHfRQ9TUxtGbmKBJUbP2EPMKf9PJMtifVEZDlMjF7
         RUkimIe7rNyR3DyyIoPCugFBT4OV0v+D3wn9X4E954PYeuhkG+vkklzyB8Xz8ngQNQ
         l/Yl0+sxSdRpRqSrmfbp9BRsp3+yxQVkZJA85NYd4SD+mLKl2T5p11szpBmWXPuL4r
         fYNWD4CuwCDPusz6svqt64I9qZq5yYviu4tC3iyPcmwO6nvGuRYH/cBsllMmNqHXkc
         cbSAnCIHjWjRQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Zack Rusin <zackr@vmware.com>, Sasha Levin <sashal@kernel.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 07/20] drm: vmwgfx_surface.c: copy user-array safely
Date:   Tue,  7 Nov 2023 07:29:01 -0500
Message-ID: <20231107122940.3762228-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122940.3762228-1-sashal@kernel.org>
References: <20231107122940.3762228-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit 06ab64a0d836ac430c5f94669710a78aa43942cb ]

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920123612.16914-7-pstanner@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 5d53a5f9d1237..872af7d4b3fc9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -807,9 +807,9 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
 	metadata->num_sizes = num_sizes;
 	user_srf->size = size;
 	metadata->sizes =
-		memdup_user((struct drm_vmw_size __user *)(unsigned long)
+		memdup_array_user((struct drm_vmw_size __user *)(unsigned long)
 			    req->size_addr,
-			    sizeof(*metadata->sizes) * metadata->num_sizes);
+			    metadata->num_sizes, sizeof(*metadata->sizes));
 	if (IS_ERR(metadata->sizes)) {
 		ret = PTR_ERR(metadata->sizes);
 		goto out_no_sizes;
-- 
2.42.0

