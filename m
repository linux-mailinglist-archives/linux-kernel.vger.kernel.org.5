Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960737A5A98
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjISHNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjISHNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:13:18 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6277F11A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:13:12 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9A1631257;
        Tue, 19 Sep 2023 09:11:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695107495;
        bh=xZVjIvalSzQChhfXM3j4TPEPuazse+0jkiMMdkmQ7Pk=;
        h=From:Date:Subject:To:Cc:From;
        b=KkBoDGIgk38Co4MW4PgTzVY9bz0vl7XF2Ww19fked3AnfLzZfqonUAD/+ofJOScqZ
         TdcZrTRanp+2ef5hInKzQWpZXpjyByFolFKmWxkf7vQjzBz0RQKQis3NVLn5Y5Yvuc
         6JiHncCB1qY0vieyZZJhOckJG7rA/L5rk9ZdSPNY=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Tue, 19 Sep 2023 10:12:50 +0300
Subject: [PATCH] drm/tilcdc: Fix irq free on unload
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-lcdc-v1-1-ba60da7421e1@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAPJJCWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0NL3ZzklGRdy1QDy1RLkzSTVEtjJaDSgqLUtMwKsDHRsbW1AMs3i6Z
 WAAAA
To:     Jyri Sarha <jyri.sarha@iki.fi>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=xZVjIvalSzQChhfXM3j4TPEPuazse+0jkiMMdkmQ7Pk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlCUoFClz12Kf0TeatkDF632nSj6atk0CLo4eYi
 ojwO7tDmLyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZQlKBQAKCRD6PaqMvJYe
 9eYWD/9DdFAzLQKYPEOpgXfOvjSz5wq8S4H1BjOBYiTM391/1QqLLuKta8ZsR0km0HmeayeTKkf
 UYN4/bpKomWgInJbdz7lFfcSVzwOB3lSTdSBltwVxFvqdMEmwv4qKJe93jfV1OBxYzaYM5DZiEr
 bO+Vq9KvfcDBi3O10LLfhAQ+ivEzIR+L666IU6jcxEt/0LJBX6V2cT8iEbr0CZvBIW4VBXycLhz
 BYjZxOjdvDAWCL/XyJGnNExuGR4xIBg4Tq+/jTjU1QuBvdBLopDz2k+DdogyWTffTlb9AQaU7jI
 O8zHVPZJw/pRtMCighR4UBDbgl6a5vQGxQH5rOnktRKe7RyBXEdnj54xLSkJtbujf4x0Yuu7HR+
 zFhMBIowUaToZ6TeKPmlMGivYwZKeX+sUgJPVWesz4+bRsVZr2oN3Utg4t3ysXGxM2oMw8Ia4cb
 /Oi7XcMVhj/1fbgF7rB0iDAVXn1sElHp9/bIUHhc/rUvBDIwbyF3paro/zMmoGzilN013RG6DST
 8MVbB8NKFBWUc6SYCcTwaYIuSgCfJL6IPT8sUZpXuK+rdOT5mKTxFoEwsyllq9fiCIWWYYKKj7E
 LcqTFbR0ueQHA8gZW5UPPbaeabDmf069NiQm+g7YTzOtkW+wuOXexUPtTN+IVybxZUycjrNvMd6
 pJP1YijEgNTYUQQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only frees the reserved irq if priv->irq_enabled is set to
true. However, the driver mistakenly sets priv->irq_enabled to false,
instead of true, in tilcdc_irq_install(), and thus the driver never
frees the irq, causing issues on loading the driver a second time.

Fixes: b6366814fa77 ("drm/tilcdc: Convert to Linux IRQ interfaces")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index fe56beea3e93..83233bdc0526 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -138,7 +138,7 @@ static int tilcdc_irq_install(struct drm_device *dev, unsigned int irq)
 	if (ret)
 		return ret;
 
-	priv->irq_enabled = false;
+	priv->irq_enabled = true;
 
 	return 0;
 }

---
base-commit: 0663e1da5ba8e6459e3555ac12c62741668c0d30
change-id: 20230919-lcdc-9e09e94f4e93

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

