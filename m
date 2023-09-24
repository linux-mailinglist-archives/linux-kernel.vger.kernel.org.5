Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6F7AC6D5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjIXGmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXGmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:42:49 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F8E4107;
        Sat, 23 Sep 2023 23:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=N0gkh5tC+ChwweYN80
        y3EQPf2uMx44WfANoaXNQ07/Y=; b=Rh835qLOFMtdLoQUyzWSuzOM0k4dIJ7+KA
        Y1OSc0zT2ixGgwbKeOr6raNb/zmiDA9jH++DLCGZA2zfyKTgopn99DSoh2dXFxKO
        sybbxKJROe1GP0CN8UUi4K+mIRPXKMpY745XL2jqaSqgAYDDXwe0M0Gj5Tetw2Wp
        kEfDk1HdA=
Received: from localhost.localdomain (unknown [223.104.131.178])
        by zwqz-smtp-mta-g1-4 (Coremail) with SMTP id _____wCHjRFE2g9lvoerCw--.57896S2;
        Sun, 24 Sep 2023 14:42:14 +0800 (CST)
From:   liuhaoran <liuhaoran14@163.com>
To:     robdclark@gmail.com
Cc:     quic_abhinavk@quicinc.com, airlied@gmail.com, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        liuhaoran <liuhaoran14@163.com>
Subject: [PATCH] drm/msm/mdp4: Add error handling in mdp4_lvds_connector_init()
Date:   Sun, 24 Sep 2023 14:41:59 +0800
Message-Id: <20230924064159.14739-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wCHjRFE2g9lvoerCw--.57896S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW3Wr13Jw45GFy5ZrykGrg_yoW8Cr15pr
        WjyrZaqr40gry3KFn8AF1kCrn5ArWkKF1jgr109w15G348G34qyFW8Jr1ku3Z8Jr93Jr47
        ZwsrXF47GF1UC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2JPiUUUUU=
X-Originating-IP: [223.104.131.178]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiTgj0gmNh-QidlQAAsP
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error-handling for the drm_connector_init() and
drm_connector_attach_encoder inside the mdp4_lvds_connector_init().

Signed-off-by: liuhaoran <liuhaoran14@163.com>
---
 .../gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c    | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
index 7444b75c4215..62eb363ba90f 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
@@ -96,6 +96,7 @@ struct drm_connector *mdp4_lvds_connector_init(struct drm_device *dev,
 {
 	struct drm_connector *connector = NULL;
 	struct mdp4_lvds_connector *mdp4_lvds_connector;
+	int ret;
 
 	mdp4_lvds_connector = kzalloc(sizeof(*mdp4_lvds_connector), GFP_KERNEL);
 	if (!mdp4_lvds_connector)
@@ -106,8 +107,12 @@ struct drm_connector *mdp4_lvds_connector_init(struct drm_device *dev,
 
 	connector = &mdp4_lvds_connector->base;
 
-	drm_connector_init(dev, connector, &mdp4_lvds_connector_funcs,
-			DRM_MODE_CONNECTOR_LVDS);
+	ret = drm_connector_init(dev, connector, &mdp4_lvds_connector_funcs,
+				 DRM_MODE_CONNECTOR_LVDS);
+
+	if (ret)
+		return ret;
+
 	drm_connector_helper_add(connector, &mdp4_lvds_connector_helper_funcs);
 
 	connector->polled = 0;
@@ -115,7 +120,10 @@ struct drm_connector *mdp4_lvds_connector_init(struct drm_device *dev,
 	connector->interlace_allowed = 0;
 	connector->doublescan_allowed = 0;
 
-	drm_connector_attach_encoder(connector, encoder);
+	ret = drm_connector_attach_encoder(connector, encoder);
+
+	if (ret)
+		return ret;
 
 	return connector;
 }
-- 
2.17.1

