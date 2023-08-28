Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971AF78B40E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjH1PJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjH1PJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:09:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB47129
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31c3726cc45so2867214f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693235348; x=1693840148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSsehURxisS0cPQOlmw5cEhdkgRF5G0B9O4abug5R1Y=;
        b=KcBVK2L/+QiqeWFTYXdOHgeUKp7DE3X4tkqvOHvJL3c9l2s8PVNUDW7Vbov+Z+q4gQ
         mcZKACunCQ1/A/aDTljARoKg3f6xbibrlG6bzvrYRt2IfOW/RY1hCJt/5Bjtk9lSUGNn
         58lL0yysgJLrF2YisIvCE3BrZVByNt8ljS8SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235348; x=1693840148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSsehURxisS0cPQOlmw5cEhdkgRF5G0B9O4abug5R1Y=;
        b=SJAlCCpFKIOVBfqDj9LbJkYLWbkXsX00loWYkE5qZNKpDXDyq+kvxaMdB+Ss3MqqoU
         vZgbX+n3eUd7A8p2ilabwUYrUVc72mTopi3PhbJA4hmCOUbM+YTQCrf024eYLYA/gcRP
         PDyDEteZ+y5MzVCgGpIIDjOAVEuG9HE9jbRVDmI8cSUUutPE+hhRiThFdttOOWu07FXa
         UiAdNsb2wTIPWZshYQ+3iHAIyFf8jnj1uCoj7o1vgpGvWxjq/t2UIr3LcuFY5dRFG3pF
         0gwaUG+zazwnQ/61zfeyF2wb3NBPAPU1d/AlA/eeZbttEGnPiWKQfvUCswIdBh3Y02jK
         BFYw==
X-Gm-Message-State: AOJu0YyXDYrv+1P0ngqn9IveTZliqwXY4q5FWZVm9L5HdN8YMTIbRiSE
        0MDl4kMzikaTxKFhAdVNb0lUqpK/OTZNdQxHBcw=
X-Google-Smtp-Source: AGHT+IEAybtNw1oHry9kGIGPO60mG51GaKuwtgSiIvjeqoNDFS3SqrUaPm7yaU7LHb+xUqgnOcm9kA==
X-Received: by 2002:a5d:574f:0:b0:317:5ece:e16a with SMTP id q15-20020a5d574f000000b003175ecee16amr18928693wrw.50.1693235348569;
        Mon, 28 Aug 2023 08:09:08 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:40c6:6cff:63b:c70a])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d43c3000000b003140fff4f75sm10730522wrr.17.2023.08.28.08.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 08:09:07 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        ayush.jain3@amd.com, Florent Revest <revest@chromium.org>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH v4 2/6] kselftest: vm: Fix mdwe's mmap_FIXED test case
Date:   Mon, 28 Aug 2023 17:08:54 +0200
Message-ID: <20230828150858.393570-3-revest@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230828150858.393570-1-revest@chromium.org>
References: <20230828150858.393570-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I checked with the original author, the mmap_FIXED test case wasn't
properly tested and fails. Currently, it maps two consecutive (non
overlapping) pages and expects the second mapping to be denied by MDWE
but these two pages have nothing to do with each other so MDWE is
actually out of the picture here.

What the test actually intended to do was to remap a virtual address
using MAP_FIXED. However, this operation unmaps the existing mapping and
creates a new one so the va is backed by a new page and MDWE is again
out of the picture, all remappings should succeed.

This patch keeps the test case to make it clear that this situation is
expected to work: MDWE shouldn't block a MAP_FIXED replacement.

Signed-off-by: Florent Revest <revest@chromium.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Ayush Jain <ayush.jain3@amd.com>
Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-execute")
---
 tools/testing/selftests/mm/mdwe_test.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index d0954c657feb..91aa9c3099e7 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -168,13 +168,10 @@ TEST_F(mdwe, mmap_FIXED)
 	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
 	ASSERT_NE(self->p, MAP_FAILED);
 
-	p = mmap(self->p + self->size, self->size, PROT_READ | PROT_EXEC,
+	/* MAP_FIXED unmaps the existing page before mapping which is allowed */
+	p = mmap(self->p, self->size, PROT_READ | PROT_EXEC,
 		 self->flags | MAP_FIXED, 0, 0);
-	if (variant->enabled) {
-		EXPECT_EQ(p, MAP_FAILED);
-	} else {
-		EXPECT_EQ(p, self->p);
-	}
+	EXPECT_EQ(p, self->p);
 }
 
 TEST_F(mdwe, arm64_BTI)
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

