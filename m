Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B637A9D99
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjIUTmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIUTmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:42:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064B07D96
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso1228090b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695324512; x=1695929312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZtAYqJWE7JpdsZxb5rfWkU3kZ2lTrkKomU0ysGX5d0=;
        b=ToDHSlZL2ePyl5Fy5MYy4QymnfmjAzXN7tA6azG2N3WLAFyjK8LPmf1PxPBfFsYVBk
         +MLMjrmk98l21JXBPpSX5nh491HXyHEENNsNXlfTDFTWo/c/0/2moZAj3+rejToe5VIB
         5tX0fiqCKBhcmDoNIqvpYmXyP3YqeouI5xEUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324512; x=1695929312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZtAYqJWE7JpdsZxb5rfWkU3kZ2lTrkKomU0ysGX5d0=;
        b=R82AALYUmsAXkgtdJfoaqQj5iZlN57VJ8I+oljXEDDOKloza8zum7WheeaXjNC/dDI
         Nyloph3lk4P82bDekdEHy1HsOx9pKUN1i8fLrMDnA/dCF75+ra2IIvOWvJuK0y5YlgBx
         VsgwmGQy2vUybk/TW8mvTNHjCxgP2lEcdHw7n/RZVfCkAa/5TgVJtboajQmvKjVrn/qQ
         fseybIjn5IzUmvIAwNllJkXHA8jltTXOK9mqazn/xEb3i3WrJ7EimvHwdTvMx0rpV37I
         Ga24cSrSgLpozEaMvV2xHIlpT8XTzbDyGfVCa9sV5C1dK8a955L21t2pXZj1Bi7GKaMz
         NiKA==
X-Gm-Message-State: AOJu0YzuM0zl1iIkA7Rg7dfh72S64lnOz26ktAQGZFlMUvY/WuiIi/V2
        EM09RdXtxDMzHBFqLK69jYI3pA==
X-Google-Smtp-Source: AGHT+IFLfEFOKyhwKb3FZnAY6hGcxUNsWis48sb0QkS+Rc27anChCNA3mxZflSD413ezokJ4zowvTw==
X-Received: by 2002:a05:6a20:7f93:b0:152:6b63:f1e5 with SMTP id d19-20020a056a207f9300b001526b63f1e5mr8883328pzj.38.1695324512344;
        Thu, 21 Sep 2023 12:28:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709029a8800b001b9f032bb3dsm1892875plp.3.2023.09.21.12.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:28:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, abrodkin@synopsys.com,
        airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 06/12] drm/arcpgu: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Thu, 21 Sep 2023 12:26:49 -0700
Message-ID: <20230921122641.RFT.v2.6.I8a0a246fea222059881d01a8fff2adcf7ef3d7a4@changeid>
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

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

(no changes since v1)

 drivers/gpu/drm/tiny/arcpgu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index e5b10e41554a..c1e851c982e4 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -414,6 +414,11 @@ static int arcpgu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void arcpgu_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static const struct of_device_id arcpgu_of_table[] = {
 	{.compatible = "snps,arcpgu"},
 	{}
@@ -424,6 +429,7 @@ MODULE_DEVICE_TABLE(of, arcpgu_of_table);
 static struct platform_driver arcpgu_platform_driver = {
 	.probe = arcpgu_probe,
 	.remove = arcpgu_remove,
+	.shutdown = arcpgu_shutdown,
 	.driver = {
 		   .name = "arcpgu",
 		   .of_match_table = arcpgu_of_table,
-- 
2.42.0.515.g380fc7ccd1-goog

