Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0C07B4C89
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbjJBHaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbjJBHaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:30:02 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C246B7;
        Mon,  2 Oct 2023 00:29:59 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 6181F18651E1;
        Mon,  2 Oct 2023 10:29:57 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MhpPlMfsexIS; Mon,  2 Oct 2023 10:29:56 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id CEFB51862F42;
        Mon,  2 Oct 2023 10:29:56 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AGFD1h-Y19PO; Mon,  2 Oct 2023 10:29:56 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.232.254])
        by mail.astralinux.ru (Postfix) with ESMTPSA id CF8D41863156;
        Mon,  2 Oct 2023 10:29:54 +0300 (MSK)
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
Subject: [PATCH v3] drm: rcar-du: turn rcar_du_group_get() into void and remove its return value check
Date:   Mon,  2 Oct 2023 10:29:17 +0300
Message-Id: <20231002072917.22194-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230930145032.GD31829@pendragon.ideasonboard.com>
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
v3: fix build errors
v2: rcar_du_group_get() is turned into void and its return=20
value check is removed in rcar_du_crtc_get()
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c  | 6 +-----
 drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c | 5 +----
 drivers/gpu/drm/renesas/rcar-du/rcar_du_group.h | 2 +-
 3 files changed, 3 insertions(+), 10 deletions(-)

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
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.h b/drivers/gp=
u/drm/renesas/rcar-du/rcar_du_group.h
index 55649ad86a10..5330dc4ce64a 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.h
@@ -54,7 +54,7 @@ struct rcar_du_group {
 u32 rcar_du_group_read(struct rcar_du_group *rgrp, u32 reg);
 void rcar_du_group_write(struct rcar_du_group *rgrp, u32 reg, u32 data);
=20
-int rcar_du_group_get(struct rcar_du_group *rgrp);
+void rcar_du_group_get(struct rcar_du_group *rgrp);
 void rcar_du_group_put(struct rcar_du_group *rgrp);
 void rcar_du_group_start_stop(struct rcar_du_group *rgrp, bool start);
 void rcar_du_group_restart(struct rcar_du_group *rgrp);
--=20
2.30.2

