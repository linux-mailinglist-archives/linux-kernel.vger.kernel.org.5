Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6785276CD7C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjHBMtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjHBMtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:49:08 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46C73581;
        Wed,  2 Aug 2023 05:48:56 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-56433b1b12dso2361239a12.1;
        Wed, 02 Aug 2023 05:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690980536; x=1691585336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzdBr4YE6+e2aCPihxyG1VP6AlkYIgUBNXtEC6jGkqA=;
        b=affZwz5TEk3WIR+PRuKQAQZIq234JaxujRitv/TmpCwQ1HiXjIUtfisiW6PsYsy2WJ
         z6H0HlNkN6qsdwiaIFnFaobjoGoPPbfnfQa2cqi9nAquKLz0X0Sd+ooFwFMDR1WwHPpE
         pegy5hefVZ0Zy/SPcKkxFZb9N2evvh0O/0r1N+JlU7TJwXsjTtL+sVl1K6fuiX37ABsg
         Jgs1lA22+oPPSEB0BqL9BVhE8KM78m2A56G8LPKum4AWTZOoDp719Fh5p5bCK/6k9ELP
         613jSrxGDKHtBBvNGOGuQDN3uPGTJ2feM9YRuwotVBxZi1Bd3MS5qJCQcwOaaohs5hEp
         T1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980536; x=1691585336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzdBr4YE6+e2aCPihxyG1VP6AlkYIgUBNXtEC6jGkqA=;
        b=BxG/avEX7AVvNaQZAd7x8iP02euQbX1nFijnWPPU4brc9/lwOJIk2zbntdApGWPljg
         eYVTQ2KfPETpIvuCgDQnZXzzx1KCdS/FjwpXK7UJL9d6g7aXO2+cDwy/vicdSL1w76eF
         aO0pafMKk6rinmDGBq8w9/j8grDr3Do7HUbDyLueAFg3ZLM2zsn1OUFAcJYDasKvtAWp
         z1i+9Sk0Rs9h/Yknus641hbCEKEC8OWWCIPUKv8ORmzjvIZF6xShap6E52HzyrAbqwTJ
         ZuD1IGEAmUnu4Q9ZDcx5DD8i6edLyclsH5BatP5p8abGyFmHYlSEuMZAj0TjPyyGABcI
         XzoA==
X-Gm-Message-State: ABy/qLbjDzTKRrSNXXgkY4BM4IF0p7tWJ4Dr3NjTOUyCdlvhMuuzc66w
        7FEkUhS2Tlu46RRrTf0ZMN8=
X-Google-Smtp-Source: APBJJlGbwBrjxZSrIH+627bumLqD2mkRT9eSI5Q1xKxgYAsKG9qVBYCJYrIlLLDaF3pnUVITFpbiTw==
X-Received: by 2002:a17:90b:1954:b0:256:8dbd:74fa with SMTP id nk20-20020a17090b195400b002568dbd74famr12027905pjb.22.1690980535749;
        Wed, 02 Aug 2023 05:48:55 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm4811993pjj.1.2023.08.02.05.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:48:55 -0700 (PDT)
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
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v5 2/7] perf sched: sync state char array with the kernel
Date:   Wed,  2 Aug 2023 08:47:25 -0400
Message-ID: <20230802124840.335638-3-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802124840.335638-1-zegao@tencent.com>
References: <20230802124840.335638-1-zegao@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

