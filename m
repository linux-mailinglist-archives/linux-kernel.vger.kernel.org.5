Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2293380698A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377148AbjLFIW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376876AbjLFIW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:22:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2E18D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:23:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db547d41413so597251276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 00:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701850981; x=1702455781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WCRvn/sz9XVm96oNWnMxAn3yHnXhHkzRkqQQYNeebWk=;
        b=jiGsp8diuKYRABNDXqse482cb3kDzJNtGOGQmKQLRwZX0M9iKg33lE5nOkx+81RRxh
         k4L+STcB6cReRyQhyWS1gVj41qUOwnnO0eXGf+hn0DvEKsJyX6bu/2U3xvVCvxg2LtUh
         1sxXmYpBy2Cnr0LureaNj2RMAtSz5uUWdjoqHUjUZbDYTGBGQmHSOlt3FTH/NAoY01jf
         4GzIvMqPomPERtafBTbSGh4jyTPxVRnllPQjKIQk1ZgEfOLxKsODzTR3UdJUI0Q0q/CP
         87TSOZjMaJUxkEDOw/YesztP3lIkZD11stD+b7a6LbvOPqfQtWTNk9b1z900TXeEXSjl
         BTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850981; x=1702455781;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCRvn/sz9XVm96oNWnMxAn3yHnXhHkzRkqQQYNeebWk=;
        b=uaa5AeYcHyp8KAZEJxNaH7ZOiyw+WcfnMvwi2ruS+gMHYJQqW+7fygsY2uhONpOymz
         HrC58HZBMIYn7KKp7/SukbnJ31FtkT/XqfLg7O9AgVtauV0RJyXPbP8m8jbAPS+z4HCn
         t12HMlG5u5b3Z62FK2qzSPpSTmgGikjez1M7YnxQTEvSleS/GazqjmcLMMx53otEdACA
         i1y+k1oz5iB2xTfD5BevU+Y0h1kxgMJZ8AzfQ3OpxG3bBty1N+lzl0HCCbcx8Am9+qml
         c+WFp+RYs+sa/nOZmhWAJ/Kk1HOj2vYZs+fhhuu3ikCHJiqne8mz3/q+eRIp/+qabhG2
         eh9w==
X-Gm-Message-State: AOJu0YxqIoCoQ9jkeT4Z5SE0Lx9yod8RX/5k6ZbES2s+/q3r3Co79Cb8
        CD4/rnjLbSda0NwmrKGSC2ecKYZFH4wNKA==
X-Google-Smtp-Source: AGHT+IHgN9snu5a/ppS7OlD3/ljvTemeLfF2mtBrbyVREwmLrAUt0HI19V0c0cnISxARtPjazI9Qq2Ace2v1QQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:51:b0:da3:b467:af07 with SMTP id
 m17-20020a056902005100b00da3b467af07mr82068ybh.2.1701850981627; Wed, 06 Dec
 2023 00:23:01 -0800 (PST)
Date:   Wed,  6 Dec 2023 16:22:49 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231206082251.586204-1-davidgow@google.com>
Subject: [PATCH] kunit: test: Use an action wrapper instead of a cast
From:   David Gow <davidgow@google.com>
To:     Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

We missed one of the casts of kfree() to kunit_action_t in kunit-test,
which was only enabled when debugfs was in use. This could potentially
break CFI.

Use the existing wrapper function instead.

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/kunit-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 3e9c5192d095..ee6927c60979 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -559,7 +559,7 @@ static void kunit_log_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, test->log->append_newlines);
 
 	full_log = string_stream_get_string(test->log);
-	kunit_add_action(test, (kunit_action_t *)kfree, full_log);
+	kunit_add_action(test, kfree_wrapper, full_log);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
 				     strstr(full_log, "put this in log."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-- 
2.43.0.rc2.451.g8631bc7472-goog

