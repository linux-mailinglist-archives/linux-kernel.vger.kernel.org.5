Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B106475FC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjGXQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjGXQbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:31:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A1A1FC6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:30:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583f048985bso17046087b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690216256; x=1690821056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G5j34NW7MgcGMBHuRGUcTaJqW07I0/xnHGpldPUn/Ww=;
        b=S2ZqeCnl65tgF1NOidFcgWC4NjLl7ygrpsBLxwpC5gNYvhMElUFzesFQ54EhtucwWH
         E+VfzotvqWxFVa2fUNNYxczoZf6mWuJdhpU6NpEhwzepMXnn2RbWhmO7tryCCamNcljZ
         TFZ/A6vxzy7yvMSzSy7wwu0MY6Y5uy4RSWrM1xAjWw8Jp+cx/+uvrRaoB+0p54LfWFdQ
         u13dVIxGoD1iC313Q0XEmqUM7cGrygEVtipcbDv4GLM6wtMPY3bXGEaSjaVVmY9jkkh6
         QOeW3NNvE2a1cGa323Ldx6hSyAi402y2x7xzE/CU4MnDYdhC3T9FUwB/or76pIuSXiFF
         Q0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216256; x=1690821056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5j34NW7MgcGMBHuRGUcTaJqW07I0/xnHGpldPUn/Ww=;
        b=UaTWyWEZWtwlhGanV33K29dYsYHyt0nXA+/hpUEXgP0qM9irWBjFixywiDtcw5TGe3
         b7SX5t6LVAYrZmAcMH00qHutKTtEyf2mktUQkIUYKxATgCIn95HAf29pKbwrGXZmFPZh
         99b/e6GYbsRwE4Tx8KStOrX2UxfJ0JBRBCH5q+CTKDKv/LExnyou7gfYk2i22wuresjU
         4ylsQHXQniiqcGH4fywGbWZ+16SjF7VtQpGsGMRNUiaAPPbZz5leIMn3d2FNsEkN/K7X
         OJ9P/QS/u501qytn4A/pDrK7DJEDZbMtY0d4l8gS+ct8ZooYFnTlDwloMoxxqVY6xTDf
         EWCQ==
X-Gm-Message-State: ABy/qLYSvtPAnN46FZX/yb2OvxiNpMZ/uXADtDvoiNDvSZBddWhLMXta
        HdhSSwOBo66ogZmpU1z2k3y6D8jang==
X-Google-Smtp-Source: APBJJlHP0ywTKtk7Dfde1Vwf+7bCD8q0bSRqx5AjPWkZ8anuNNKbDWGNiL//GJRGLAmhmzHC8ogzUkDpqQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:ae54:0:b0:57a:141f:b4f7 with SMTP id
 g20-20020a81ae54000000b0057a141fb4f7mr64651ywk.6.1690216256539; Mon, 24 Jul
 2023 09:30:56 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:28:27 +0000
In-Reply-To: <20230724162834.1354164-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230724162834.1354164-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724162834.1354164-8-rmoar@google.com>
Subject: [PATCH v2 7/9] kunit: time: Mark test as slow using test attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v1:
- No changes.
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
2.41.0.487.g6d72f3e995-goog

