Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11A680FC12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377749AbjLMAN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjLMANW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:13:22 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CED92;
        Tue, 12 Dec 2023 16:13:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28ad44e5d5aso834353a91.3;
        Tue, 12 Dec 2023 16:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426408; x=1703031208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG5uhH6+vrhrt8eFk+mi+3iC/XTE/ZNynaN3tsBSr8c=;
        b=fS+oYds8KN2olU1eUM/RQgGaaU3g6FSgRAJ7Vh2kHCJGnCdQ1krBSVwXn/p2Didg55
         fAtrgvCuw2GuEGFga0W20xdoqM7HO29vnL6kNAwNv+JYLs4p3bVvZtl+bKb3XOq7EvN8
         13XEYn/gF3zTWjBj6xUlz336yg9LdXV5pXDiGMDl+w17FLjSEcqjCM/R04tvDXiKGUoL
         ofSMdVXS9wyk1nImv2pLFKLcKEHuhkLTAd9A5/rxsM0qCIkcIWP6lB05XZcOfRR5vZpD
         jecYzl7J+/SPGXPg1UmcKSJ8kiSoZEvt/ctfmek7LhhVYDu2FWq3W41/ANVF6FnMljrl
         ZOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426408; x=1703031208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lG5uhH6+vrhrt8eFk+mi+3iC/XTE/ZNynaN3tsBSr8c=;
        b=QT225El6+mVi1oyYJkdqtFTHk0bsP09FUBXFsXtpvdjzzr+8iEPUzOHMRdZc5D1WpX
         sh8NNOhCAuZsQOYUt+lQ/9eALTMPeu9++9Im3aFQSxYyTjEtgFnChDNHg8AatxpBcKNo
         9BEKg4qmmMlGWy1g5aqewayp5VGvwvWee1wN9sqLv8PIz0OPGILb7ZCQ1L/S61Y6+kYt
         ufm8tEK1FZmy59j4X5i3SFH3HB4hRij3yPiOlA0TtASO4DVkzDH92D21YMS7lSewc29v
         cPN2A6FP6Rlt0iIcrw8nFVQHXrIdWI9nbVMTkDnVv22s5Yzu8sFcHn/OztG/hK3MHFcF
         +Kjw==
X-Gm-Message-State: AOJu0Yy0Q4HNmFHPfYbI04jqqKceuqq/WjBe1+WP4+ENJMTUcExI5t+V
        rgV8pqyuR6NqqWwJ+lErelU=
X-Google-Smtp-Source: AGHT+IHTA0FcHf41HpX86cu/kMoU8JzP9CdC51uGuAStlcn8QS7QkMFa2VxqMhixXwXv/2MmrrLzMQ==
X-Received: by 2002:a17:90b:1213:b0:286:f16c:caff with SMTP id gl19-20020a17090b121300b00286f16ccaffmr5449689pjb.33.1702426407843;
        Tue, 12 Dec 2023 16:13:27 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:27 -0800 (PST)
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
Subject: [PATCH 01/17] perf dwarf-aux: Factor out die_get_typename_from_type()
Date:   Tue, 12 Dec 2023 16:13:07 -0800
Message-ID: <20231213001323.718046-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213001323.718046-1-namhyung@kernel.org>
References: <20231213001323.718046-1-namhyung@kernel.org>
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

The die_get_typename_from_type() is to get the name of the given DIE in
C-style type name.  The difference from the die_get_typename() is that
it does not retrieve the DW_AT_type and use the given DIE directly.
This will be used when users know the type DIE already.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 38 ++++++++++++++++++++++++++-----------
 tools/perf/util/dwarf-aux.h |  3 +++
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index edd9e407bc74..7aa5fee0da19 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1051,32 +1051,28 @@ Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
 }
 
 /**
- * die_get_typename - Get the name of given variable DIE
- * @vr_die: a variable DIE
+ * die_get_typename_from_type - Get the name of given type DIE
+ * @type_die: a type DIE
  * @buf: a strbuf for result type name
  *
- * Get the name of @vr_die and stores it to @buf. Return 0 if succeeded.
+ * Get the name of @type_die and stores it to @buf. Return 0 if succeeded.
  * and Return -ENOENT if failed to find type name.
  * Note that the result will stores typedef name if possible, and stores
  * "*(function_type)" if the type is a function pointer.
  */
-int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
+int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
 {
-	Dwarf_Die type;
 	int tag, ret;
 	const char *tmp = "";
 
-	if (__die_get_real_type(vr_die, &type) == NULL)
-		return -ENOENT;
-
-	tag = dwarf_tag(&type);
+	tag = dwarf_tag(type_die);
 	if (tag == DW_TAG_array_type || tag == DW_TAG_pointer_type)
 		tmp = "*";
 	else if (tag == DW_TAG_subroutine_type) {
 		/* Function pointer */
 		return strbuf_add(buf, "(function_type)", 15);
 	} else {
-		const char *name = dwarf_diename(&type);
+		const char *name = dwarf_diename(type_die);
 
 		if (tag == DW_TAG_union_type)
 			tmp = "union ";
@@ -1089,7 +1085,7 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
 		/* Write a base name */
 		return strbuf_addf(buf, "%s%s", tmp, name ?: "");
 	}
-	ret = die_get_typename(&type, buf);
+	ret = die_get_typename(type_die, buf);
 	if (ret < 0) {
 		/* void pointer has no type attribute */
 		if (tag == DW_TAG_pointer_type && ret == -ENOENT)
@@ -1100,6 +1096,26 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
 	return strbuf_addstr(buf, tmp);
 }
 
+/**
+ * die_get_typename - Get the name of given variable DIE
+ * @vr_die: a variable DIE
+ * @buf: a strbuf for result type name
+ *
+ * Get the name of @vr_die and stores it to @buf. Return 0 if succeeded.
+ * and Return -ENOENT if failed to find type name.
+ * Note that the result will stores typedef name if possible, and stores
+ * "*(function_type)" if the type is a function pointer.
+ */
+int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
+{
+	Dwarf_Die type;
+
+	if (__die_get_real_type(vr_die, &type) == NULL)
+		return -ENOENT;
+
+	return die_get_typename_from_type(&type, buf);
+}
+
 /**
  * die_get_varname - Get the name and type of given variable DIE
  * @vr_die: a variable DIE
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 0ddf61fd3f8b..4e64caac6df8 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -116,6 +116,9 @@ Dwarf_Die *die_find_variable_at(Dwarf_Die *sp_die, const char *name,
 Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
 			   Dwarf_Die *die_mem);
 
+/* Get the name of given type DIE */
+int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf);
+
 /* Get the name of given variable DIE */
 int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf);
 
-- 
2.43.0.472.g3155946c3a-goog

