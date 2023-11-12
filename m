Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1753F7E8EE7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 08:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjKLHQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 02:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 02:16:08 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD8A2D54;
        Sat, 11 Nov 2023 23:16:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2802c41b716so2880281a91.1;
        Sat, 11 Nov 2023 23:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699773364; x=1700378164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gop7WM26jCIuZ6HhuXXtjpUt3mNf1DilLo5pNYto5PI=;
        b=HKaUUwFVtAmS3dpLSI2qfbHt5ejM68wuTw6Sy52mv0O1bNFKO9PQApC8NSV/STqfaE
         xjoKp7Zm9rGRbhHeEak2tQ6nXC3FW3AJt9n4xrVGijWeFoWamHLL9M33H8/H7kLxBCu9
         TUnnakQ6461Jd4xSpU03dFhqnIFHIUR/VlvmRTmwTEDyzdQ2gBraZAsT2BwDV3rGBBOp
         CJBT80swA/77/QN0Tlu7jNsHYbRp0J2t2+zcdYW1cHAqMSQQ2owdavPyIlYpGLaw2YIK
         mPZ0O/tfh0xqz2NhbMNZyNuXEyX1F8ZBAodYXm52JSxy2JZVtxcIa8UQ0gChrSJqlErJ
         W7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699773364; x=1700378164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gop7WM26jCIuZ6HhuXXtjpUt3mNf1DilLo5pNYto5PI=;
        b=LmTjTP9o46K/ZdLqkgVlOhq8ccqh0n83RAXSBek1JJTq4f6x9GRkqIFPo+oRMXxdLA
         RKKKCiD7N46BhCZmPAfnjp2OHDFy0fCqUFdHMtNyXCG8JnM4xnDbrBzEWyhtOncr1ose
         R1L2r1QqcLUoU6y3dF1WqliaiIZ5QWA4WqYL9W1TEaUXatacBO+omOGDEKe27L0GnuK7
         JkKpsDkti0jCda0rRqke6YI0pBG4UlEnqdF9LokA12N3taCfLrFNS3GJHP5ReSvgAeQs
         syCwzXfHj8Smg60mpOMrjLl6ZujCRcxlq5L/yDdG1JJTR8Pw0m2LZ2TKGmUJDnUgxhj5
         9sWw==
X-Gm-Message-State: AOJu0YyYAKYuoEuOPNbzWNiv3EdsAInMlt0p8N7ONvKCjHQkW+ZJf2n7
        pmLIJHti88gtcjaPUrawwZw=
X-Google-Smtp-Source: AGHT+IFVfFgHSLI6DErH8Pen00pHogOVowf1UHo4ZLwbRQP3JHyUwflp7/oqzeGZ0ESTvUczOQlFpg==
X-Received: by 2002:a05:6a20:7faa:b0:184:26d8:cf5c with SMTP id d42-20020a056a207faa00b0018426d8cf5cmr2900849pzj.0.1699773363488;
        Sat, 11 Nov 2023 23:16:03 -0800 (PST)
Received: from DESKTOP-NK4TH6S.localdomain ([220.72.86.232])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b001bc930d4517sm2190987plg.42.2023.11.11.23.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 23:16:01 -0800 (PST)
From:   Paran Lee <p4ranlee@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        shjy180909@gmail.com, austindh.kim@gmail.com, honggyu.kp@gmail.com,
        Paran Lee <p4ranlee@gmail.com>
Subject: [PATCH] perf script python: Fail check on dynamic allocation.
Date:   Sun, 12 Nov 2023 16:14:47 +0900
Message-Id: <20231112071446.7811-1-p4ranlee@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is Ommitted PyList_New() Fail check
and set_regs_in_dict(), python_start_script()
dynamic allocation checking.

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 .../scripting-engines/trace-event-python.c     | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 94312741443a..0847c50d4601 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -353,6 +353,8 @@ static PyObject *get_field_numeric_entry(struct tep_event *event,
 
 	if (is_array) {
 		list = PyList_New(field->arraylen);
+		if (!list)
+			Py_FatalError("couldn't create Python list");
 		item_size = field->size / field->arraylen;
 		n_items = field->arraylen;
 	} else {
@@ -754,7 +756,7 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
 	}
 }
 
-static void set_regs_in_dict(PyObject *dict,
+static int set_regs_in_dict(PyObject *dict,
 			     struct perf_sample *sample,
 			     struct evsel *evsel)
 {
@@ -770,6 +772,9 @@ static void set_regs_in_dict(PyObject *dict,
 	 */
 	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
 	char *bf = malloc(size);
+	if (!bf)
+		return -1;
+	}
 
 	regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, size);
 
@@ -781,6 +786,8 @@ static void set_regs_in_dict(PyObject *dict,
 	pydict_set_item_string_decref(dict, "uregs",
 			_PyUnicode_FromString(bf));
 	free(bf);
+
+	return 0;
 }
 
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
@@ -920,7 +927,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
 	}
 
-	set_regs_in_dict(dict, sample, evsel);
+	if (!set_regs_in_dict(dict, sample, evsel))
+		Py_FatalError("Failed to setting regs in dict");
 
 	return dict;
 }
@@ -1918,12 +1926,18 @@ static int python_start_script(const char *script, int argc, const char **argv,
 	scripting_context->session = session;
 #if PY_MAJOR_VERSION < 3
 	command_line = malloc((argc + 1) * sizeof(const char *));
+	if(!command_line) {
+		return -1;
+	}
 	command_line[0] = script;
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = argv[i - 1];
 	PyImport_AppendInittab(name, initperf_trace_context);
 #else
 	command_line = malloc((argc + 1) * sizeof(wchar_t *));
+	if(!command_line) {
+		return -1;
+	}
 	command_line[0] = Py_DecodeLocale(script, NULL);
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);
-- 
2.25.1

