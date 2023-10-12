Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45C7C6379
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377453AbjJLDxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377237AbjJLDw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78D3185;
        Wed, 11 Oct 2023 20:51:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c871a095ceso4550015ad.2;
        Wed, 11 Oct 2023 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082697; x=1697687497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/1w/NdKs766XcCtqpVuOkRbnXHH9DRAZo4m/CjTbtY=;
        b=krSfokDDOcXRmjVI49Pbu9TJA2twsnhOVjSCVYbBQ8Ipanev75JKldUyeiYK+qS4ch
         ECg2X2LhaEy3G0jiJNIEcY94brRUryhQ8NoZu/2thEVSh3/zv3hTyRlB2/aWkdfKcDFC
         dZRHDUAgYA8rNjiuh3/pA2HKHH1TR1guW/p9r/QtpC0rsV2wKMhtyTF4QIcg/bgoIh0V
         M55pJNfGLA+71jCejUVctsBhQLFaO7RojvES9EiechX9cr82GBvjQUxcR9Hc89aZgvt1
         xxjmPjUdqYYQ++rF3OlbmIjPJcRW4uQa9WZA18R+mQcWGgAL7Xf4vX3KUh8oeyK3hk5u
         ytIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082697; x=1697687497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/1w/NdKs766XcCtqpVuOkRbnXHH9DRAZo4m/CjTbtY=;
        b=o4Wbtb9DVLa0fxVVxosoBAiT8lKKaw26LmnP4rdKoMfQFM6a4SgLzMOtPOIvF1Hoya
         Rt5mCA+BGWxFxjEloFUU3PPbBMsBX3wtRZeeygngKgls3ZUzAyyEzZ5xONAtlrF7S0Ag
         Soo40h+yfHmttYjHcfgvAJmifRF+I5ekhvHduy+aGLQ/SWGle5PdFrZwWWWlpDHrXafs
         LNLngeWRM+Wt5fCnjGaZr5vPGVyAGgMINqqRxXTjes/hE3HkAaxti8pK0HD5XWw6ZhTJ
         zcZwRM0QFRIZekazXLfDwqYoWC18oFaUFepR6AiaR+6gb3sDRgGY3KGM9O/vVNFcImfe
         LafQ==
X-Gm-Message-State: AOJu0Yxkbzy6Z4pRMrW20q1p6iVaUEVQWNJmwM7GycFZIWx5YZMCDtXr
        2kQq5SI8v7Sow6rfCaFYtO4=
X-Google-Smtp-Source: AGHT+IF2d6T/3yhTEjm5f4jVYkGuQsMM+wvl5SxF88c1ATenxd3apUceICs/gkVGvC3XmEF3vC+oYA==
X-Received: by 2002:a17:902:9a93:b0:1c8:8d9a:49d with SMTP id w19-20020a1709029a9300b001c88d9a049dmr13999009plp.47.1697082697296;
        Wed, 11 Oct 2023 20:51:37 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:36 -0700 (PDT)
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
Subject: [PATCH 17/48] perf annotate-data: Add member field in the data type
Date:   Wed, 11 Oct 2023 20:50:40 -0700
Message-ID: <20231012035111.676789-18-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
 tools/perf/util/annotate-data.c | 106 ++++++++++++++++++++++++++++----
 tools/perf/util/annotate-data.h |  27 ++++++--
 tools/perf/util/sort.c          |   4 +-
 3 files changed, 119 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 3e3a561d73e3..63205506b9fe 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -19,7 +19,10 @@
 
 /* Pseudo data types */
 struct annotated_data_type unknown_type = {
-	.type_name = (char *)"(unknown)",
+	.self = {
+		.type_name = (char *)"(unknown)",
+		.children = LIST_HEAD_INIT(unknown_type.self.children),
+	},
 };
 
 /*
@@ -35,9 +38,9 @@ static int data_type_cmp(const void *_key, const struct rb_node *node)
 
 	type = rb_entry(node, struct annotated_data_type, node);
 
-	if (key->type_size != type->type_size)
-		return key->type_size - type->type_size;
-	return strcmp(key->type_name, type->type_name);
+	if (key->self.size != type->self.size)
+		return key->self.size - type->self.size;
+	return strcmp(key->self.type_name, type->self.type_name);
 }
 
 static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
@@ -47,9 +50,80 @@ static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
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
@@ -69,8 +143,8 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	dwarf_aggregate_size(type_die, &size);
 
 	/* Check existing nodes in dso->data_types tree */
-	key.type_name = type_name;
-	key.type_size = size;
+	key.self.type_name = type_name;
+	key.self.size = size;
 	node = rb_find(&key, &dso->data_types, data_type_cmp);
 	if (node) {
 		result = rb_entry(node, struct annotated_data_type, node);
@@ -85,8 +159,15 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
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
@@ -237,7 +318,8 @@ void annotated_data_type__tree_delete(struct rb_root *root)
 
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
index c79564c1d5df..01300831333e 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2166,7 +2166,7 @@ sort__type_collapse(struct hist_entry *left, struct hist_entry *right)
 		right_type = right->mem_type;
 	}
 
-	return strcmp(left_type->type_name, right_type->type_name);
+	return strcmp(left_type->self.type_name, right_type->self.type_name);
 }
 
 static int64_t
@@ -2178,7 +2178,7 @@ sort__type_sort(struct hist_entry *left, struct hist_entry *right)
 static int hist_entry__type_snprintf(struct hist_entry *he, char *bf,
 				     size_t size, unsigned int width)
 {
-	return repsep_snprintf(bf, size, "%-*s", width, he->mem_type->type_name);
+	return repsep_snprintf(bf, size, "%-*s", width, he->mem_type->self.type_name);
 }
 
 struct sort_entry sort_type = {
-- 
2.42.0.655.g421f12c284-goog

