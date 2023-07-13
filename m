Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F97B7528E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjGMQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbjGMQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:23 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFBD2D6B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:03 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3460aee1d57so3901035ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266222; x=1691858222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmUO1J5EliCxWpcWuYGhTm19HhOvYVoh1+BXohGfWSM=;
        b=KuIuySGbHxWr2luhx6hKg1vvgvRLdtiQtr3IcR8WoH7X0Wwa0/h6fJfEd8l032wPuM
         1PcWBuhFRtaPc2tsH/G2q74blfh5Of1pKjzs5UrZ7/BwJ4Vr829mXVwbVoWSvhTatmpM
         w5f39t4SCQfDcGjfKNhqVOorY0OrfhVGFb4zfUN4Toi2La7Ut33OzElFAv9ns4yn9Tg7
         Y2TfC+zBLZKXw9iwLUmq5fG3eG4pfWnsTRK1sARQfAy/F9zhQaXv+aMK6d7xCncimosU
         5pNXpFMIf8zY0r5CQJK8Hozhtn15Xl05S6Bx/kvwmoy+e50OWopriS+vdrsejTq37imB
         0HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266222; x=1691858222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmUO1J5EliCxWpcWuYGhTm19HhOvYVoh1+BXohGfWSM=;
        b=EmOKpJd18Fy6prNJfwGRvLMEqLKeSRHN7qQL2tQtfEkY4WwEtBuJdQ5bVHxfiPw5rM
         sCpjDhGjcxDF4o5BnHHC1YWD0Ru2rvTsZa0xtlrRqdRafdmw2b+CQwf4m3BUEPIYNXCV
         OtHhk1IkMgs9La9TLivNPXnT+0ah/yBUZ8AGCnj1+mI5SaG5jLnJb0pQVeRhXswttzlt
         lOHLYgZTO7oUrxz1E3aZn1EFH0M3fhBrDgYDGcEt68dLguPw7kZ+BF1ZgaozY81fDeGw
         hJ38qPP93mLlIegB/UKCpGeiDkaOn1dpH7ctK/ya+L/Z87cA0nHULY56wMMlBEgHX7uk
         ul3g==
X-Gm-Message-State: ABy/qLZU1aFVNOTCqG2w1w7V/jjv0zqQopw+eubHqeXjhW0fYqXq2ATH
        G4HB9Ms5f4hEwSwEqtw1iGo=
X-Google-Smtp-Source: APBJJlHKO7WCLEDxmaYSP3LhNmBmlPVndP0gCenFwmd4HZm4pnLqdWvaF5AZKoEED4EJ2uJ9Uqhlbw==
X-Received: by 2002:a92:d490:0:b0:347:7399:b170 with SMTP id p16-20020a92d490000000b003477399b170mr1306676ilg.32.1689266222716;
        Thu, 13 Jul 2023 09:37:02 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:37:02 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 17/21] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date:   Thu, 13 Jul 2023 10:36:22 -0600
Message-ID: <20230713163626.31338-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713163626.31338-1-jim.cromie@gmail.com>
References: <20230713163626.31338-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of burn-in testing needed before signing, upstreaming.
I set default Y to maximize testing by default.

NOTE: without __UNIQUE_ID fix in HEAD~1, this population of
DRM_CLASSMAP_USE()rs experienced name collisions in several different
@lkp-robot allyes and randconfigs, probably because the macro is
always a file-scope declarator, and is always near the top of fhe
file.  Moving declarations around tended to fix one collision, only to
create another collision elsewhere.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index ba3fb04bb691..ff478fcba67e 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -52,8 +52,7 @@ config DRM_DEBUG_MM
 
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default n
-	depends on BROKEN
+	default y
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.41.0

