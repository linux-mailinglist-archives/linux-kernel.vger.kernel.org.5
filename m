Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA07E7AB883
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjIVRyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjIVRxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:53:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA4810C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690d2441b95so2103697b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405142; x=1696009942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUfG5CM9LeO6dcNwDkeYkSibXZr9XVodXzzx/nCur9U=;
        b=BQOY4m9VSZQt7HPokJQmy5539fTULs4DI5vdLHyW57g1+f3E1uUeTJwAdawx8teV28
         bVbvyPkwfr6xurEDY2Qzu6GmBs0Ey6qyNSECpAJNLxcyQ8H8qN+8VdYgcLw3zT7TbzLG
         NLzv+1ggOQk7R3avNi+IIzRjiGgSVh4U2atE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405142; x=1696009942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUfG5CM9LeO6dcNwDkeYkSibXZr9XVodXzzx/nCur9U=;
        b=nEyUpnnki49C2js4d7cwsrorfhgt2LI7S1ib+fUB9svn+qzcmlr5WWbDwRCqI88QmQ
         k8dguW7rVz0Y9+sNMG+97poCuyYKeuyZSYehlwd/yp3LF7iaaVmAL4wPL30v9h2M07q1
         k/63Z6VVovVEMqJyV2MR/G7vFIIxl4xhYDTP6onDRcU5u6E94FyjiHlk3PaM1hhnWxGQ
         u2nQHOwXr6+uoGFVbKW5HP9L4GyAy+raDg11dk2Gx7ks/Nf6CLa0e+jd+RN5gn+QMWMf
         rBfHaqLT8FanDbiHXelayCfBuDqOz4lIvwJkTLcogPOwjHFOcgoHksieT/F78MPsj82G
         5sjg==
X-Gm-Message-State: AOJu0Yy7uB/qR3eTlPm1hxyRGjiEks19JJbdpSQHBGZkyzBVfQc0HBsk
        F/W2L11ZULz+WmSXfzdbnOATJQ==
X-Google-Smtp-Source: AGHT+IGKglSu4V94OTI3A3BfgAmZCaaFTkJEerKkiQY4tQfjHtM7Ae884UZbgp+Yzv55o7c6aErRvg==
X-Received: by 2002:a05:6a00:10c6:b0:68f:cb69:8e66 with SMTP id d6-20020a056a0010c600b0068fcb698e66mr459676pfu.15.1695405142449;
        Fri, 22 Sep 2023 10:52:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c26-20020aa78c1a000000b0067b643b814csm3492756pfd.6.2023.09.22.10.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] gcov: Annotate struct gcov_iterator with __counted_by
Date:   Fri, 22 Sep 2023 10:52:20 -0700
Message-Id: <20230922175220.work.327-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=keescook@chromium.org;
 h=from:subject:message-id; bh=PERykbPQFb07CtyESuEWnJKmw1X+EsX8MBvMPSKrxC0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRUUa78Ww0nV8tm9uBXdH6YFNvrlgq4vOUD0
 VtGGM7H0YKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UVAAKCRCJcvTf3G3A
 JjQHD/0UYfkg7/bkKyRZFzhxwcMCFxcRlEeqzLk645U0ZI9EVsp4jndBVkZ+iw5IwU7aRrq18L4
 8aTvCwK2LSM+TXSQ8bTsckVKhNNC2LEGdGcAyzEL/6uZySyr82kR0W32JBSwA20fgzjCLrWuAFt
 TQ3l7yy/5NyAQ3IZEpHGDbmkIJ/iP2jTes6eXQdljIfv1L5kiIl8A0N6X3abxTan8idIaE5qxSX
 g8VVf8vZabxyp39MNdCrALA6b1RO1NBanmP7mDPpMGrLaf71Y8+MQ32jntnDIyDMvCnHUjx2B7N
 M1IV8C7rGNxLJjH3Y/ZUFmea19f7lvgs3sIDi3WzY4YTfTN0LvJRVkzLfiCTJGdOgYfmYRqvYkX
 9pi6sgaIlCb3ZejdLb3fibwDBT/+5/Zj04mn3bFSH+YQk84KYrPmaQ9CqUtPT2Q3OsBpdABJkWi
 g6q5MiqogBKcHYYiBm4dBjJ9f8SDDGHRSen2a5mm9TPRZrj+S2rE4JDMefGMdPfr4JD6uGVoEfq
 z0+KSraR9tUXAi54bzPB5OBQfpZnjSHNkNMcqwTjIgJFuQ/7UqQwn8jEQbaLLQSePHLGeK5qiVO
 6vLvyE4Pfwo8UClJmc6qkpfjX5dwtbbWcYFCJLcNshPGyxh2NikJOgh3xcwQJTNrZNWV0dX6Q+E
 Now+tQ6E ++kkCSA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct gcov_iterator.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/gcov/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 5c3086cad8f9..01520689b57c 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -99,7 +99,7 @@ struct gcov_iterator {
 	struct gcov_info *info;
 	size_t size;
 	loff_t pos;
-	char buffer[];
+	char buffer[] __counted_by(size);
 };
 
 /**
-- 
2.34.1

