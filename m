Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454D8790440
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351310AbjIAXoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351295AbjIAXnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:43:52 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A536610D2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:13 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a7aedc57ffso1704374b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611756; x=1694216556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vomcb5R4YlkPi6yAEBTRSlkjqsgpX/8uar7hs/ep3QM=;
        b=A7fmUeitqUvMSMxFr2TLY4xst8WEqKgsQ+7/zrV+uQ5GbVRHdeb1Vfk7sl0Bv72LSf
         LTCLKLWsgmayPd2Cgsvrz9XVP2Gd7i4e50LO4J8Fj2LLzzCzdYju5CfaySBQwipS4taX
         DUCBF8y+V9eXROX/bvFSB3Wxx7xY2UNnOzPE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611756; x=1694216556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vomcb5R4YlkPi6yAEBTRSlkjqsgpX/8uar7hs/ep3QM=;
        b=WqvYFspznmpOJhQOSxuQxd9NBtv8QH5WdFPP+Peq8l+1gf8qCpvt5SpE6MWbIu3ma1
         9f6qaJT5mOQc636qnMk2nrFhSFODp1CmsufYkrJ/IPsj3I4zviqG0kjorM8tJ5WY0S11
         uDvWnK2TPKzf/rSsit2vt27KTKX0sDQ8kHDpbikUjW+HobiJQSp2qwUKrPnjMvBWDcm9
         eSmrORcf24BMOijWsJk3cx715+tzMZTEhJiAYrdxQJzJHUYDc5lfgqP1m63S0EH7lAXJ
         4n/xg3FsFvuJNFSixA6tXTclkYl9R7eKRQhuAm1cGxp23OPWwiMeu5hqnpHguDJHKhDB
         +GCg==
X-Gm-Message-State: AOJu0Yz79peNy+YWNQ/57hof8sQ6ZKVfAzBVj61BtJ56w6Ehr0aW2gq+
        7hnUZwGpt+2trDtzoHA5yegj6AmnSLaqFawtRu9mdxNz
X-Google-Smtp-Source: AGHT+IH161FDJO4p2lz9ilVRETKBQ5UyI7NChHl4VMZC9iScfWTxID2/lUEJl6hXY/byI5CWz2ElFA==
X-Received: by 2002:a05:6808:28e:b0:3a7:a299:1201 with SMTP id z14-20020a056808028e00b003a7a2991201mr4034449oic.23.1693611755813;
        Fri, 01 Sep 2023 16:42:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Subject: [RFT PATCH 05/15] drm/mediatek: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Fri,  1 Sep 2023 16:41:16 -0700
Message-ID: <20230901164111.RFT.5.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901234202.566951-1-dianders@chromium.org>
References: <20230901234202.566951-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

This driver users the component model and shutdown happens in the base
driver. The "drvdata" for this driver will always be valid if
shutdown() is called and we know that if the "drm" pointer in our
private data is non-NULL then we need to call
drm_atomic_helper_shutdown(). Technically with a previous patch,
("drm/atomic-helper: drm_atomic_helper_shutdown(NULL) should be a
noop"), we don't actually need to check to see if our "drm" pointer is
NULL before calling drm_atomic_helper_shutdown(). We'll leave the "if"
test in, though, so that this patch can land without any
dependencies. It could potentially be removed later.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 961715dd5b11..8b1c9c992ca8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -921,6 +921,14 @@ static int mtk_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void mtk_drm_shutdown(struct platform_device *pdev)
+{
+	struct mtk_drm_private *private = platform_get_drvdata(pdev);
+
+	if (private->drm)
+		drm_atomic_helper_shutdown(private->drm);
+}
+
 static int mtk_drm_sys_prepare(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
@@ -952,6 +960,7 @@ static const struct dev_pm_ops mtk_drm_pm_ops = {
 static struct platform_driver mtk_drm_platform_driver = {
 	.probe	= mtk_drm_probe,
 	.remove	= mtk_drm_remove,
+	.shutdown = mtk_drm_shutdown,
 	.driver	= {
 		.name	= "mediatek-drm",
 		.pm     = &mtk_drm_pm_ops,
-- 
2.42.0.283.g2d96d420d3-goog

