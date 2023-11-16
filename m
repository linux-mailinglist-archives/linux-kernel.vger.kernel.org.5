Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB8A7EDBAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjKPGwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPGwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:52:20 -0500
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250E8196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:52:14 -0800 (PST)
Received: from mail.nppct.ru (localhost [127.0.0.1])
        by mail.nppct.ru (Postfix) with ESMTP id 331291C0D49
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:52:11 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :date:subject:subject:to:from:from; s=dkim; t=1700117530; x=
        1700981531; bh=K3YRmKofc6N6uINNSmeFkKZnxYRW32B+l0K9TQS6g74=; b=f
        zvySR4TFRoqaZp0rWO0uVqXf6kj06TaABLkINcz/GlJYHCU0hlf/jg9RV07mrSBE
        s90tYgzMV+Jy2RGLb8SWeo1HFpQZJdKikzGZufvwTa9qjeEGC4d0keLQMNV+LSZF
        YnPDYb/UzYF2CG8zQbNrJ7wYiBX7b9GdwUqwNEZa3g=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
        by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MWzU3XDIG0GN for <linux-kernel@vger.kernel.org>;
        Thu, 16 Nov 2023 09:52:10 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
        by mail.nppct.ru (Postfix) with ESMTPSA id D04BC1C061A;
        Thu, 16 Nov 2023 09:52:07 +0300 (MSK)
From:   Andrey Shumilin <shum.sdl@nppct.ru>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Andrey Shumilin <shum.sdl@nppct.ru>, Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Jani Nikula <jani.nikula@intel.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, khoroshilov@ispras.ru,
        ykarpov@ispras.ru, vmerzlyakov@ispras.ru, vefanov@ispras.ru
Subject: [PATCH] tvnv17.c: Adding a NULL pointer check.
Date:   Thu, 16 Nov 2023 09:51:59 +0300
Message-Id: <20231116065159.37876-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to dereference a null pointer if drm_mode_duplicate() returns NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index 670c9739e5e1..1f0c5f4a5fd2 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -209,7 +209,8 @@ static int nv17_tv_get_ld_modes(struct drm_encoder *encoder,
 		struct drm_display_mode *mode;
 
 		mode = drm_mode_duplicate(encoder->dev, tv_mode);
-
+		if (mode == NULL)
+			continue;
 		mode->clock = tv_norm->tv_enc_mode.vrefresh *
 			mode->htotal / 1000 *
 			mode->vtotal / 1000;
@@ -258,6 +259,8 @@ static int nv17_tv_get_hd_modes(struct drm_encoder *encoder,
 		if (modes[i].hdisplay == output_mode->hdisplay &&
 		    modes[i].vdisplay == output_mode->vdisplay) {
 			mode = drm_mode_duplicate(encoder->dev, output_mode);
+			if (mode == NULL)
+				continue;
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		} else {
-- 
2.30.2

