Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341A579044F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351340AbjIAXoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351277AbjIAXn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:43:59 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513C41991
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:23 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5735282d713so1489469eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611763; x=1694216563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4TY+mfn1StbQRy79Smag9rvt1YGLeZB0A1g4xD0EoY=;
        b=L0wEXyKYEB/0OrpRhb6aZ3Y6qlbzCX9Tvh0R632JS86KqJ+gvBqFEZaxYw2YqPG+kU
         daasImSVboWjZQacBJBKfA8jRpFzuGQNSIvHYcTy6I2phEKirrYaInK6wZD7ocWjzle3
         1S6WM1H08S0hX7x713avyr6623kVVyonqeuE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611763; x=1694216563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4TY+mfn1StbQRy79Smag9rvt1YGLeZB0A1g4xD0EoY=;
        b=Ar4BfNccFOszE4LrnH2bKoJzfoMX91oMyFJJTxsVZOL0k04NOIO+WUI0yGVRNYX+mF
         Lb0nJaW4GaUL7MWMm9SNW1VN99Y/nDp3qmuqHjODiCGDyNg07jZqnBpthySzccBRjvN9
         6dQaiAfX89+uDJvHoChElC5G8HjJqjqblomAq5lDAwY+xgstw+DK66Cc34mrzkz2O3u0
         5Y7/BkWpiw15u90lwv+Od+5ilGI2nODE/On2YzlE7HIygqpIQWBPrLc8iqsbD79VlxkH
         Qc41O1HwW0WWABwQ22u1mt2jmp+bzfZvkTfjbHbYRwfNeD4KqmqeejZklO7VlX7kZdy9
         vq1Q==
X-Gm-Message-State: AOJu0YwuWy70qubZGAGv/n9jfgxQc+WGuTPCLPWdxh4qPwRxc/wth6Qt
        kBk2SOWYwummo+PI6luxHPj3AQ==
X-Google-Smtp-Source: AGHT+IF7UPzkkGzgqVZz1o/USebNUQJU5okEoq2BB0eQhVhRuIETriXPYYu2vmslkxHSUlAV+cQf2A==
X-Received: by 2002:a05:6358:6f92:b0:134:e603:116e with SMTP id s18-20020a0563586f9200b00134e603116emr4089163rwn.6.1693611762893;
        Fri, 01 Sep 2023 16:42:42 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, abrodkin@synopsys.com,
        airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 08/15] drm/arcpgu: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Fri,  1 Sep 2023 16:41:19 -0700
Message-ID: <20230901164111.RFT.8.I8a0a246fea222059881d01a8fff2adcf7ef3d7a4@changeid>
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

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

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
2.42.0.283.g2d96d420d3-goog

