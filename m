Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D957A19FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjIOJKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjIOJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:09:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F262113;
        Fri, 15 Sep 2023 02:09:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4018af103bcso12664495e9.1;
        Fri, 15 Sep 2023 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694768951; x=1695373751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+SaUS6vSo7orYelt85erkzzlVKhFWk0a2MJr/r0pFQ=;
        b=Fh+brkwz58HhzcVqcicA8gMpuMan4iWcVLjzurRhekcN0kFlOyTOu3/rcY/ywEoE+2
         JrCk/V/TgP2ZDuFlqx+/HBeGOe6d0tfkufp242Br6eFoYQuJx4lqHxCwwofGjgdl+e9V
         e1zsrn9DMdQk4sBA8pAP3enkOIU3AORaAVrYOez7MUp/Lxlih1hPT1IxZYFcxr9uHO45
         /jJqM4cZSmTp3SA4EfsOxfwW/R8/gJqvkdQyHmBrQCsqKatVguQ1kMxyA29zywlH6IMQ
         pWHqywoDXZMvFkyLGdnp+aOPAsasTB6wQ6ghtsoWxAx161hTAwjcOKOjjDFWARBslYm0
         7iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694768951; x=1695373751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+SaUS6vSo7orYelt85erkzzlVKhFWk0a2MJr/r0pFQ=;
        b=Jnc6b/ORiH4KylxqE9cfMVwXmwUyOHk51azbZvW3P0BfKwNNIczs+t2jGUtSRpn/w5
         mPwsAAzWwwbyU6PQFrbfH3zaJhQcm+ssROsPSb/X1gGS7C+xg/Q58W3ih66j24qMNaDR
         As+GA4oPwR25th/1bJi2M5KQuS9tpIluA2BTf2dLTbazjw8E0hM8oxDsjy3NO9S49pZb
         prbGc42DLhawNEucjXp/CNUYd0toyFezukQGgeaY6FLu9SiM9jhiMVPoujAukexz2q3m
         BOg419CuTFyytigQIK9XZVM8n2tRJaxtb/zY6BDnZ5ITcDZSWtHOnk9lYnRNPc5ErcV0
         XsqA==
X-Gm-Message-State: AOJu0YxUMyJF5yAq5ENR0s9LzIucLSxzKKeC5kxrs2ocnpUiF7DiJ610
        uOR+rnw97xcLvCxXn/ll4AMdBl0S0YogV5xq
X-Google-Smtp-Source: AGHT+IFOf/E8HzEzYsp3EqhqBQ2CwqOBGF19/Nx5TFz4oIQWeKi0fYakDvNq6BtdabSYRMC7++88fg==
X-Received: by 2002:a05:600c:4b92:b0:403:aced:f7f4 with SMTP id e18-20020a05600c4b9200b00403acedf7f4mr3436020wmp.12.1694768951383;
        Fri, 15 Sep 2023 02:09:11 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bc8ca000000b00401d8181f8bsm6928709wml.25.2023.09.15.02.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:09:10 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf kwork: Fix spelling mistake "COMMMAND" -> "COMMAND"
Date:   Fri, 15 Sep 2023 10:09:10 +0100
Message-Id: <20230915090910.30182-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/builtin-kwork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 04b966801643..7e8dd35d764b 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1629,7 +1629,7 @@ static void top_print_header(struct perf_kwork *kwork __maybe_unused)
 
 		     PRINT_CPU_USAGE_WIDTH, "%CPU",
 		     PRINT_RUNTIME_HEADER_WIDTH + RPINT_DECIMAL_WIDTH, "RUNTIME",
-		     PRINT_TASK_NAME_WIDTH, "COMMMAND");
+		     PRINT_TASK_NAME_WIDTH, "COMMAND");
 	printf("\n ");
 	print_separator(ret);
 }
-- 
2.39.2

