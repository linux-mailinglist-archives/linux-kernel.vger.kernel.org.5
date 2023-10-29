Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0B17DADDE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjJ2SqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjJ2Spy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:45:54 -0400
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289EEF7;
        Sun, 29 Oct 2023 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1698605142; bh=91P/9m4HKX2FnWBtteRHoyQs6bdEapVxts8s+Azicp0=;
 b=pT/eJvvu16H69EObxGfGqPVgsJmlly4tUv+D9bpParbMMeOYT/69c84c1v5kNM67Mzjkr0kRY
 TzNtxjo/183l3shgJCS99KvDzPJmBGc67uixKwG7Fmttl49SBwVIDjVDYFNRD+NO/NXFyWBPiUh
 YKlYN2ruDdEkh/sZvyj3CgGrpFHv9q63oTCAQrecuIWn1kCKb4eVRpYHMAoBmPDVVjeHXlSvF0M
 Li4NhGLHl9UkLfa7VNkLp1y0AefBaMdDCEikKTNQzYsUSa2V0S5r8c6bbMh3xOQrye8Ai40Kogy
 didVEccASrSut1EIvSITAs3M7xBk3MgGT0Fv9ImPRJLg==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 01/10] media: v4l2-common: Add helpers to calculate bytesperline and sizeimage
Date:   Sun, 29 Oct 2023 18:34:08 +0000
Message-ID: <20231029183427.1781554-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029183427.1781554-1-jonas@kwiboo.se>
References: <20231029183427.1781554-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 653ea5bd8fe0ffca230b0f15
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper functions to calculate plane bytesperline and sizeimage,
these new helpers consider bpp div, block width and height when
calculating plane bytesperline and sizeimage.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3:
- Consider bpp_div in calculation

 drivers/media/v4l2-core/v4l2-common.c | 78 +++++++++++++--------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 3a4b15a98e02..834b426da8b1 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -350,6 +350,34 @@ static inline unsigned int v4l2_format_block_height(const struct v4l2_format_inf
 	return info->block_h[plane];
 }
 
+static inline unsigned int v4l2_format_plane_width(const struct v4l2_format_info *info, int plane,
+						   unsigned int width)
+{
+	unsigned int hdiv = plane ? info->hdiv : 1;
+	unsigned int aligned_width =
+		ALIGN(width, v4l2_format_block_width(info, plane));
+
+	return DIV_ROUND_UP(aligned_width, hdiv) *
+	       info->bpp[plane] / info->bpp_div[plane];
+}
+
+static inline unsigned int v4l2_format_plane_height(const struct v4l2_format_info *info, int plane,
+						    unsigned int height)
+{
+	unsigned int vdiv = plane ? info->vdiv : 1;
+	unsigned int aligned_height =
+		ALIGN(height, v4l2_format_block_height(info, plane));
+
+	return DIV_ROUND_UP(aligned_height, vdiv);
+}
+
+static inline unsigned int v4l2_format_plane_size(const struct v4l2_format_info *info, int plane,
+						  unsigned int width, unsigned int height)
+{
+	return v4l2_format_plane_width(info, plane, width) *
+	       v4l2_format_plane_height(info, plane, height);
+}
+
 void v4l2_apply_frmsize_constraints(u32 *width, u32 *height,
 				    const struct v4l2_frmsize_stepwise *frmsize)
 {
@@ -385,37 +413,19 @@ int v4l2_fill_pixfmt_mp(struct v4l2_pix_format_mplane *pixfmt,
 
 	if (info->mem_planes == 1) {
 		plane = &pixfmt->plane_fmt[0];
-		plane->bytesperline = ALIGN(width, v4l2_format_block_width(info, 0)) * info->bpp[0] / info->bpp_div[0];
+		plane->bytesperline = v4l2_format_plane_width(info, 0, width);
 		plane->sizeimage = 0;
 
-		for (i = 0; i < info->comp_planes; i++) {
-			unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
-			unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
-			unsigned int aligned_width;
-			unsigned int aligned_height;
-
-			aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
-			aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
-
-			plane->sizeimage += info->bpp[i] *
-				DIV_ROUND_UP(aligned_width, hdiv) *
-				DIV_ROUND_UP(aligned_height, vdiv) / info->bpp_div[i];
-		}
+		for (i = 0; i < info->comp_planes; i++)
+			plane->sizeimage +=
+				v4l2_format_plane_size(info, i, width, height);
 	} else {
 		for (i = 0; i < info->comp_planes; i++) {
-			unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
-			unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
-			unsigned int aligned_width;
-			unsigned int aligned_height;
-
-			aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
-			aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
-
 			plane = &pixfmt->plane_fmt[i];
 			plane->bytesperline =
-				info->bpp[i] * DIV_ROUND_UP(aligned_width, hdiv) / info->bpp_div[i];
-			plane->sizeimage =
-				plane->bytesperline * DIV_ROUND_UP(aligned_height, vdiv);
+				v4l2_format_plane_width(info, i, width);
+			plane->sizeimage = plane->bytesperline *
+				v4l2_format_plane_height(info, i, height);
 		}
 	}
 	return 0;
@@ -439,22 +449,12 @@ int v4l2_fill_pixfmt(struct v4l2_pix_format *pixfmt, u32 pixelformat,
 	pixfmt->width = width;
 	pixfmt->height = height;
 	pixfmt->pixelformat = pixelformat;
-	pixfmt->bytesperline = ALIGN(width, v4l2_format_block_width(info, 0)) * info->bpp[0] / info->bpp_div[0];
+	pixfmt->bytesperline = v4l2_format_plane_width(info, 0, width);
 	pixfmt->sizeimage = 0;
 
-	for (i = 0; i < info->comp_planes; i++) {
-		unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
-		unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
-		unsigned int aligned_width;
-		unsigned int aligned_height;
-
-		aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
-		aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
-
-		pixfmt->sizeimage += info->bpp[i] *
-			DIV_ROUND_UP(aligned_width, hdiv) *
-			DIV_ROUND_UP(aligned_height, vdiv) / info->bpp_div[i];
-	}
+	for (i = 0; i < info->comp_planes; i++)
+		pixfmt->sizeimage +=
+			v4l2_format_plane_size(info, i, width, height);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(v4l2_fill_pixfmt);
-- 
2.42.0

