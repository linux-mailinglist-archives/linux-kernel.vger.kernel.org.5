Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B5F7BC44C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 05:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjJGDEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 23:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjJGDD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 23:03:58 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10CACBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 20:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eXdTM
        qOTVo37Vuo+Ii2+2vMJv7kgRRnrVpWPIL1gsDI=; b=KZJxd/jdNVT4o+gYnm2IU
        GxGA/ZihRg6oC6c1CYAFJEvZymE3+T/a5mGXdIXI3OaH70JOdyMhvI1vAeqlffH0
        IlztKSKbbbJHWo5lDB0TNFfONMjm2lTxBz3h48bmebY4J8j6KHdJnk+Xfc12TmdL
        APzyao2b1ME89Rbe5yCrW0=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wDnFXp4yiBl5FAoEA--.48757S4;
        Sat, 07 Oct 2023 11:03:29 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     linus.walleij@linaro.org, neil.armstrong@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] drm/panel/panel-tpo-tpg110: fix a possible null pointer dereference
Date:   Sat,  7 Oct 2023 11:03:18 +0800
Message-Id: <20231007030318.3996798-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnFXp4yiBl5FAoEA--.48757S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW8KFyfCw18AF47KFWrAFb_yoWDJFb_uF
        18XasrWr47W3Z7CF4Iva13Ar1ayFs8AF4kZ3WSkayIkrykGF17Jr1DWr909a4UuF17uFs8
        Aa4xAF1YvFnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKLvK7UUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFR4CC2B9oZk1SgAAsY
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In radeon_fp_native_mode(), the return value of drm_mode_duplicate()
is assigned to mode, which will lead to a NULL pointer dereference
on failure of drm_mode_duplicate(). Add a check to avoid npd.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/gpu/drm/panel/panel-tpo-tpg110.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-tpo-tpg110.c b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
index 845304435e23..f6a212e542cb 100644
--- a/drivers/gpu/drm/panel/panel-tpo-tpg110.c
+++ b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
@@ -379,6 +379,8 @@ static int tpg110_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = tpg->panel_mode->bus_flags;
 
 	mode = drm_mode_duplicate(connector->dev, &tpg->panel_mode->mode);
+	if (!mode)
+		return -ENOMEM;
 	drm_mode_set_name(mode);
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 
-- 
2.37.2

