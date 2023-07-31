Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5029769249
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGaJvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGaJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:50:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C91BD2;
        Mon, 31 Jul 2023 02:49:43 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f38692b3so4077682b3a.2;
        Mon, 31 Jul 2023 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690796983; x=1691401783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srChBgqkK2HgGpCSRgI2R97JsxAcdTHmiRn2ciHkn/Y=;
        b=p1r5iHFCJoYcfwDUrmDWxBxPw6HqRaQG3xB8yYmbvEY+VYS7gw4oolqV+Z/nnfYg5M
         oEV7LlRg5v/1Bt84bYMiW8YjIA7p3L0RxTyU3rreH8LVurcwMhXijRz7jAPR/vWwY0IY
         tQs/4WJ0qFxqb9By1De8gqvGMlQCa2pWz6hN2dwl0pxx0L3G3lXcu0v0etR8rbwONHuH
         AL9BK9mquSqih5nFnop3SNa5QXcKOfUR3DvZ9mPo//l8b1dGvOQYfSQXIt7Ur7ayzqJz
         i4VcNeSLb65rPUUtBulKhqNvjkIOVqdhkm/MVWWsV3uglHHHGO3gS56UHxK852Zyat8B
         UsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796983; x=1691401783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=srChBgqkK2HgGpCSRgI2R97JsxAcdTHmiRn2ciHkn/Y=;
        b=Axi44AwssO3ODLFVW02E+wewwsKLP5T8AXfG6BJwLWJiAxO/al0NLmbTV5kWHQlZ98
         5pOuXyQlGNJE1bAriRipCawWCOBtZaXw3GS/IwHS1tBkewiYlAxqApEY+fIeJjcOCQ7l
         PKC3Q1lxKD9GZiVOB8N7k9aURS7OgjqU817M5onoFxt0xJE6Wws4NM0JxHbWPCFAegFl
         mBoDSC61yHDOAo5SO4/v7XRowLfWH7Tbm9Hny9Jy4ZNk5JlAXquD34Rg6kOH8/s4TqFn
         a2faCf2U6pwOtEc/SyjZYCZfrOE7X9pWXAY6A4WsGiXDpJvd5+9y6x1tQ/Bzwuka7ktO
         PLDA==
X-Gm-Message-State: ABy/qLZAaud8tpAT3dnxsPS4UYK7ZsYPKo63wweXBi1ZuwRriuxg9b51
        y506/P8fe8dI69OU6jyq4oE=
X-Google-Smtp-Source: APBJJlHZAthHl4OKjoHHK6ESw06lVprmQUtSl7arS/NlwVct68uoaFo12mTuuHfBABubGVEyJ3stBw==
X-Received: by 2002:a05:6a21:a105:b0:133:ebf2:96da with SMTP id aq5-20020a056a21a10500b00133ebf296damr8970908pzc.41.1690796983236;
        Mon, 31 Jul 2023 02:49:43 -0700 (PDT)
Received: from bangji.roam.corp.google.com ([117.111.1.150])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001bbd1562e75sm8117852plb.55.2023.07.31.02.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:49:42 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/2] perf hists browser: Fix the number of entries for 'e' key
Date:   Mon, 31 Jul 2023 02:49:33 -0700
Message-ID: <20230731094934.1616495-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230731094934.1616495-1-namhyung@kernel.org>
References: <20230731094934.1616495-1-namhyung@kernel.org>
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

The 'e' key is to toglle expand/collapse the selected entry only.  But
the current code has a bug that it only increases the number of entries
by 1 in the hierarchy mode so users cannot move under the current entry
after the key stroke.  This is due to a wrong assumption in the
hist_entry__set_folding().

The commit b33f922651011 ("perf hists browser: Put hist_entry folding
logic into single function") factored out the code, but actually it
should be handled separately.  The hist_browser__set_folding() is to
update fold state for each entry so it needs to traverse all (child)
entries regardless of the current fold state.  So it increases the
number of entries by 1.

But the hist_entry__set_folding() only cares the currently selected
entry and its all children.  So it should count all unfolded child
entries.  This code is implemented in hist_browser__toggle_fold()
already so we can just call it.

Fixes: b33f922651011 ("perf hists browser: Put hist_entry folding logic into single function")
Cc: stable@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/hists.c | 58 ++++++++++++++--------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index d8b88f10a48d..70db5a717905 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -407,11 +407,6 @@ static bool hist_browser__selection_has_children(struct hist_browser *browser)
 	return container_of(ms, struct callchain_list, ms)->has_children;
 }
 
-static bool hist_browser__he_selection_unfolded(struct hist_browser *browser)
-{
-	return browser->he_selection ? browser->he_selection->unfolded : false;
-}
-
 static bool hist_browser__selection_unfolded(struct hist_browser *browser)
 {
 	struct hist_entry *he = browser->he_selection;
@@ -584,8 +579,8 @@ static int hierarchy_set_folding(struct hist_browser *hb, struct hist_entry *he,
 	return n;
 }
 
-static void __hist_entry__set_folding(struct hist_entry *he,
-				      struct hist_browser *hb, bool unfold)
+static void hist_entry__set_folding(struct hist_entry *he,
+				    struct hist_browser *hb, bool unfold)
 {
 	hist_entry__init_have_children(he);
 	he->unfolded = unfold ? he->has_children : false;
@@ -603,34 +598,12 @@ static void __hist_entry__set_folding(struct hist_entry *he,
 		he->nr_rows = 0;
 }
 
-static void hist_entry__set_folding(struct hist_entry *he,
-				    struct hist_browser *browser, bool unfold)
-{
-	double percent;
-
-	percent = hist_entry__get_percent_limit(he);
-	if (he->filtered || percent < browser->min_pcnt)
-		return;
-
-	__hist_entry__set_folding(he, browser, unfold);
-
-	if (!he->depth || unfold)
-		browser->nr_hierarchy_entries++;
-	if (he->leaf)
-		browser->nr_callchain_rows += he->nr_rows;
-	else if (unfold && !hist_entry__has_hierarchy_children(he, browser->min_pcnt)) {
-		browser->nr_hierarchy_entries++;
-		he->has_no_entry = true;
-		he->nr_rows = 1;
-	} else
-		he->has_no_entry = false;
-}
-
 static void
 __hist_browser__set_folding(struct hist_browser *browser, bool unfold)
 {
 	struct rb_node *nd;
 	struct hist_entry *he;
+	double percent;
 
 	nd = rb_first_cached(&browser->hists->entries);
 	while (nd) {
@@ -640,6 +613,21 @@ __hist_browser__set_folding(struct hist_browser *browser, bool unfold)
 		nd = __rb_hierarchy_next(nd, HMD_FORCE_CHILD);
 
 		hist_entry__set_folding(he, browser, unfold);
+
+		percent = hist_entry__get_percent_limit(he);
+		if (he->filtered || percent < browser->min_pcnt)
+			continue;
+
+		if (!he->depth || unfold)
+			browser->nr_hierarchy_entries++;
+		if (he->leaf)
+			browser->nr_callchain_rows += he->nr_rows;
+		else if (unfold && !hist_entry__has_hierarchy_children(he, browser->min_pcnt)) {
+			browser->nr_hierarchy_entries++;
+			he->has_no_entry = true;
+			he->nr_rows = 1;
+		} else
+			he->has_no_entry = false;
 	}
 }
 
@@ -659,8 +647,10 @@ static void hist_browser__set_folding_selected(struct hist_browser *browser, boo
 	if (!browser->he_selection)
 		return;
 
-	hist_entry__set_folding(browser->he_selection, browser, unfold);
-	browser->b.nr_entries = hist_browser__nr_entries(browser);
+	if (unfold == browser->he_selection->unfolded)
+		return;
+
+	hist_browser__toggle_fold(browser);
 }
 
 static void ui_browser__warn_lost_events(struct ui_browser *browser)
@@ -732,8 +722,8 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
 		hist_browser__set_folding(browser, true);
 		break;
 	case 'e':
-		/* Expand the selected entry. */
-		hist_browser__set_folding_selected(browser, !hist_browser__he_selection_unfolded(browser));
+		/* Toggle expand/collapse the selected entry. */
+		hist_browser__toggle_fold(browser);
 		break;
 	case 'H':
 		browser->show_headers = !browser->show_headers;
-- 
2.41.0.487.g6d72f3e995-goog

