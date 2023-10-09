Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD77BD18E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 02:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344842AbjJIAwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 20:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344591AbjJIAv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 20:51:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CD8AC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 17:51:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [179.221.49.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D8BCE6607243;
        Mon,  9 Oct 2023 01:51:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696812715;
        bh=S5ZXMtsqrCKXNXumQnygyDaY0j/k5BBmH6XyblMxH4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmCOTNMMN5s7SN54REpOBYRfNpgzZyAbHmgF+YJzXMNMbz5O76ZWWuWAYhViz4SS8
         6EteOZ4+nom5JHiDC/whru/tTDJ22ba/KhohhXFdMTORrm965y8W4zp7IMvWFZoZ4o
         5nBqbzNGFBDdkaXHnZ54WbLUnUVs9BCBO1eAyrVsRTFnAWvS6BMGaYDoUqTHxmfiIv
         OLZ/CLbrtJUQDdrPxrid+AbtamrE31mSEDoXmH1BSBHckZ0SCN6RCiUxlf7LWQNc5T
         toep/H2UZw4QkcZJaAW1xaW4WRfEyBsF8eUZ5XEw/bYiubf5twITsvyYT9hwlvTug6
         WKHTjCNO3Hffg==
From:   Helen Koike <helen.koike@collabora.com>
To:     Helen Koike <helen.koike@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     robdclark@chromium.org, dmitry.baryshkov@linaro.org,
        vignesh.raman@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, david.heidelberg@collabora.com,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] drm/ci: export kernel config
Date:   Sun,  8 Oct 2023 21:49:52 -0300
Message-Id: <20231009004953.203576-8-helen.koike@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009004953.203576-1-helen.koike@collabora.com>
References: <20231009004953.203576-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the resultant kernel config, making it easier to verify if the
resultant config was correctly generated.

Suggested-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
 drivers/gpu/drm/ci/build.sh       | 1 +
 drivers/gpu/drm/ci/image-tags.yml | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index 8eec15143bfe..740b5008be2e 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -148,6 +148,7 @@ mkdir -p artifacts/install/lib
 mv install/* artifacts/install/.
 rm -rf artifacts/install/modules
 ln -s common artifacts/install/ci-common
+cp .config artifacts/${CI_JOB_NAME}_config
 
 for image in ${KERNEL_IMAGE_NAME}; do
     cp /lava-files/$image artifacts/install/.
diff --git a/drivers/gpu/drm/ci/image-tags.yml b/drivers/gpu/drm/ci/image-tags.yml
index df94d8fb348e..3e5cd4e8be24 100644
--- a/drivers/gpu/drm/ci/image-tags.yml
+++ b/drivers/gpu/drm/ci/image-tags.yml
@@ -4,7 +4,7 @@ variables:
    DEBIAN_BASE_TAG: "${CONTAINER_TAG}"
 
    DEBIAN_X86_64_BUILD_IMAGE_PATH: "debian/x86_64_build"
-   DEBIAN_BUILD_TAG: "2023-10-08-igt"
+   DEBIAN_BUILD_TAG: "2023-10-08-config"
 
    KERNEL_ROOTFS_TAG: "2023-10-06-amd"
 
-- 
2.34.1

