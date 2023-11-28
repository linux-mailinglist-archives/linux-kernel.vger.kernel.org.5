Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8847FB2A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbjK1HYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343847AbjK1HYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:24:30 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4242DD45
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:24:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca2a6f07b6so74589377b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701156274; x=1701761074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hL9Tqag7AJX6zAdbbkbaDwLX0iVjHOEY+HYssYNlBSs=;
        b=R3O79Cw8aWGA1Ko2Wlpc7FUaut6rEhvk3H35RBLLYZqFbPxBL3pU8Q0gTRsoUhnH8Z
         odE5pA+ErI5frmKIGo2WNviooWT9caTN/vNtcclMttrIS3k9rn+WiTqcwH5xODKd3Z6a
         c8DlSj+6t7PR7zsE9yZWnCCswQT5QqzcnAbQd2dwIu5r/3z9YPCs2LdZVumjKq5xedDz
         4NXI2jz71GhRJBN5Wl2j3Ggo/sQcBqmipjCNQFWMnCh1dRumkxhXMwY2u14EA8/GkXah
         nuDbZB1+MAbNUpxf6TEC2lVi2BqAF9I/RdQDxC4/NlEcYJpcDBXDcYa+zlkvHFVzmVE2
         /mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156274; x=1701761074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hL9Tqag7AJX6zAdbbkbaDwLX0iVjHOEY+HYssYNlBSs=;
        b=pcqYTVKQKgPgWS/yeqzS2Y7fNGZjVEAy8h3HV2FYbBzatCU40Mirpi1uhYkOqMpgPq
         2thOuQMr3v7cZuiJkmp3+jRDeoP5NCUaRiy6PJZdChAu94RyWUA+O5JAG0S/v58UQxzJ
         MeRJMKV/A0VPqPNfilbnoypYUgrNFKfNzQ7mhYYHdZlr3IE3ROg1TCp9hY3sFDRoMarv
         GvH5r3PJzsjZ9xjEfbsesBR1exZnwsozokaLGQe5SIb+bCo59f2nBjp+/piIl0m1bNzc
         vuo6nezFaIonFEcURnnV0Ramqim+zSbeX06yg92oO92pmFauRG7CdK+nBf8TiMs1Xfmi
         sKjA==
X-Gm-Message-State: AOJu0YyYO1UulRoB6nGYmFFNC2OFVEMNjWk/nZad45lLWFbP3hrp9QFE
        yug4s0IUaJBF5ywRKJHD2d6dcadVJqzX5Q==
X-Google-Smtp-Source: AGHT+IGoRIHKr3JyrbM3tkKrf0PmKkWlRFIRiSnxD6FAHnrPxKsZM4C/FRkjkDW0SuhziYxtsE89EeXxGNnLEA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:3741:0:b0:db5:2a4:aef1 with SMTP id
 e62-20020a253741000000b00db502a4aef1mr30191yba.13.1701156274525; Mon, 27 Nov
 2023 23:24:34 -0800 (PST)
Date:   Tue, 28 Nov 2023 15:24:07 +0800
In-Reply-To: <20231128072410.952662-1-davidgow@google.com>
Mime-Version: 1.0
References: <20231128072410.952662-1-davidgow@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128072410.952662-3-davidgow@google.com>
Subject: [PATCH v2 3/3] drm/vc4: tests: Use KUNIT_DEFINE_ACTION_WRAPPER
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to pass functions to kunit_add_action(), they need to be of the
kunit_action_t type. While casting the function pointer can work, it
will break control-flow integrity.

vc4_mock already defines such a wrapper for drm_dev_unregister(), but it
involves less boilerplate to use the new macro, so replace the manual
implementation.

Signed-off-by: David Gow <davidgow@google.com>
---

No changes since v1:
https://lore.kernel.org/linux-kselftest/20231110200830.1832556-3-davidgow@google.com/

---
 drivers/gpu/drm/vc4/tests/vc4_mock.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.c b/drivers/gpu/drm/vc4/tests/vc4_mock.c
index 63ca46f4cb35..becb3dbaa548 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock.c
@@ -153,12 +153,9 @@ static int __build_mock(struct kunit *test, struct drm_device *drm,
 	return 0;
 }
 
-static void kunit_action_drm_dev_unregister(void *ptr)
-{
-	struct drm_device *drm = ptr;
-
-	drm_dev_unregister(drm);
-}
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_drm_dev_unregister,
+			    drm_dev_unregister,
+			    struct drm_device *);
 
 static struct vc4_dev *__mock_device(struct kunit *test, bool is_vc5)
 {
-- 
2.43.0.rc1.413.gea7ed67945-goog

