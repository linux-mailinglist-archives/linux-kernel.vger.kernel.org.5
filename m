Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC43476CD7B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjHBMtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjHBMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:49:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6057830C6;
        Wed,  2 Aug 2023 05:48:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2683add3662so4705778a91.1;
        Wed, 02 Aug 2023 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690980532; x=1691585332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8lpjzm6rHULKX3RnedYfP137m4qvGL5uKJaH+JzOyE=;
        b=dsOEdkUxZ1tD0QOsLdlp1zsXXHcieudYGt0U2fn/8f2w/6NdSK5Nom90sLaMCS79VO
         LzqM7DSiv3m8Hwx1t07Zp19pmLFJJP2zZ9CmQCc0FSGxAQYwSJ2UM2Wz7IX8t5y7cvht
         /VJGkDkDYaZ1Z/vu0FhjBcDt6WKWLEY26NZ83tqM5JGm3h8Z0GleINZTIljljgp/xkGM
         WPxbr793xnvOXWGTd3A+7KkbCjd0N94kwA5ZIW7s8roJg6Z+Es0YwTH4qsn9JpljLHUv
         9t126fNkmkPiX8RijOxRbPQAI1E+2Pwmza6sfmocbKLSsYEILpRw/DSffy3zvmN0xLcc
         kZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980532; x=1691585332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8lpjzm6rHULKX3RnedYfP137m4qvGL5uKJaH+JzOyE=;
        b=EEU4+lsvkd7NInan/4M5KbL5Hxqiehvl+xqT0PvTqLf4xmKeUNtGIf0KhgD6lfH8w1
         qHXlL7As0k2B5XxObHjDqzFZPgWVzsClGIQG1EwiqMc07f4WjxgTCp3hi0+4U5YUDV6J
         FMM3R8p8obuXaJa7xsudoab1kOdjZj63zZhF2hmATzLkBJz1GqAOip3Bs5tsibN9Z8Qe
         SEE6qSUmiHrT5WUTv7TQydtvjnuwWD4egwf5r8phMOXrRRNveBa0Ot8qP/w16Q+Svdv3
         MB+fuHN7qE4Gt472HJEJSKOfgYJId0zalJ+bBiE7gq88jDGxsds878V41yn23GjWaO6N
         PDZA==
X-Gm-Message-State: ABy/qLaAzkBBBuxFJhMR52rfCxoVNcDKuL3yi1C/QGP7ocgJgBHnGyFm
        DL+nm07c7jKrhSty44qUTTc=
X-Google-Smtp-Source: APBJJlFZT7ZCW9/VkjiP1bSpFOyccekrrKdSn3AqKrrXWF9WWcXCPkdd1pDWteK/UbKlAYG8BxBNog==
X-Received: by 2002:a17:90b:4a8d:b0:268:1217:46bc with SMTP id lp13-20020a17090b4a8d00b00268121746bcmr14634627pjb.11.1690980531731;
        Wed, 02 Aug 2023 05:48:51 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm4811993pjj.1.2023.08.02.05.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:48:51 -0700 (PDT)
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
Subject: [RFC PATCH v4 1/7] libtraceevent: sync state char array with the kernel
Date:   Wed,  2 Aug 2023 08:47:24 -0400
Message-ID: <20230802124840.335638-2-zegao@tencent.com>
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

Update state char array to match the latest kernel
definitions.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 plugins/plugin_sched_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/plugin_sched_switch.c b/plugins/plugin_sched_switch.c
index 8752cae..e0986ac 100644
--- a/plugins/plugin_sched_switch.c
+++ b/plugins/plugin_sched_switch.c
@@ -11,7 +11,7 @@
 
 static void write_state(struct trace_seq *s, int val)
 {
-	const char states[] = "SDTtZXxW";
+	const char states[] = "SDTtXZPI";
 	int found = 0;
 	int i;
 
-- 
2.41.0

