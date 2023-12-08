Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D358096E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjLHAFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjLHAFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:05:24 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8131716
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:05:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d7e7e10231so9720297b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701993929; x=1702598729; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgzdmxyD187mlNLpFJ4WQcDthQqtT591zShxv4oxXeo=;
        b=mMbnETiZ+g50JfUFRBSzXe0iTlPVlEtdQH9KjOBgOe2a8MDht5H2v5Bb87/ynA61uC
         TjBkNVLQIy3S8s5SfK+izTfVZXDHU2npS2K5ftbIAVDyVgOln2nt8lEuNe8p35SDfjRe
         n116DEtsfGUBxKLIkLDWpQLaix10XVKIu+5PO0xeCW7F5YH1u1kWJyVgGRZGHQEyfkaf
         8fqWP5OuGhpkYuSF7ZELFJJvUIw12xezt8xJVFe+VBhpED9IT/Wt62HVY4vmdFWLoAkv
         edVDk/cvu5b/NCsW5msCzd4vdkz9d7MMJEMyvVQ1XW+cGBT6Lb5uIPjBIv6iKNV+3uj1
         gJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993929; x=1702598729;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgzdmxyD187mlNLpFJ4WQcDthQqtT591zShxv4oxXeo=;
        b=kuqTofA4oKwFTQknrKJSq5tJUI1E1sseJ8tHrz+MK1rVPXcVujVGOlViLOv3uq6Bo6
         YGWVwhYWnjAmUqPaLHU5vHM7bjhFAK9vBMp/htIRU/JuIAQX0v8zDFeprBmbwoggv9No
         eQDs8vBuczjzj5DBSoP8cevIyDXPkQ2FHou8ghZ1UG6Up4Pv71SUrQ12FFAPwbaGV8km
         X/NSXKZmI93wVMegZdPj9N4FybUTpslcRsWFSU5ZvrwQPo3kUsVrI3dU+cRj7ZrcuKHl
         G5XEYihP5Bdujx275/BYEfLFrMrbNMC0XSy9Exnr+0Asray/UlqCXHXnxS29DCyov9nG
         GvLg==
X-Gm-Message-State: AOJu0YyaN6G1Y3/8hD5r6rlQ5mNvI8f8KBe5/3NvFiLQMgW89SsI2VP2
        XzlIUheBqfngdv9+Y6WjXOKBN4OhWhWG
X-Google-Smtp-Source: AGHT+IEIhcIw8xy4mXcVlIVgYRmYedq9Rmvq6nH9O224FYrn8Hf8qx3kHxCVC9QjDwyjRtuRxHCGVJ0OgJF6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aa27:6848:76cc:141c])
 (user=irogers job=sendgmr) by 2002:a05:690c:2882:b0:5d3:985c:800c with SMTP
 id ee2-20020a05690c288200b005d3985c800cmr869ywb.3.1701993929362; Thu, 07 Dec
 2023 16:05:29 -0800 (PST)
Date:   Thu,  7 Dec 2023 16:05:15 -0800
In-Reply-To: <20231208000515.1693746-1-irogers@google.com>
Message-Id: <20231208000515.1693746-3-irogers@google.com>
Mime-Version: 1.0
References: <20231208000515.1693746-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1 3/3] perf help: Lower levenshtein penality for deleting character
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
        Chenyuan Mi <cymi20@fudan.edu.cn>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The levenshtein penalty for deleting a character was far higher than
subsituting or inserting a character. Lower the penalty to match that
of inserting a character.

Before:
```
$ perf recccord
perf: 'recccord' is not a perf-command. See 'perf --help'.
```

After:
```
$ perf recccord
perf: 'recccord' is not a perf-command. See 'perf --help'.

Did you mean this?
        record
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/help-unknown-cmd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index 2ba3369f1620..a0a46e34f8d1 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -73,10 +73,14 @@ const char *help_unknown_cmd(const char *cmd, struct cmdnames *main_cmds)
 
 	if (main_cmds->cnt) {
 		/* This reuses cmdname->len for similarity index */
-		for (i = 0; i < main_cmds->cnt; ++i)
+		for (i = 0; i < main_cmds->cnt; ++i) {
 			main_cmds->names[i]->len =
-				levenshtein(cmd, main_cmds->names[i]->name, 0, 2, 1, 4);
-
+				levenshtein(cmd, main_cmds->names[i]->name,
+					/*swap_penalty=*/0,
+					/*substition_penality=*/2,
+					/*insertion_penality=*/1,
+					/*deletion_penalty=*/1);
+		}
 		qsort(main_cmds->names, main_cmds->cnt,
 		      sizeof(*main_cmds->names), levenshtein_compare);
 
-- 
2.43.0.472.g3155946c3a-goog

