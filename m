Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6346A7FC245
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbjK1OkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbjK1OkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:40:13 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F192D5B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:40:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b4c2ef5cdso6231565e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701182418; x=1701787218; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oaKrElE1AMJOvXqLWag42ZjIrLYDCFvrlaWvSZAKArw=;
        b=r3gg9VO5gCcnwDOz0pufW2ZafaiK/KADozXnqcNaxv+Agpv96S42mZj66g9d0umPKr
         lz5sG4rJEKW7g+9znCdibcl1tNEbBsNY/z8oaUONLWxar3OUa6OALrZL373AZXtuAH6I
         z6gRYIte5SJikACtGjR4dsNpRkwo7DvEY9jvxMYjN+VKRg6I8lrdujCXlArsX/OyykxZ
         fkRhz2338ofvFMnaLqiQLmx9EXgioLA3R3FrDBiMnvoIGYeUPIRYzJQCmUh64bqhwOYk
         lBt/3l31k9jlDmI7njU9gtLDaDx3VurxDLFlpy0IFakFZA9UVmmCANEfS7NsBaJp+X8A
         50Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182418; x=1701787218;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaKrElE1AMJOvXqLWag42ZjIrLYDCFvrlaWvSZAKArw=;
        b=IWuJyOdCBkZl0vMYD8CUGL2t43JWtX9s5i71OJOccfKASAJtRbYD/SQUEsSYSGMM+6
         usiwkW+n/c+R3Hj6Ry8GAg0APr216ZNHIspCvp/FeVs4a18TJOnue6s8fdyj9mH+jBX1
         yHOO2GJpMY4cVTHiXSthiNF1j5x12P5ZJoXfL4uttQICmEGqv5MmLhibze4hBoXUqogH
         11R3JWdvBEKmn99j9dCXgFj42j65v7NUASrhtNHsYrhSYNjc4zM5AKRbfkRLBXoYPxAL
         N9FHpqnBWvDLsfQNM34Yec1YmN5NaFXvryZ4r2w4Q1f6EvRgfFsiTHRdkO+twV0VykWy
         zUAQ==
X-Gm-Message-State: AOJu0Yyws9rYZAoVv2YoDnPSRI4pGcmM6sFYqg+JjOgdc37gOgMWQ8Vf
        WThKJ2blJRibN+Mlb8929mXp7waFhYKtc1ZZSs5y1vJO
X-Google-Smtp-Source: AGHT+IEUXsu35JfaoTse6WpNi0aat3trZZEVzz9HHjmeo+pJm7QYeZQ28Vz4IccP7yCA63IgMU75YA==
X-Received: by 2002:a05:600c:4f82:b0:40b:2b42:a1c9 with SMTP id n2-20020a05600c4f8200b0040b2b42a1c9mr10704074wmq.23.1701182417945;
        Tue, 28 Nov 2023 06:40:17 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b0040b37f107c4sm16321352wmo.16.2023.11.28.06.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:40:17 -0800 (PST)
Date:   Tue, 28 Nov 2023 17:40:14 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] media: staging: starfive: camss: fix off by one in
 isp_enum_mbus_code()
Message-ID: <7d222638-2d19-466d-8dd4-9e1ceb1d46f3@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These > comparisons should be >=.  The formats->fmts[] array is either
a pointer to isp_formats_sink[] or isp_formats_source[] respectively.

Fixes: e57854628f58 ("media: staging: media: starfive: camss: Add ISP driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/staging/media/starfive/camss/stf-isp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index 893dbd8cddc8..98d61d71c31b 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -120,7 +120,7 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
 	const struct stf_isp_format_table *formats;
 
 	if (code->pad == STF_ISP_PAD_SINK) {
-		if (code->index > ARRAY_SIZE(isp_formats_sink))
+		if (code->index >= ARRAY_SIZE(isp_formats_sink))
 			return -EINVAL;
 
 		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
@@ -128,7 +128,7 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
 	} else {
 		struct v4l2_mbus_framefmt *sink_fmt;
 
-		if (code->index > ARRAY_SIZE(isp_formats_source))
+		if (code->index >= ARRAY_SIZE(isp_formats_source))
 			return -EINVAL;
 
 		sink_fmt = v4l2_subdev_state_get_format(state,
-- 
2.42.0

