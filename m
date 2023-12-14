Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1C9812E25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443920AbjLNLHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443946AbjLNLGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:06:50 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB3312C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:06:55 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d0c4ba7081so95229457b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702552014; x=1703156814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2GSxzhcZ07xCv7d1L9tozvjfnh/gD6wLbTwZXMSaKU=;
        b=qLlgVyYJDfMBdwGquZ1gI1iTSviYf7C6ZOYCw55bDuN8FhB+JVy/qYH98RHoncXgKN
         J22i9SLmfoD2LCCtagPlNKq4BKEuSpyjhWxOtXaOj5sDwYgFQJr+tW/XmmNhu3/x78KB
         JQQxhX5/lu4FIxEoKUwTNeauHM5POj97zctAqfPWhoIvMIL9X9U0l2/AxmUSqG+gB2pl
         hecKTuE68x8JhWGLfRvfKJFPGHiMQfzkVpgehGvhoufpTk2S7n3Q+ueBnJoEMaY7f1tQ
         5eZucf4uoJPRZI5Tth2b4PDXGpCuxL4RR9YCv6qSEl0Hz8IMawqeVF1gfdEj2aoh9msk
         PHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552014; x=1703156814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2GSxzhcZ07xCv7d1L9tozvjfnh/gD6wLbTwZXMSaKU=;
        b=wqV0RYrpqquVEjCg5IzKrI+JpTizdvkTxc59m1Ektt24HMnYnU37Df4ONh4UoNWH8C
         isbyHM+QNJtPubspMWuFJM9ymRJ+KQOv6sUd6QA2e4gWqBxWUIZuW6ZZV6gpQQMHGDAW
         pJwYtD5AFWoMLfQlqBYTugU5ck68vjcwiIuDt9jeJ1zI8YkB9Or/Hh1ELX2dJc4IW4Af
         lTvp/lDm8ee3Xguq0lzjIuD1zciChSDJajx236jkfY2uoQvoAq8vDr4KZDMTnAR10oJs
         nwyGADXT6W7W/KgRAL8j1RrzH4B6rtfVCX6f1JWGseiGfxEDe6yWuNXETJjmrg8laI7Z
         JyYQ==
X-Gm-Message-State: AOJu0YwnCZeGLhNaY8NiJPibIaYEboFkpZJZcWkAr+36+ye24VD1rKhq
        zfk4DtW5ts/Z6TAaAL/hfXiK5jaUdas=
X-Google-Smtp-Source: AGHT+IGGkSzNTGa/Zh9JtgjWjYaXHf5NHT9/GP0mNOA+eSkSEyP37yRz72mdweuJoDQ9Wlcg+oAYfOGLUZc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:8447:3e89:1f77:ff8a])
 (user=glider job=sendgmr) by 2002:a05:6902:1345:b0:db7:e75c:24c1 with SMTP id
 g5-20020a056902134500b00db7e75c24c1mr6642ybu.9.1702552014550; Thu, 14 Dec
 2023 03:06:54 -0800 (PST)
Date:   Thu, 14 Dec 2023 12:06:35 +0100
In-Reply-To: <20231214110639.2294687-1-glider@google.com>
Mime-Version: 1.0
References: <20231214110639.2294687-1-glider@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214110639.2294687-4-glider@google.com>
Subject: [PATCH v10-mte 3/7] lib/test_bitmap: use pr_info() for non-error messages
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
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

pr_err() messages may be treated as errors by some log readers, so let
us only use them for test failures. For non-error messages, replace them
with pr_info().

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
v10-mte:
 - send this patch together with the "Implement MTE tag compression for
   swapped pages"
---
 lib/test_bitmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 46c0154680772..a6e92cf5266af 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -507,7 +507,7 @@ static void __init test_bitmap_parselist(void)
 		}
 
 		if (ptest.flags & PARSE_TIME)
-			pr_err("parselist: %d: input is '%s' OK, Time: %llu\n",
+			pr_info("parselist: %d: input is '%s' OK, Time: %llu\n",
 					i, ptest.in, time);
 
 #undef ptest
@@ -546,7 +546,7 @@ static void __init test_bitmap_printlist(void)
 		goto out;
 	}
 
-	pr_err("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
+	pr_info("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
 out:
 	kfree(buf);
 	kfree(bmap);
@@ -624,7 +624,7 @@ static void __init test_bitmap_parse(void)
 		}
 
 		if (test.flags & PARSE_TIME)
-			pr_err("parse: %d: input is '%s' OK, Time: %llu\n",
+			pr_info("parse: %d: input is '%s' OK, Time: %llu\n",
 					i, test.in, time);
 	}
 }
@@ -1380,7 +1380,7 @@ static void __init test_bitmap_read_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("Time spent in %s:\t%llu\n", __func__, time);
 }
 
 static void __init test_bitmap_write_perf(void)
@@ -1402,7 +1402,7 @@ static void __init test_bitmap_write_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("Time spent in %s:\t%llu\n", __func__, time);
 }
 
 #undef TEST_BIT_LEN
-- 
2.43.0.472.g3155946c3a-goog

