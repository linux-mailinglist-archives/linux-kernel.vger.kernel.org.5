Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EEB7ACB9B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjIXT0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIXT0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:26:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518CFF1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso669829366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695583576; x=1696188376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P67yQ9/R8vP33MNrFu8s/BR4RgUF4Oo7AxmSI7wtbGo=;
        b=LRbg1WbVE61YqEHyiUHXU46unUMx1cX1WEkhs2nBnEmlMGhgIPkThEj6CgIDs5J9RI
         50GmpeOEqUYqw1hu/b2J8MFnfDNcNifXx3SQQ4gXifrL0wcoeU3GdrmYsPvLg9qqj8GS
         ub3xww6C5eU/h+bcXgzQ0FdTvHA6E+B5q5Y4RlxkUCANm1mtXiPZ2JCUhVul1KA9FUk+
         jR4Tbsq+FWKBCPXON0yc4crm+SMBeX00byqXKfEdDqgKUNzX1cC2s7TbsEUvDD403qOk
         0LMbqUWEhF8uakDHAk3nzT4cEql3ntKmC53L2AUnvjzRApP2u6IPo8TYDrBmovkZNifD
         iNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695583576; x=1696188376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P67yQ9/R8vP33MNrFu8s/BR4RgUF4Oo7AxmSI7wtbGo=;
        b=H6LFlaGqTywppzoqeA9UzyAlSwOa4/+5/ht4zdXqf/HR0RpUc+pWSDW8miULZOUBte
         wBU1cwCFN9p8w0JTtVauTqDvMrSNSqruFL8q7L8ZA3zlhs2TORv+Wfzp2YECA38YE8oQ
         hOGi5Q91Uh5Dt4QgwIwY2WCA1OZm4j8TnVxK2GIyydoAnP7g2jqx0NEoM8XVi402Xfnh
         SzKVe3S9RhUOUykBFGS4leKu+AgO6v8+Zm7JPDARA3W3VM3YAlGoUAn7aO/0HkFc1Doi
         9VttmnFWvkUVpRSaC/5e+tOjR5VTaHVLAKY2UGDgXA+A+y8U8dBz32ojf9vRdAGkDWfJ
         w47Q==
X-Gm-Message-State: AOJu0YyCfXU/EGyqRm3DKWFf/NWTcMbWS+4wYCsOFLZtXMhwmH65Mje4
        hnL6grQSKmgeLuPfDZT8j3s=
X-Google-Smtp-Source: AGHT+IGYcIjckD309lYilHv1Z7GzrnSkK3WVyjDqrq0qtPDgxT6RI3OTizpfVXr1WSEMocNk7yTMyQ==
X-Received: by 2002:a17:907:775a:b0:9b0:169b:eee2 with SMTP id kx26-20020a170907775a00b009b0169beee2mr4068950ejc.10.1695583576620;
        Sun, 24 Sep 2023 12:26:16 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b0099d0c0bb92bsm5317632eje.80.2023.09.24.12.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:26:16 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 4/7] drm/sun4i: Don't show error for deferred probes.
Date:   Sun, 24 Sep 2023 21:26:01 +0200
Message-ID: <20230924192604.3262187-5-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
References: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers probing in display pipeline can be deferred for many reasons.
Don't print error for such cases.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 6a8dfc022d3c..b4816a1b0be3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -88,7 +88,8 @@ static int sun4i_drv_bind(struct device *dev)
 
 	ret = component_bind_all(drm->dev, drm);
 	if (ret) {
-		dev_err(drm->dev, "Couldn't bind all pipelines components\n");
+		dev_err_probe(drm->dev, ret,
+			      "Couldn't bind all pipelines components\n");
 		goto cleanup_mode_config;
 	}
 
-- 
2.42.0

