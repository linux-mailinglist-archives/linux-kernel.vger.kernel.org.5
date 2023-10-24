Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E207D5E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbjJXWZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344489AbjJXWYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:24:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4060E1738
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7be940fe1so65244917b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186273; x=1698791073; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=suhDjyVWL4E1hV+3n6FJxzBer/uTQy3hSIxvwlmIybE=;
        b=zCU8CFVJ1mxe9S1kRflGZLVulexeKS1d12mFQacSp2B/pkolQVNZfgAneQSp2wc6zw
         vpEy58qi1Iivguek2u7qnKXofPcWLfXQggQXGr3LzqDLIYOp7TgS6rK4VPwDBzwwuEIG
         8cRQH35fsSO68wxoTdAABhK16E0c6b1TpBz9SK9IxbRk0rV1waNH1mLDeSdT5VEtaUBf
         /vjYg9GvB/EmmJ/sLvCEgdCdoXPDssHCIw9yzUWWFoF4NfZpLAWFCFQYV+EyG7a3mLEd
         aZ0mqsStDXEHowH1sVOSp4VYubJM2QBpXmPMFDFlgBPDCupkSqeecT6bCGDuy/lyFWT+
         cguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186273; x=1698791073;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suhDjyVWL4E1hV+3n6FJxzBer/uTQy3hSIxvwlmIybE=;
        b=OIzLNfbUpEd5jE9vqmQSX7E3dgzDgCKEMGPAoFG6RkfSKqhDRsgOoZgdBEF8I0Adji
         /K46sN5m1/6Fj8rl4OHUtwQqj9yPGvBiMz15z3ro11KKkGJiDnaJvFAyFWzWg31t7qQJ
         ZboVIy20wdbPCyv7SYgx5wd7akfdimnrY+kQXEb7LMeDUmgNbWHNT0mJv3ELJ8CPGY9v
         iE/nYHc0TQpU4WNMBHFVlfB7tlGqmJThEy6AhOGfQgiiYh+jLv1Tmj5LLiawshZuSzSH
         UmK6M4J2X9On6c6mLZcO77/dHThg87jwN1wQq789TFj+UeHsgqGRhHwnIz8Sm4tdxkxN
         qe6A==
X-Gm-Message-State: AOJu0YxtSirmH2Z3o0+Xw5MoBAISSFWF2tf+vZcNkIExkPIpOJIRtkx0
        Q0aFBSMJVLgMGdL0HaFilyx/Zz0ugSKN
X-Google-Smtp-Source: AGHT+IGVq816b1HgY133mLzi3Lvv2j14MwG8ioqBQUVZHwZLLQPUE3bo1r23Y1281rxRikEGIIG9NZXUQqpx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:c7c7:0:b0:da0:433e:871d with SMTP id
 w190-20020a25c7c7000000b00da0433e871dmr54206ybe.7.1698186273164; Tue, 24 Oct
 2023 15:24:33 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:12 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-10-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 09/50] perf callchain: Make brtype_stat in callchain_list optional
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct callchain_list is 352bytes in size, 232 of which are
brtype_stat. brtype_stat is only used for certain callchain_list
items so make it optional, allocating when necessary. So that
printing doesn't need to deal with an optional brtype_stat, pass
an empty/zero version.

Before:
```
struct callchain_list {
        u64                        ip;                   /*     0     8 */
        struct map_symbol          ms;                   /*     8    24 */
        struct {
                _Bool              unfolded;             /*    32     1 */
                _Bool              has_children;         /*    33     1 */
        };                                               /*    32     2 */

        /* XXX 6 bytes hole, try to pack */

        u64                        branch_count;         /*    40     8 */
        u64                        from_count;           /*    48     8 */
        u64                        predicted_count;      /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u64                        abort_count;          /*    64     8 */
        u64                        cycles_count;         /*    72     8 */
        u64                        iter_count;           /*    80     8 */
        u64                        iter_cycles;          /*    88     8 */
        struct branch_type_stat    brtype_stat;          /*    96   232 */
        /* --- cacheline 5 boundary (320 bytes) was 8 bytes ago --- */
        const char  *              srcline;              /*   328     8 */
        struct list_head           list;                 /*   336    16 */

        /* size: 352, cachelines: 6, members: 13 */
        /* sum members: 346, holes: 1, sum holes: 6 */
        /* last cacheline: 32 bytes */
};
```

After:
```
struct callchain_list {
        u64                        ip;                   /*     0     8 */
        struct map_symbol          ms;                   /*     8    24 */
        struct {
                _Bool              unfolded;             /*    32     1 */
                _Bool              has_children;         /*    33     1 */
        };                                               /*    32     2 */

        /* XXX 6 bytes hole, try to pack */

        u64                        branch_count;         /*    40     8 */
        u64                        from_count;           /*    48     8 */
        u64                        predicted_count;      /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u64                        abort_count;          /*    64     8 */
        u64                        cycles_count;         /*    72     8 */
        u64                        iter_count;           /*    80     8 */
        u64                        iter_cycles;          /*    88     8 */
        struct branch_type_stat *  brtype_stat;          /*    96     8 */
        const char  *              srcline;              /*   104     8 */
        struct list_head           list;                 /*   112    16 */

        /* size: 128, cachelines: 2, members: 13 */
        /* sum members: 122, holes: 1, sum holes: 6 */
};
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/callchain.c | 41 +++++++++++++++++++++++++++++--------
 tools/perf/util/callchain.h |  2 +-
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index cde4860e6f28..5349c6a21849 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -586,7 +586,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 		call = zalloc(sizeof(*call));
 		if (!call) {
 			perror("not enough memory for the code path tree");
-			return -1;
+			return -ENOMEM;
 		}
 		call->ip = cursor_node->ip;
 		call->ms = cursor_node->ms;
@@ -602,7 +602,15 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 				 * branch_from is set with value somewhere else
 				 * to imply it's "to" of a branch.
 				 */
-				call->brtype_stat.branch_to = true;
+				if (!call->brtype_stat) {
+					call->brtype_stat = zalloc(sizeof(*call->brtype_stat));
+					if (!call->brtype_stat) {
+						perror("not enough memory for the code path branch statisitcs");
+						free(call->brtype_stat);
+						return -ENOMEM;
+					}
+				}
+				call->brtype_stat->branch_to = true;
 
 				if (cursor_node->branch_flags.predicted)
 					call->predicted_count = 1;
@@ -610,7 +618,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 				if (cursor_node->branch_flags.abort)
 					call->abort_count = 1;
 
-				branch_type_count(&call->brtype_stat,
+				branch_type_count(call->brtype_stat,
 						  &cursor_node->branch_flags,
 						  cursor_node->branch_from,
 						  cursor_node->ip);
@@ -618,7 +626,8 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 				/*
 				 * It's "from" of a branch
 				 */
-				call->brtype_stat.branch_to = false;
+				if (call->brtype_stat && call->brtype_stat->branch_to)
+					call->brtype_stat->branch_to = false;
 				call->cycles_count =
 					cursor_node->branch_flags.cycles;
 				call->iter_count = cursor_node->nr_loop_iter;
@@ -652,6 +661,7 @@ add_child(struct callchain_node *parent,
 			list_del_init(&call->list);
 			map__zput(call->ms.map);
 			maps__zput(call->ms.maps);
+			zfree(&call->brtype_stat);
 			free(call);
 		}
 		free(new);
@@ -762,7 +772,14 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			/*
 			 * It's "to" of a branch
 			 */
-			cnode->brtype_stat.branch_to = true;
+			if (!cnode->brtype_stat) {
+				cnode->brtype_stat = zalloc(sizeof(*cnode->brtype_stat));
+				if (!cnode->brtype_stat) {
+					perror("not enough memory for the code path branch statisitcs");
+					return MATCH_ERROR;
+				}
+			}
+			cnode->brtype_stat->branch_to = true;
 
 			if (node->branch_flags.predicted)
 				cnode->predicted_count++;
@@ -770,7 +787,7 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			if (node->branch_flags.abort)
 				cnode->abort_count++;
 
-			branch_type_count(&cnode->brtype_stat,
+			branch_type_count(cnode->brtype_stat,
 					  &node->branch_flags,
 					  node->branch_from,
 					  node->ip);
@@ -778,7 +795,8 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			/*
 			 * It's "from" of a branch
 			 */
-			cnode->brtype_stat.branch_to = false;
+			if (cnode->brtype_stat && cnode->brtype_stat->branch_to)
+				cnode->brtype_stat->branch_to = false;
 			cnode->cycles_count += node->branch_flags.cycles;
 			cnode->iter_count += node->nr_loop_iter;
 			cnode->iter_cycles += node->iter_cycles;
@@ -1026,6 +1044,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 		maps__zput(ms.maps);
 		map__zput(list->ms.map);
 		maps__zput(list->ms.maps);
+		zfree(&list->brtype_stat);
 		free(list);
 	}
 
@@ -1447,11 +1466,14 @@ static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 int callchain_list_counts__printf_value(struct callchain_list *clist,
 					FILE *fp, char *bf, int bfsize)
 {
+	static const struct branch_type_stat empty_brtype_stat = {};
+	const struct branch_type_stat *brtype_stat;
 	u64 branch_count, predicted_count;
 	u64 abort_count, cycles_count;
 	u64 iter_count, iter_cycles;
 	u64 from_count;
 
+	brtype_stat = clist->brtype_stat ?: &empty_brtype_stat;
 	branch_count = clist->branch_count;
 	predicted_count = clist->predicted_count;
 	abort_count = clist->abort_count;
@@ -1463,7 +1485,7 @@ int callchain_list_counts__printf_value(struct callchain_list *clist,
 	return callchain_counts_printf(fp, bf, bfsize, branch_count,
 				       predicted_count, abort_count,
 				       cycles_count, iter_count, iter_cycles,
-				       from_count, &clist->brtype_stat);
+				       from_count, brtype_stat);
 }
 
 static void free_callchain_node(struct callchain_node *node)
@@ -1476,6 +1498,7 @@ static void free_callchain_node(struct callchain_node *node)
 		list_del_init(&list->list);
 		map__zput(list->ms.map);
 		maps__zput(list->ms.maps);
+		zfree(&list->brtype_stat);
 		free(list);
 	}
 
@@ -1483,6 +1506,7 @@ static void free_callchain_node(struct callchain_node *node)
 		list_del_init(&list->list);
 		map__zput(list->ms.map);
 		maps__zput(list->ms.maps);
+		zfree(&list->brtype_stat);
 		free(list);
 	}
 
@@ -1569,6 +1593,7 @@ int callchain_node__make_parent_list(struct callchain_node *node)
 		list_del_init(&chain->list);
 		map__zput(chain->ms.map);
 		maps__zput(chain->ms.maps);
+		zfree(&chain->brtype_stat);
 		free(chain);
 	}
 	return -ENOMEM;
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index d2618a47deca..86e8a9e81456 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -129,7 +129,7 @@ struct callchain_list {
 	u64			cycles_count;
 	u64			iter_count;
 	u64			iter_cycles;
-	struct branch_type_stat brtype_stat;
+	struct branch_type_stat *brtype_stat;
 	const char		*srcline;
 	struct list_head	list;
 };
-- 
2.42.0.758.gaed0368e0e-goog

