Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9776CC5D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjHBMLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbjHBMLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:11:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7965F2728;
        Wed,  2 Aug 2023 05:11:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bb7b8390e8so42034925ad.2;
        Wed, 02 Aug 2023 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690978293; x=1691583093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMwGk7rqssSAGhj7vNRsmygfgKVCaIWXJ1YRE7kR0YA=;
        b=Vzy2N+AG7dXCqR617X1+uJMRtDJIV2AwsiOW8fmfACy6LxhPOYD0rTspFdUobZUJmh
         lNMZTDfIHwePI8PXV3YiW8lJwRqwM9DBjyeKLRu5CSZr5+OBxJyzNfbIU6JSqxdsdw1F
         95A12YLXqO+ZV/zztH2/rtV7BsQ2dSJp/Shqalt7QLltqXCfQZ+6mNet7+5ajVek81/F
         ZLmRvlmNBYrs4aOosyWxMIbTvKOznBcE4rlfSZRK1VZVrW6vl9c3PeDKMqGbt8Tzeb7x
         nO8WhNhRpkcrVJk/B4w4jeynUyhxQLi8Ep43VnVA3ZGsEaEL34fEKHdLT7o2rx4ritzn
         Ay1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978293; x=1691583093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMwGk7rqssSAGhj7vNRsmygfgKVCaIWXJ1YRE7kR0YA=;
        b=T3oYiAzHl3dW7nUjkSuVaXIJu91/YOXdQV06EDiw2E2o81wAp7EjK4NOe09qaUhml4
         8kfZgUfjOwahjwUoe8SG40H+kS4xlnADthPsejfIwvzv9oidPNII103SPk0I0wrbyvKm
         14rjle7aZF/DFe+eM4Tg9ZU6qNljqME6iwjNlHZKT135OXDk04H/x9pFgVal2tJiVFs5
         onL5MsaoKSF8/NvGnc6SjDhPbsc32Sld6dnCpCvOnZdade/439MnDiGNJH815smJRjN+
         P8aqsm8emfsDqSv1zMwh3VPbVNtCIGkkkVIciZlaayw09QSJhuJmYZsBAJe6HCXRrUds
         j+Ow==
X-Gm-Message-State: ABy/qLbyLplCcs/waSd9CsC07jWEAtlx2FpCF5yFhrDjtgwdmXCeC4Vs
        3ZF6KJn3FSzU/MUWGCWUv/8=
X-Google-Smtp-Source: APBJJlGl+olfJYh5aXcHw4SRMdjzHVVGLF9oHRezdQp9jmJ7C31iK5UAsmKCqmYJbLen/zOZbxDRgg==
X-Received: by 2002:a17:902:da83:b0:1bb:4861:d3a7 with SMTP id j3-20020a170902da8300b001bb4861d3a7mr14948719plx.16.1690978292854;
        Wed, 02 Aug 2023 05:11:32 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.115])
        by smtp.googlemail.com with ESMTPSA id kx14-20020a170902f94e00b001b890009634sm12293173plb.139.2023.08.02.05.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:11:32 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao2021@gmail.com>,
        Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v4 2/7] perf sched: sync state char array with the kernel
Date:   Wed,  2 Aug 2023 08:09:57 -0400
Message-ID: <20230802121116.324604-3-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802121116.324604-1-zegao@tencent.com>
References: <20230802121116.324604-1-zegao@tencent.com>
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

From: Ze Gao <zegao2021@gmail.com>

Update state char array and then remove unused and stale
macros, which are kernel internal representations and not
encouraged to use anymore.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 9ab300b6f131..8dc8f071721c 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -92,23 +92,12 @@ struct sched_atom {
 	struct task_desc	*wakee;
 };
 
-#define TASK_STATE_TO_CHAR_STR "RSDTtZXxKWP"
+#define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
 
 /* task state bitmask, copied from include/linux/sched.h */
 #define TASK_RUNNING		0
 #define TASK_INTERRUPTIBLE	1
 #define TASK_UNINTERRUPTIBLE	2
-#define __TASK_STOPPED		4
-#define __TASK_TRACED		8
-/* in tsk->exit_state */
-#define EXIT_DEAD		16
-#define EXIT_ZOMBIE		32
-#define EXIT_TRACE		(EXIT_ZOMBIE | EXIT_DEAD)
-/* in tsk->state again */
-#define TASK_DEAD		64
-#define TASK_WAKEKILL		128
-#define TASK_WAKING		256
-#define TASK_PARKED		512
 
 enum thread_state {
 	THREAD_SLEEPING = 0,
-- 
2.41.0

