Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5892C7F0447
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 05:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjKSECf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 23:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSECd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 23:02:33 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1781D5;
        Sat, 18 Nov 2023 20:02:29 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5c5d59adeedso25572447b3.3;
        Sat, 18 Nov 2023 20:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700366548; x=1700971348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZtE1sXq/6EOMIXLdRyz9i4gTsfOOa5vBqb4CxOsnD8=;
        b=TLNQabSx5wF/16TT4xzfjEKSRRfTD9bi1S7s3cexPa29V8/KN9bbucOA3CA8bF7L44
         Hj2maWpS01PqAzBJcuBts8+s8JqYm45Rue/x6W1uE5cBLc4NFLtLiyQk/rxun/t6NElT
         0eA/1s1t3xRRLiR0iPAkY6ruuCK26KiZD+xuBC0ADJ1UHgFqnPkdvQA7DT4eT3QIFoHZ
         XCBpd4EQ1XWkD0ToAsbErbzHIJEu5Zl5OuupCbmN3N63f6PvWWLznkhj0HWUXmA2oLRd
         Rzdxk3chKg2j9R1fmOhpemiItqCM3tHmdLFVDlfhaYl2YYNdzSoUWl2dA4tgXDqJvtPW
         1muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700366548; x=1700971348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZtE1sXq/6EOMIXLdRyz9i4gTsfOOa5vBqb4CxOsnD8=;
        b=k7SqVjHW7Jlu7pMEZ9PbHhsE+H5fZn96s4kIyQyXAuSab6RcuyXgAqfDG0QZnWfbeW
         v8rchf+f5M384RDjIcjaAtwHi2y+STO2WDzQ98WoR/lvWNgkzPIwfLJr7ABcdBXJwz8o
         YF2kTSCNOn6rhqLMI0qgYFxyWdynuvtAjcDNA8n7QpP6cxhQRzAB8RHNg4rC7KJjUc9u
         pBjeFHd/pms74ndKy0BaheNtLmVYnqkB7wLX8XTlQTj1lOtiT/AJutAm4Hcv4jDKqnhz
         KDnxQqqOY/pRBckn7O3HK18c1lOL2SLD0CyH0gt5hObCAZFhevsQEKZf0hh89+9bCZhm
         T8Pg==
X-Gm-Message-State: AOJu0YyRx4M67B112/T9bJisSExLe/WBqIFWKGk9Bf40HROGrwboL+Ca
        BihFtMnWQoj+ykReqFKMdQefzjTvCRwwF2BV
X-Google-Smtp-Source: AGHT+IE/Ke/Uk0fxKu5KS7ehGDiXvlyE94ch6A2hvBPPzXjMdCuybzm14amvuoqAIYnK6sZ+c6K33w==
X-Received: by 2002:a25:ae0d:0:b0:da0:d0be:ef06 with SMTP id a13-20020a25ae0d000000b00da0d0beef06mr3332873ybj.51.1700366547794;
        Sat, 18 Nov 2023 20:02:27 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id el8-20020ad459c8000000b0065d105f6931sm1877264qvb.59.2023.11.18.20.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 20:02:27 -0800 (PST)
From:   angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To:     linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, shuah@kernal.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        angquan yu <angquan21@gmail.com>
Subject: [PATCH 1/2] [PATCH,breakpoints] selftests/breakpoints: Fix format specifier in ksft_print_msg in step_after_suspend_test.c
Date:   Sat, 18 Nov 2023 22:02:09 -0600
Message-Id: <20231119040209.40900-1-angquan21@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: angquan yu <angquan21@gmail.com>

In the function 'tools/testing/selftests/breakpoints/run_test' within step_after_suspend_test.c, the ksft_print_msg function call incorrectly used '$s' as a format specifier. This commit corrects this typo to use the proper '%s' format specifier, ensuring the error message from waitpid() is correctly displayed.

The issue manifested as a compilation warning (too many arguments for format [-Wformat-extra-args]), potentially obscuring actual runtime errors and complicating debugging processes.

This fix enhances the clarity of error messages during test failures and ensures compliance with standard C format string conventions.

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index 2cf6f10ab..b8703c499 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -89,7 +89,7 @@ int run_test(int cpu)
 
 	wpid = waitpid(pid, &status, __WALL);
 	if (wpid != pid) {
-		ksft_print_msg("waitpid() failed: $s\n", strerror(errno));
+		ksft_print_msg("waitpid() failed: %s\n", strerror(errno));
 		return KSFT_FAIL;
 	}
 	if (WIFEXITED(status)) {
-- 
2.39.2

