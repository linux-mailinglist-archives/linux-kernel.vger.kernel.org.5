Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5677F2069
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjKTWbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTWbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:31:49 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D320797;
        Mon, 20 Nov 2023 14:31:45 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c398717726so4093714b3a.2;
        Mon, 20 Nov 2023 14:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700519505; x=1701124305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwUXyg7MBmR4xeoVYVivfJ5Bm/G7s4W1J7Z6JZoWHTc=;
        b=MKp4IGfR5ny5B4xEtxTgSYgxX6398lSHdLMSiCKxCHqccRkOclg28ofqqKbIYUqQMj
         FMje+1HrC6iE1KCifk7noWCy1JoLXewuAI21AuM+eKZMA09+cLxMYu8H8gb2fjXjVlMe
         4TlQv1AYvJtvPWxOR9h5V6B2dLoVOjOr6IEXX3FXy3sjyatC88+OtPGJiUFlC7H3GGiF
         kkI4M5dQH33DawJNATPBkpoOfUa3ObbzLCUx5Wl2K1K8gsejpsnSFBH8AA+HYaI5xu/q
         q5CaOFGVKu5wbtOhkEkdlkinn92uh53yKEYGaDnB13fiGpgf3EFzNrypo5UCyARix+Wj
         fwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700519505; x=1701124305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwUXyg7MBmR4xeoVYVivfJ5Bm/G7s4W1J7Z6JZoWHTc=;
        b=soKRUQSQcMD7Ae0mB6DY8p9D4XtXiu3tHMmCxE1pWzlpluxSTatt52KKevdVxMIZus
         g1/wspojAb1gEmKHHHnMtN0HhjDMbktqgjTp74TlLNSudyUjoH+YD9gPhOc1saUAltgA
         ecxM/D2w6A9r+9K2ZbStH7idATr5jl6MnU0Lipv1RRmoqEWwT0eh3GnvsJ1TNdrjxIS4
         Sc0Uo8bzLCeOda7thucCZAYG1rPezMTqApyq5+J8S6kwcPCBP6DTTnnfs95zNCUtH3pD
         e1TkyktpKRHB+xh3uB3V/p/T4TkTxjvZzi7DoeC+W7bq9Mtv/fGOXABxzh8IlR6NpvUM
         5r9g==
X-Gm-Message-State: AOJu0YxE4mai7Al02hAwMaFoYnnkbScxEl0/ctuslXVlaKoxbbcLA9jd
        lT2NXHdEINnDnFCBpK56QZE=
X-Google-Smtp-Source: AGHT+IFz0824EWcEuMS1toXRyWZ/LEEacSZ1N8m+U91pmRtcJFeB50VsKHCpD3RPXxTLBFTz3xFQmg==
X-Received: by 2002:a05:6a00:2908:b0:6be:5367:2131 with SMTP id cg8-20020a056a00290800b006be53672131mr7460789pfb.24.1700519505134;
        Mon, 20 Nov 2023 14:31:45 -0800 (PST)
Received: from DESKTOP-NK4TH6S.localdomain ([220.72.86.144])
        by smtp.gmail.com with ESMTPSA id h7-20020a056a00170700b006cb574445efsm4566141pfc.88.2023.11.20.14.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:31:44 -0800 (PST)
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
Subject: [PATCiH V3] perf script python: Fail check on dynamic allocation
Date:   Tue, 21 Nov 2023 07:26:24 +0900
Message-Id: <20231120222624.2396-1-p4ranlee@gmail.com>
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

Add PyList_New() Fail check in get_field_numeric_entry()
function and dynamic allocation checking for
set_regs_in_dict(), python_start_script().

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
Reviewed-by: MichelleJin <shjy180909@gmail.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/scripting-engines/trace-event-python.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 94312741443a..860e1837ba96 100644
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
+	if (set_regs_in_dict(dict, sample, evsel))
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

