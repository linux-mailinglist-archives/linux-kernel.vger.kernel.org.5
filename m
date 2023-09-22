Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AB17AB6E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjIVRNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjIVRNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:13:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE0E1A6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:13:02 -0700 (PDT)
Received: from ginger.. (unknown [177.98.21.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D4E0B66072E7;
        Fri, 22 Sep 2023 18:12:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695402781;
        bh=45K/IqAScPK7C6o2uDeoMEg0kNDhURxAWC5KyxTD4p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvMG0aff4LHkjnpL/iZ4lQXVyXLbfVcuAR+YwU2xT2axk9zV8Ji4H9n73nXtFaOE1
         MZxq5wu0mmtfXO/jtvYaJGdvw1n0Mi/1Z+Ha7qgpOtv3ut1qVnHTenW39gQ0+HonQR
         TymIr4MtIkzSxKk55u5GdjqIoDBiGIa4HZnQ0knDF5z5vjroNo7hLbgwgCemXB+ke2
         r7wNCMcCRAtFkBSeZiHLA/xuje+2cGUxX1RxAYW8WaqX59JZJemrlO2FZ8KkE+Yzwp
         3u7OFDnnsGp6TR3NTomGdp8s7mLHc9MgSRYk+4newqcM5+lg2Kdll9KJQAtTZ7wc26
         VoYay22G/NtCQ==
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, mairacanal@riseup.net,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        daniel@fooishbar.org, vignesh.raman@collabora.com,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        michel.daenzer@mailbox.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com
Subject: [PATCH v2 1/2] drm/ci: uprev mesa version - fix container build
Date:   Fri, 22 Sep 2023 14:12:36 -0300
Message-Id: <20230922171237.550762-2-helen.koike@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922171237.550762-1-helen.koike@collabora.com>
References: <20230922171237.550762-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building containers, some rust packages were installed without
locking the dependencies version, which got updated and started giving
errors like:

error: failed to compile `bindgen-cli v0.62.0`, intermediate artifacts can be found at `/tmp/cargo-installkNKRwf`
Caused by:
  package `rustix v0.38.13` cannot be built because it requires rustc 1.63 or newer, while the currently active rustc version is 1.60.0

A patch to Mesa was recently added fixing this error, so update it.

Signed-off-by: Helen Koike <helen.koike@collabora.com>

---

v2:
- point to upstream mesa/mesa (solved the TODO and removed RFC tag)
---
 drivers/gpu/drm/ci/gitlab-ci.yml  | 15 ++++++++++++++-
 drivers/gpu/drm/ci/lava-submit.sh |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 2c4df53f5dfe..522f83db1a07 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -1,6 +1,6 @@
 variables:
   DRM_CI_PROJECT_PATH: &drm-ci-project-path mesa/mesa
-  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 0dc961645c4f0241f8512cb0ec3ad59635842072
+  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 1cdc4be14b66108ae0e8069686ac3efe52bef3cb
 
   UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
   TARGET_BRANCH: drm-next
@@ -24,6 +24,8 @@ variables:
   PIPELINE_ARTIFACTS_BASE: ${S3_HOST}/artifacts/${CI_PROJECT_PATH}/${CI_PIPELINE_ID}
   # per-job artifact storage on MinIO
   JOB_ARTIFACTS_BASE: ${PIPELINE_ARTIFACTS_BASE}/${CI_JOB_ID}
+  # default kernel for rootfs before injecting the current kernel tree
+  KERNEL_IMAGE_BASE: https://${S3_HOST}/mesa-lava/gfx-ci/linux/v6.4.12-for-mesa-ci-f6b4ad45f48d
 
   LAVA_JOB_PRIORITY: 30
 
@@ -86,6 +88,17 @@ include:
       - '/.gitlab-ci/container/gitlab-ci.yml'
       - '/.gitlab-ci/test/gitlab-ci.yml'
       - '/.gitlab-ci/lava/lava-gitlab-ci.yml'
+      - '/src/microsoft/ci/gitlab-ci-inc.yml'
+      - '/src/gallium/drivers/zink/ci/gitlab-ci-inc.yml'
+      - '/src/gallium/drivers/crocus/ci/gitlab-ci-inc.yml'
+      - '/src/gallium/drivers/softpipe/ci/gitlab-ci-inc.yml'
+      - '/src/gallium/drivers/llvmpipe/ci/gitlab-ci-inc.yml'
+      - '/src/gallium/drivers/virgl/ci/gitlab-ci-inc.yml'
+      - '/src/gallium/drivers/nouveau/ci/gitlab-ci-inc.yml'
+      - '/src/gallium/frontends/lavapipe/ci/gitlab-ci-inc.yml'
+      - '/src/intel/ci/gitlab-ci-inc.yml'
+      - '/src/freedreno/ci/gitlab-ci-inc.yml'
+      - '/src/amd/ci/gitlab-ci-inc.yml'
   - drivers/gpu/drm/ci/image-tags.yml
   - drivers/gpu/drm/ci/container.yml
   - drivers/gpu/drm/ci/static-checks.yml
diff --git a/drivers/gpu/drm/ci/lava-submit.sh b/drivers/gpu/drm/ci/lava-submit.sh
index 0c4456b21b0f..379f26ea87cc 100755
--- a/drivers/gpu/drm/ci/lava-submit.sh
+++ b/drivers/gpu/drm/ci/lava-submit.sh
@@ -22,7 +22,7 @@ cp "$SCRIPTS_DIR"/setup-test-env.sh results/job-rootfs-overlay/
 
 # Prepare env vars for upload.
 section_start variables "Variables passed through:"
-KERNEL_IMAGE_BASE_URL="https://${BASE_SYSTEM_HOST_PATH}" \
+KERNEL_IMAGE_BASE="https://${BASE_SYSTEM_HOST_PATH}" \
 	artifacts/ci-common/generate-env.sh | tee results/job-rootfs-overlay/set-job-env-vars.sh
 section_end variables
 
-- 
2.34.1

