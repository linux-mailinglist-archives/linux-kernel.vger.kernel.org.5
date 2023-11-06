Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941B37E2C58
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjKFSun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjKFSuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:50:39 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25C9B0;
        Mon,  6 Nov 2023 10:50:36 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso3116441a12.1;
        Mon, 06 Nov 2023 10:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699296636; x=1699901436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMBUj2Kt6SbeiWM5ttIg3zTrO2lSIQVfD3WAaZwy4rI=;
        b=HRLU5enw8egXQaB/zi4WLMX3qAvbpSu9X7WV1xNaMfpHRbIJ+ITw9UX2pvZd0h8MN9
         AEqtrxOnEhMXzN4HDfE3IxCVPnrN24l1yR6Mlo7x9Db/w1jsyzqrdmFLur63myZs57lD
         T2HIt4TLLht7h64IGtVFlmUUpWWRx7NETBokWjSJBfBAKiWMupN6rq1IWDMLmbAXZa2g
         NjsPOX7o3+b9MqvkB82tjCbFnlerlqUseP38Iq/Mkja0D7AsDse0rfgId6ASyEjn1L2a
         qLJMDMal3tkR2Hrkfmk+v24DOm4tOBfikiiT5NVV9T55LyvBOOi0OYMVusfOFJrvYuHO
         S84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699296636; x=1699901436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMBUj2Kt6SbeiWM5ttIg3zTrO2lSIQVfD3WAaZwy4rI=;
        b=vCHj3hFMP6iltXZqfTIi34ooEhd2PWW1wbcxdqo1KsywRSzGw2+vUstCQ9TrjcMtF3
         2ZaC9sKA1Xb8EC3/aYLlk+iFGs/cFV/x7xoYufS+S3VGrxmK6n4Wwvtk0nDRTBtudSxb
         m0voPYopssuIMBBPJX8DAzC3pk4CAPUT6dv9prwN8Err0JXqMuJasaLCdpD7iIaLIwQs
         H8zpw2pr2FOkzN7Rqv2MJ0F1osFkGsM82UGdt9vdJ1+DqOO2C5e1LtRXbWCgbaqtpY28
         Tm3RTDDCqDVvC4jHWgQWnlTWwRFvPnj9oG2SPEFDVK+C+hpb/wLM5RZ9Kb6YPk9RQ3Ys
         SWfQ==
X-Gm-Message-State: AOJu0YwpOyUM4U7vxQfI1duAdBc+8nykPDEwh0A72vagXVvytSV2BGtz
        +j5d9xuVn+c6HUb3jPtr94FJllWVAos=
X-Google-Smtp-Source: AGHT+IEpIxI6HOgD4VG/z4qSIMgMurh0j6eSjFkqM7cUS1WvSwGLhAKP7XbFexVhwhJXkI3Dg0BZhQ==
X-Received: by 2002:a05:6a20:a115:b0:13d:df16:cf29 with SMTP id q21-20020a056a20a11500b0013ddf16cf29mr27399556pzk.15.1699296636342;
        Mon, 06 Nov 2023 10:50:36 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7874d000000b006c31c0dfb69sm5919796pfo.188.2023.11.06.10.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:50:35 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniels@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] drm/msm/gem: Add metadata
Date:   Mon,  6 Nov 2023 10:50:26 -0800
Message-ID: <20231106185028.209462-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106185028.209462-1-robdclark@gmail.com>
References: <20231106185028.209462-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The EXT_external_objects extension is a bit awkward as it doesn't pass
explicit modifiers, leaving the importer to guess with incomplete
information.  In the case of vk (turnip) exporting and gl (freedreno)
importing, the "OPTIMAL_TILING_EXT" layout depends on VkImageCreateInfo
flags (among other things), which the importer does not know.  Which
unfortunately leaves us with the need for a metadata back-channel.

The contents of the metadata are defined by userspace.  The
EXT_external_objects extension is only required to work between
compatible versions of gl and vk drivers, as defined by device and
driver UUIDs.

v2: add missing metadata kfree
v3: Rework to move copy_from/to_user out from under gem obj lock
    to avoid angering lockdep about deadlocks against fs-reclaim

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Note, I dropped Dmitry's r-b on this version because it was a bit of
a re-write of the original patch.

 drivers/gpu/drm/msm/msm_drv.c | 92 ++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_gem.c |  1 +
 drivers/gpu/drm/msm/msm_gem.h |  4 ++
 include/uapi/drm/msm_drm.h    |  2 +
 4 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 781db689fb16..c05c27a70c34 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -49,9 +49,10 @@
  * - 1.9.0 - Add MSM_SUBMIT_FENCE_SN_IN
  * - 1.10.0 - Add MSM_SUBMIT_BO_NO_IMPLICIT
  * - 1.11.0 - Add wait boost (MSM_WAIT_FENCE_BOOST, MSM_PREP_BOOST)
+ * - 1.12.0 - Add MSM_INFO_SET_METADATA and MSM_INFO_GET_METADATA
  */
 #define MSM_VERSION_MAJOR	1
-#define MSM_VERSION_MINOR	11
+#define MSM_VERSION_MINOR	12
 #define MSM_VERSION_PATCHLEVEL	0
 
 static void msm_deinit_vram(struct drm_device *ddev);
@@ -822,6 +823,85 @@ static int msm_ioctl_gem_info_set_iova(struct drm_device *dev,
 	return msm_gem_set_iova(obj, ctx->aspace, iova);
 }
 
+static int msm_ioctl_gem_info_set_metadata(struct drm_gem_object *obj,
+					   __user void *metadata,
+					   u32 metadata_size)
+{
+	struct msm_gem_object *msm_obj = to_msm_bo(obj);
+	void *buf;
+	int ret;
+
+	/* Impose a moderate upper bound on metadata size: */
+	if (metadata_size > 128) {
+		return -EOVERFLOW;
+	}
+
+	/* Use a temporary buf to keep copy_from_user() outside of gem obj lock: */
+	buf = memdup_user(metadata, metadata_size);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = msm_gem_lock_interruptible(obj);
+	if (ret)
+		goto out;
+
+	msm_obj->metadata =
+		krealloc(msm_obj->metadata, metadata_size, GFP_KERNEL);
+	msm_obj->metadata_size = metadata_size;
+	memcpy(msm_obj->metadata, buf, metadata_size);
+
+	msm_gem_unlock(obj);
+
+out:
+	kfree(buf);
+
+	return ret;
+}
+
+static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
+					   __user void *metadata,
+					   u32 *metadata_size)
+{
+	struct msm_gem_object *msm_obj = to_msm_bo(obj);
+	void *buf;
+	int ret, len;
+
+	if (!metadata) {
+		/*
+		 * Querying the size is inherently racey, but
+		 * EXT_external_objects expects the app to confirm
+		 * via device and driver UUIDs that the exporter and
+		 * importer versions match.  All we can do from the
+		 * kernel side is check the length under obj lock
+		 * when userspace tries to retrieve the metadata
+		 */
+		*metadata_size = msm_obj->metadata_size;
+		return 0;
+	}
+
+	ret = msm_gem_lock_interruptible(obj);
+	if (ret)
+		return ret;
+
+	/* Avoid copy_to_user() under gem obj lock: */
+	len = msm_obj->metadata_size;
+	buf = kmemdup(msm_obj->metadata, len, GFP_KERNEL);
+
+	msm_gem_unlock(obj);
+
+	if (*metadata_size < len) {
+		ret = -ETOOSMALL;
+	} else if (copy_to_user(metadata, buf, len)) {
+		ret = -EFAULT;
+	} else {
+		*metadata_size = len;
+	}
+
+	kfree(buf);
+
+	return 0;
+}
+
 static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
@@ -844,6 +924,8 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 		break;
 	case MSM_INFO_SET_NAME:
 	case MSM_INFO_GET_NAME:
+	case MSM_INFO_SET_METADATA:
+	case MSM_INFO_GET_METADATA:
 		break;
 	default:
 		return -EINVAL;
@@ -906,6 +988,14 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 				ret = -EFAULT;
 		}
 		break;
+	case MSM_INFO_SET_METADATA:
+		ret = msm_ioctl_gem_info_set_metadata(
+			obj, u64_to_user_ptr(args->value), args->len);
+		break;
+	case MSM_INFO_GET_METADATA:
+		ret = msm_ioctl_gem_info_get_metadata(
+			obj, u64_to_user_ptr(args->value), &args->len);
+		break;
 	}
 
 	drm_gem_object_put(obj);
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 1113e6b2ec8e..175ee4ab8a6f 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1058,6 +1058,7 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
 
 	drm_gem_object_release(obj);
 
+	kfree(msm_obj->metadata);
 	kfree(msm_obj);
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 7f34263048a3..8d414b072c29 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -109,6 +109,10 @@ struct msm_gem_object {
 
 	char name[32]; /* Identifier to print for the debugfs files */
 
+	/* userspace metadata backchannel */
+	void *metadata;
+	u32 metadata_size;
+
 	/**
 	 * pin_count: Number of times the pages are pinned
 	 *
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 6c34272a13fd..6f2a7ad04aa4 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -139,6 +139,8 @@ struct drm_msm_gem_new {
 #define MSM_INFO_GET_NAME	0x03   /* get debug name, returned by pointer */
 #define MSM_INFO_SET_IOVA	0x04   /* set the iova, passed by value */
 #define MSM_INFO_GET_FLAGS	0x05   /* get the MSM_BO_x flags */
+#define MSM_INFO_SET_METADATA	0x06   /* set userspace metadata */
+#define MSM_INFO_GET_METADATA	0x07   /* get userspace metadata */
 
 struct drm_msm_gem_info {
 	__u32 handle;         /* in */
-- 
2.41.0

