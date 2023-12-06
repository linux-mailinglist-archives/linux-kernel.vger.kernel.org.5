Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD625807340
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379067AbjLFPCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378966AbjLFPCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:02:01 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E349A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:02:07 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ca0d14976aso39377801fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701874925; x=1702479725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1zZpsz6Hajn4WlNLB7bRKZ+RtbXlToJX9UdTVguXzw=;
        b=LxRBVTGF5WYysnS8BmximysOIWTqgd12VcbeKiQwXFb6kNZAQPT6KGbNFQDKbsvkbR
         t1Y6ps6pVz6tri1g2EW6JLkNJC2dNGFl7cYzPLbyYDisrPtlzcpq9lf+RztI7UlVH6x1
         fza045HXmrfXC9UQuO8S12RSyG1oaZsSErAlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701874925; x=1702479725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1zZpsz6Hajn4WlNLB7bRKZ+RtbXlToJX9UdTVguXzw=;
        b=vJsfBQOQt0rYaj12pbH3zjmzS0UCEdLk6mL2gcQx+Iyr9b3IYtL8dAnVbThp/t96ON
         vaGhBBCTrgn9ZxwZrJ40HLejalNpmL5S32ck5qa6OaWyDG3SRORArgTMoOTBL7zvUz7O
         Ry/j9eSxk4090VMBIcxsQL5/HbkNmHPaU1qGTTkAGtEUKqpxQFu3sUxRl+qfP4jM/Wna
         uxHIKe7Z7nffBA0GJTR5WCUy96waIVmO+CBrQ7QhzuyYOLx8mai2VTNdrb841EqMONIz
         o2FbZ0Tp5Yp9FGax2PvWpGPkUCCiR0GYLqh+BMfuG/lin2oJDWoXPuucUmkdsktxvVoR
         xH7g==
X-Gm-Message-State: AOJu0Ywwgil3YbkhY3LOCbzx6aA3r4FZhUfakdFt0pzKBfTsFrQ2NG5f
        0CN2pSsIfL9DVwvvDBz0/cimggIRPhUWat11JH/Gug==
X-Google-Smtp-Source: AGHT+IGZNKBNPt39cTvI8EJKSjRt2XOXR6LOhsuTh1v/i0pyQvPn4ufkZh9/uUwGpLeyj0SrWl+OoQ==
X-Received: by 2002:a2e:a7c2:0:b0:2ca:2966:e754 with SMTP id x2-20020a2ea7c2000000b002ca2966e754mr234967ljp.21.1701874925276;
        Wed, 06 Dec 2023 07:02:05 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:9e85:9d11:a604:aaf7])
        by smtp.gmail.com with ESMTPSA id ca19-20020a170906a3d300b00a1dc4307ed5sm20076ejb.195.2023.12.06.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:02:04 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/debugfs: drop unneeded DEBUG_FS guard
Date:   Wed,  6 Dec 2023 16:01:55 +0100
Message-ID: <20231206150201.669055-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefile enables/disables the file compilation depending on
CONFIG_DEBUG_FS.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/drm_debugfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index f291fb4b359f..f80d9cf3e71a 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -45,8 +45,6 @@
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
 
-#if defined(CONFIG_DEBUG_FS)
-
 /***************************************************
  * Initialization, etc.
  **************************************************/
@@ -588,5 +586,3 @@ void drm_debugfs_crtc_remove(struct drm_crtc *crtc)
 	debugfs_remove_recursive(crtc->debugfs_entry);
 	crtc->debugfs_entry = NULL;
 }
-
-#endif /* CONFIG_DEBUG_FS */
-- 
2.43.0

