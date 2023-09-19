Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6737F7A6F90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjISXgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjISXgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:36:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138D283;
        Tue, 19 Sep 2023 16:36:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA73966071A9;
        Wed, 20 Sep 2023 00:36:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695166566;
        bh=fsXk4Gu75MgGG6vNMPuwnxFfx901KJO2Un2zim24NTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dq5b59vhlYoNpLOW5qFt0Bk73Ed7dsZ6/s8FLoFexKkdanEzvgulyJ/glb9OcZBqD
         kPG1j/DenYrFKPpxvA/O/P7UJyULnjmBQpo7GuqQ60pszHZwJ700dXUt9blsbyJG99
         HCNcd6iaCDq0g3L21X+G3lz4RfBHcO8Dycaqv4wCma4opNSboztcaI0Do/Vy2SZc1e
         AvQfaKoxU35FWQr738ZezlmdDFR5g1x2e8xC9Few10Vl4qFivODIQkFPtgJg9+ge0A
         fWqOec2wtLPCNeO2gGzr5UpdITgCq4SsqXzKrU+J1t74X0krAMoMsLZtP8dTP8ovQY
         PTw/l6lECRW8w==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     adrian.larumbe@collabora.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v6 6/6] drm/drm-file: Show finer-grained BO sizes in drm_show_memory_stats
Date:   Wed, 20 Sep 2023 00:34:54 +0100
Message-ID: <20230919233556.1458793-7-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919233556.1458793-1-adrian.larumbe@collabora.com>
References: <20230919233556.1458793-1-adrian.larumbe@collabora.com>
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

The current implementation will try to pick the highest available size
display unit as soon as the BO size exceeds that of the previous
multiplier. That can lead to loss of precision in contexts of low memory
usage.

The new selection criteria try to preserve precision, whilst also
increasing the display unit selection threshold to render more accurate
values.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/drm_file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 762965e3d503..34cfa128ffe5 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -872,6 +872,8 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
 }
 EXPORT_SYMBOL(drm_send_event);
 
+#define UPPER_UNIT_THRESHOLD 100
+
 static void print_size(struct drm_printer *p, const char *stat,
 		       const char *region, u64 sz)
 {
@@ -879,7 +881,8 @@ static void print_size(struct drm_printer *p, const char *stat,
 	unsigned u;
 
 	for (u = 0; u < ARRAY_SIZE(units) - 1; u++) {
-		if (sz < SZ_1K)
+		if ((sz & (SZ_1K - 1)) &&
+		    sz < UPPER_UNIT_THRESHOLD * SZ_1K)
 			break;
 		sz = div_u64(sz, SZ_1K);
 	}
-- 
2.42.0

