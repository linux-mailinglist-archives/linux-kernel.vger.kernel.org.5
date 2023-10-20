Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8B7D0703
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376264AbjJTDmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346944AbjJTDmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:42:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0C1D5F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:41:57 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:e646:872b:8302:9b9b:d59b:1681])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B80F1660734B;
        Fri, 20 Oct 2023 04:41:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697773316;
        bh=9MrjxQacUj15ep8Zx8F+0wVVrkSwNkBKyIzymzzBRE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1lQQ87zxitp42CnzbvsNjr7rJ7Y3sp/WjZSx1tFPzf8m31G8rd0VVgE8THJpzvQ8
         BuZQ0etRY4gNp5hD8txbOWMCN3QYlxy2AFC/W2wSvKS3efIDEZH1z27lRL259zCWSz
         WJfkPT0kp8xmUZMLhwq5j7/1oyo3nGCianWX9isJpPiM6CpHv3fV0/dYLRS9PIMawS
         dfF5u157LZdwnlKyL0vFxFIjdXqdZdvkTXX973ZE3wGDu/XK+OCmibtW/7tioqF3bS
         DUA9KJIU8UW8k4CNiZ5wC859AxezJHy5PVWUNUuQ0hAS/r9GByyR6NVthNQf/UUiew
         xtvUGQ38CEmGg==
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org,
        Helen Koike <helen.koike@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     robdclark@chromium.org, dmitry.baryshkov@linaro.org,
        vignesh.raman@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, david.heidelberg@collabora.com,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] drm/ci: fix DEBIAN_ARCH and get amdgpu probing
Date:   Fri, 20 Oct 2023 00:41:17 -0300
Message-Id: <20231020034124.136295-3-helen.koike@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020034124.136295-1-helen.koike@collabora.com>
References: <20231020034124.136295-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amdgpu driver wasn't loading because amdgpu firmware wasn't being
installed in the rootfs due to the wrong DEBIAN_ARCH variable.

rename ARCH to DEBIAN_ARCH also, so we don't have the confusing
DEBIAN_ARCH, KERNEL_ARCH and ARCH.

Signed-off-by: Helen Koike <helen.koike@collabora.com>
Reviewed-by: David Heidelberg <david.heidelberg@collabora.com>

---

v2:
- fix typos in commit message
---
 drivers/gpu/drm/ci/build.sh       | 2 +-
 drivers/gpu/drm/ci/image-tags.yml | 4 ++--
 drivers/gpu/drm/ci/lava-submit.sh | 4 ++--
 drivers/gpu/drm/ci/test.yml       | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index 20a6ba8a7b04..e3908f4d71cb 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -35,7 +35,7 @@ elif [[ "$KERNEL_ARCH" = "arm" ]]; then
     apt-get install -y libssl-dev:armhf
 else
     GCC_ARCH="x86_64-linux-gnu"
-    DEBIAN_ARCH="x86_64"
+    DEBIAN_ARCH="amd64"
     DEVICE_TREES=""
 fi
 
diff --git a/drivers/gpu/drm/ci/image-tags.yml b/drivers/gpu/drm/ci/image-tags.yml
index 157d987149f0..e1b387581c11 100644
--- a/drivers/gpu/drm/ci/image-tags.yml
+++ b/drivers/gpu/drm/ci/image-tags.yml
@@ -4,9 +4,9 @@ variables:
    DEBIAN_BASE_TAG: "${CONTAINER_TAG}"
 
    DEBIAN_X86_64_BUILD_IMAGE_PATH: "debian/x86_64_build"
-   DEBIAN_BUILD_TAG: "${CONTAINER_TAG}"
+   DEBIAN_BUILD_TAG: "2023-10-06-amd"
 
-   KERNEL_ROOTFS_TAG: "${CONTAINER_TAG}"
+   KERNEL_ROOTFS_TAG: "2023-10-06-amd"
 
    DEBIAN_X86_64_TEST_BASE_IMAGE: "debian/x86_64_test-base"
    DEBIAN_X86_64_TEST_IMAGE_GL_PATH: "debian/x86_64_test-gl"
diff --git a/drivers/gpu/drm/ci/lava-submit.sh b/drivers/gpu/drm/ci/lava-submit.sh
index 379f26ea87cc..3d39b0c916a8 100755
--- a/drivers/gpu/drm/ci/lava-submit.sh
+++ b/drivers/gpu/drm/ci/lava-submit.sh
@@ -37,8 +37,8 @@ PYTHONPATH=artifacts/ artifacts/lava/lava_job_submitter.py \
 	--dump-yaml \
 	--pipeline-info "$CI_JOB_NAME: $CI_PIPELINE_URL on $CI_COMMIT_REF_NAME ${CI_NODE_INDEX}/${CI_NODE_TOTAL}" \
 	--rootfs-url-prefix "https://${BASE_SYSTEM_HOST_PATH}" \
-	--kernel-url-prefix "https://${PIPELINE_ARTIFACTS_BASE}/${ARCH}" \
-	--build-url "${FDO_HTTP_CACHE_URI:-}https://${PIPELINE_ARTIFACTS_BASE}/${ARCH}/kernel-files.tar.zst" \
+	--kernel-url-prefix "https://${PIPELINE_ARTIFACTS_BASE}/${DEBIAN_ARCH}" \
+	--build-url "${FDO_HTTP_CACHE_URI:-}https://${PIPELINE_ARTIFACTS_BASE}/${DEBIAN_ARCH}/kernel-files.tar.zst" \
 	--job-rootfs-overlay-url "${FDO_HTTP_CACHE_URI:-}https://${JOB_ROOTFS_OVERLAY_PATH}" \
 	--job-timeout-min ${JOB_TIMEOUT:-80} \
 	--first-stage-init artifacts/ci-common/init-stage1.sh \
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 6473cddaa7a9..3479d2a0108d 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -23,7 +23,7 @@
     - .lava-test:arm32
   variables:
     HWCI_TEST_SCRIPT: "/install/igt_runner.sh"
-    ARCH: "armhf"
+    DEBIAN_ARCH: "armhf"
   dependencies:
     - testing:arm32
   needs:
@@ -38,7 +38,7 @@
     - .lava-test:arm64
   variables:
     HWCI_TEST_SCRIPT: "/install/igt_runner.sh"
-    ARCH: "arm64"
+    DEBIAN_ARCH: "arm64"
   dependencies:
     - testing:arm64
   needs:
@@ -53,7 +53,7 @@
     - .lava-test:x86_64
   variables:
     HWCI_TEST_SCRIPT: "/install/igt_runner.sh"
-    ARCH: "x86_64"
+    DEBIAN_ARCH: "amd64"
   dependencies:
     - testing:x86_64
   needs:
-- 
2.39.2

