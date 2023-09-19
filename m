Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C029B7A6E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjISWK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjISWKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4B010C4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mA9VxmxzAaHhmrYSLsK1K2a+WJzqPPhkmmLdCRKl9ZA=;
        b=SyjKUo6w7ZL0actcfFMpXl0BFhNy2XjzJ8uZwDh2uVQho/Erd+WAcZWjgUbNCEuRB+qT8v
        df+iMy5hjKNtY//CycGvJF+Y++0ck/4xrFBsQQddgjyU8eZxBMHr42AlhP/VnWP/0YhUy5
        qZgGF3CdInwmyXkxYognsjqhYvh5fOY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-b7TiFgRcMRSVgvgcIZVvgA-1; Tue, 19 Sep 2023 18:07:37 -0400
X-MC-Unique: b7TiFgRcMRSVgvgcIZVvgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE42529AB45E;
        Tue, 19 Sep 2023 22:07:36 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9488040C2064;
        Tue, 19 Sep 2023 22:07:36 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 41/44] drm/nouveau/kms/nv50-: name aux channels after their connector
Date:   Tue, 19 Sep 2023 17:56:36 -0400
Message-ID: <20230919220442.202488-42-lyude@redhat.com>
In-Reply-To: <20230919220442.202488-1-lyude@redhat.com>
References: <20230919220442.202488-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

- removes use of VBIOS data for naming
- preparation for GSP-RM

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 25 ++++++++-------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 063cefe26be20..73657736ce838 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -400,10 +400,8 @@ nouveau_connector_destroy(struct drm_connector *connector)
 	kfree(nv_connector->edid);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
-	if (nv_connector->aux.transfer) {
+	if (nv_connector->aux.transfer)
 		drm_dp_cec_unregister_connector(&nv_connector->aux);
-		kfree(nv_connector->aux.name);
-	}
 	nvif_conn_dtor(&nv_connector->conn);
 	kfree(connector);
 }
@@ -1280,13 +1278,11 @@ struct drm_connector *
 nouveau_connector_create(struct drm_device *dev,
 			 const struct dcb_output *dcbe)
 {
-	const struct drm_connector_funcs *funcs = &nouveau_connector_funcs;
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_connector *nv_connector = NULL;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
-	char aux_name[48] = {0};
 	int index = dcbe->connector;
 	int type, ret = 0;
 	bool dummy;
@@ -1376,7 +1372,13 @@ nouveau_connector_create(struct drm_device *dev,
 		}
 	}
 
-	switch ((type = drm_conntype_from_dcb(nv_connector->type))) {
+	type = drm_conntype_from_dcb(nv_connector->type);
+	if (type == DRM_MODE_CONNECTOR_LVDS)
+		drm_connector_init(dev, connector, &nouveau_connector_funcs_lvds, type);
+	else
+		drm_connector_init(dev, connector, &nouveau_connector_funcs, type);
+
+	switch (type) {
 	case DRM_MODE_CONNECTOR_LVDS:
 		ret = nouveau_bios_parse_lvds_table(dev, 0, &dummy, &dummy);
 		if (ret) {
@@ -1385,24 +1387,16 @@ nouveau_connector_create(struct drm_device *dev,
 			return ERR_PTR(ret);
 		}
 
-		funcs = &nouveau_connector_funcs_lvds;
 		break;
 	case DRM_MODE_CONNECTOR_DisplayPort:
 	case DRM_MODE_CONNECTOR_eDP:
 		nv_connector->aux.dev = connector->kdev;
 		nv_connector->aux.drm_dev = dev;
 		nv_connector->aux.transfer = nouveau_connector_aux_xfer;
-		snprintf(aux_name, sizeof(aux_name), "sor-%04x-%04x",
-			 dcbe->hasht, dcbe->hashm);
-		nv_connector->aux.name = kstrdup(aux_name, GFP_KERNEL);
-		if (!nv_connector->aux.name) {
-			kfree(nv_connector);
-			return ERR_PTR(-ENOMEM);
-		}
+		nv_connector->aux.name = connector->name;
 		drm_dp_aux_init(&nv_connector->aux);
 		break;
 	default:
-		funcs = &nouveau_connector_funcs;
 		break;
 	}
 
@@ -1417,7 +1411,6 @@ nouveau_connector_create(struct drm_device *dev,
 	connector->interlace_allowed = false;
 	connector->doublescan_allowed = false;
 
-	drm_connector_init(dev, connector, funcs, type);
 	drm_connector_helper_add(connector, &nouveau_connector_helper_funcs);
 	connector->polled = DRM_CONNECTOR_POLL_CONNECT;
 
-- 
2.41.0

