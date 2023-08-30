Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2200278DF99
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242035AbjH3TLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241811AbjH3HIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:08:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3941E1A4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:08:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e8207103so54979477b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693379283; x=1693984083; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+8JLAKIBIn048cO3B8TYmgEefYduNPXi4aPzlXEsfM=;
        b=uiy8q8sY8t6J5j4MbQ+/fF/jLis8Fa14Arru3Q/ilXQqhOYb337WLLSbSYc6IggOkc
         eIE3DhsBFDM4/OOSnVDEbOv4kMJUfD5cfD/ooL8VBm0m9YntuCsesfFXj++DoZbm9OUc
         9kfnZv5h+taMY0AiLtmOmhnsa/ENcVCzcfFC7ZPdVarfGJ+phddJI9aybwUJEYxEDxM7
         Lgn0cgz858RaygaeEdFn2nqmbSP8lG3H7ymCR6wRLYhAr6KgXiEVWf7K/3nwNwI88DWF
         ntI2t86Rrn7IDYxNiMvlzKQUZ63pJWLrAA263p8tcVNvTDCDrxmiUmZQn/wOUJzsdzxc
         bzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693379283; x=1693984083;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+8JLAKIBIn048cO3B8TYmgEefYduNPXi4aPzlXEsfM=;
        b=GOqQi4c0qjRkP/bNsbSkqCyAYkjY5/kX1kaIFVPVYbgcDWUuf9Z9wOXnh5e1Wuc7Z+
         axSXEhY8CWL5rjyjvgFresRY6JPqBCU/wk5LZs6RnVON7defhQ6p0Nwc1MDYG9ZQyiSw
         ZwkYqFA88juKV4GB0R90tRAXhCy6XBAZpu+cw+ZqdYTG5jt+KmgAC48gj1BwEhYNMj1g
         ygmUvD8i73oIDKYu0nTf+EjdKYAyxPPWOUj2tQiwwTwfEcRjsW3ko8iMRIo1xvLPpYeX
         VChUz3xVJqfLDAb85+NP9133uqFkhB0vEqVx8ON78EKKpp1O/0rY4aKAwwsdnHoRFDel
         yskA==
X-Gm-Message-State: AOJu0YwzcFD15K+sX+lnm61fKhLV7n67MHcVdb2uPfc1OwtlQ01ZL1ny
        2HYwvszS90rGxodsL2opnznWXHnIEh30
X-Google-Smtp-Source: AGHT+IGa4KqrG0JMXUrj92shCnvizPR/jPb6Je3MKgarqiiXASgu8g7j5hN7r28Ca/zboYqjEl/qgeCFNShf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d623:3cd7:ecbc:8798])
 (user=irogers job=sendgmr) by 2002:a25:34c3:0:b0:d0e:e780:81b3 with SMTP id
 b186-20020a2534c3000000b00d0ee78081b3mr31760yba.2.1693379283536; Wed, 30 Aug
 2023 00:08:03 -0700 (PDT)
Date:   Wed, 30 Aug 2023 00:07:53 -0700
In-Reply-To: <20230830070753.1821629-1-irogers@google.com>
Message-Id: <20230830070753.1821629-3-irogers@google.com>
Mime-Version: 1.0
References: <20230830070753.1821629-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1 3/3] perf pmu: Remove str from perf_pmu_alias
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the value is only used in perf list. Compute the value just
when needed to avoid unnecessary overhead. Recycle the strbuf to avoid
memory allocation overhead.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8dbb7008877e..152cda84f273 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -51,11 +51,6 @@ struct perf_pmu_alias {
 	 * json events.
 	 */
 	char *topic;
-	/**
-	 * @str: Comma separated parameter list like
-	 * "event=0xcd,umask=0x1,ldlat=0x3".
-	 */
-	char *str;
 	/** @terms: Owned list of the original parsed parameters. */
 	struct list_head terms;
 	/** @list: List element of struct perf_pmu aliases. */
@@ -408,7 +403,6 @@ static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
 	zfree(&newalias->desc);
 	zfree(&newalias->long_desc);
 	zfree(&newalias->topic);
-	zfree(&newalias->str);
 	zfree(&newalias->pmu_name);
 	parse_events_terms__purge(&newalias->terms);
 	free(newalias);
@@ -489,7 +483,7 @@ static int update_alias(const struct pmu_event *pe,
 	assign_str(pe->name, "long_desc", &data->alias->long_desc, pe->long_desc);
 	assign_str(pe->name, "topic", &data->alias->topic, pe->topic);
 	data->alias->per_pkg = pe->perpkg;
-	if (assign_str(pe->name, "value", &data->alias->str, pe->event)) {
+	if (pe->event) {
 		parse_events_terms__purge(&data->alias->terms);
 		ret = parse_events_terms(&data->alias->terms, pe->event, /*input=*/NULL);
 	}
@@ -511,7 +505,6 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	int ret;
 	const char *long_desc = NULL, *topic = NULL, *unit = NULL, *pmu_name = NULL;
 	bool deprecated = false, perpkg = false;
-	struct strbuf sb;
 
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ false)) {
 		/* Alias was already created/loaded. */
@@ -531,7 +524,6 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (!alias)
 		return -ENOMEM;
 
-	alias->str = NULL;
 	INIT_LIST_HEAD(&alias->terms);
 	alias->scale = 1.0;
 	alias->unit[0] = '\0';
@@ -574,17 +566,6 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		}
 	}
 
-	/* Scan event and remove leading zeroes, spaces, newlines, some
-	 * platforms have terms specified as
-	 * event=0x0091 (read from files ../<PMU>/events/<FILE>
-	 * and terms specified as event=0x91 (read from JSON files).
-	 *
-	 * Rebuild string to make alias->str member comparable.
-	 */
-	zfree(&alias->str);
-	strbuf_init(&sb, /*hint=*/ 0);
-	parse_events_term__to_strbuf(&alias->terms, &sb);
-	alias->str = strbuf_detach(&sb, /*sz=*/ NULL);
 	if (!pe)
 		pmu->sysfs_aliases++;
 	else
@@ -1682,7 +1663,9 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		.pmu = pmu,
 	};
 	int ret = 0;
+	struct strbuf sb;
 
+	strbuf_init(&sb, /*hint=*/ 0);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		size_t buf_used;
@@ -1710,14 +1693,16 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		info.desc = event->desc;
 		info.long_desc = event->long_desc;
 		info.encoding_desc = buf + buf_used;
+		parse_events_term__to_strbuf(&event->terms, &sb);
 		buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-				"%s/%s/", info.pmu_name, event->str) + 1;
+				"%s/%s/", info.pmu_name, sb.buf) + 1;
 		info.topic = event->topic;
-		info.str = event->str;
+		info.str = sb.buf;
 		info.deprecated = event->deprecated;
 		ret = cb(state, &info);
 		if (ret)
-			return ret;
+			goto out;
+		strbuf_setlen(&sb, /*len=*/ 0);
 	}
 	if (pmu->selectable) {
 		info.name = buf;
@@ -1732,6 +1717,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		info.deprecated = false;
 		ret = cb(state, &info);
 	}
+out:
+	strbuf_release(&sb);
 	return ret;
 }
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

