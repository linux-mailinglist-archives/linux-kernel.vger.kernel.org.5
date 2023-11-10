Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24287E7593
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbjKJAEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345735AbjKJADO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:03:14 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44D549CD;
        Thu,  9 Nov 2023 16:01:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28094a3b760so1326053a91.3;
        Thu, 09 Nov 2023 16:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574480; x=1700179280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8QAEj7ZpfAN1FTj9/Rbc4l4YuXZwz+MzirCDbahEG4=;
        b=AN8aGCrGr5kzSpBxetWwxuC7GWWCHC1j8ePkydSrIMLQ9avi1EhEO+1zjIJDikBqJx
         vcJmx9ELsNqvPZMs+7ha5Bt+WMjt9WTWRGF7ekvX8V2GOWVtGFDusGbJ9dv+8EtsaBLt
         Dcz9PE1jvjOzUu7FfijnXlqbtfwOfzMq4meOjkG7/uthVykQb8ffp0loWTncCR+cj3Fw
         3OHua5N2GwnSBDMgq9YeUg0KpYY2fYQcRwUcQTkZmEKTv0F7b7zrChUtdYfgCKMyztUo
         md/ztkyJJEh5DBJ7NkIXNZH/sP9ART9YyC0EkWilVjaKC3joKmXnHkkYNpk0xMnwYphr
         U4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574480; x=1700179280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8QAEj7ZpfAN1FTj9/Rbc4l4YuXZwz+MzirCDbahEG4=;
        b=YEbzJnSQyzyrLzDdwP46+F/8Gzk1yXQIjaUTQ3tzgLGLaUdI9VHtm2ut/PGDDXOb7j
         ldehnbF9TB9bDZmf6EjT76UfsSphxGaHlGoBdWF/QlxflQuKiXNhJiGsCWIYTbRP+iKV
         JYFUoxN5Fu+PdM6b/FR6RhAIXjvoriwSb7mQlZHH/MjSUDY8jn3wRa6NgabEFgE5zVPl
         xua6Zxfnt04xy7TvTjE3Ayn+W1MNB/PepepYsfG7SSY/Fvh2gJBTNM13eNQZfQ6t2Oa6
         Maw9eo5uR+y22/CMddEp/pLJOUwTU5kSRS74D2x+HhfvU6bMQ+I3Ut3leq1wgySIMeeZ
         nrrg==
X-Gm-Message-State: AOJu0Yxx8/P1/EYMGcCofNln9FT9LauXwRsGBzp3mrtS41r0fzOmCqvA
        fC6Gf1b/nlfUGvdoWOiIwv0=
X-Google-Smtp-Source: AGHT+IG2CoWOYMeP6e+QCAuiIg/l0LJpUL0phHQ9IrCQRn5wIuruABY5evY7r+2R0HykGR1mpUp3lw==
X-Received: by 2002:a17:90b:3b88:b0:27d:6b5:9e07 with SMTP id pc8-20020a17090b3b8800b0027d06b59e07mr3255050pjb.1.1699574479929;
        Thu, 09 Nov 2023 16:01:19 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:19 -0800 (PST)
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 41/52] perf map: Add map__objdump_2rip()
Date:   Thu,  9 Nov 2023 16:00:00 -0800
Message-ID: <20231110000012.3538610-42-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.42.0.869.gea05f2083d-goog

