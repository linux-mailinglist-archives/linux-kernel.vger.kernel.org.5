Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E09752E53
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 02:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjGNAh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 20:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGNAhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 20:37:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574F5211C;
        Thu, 13 Jul 2023 17:37:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6686a05bc66so1000299b3a.1;
        Thu, 13 Jul 2023 17:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689295073; x=1691887073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CctAjUFV1xpereksxrBg0+mczOOOQo8Ume+knSAyNSA=;
        b=lYJpcJRJb9SNL3nkgSZJixYh9SFl72yF1riPiYiU8ciraE3COWM1XxqEcRv2LXBGi4
         wQx9jFsqpPNRfK1lPzrOVs3ut0a5jR8GlT/JvhNyeHGIewXMcfMxxWBFmDMyH1JjL8lU
         lntJP6Y3pGlDGZo8MrpLf+8844EE+0JJdNCG3gGFfKMcuzrOqN39yFFpm3H7BWPQvkLG
         FtWgm+EsPtlACRVy2WfZOPx/FzVJd4bazCeZjywlak2gDsY4yR+3FoIzmISFHqRYuv97
         20/M90KLBiKKvcVVLCN7PbMnGsw6/NJwo211cglp84au5+sOuJd0izOZnPxTgQOHTl2w
         AxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689295073; x=1691887073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CctAjUFV1xpereksxrBg0+mczOOOQo8Ume+knSAyNSA=;
        b=B2Hu91nY/EVUW+pddPSyWJ2MVTA0fey6FuhoLsDkUVubmyrMFNHeQPejVVtrC4zFfo
         /TAgp/falK+V9pOI8tlnHQlU8amOP8HXWlejGkWpVvHVslceNXdPbBw2jqGehywMb2CO
         IpReQ8qc612wGbtWNTCUXhK8PXarog3SngLOwuZs3GcR3Y8CzrSBOs3gRokY6R+WMqCu
         zYWchLuzDAUq19ctiEry6bgr6fl5Bf7XTvwZs9sq3m1yAX6AyYPi5mA7GPgcrKSCadWo
         m2WSmrJI2UG8NkmkpUwwzYdlWeSX0UUDsZUYMCuzvTq5k+9T5oIOXwK+4cQkNBlkZNLY
         g8zg==
X-Gm-Message-State: ABy/qLaRuONLonZZPwpYsNgcZlUjVHoIBzilZDEYVn94qWwbGB++ZRZ6
        8ASfAPLIv7k1pJUEdwCMXWCS0NfU/dg=
X-Google-Smtp-Source: APBJJlEiHiaptAXuvtXrlZ6sVYZbgFP0Qaahhb0xY+3xGXgYFbidFVi2AxUIRJJ595Diplb5DXLQVA==
X-Received: by 2002:a05:6a00:2492:b0:64d:5b4b:8429 with SMTP id c18-20020a056a00249200b0064d5b4b8429mr3305331pfv.18.1689295072299;
        Thu, 13 Jul 2023 17:37:52 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-70-13.dynamic-ip.hinet.net. [36.228.70.13])
        by smtp.gmail.com with ESMTPSA id s11-20020a62e70b000000b006825003a276sm5970384pfh.42.2023.07.13.17.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 17:37:51 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: fbmem: mark registered_fb static
Date:   Fri, 14 Jul 2023 08:37:46 +0800
Message-Id: <20230714003748.91129-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark registered_fb, num_registered_fb, fbcon_registered_fb, and
fbcon_num_registered_fb static to fix the following sparse
warnings:

drivers/video/fbdev/core/fbmem.c:51:16: sparse: warning: symbol 'registered_fb' was not declared. Should it be static?
drivers/video/fbdev/core/fbmem.c:52:5: sparse: warning: symbol 'num_registered_fb' was not declared. Should it be static?
drivers/video/fbdev/core/fbcon.c:105:16: sparse: warning: symbol 'fbcon_registered_fb' was not declared. Should it be static?
drivers/video/fbdev/core/fbcon.c:106:5: sparse: warning: symbol 'fbcon_num_registered_fb' was not declared. Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 4 ++--
 drivers/video/fbdev/core/fbmem.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c6c9d040bdec..4336c7d64ed0 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -102,8 +102,8 @@ enum {
 
 static struct fbcon_display fb_display[MAX_NR_CONSOLES];
 
-struct fb_info *fbcon_registered_fb[FB_MAX];
-int fbcon_num_registered_fb;
+static struct fb_info *fbcon_registered_fb[FB_MAX];
+static int fbcon_num_registered_fb;
 
 #define fbcon_for_each_registered_fb(i)		\
 	for (i = 0; WARN_CONSOLE_UNLOCKED(), i < FB_MAX; i++)		\
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 329d16e49a90..18355655959a 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -48,8 +48,8 @@
 
 static DEFINE_MUTEX(registration_lock);
 
-struct fb_info *registered_fb[FB_MAX] __read_mostly;
-int num_registered_fb __read_mostly;
+static struct fb_info *registered_fb[FB_MAX] __read_mostly;
+static int num_registered_fb __read_mostly;
 #define for_each_registered_fb(i)		\
 	for (i = 0; i < FB_MAX; i++)		\
 		if (!registered_fb[i]) {} else
-- 
2.34.1

