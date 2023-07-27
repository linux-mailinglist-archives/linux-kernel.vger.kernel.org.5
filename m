Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708E87653C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjG0MZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjG0MZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D823C01
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8416D61E5D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A583DC433C7;
        Thu, 27 Jul 2023 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460658;
        bh=I5/OzNyWa4cq5lqW1SUiyYV4KV0DfEq9gMsgUWKzfA4=;
        h=From:To:Cc:Subject:Date:From;
        b=Wn40rLoxS6gKTnyr8X7QiWA9zo/IOmJfXxG60tMscbeBoJMA+CNIaOzZywmMphcfO
         DDfis9+PTBq8FYyHycTvonWDT1kQW1nw5M+22GXGDZJprpyFSSma8wtbvOA9jkwI9J
         MjOLVzTkHfZhQOxI0k19o9wOSIgRpI/WHARfWFO8XY8c/8KrELx7M+2j19uJoD8hws
         h1PZjri9PtRn+TMHhcSHg3KDRVG5eDe+hqeIimD4q3jK47PT/lkYxYnIBNEWJBKvSQ
         I0wPqf9/COE8bK2PWJGK18MpLIzatLd0UscbWaVjHd1v54/rck0TVNezXJruCL/wBX
         6XsvYfN4N2YoQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ssd130x: drop DRM_GEM_SHADOW_PLANE_FUNCS override
Date:   Thu, 27 Jul 2023 14:24:06 +0200
Message-Id: <20230727122412.2464210-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

It is not possible for ssd130x_primary_plane_funcs to use both
its own reset/duplicate/destroy callbacks and the ones from
DRM_GEM_SHADOW_PLANE_FUNCS:

In file included from drivers/gpu/drm/solomon/ssd130x.c:29:
include/drm/drm_gem_atomic_helper.h:100:18: error: initialized field overwritten [-Werror=override-init]
  100 |         .reset = drm_gem_reset_shadow_plane, \
  101 |         .atomic_duplicate_state = drm_gem_duplicate_shadow_plane_state, \
  102 |         .atomic_destroy_state = drm_gem_destroy_shadow_plane_state
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/solomon/ssd130x.c:744:9: note: in expansion of macro 'DRM_GEM_SHADOW_PLANE_FUNCS'
  744 |         DRM_GEM_SHADOW_PLANE_FUNCS,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~

Since the custom callbacks were just added, I assume these are the
ones it is meant to use, so remvoe the generic overrides.

Fixes: 45b58669e532b ("drm/ssd130x: Allocate buffer in the plane's .atomic_check() callback")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/solomon/ssd130x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index d2f8dd6a6347a..479de42307c88 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -741,7 +741,6 @@ static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
 	.atomic_duplicate_state = ssd130x_primary_plane_duplicate_state,
 	.atomic_destroy_state = ssd130x_primary_plane_destroy_state,
 	.destroy = drm_plane_cleanup,
-	DRM_GEM_SHADOW_PLANE_FUNCS,
 };
 
 static enum drm_mode_status ssd130x_crtc_helper_mode_valid(struct drm_crtc *crtc,
-- 
2.39.2

