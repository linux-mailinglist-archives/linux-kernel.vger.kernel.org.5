Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D3F7B0224
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjI0KpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjI0KpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:45:11 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB16013A;
        Wed, 27 Sep 2023 03:45:07 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 6DD891867E3A;
        Wed, 27 Sep 2023 13:45:03 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nNZF-6neTcXu; Wed, 27 Sep 2023 13:45:03 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id DB4EF1867DA8;
        Wed, 27 Sep 2023 13:45:02 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K11eK_b7uODQ; Wed, 27 Sep 2023 13:45:02 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.236.148])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 3AC741867E3A;
        Wed, 27 Sep 2023 13:45:01 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH v2] drm: rcar-du: turn rcar_du_group_get() into void and remove its return value check
Date:   Wed, 27 Sep 2023 13:44:38 +0300
Message-Id: <20230927104438.30628-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <169383224922.277971.15400887308406098634@ping.linuxembedded.co.uk>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcar_du_group_get() never returns a negative
error code (always returns 0), so change the comment
about returned value, turn function into void (return
code of rcar_du_group_get has been redundant for a
long time, so perhaps it's just not required) and
remove redundant error path handling in rcar_du_crtc_get()

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0bb63534fdf3 ("drm: rcar-du: Perform the initial CRTC setup from r=
car_du_crtc_get()")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
v2: rcar_du_group_get() is turned into void and its return=20
value check is removed in rcar_du_crtc_get()
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c  | 6 +-----
 drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c | 5 +----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c b/drivers/gpu=
/drm/renesas/rcar-du/rcar_du_crtc.c
index 7e175dbfd892..2be7c6e64d72 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
@@ -565,17 +565,13 @@ static int rcar_du_crtc_get(struct rcar_du_crtc *rc=
rtc)
 	if (ret < 0)
 		goto error_clock;
=20
-	ret =3D rcar_du_group_get(rcrtc->group);
-	if (ret < 0)
-		goto error_group;
+	rcar_du_group_get(rcrtc->group);
=20
 	rcar_du_crtc_setup(rcrtc);
 	rcrtc->initialized =3D true;
=20
 	return 0;
=20
-error_group:
-	clk_disable_unprepare(rcrtc->extclock);
 error_clock:
 	clk_disable_unprepare(rcrtc->clock);
 	return ret;
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c b/drivers/gp=
u/drm/renesas/rcar-du/rcar_du_group.c
index 2ccd2581f544..7113025dabff 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
@@ -199,10 +199,8 @@ static void rcar_du_group_setup(struct rcar_du_group=
 *rgrp)
  * before accessing any hardware registers.
  *
  * This function must be called with the DRM mode_config lock held.
- *
- * Return 0 in case of success or a negative error code otherwise.
  */
-int rcar_du_group_get(struct rcar_du_group *rgrp)
+void rcar_du_group_get(struct rcar_du_group *rgrp)
 {
 	if (rgrp->use_count)
 		goto done;
@@ -211,7 +209,6 @@ int rcar_du_group_get(struct rcar_du_group *rgrp)
=20
 done:
 	rgrp->use_count++;
-	return 0;
 }
=20
 /*
--=20
2.30.2

