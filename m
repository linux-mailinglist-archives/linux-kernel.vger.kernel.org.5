Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB8B7E756C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345508AbjKJAAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345457AbjKJAAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:37 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3454693;
        Thu,  9 Nov 2023 16:00:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc316ccc38so12752135ad.1;
        Thu, 09 Nov 2023 16:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574425; x=1700179225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVwEgWJomgfw297GtG9OF7+0iUeurVYuT1rqsW67QX0=;
        b=jT9icGVXK2F8It0gtLH//nJbw5IUDqeNUg48nF4zmk4TUiezseWg0YqvDoUiU3kzH5
         DS9mBRtr5UjY060aO2vV67E5Q2uK9EgsDsNOZXJrL7t3PMgumLAIkrbuPrsyfzfp2BS6
         MNuCDfJumf/kQYfckP38Hjcs+ULxCu/7W7PMxnDkQjsZY/4/nPhH/finCj8OYcYB8acn
         kMC/wlkGiLXitMrNio18JutvMgKi3H70WWnYwuwnCebs9DfVTdN8pwQKTtnIWXqhOSv0
         yzVDr8CtqJ9fPFttiSzOYs4eqSCrXLpVuSmXY000nU2JaKfMchHZB0/5AqoORJXx8ulD
         VhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574425; x=1700179225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVwEgWJomgfw297GtG9OF7+0iUeurVYuT1rqsW67QX0=;
        b=sls7f1vIkojZzMreQLOtlThQITd2cJQqZLlhxTMVpsYRs+6c6Az8JmvxMWrX8CB4DE
         HneLMgyA87emyYXjb3cjXHf+7hbFQZ12llV2aDUSWrT9dFJprtl8nd9EjclwuxgnEjKs
         jlHs0YXX9wG0dpHUXxsph9ZAa+jd46dLoHGJIAeIB4QIy5CjOElWY5RR4Jhzh/7AmDi9
         bgb0Tui/rRq0Z3KyYuVcB2TkRNvHvXvXnxfF9vlRf+le4o8nZQbondkVmUDZbikLn/+i
         adXvaYNIyVYtvYS+q8lfepJgl6MGR1Ml5EAN/u7Ej1kFgxlAlF/gJlxWlflWMHTwpFs4
         k2wA==
X-Gm-Message-State: AOJu0YzAXopfdOhcdii+LCtV7FHG7pZqDFCRODwjmGOIT5IVikvGEdoL
        PEy2cdrif9FeZyG4D8euawRsh9CgsUk=
X-Google-Smtp-Source: AGHT+IHa3NPlEkQxndKeHMB+SCA3CAVMa9ywBwXCn4vWfuYRoUSshom/VddDCJBuWbdJNlYkYYWC9g==
X-Received: by 2002:a17:90b:4c47:b0:27d:4f1f:47f5 with SMTP id np7-20020a17090b4c4700b0027d4f1f47f5mr3352933pjb.23.1699574425414;
        Thu, 09 Nov 2023 16:00:25 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:24 -0800 (PST)
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
Subject: [PATCH 06/52] perf dwarf-aux: Add die_get_scopes() helper
Date:   Thu,  9 Nov 2023 15:59:25 -0800
Message-ID: <20231110000012.3538610-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The die_get_scopes() would return the number of enclosing DIEs for the
given address and it fills an array of DIEs like dwarf_getscopes().
But it doesn't follow the abstract origin of inlined functions as we
want information of the concrete instance.  This is needed to check the
location of parameters and local variables properly.  Users can check
the origin separately if needed.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 53 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  3 +++
 2 files changed, 56 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index adef2635587d..10aa32334d6f 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1425,3 +1425,56 @@ void die_skip_prologue(Dwarf_Die *sp_die, Dwarf_Die *cu_die,
 
 	*entrypc = postprologue_addr;
 }
+
+/* Internal parameters for __die_find_scope_cb() */
+struct find_scope_data {
+	/* Target instruction address */
+	Dwarf_Addr pc;
+	/* Number of scopes found [output] */
+	int nr;
+	/* Array of scopes found, 0 for the outermost one. [output] */
+	Dwarf_Die *scopes;
+};
+
+static int __die_find_scope_cb(Dwarf_Die *die_mem, void *arg)
+{
+	struct find_scope_data *data = arg;
+
+	if (dwarf_haspc(die_mem, data->pc)) {
+		Dwarf_Die *tmp;
+
+		tmp = realloc(data->scopes, (data->nr + 1) * sizeof(*tmp));
+		if (tmp == NULL)
+			return DIE_FIND_CB_END;
+
+		memcpy(tmp + data->nr, die_mem, sizeof(*die_mem));
+		data->scopes = tmp;
+		data->nr++;
+		return DIE_FIND_CB_CHILD;
+	}
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_get_scopes - Return a list of scopes including the address
+ * @cu_die: a compile unit DIE
+ * @pc: the address to find
+ * @scopes: the array of DIEs for scopes (result)
+ *
+ * This function does the same as the dwarf_getscopes() but doesn't follow
+ * the origins of inlined functions.  It returns the number of scopes saved
+ * in the @scopes argument.  The outer scope will be saved first (index 0) and
+ * the last one is the innermost scope at the @pc.
+ */
+int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes)
+{
+	struct find_scope_data data = {
+		.pc = pc,
+	};
+	Dwarf_Die die_mem;
+
+	die_find_child(cu_die, __die_find_scope_cb, &data, &die_mem);
+
+	*scopes = data.scopes;
+	return data.nr;
+}
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 4f5d0211ee4f..f9d765f80fb0 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -129,6 +129,9 @@ bool die_is_optimized_target(Dwarf_Die *cu_die);
 void die_skip_prologue(Dwarf_Die *sp_die, Dwarf_Die *cu_die,
 		       Dwarf_Addr *entrypc);
 
+/* Get the list of including scopes */
+int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes);
+
 #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 
 /* Get byte offset range of given variable DIE */
-- 
2.42.0.869.gea05f2083d-goog

