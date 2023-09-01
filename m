Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7C790418
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351231AbjIAXld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351229AbjIAXlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:41:31 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D7110F8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:40:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-569deb93999so1840196a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611645; x=1694216445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1LlxEF4RQMcRybMyLUYgejZ0HV1kn3rreyInd+SMhw=;
        b=XBhWShFPR1RSx6EKUhplpox2LnfAVYalodlp16fzfOLr2D5fmIlQS9oR9lhZ5HV05f
         Gr1BpS7aY4ldg6myoWPdZFLlKoXgBwpQolGRlvtF5u2kXb84aNF45aH6QHLdN7NpQpFD
         VRP699LtNxFGieXYK7uU7JzqRAWx+lWYBhIUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611645; x=1694216445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1LlxEF4RQMcRybMyLUYgejZ0HV1kn3rreyInd+SMhw=;
        b=aEmf+a17RtK21dpVf2Vm3yt7Cy3UNZjl53d08AfW/RK/6/n5Nao5YAyTD89G4T4TRw
         BGEjZpVLRmFSjxQXTHh1VNxioBo3l+utRA32HKtzXadMdvr+MYdCNOoCexnxqw8GFXc1
         EgBR9M7A8dIB36jLRWOR9Err1EpChebfFIWsbqRgFo6kguRhly65itWsolZpwNwtMnFG
         g9VxTn/BHVYr1g0kLGstNV6LIhyi5stJ0e31K9rR10Mgri6bV+FCyN9wkd6KmFnjYRdr
         g3mmHMfox6IAv4AAiloaw3haRJj3qAyusDGt8s6xRXFlH5/cvGLH8sIiuYL3Ww+rzFgi
         HLWA==
X-Gm-Message-State: AOJu0YzvdMW3WfxIMIzXSn7712lm/5pl9BMmtjPuTbjhxjp5M/HVMnza
        7NsYtcyRPvWzdKlRBRhq5TAYYQ==
X-Google-Smtp-Source: AGHT+IHdqIX+XBiRHTDluS5KvZ5QkvIQj+FK8jGum6b97Eu1rT0JDLuFn7HoN6B/O2zYYxeetoxxxA==
X-Received: by 2002:a17:90b:33cc:b0:269:96e:7d52 with SMTP id lk12-20020a17090b33cc00b00269096e7d52mr3827916pjb.26.1693611645262;
        Fri, 01 Sep 2023 16:40:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a1a4500b0026b4ca7f62csm3773488pjl.39.2023.09.01.16.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:40:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de
Subject: [RFT PATCH 1/6] drm/atomic-helper: drm_atomic_helper_shutdown(NULL) should be a noop
Date:   Fri,  1 Sep 2023 16:39:52 -0700
Message-ID: <20230901163944.RFT.1.I906acd535bece03b6671d97c2826c6f0444f4728@changeid>
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

As with other places in the Linux kernel--kfree(NULL) being the most
famous example--it's convenient to treat being passed a NULL argument
as a noop in cleanup functions. Let's make
drm_atomic_helper_shutdown() work like this.

This is convenient for DRM devices that use the "component" model. On
these devices we want shutdown to be a noop if the bind() call of the
component hasn't been called yet. As long as drivers are careful to
make sure the drvdata is NULL whenever the driver is not bound then we
can just do a simple call to drm_atomic_helper_shutdown() with the
drvdata at shutdown time.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/drm_atomic_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 292e38eb6218..71d399397107 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3339,6 +3339,9 @@ void drm_atomic_helper_shutdown(struct drm_device *dev)
 	struct drm_modeset_acquire_ctx ctx;
 	int ret;
 
+	if (dev == NULL)
+		return;
+
 	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
 
 	ret = drm_atomic_helper_disable_all(dev, &ctx);
-- 
2.42.0.283.g2d96d420d3-goog

