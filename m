Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BBB7F0449
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 05:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjKSENN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 23:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKSENM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 23:13:12 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77463182;
        Sat, 18 Nov 2023 20:13:07 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2ea7cca04so2275973b6e.2;
        Sat, 18 Nov 2023 20:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700367187; x=1700971987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOgwgaiftsipEDq0IwhuZKtoSJ1SnhGvWaa7wLnN7nQ=;
        b=SPJuJR8x2NUhyeYcq97FMH9GqKa1kE93ufqZWHJ4HQvf91fOqxdMUeGOnz0wsQO2DN
         i3DRPoaIwlPdKvZOb59HOr9lJCqrmnJ1Ye7YYPEJZrBK55olobz5hlZ4Ap4Lg9wyMzO7
         QZ+ASbZIRQhgqL2Du1PonqHTuUYaB5al9Rqe8gxOMnSyE93qVhc/+ZDgP07sjUkRtD8t
         KN8j2fojLijKH3ZsXlQBm0GsxJqXpyR6bgWXNX4KBo6sgaHqZidYtfpgXWrT+vj2pBbg
         vor2S6HH3kX3CoBs3iRvlvkxIo7HEhObU2ylu7YPLDPiXfSPgQXjktLG/qqyIQCaayM4
         Tl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700367187; x=1700971987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOgwgaiftsipEDq0IwhuZKtoSJ1SnhGvWaa7wLnN7nQ=;
        b=afabjw/Tj/ckQcT92Dq8cbB97mI980S7zCpgQoeQOXPkAlWKJfwfRK59u9nPPOCFe1
         L6getlR7Zc4Rb9AmUltC39ifHzyshb/yqgwGT6zlqPgFQgHs4uawUfxeKEJ94w/Oz0Ky
         /tgvPi2qnu3d6jirt2EBZj2oTOyhcpaukdhdU/YmExlVJaAJizqaeqxkOeb0swy/LwLz
         baQIZAaV/yjR1xvHuhpXjZjuiOMpsrDQIF6R/KCD+fa3nT3AGtMfUkOY6wfudu44e18R
         eY9Q5Sg9Z3WSREj2JRiYgW/xGN51nXGvsFlzri0NGQPIWkP+kA/t3lwpuB1Uh9AypzMM
         j8UQ==
X-Gm-Message-State: AOJu0YwIuAUEB5bp83yuERWW1BmImUd0YbLTsoCwWo+kEPbaMi/cA58m
        sU2WTRbVR9/i6BQPYD2y+cw=
X-Google-Smtp-Source: AGHT+IHA73OATWMatatsNAiauzxenxDWV/aT0yxMPKEdQiv5iFqhWZKrpLfzT0g1Pcqt+7oMk+VkBg==
X-Received: by 2002:a05:6808:1410:b0:3b2:e536:a442 with SMTP id w16-20020a056808141000b003b2e536a442mr5993983oiv.16.1700367186570;
        Sat, 18 Nov 2023 20:13:06 -0800 (PST)
Received: from DESKTOP-NK4TH6S.localdomain ([220.72.86.144])
        by smtp.gmail.com with ESMTPSA id it18-20020a056a00459200b006c6f668c90bsm3724360pfb.134.2023.11.18.20.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 20:13:06 -0800 (PST)
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
Subject: [PATCH V2] perf script python: Fail check on dynamic allocation
Date:   Sun, 19 Nov 2023 13:09:44 +0900
Message-Id: <20231119040943.13500-1-p4ranlee@gmail.com>
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

Add PyList_New() Fail check in
get_field_numeric_entry() function
and dynamic allocation checking for
set_regs_in_dict(), python_start_script().

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
Reviewed-by: Seonghee Jin<shjy180909@gmail.com>
---
 .../util/scripting-engines/trace-event-python.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 94312741443a..f96968ba371f 100644
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
@@ -770,6 +772,8 @@ static void set_regs_in_dict(PyObject *dict,
 	 */
 	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
 	char *bf = malloc(size);
+	if (!bf)
+		return -1;
 
 	regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, size);
 
@@ -781,6 +785,8 @@ static void set_regs_in_dict(PyObject *dict,
 	pydict_set_item_string_decref(dict, "uregs",
 			_PyUnicode_FromString(bf));
 	free(bf);
+
+	return 0;
 }
 
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
@@ -920,7 +926,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
 	}
 
-	set_regs_in_dict(dict, sample, evsel);
+	if (!set_regs_in_dict(dict, sample, evsel))
+		Py_FatalError("Failed to setting regs in dict");
 
 	return dict;
 }
@@ -1918,12 +1925,18 @@ static int python_start_script(const char *script, int argc, const char **argv,
 	scripting_context->session = session;
 #if PY_MAJOR_VERSION < 3
 	command_line = malloc((argc + 1) * sizeof(const char *));
+	if (!command_line)
+		return -1;
+
 	command_line[0] = script;
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = argv[i - 1];
 	PyImport_AppendInittab(name, initperf_trace_context);
 #else
 	command_line = malloc((argc + 1) * sizeof(wchar_t *));
+	if (!command_line)
+		return -1;
+
 	command_line[0] = Py_DecodeLocale(script, NULL);
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);
-- 
2.25.1

