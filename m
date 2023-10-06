Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94EF7BB126
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 07:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjJFFSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 01:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFFSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:18:21 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3208ECA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 22:18:20 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3ae5ce4a4ceso1188622b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 22:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696569499; x=1697174299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUmzwFWm2fPwy4CB12OZE+k96a2phqo45N6Zs8xEb94=;
        b=aazrwwBsCaVyDnt4g/1TjY2zt3RrEiu45pqCtbzhpZzjaoPvrL6KDxILE2efffc0ZM
         6TuY8QchUSUG6JEypfMG62ASzbQLQQzAzgeJud7h3p/xQ2XCxx9XqfYjcdl/DO88wD9M
         KxAwB5wY8DMQJO72lUzV5sStH+7Pn32BiPqFqL5STu3H9RhqZWWYVbygTTcZO/fKfpLD
         pd+4MSUEIoAXzGR2sOk4cExDhO2WEI6KrK2RRrjley6FEWiY+wnmv9yPfPTf9ZWzxu19
         6nWijgppG9nVBpWzCB0BN4zy/lGr0NIBA5DliqXAnsu+/1x/u1Kkr26cusSQkzX6oxZM
         fGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696569499; x=1697174299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUmzwFWm2fPwy4CB12OZE+k96a2phqo45N6Zs8xEb94=;
        b=D5kxwc6tp8mu2AK+gu8Ysv0T4qQ+iOJr4495twveYwp1yEQs1P5pRWiwvVSRb6XQuy
         XUnM9WnRgtyovXRmolmprVL0aQKI8Xlc+WWcrvT2UOxdQi6xDS0xc4RqrUlg1m2RlrWA
         SAl/HVHrBW2P2TdfrjpnvAzAuX1DMnhvtUL02mEcJMrcvOLY/tPkmBQ8NhnFxVMeCzdc
         oRx1Wbc8DX+BJaDW2Vrb/Psq6lVN0GXcgLxawXN2+XlAyJdbw52vyU7HkoahSb3mKqNA
         mId2v/y5vXsmxkHKMzLhs9stnAMo081MbDzr9IW8yZuVD9NlT3wtkBHNxfVFCKybFTWQ
         7MRw==
X-Gm-Message-State: AOJu0YycgJplgqWp3wSVElT0SG+JmT1c27LOw4gaAQ3phGsuq8YnzAyJ
        cbFweSZbfFl0BQCBldRhAxbD+w==
X-Google-Smtp-Source: AGHT+IGRKyv+Xkec+BOkW8HPio9rp9UbeWoHrfePkC+ZYEbRjOP+qBayFrCJkx5nft+RibIDm5hi0w==
X-Received: by 2002:a05:6808:144d:b0:3ad:c5f3:36c6 with SMTP id x13-20020a056808144d00b003adc5f336c6mr8475294oiv.38.1696569499432;
        Thu, 05 Oct 2023 22:18:19 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.23])
        by smtp.gmail.com with ESMTPSA id w25-20020a639359000000b00553dcfc2179sm2393874pgm.52.2023.10.05.22.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 22:18:19 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     torvalds@linux-foundation.org, jarkko@kernel.org,
        peterz@infradead.org, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, David.Kaplan@amd.com, bp@alien8.de,
        mingo@kernel.org, x86@kernel.org, regressions@leemhuis.info,
        Sumit Garg <sumit.garg@linaro.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
Date:   Fri,  6 Oct 2023 10:48:01 +0530
Message-Id: <20231006051801.423973-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static calls invocations aren't well supported from module __init and
__exit functions. Especially the static call from cleanup_trusted() led
to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.

However, the usage of static call invocations for trusted_key_init()
and trusted_key_exit() don't add any value from either a performance or
security perspective. Hence switch to use indirect function calls instead.

Note here that although it will fix the current crash report, ultimately
the static call infrastructure should be fixed to either support its
future usage from module __init and __exit functions or not.

Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lore.kernel.org/lkml/ZRhKq6e5nF%2F4ZIV1@fedora/#t
Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v2:
- Polish commit message as per comments from Mimi

 security/keys/trusted-keys/trusted_core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index c6fc50d67214..85fb5c22529a 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -44,13 +44,12 @@ static const struct trusted_key_source trusted_key_sources[] = {
 #endif
 };
 
-DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
 DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->seal);
 DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
 			*trusted_key_sources[0].ops->unseal);
 DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
 			*trusted_key_sources[0].ops->get_random);
-DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
+static void (*trusted_key_exit)(void);
 static unsigned char migratable;
 
 enum {
@@ -359,19 +358,16 @@ static int __init init_trusted(void)
 		if (!get_random)
 			get_random = kernel_get_random;
 
-		static_call_update(trusted_key_init,
-				   trusted_key_sources[i].ops->init);
 		static_call_update(trusted_key_seal,
 				   trusted_key_sources[i].ops->seal);
 		static_call_update(trusted_key_unseal,
 				   trusted_key_sources[i].ops->unseal);
 		static_call_update(trusted_key_get_random,
 				   get_random);
-		static_call_update(trusted_key_exit,
-				   trusted_key_sources[i].ops->exit);
+		trusted_key_exit = trusted_key_sources[i].ops->exit;
 		migratable = trusted_key_sources[i].ops->migratable;
 
-		ret = static_call(trusted_key_init)();
+		ret = trusted_key_sources[i].ops->init();
 		if (!ret)
 			break;
 	}
@@ -388,7 +384,8 @@ static int __init init_trusted(void)
 
 static void __exit cleanup_trusted(void)
 {
-	static_call_cond(trusted_key_exit)();
+	if (trusted_key_exit)
+		(*trusted_key_exit)();
 }
 
 late_initcall(init_trusted);
-- 
2.34.1

