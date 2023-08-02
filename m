Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F26676CC5C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjHBMLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjHBMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:11:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BBF1BF9;
        Wed,  2 Aug 2023 05:11:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso57245955ad.2;
        Wed, 02 Aug 2023 05:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690978289; x=1691583089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8lpjzm6rHULKX3RnedYfP137m4qvGL5uKJaH+JzOyE=;
        b=qDhWpMiPmib0qqnREtOztQZpDsTPdJdWHHMZI23ihdKILrWa9RKCZKneIgluadIyZV
         k/DsHqzpgh6zo+z0WUcVasAAtxg8wCEIs2YEl4RBmRyoXr9upFn+lca+ZIMRl9p7ysIX
         gZNZ6xxkEL9DfCNTvL6vQw2J3VlGXgBnpr5A/AYAG6Ymopo8OVNeBofOyPSVLxDDUHHd
         uOGCP7/mSJomw/L6ZjWH3qg+O8qfQvxIfoQbf4nVoYjQTdechqL/vwrxfsjD1vyzGUGz
         sL8Xh7n6VyvBeHlEePIscQm0rL23Mdw1HvtiIc2dTLUqumsgeV9dyFWY69Sg02nqdYyz
         mhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978289; x=1691583089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8lpjzm6rHULKX3RnedYfP137m4qvGL5uKJaH+JzOyE=;
        b=VPxAOWpMBoIy9/34zfY4MxeERHARZW6TZ7ba0tptNyrHIHksM6Qzdx/84+UTgy+S0j
         /Wgy4KIglTsBoU7aHgb1IMSb9/UoMb1cBIG+njZuQiWOJk6epUKRNIU6Hx2evRILjGOc
         rGnWZZEIXTwmykkzJimWQNnhUMwNqcG6xfG72P59LA1Cm0QWUpe8LsizJbV/cO1Z49xG
         YV+xg8p+8hY4LA2CLtWKXtw3UK+xsesTVTmIXCsbOSiAd6uEwxPFGjsVoQhM/g7Z8CO3
         2hie5KpjNCjue/geVOan/TnYYzJAaIPwp7+QD/kN0nakryQEb2Wa4RaqV1ELnsaC7Im+
         WyAw==
X-Gm-Message-State: ABy/qLbj/5KJUw7LY8+TKmzxGI0/O1ajdwjJuSYGrLQOHrS9eM/d5Ew7
        SUlUXrbo0fyGmNtq9Rtnzlg=
X-Google-Smtp-Source: APBJJlHv0s+24DtRzTF7MSff5+HnSMFm9tB/W5D+rEXRTJW+Rzj8gIRgQMZKVyGUTgiH+uNle+Mywg==
X-Received: by 2002:a17:902:7283:b0:1bc:1270:1bfd with SMTP id d3-20020a170902728300b001bc12701bfdmr7909491pll.55.1690978288680;
        Wed, 02 Aug 2023 05:11:28 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.115])
        by smtp.googlemail.com with ESMTPSA id kx14-20020a170902f94e00b001b890009634sm12293173plb.139.2023.08.02.05.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:11:28 -0700 (PDT)
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
Date:   Wed,  2 Aug 2023 08:09:56 -0400
Message-ID: <20230802121116.324604-2-zegao@tencent.com>
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

