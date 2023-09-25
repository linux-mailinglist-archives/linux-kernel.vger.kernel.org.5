Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D33C7ADC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjIYP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjIYP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:59:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FADB6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:59:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBFDC433C7;
        Mon, 25 Sep 2023 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695657575;
        bh=pFhRBn5GwxIYPM5GA2ar9CKtCGC8fLy/cMk2rpqwfMs=;
        h=From:To:Cc:Subject:Date:From;
        b=nKpHcquP8+qpdZLt67K5VWTRQ8F8VHGeW/s/Uz3bRUjhSCUGIAO+M62heq3Ln1oUn
         BqVhK74g1ZwO18Z5q6UibGNz7cIKYIR3WW9ClQMzEHD5hkJrjK/wxKssL+o3fJ6/OL
         jw/8SYU144MTXKzTsTSrGnvZVkp2lXbJX2Fa+4khSVpxapdA7DL2SFYKPdQMgQITk8
         Np9XMbUqHAvK4U5R4bItqWB48mk+z7SiLTVMBVYEMvFJwexE9Ro1sD1OpxkYjPilNw
         8rp3eC13Yq4SqzPQqk0oaD6QYJnBWKiar39Rl52y26Eu+GcHAxtMMZ/YHNUXqQsNlt
         k1TxET8DZlTOQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Danilo Krummrich <me@dakr.org>, Ben Skeggs <bskeggs@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wayne Lin <Wayne.Lin@amd.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/kms/nv50: hide unused variables
Date:   Mon, 25 Sep 2023 17:59:24 +0200
Message-Id: <20230925155930.677620-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

After a recent change, two variables are only used in an #ifdef:

drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_sor_atomic_disable':
drivers/gpu/drm/nouveau/dispnv50/disp.c:1569:13: error: unused variable 'ret' [-Werror=unused-variable]
 1569 |         int ret;
      |             ^~~
drivers/gpu/drm/nouveau/dispnv50/disp.c:1568:28: error: unused variable 'aux' [-Werror=unused-variable]
 1568 |         struct drm_dp_aux *aux = &nv_connector->aux;
      |                            ^~~

Move them into the same conditional block, along with the nv_connector variable
that becomes unused during that fix.

Fixes: 757033808c95b ("drm/nouveau/kms/nv50-: fixup sink D3 before tearing down link")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 52f1569ee37c1..a0ac8c258d9ff 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1560,15 +1560,13 @@ nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *st
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct nv50_head *head = nv50_head(nv_encoder->crtc);
-	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
+	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nouveau_backlight *backlight = nv_connector->backlight;
-#endif
 	struct drm_dp_aux *aux = &nv_connector->aux;
 	int ret;
 
-#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	if (backlight && backlight->uses_dpcd) {
 		ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
 		if (ret < 0)
-- 
2.39.2

