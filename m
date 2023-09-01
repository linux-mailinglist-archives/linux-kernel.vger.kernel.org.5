Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AB4790417
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351258AbjIAXlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351239AbjIAXlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:41:37 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F719199F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:40:58 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1ccc0d2e697so1653981fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611654; x=1694216454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjN3sfEO+JM922O5awQYKULh62YjERT8p0jq8P8wGb0=;
        b=Wbd8V+otA+BMM3/yRsAi1bAvy1aj6qmpCPDRimTTOaqJZMu6qfq6O8XfYywEQfyn5w
         vgC+KVlropb7jlG91mr2b9zmmGVYhYuir6oHJqhxfnXzh95mI6LNrkhzDzU6z2n2auce
         sL0qG0LZnyvHVb+9+7OtomMrCr3yziYJWkCnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611654; x=1694216454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjN3sfEO+JM922O5awQYKULh62YjERT8p0jq8P8wGb0=;
        b=RIr7gq7/M1YdrXK1VQQzNhK4VV6p57x6H8W5XtBEkXVONTbuBSavE7DstFFXOg565o
         J/tl0DsSj8tZeFKXN2i8SFtzQSB9Ep1HLoArgqY6Y0RJxBCCs+ur3JD5DUwiZmbNqFXa
         phGkgz4EGK+owprcsuolM1zNtSVfG2jgpL5WXMo9vguSEsHWPTVad93YGzH5zc4NbDki
         ZVIIPXtVa/8hxXMOQ5/gZuiRbZ+4hAea+yzQPkEBEHdUf0ht9MOi1+2bA4t3osvWWANy
         tdm0xyNz+Sis6Qfm7PKzDt285GoWdQydhJgAZfJqDBoGvEzMjNPi2Nqtis0q9omwxAGu
         Vn0g==
X-Gm-Message-State: AOJu0YzJOrfaaNHpNYzdZ/HyPkhEmKKmypxsKz3HA+81MaJNZQq4/wBp
        L2smoj+eO5bzFZM9drG+w71uSQ==
X-Google-Smtp-Source: AGHT+IHtZYYm3kAb6nsZHXag2Hv09GGqSDmAQq+JJIcuHqOc1L2+l/u8XFzy1Ix3zXRbzhU1ARWddg==
X-Received: by 2002:a05:6870:4290:b0:1bc:3f6:579b with SMTP id y16-20020a056870429000b001bc03f6579bmr4478955oah.22.1693611654700;
        Fri, 01 Sep 2023 16:40:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a1a4500b0026b4ca7f62csm3773488pjl.39.2023.09.01.16.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:40:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        daniel@ffwll.ch, javierm@redhat.com, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 4/6] drm/ssd130x: Call drm_atomic_helper_shutdown() at remove time
Date:   Fri,  1 Sep 2023 16:39:55 -0700
Message-ID: <20230901163944.RFT.4.I4752a39ad9f8fd08b32c2b78a8a3e40491bfb5eb@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901234015.566018-1-dianders@chromium.org>
References: <20230901234015.566018-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on grepping through the source code, this driver appears to be
missing a call to drm_atomic_helper_shutdown() at remove time. Let's
add it.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS driver remove comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

NOTE: I'm not 100% sure this is the correct thing to do, but I _think_
so. Please shout if you know better.

 drivers/gpu/drm/solomon/ssd130x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 5a80b228d18c..dc06fd82fd30 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1131,6 +1131,7 @@ EXPORT_SYMBOL_GPL(ssd130x_probe);
 void ssd130x_remove(struct ssd130x_device *ssd130x)
 {
 	drm_dev_unplug(&ssd130x->drm);
+	drm_atomic_helper_shutdown(&ssd130x->drm);
 }
 EXPORT_SYMBOL_GPL(ssd130x_remove);
 
-- 
2.42.0.283.g2d96d420d3-goog

