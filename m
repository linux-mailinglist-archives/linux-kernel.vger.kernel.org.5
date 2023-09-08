Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4EC798181
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbjIHFWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjIHFWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:22:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC501997;
        Thu,  7 Sep 2023 22:22:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68e29792976so1468873b3a.2;
        Thu, 07 Sep 2023 22:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694150539; x=1694755339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YYqMjXvyP9eSuVfonZy2BlNb/nZfEBjIJ7oDG/l+S0M=;
        b=deamZDClQtv6qKiBwBWh08o7pesMuY+qtaSkf7ExbCOtQFgbQbbCbsSH9fbNakmKJn
         iWdSpsjUjcCRYqB1eZSxcsqV8eLSgy2eeOJXcjr2PpqMd+ua7zpIigsvY8KJOvwHjD0Y
         D8dL8tCCQnAlK7sIQFhX8kRm4YqwwW0zzyBhtuDpqoagsNjr4Cyzn3kVTVJpob5zPPkE
         QQf7EBH6TsUldu3S3e+j9aYqRIwwHxL4ReDHaJZFJY4GebXkYemfzvVhw9VQRp5fWCkH
         ComaJ3awA8t3eIyo1ZtUqF2PBOZSZLoWPc6eaiTNQh22EncdIp3h8sBbUfjXsDFuF1U/
         WilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694150539; x=1694755339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYqMjXvyP9eSuVfonZy2BlNb/nZfEBjIJ7oDG/l+S0M=;
        b=UsRhUcEQdvYBvxb5Y2uUzMvgStA/k/M0ELFAUuZGjMz/UMR4/Z6u57Lopz8OI6NuaH
         cX+GGoIjeBultr8za2Arp5iK0aW1qVv3wbS4tx2Qjeic8SKoxpsfpmk9crV6brg6ZPid
         Pq8BNlpJEcugQTaPvL5OA1BY97WPUSMAB+AV/Ng+fojJMQsslSnOiSLv2StBEvSgXPZR
         033/vucJg42gka/q3UBdLI8BKvL3RxhA6F5opQ1SgpL0k12VY0JCR9Bs7kDq4aEewZiR
         IrLXcydNJbWPR7UlYpCr8vpnbbnlZSUsj3ZSmnYDHeJFspdLHm5uy3/xfv2dvET0Sh9B
         leSA==
X-Gm-Message-State: AOJu0YwDobpmFJWLBZQWz59uC5iOHrl2RjcPXXlUAtvuHCy8d8ImgPBa
        b8e5AbXCtgkX9e6ptmg3sCE=
X-Google-Smtp-Source: AGHT+IFM2Q/0ux5uBmIxvZlzMmD7GKxrROjh2tqj3TcHd6VWJsdSd4JkqY6THXJQ1p74npzmfSriWw==
X-Received: by 2002:a05:6a00:1346:b0:68e:264f:d9ff with SMTP id k6-20020a056a00134600b0068e264fd9ffmr1620319pfu.15.1694150539475;
        Thu, 07 Sep 2023 22:22:19 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7e3a:75cb:af9d:24ea])
        by smtp.gmail.com with ESMTPSA id g9-20020aa78189000000b00682c1db7551sm537445pfi.49.2023.09.07.22.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 22:22:19 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf annotate: Add more x86 mov instruction cases
Date:   Thu,  7 Sep 2023 22:22:16 -0700
Message-ID: <20230908052216.566148-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instructions with sign- and zero- extention like movsbl and movzwq were
not handled properly.  As it can check different size suffix (-b, -w, -l
or -q) we can omit that and add the common parts even though some
combinations are not possible.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/annotate/instructions.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 5f4ac4fc7fcf..5cdf457f5cbe 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -74,12 +74,15 @@ static struct ins x86__instructions[] = {
 	{ .name = "movdqa",	.ops = &mov_ops,  },
 	{ .name = "movdqu",	.ops = &mov_ops,  },
 	{ .name = "movsd",	.ops = &mov_ops,  },
-	{ .name = "movslq",	.ops = &mov_ops,  },
 	{ .name = "movss",	.ops = &mov_ops,  },
+	{ .name = "movsb",	.ops = &mov_ops,  },
+	{ .name = "movsw",	.ops = &mov_ops,  },
+	{ .name = "movsl",	.ops = &mov_ops,  },
 	{ .name = "movupd",	.ops = &mov_ops,  },
 	{ .name = "movups",	.ops = &mov_ops,  },
-	{ .name = "movzbl",	.ops = &mov_ops,  },
-	{ .name = "movzwl",	.ops = &mov_ops,  },
+	{ .name = "movzb",	.ops = &mov_ops,  },
+	{ .name = "movzw",	.ops = &mov_ops,  },
+	{ .name = "movzl",	.ops = &mov_ops,  },
 	{ .name = "mulsd",	.ops = &mov_ops,  },
 	{ .name = "mulss",	.ops = &mov_ops,  },
 	{ .name = "nop",	.ops = &nop_ops,  },
-- 
2.42.0.283.g2d96d420d3-goog

