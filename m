Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22D67E3F70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjKGM5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbjKGM45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:56:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A014AD0B;
        Tue,  7 Nov 2023 04:29:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8109FC433C9;
        Tue,  7 Nov 2023 12:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360140;
        bh=7wbJdA3ghOcU/xwQGrXIOSq9/8v6+kYwE1zY/1YVvWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0ihbdil1CE5jFw7gCgBbVtOmBrErRaI+7vbEculHKXlPj91q/Jj5O0adS+TuJplC
         JOOgfL5kmgKUSXYsRdKvrkZ3cPlT66L2eX3YQJLWMzsdDN1hiycnYp83rljSGKKrbM
         k+y6go0iAS9ch2aQTocOpns0vd4rdeQWJu0Ropa+diY1G+9etbaQ/XEID/ctTJXFUN
         26gWNn7Sq5US7cRjyPipk34Vd6vI/7DWOr38ubbM93SYYLTHxeFWjnVk62aHJvRwLl
         3+S3VEGUHOfgoMkx4e4ZeaMX/EpZWIu6b3Q9PYJgx7XowjYLiNCQWIiqqi9U8FMNPo
         oKjOq+6qRKCug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        guchun.chen@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 20/25] drm/amdgpu/vkms: fix a possible null pointer dereference
Date:   Tue,  7 Nov 2023 07:26:59 -0500
Message-ID: <20231107122745.3761613-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122745.3761613-1-sashal@kernel.org>
References: <20231107122745.3761613-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit cd90511557fdfb394bb4ac4c3b539b007383914c ]

In amdgpu_vkms_conn_get_modes(), the return value of drm_cvt_mode()
is assigned to mode, which will lead to a NULL pointer dereference
on failure of drm_cvt_mode(). Add a check to avoid null pointer
dereference.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d60c4a2eeb0c5..06980b8527ff8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -239,6 +239,8 @@ static int amdgpu_vkms_conn_get_modes(struct drm_connector *connector)
 
 	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
+		if (!mode)
+			continue;
 		drm_mode_probed_add(connector, mode);
 	}
 
-- 
2.42.0

