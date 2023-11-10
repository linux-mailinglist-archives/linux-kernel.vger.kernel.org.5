Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626C27E8379
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345902AbjKJUIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjKJUIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:08:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7551D1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:08:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da31ec03186so1935894276.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699646927; x=1700251727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAkJ89LUqtxG0K+MSJnco+XQD27u+TKLaVoOcPh4bOc=;
        b=JAujfGHJ8yOYNMAj+/UzMg5ghYS5kqcl7r5wvrjHHCdl2sM8xOiTkUGnVaF+EHQjJb
         TmJhenOTUE/qPxBsjJBqd7QjAUK89cbdB2q1c7corDKfnE2MywVyc4qjt2FMEwkQaUqA
         JLopDWEh9Zx6/9lehNFw0qyeeunwaCl3uO2oj/yVVL6EeBZFs80cjPKM1MxFsuubgqZm
         22YQEEAIjx0YRE7ZRv6AW7TsH4v6Bk9y2NYAkZIXYVKPKPdyCQFiz5UYFVzVbqd8ZJbg
         nAsYZInmjMEDKXuvMtX6lr2Urrl+kIUb81TOODAcX6wlIIdlBiY4HC+oOBC3CurBJGCu
         Ll4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699646927; x=1700251727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAkJ89LUqtxG0K+MSJnco+XQD27u+TKLaVoOcPh4bOc=;
        b=oXCzEf3OrSvNuiR0Hq7WtwjSaqPm0+5jQcevNeSDAAopZrfBk8PQJVLg55ww+wWx+Q
         Wt5ICoBOYoOOu9JM1USrEenhO5/yysNNhnudHFDne7HMC1b+l4E5B7p73Dk/NA/lB6II
         EB2Ln+ocxl4nj+cnazP0bcydgae8irfRftNp+IECFX3oVVl2JGTtBZzdNufplU+Nwpyb
         NMW1pFyyvhtwSEnrLR1z/rUlKSr9WhTVt2JCg0ilo6MgzFY/bjaDsYc/itI/SmZVQYli
         1QFPq8+ZzD21fcy9Dkv67dphR6NPnuL9WwqwYbcLN/6dGK0p0nF6JXrzvKG36e1JXyxs
         pu6A==
X-Gm-Message-State: AOJu0YxaeO4cykclkLEpzMubhJPmusX7u1s43rtnaocC4XfDt4016lYl
        wv7TxUXyifxhP1OxS2IQhqmWl7dBPg3y2Q==
X-Google-Smtp-Source: AGHT+IG2qICxw/Ih6W1d00Yw7wl6gZh00iMH2vxhyvW4HtVTUR9T6SIeeV3AzuFmY7j3gx/bERyrecNPMvP5+g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:18d:b0:d89:42d7:e72d with SMTP
 id t13-20020a056902018d00b00d8942d7e72dmr141489ybh.3.1699646927074; Fri, 10
 Nov 2023 12:08:47 -0800 (PST)
Date:   Sat, 11 Nov 2023 04:08:28 +0800
In-Reply-To: <20231110200830.1832556-1-davidgow@google.com>
Mime-Version: 1.0
References: <20231110200830.1832556-1-davidgow@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110200830.1832556-3-davidgow@google.com>
Subject: [PATCH 3/3] drm/vc4: tests: Use KUNIT_DEFINE_ACTION_WRAPPER
From:   David Gow <davidgow@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>, dlatypov@google.com,
        Maxime Ripard <mripard@kernel.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        "=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mairacanal@riseup.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
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

vc4_mock already defines such a wrapper for drm_dev_unregister(), but it
involves less boilerplate to use the new macro, so replace the manual
implementation.

Signed-off-by: David Gow <davidgow@google.com>
---

This patch should be a no-op, just moving to use a standard macro to
implement these wrappers rather than hand-coding them.

Let me know if you'd prefer to take these in separately via the drm
trees, or if you're okay with having this whole series go via
kselftest/kunit.

Cheers,
-- David

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
2.42.0.869.gea05f2083d-goog

