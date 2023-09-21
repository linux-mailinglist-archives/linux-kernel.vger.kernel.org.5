Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085487A9DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjIUTpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjIUTp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:45:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A494236
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c3d6d88231so11301625ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695324503; x=1695929303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhFda07Eo+JhAQAACXr7n7to50ItTosGgo10Du+RGvo=;
        b=f0lhqKw3oJ1yFQA9tqXZV9wOds8/+79QdXFdG5im3zc8TOsvqe//6yLOCH9sctWUcr
         rrKN79e8HoHVXVz2G7EzvaIcPbelXn/gCeNg0877wf5DuG6e44+uz0B9AqO5o8+zTgJ0
         C1jnFfaCShAcZs7lDKWgVjHUb6MoRPryIjgqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324503; x=1695929303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhFda07Eo+JhAQAACXr7n7to50ItTosGgo10Du+RGvo=;
        b=QUI0742DULjF5GVZAtbpsqQgJQ8ekk82FSRABTHh4XYP+Mt6SoWPWxHyyXH2OZTnAo
         riY5h9KwFgxNT2cErddZ79/KTIDaDgHnIg9UIeh2AFjPf3dgHeFQRz5wyvai7Lr8ANh4
         an3ZXEuzdKC5HfzJKVlF2BSNah5GusN8oMgX7hl4dqUzVhwrmtirS+fBVPEWQk30Gtat
         8euO/EcnnveTXbkFEDUU5JLNPOtHmWHvitxcUdkIn4glkcVwMp1mmeAc2kWWeT2vCM1H
         Upa7jxiM8DrkR7HtAghhEoYQnux7xFCPd2j+ZUeCe/mFsMLyUlIZEZ5mCF6prbJUKusz
         pEMA==
X-Gm-Message-State: AOJu0YwbPnNSBbzD1z0REzmkpy4S9EXrArQbyxSbuIaduh4xjkF6yia8
        oOASKOfYA6cJTXgmZRSpan6bn+q630EJnUcXR20RMl4X
X-Google-Smtp-Source: AGHT+IH0nh1V6SVusdyeEYE29qugLYksEX+ehkYFjSjdH7aYyfOGlzf+vImX/ZKutU0AaIJ59ga9tA==
X-Received: by 2002:a17:902:f80a:b0:1c5:deaa:d72e with SMTP id ix10-20020a170902f80a00b001c5deaad72emr1042601plb.30.1695324503552;
        Thu, 21 Sep 2023 12:28:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709029a8800b001b9f032bb3dsm1892875plp.3.2023.09.21.12.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:28:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Fei Shao <fshao@chromium.org>, airlied@gmail.com,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Subject: [RFT PATCH v2 03/12] drm/mediatek: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Thu, 21 Sep 2023 12:26:46 -0700
Message-ID: <20230921122641.RFT.v2.3.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921192749.1542462-1-dianders@chromium.org>
References: <20230921192749.1542462-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Rebased and resolved conflicts.

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index d16cc8219105..6bab360c0c1a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -919,6 +919,14 @@ static void mtk_drm_remove(struct platform_device *pdev)
 		of_node_put(private->comp_node[i]);
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
@@ -950,6 +958,7 @@ static const struct dev_pm_ops mtk_drm_pm_ops = {
 static struct platform_driver mtk_drm_platform_driver = {
 	.probe	= mtk_drm_probe,
 	.remove_new = mtk_drm_remove,
+	.shutdown = mtk_drm_shutdown,
 	.driver	= {
 		.name	= "mediatek-drm",
 		.pm     = &mtk_drm_pm_ops,
-- 
2.42.0.515.g380fc7ccd1-goog

