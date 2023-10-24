Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043757D4441
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjJXArU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjJXArP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:47:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5B910C7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:47:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:e646:872b:1c98:7e30:3cb0:3153])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 762C4660576C;
        Tue, 24 Oct 2023 01:47:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698108424;
        bh=jor5PAvHc7oI6Ti1WkTfhM0oEaNCBiswzxlyv7Iwmdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QH5l+yFK0FkDz6WGVk5OvWBSfVnbVPFg2VbtP3VKn472B3OQxiUv8zJ2z3RBGItFF
         vzIBj8P3KGXRua3JvWmOMQ7sxQHcQWS//SapiUGrF05syXW5Iy5L75xt+zBePswZNn
         O6qn6rAwRLE26jMTiP2OViK5oDRxp+oG28bVY8cvc4gq8uuGqCgcnYUAF6kjGZisxM
         1+V3+VlniKzus1HOcqvHn0AGq5fQG5y+7zMqAF8PiQ1b1aYKvz6Tn5ujxQ18Bw/Uh2
         Yn6lHocZDf9/GsHAqEHDnQ4JHEBhcgaJNGvIFHf/q1V94TBOcLAVtYMQTR69mGaX32
         GHoYTjMEiVu2g==
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
        daniels@collabora.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] drm/ci: do not automatically retry on error
Date:   Mon, 23 Oct 2023 21:45:24 -0300
Message-Id: <20231024004525.169002-10-helen.koike@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024004525.169002-1-helen.koike@collabora.com>
References: <20231024004525.169002-1-helen.koike@collabora.com>
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
Reviewed-by: David Heidelberg <david.heidelberg@collabora.com>

---

v2:
- no changes
v3:
-no changes
---
 drivers/gpu/drm/ci/gitlab-ci.yml | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index cb41fa1b068b..aeb9bab1b069 100644
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
2.39.2

