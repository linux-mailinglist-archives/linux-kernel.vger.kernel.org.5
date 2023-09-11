Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED3C79C346
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbjILCr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbjILCrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:47:45 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43980412C9;
        Mon, 11 Sep 2023 19:12:36 -0700 (PDT)
Received: from [31.221.198.239] (port=5908 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qfpqO-009xqF-Ei; Tue, 12 Sep 2023 00:57:28 +0200
Date:   Tue, 12 Sep 2023 00:57:22 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Timo Sigurdsson <public_timo.s@silentcreek.de>
Cc:     kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        sashal@kernel.org, carnil@debian.org, 1051592@bugs.debian.org
Subject: Re: Regression: Commit "netfilter: nf_tables: disallow rule addition
 to bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in
 linux-stable
Message-ID: <ZP+bUpxJiFcmTWhy@calendula>
References: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="I94TNaEqQtwh+Mu3"
Content-Disposition: inline
In-Reply-To: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
X-Spam-Score: -1.9 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I94TNaEqQtwh+Mu3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Timo,

On Mon, Sep 11, 2023 at 11:37:50PM +0200, Timo Sigurdsson wrote:
> Hi,
> 
> recently, Debian updated their stable kernel from 6.1.38 to 6.1.52
> which broke nftables ruleset loading on one of my machines with lots
> of "Operation not supported" errors. I've reported this to the
> Debian project (see link below) and Salvatore Bonaccorso and I
> identified "netfilter: nf_tables: disallow rule addition to bound
> chain via NFTA_RULE_CHAIN_ID" (0ebc1064e487) as the offending commit
> that introduced the regression. Salvatore also found that this issue
> affects the 5.10 stable tree as well (observed in 5.10.191), but he
> cannot reproduce it on 6.4.13 and 6.5.2.
> 
> The issue only occurs with some rulesets. While I can't trigger it
> with simple/minimal rulesets that I use on some machines, it does
> occur with a more complex ruleset that has been in use for months
> (if not years, for large parts of it). I'm attaching a somewhat
> stripped down version of the ruleset from the machine I originally
> observed this issue on. It's still not a small or simple ruleset,
> but I'll try to reduce it further when I have more time.
> 
> The error messages shown when trying to load the ruleset don't seem
> to be helpful. Just two simple examples: Just to give two simple
> examples from the log when nftables fails to start:
> /etc/nftables.conf:99:4-44: Error: Could not process rule: Operation not supported
>                         tcp option maxseg size 1-500 counter drop
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> /etc/nftables.conf:308:4-27: Error: Could not process rule: Operation not supported
>                         tcp dport sip-tls accept
>                         ^^^^^^^^^^^^^^^^^^^^^^^^

I can reproduce this issue with 5.10.191 and 6.1.52 and nftables v1.0.6,
this is not reproducible with v1.0.7 and v1.0.8.

> Since the issue only affects some stable trees, Salvatore thought it
> might be an incomplete backport that causes this.
> 
> If you need further information, please let me know.

Userspace nftables v1.0.6 generates incorrect bytecode that hits a new
kernel check that rejects adding rules to bound chains. The incorrect
bytecode adds the chain binding, attach it to the rule and it adds the
rules to the chain binding. I have cherry-picked these three patches
for nftables v1.0.6 userspace and your ruleset restores fine.

See patches enclosed to this email.

--I94TNaEqQtwh+Mu3
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-rule-add-helper-function-to-expand-chain-rules-into-.patch"

From 4e5b0a64227dde250f94bec45b3fb127d78b7fd2 Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Mon, 6 Feb 2023 15:28:40 +0100
Subject: [PATCH 1/3,nft] rule: add helper function to expand chain rules intoi
 commands

[ upstream commit 784597a4ed63b9decb10d74fdb49a1b021e22728 ]

This patch adds a helper function to expand chain rules into commands.
This comes in preparation for the follow up patch.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/rule.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/src/rule.c b/src/rule.c
index 1402210acd8d..43c6520517ce 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1310,13 +1310,31 @@ void cmd_add_loc(struct cmd *cmd, uint16_t offset, const struct location *loc)
 	cmd->num_attrs++;
 }
 
+static void nft_cmd_expand_chain(struct chain *chain, struct list_head *new_cmds)
+{
+	struct rule *rule;
+	struct handle h;
+	struct cmd *new;
+
+	list_for_each_entry(rule, &chain->rules, list) {
+		memset(&h, 0, sizeof(h));
+		handle_merge(&h, &rule->handle);
+		if (chain->flags & CHAIN_F_BINDING) {
+			rule->handle.chain_id = chain->handle.chain_id;
+			rule->handle.chain.location = chain->location;
+		}
+		new = cmd_alloc(CMD_ADD, CMD_OBJ_RULE, &h,
+				&rule->location, rule_get(rule));
+		list_add_tail(&new->list, new_cmds);
+	}
+}
+
 void nft_cmd_expand(struct cmd *cmd)
 {
 	struct list_head new_cmds;
 	struct flowtable *ft;
 	struct table *table;
 	struct chain *chain;
-	struct rule *rule;
 	struct set *set;
 	struct obj *obj;
 	struct cmd *new;
@@ -1362,22 +1380,9 @@ void nft_cmd_expand(struct cmd *cmd)
 					&ft->location, flowtable_get(ft));
 			list_add_tail(&new->list, &new_cmds);
 		}
-		list_for_each_entry(chain, &table->chains, list) {
-			list_for_each_entry(rule, &chain->rules, list) {
-				memset(&h, 0, sizeof(h));
-				handle_merge(&h, &rule->handle);
-				if (chain->flags & CHAIN_F_BINDING) {
-					rule->handle.chain_id =
-						chain->handle.chain_id;
-					rule->handle.chain.location =
-						chain->location;
-				}
-				new = cmd_alloc(CMD_ADD, CMD_OBJ_RULE, &h,
-						&rule->location,
-						rule_get(rule));
-				list_add_tail(&new->list, &new_cmds);
-			}
-		}
+		list_for_each_entry(chain, &table->chains, list)
+			nft_cmd_expand_chain(chain, &new_cmds);
+
 		list_splice(&new_cmds, &cmd->list);
 		break;
 	case CMD_OBJ_SET:
-- 
2.30.2


--I94TNaEqQtwh+Mu3
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0002-rule-expand-standalone-chain-that-contains-rules.patch"

From 70c03d81df0e87fb416bd1f38409367e9d08ed7f Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Mon, 6 Feb 2023 15:28:41 +0100
Subject: [PATCH 2/3,nft] rule: expand standalone chain that contains rules

[ upstream 27c753e4a8d4744f479345e3f5e34cafef751602 commit ]

Otherwise rules that this chain contains are ignored when expressed
using the following syntax:

chain inet filter input2 {
       type filter hook input priority filter; policy accept;
       ip saddr 1.2.3.4 tcp dport { 22, 443, 123 } drop
}

When expanding the chain, remove the rule so the new CMD_OBJ_CHAIN
case does not expand it again.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1655
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/rule.c                                    | 15 +++++++++---
 .../testcases/include/0020include_chain_0     | 23 +++++++++++++++++++
 .../include/dumps/0020include_chain_0.nft     |  6 +++++
 3 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100755 tests/shell/testcases/include/0020include_chain_0
 create mode 100644 tests/shell/testcases/include/dumps/0020include_chain_0.nft

diff --git a/src/rule.c b/src/rule.c
index 43c6520517ce..323d89afd141 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1312,11 +1312,12 @@ void cmd_add_loc(struct cmd *cmd, uint16_t offset, const struct location *loc)
 
 static void nft_cmd_expand_chain(struct chain *chain, struct list_head *new_cmds)
 {
-	struct rule *rule;
+	struct rule *rule, *next;
 	struct handle h;
 	struct cmd *new;
 
-	list_for_each_entry(rule, &chain->rules, list) {
+	list_for_each_entry_safe(rule, next, &chain->rules, list) {
+		list_del(&rule->list);
 		memset(&h, 0, sizeof(h));
 		handle_merge(&h, &rule->handle);
 		if (chain->flags & CHAIN_F_BINDING) {
@@ -1324,7 +1325,7 @@ static void nft_cmd_expand_chain(struct chain *chain, struct list_head *new_cmds
 			rule->handle.chain.location = chain->location;
 		}
 		new = cmd_alloc(CMD_ADD, CMD_OBJ_RULE, &h,
-				&rule->location, rule_get(rule));
+				&rule->location, rule);
 		list_add_tail(&new->list, new_cmds);
 	}
 }
@@ -1385,6 +1386,14 @@ void nft_cmd_expand(struct cmd *cmd)
 
 		list_splice(&new_cmds, &cmd->list);
 		break;
+	case CMD_OBJ_CHAIN:
+		chain = cmd->chain;
+		if (!chain || list_empty(&chain->rules))
+			break;
+
+		nft_cmd_expand_chain(chain, &new_cmds);
+		list_splice(&new_cmds, &cmd->list);
+		break;
 	case CMD_OBJ_SET:
 	case CMD_OBJ_MAP:
 		set = cmd->set;
diff --git a/tests/shell/testcases/include/0020include_chain_0 b/tests/shell/testcases/include/0020include_chain_0
new file mode 100755
index 000000000000..8f78e8c606ec
--- /dev/null
+++ b/tests/shell/testcases/include/0020include_chain_0
@@ -0,0 +1,23 @@
+#!/bin/bash
+
+set -e
+
+tmpfile1=$(mktemp -p .)
+if [ ! -w $tmpfile1 ] ; then
+	echo "Failed to create tmp file" >&2
+	exit 0
+fi
+
+trap "rm -rf $tmpfile1" EXIT # cleanup if aborted
+
+RULESET="table inet filter { }
+include \"$tmpfile1\""
+
+RULESET2="chain inet filter input2 {
+	type filter hook input priority filter; policy accept;
+	ip saddr 1.2.3.4 tcp dport { 22, 443, 123 } drop
+}"
+
+echo "$RULESET2" > $tmpfile1
+
+$NFT -o -f - <<< $RULESET
diff --git a/tests/shell/testcases/include/dumps/0020include_chain_0.nft b/tests/shell/testcases/include/dumps/0020include_chain_0.nft
new file mode 100644
index 000000000000..3ad6db14d2f5
--- /dev/null
+++ b/tests/shell/testcases/include/dumps/0020include_chain_0.nft
@@ -0,0 +1,6 @@
+table inet filter {
+	chain input2 {
+		type filter hook input priority filter; policy accept;
+		ip saddr 1.2.3.4 tcp dport { 22, 123, 443 } drop
+	}
+}
-- 
2.30.2


--I94TNaEqQtwh+Mu3
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0003-src-expand-table-command-before-evaluation.patch"

From a13ffae3838548d9b337d6efe74af070edc355d5 Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Thu, 23 Feb 2023 19:55:39 +0100
Subject: [PATCH 3/3,nft] src: expand table command before evaluation

[ upstream 3975430b12d97c92cdf03753342f2269153d5624 commit ]

The nested syntax notation results in one single table command which
includes all other objects. This differs from the flat notation where
there is usually one command per object.

This patch adds a previous step to the evaluation phase to expand the
objects that are contained in the table into independent commands, so
both notations have similar representations.

Remove the code to evaluate the nested representation in the evaluation
phase since commands are independently evaluated after the expansion.

The commands are expanded after the set element collapse step, in case
that there is a long list of singleton element commands to be added to
the set, to shorten the command list iteration.

This approach also avoids interference with the object cache that is
populated in the evaluation, which might refer to objects coming in the
existing command list that is being processed.

There is still a post_expand phase to detach the elements from the set
which could be consolidated by updating the evaluation step to handle
the CMD_OBJ_SETELEMS command type.

This patch fixes 27c753e4a8d4 ("rule: expand standalone chain that
contains rules") which broke rule addition/insertion by index because
the expansion code after the evaluation messes up the cache.

Fixes: 27c753e4a8d4 ("rule: expand standalone chain that contains rules")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/rule.h    |  1 +
 src/evaluate.c    | 39 ---------------------------------------
 src/libnftables.c |  9 ++++++++-
 src/rule.c        | 19 ++++++++++++++++++-
 4 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/include/rule.h b/include/rule.h
index 00a1bac5a773..7625addfd919 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -733,6 +733,7 @@ extern struct cmd *cmd_alloc(enum cmd_ops op, enum cmd_obj obj,
 			     const struct handle *h, const struct location *loc,
 			     void *data);
 extern void nft_cmd_expand(struct cmd *cmd);
+extern void nft_cmd_post_expand(struct cmd *cmd);
 extern bool nft_cmd_collapse(struct list_head *cmds);
 extern void nft_cmd_uncollapse(struct list_head *cmds);
 extern struct cmd *cmd_alloc_obj_ct(enum cmd_ops op, int type,
diff --git a/src/evaluate.c b/src/evaluate.c
index c04cb91d3919..e2172569cdcc 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4601,7 +4601,6 @@ static uint32_t str2hooknum(uint32_t family, const char *hook)
 static int chain_evaluate(struct eval_ctx *ctx, struct chain *chain)
 {
 	struct table *table;
-	struct rule *rule;
 
 	table = table_cache_find(&ctx->nft->cache.table_cache,
 				 ctx->cmd->handle.table.name,
@@ -4657,11 +4656,6 @@ static int chain_evaluate(struct eval_ctx *ctx, struct chain *chain)
 		}
 	}
 
-	list_for_each_entry(rule, &chain->rules, list) {
-		handle_merge(&rule->handle, &chain->handle);
-		if (rule_evaluate(ctx, rule, CMD_INVALID) < 0)
-			return -1;
-	}
 	return 0;
 }
 
@@ -4729,11 +4723,6 @@ static int obj_evaluate(struct eval_ctx *ctx, struct obj *obj)
 
 static int table_evaluate(struct eval_ctx *ctx, struct table *table)
 {
-	struct flowtable *ft;
-	struct chain *chain;
-	struct set *set;
-	struct obj *obj;
-
 	if (!table_cache_find(&ctx->nft->cache.table_cache,
 			      ctx->cmd->handle.table.name,
 			      ctx->cmd->handle.family)) {
@@ -4746,34 +4735,6 @@ static int table_evaluate(struct eval_ctx *ctx, struct table *table)
 		}
 	}
 
-	if (ctx->cmd->table == NULL)
-		return 0;
-
-	ctx->table = table;
-	list_for_each_entry(set, &table->sets, list) {
-		expr_set_context(&ctx->ectx, NULL, 0);
-		handle_merge(&set->handle, &table->handle);
-		if (set_evaluate(ctx, set) < 0)
-			return -1;
-	}
-	list_for_each_entry(chain, &table->chains, list) {
-		handle_merge(&chain->handle, &table->handle);
-		ctx->cmd->handle.chain.location = chain->location;
-		if (chain_evaluate(ctx, chain) < 0)
-			return -1;
-	}
-	list_for_each_entry(ft, &table->flowtables, list) {
-		handle_merge(&ft->handle, &table->handle);
-		if (flowtable_evaluate(ctx, ft) < 0)
-			return -1;
-	}
-	list_for_each_entry(obj, &table->objs, list) {
-		handle_merge(&obj->handle, &table->handle);
-		if (obj_evaluate(ctx, obj) < 0)
-			return -1;
-	}
-
-	ctx->table = NULL;
 	return 0;
 }
 
diff --git a/src/libnftables.c b/src/libnftables.c
index a376825d7309..fd4ee6988c27 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -520,6 +520,13 @@ static int nft_evaluate(struct nft_ctx *nft, struct list_head *msgs,
 	if (nft_cmd_collapse(cmds))
 		collapsed = true;
 
+	list_for_each_entry(cmd, cmds, list) {
+		if (cmd->op != CMD_ADD)
+			continue;
+
+		nft_cmd_expand(cmd);
+	}
+
 	list_for_each_entry_safe(cmd, next, cmds, list) {
 		struct eval_ctx ectx = {
 			.nft	= nft,
@@ -543,7 +550,7 @@ static int nft_evaluate(struct nft_ctx *nft, struct list_head *msgs,
 		if (cmd->op != CMD_ADD)
 			continue;
 
-		nft_cmd_expand(cmd);
+		nft_cmd_post_expand(cmd);
 	}
 
 	return 0;
diff --git a/src/rule.c b/src/rule.c
index 323d89afd141..982160359aea 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1318,8 +1318,9 @@ static void nft_cmd_expand_chain(struct chain *chain, struct list_head *new_cmds
 
 	list_for_each_entry_safe(rule, next, &chain->rules, list) {
 		list_del(&rule->list);
+		handle_merge(&rule->handle, &chain->handle);
 		memset(&h, 0, sizeof(h));
-		handle_merge(&h, &rule->handle);
+		handle_merge(&h, &chain->handle);
 		if (chain->flags & CHAIN_F_BINDING) {
 			rule->handle.chain_id = chain->handle.chain_id;
 			rule->handle.chain.location = chain->location;
@@ -1350,6 +1351,7 @@ void nft_cmd_expand(struct cmd *cmd)
 			return;
 
 		list_for_each_entry(chain, &table->chains, list) {
+			handle_merge(&chain->handle, &table->handle);
 			memset(&h, 0, sizeof(h));
 			handle_merge(&h, &chain->handle);
 			h.chain_id = chain->handle.chain_id;
@@ -1394,6 +1396,21 @@ void nft_cmd_expand(struct cmd *cmd)
 		nft_cmd_expand_chain(chain, &new_cmds);
 		list_splice(&new_cmds, &cmd->list);
 		break;
+	default:
+		break;
+	}
+}
+
+void nft_cmd_post_expand(struct cmd *cmd)
+{
+	struct list_head new_cmds;
+	struct set *set;
+	struct cmd *new;
+	struct handle h;
+
+	init_list_head(&new_cmds);
+
+	switch (cmd->obj) {
 	case CMD_OBJ_SET:
 	case CMD_OBJ_MAP:
 		set = cmd->set;
-- 
2.30.2


--I94TNaEqQtwh+Mu3--
