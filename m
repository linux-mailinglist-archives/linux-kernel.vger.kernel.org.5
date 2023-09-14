Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C377A1131
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjINWj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjINWjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:39:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3381B26B8;
        Thu, 14 Sep 2023 15:39:41 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F8406607356;
        Thu, 14 Sep 2023 23:39:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694731178;
        bh=o/iAnyoRLcVir53WqRf/gPFuGD/IX2JK6SO8vfDKfz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2va4uwsWHN9fBDL6qqNuj/kVsL2ikwCM6q5Lr9UruIrghN9Dt/0Kzi0VWXE+Kzp5
         RifYuBnRSONBHEjiU6YLR+SVptssqyOBjeS9e5Tm2hLIVAOtHMM+3PWtQ7LY7Ot5Qg
         vN674UVRBrbbGqPX25s9I2q3opABis+IEdKSsurmqxGACR0sjvUFDZMIhyjZAk/1we
         HM43AC40Hnpjw7V43rZS7DDFqgJAK2xLGQ8qCC9AD8oJCH/2J3IGTurrBrLIvnNBG8
         G3w3dyhuCT0CgJBAy7vRqx6danx3WfK8jNSk74oW8Wt2UkTAXhwWVZ5KfQUmvbeQyD
         ZJrprymAfvRfg==
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
        kernel@collabora.com
Subject: [PATCH v5 6/6] drm/drm-file: Show finer-grained BO sizes in drm_show_memory_stats
Date:   Thu, 14 Sep 2023 23:38:44 +0100
Message-ID: <20230914223928.2374933-7-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914223928.2374933-1-adrian.larumbe@collabora.com>
References: <20230914223928.2374933-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

