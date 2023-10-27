Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733F27DA171
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjJ0TqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0TqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:46:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024F1B3;
        Fri, 27 Oct 2023 12:45:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc30bf9e22so791085ad.1;
        Fri, 27 Oct 2023 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698435952; x=1699040752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy6IbgFuL135BKR91oRxByMVAKgGs/1dk+ALnWKFvUw=;
        b=HGKTSDKaWPM7mggPNjkCr7OQfEvrAzv5qv48/iZgooWEogyEdQpJ8SQJIrOzNSjT3I
         jjFCLmhm7DFn1n2LU0ZGMT5S+EMjC/VuNJgq4xVXDoakw8SJv8hp6PX5y3/axCvCqNFS
         Iav+LuAeieQnamuNdJ545/lr09GqZHmUe8vN8C6j8Ha0zb8UR6Wd0XfXa/uCDPOwaRgH
         U9S63RH3BC3i77cFFff37ZcdVeqhQuRY9U9nqGXeUBnmFcy5rjI1+htraGrNIp2fQ6Z+
         ZzXaUwfIPzhvAFaWHLmjjVScEAeL/CRSQsftsyrVE0BWSjfISnM/NNIkvM0SYFnZeSNI
         1Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698435952; x=1699040752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cy6IbgFuL135BKR91oRxByMVAKgGs/1dk+ALnWKFvUw=;
        b=cHFJnUoQlB7qckgcIR2juc7qfZC1gXwG4E2IZh0bfOgYmKI12o87BwElA/Jo9h5JMg
         oIBn1HPO4TQWcbjZBOKcKQM45JfGhttp8PBDfhj9QLrr9doH/4mP7RV/hA4q4nZ7bLs8
         NFTOrlnvcvTJPHxliPVaKf0Y31tjJH0Rg6KJ45KuFsCfEQRgMH4imW7zEQzagUp1O2bq
         B6w90SfGm93K2+TXLxSMSVAY5D+hlGo2I3/eDGzOERoPzCIocf2kZ9W5CrQzfWVg1K4S
         f4XYmLVQPcaf+AQlXVXjon/la8OlOqcq5zoPbVYr/5X6Ue0ni8QsX1ZRc1WtkUtgOYSN
         q99Q==
X-Gm-Message-State: AOJu0YwEgmvwXLyj7/CMjPH0GvUMNp3V1oVvD3WL9tOnyBeWG4sODqik
        8jlnFJOpQnmyfJuqVjS2pFA=
X-Google-Smtp-Source: AGHT+IGNfpLwVZYgsKfstsi00o+X3315W5bkhk4p0g9uo4d8PBR1FrlLIhgEKv8mSqdIInkoZ6Tvyg==
X-Received: by 2002:a17:902:e74e:b0:1cb:fcfb:61af with SMTP id p14-20020a170902e74e00b001cbfcfb61afmr8280487plf.30.1698435951704;
        Fri, 27 Oct 2023 12:45:51 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id ju19-20020a170903429300b001ae0152d280sm1944708plb.193.2023.10.27.12.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 12:45:50 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/gem: Add metadata
Date:   Fri, 27 Oct 2023 12:45:37 -0700
Message-ID: <20231027194537.408922-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 59 +++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_gem.h |  4 +++
 include/uapi/drm/msm_drm.h    |  2 ++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index b61ccea05327..8fe2677ea37a 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -37,9 +37,10 @@
  * - 1.9.0 - Add MSM_SUBMIT_FENCE_SN_IN
  * - 1.10.0 - Add MSM_SUBMIT_BO_NO_IMPLICIT
  * - 1.11.0 - Add wait boost (MSM_WAIT_FENCE_BOOST, MSM_PREP_BOOST)
+ * - 1.12.0 - Add MSM_INFO_SET_METADATA and MSM_INFO_GET_METADATA
  */
 #define MSM_VERSION_MAJOR	1
-#define MSM_VERSION_MINOR	10
+#define MSM_VERSION_MINOR	12
 #define MSM_VERSION_PATCHLEVEL	0
 
 static void msm_deinit_vram(struct drm_device *ddev);
@@ -566,6 +567,8 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 		break;
 	case MSM_INFO_SET_NAME:
 	case MSM_INFO_GET_NAME:
+	case MSM_INFO_SET_METADATA:
+	case MSM_INFO_GET_METADATA:
 		break;
 	default:
 		return -EINVAL;
@@ -618,7 +621,7 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 		break;
 	case MSM_INFO_GET_NAME:
 		if (args->value && (args->len < strlen(msm_obj->name))) {
-			ret = -EINVAL;
+			ret = -ETOOSMALL;
 			break;
 		}
 		args->len = strlen(msm_obj->name);
@@ -627,6 +630,58 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 					 msm_obj->name, args->len))
 				ret = -EFAULT;
 		}
+		break;
+	case MSM_INFO_SET_METADATA:
+		/* Impose a moderate upper bound on metadata size: */
+		if (args->len > 128) {
+			ret = -EOVERFLOW;
+			break;
+		}
+
+		ret = msm_gem_lock_interruptible(obj);
+		if (ret)
+			break;
+
+		msm_obj->metadata =
+			krealloc(msm_obj->metadata, args->len, GFP_KERNEL);
+		msm_obj->metadata_size = args->len;
+
+		if (copy_from_user(msm_obj->metadata, u64_to_user_ptr(args->value),
+				   args->len)) {
+			msm_obj->metadata_size = 0;
+			ret = -EFAULT;
+		}
+
+		msm_gem_unlock(obj);
+
+		break;
+	case MSM_INFO_GET_METADATA:
+		if (!args->value) {
+			/*
+			 * Querying the size is inherently racey, but
+			 * EXT_external_objects expects the app to confirm
+			 * via device and driver UUIDs that the exporter and
+			 * importer versions match.  All we can do from the
+			 * kernel side is check the length under obj lock
+			 * when userspace tries to retrieve the metadata
+			 */
+			args->len = msm_obj->metadata_size;
+			break;
+		}
+
+		ret = msm_gem_lock_interruptible(obj);
+		if (ret)
+			break;
+
+		if (args->len < msm_obj->metadata_size) {
+			ret = -ETOOSMALL;
+		} else if (copy_to_user(u64_to_user_ptr(args->value),
+					msm_obj->metadata, args->len)) {
+			ret = -EFAULT;
+		}
+
+		msm_gem_unlock(obj);
+
 		break;
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

