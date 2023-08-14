Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0709777BC07
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjHNOum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjHNOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190C6E65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692024578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lLr1fKQOmjiaD4LHyCW/7ka5sjk7zv0No4ICWghVhgc=;
        b=dNEUDutHATjGVdGAUFYTICTvOFALF6CC0x+/e4yk3qFLrIgbp6g8P58Tk0dVeNREsVurMR
        60rg/4B/+cgodHfxw2R+JOYae0pbZhjHwlYo+5e9EJQFb9toOK6wJY6JKmLc9Fs44kT2/7
        D7+LtGkO9tkfsNH281XJfHwNhyG/LvM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-V1bxQ_9aNO6H9WzbaKSJ4g-1; Mon, 14 Aug 2023 10:49:36 -0400
X-MC-Unique: V1bxQ_9aNO6H9WzbaKSJ4g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe4f8a557dso11724395e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692024575; x=1692629375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLr1fKQOmjiaD4LHyCW/7ka5sjk7zv0No4ICWghVhgc=;
        b=U+K5x/1vJHSsGcPmmnixNpNliv1xp9DCgQFYACBkmmmMsL3Wd3lb25cEFSt+Hwe5Fb
         Lmh3xbBq/KLo8xivwOqI6qE7zgK7EkE0owz54MHYRXDuyCq0Be67e1NsxhTyM6vVd/xv
         2N/QtbmksM4AK/n7wctHHbQYdMchi4nockxR+KIlw+HgasDWZd4nUGPSgL3BNwayzJOS
         8b/3l4bE3H9TPA+uTG1y2DQaiKfMyGc3yYtC9fGk2ZuW61Mf7CY207DQ72XajGqN+8H/
         NtCi4WiKFBeTU3CataX4L1HgYMO3XUJeD+VnKpcaYENTKNP3R+uMO6Qq2odG0QfbCZIw
         8CKQ==
X-Gm-Message-State: AOJu0YyaHlQaPIJE3F5euJaEqUGPc3Pg+l9JR2VR+/wp5dmuExdX4EYZ
        7LxlqiHcTIFPfKgLvrtorgDjS+OKWQoCpTe3iDBqReNmQ1qw9WXWMRZfH4tcfeHerNo4hr1Q2VL
        a+RFsve9xCbeYuDYdGOw1eUpKawysUa6Q3zEINbap08hXblWDSWKDtcHobWDqrJ3Au0HKmztAWx
        3y/fbJNVA=
X-Received: by 2002:a05:600c:5111:b0:3fe:5228:b78c with SMTP id o17-20020a05600c511100b003fe5228b78cmr9591565wms.1.1692024575569;
        Mon, 14 Aug 2023 07:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1tdiW9HZTOV/fGkyYi3rJqI/IoMOtWccUH8Xg17/48IA+MNHERlSrq0NBJk1Sk2qPt4rsUA==
X-Received: by 2002:a05:600c:5111:b0:3fe:5228:b78c with SMTP id o17-20020a05600c511100b003fe5228b78cmr9591538wms.1.1692024575076;
        Mon, 14 Aug 2023 07:49:35 -0700 (PDT)
Received: from kherbst.pingu.com ([31.17.16.107])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c210a00b003fc02e8ea68sm17373094wml.13.2023.08.14.07.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:49:34 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Borislav Petkov <bp@alien8.de>, Takashi Iwai <tiwai@suse.de>,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH] drm/nouveau/disp: fix use-after-free in error handling of nouveau_connector_create
Date:   Mon, 14 Aug 2023 16:49:32 +0200
Message-ID: <20230814144933.3956959-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't simply free the connector after calling drm_connector_init on it.
We need to clean up the drm side first.

It might not fix all regressions from 2b5d1c29f6c4 ("drm/nouveau/disp:
PIOR DP uses GPIO for HPD, not PMGR AUX interrupts"), but at least it
fixes a memory corruption in error handling related to that commit.

Link: https://lore.kernel.org/lkml/20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local/
Fixes: 95983aea8003 ("drm/nouveau/disp: add connector class")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index a2e0033e8a260..622f6eb9a8bfd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1408,8 +1408,7 @@ nouveau_connector_create(struct drm_device *dev,
 		ret = nvif_conn_ctor(&disp->disp, nv_connector->base.name, nv_connector->index,
 				     &nv_connector->conn);
 		if (ret) {
-			kfree(nv_connector);
-			return ERR_PTR(ret);
+			goto drm_conn_err;
 		}
 
 		ret = nvif_conn_event_ctor(&nv_connector->conn, "kmsHotplug",
@@ -1426,8 +1425,7 @@ nouveau_connector_create(struct drm_device *dev,
 			if (ret) {
 				nvif_event_dtor(&nv_connector->hpd);
 				nvif_conn_dtor(&nv_connector->conn);
-				kfree(nv_connector);
-				return ERR_PTR(ret);
+				goto drm_conn_err;
 			}
 		}
 	}
@@ -1475,4 +1473,9 @@ nouveau_connector_create(struct drm_device *dev,
 
 	drm_connector_register(connector);
 	return connector;
+
+drm_conn_err:
+	drm_connector_cleanup(connector);
+	kfree(nv_connector);
+	return ERR_PTR(ret);
 }
-- 
2.41.0

