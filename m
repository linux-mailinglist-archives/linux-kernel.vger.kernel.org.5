Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEB681064E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378092AbjLMAOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377920AbjLMAOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:14:00 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2D0F2;
        Tue, 12 Dec 2023 16:13:45 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d4e557c4bso27947495ab.0;
        Tue, 12 Dec 2023 16:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426424; x=1703031224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LlEZ9GnF4AN+GzvPvQSgw+KzjsL2hLZSHT6H7XrNW4=;
        b=GA3QAx3s4stc+uMThLDL7IOsmeKHXzlOeDn1yZ2W/Fi2mvwqtiLREBJdcBAC0KaLuN
         9Y5rlcw3D6ADK6GfvIyZcvhbOK4X4b9zLqTXnJALIaVDOAuiLZrMHKzJ7gB6Hj00ndIk
         ZtCoSdVPogoNR+K0owcLqSqZAGMfEPvQwdmT7o2D8ixpPVCI4gYOQQF+QH3WgytI0DHB
         bOpVTDfSe6Pk36Y+pN6AERI912hlWx2Aa5IdAqL+F+0lgu/7BXNz5McooQFf7xgDsdYb
         Akj5gJL6jDkFbHneke4qL7JaazO4fNTGfT6QcFVPQ0BS6Pj2qe6YdnNmqTZ9jvc4otSh
         W7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426424; x=1703031224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9LlEZ9GnF4AN+GzvPvQSgw+KzjsL2hLZSHT6H7XrNW4=;
        b=O/ZmMphXMoscAGLBjN515G8rgLidGbn1jnYTHeSVNDnpBzz1qkB8qcl6fNSuS5p/7H
         dpuFKS8k4cRDNuRzAr5wZcGoJ+RSqgkpteXbv4MlwDS9Ijl7zABpx230CKeIj93E4Lgb
         qaY5r506/ztNrLM0c1ntUpAe3Csb8gTSvihOVbg+Z/VArDQvTQr7vGPLrk9CLzW4zyja
         LEGc4x+JmOl/woB34van9LHng6ZcuZluAFrPrHtPoeEedf69n2XZxcQW1QKP+vapSL1e
         RfpYr2GEPZeCLdKcVPnNIJDH8gbRhZLwr3JgXKOApBNw2gHGaFKs+F/0Fjm6GsOk4dYk
         V2QQ==
X-Gm-Message-State: AOJu0YyfAin6hl87PmK2dqJ3d6+CXEkS5eC6SIOPgVTkAsr8xORTHwnX
        PTC+uUGMR7Yy3ZE4+P7Q5g0=
X-Google-Smtp-Source: AGHT+IFKHnYclCb5Lb9JWGVnsBBK4dcNEeThwFt8YIeksCqeoGJjwcXHmipUDm/1z85iK1bwJZRlFg==
X-Received: by 2002:a92:cd8f:0:b0:35d:5d53:eae8 with SMTP id r15-20020a92cd8f000000b0035d5d53eae8mr10149508ilb.62.1702426424202;
        Tue, 12 Dec 2023 16:13:44 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:43 -0800 (PST)
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
Subject: [PATCH 10/17] perf annotate-data: Add member field in the data type
Date:   Tue, 12 Dec 2023 16:13:16 -0800
Message-ID: <20231213001323.718046-11-namhyung@kernel.org>
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

Add child member field if the current type is a composite type like a
struct or union.  The member fields are linked in the children list
and do the same recursively if the child itself is a composite type.
Add 'self' member to the annotated_data_type to handle the members in
the same way.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 101 ++++++++++++++++++++++++++++----
 tools/perf/util/annotate-data.h |  27 +++++++--
 tools/perf/util/sort.c          |   9 ++-
 3 files changed, 119 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index c9c359b4d4ad..d9c63e989b6e 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -30,9 +30,9 @@ static int data_type_cmp(const void *_key, const struct rb_node *node)
 
 	type = rb_entry(node, struct annotated_data_type, node);
 
-	if (key->type_size != type->type_size)
-		return key->type_size - type->type_size;
-	return strcmp(key->type_name, type->type_name);
+	if (key->self.size != type->self.size)
+		return key->self.size - type->self.size;
+	return strcmp(key->self.type_name, type->self.type_name);
 }
 
 static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
@@ -42,9 +42,80 @@ static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
 	a = rb_entry(node_a, struct annotated_data_type, node);
 	b = rb_entry(node_b, struct annotated_data_type, node);
 
-	if (a->type_size != b->type_size)
-		return a->type_size < b->type_size;
-	return strcmp(a->type_name, b->type_name) < 0;
+	if (a->self.size != b->self.size)
+		return a->self.size < b->self.size;
+	return strcmp(a->self.type_name, b->self.type_name) < 0;
+}
+
+/* Recursively add new members for struct/union */
+static int __add_member_cb(Dwarf_Die *die, void *arg)
+{
+	struct annotated_member *parent = arg;
+	struct annotated_member *member;
+	Dwarf_Die member_type, die_mem;
+	Dwarf_Word size, loc;
+	Dwarf_Attribute attr;
+	struct strbuf sb;
+	int tag;
+
+	if (dwarf_tag(die) != DW_TAG_member)
+		return DIE_FIND_CB_SIBLING;
+
+	member = zalloc(sizeof(*member));
+	if (member == NULL)
+		return DIE_FIND_CB_END;
+
+	strbuf_init(&sb, 32);
+	die_get_typename(die, &sb);
+
+	die_get_real_type(die, &member_type);
+	if (dwarf_aggregate_size(&member_type, &size) < 0)
+		size = 0;
+
+	if (!dwarf_attr_integrate(die, DW_AT_data_member_location, &attr))
+		loc = 0;
+	else
+		dwarf_formudata(&attr, &loc);
+
+	member->type_name = strbuf_detach(&sb, NULL);
+	/* member->var_name can be NULL */
+	if (dwarf_diename(die))
+		member->var_name = strdup(dwarf_diename(die));
+	member->size = size;
+	member->offset = loc + parent->offset;
+	INIT_LIST_HEAD(&member->children);
+	list_add_tail(&member->node, &parent->children);
+
+	tag = dwarf_tag(&member_type);
+	switch (tag) {
+	case DW_TAG_structure_type:
+	case DW_TAG_union_type:
+		die_find_child(&member_type, __add_member_cb, member, &die_mem);
+		break;
+	default:
+		break;
+	}
+	return DIE_FIND_CB_SIBLING;
+}
+
+static void add_member_types(struct annotated_data_type *parent, Dwarf_Die *type)
+{
+	Dwarf_Die die_mem;
+
+	die_find_child(type, __add_member_cb, &parent->self, &die_mem);
+}
+
+static void delete_members(struct annotated_member *member)
+{
+	struct annotated_member *child, *tmp;
+
+	list_for_each_entry_safe(child, tmp, &member->children, node) {
+		list_del(&child->node);
+		delete_members(child);
+		free(child->type_name);
+		free(child->var_name);
+		free(child);
+	}
 }
 
 static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
@@ -64,8 +135,8 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	dwarf_aggregate_size(type_die, &size);
 
 	/* Check existing nodes in dso->data_types tree */
-	key.type_name = type_name;
-	key.type_size = size;
+	key.self.type_name = type_name;
+	key.self.size = size;
 	node = rb_find(&key, &dso->data_types, data_type_cmp);
 	if (node) {
 		result = rb_entry(node, struct annotated_data_type, node);
@@ -80,8 +151,15 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 		return NULL;
 	}
 
-	result->type_name = type_name;
-	result->type_size = size;
+	result->self.type_name = type_name;
+	result->self.size = size;
+	INIT_LIST_HEAD(&result->self.children);
+
+	/*
+	 * Fill member info unconditionally for now,
+	 * later perf annotate would need it.
+	 */
+	add_member_types(result, type_die);
 
 	rb_add(&result->node, &dso->data_types, data_type_less);
 	return result;
@@ -232,7 +310,8 @@ void annotated_data_type__tree_delete(struct rb_root *root)
 
 		rb_erase(node, root);
 		pos = rb_entry(node, struct annotated_data_type, node);
-		free(pos->type_name);
+		delete_members(&pos->self);
+		free(pos->self.type_name);
 		free(pos);
 	}
 }
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 6efdd7e21b28..33748222e6aa 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -9,17 +9,36 @@
 
 struct map_symbol;
 
+/**
+ * struct annotated_member - Type of member field
+ * @node: List entry in the parent list
+ * @children: List head for child nodes
+ * @type_name: Name of the member type
+ * @var_name: Name of the member variable
+ * @offset: Offset from the outer data type
+ * @size: Size of the member field
+ *
+ * This represents a member type in a data type.
+ */
+struct annotated_member {
+	struct list_head node;
+	struct list_head children;
+	char *type_name;
+	char *var_name;
+	int offset;
+	int size;
+};
+
 /**
  * struct annotated_data_type - Data type to profile
- * @type_name: Name of the data type
- * @type_size: Size of the data type
+ * @node: RB-tree node for dso->type_tree
+ * @self: Actual type information
  *
  * This represents a data type accessed by samples in the profile data.
  */
 struct annotated_data_type {
 	struct rb_node node;
-	char *type_name;
-	int type_size;
+	struct annotated_member self;
 };
 
 extern struct annotated_data_type unknown_type;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e647f0117bb5..a41209e242ae 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2135,7 +2135,10 @@ struct sort_entry sort_addr = {
 /* --sort type */
 
 struct annotated_data_type unknown_type = {
-	.type_name = (char *)"(unknown)",
+	.self = {
+		.type_name = (char *)"(unknown)",
+		.children = LIST_HEAD_INIT(unknown_type.self.children),
+	},
 };
 
 static int64_t
@@ -2170,7 +2173,7 @@ sort__type_collapse(struct hist_entry *left, struct hist_entry *right)
 		right_type = right->mem_type;
 	}
 
-	return strcmp(left_type->type_name, right_type->type_name);
+	return strcmp(left_type->self.type_name, right_type->self.type_name);
 }
 
 static int64_t
@@ -2182,7 +2185,7 @@ sort__type_sort(struct hist_entry *left, struct hist_entry *right)
 static int hist_entry__type_snprintf(struct hist_entry *he, char *bf,
 				     size_t size, unsigned int width)
 {
-	return repsep_snprintf(bf, size, "%-*s", width, he->mem_type->type_name);
+	return repsep_snprintf(bf, size, "%-*s", width, he->mem_type->self.type_name);
 }
 
 struct sort_entry sort_type = {
-- 
2.43.0.472.g3155946c3a-goog

