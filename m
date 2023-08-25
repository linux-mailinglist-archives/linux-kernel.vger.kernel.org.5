Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69F0788C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbjHYP0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbjHYP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:26:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCED2135;
        Fri, 25 Aug 2023 08:25:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68c3b9f83f4so102101b3a.2;
        Fri, 25 Aug 2023 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692977158; x=1693581958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dkIp32PKiTsayBFNAWUFDT4Ll/EsNMIdgnUcUxUk/g=;
        b=UOa37g7QOTAhyE9nuxalTn3MBlr6KmIhbQbsa+euX/xrh5DVQVUmOx0KVeL+I7EMdd
         tI4wbYV6G1bwCcAR0uXHzf/JR2DubcTspop1VgEbdTzdPP5FO2NXgY3FtmaMFCuX7bAj
         T/a1IuUXXw0+9wWCXhxxrqXa8FrFqxJnuvc8lFgeiPECLh2bau+Bt2yggS+pHs4Iw1Of
         4VWUD+KaKouHFrDyLtqCHAwmtghb9grVKzumITEjOpyIqY1gasOa9B2as0rYwbvifgwx
         6kUVu5SpMG9D73Y5FDc9EyM7VAsETRVlFioXeJnASWQuYJAZxgQCGyob8F3PmPLg53ng
         MpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977158; x=1693581958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/dkIp32PKiTsayBFNAWUFDT4Ll/EsNMIdgnUcUxUk/g=;
        b=LyEpoO3y0GaYod5XbLD0mmP9ncf+1DshDpdQcOFxDPjoWZ67R3uXIvUQqwi5KQL+/O
         jF4dKObH1C2O1bOyhqZsMxHYrbYZ8cXC9kWKeOAAF7rh9QRZbQ0OWJftgNI9xMaw9HJF
         w86zgDJv9+CcMaUFlKYHg+vH4bTrmQ0/i69xaZb49MihPsevC+NM2V6rev0b8fyWXHBE
         0/nBdWclwbFD6fpRaWmvEjLyY1zZFsp7S4uYj8zempzhvMqN11XZsiOn3Hk2iDQX14gT
         nHwVKl/kPrclhJGLeBJo1nab1Brs8pIiMXJZkXOs7IyRsinrxnbdllXHbocPVyYt0MMn
         PUfg==
X-Gm-Message-State: AOJu0YyGHAxRIKfS39u9JDJB93qQK5BHx9irsU3imXl8Xfw0KnTGfimV
        k4IXqFUi66J9B4XSoySzqkE=
X-Google-Smtp-Source: AGHT+IFH9hd/zLbUtBP2XqBtmVdQRmY+BoqC3rx/hdRJk78+sh1r0INTC1NOrOjRMcVtyXDkuz24KA==
X-Received: by 2002:a05:6a00:1581:b0:68b:4e07:133f with SMTP id u1-20020a056a00158100b0068b4e07133fmr11754218pfk.7.1692977158301;
        Fri, 25 Aug 2023 08:25:58 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:a7ba:1788:3b00:4316])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b006879493aca0sm1701748pfn.26.2023.08.25.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:25:57 -0700 (PDT)
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
Subject: [PATCH v2 3/4] perf tools: Convert to perf_record_header_attr_id()
Date:   Fri, 25 Aug 2023 08:25:51 -0700
Message-ID: <20230825152552.112913-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230825152552.112913-1-namhyung@kernel.org>
References: <20230825152552.112913-1-namhyung@kernel.org>
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

Instead of accessing the attr.id directly, use the
perf_record_header_attr_id() helper to handle old versions.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/header.c           | 2 +-
 tools/perf/util/session.c          | 4 ++--
 tools/perf/util/synthetic-events.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f89321cbfdee..63967c34157d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4408,7 +4408,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 	if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
 		return -ENOMEM;
 
-	ids = (void *)&event->attr.attr + event->attr.attr.size;
+	ids = perf_record_header_attr_id(event);
 	for (i = 0; i < n_ids; i++) {
 		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ids[i]);
 	}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 00d18c74c090..1e9aa8ed15b6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -833,8 +833,8 @@ static void perf_event__hdr_attr_swap(union perf_event *event,
 	perf_event__attr_swap(&event->attr.attr);
 
 	size = event->header.size;
-	size -= (void *)&event->attr.id - (void *)event;
-	mem_bswap_64(event->attr.id, size);
+	size -= perf_record_header_attr_id(event) - (void *)event;
+	mem_bswap_64(perf_record_header_attr_id(event), size);
 }
 
 static void perf_event__event_update_swap(union perf_event *event,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 45714a2785fd..a0579c7d7b9e 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2145,7 +2145,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool, struct perf_event_attr *
 		return -ENOMEM;
 
 	ev->attr.attr = *attr;
-	memcpy(ev->attr.id, id, ids * sizeof(u64));
+	memcpy(perf_record_header_attr_id(ev), id, ids * sizeof(u64));
 
 	ev->attr.header.type = PERF_RECORD_HEADER_ATTR;
 	ev->attr.header.size = (u16)size;
-- 
2.42.0.rc1.204.g551eb34607-goog

