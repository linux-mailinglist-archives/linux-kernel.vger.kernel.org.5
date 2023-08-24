Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE0C7868B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbjHXHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjHXHiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA47DC7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58A1565CD5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4046C433C7;
        Thu, 24 Aug 2023 07:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692862685;
        bh=Dk8iyOyFggoB4EAzE/YjAU2+gPq8/lElJKWAaFnOoqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFMzcDocYu5qJE0nqzVZdFuYHkgjWFhcb+ESDiqEszUjE9SMw3zgXQukSHH1cxzzD
         R7fOHxw628wRKYtkeWd4BpUiY+hOMkJjFgm4pXVW9Odzu8qLYXPOmByNyGVvRIDy1s
         5JCNl8iVNNE2gKRU5wFOI5Zy60P05USK3PMSWYAPgs6xNvi2FtuCJHmMe3dhpwIV5x
         GbnayJBlAWUHp8AOfJXapQJwWtCZbG8sNT9goXD2FZ3Np1FpknuDs/BWi6DoaE9+qx
         3sjSKiYBYrqJz/NBRIYkvNeHXdo9A6niRzQfJIjzA7XmK4nNKHbDlMGwMSXQECZK/J
         E0NwxFh8smr0A==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/20] drm/imx/ipuv3/imx-ldb: Increase buffer size to ensure all possible values can be stored
Date:   Thu, 24 Aug 2023 08:36:59 +0100
Message-ID: <20230824073710.2677348-15-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824073710.2677348-1-lee@kernel.org>
References: <20230824073710.2677348-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When converting from int to string, we must allow for up to 10-chars (2147483647).

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/imx/ipuv3/imx-ldb.c: In function ‘imx_ldb_probe’:
 drivers/gpu/drm/imx/ipuv3/imx-ldb.c:659:39: warning: ‘_sel’ directive writing 4 bytes into a region of size between 3 and 13 [-Wformat-overflow=]
 drivers/gpu/drm/imx/ipuv3/imx-ldb.c:659:17: note: ‘sprintf’ output between 8 and 18 bytes into a destination of size 16

Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/imx/ipuv3/imx-ldb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-ldb.c b/drivers/gpu/drm/imx/ipuv3/imx-ldb.c
index c45fc8f4744d0..0404781dcd176 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-ldb.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-ldb.c
@@ -654,7 +654,7 @@ static int imx_ldb_probe(struct platform_device *pdev)
 	 * Map them all to di0_sel...di3_sel.
 	 */
 	for (i = 0; i < 4; i++) {
-		char clkname[16];
+		char clkname[18];
 
 		sprintf(clkname, "di%d_sel", i);
 		imx_ldb->clk_sel[i] = devm_clk_get(imx_ldb->dev, clkname);
-- 
2.42.0.rc1.204.g551eb34607-goog

