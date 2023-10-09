Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480D17BD18D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 02:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344695AbjJIAwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 20:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjJIAwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 20:52:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14023F4
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 17:52:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [179.221.49.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CBE4C660708F;
        Mon,  9 Oct 2023 01:51:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696812719;
        bh=Y+j9Xsw46AsG5JPdCV09TevV027ik56XBQjQ+3I3yBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhdpLJboVDPCZmaEkV+qeAUD1OVyuyyn0Pls27DDegt2Fa78QUEKlSEpDht8ZgFSN
         J2bMWY8m3uKCyuUwKjF4FTHlzbjYoKv6BVZ9snhHsvISgSB4uVfBPMhyWs3IOUlLdO
         q4DD0SjfI5dETgUmyKY1bcITTtZQ0xBMtUy1rm9/+XMkqe84KDPvUTGTD31v7VLpy2
         jW1nijf3K72aXf2KpJWJBawqSow0YKqUYyACm1ciCDzvoq9d+xLOlElo2tE0lcZLdW
         eySkHf9lJzE69PZkg1rB8beO833l/B4L3YfQNvcxU+fU7edDnmWQzpdseKO238rycg
         M7xhPFkmVHgMg==
From:   Helen Koike <helen.koike@collabora.com>
To:     Helen Koike <helen.koike@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     robdclark@chromium.org, dmitry.baryshkov@linaro.org,
        vignesh.raman@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, david.heidelberg@collabora.com,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] drm/ci: do not automatically retry on error
Date:   Sun,  8 Oct 2023 21:49:53 -0300
Message-Id: <20231009004953.203576-9-helen.koike@collabora.com>
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

Since the kernel doesn't use a bot like Mesa that requires tests to pass
in order to merge the patches, leave it to developers and/or maintainers
to manually retry.

Suggested-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
 drivers/gpu/drm/ci/gitlab-ci.yml | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 9326522823bb..6c5bf6fac697 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -55,20 +55,6 @@ default:
       export CI_JOB_JWT="$(<${CI_JOB_JWT_FILE})" &&
       rm "${CI_JOB_JWT_FILE}"
 
-  # Retry when job fails.
-  retry:
-    max: 1
-    # Ignore runner_unsupported, stale_schedule, archived_failure, or
-    # unmet_prerequisites
-    when:
-      - api_failure
-      - runner_system_failure
-      - script_failure
-      - job_execution_timeout
-      - scheduler_failure
-      - data_integrity_failure
-      - unknown_failure
-
 include:
   - project: 'freedesktop/ci-templates'
     ref: 16bc29078de5e0a067ff84a1a199a3760d3b3811
-- 
2.34.1

