Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B1F7CBF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbjJQJam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjJQJ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:29:37 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6FD199F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dQbTPqJByKTPRLvnAel3VnOmQ8OJEdk4CamVdOalghI=; b=Jo4AZzxOJkvJwxXWTfsE4Zgt2X
        tna5CGyRFMLVrCxn47Sl65mR1FIEwyISddy7xwMy+fEIaxagAf/9OEpbAAuWxuLd468gHLC0EH578
        zbq7wjpIoZ/fh3JIiKiN5rjJT83EJXAd8H/UzP9epr04TMXr5veA4Ozr5oJMuQlKDK9kXqiWt6OOh
        sV9Dof/7cYavl/94toW4W0aSA8cambcnrPddNU+VqDMcfLEwwapJ+j5+OvbHsoKjFwqbA/x+Pibzx
        eArWy4+R/cjXY3f1J3Kue+p0/m1CtarjEulzASj4Wv1Q+711DmyWnZCzBPCfwf7LyuV15ohSf0ljZ
        X3359AqA==;
Received: from 167.red-81-39-185.dynamicip.rima-tde.net ([81.39.185.167] helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qsgNc-001ODF-T9; Tue, 17 Oct 2023 11:28:48 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Pekka Paalanen" <ppaalanen@gmail.com>, hwentlan@amd.com,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, joshua@froggi.es,
        Simon Ser <contact@emersion.fr>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v7 2/6] drm: introduce DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP
Date:   Tue, 17 Oct 2023 11:28:33 +0200
Message-ID: <20231017092837.32428-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017092837.32428-1-andrealmeid@igalia.com>
References: <20231017092837.32428-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Ser <contact@emersion.fr>

This new kernel capability indicates whether async page-flips are
supported via the atomic uAPI. DRM clients can use it to check
for support before feeding DRM_MODE_PAGE_FLIP_ASYNC to the kernel.

Make it clear that DRM_CAP_ASYNC_PAGE_FLIP is for legacy uAPI only.

Signed-off-by: Simon Ser <contact@emersion.fr>
Reviewed-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/drm_ioctl.c |  5 +++++
 include/uapi/drm/drm.h      | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 77590b0f38fa..a96e7acb9071 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -301,6 +301,11 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
 	case DRM_CAP_CRTC_IN_VBLANK_EVENT:
 		req->value = 1;
 		break;
+	case DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP:
+		req->value = drm_core_check_feature(dev, DRIVER_ATOMIC) &&
+			     dev->mode_config.async_page_flip &&
+			     !dev->mode_config.atomic_async_page_flip_not_supported;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 794c1d857677..58baefe32c23 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -713,7 +713,8 @@ struct drm_gem_open {
 /**
  * DRM_CAP_ASYNC_PAGE_FLIP
  *
- * If set to 1, the driver supports &DRM_MODE_PAGE_FLIP_ASYNC.
+ * If set to 1, the driver supports &DRM_MODE_PAGE_FLIP_ASYNC for legacy
+ * page-flips.
  */
 #define DRM_CAP_ASYNC_PAGE_FLIP		0x7
 /**
@@ -773,6 +774,13 @@ struct drm_gem_open {
  * :ref:`drm_sync_objects`.
  */
 #define DRM_CAP_SYNCOBJ_TIMELINE	0x14
+/**
+ * DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP
+ *
+ * If set to 1, the driver supports &DRM_MODE_PAGE_FLIP_ASYNC for atomic
+ * commits.
+ */
+#define DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP	0x15
 
 /* DRM_IOCTL_GET_CAP ioctl argument type */
 struct drm_get_cap {
-- 
2.42.0

