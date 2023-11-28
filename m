Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB647FC21B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346929AbjK1Rzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346763AbjK1RzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:55:07 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D20F19A6;
        Tue, 28 Nov 2023 09:54:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cc2027f7a2so2936067b3a.2;
        Tue, 28 Nov 2023 09:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701194097; x=1701798897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZSI6nbgA6QD83qiIZ5QwLyFy76wOuZEQPl5G7QZIT8=;
        b=SEYBQ8QL0/NEPZNwZOs7Ar3SQy/JsRx49yvnt5+4ALRbLl4aCglldbkinIqxK3AWeO
         8FBkZEx3+1rl39PPCf4Xcw0K8PyiSl/MoZS2skcjBTHrggavIQCNlImPjOc98IntwNct
         9bO4f/r4JT+pNSLGIq35m2JXy6gn0q88oosWuq7VsKLvAxxE8b/WwlqbBmc1eVD23eze
         FlBQWeJ6aOSjEFWtcnAc2BrmNKPKJ4U26do4HcgyUFnjaWzb6xuLJJ3BJKNYHJTs6UMb
         5dx4CljQJ3MYVKBOdyWa8+8SFqZOkeSWvM+Qce1wGC09TGmdNduWTBf8if1GreimtozF
         M9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194097; x=1701798897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ZSI6nbgA6QD83qiIZ5QwLyFy76wOuZEQPl5G7QZIT8=;
        b=G5IvFoTBvyzf8Brw++vzhFHCWEnZU9Cw+5G3R4TYl4eN0ZlhPwMQYx7doWiRxmGQeC
         p7fQkHRNYe7X5LK5T0E+o+SgiD5v4wiiys/572ePV90aZ4trqFRV/aNL0NpGxP7ceZ/a
         vbISNNjaESC1UbAvKn9CaEHbmKWal5fXYPyllZEjM+XY1fkvlnIaADUavUle2cBphKUk
         knEymBlZ2d68jN25wIWXyQAzr6KbxpOF/7csMYBSlM3fw7LoErlUr0KKQ6grpF0tKdeA
         xPuc+rez2bQkG+ErabzKXAThmD70AGW1mlWcTfn3kInfDrjCSn6tXm3Xw0lMFQkZFtif
         63qQ==
X-Gm-Message-State: AOJu0Yy6mVDFpKQ/yLDxF08g/u+1FDQAbhs3fl1WKLsXzBXEATSAKshQ
        RIB90+/XyfwZBAMAvRymX+0=
X-Google-Smtp-Source: AGHT+IF+J6deI6CdJUjmIuJNHQDdMwHy1IWbB3CCbzxgqFerkQB9w3OyYECWx7IvC/w28SuWPiOZMg==
X-Received: by 2002:a05:6a20:4412:b0:18a:d8ba:ca4c with SMTP id ce18-20020a056a20441200b0018ad8baca4cmr17779650pzb.52.1701194097652;
        Tue, 28 Nov 2023 09:54:57 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:146f:6347:3bb4:8cf4])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78042000000b006cbbc07a1c0sm9224721pfm.156.2023.11.28.09.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:54:57 -0800 (PST)
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
Subject: [PATCH 8/8] perf annotate: Get rid of local annotation options
Date:   Tue, 28 Nov 2023 09:54:41 -0800
Message-ID: <20231128175441.721579-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231128175441.721579-1-namhyung@kernel.org>
References: <20231128175441.721579-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't need the option in the struct annotation which is allocated
for each symbol.  It can directly use the global options and save 8
bytes per symbol.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 2 --
 tools/perf/util/annotate.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 09c399ab0384..c81fa0791918 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3333,8 +3333,6 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	if (err)
 		goto out_free_offsets;
 
-	notes->options = &annotate_opts;
-
 	symbol__calc_percent(sym, evsel);
 
 	annotation__set_offsets(notes, size);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 6d5a6bb49a97..589f8aaf0236 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -294,7 +294,6 @@ struct annotated_branch {
 
 struct LOCKABLE annotation {
 	u64			start;
-	struct annotation_options *options;
 	int			nr_events;
 	int			max_jump_sources;
 	struct {
-- 
2.43.0.rc1.413.gea7ed67945-goog

