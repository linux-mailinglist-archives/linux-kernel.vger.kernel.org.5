Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD6A76507A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjG0KBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjG0KBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:01:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF109C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:01:37 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb8e45185bso4677875ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690452097; x=1691056897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CARYd8ARiLxF5jPoq3PGLDFWv0ljfFGEfqeFhyIpcRU=;
        b=dXLsqrrNBLBrIkAdUcLisQXUAPad2iWVIeWLiXeQ5I42iC0MjkrP5YTJkR0zFEtBA0
         /23ZdFidAHj/23+wehfD9Mt2fqE1S/bvOuiIusc/QWGl9pIoOk7VY3MyuWxayS0RcDNv
         R6Hpu+9pJQ6345N/VjPCBdurYfmFD0RhkwQr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690452097; x=1691056897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CARYd8ARiLxF5jPoq3PGLDFWv0ljfFGEfqeFhyIpcRU=;
        b=TqB+a3hh25BEZr6bG1BvqtYJNzVPjRO94BkCbgW2YrdAWin+FW12FcOjfKUdGUnOtT
         H1pllHCqmcK0knjxZBqIG0EWQW96fnhDXve2FGZWytBj2sa+Ly5DcbmFjRW1TAR7EPPx
         7lW3Urx6d0/zDd2G+MEHB7SPBIoNPS4DYAC6wOwMk9vioE+ZtBI0sTaCtq2KInnrfjoj
         ArOk8MwZKsN+EkTMqu3TzEeV1FCOVQCncy4kRcQdEafvO9yLdBWJhcWABddTICSnCUKa
         j6n/aO6n6YoQ/vIbXrwJQfV4jp7okKWtJxHpvFGAuIPMvy9crpjGnaP/ncu2jKriCBPZ
         EeUA==
X-Gm-Message-State: ABy/qLbkVDXSnjfUzQzP9coYFu0JzW6N6upQ60RyDb0cQEzjbjqUqAUl
        AMAZuc9mZ7DKcTC8wQgXxzdWtg==
X-Google-Smtp-Source: APBJJlFY40YO/cks4NQsjjmQjn7CZmUmhVYqeVRxBuQoVSYFcEa2b1lCRtUalXLwI4oMULKg21fNhA==
X-Received: by 2002:a17:902:a9c1:b0:1bb:77a0:33e9 with SMTP id b1-20020a170902a9c100b001bb77a033e9mr3583731plr.58.1690452097090;
        Thu, 27 Jul 2023 03:01:37 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:dc11:8e9e:95e:4068])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001bba7aab826sm1199913plb.163.2023.07.27.03.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 03:01:36 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] drm/bridge: it6505: Check power state with it6505->powered in IRQ handler
Date:   Thu, 27 Jul 2023 18:01:10 +0800
Message-ID: <20230727100131.2338127-1-treapking@chromium.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On system resume, the driver might call it6505_poweron directly if the
runtime PM hasn't been enabled. In such case, pm_runtime_get_if_in_use
will always return 0 because dev->power.runtime_status stays at
RPM_SUSPENDED, and the IRQ will never be handled.

Use it6505->powered from the driver struct fixes this because it always
gets updated when it6505_poweron is called.

Fixes: 5eb9a4314053 ("drm/bridge: it6505: Guard bridge power in IRQ handler")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 drivers/gpu/drm/bridge/ite-it6505.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 6c2fcd8b8780..2f300f5ca051 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2517,9 +2517,11 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 	};
 	int int_status[3], i;
 
-	if (it6505->enable_drv_hold || pm_runtime_get_if_in_use(dev) <= 0)
+	if (it6505->enable_drv_hold || !it6505->powered)
 		return IRQ_HANDLED;
 
+	pm_runtime_get_sync(dev);
+
 	int_status[0] = it6505_read(it6505, INT_STATUS_01);
 	int_status[1] = it6505_read(it6505, INT_STATUS_02);
 	int_status[2] = it6505_read(it6505, INT_STATUS_03);
-- 
2.41.0.487.g6d72f3e995-goog

