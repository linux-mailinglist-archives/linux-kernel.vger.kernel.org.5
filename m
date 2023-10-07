Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858CD7BC45A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 05:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbjJGDSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 23:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjJGDSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 23:18:39 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D62B0BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 20:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3NUit
        ICBhSCtbw7Vlya/QRr1+OuCRgNgVY92wWYt9kc=; b=A0/b+9/bwMMo9z9RmveY5
        Vh5zJx+MPY8ueuREbEXgcyhm5Mh6dCGoahMvd3WBpqmDj2kfkz6GMenAhGX9oDun
        cEo0CMLC1Y9g5y7tjvS97R+pEo+Dk68kH5it05ITg8S2Mwbly1I5WQWMOoCj+2BW
        Iw/SMAASS7tp/WH7jJPim4=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wDXbMK6zSBl0sglEA--.50228S4;
        Sat, 07 Oct 2023 11:17:23 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        lyude@redhat.com, mripard@kernel.org,
        u.kleine-koenig@pengutronix.de, noralf@tronnes.org,
        tzimmermann@suse.de, make_ruc2021@163.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i2c/ch7006: fix a possible null pointer dereference
Date:   Sat,  7 Oct 2023 11:17:12 +0800
Message-Id: <20231007031712.3997144-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXbMK6zSBl0sglEA--.50228S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1rZr4fAF1kKw1xZr45trb_yoWDGrb_u3
        W0vr9xur4UZ3Z3Ar4jyFy3Ary0yF1UAFs3KrsIkay0ya9rXwnIq345Xa48XFW7uFWUAFn0
        qa43CF4fAFnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM189JUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbivgMCC1ZcjAI-mQAAsW
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ch7006_encoder_get_modes(), the return value of drm_mode_duplicate()
is assigned to mode, which will lead to a NULL pointer dereference
on failure of drm_mode_duplicate(). Add a check to avoid npd.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/gpu/drm/i2c/ch7006_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
index 131512a5f3bd..27c2f02f5b43 100644
--- a/drivers/gpu/drm/i2c/ch7006_drv.c
+++ b/drivers/gpu/drm/i2c/ch7006_drv.c
@@ -236,8 +236,10 @@ static int ch7006_encoder_get_modes(struct drm_encoder *encoder,
 		    ~mode->valid_norms & 1<<priv->norm)
 			continue;
 
-		drm_mode_probed_add(connector,
-				drm_mode_duplicate(encoder->dev, &mode->mode));
+		struct drm_display_mode *encoder_mode;
+		encoder_mode = drm_mode_duplicate(encoder->dev, &mode->mode);
+		if (!mode)
+			continue;
 
 		n++;
 	}
-- 
2.37.2

