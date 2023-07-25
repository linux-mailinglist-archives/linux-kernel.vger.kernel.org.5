Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2337603C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjGYATm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjGYATj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:19:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F1B115;
        Mon, 24 Jul 2023 17:19:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-668704a5b5bso4634042b3a.0;
        Mon, 24 Jul 2023 17:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690244378; x=1690849178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur/5UIDBgXwG6Jd780Yg5waMFnc/eDxnmfp27sGRL7Y=;
        b=UV8wFxFPlSwyHsXrydC1BGttSUD8lOYHmBhZvhaf/T2014SOsJQLM4SFjYjxITN3Ei
         /d5uvS56wDOZAdMe9C3XDtvK1JYm22RTo5uN3bZmmiFQmwD6cYOu8wMhXLdP+EqxDzke
         A1e3A2tm2INM9SnAGh559S/O2gfw6jmkTf/+LzwStrt14aXD2lmOO6cY43yujd/CJdiY
         3zEVSjNS2nn68dMVK7gutTTViD9b15P7Jp7KVh0Fb9sk0o6/43VeTXyfGP1Op4MYx+Fg
         FNUnz1SanvO5enx9h3MDiX/BlWnqBIFUjI27Bz92yBRh/UGMK0M7ppyRcP/xK2YE8mzI
         iyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690244378; x=1690849178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ur/5UIDBgXwG6Jd780Yg5waMFnc/eDxnmfp27sGRL7Y=;
        b=RjvTSt5jE0qxOEsFVOAX65WQhNtUGE6WvMl0ieosHM1mpLVzzY7OV5dGxmGzrh8IGN
         P4+ApawiI2l67fSWPK4vJUg1zBXxIh31vE9lItCeiCD/ER3i4lwtpQxSGrTLq9gFVZn+
         IRfzTMBvHV+O5G7CTw0yQ+YB1/em62d1EslVo4so0eTOtub2n4qfdCC2DPfxVI7Tlx5k
         uuITqJbzg/j47uiGf5dWOHUtUJ/UN1zyreov6I24xF98W1XSpwPLjQVNc9sBHcWq2HaA
         piKAdWWi+Vt+wL7CmzuygzcwjETRkzjrUV0dHlAYcO0Qq1I2kJEvQ06PeBhgYMYnNZEe
         Ub8w==
X-Gm-Message-State: ABy/qLbpXAydVz+XoCgJ8UzzrO8iD6wRwMkyCgKNd4fQpRgZNfuoDLpS
        qxqVjkc1/rDfjgBMYdwaaJo=
X-Google-Smtp-Source: APBJJlE0zu9xQr1b0Yyk1rWyWtZRdcIrob1s3mfM+a0+bLXLjgA2N8iULbEgxbjKaZhnSnITG9QZqw==
X-Received: by 2002:a05:6a00:14c4:b0:675:8f71:28ee with SMTP id w4-20020a056a0014c400b006758f7128eemr13956213pfu.34.1690244378333;
        Mon, 24 Jul 2023 17:19:38 -0700 (PDT)
Received: from bangji.roam.corp.google.com ([101.235.25.38])
        by smtp.gmail.com with ESMTPSA id i22-20020aa787d6000000b006736bce8581sm8602432pfo.16.2023.07.24.17.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 17:19:37 -0700 (PDT)
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
Subject: [PATCH v2 2/2] perf machine: Include data symbols in the kernel map
Date:   Mon, 24 Jul 2023 17:19:29 -0700
Message-ID: <20230725001929.368041-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725001929.368041-1-namhyung@kernel.org>
References: <20230725001929.368041-1-namhyung@kernel.org>
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

When perf record -d is used, it needs data mmaps to symbolize global data.
But it missed to collect kernel data maps so it cannot symbolize them.
Instead of having a separate map, just increase the kernel map size to
include the data section.

Probably we can have a separate kernel map for data, but the current
code assumes a single kernel map.  So it'd require more changes in other
places and looks error-prone.  I decided not to go that way for now.

Also it seems the kernel module size already includes the data section.

For example, my system has the following.

  $ grep -e _stext -e _etext -e _edata /proc/kallsyms
  ffffffff99800000 T _stext
  ffffffff9a601ac8 T _etext
  ffffffff9b446a00 D _edata

Size of the text section is (0x9a601ac8 - 0x99800000 = 0xe01ac8) and
size including data section is (0x9b446a00 - 0x99800000 = 0x1c46a00).

Before:
  $ perf record -d true

  $ perf report -D | grep MMAP | head -1
  0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0xe01ac8) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
                                                               ^^^^^^^^
                                                                 here
After:
  $ perf report -D | grep MMAP | head -1
  0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0x1c46a00) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
                                                               ^^^^^^^^^

Instead of just replacing it to _edata, try _edata first and then fall
back to _etext just in case.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 4e62843d51b7..11de3ca8d4fa 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1216,7 +1216,9 @@ static int machine__get_running_kernel_start(struct machine *machine,
 
 	*start = addr;
 
-	err = kallsyms__get_function_start(filename, "_etext", &addr);
+	err = kallsyms__get_symbol_start(filename, "_edata", &addr);
+	if (err)
+		err = kallsyms__get_function_start(filename, "_etext", &addr);
 	if (!err)
 		*end = addr;
 
-- 
2.41.0.487.g6d72f3e995-goog

