Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19778C1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjH2Jwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjH2JwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:52:22 -0400
X-Greylist: delayed 1257 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 02:52:17 PDT
Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84524EA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:52:17 -0700 (PDT)
Received: from mail03.siengine.com (localhost [127.0.0.2] (may be forged))
        by mail03.siengine.com with ESMTP id 37T9VKtA006171
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:31:20 +0800 (+08)
        (envelope-from lucas.liu@siengine.com)
Received: from dsgsiengine01 ([10.8.1.61])
        by mail03.siengine.com with ESMTPS id 37T9UBnI006104
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 29 Aug 2023 17:30:11 +0800 (+08)
        (envelope-from lucas.liu@siengine.com)
Received: from SEEXMB04-2019.siengine.com (SEEXMB04-2019.siengine.com [10.8.1.34])
        by dsgsiengine01 (SkyGuard) with ESMTPS id 4RZhwf3MPkz7ZMc9;
        Tue, 29 Aug 2023 17:30:10 +0800 (CST)
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB04-2019.siengine.com (10.8.1.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1258.25; Tue, 29 Aug 2023 17:30:09 +0800
Received: from localhost.localdomain (10.12.6.21) by
 SEEXMB03-2019.siengine.com (10.8.1.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.1258.25
 via Frontend Transport; Tue, 29 Aug 2023 17:30:09 +0800
From:   "baozhu.liu" <lucas.liu@siengine.com>
To:     <liviu.dudau@arm.com>, <airlied@gmail.com>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "baozhu.liu" <lucas.liu@siengine.com>
Subject: [PATCH] drm/komeda: add NV12 format to support writeback layer type
Date:   Tue, 29 Aug 2023 17:30:03 +0800
Message-ID: <20230829093004.22860-1-lucas.liu@siengine.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: mail03.siengine.com 37T9VKtA006171
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing the d71 writeback layer function,
the output format is set to NV12, and the following error message is displayed:

[drm:komeda_fb_is_layer_supported] Layer TYPE: 4 doesn't support fb FMT: NV12 little-endian (0x3231564e) with modifier: 0x0..

Check the d71 data manual, writeback layer output formats includes NV12 format.

Signed-off-by: baozhu.liu <lucas.liu@siengine.com>
---
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
index 6c56f5662bc7..80973975bfdb 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -521,7 +521,7 @@ static struct komeda_format_caps d71_format_caps_table[] = {
 	{__HW_ID(5, 1),	DRM_FORMAT_YUYV,	RICH,		Rot_ALL_H_V,	LYT_NM, AFB_TH}, /* afbc */
 	{__HW_ID(5, 2),	DRM_FORMAT_YUYV,	RICH,		Flip_H_V,		0, 0},
 	{__HW_ID(5, 3),	DRM_FORMAT_UYVY,	RICH,		Flip_H_V,		0, 0},
-	{__HW_ID(5, 6),	DRM_FORMAT_NV12,	RICH,		Flip_H_V,		0, 0},
+	{__HW_ID(5, 6),	DRM_FORMAT_NV12,	RICH_WB,	Flip_H_V,		0, 0},
 	{__HW_ID(5, 6),	DRM_FORMAT_YUV420_8BIT,	RICH,		Rot_ALL_H_V,	LYT_NM, AFB_TH}, /* afbc */
 	{__HW_ID(5, 7),	DRM_FORMAT_YUV420,	RICH,		Flip_H_V,		0, 0},
 	/* YUV 10bit*/
-- 
2.17.1

