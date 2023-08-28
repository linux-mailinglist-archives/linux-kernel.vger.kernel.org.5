Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C7178B40D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjH1PJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjH1PJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:09:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1727E3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso222945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693235346; x=1693840146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54UPPhNi0y2AdnbsRZs/CNcj4MVRDSwIBY8KLrESmWo=;
        b=LwMgQz/Pz1vI9C+GIi5muwLbzIkuznGpP9E03o8fY/OOVPIb6sBIjWAvlpDZJCYO3c
         dsDrAs07+54wwoOvW2N+ZRL7SQ5CIMhTMEDoBsYMYTBI3QM95BPxEPPK680uL3vkt8uo
         vaDJN0HfI+13p6NMtHDCzWAfIsfHMOO6Ww0uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235346; x=1693840146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54UPPhNi0y2AdnbsRZs/CNcj4MVRDSwIBY8KLrESmWo=;
        b=MKsZa/5JJh5q19ZvWsLZWVyPGwPG6q3Jz25VwZCut9avJ94qgF693cfO/CrNYk2EFI
         ZLhCmqWL/4gY9cBkgnJbU3hm5lso8CcyLtpFJVIOg/JhMeR61fEj4BzuYJ5jlJYIMh7W
         h6T6iaZ/x04LizVmYWmqZSzCGhZ+9UPnFh+A7q4FFyHGKHSTXhVxne+zTovs6uRJ36rQ
         c3mIK9J/Br1l/8IJ1IUxXXGdUFvvTsga2zA3ap7L9bYhpwo73XDRew85z3hXjNqrTUoU
         9TNlQCiWHJiHuFyoHiqhMc1/GyXl/hEPy6RGb9z/vAK7QOMgEwAtA74xXGrex7EyQWhT
         yAsA==
X-Gm-Message-State: AOJu0YyqKeJvK8GEk92tCrq8x+6RjRn4pqhNqwRSH1/csvmap21FbLDF
        mOsuSk+gIYGe4+/zlcLL5lNj8Py7yDPQVUvy4Y8=
X-Google-Smtp-Source: AGHT+IEsED+uVDf3QF+1TMYiMI9fwCvF0Riiqa1w3RmNOSnx23YM4S/JlhQ+bju/J7g38NJUjnBylw==
X-Received: by 2002:a5d:4561:0:b0:313:f75b:c552 with SMTP id a1-20020a5d4561000000b00313f75bc552mr21799616wrc.15.1693235346658;
        Mon, 28 Aug 2023 08:09:06 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:40c6:6cff:63b:c70a])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d43c3000000b003140fff4f75sm10730522wrr.17.2023.08.28.08.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 08:09:06 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        ayush.jain3@amd.com, Florent Revest <revest@chromium.org>
Subject: [PATCH v4 1/6] kselftest: vm: Fix tabs/spaces inconsistency in the mdwe test
Date:   Mon, 28 Aug 2023 17:08:53 +0200
Message-ID: <20230828150858.393570-2-revest@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230828150858.393570-1-revest@chromium.org>
References: <20230828150858.393570-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/mm/mdwe_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index bc91bef5d254..d0954c657feb 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -49,19 +49,19 @@ FIXTURE_VARIANT(mdwe)
 
 FIXTURE_VARIANT_ADD(mdwe, stock)
 {
-        .enabled = false,
+	.enabled = false,
 	.forked = false,
 };
 
 FIXTURE_VARIANT_ADD(mdwe, enabled)
 {
-        .enabled = true,
+	.enabled = true,
 	.forked = false,
 };
 
 FIXTURE_VARIANT_ADD(mdwe, forked)
 {
-        .enabled = true,
+	.enabled = true,
 	.forked = true,
 };
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

