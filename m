Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E83B7FB2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbjK1HY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbjK1HYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:24:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E79182
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:24:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da2b8af7e89so5804162276.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701156270; x=1701761070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8A55muWkSvzSnrtuE06G95D3EwTRR81H/qJIXehCNYE=;
        b=eD0GsesOBhAzZBH/kplxySSzuceiyUg9nzOV4gFHnjE3Ey782NPKnuXVFERvC985oe
         JppY5onThnOlVKDNIC3zRmq5MII4xigtkggUparmjS679IlM3hUH02YLVS4MT/kpO9bo
         Q2J6w+mRmQ42uPmIysbO01ONcCKQFKTZQhIrw9QnQcx98zCqIjo3q4KisuRz4zKBgGaF
         G3ElAg6nTiRJizSTwNOoGYfOBoibR4Yr4PNE3gYKtwJL64lFnGJcxch1HZi4gHn2VjBZ
         1BLIcCWQQnEzck50aNa8rVh6AiVSOspASyWionfTI8Emc+aZs2RC/stdLdA2vZ8wx0nW
         KhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156270; x=1701761070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8A55muWkSvzSnrtuE06G95D3EwTRR81H/qJIXehCNYE=;
        b=tSI6WYyk6cIcAjx3W1bjpCMfJIH5dl2je7wbYWpMWWbdpHAGDX6LjCudz+MnbAXMgL
         ziQc3Ly4yAZW6SjbxLDPR+vzntFWhE9XCIloa3LuA5XWWFvdeA45wA/yTMXR7GrzrGY9
         TBDS9H0v/LPkleIAn7ebwWkuOk48lwutlZGBCr/m96v4A86QlgE05IonPYryfxZRL/3S
         uUA8nTz11WaeZ0vKC4vuKa+XUf1pOOs4qWrtiXiduwfEW0vQKnEAz2p5M7f+BJUDirhp
         paFNb0HECYXCf/ujUgONj1WHRcdbQUHNueX/prBtXcecV7eV2kAoqTzWrpbPXSwTmD/A
         rY4w==
X-Gm-Message-State: AOJu0Yya0RUB9Km4Y77T+aRNniAIvtzoWjI0jacqfsQMDOJddbGocqDp
        Q43a2w+6g8w6k2fVIsbiLWdQlA0iBhfsUQ==
X-Google-Smtp-Source: AGHT+IE7kvRypcJMNH1aBvRFoLiB9G1ImGLyl3WTQDpglv6t886iGoKBRHmMrlJFektQzH1GywC4p5ZQUuyHDQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:738c:0:b0:d90:e580:88e5 with SMTP id
 o134-20020a25738c000000b00d90e58088e5mr390789ybc.10.1701156270109; Mon, 27
 Nov 2023 23:24:30 -0800 (PST)
Date:   Tue, 28 Nov 2023 15:24:06 +0800
In-Reply-To: <20231128072410.952662-1-davidgow@google.com>
Mime-Version: 1.0
References: <20231128072410.952662-1-davidgow@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128072410.952662-2-davidgow@google.com>
Subject: [PATCH v2 2/3] drm/tests: Use KUNIT_DEFINE_ACTION_WRAPPER()
From:   David Gow <davidgow@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>, dlatypov@google.com
Cc:     David Gow <davidgow@google.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to pass functions to kunit_add_action(), they need to be of the
kunit_action_t type. While casting the function pointer can work, it
will break control-flow integrity.

drm_kunit_helpers already defines wrappers, but we now have a macro
which does this automatically. Using this greatly reduces the
boilerplate needed.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: David Gow <davidgow@google.com>
---

No changes since v1:
https://lore.kernel.org/linux-kselftest/20231110200830.1832556-2-davidgow@google.com/

---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 30 +++++++----------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index bccb33b900f3..c251e6b34de0 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -27,27 +27,15 @@ static struct platform_driver fake_platform_driver = {
 	},
 };
 
-static void kunit_action_platform_driver_unregister(void *ptr)
-{
-	struct platform_driver *drv = ptr;
-
-	platform_driver_unregister(drv);
-
-}
-
-static void kunit_action_platform_device_put(void *ptr)
-{
-	struct platform_device *pdev = ptr;
-
-	platform_device_put(pdev);
-}
-
-static void kunit_action_platform_device_del(void *ptr)
-{
-	struct platform_device *pdev = ptr;
-
-	platform_device_del(pdev);
-}
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_driver_unregister,
+			    platform_driver_unregister,
+			    struct platform_driver *);
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_device_put,
+			    platform_device_put,
+			    struct platform_device *);
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_device_del,
+			    platform_device_del,
+			    struct platform_device *);
 
 /**
  * drm_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
-- 
2.43.0.rc1.413.gea7ed67945-goog

