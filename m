Return-Path: <linux-kernel+bounces-124711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E2891BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E771F24C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D791448DB;
	Fri, 29 Mar 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC+nerG1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E91448C8;
	Fri, 29 Mar 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715962; cv=none; b=eiznzY0s9+DT+QQutiylGAr2G9dHWl1jROJRVpw19EGTqJE9sh4Xfa521Je7T8zWjTkrMywfaFnB4aVez6uDRd/erSiIb38ch2kgYccxPk5LfGaIwx4w+0aZcVV0c4gTf50y0VUDcpF9nvQCE0USt8upXsW3G/AidC4QBzs4qLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715962; c=relaxed/simple;
	bh=lZqrsfz7PMnd6DsRrloCr2AJhrFU8XDS8xiS4KvjE+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4ev/TtTX6MZ1YBJdfNbaGAE45GTC6+4AjMlihZUGMu87Bqis5xEBKoLf4VFxgjNkvcPIpxnekZseIpwJogfQ9QkptfGGPEw3WR6rH5rQ2hlFtm8thTyCV7eORVmVUbiAULXv1UAJU3xK56mJIUGKmr37Yxw0PcZTYk3BPuPEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC+nerG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFFAC433F1;
	Fri, 29 Mar 2024 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715962;
	bh=lZqrsfz7PMnd6DsRrloCr2AJhrFU8XDS8xiS4KvjE+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DC+nerG1ykJeg5eoi4uU8u1FfDhmG3j+zML6Ag1ww2wU7faC/TlOiPWUpCVnX3jFW
	 3JtwsRBdSPPH92J7FO/9A8DmDAaUzjsTyOFl79GYy+nlz3PaMnYTUSNhMWTzGTw00y
	 vORGwOrXCmrKizFYNTlZn6oG87H8xU6YV7ktgTEF2PNebHGyg1NQLMpBvAulPBLn+n
	 QSZrQjucT0WFsavYXmfva0pE5lZuJH0Wq2olGQaXp0Okdnmj3J/gxSZz3wcsljqPx5
	 c0wIzWDZjXuiXJSIiJOd7VJ2hNBq+HVwh22Yk0hII9hjkVqrK7srcXx8WN5nM72KXc
	 U56jhX7YriJeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vignesh Raman <vignesh.raman@collabora.com>,
	David Heidelberg <david.heidelberg@collabora.com>,
	Helen Koike <helen.koike@collabora.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 02/98] drm/ci: uprev mesa version: fix kdl commit fetch
Date: Fri, 29 Mar 2024 08:36:33 -0400
Message-ID: <20240329123919.3087149-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Vignesh Raman <vignesh.raman@collabora.com>

[ Upstream commit d315a68e94a76310c349add3f9c914cefda0a87f ]

build-kdl.sh was doing a `clone --depth 1` of the default branch,
then checking out a commit that might not be the latest of that
branch, resulting in container build error.

https://gitlab.freedesktop.org/mesa/mesa/-/commit/5efa4d56 fixes
kdl commit fetch issue. Uprev mesa in drm-ci to fix this.

This commit updates the kernel tag and adds .never-post-merge-rules
due to the mesa uprev. It also fixes an issue where the virtio-gpu
pipeline was not getting created with the mesa uprev.

Reviewed-by: David Heidelberg <david.heidelberg@collabora.com>
Acked-by: Helen Koike <helen.koike@collabora.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231222033434.1537761-1-vignesh.raman@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ci/gitlab-ci.yml | 14 ++++++++++++--
 drivers/gpu/drm/ci/test.yml      |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index dac92cc2777cc..084e3ff8e3f42 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -1,6 +1,6 @@
 variables:
   DRM_CI_PROJECT_PATH: &drm-ci-project-path mesa/mesa
-  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha edfbf74df1d4d6ce54ffe24566108be0e1a98c3d
+  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 9d162de9a05155e1c4041857a5848842749164cf
 
   UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
   TARGET_BRANCH: drm-next
@@ -25,7 +25,9 @@ variables:
   # per-job artifact storage on MinIO
   JOB_ARTIFACTS_BASE: ${PIPELINE_ARTIFACTS_BASE}/${CI_JOB_ID}
   # default kernel for rootfs before injecting the current kernel tree
-  KERNEL_IMAGE_BASE: https://${S3_HOST}/mesa-lava/gfx-ci/linux/v6.4.12-for-mesa-ci-f6b4ad45f48d
+  KERNEL_REPO: "gfx-ci/linux"
+  KERNEL_TAG: "v6.6.4-for-mesa-ci-e4f4c500f7fb"
+  KERNEL_IMAGE_BASE: https://${S3_HOST}/mesa-lava/${KERNEL_REPO}/${KERNEL_TAG}
   LAVA_TAGS: subset-1-gfx
   LAVA_JOB_PRIORITY: 30
 
@@ -133,6 +135,11 @@ stages:
     - if: &is-pre-merge-for-marge '$GITLAB_USER_LOGIN == "marge-bot" && $CI_PIPELINE_SOURCE == "merge_request_event"'
       when: on_success
 
+.never-post-merge-rules:
+  rules:
+    - if: *is-post-merge
+      when: never
+
 # Rule to filter for only scheduled pipelines.
 .scheduled_pipeline-rules:
   rules:
@@ -150,6 +157,7 @@ stages:
 .build-rules:
   rules:
     - !reference [.no_scheduled_pipelines-rules, rules]
+    - !reference [.never-post-merge-rules, rules]
     # Run automatically once all dependency jobs have passed
     - when: on_success
 
@@ -157,6 +165,7 @@ stages:
 .container+build-rules:
   rules:
     - !reference [.no_scheduled_pipelines-rules, rules]
+    - !reference [.never-post-merge-rules, rules]
     - when: manual
 
 .ci-deqp-artifacts:
@@ -175,6 +184,7 @@ stages:
 .container-rules:
   rules:
     - !reference [.no_scheduled_pipelines-rules, rules]
+    - !reference [.never-post-merge-rules, rules]
     # Run pipeline by default in the main project if any CI pipeline
     # configuration files were changed, to ensure docker images are up to date
     - if: *is-post-merge
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 2c9a1838e7284..1705f268547ad 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -324,6 +324,7 @@ virtio_gpu:none:
     GPU_VERSION: none
   extends:
     - .test-gl
+    - .test-rules
   tags:
     - kvm
   script:
-- 
2.43.0


