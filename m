Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EEC75A1CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGSWYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGSWY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:24:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6FC26BB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:24:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56ff81be091so2065867b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805445; x=1692397445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2SH8AkTFG73ufenUbtwahXNeJY1AgRA8n8Wy9Xr37zw=;
        b=cyNzOp15K8h6pZ+knMLm87QR3n3kAiJvbpZlQJC6RNtA8e57Us52J2RSql7c5obBHG
         7Vw74UB7FcA4ZIQ6xanNmf0Rv3jdomJ/QycxcPDkCjXJxLd41WY85/19/avSnGOeGNqv
         3bkYYDqbdsbczctPRXLm34M0fhB9EbTNLn7eHEYFHM1l1JGiK8tz3cRE6+g7kjTFOuFv
         UihO70tkubpccqZTjFYU6O9zdHRAM7lHu6fU/fEYlXfkzPmTwmeQ0X9jQHs5fk8stAie
         3/pjUKq1xSXDLa3sTk8Oak78Zk6eKkeHN4k/9A2VfSOTD0ZYDUimY1JB+1cGMZ2wRG6H
         nzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805445; x=1692397445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SH8AkTFG73ufenUbtwahXNeJY1AgRA8n8Wy9Xr37zw=;
        b=lk9vLggcbY+V8+SV2IQ6wXR+8umauFLkBazm7jV42mYBojuhblb5o/kKg8dyEgvIjw
         lRksllA9jiW+52MQSPkqYJD8VplNesTXBd5d95VXHFrYABiXROT7FjyPZFZSvSV7iMPg
         Jwyt3Vf7Pjx/zhkAsWP8v5IGO+rNzr8cNCd8Hq39WuUP1iOhQEfLdaEcdx5zO3nY6Rto
         X1RHFgW9dPuX8E2cSG0gbdY6SzUq7SavwNVdf4PNODcfqYTA85MRxXYEQU/tMmC83aWg
         Ukabl/EBMlOcz4iWCOv2k/APX9xu0As3jvIAbVP5ujgPVuJihmBDLuMyEKBL20m8/qqj
         OqOw==
X-Gm-Message-State: ABy/qLZti8JGJgOpbJbZsCk76UJFXRQ+d5jQ7ugnS6A6w/KA/MpLkJbB
        wapqMT0buNpz2/8krKZzMwu0cBahOw==
X-Google-Smtp-Source: APBJJlGSpivLuIVEbNWEM5SIqiZ8+Uauh2zz2TGgLPCMi1zsdRxCY/kefSVldz4Z6a8C9rVoIwsEQGJfvQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:ca48:0:b0:57a:e0b:f63 with SMTP id
 y8-20020a81ca48000000b0057a0e0b0f63mr3982ywk.7.1689805445487; Wed, 19 Jul
 2023 15:24:05 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:23:34 +0000
In-Reply-To: <20230719222338.259684-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230719222338.259684-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719222338.259684-8-rmoar@google.com>
Subject: [PATCH v1 7/9] kunit: time: Mark test as slow using test attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
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

Mark the time KUnit test, time64_to_tm_test_date_range, as slow using test
attributes.

This test ran relatively much slower than most other KUnit tests.

By marking this test as slow, the test can now be filtered using the KUnit
test attribute filtering feature. Example: --filter "speed>slow". This will
run only the tests that have speeds faster than slow. The slow attribute
will also be outputted in KTAP.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since RFC v2:
- No changes.
Changes since RFC v1:
- No changes.

 kernel/time/time_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 831e8e779ace..ca058c8af6ba 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -86,7 +86,7 @@ static void time64_to_tm_test_date_range(struct kunit *test)
 }
 
 static struct kunit_case time_test_cases[] = {
-	KUNIT_CASE(time64_to_tm_test_date_range),
+	KUNIT_CASE_SLOW(time64_to_tm_test_date_range),
 	{}
 };
 
-- 
2.41.0.255.g8b1d071c50-goog

