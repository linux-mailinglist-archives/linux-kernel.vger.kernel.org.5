Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C377CE403
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjJRRIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjJRRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:07:14 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EF9D60;
        Wed, 18 Oct 2023 10:06:39 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a66bbb6c1dso41075339f.0;
        Wed, 18 Oct 2023 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648798; x=1698253598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SAgGhvFgEq3ojom6jJPWJ2MyF/faZd9tWGs5HOFcQQ=;
        b=JjIPyw4RfXYATRpJtR2VlWZvL7ttmaNVc8xYjzJ8z/xtig3vdvt+KZFohNEzzcZHav
         Apii499Zj4H53YuCVk1GelG9dCIK8oejASr5zoCC1LHlJWeO+UTlfFJx/XWEdxiE7whF
         4ykoovC2jMjb43wFGIG5ixkvn52nJanIQJUqL87grdYDArKSfS7UPhwcl0xhGgmB21Gu
         nLUff75I/IjO3bVuYt4EHhRHg+7GUr1l8lx4CCCZcu6nOKaumUnAF4060/nQAspeKSss
         K4mOXvZR8AKue0FjwsQj8dv+sW8lXK96BbcIy/q+DrXBqfHvMKGnr/p+Anynj37ORV19
         564A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648798; x=1698253598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SAgGhvFgEq3ojom6jJPWJ2MyF/faZd9tWGs5HOFcQQ=;
        b=lpx0Y0GKMl8veALoftwahuZjibs0lLwikXuEa+4kqWyLUYxrexVeFizYLzw2Kf3g9i
         TO1EB1afXT09oOjYLJipZcOW8B3Uxgclbmf5LRhev1+yRWNDMFEh1/1/JxViY9ylfNWK
         S7Xjiiy4853xjqroAMkip2qGoL/hU/X/plIyFA/9/cpONEkyMjGxTMCx4a/C8+dlhMSh
         pYH0+C7iWcSGVtz8RYUOXy2F6tVzhGEX6MD1rt8qo6Z0NHa8/Fx0+wcmiMU01SuKK+ej
         lukp2mAgFZ5NY9kfDr0gpoxPoOeJADOK6cbgnu7YBHJk643KayOIpiL1tdIGmbVQcslM
         QyAw==
X-Gm-Message-State: AOJu0Yxy75JLWLpCPEMzqeXOv7s9kdndo5k6E0tuPjzOGPw0K+/z92QF
        a/vDkGyIkVLQNb9/K6AcG0rFYUh7C+Atog==
X-Google-Smtp-Source: AGHT+IFTSza/HJPQYSXt9aC+Z3bMnTeu2Q7duokDt8Cb04HcVXXahtQEMWsjZYgH+ocYvA0wZN+VWA==
X-Received: by 2002:a05:6602:2f09:b0:79f:97b6:76de with SMTP id q9-20020a0566022f0900b0079f97b676demr6696853iow.3.1697648798580;
        Wed, 18 Oct 2023 10:06:38 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n4-20020a5d8244000000b0079fa1a7cd36sm1228944ioo.30.2023.10.18.10.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:06:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7c 24/24] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date:   Wed, 18 Oct 2023 11:06:04 -0600
Message-ID: <20231018170604.569042-25-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018170604.569042-1-jim.cromie@gmail.com>
References: <20231018170604.569042-1-jim.cromie@gmail.com>
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

Lots of burn-in testing needed before signing, upstreaming.

NOTE: I set default Y to maximize testing by default.
Is there a better way to do this ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 3caa020391c7..708f5e8cb205 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -55,8 +55,7 @@ config DRM_DEBUG_MM
 
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

