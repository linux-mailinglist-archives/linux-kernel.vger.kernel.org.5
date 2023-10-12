Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67EB7C6389
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377184AbjJLDzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347104AbjJLDxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:53:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419F7170F;
        Wed, 11 Oct 2023 20:52:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9b7c234a7so4824385ad.3;
        Wed, 11 Oct 2023 20:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082723; x=1697687523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luk3YMKHP4GBeY8OhFINcROss2mB/uL2Fi/9FHog88E=;
        b=JTNPmJY17mvmWeekp6EbtnHWVBVsqKijrmriYRPO7H93g6CP46HdEsotwkxTaOTgn4
         8nOZ2FEitIOagqfteLV3GG3/th0zm2ZyPPobFJ79tW8vhnkcNkAevkcAkF7wqWd9lUdH
         fzC9Q1PwAek+3t5Av4A8sjUjkeDBOIBhzndgSMRR2wPL0NUnzgwiWZyDA4x/bejWo4qV
         2U/q/CineA/MFqNjLmOR7IUbySKWjGw412JeLsQDlYV7UWtWopeyHFFrInELQDPgwtYV
         fvIFdHSbj4ZZ9ruNjvumN0R6z4/XZJ4L2eyrWB4rk+KdJ/zlJspUPKTny4pTb3w7F3Me
         Rwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082723; x=1697687523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=luk3YMKHP4GBeY8OhFINcROss2mB/uL2Fi/9FHog88E=;
        b=voHCJ+lQZUmZsu/G5ijsbyZHBq3zbCKg2pBRcWtxN/BWeKLQxJFTdOjwJHZC1TcNOt
         do45x/kz8lJFZWeGFE6KcY9yEEpLZg5Md4J8zSdiUX+EYJkpCIMzG+vaOvk1AFbHoVMO
         ev54GT4thKlcMgF9mPLcmeDSdQoHUT62y3wXjMJkYVurwD0orzMpw+vKD02fVozM5ekE
         Hm09vHNbBI9Vv3B8Iebu//xoAFeB3Cw47ylu+9vqXuwgvxK4Orz5W947gFDBD1vZ83bp
         QZPRuqti8WRBMGJJyV79sM01US/eSOUX3Y6+d58eXkhJPO+rQse9HzJQNWjvRoGyonrN
         rGXA==
X-Gm-Message-State: AOJu0YxGEeuVfUCacbpICNKu7ixvg4SMhOg7Qvd5BUassmo5MjPaWGZn
        KSZgOGT4VsSH6529BlHKXPfyy59nYO0=
X-Google-Smtp-Source: AGHT+IEGtcf7HXRETg051KX40JXX4Za2TWn2bJI9mhVghyM9tjR/pC/6W+Oa23Iy4nk6K9fou4X08Q==
X-Received: by 2002:a17:903:228f:b0:1c7:1fbc:b9e7 with SMTP id b15-20020a170903228f00b001c71fbcb9e7mr27350552plh.43.1697082723294;
        Wed, 11 Oct 2023 20:52:03 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:02 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 37/48] perf map: Add map__objdump_2rip()
Date:   Wed, 11 Oct 2023 20:51:00 -0700
Message-ID: <20231012035111.676789-38-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
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

Sometimes we want to convert an address in objdump output to
map-relative address to match with a sample data.  Let's add
map__objdump_2rip() for that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/map.c | 20 ++++++++++++++++++++
 tools/perf/util/map.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index f64b83004421..f25cf664c898 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -595,6 +595,26 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 	return ip + map__reloc(map);
 }
 
+u64 map__objdump_2rip(struct map *map, u64 ip)
+{
+	const struct dso *dso = map__dso(map);
+
+	if (!dso->adjust_symbols)
+		return ip;
+
+	if (dso->rel)
+		return ip + map__pgoff(map);
+
+	/*
+	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
+	 * but all kernel modules are ET_REL, so won't get here.
+	 */
+	if (dso->kernel == DSO_SPACE__USER)
+		return ip - dso->text_offset;
+
+	return map__map_ip(map, ip + map__reloc(map));
+}
+
 bool map__contains_symbol(const struct map *map, const struct symbol *sym)
 {
 	u64 ip = map__unmap_ip(map, sym->start);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 1b53d53adc86..b7bcf0aa3b67 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -129,6 +129,9 @@ u64 map__rip_2objdump(struct map *map, u64 rip);
 /* objdump address -> memory address */
 u64 map__objdump_2mem(struct map *map, u64 ip);
 
+/* objdump address -> rip */
+u64 map__objdump_2rip(struct map *map, u64 ip);
+
 struct symbol;
 struct thread;
 
-- 
2.42.0.655.g421f12c284-goog

