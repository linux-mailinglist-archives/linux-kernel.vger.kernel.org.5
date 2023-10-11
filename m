Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B77C5ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjJKVB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJKVBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:01:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8547B90
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:01:21 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9c496c114so52525ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697058081; x=1697662881; darn=vger.kernel.org;
        h=mime-version:date:user-agent:references:message-id:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/wh/UtH/lGoriGLCu9hG1etzUc9EGpASMGZxUuz8JtQ=;
        b=evROzrqNm1u7MWK9UtiaTAvjcBIOJHuFnwdoxJeFKXUMHW/swrimXhQmFqhyVwqu7D
         981A5jTeYDkrYaswldwaUWzkT4uqUqAc1NCyBbdvRuwerGqOw8AhmEuntWyfc+0ymEMF
         XMh8H2fi7NfzHFm6suYSSBujZ8LECOifmeaGuBFQFbKJA7vSgNbfhbY0OPJG19uDNYrb
         vW4xGSEBxJiSGb5XNrVF5p6ANmbE39r52Fc9oleCUFWaLMU5CC6oUPomu//azHgxOZ1r
         Yrisgub3COhaQWK0Ow4EMqvZH7Jqx1a87/zHvYZZXAVVhchZlugm/sW+Xz3AoN+TV6Pi
         4nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697058081; x=1697662881;
        h=mime-version:date:user-agent:references:message-id:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wh/UtH/lGoriGLCu9hG1etzUc9EGpASMGZxUuz8JtQ=;
        b=v3P/37AOMXK3vRN3NnjKqwQdHrtxTgbCl4OFGFsNo8hjIEmhsh4bmIEhdrnRaUMmdR
         RbiUxNnNCX1BH+6qAVLU/fO+8UpQtK3FZpMozyZS0wQSwpf+LEhs7+cXMCO7GfDUp0tS
         7PTkffj84Oy3tIBRZpjCxbwirw0ciTCDKiHOGVuqRZTuHi98jrecLUwaVbKdazRNCYmp
         MKySnfQuSf17r9zxEmQtQhG5o+fqRyuQ0fyjQSkPaFj4+605wYL1IfGvQID23EU+0YSE
         zwZ/LsYsVgSfyiV8NZ2R31Z1ry6xtZ82oXPOOGWU2SPCE4eWnCUS9s8oWOiyNqJLTGQT
         63Dg==
X-Gm-Message-State: AOJu0YxHf+EvGI7+qgLceUo1hTZWws5zXrkT2q4QgfuXa6B4WJxknLOg
        0liQ0r2Cp/eAqaNI4/jsaG7IUw==
X-Google-Smtp-Source: AGHT+IGuiz6zk7Jxu2NrwMhqJTBgeoYgyzgpfwANIPJ8Rz5mRtB8D0kh8e4QahgnUivPr8nf9V4aVQ==
X-Received: by 2002:a17:902:ecd2:b0:1c9:c480:1797 with SMTP id a18-20020a170902ecd200b001c9c4801797mr284587plh.11.1697058080743;
        Wed, 11 Oct 2023 14:01:20 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2a3:200:5aa:bf1b:3872:9fec])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001c75d7f2597sm281912pli.141.2023.10.11.14.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:01:19 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
In-Reply-To: <6b606049-3412-437f-af25-a4c33139e2d8@bytedance.com> (Abel Wu's
        message of "Wed, 11 Oct 2023 20:12:09 +0800")
Message-ID: <xm26bkd4x5v4.fsf@bsegall-linux.svl.corp.google.com>
References: <20230531115839.089944915@infradead.org>
        <20230531124603.931005524@infradead.org>
        <xm261qego72d.fsf_-_@google.com>
        <6b606049-3412-437f-af25-a4c33139e2d8@bytedance.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Wed, 11 Oct 2023 14:01:02 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Abel Wu <wuyun.abel@bytedance.com> writes:

> On 9/30/23 8:09 AM, Benjamin Segall Wrote:
>> +	/*
>> +	 * Now best_left and all of its children are eligible, and we are just
>> +	 * looking for deadline == min_deadline
>> +	 */
>> +	node = &best_left->run_node;
>> +	while (node) {
>> +		struct sched_entity *se = __node_2_se(node);
>> +
>> +		/* min_deadline is the current node */
>> +		if (se->deadline == se->min_deadline)
>> +			return se;
>
> IMHO it would be better tiebreak on vruntime by moving this hunk to ..
>
>> +
>> +		/* min_deadline is in the left branch */
>>   		if (node->rb_left &&
>>   		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
>>   			node = node->rb_left;
>>   			continue;
>>   		}
>
> .. here, thoughts?

Yeah, that should work and be better on the tiebreak (and my test code
agrees). There's an argument that the tiebreak will never really come up
and it's better to avoid the potential one extra cache line from
"__node_2_se(node->rb_left)->min_deadline" though.

>
>>   +		/* else min_deadline is in the right branch */
>>   		node = node->rb_right;
>>   	}
>> +	return NULL;
>
> Why not 'best'? Since ..

The only time this can happen is if the tree is corrupt. We only reach
this case if best_left is set at all (and best_left's min_deadline is
better than "best"'s, which includes curr). In that case getting an
error message is good, and in general I wasn't worrying about it much.

>
>> +}
>>   -	if (!best || (curr && deadline_gt(deadline, best, curr)))
>> -		best = curr;
>> +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>> +{
>> +	struct sched_entity *se = __pick_eevdf(cfs_rq);
>>   -	if (unlikely(!best)) {
>> +	if (!se) {
>>   		struct sched_entity *left = __pick_first_entity(cfs_rq);
>
> .. cfs_rq->curr isn't considered here.

That said, we should probably consider curr here in the error-case
fallback, if just as a "if (!left) left = cfs_rq->curr;"

>
>>   		if (left) {
>>   			pr_err("EEVDF scheduling fail, picking leftmost\n");
>>   			return left;
>>   		}
>>   	}
>>   -	return best;
>> +	return se;
>>   }
>>     #ifdef CONFIG_SCHED_DEBUG
>>   struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
>>   {
>
> The implementation of __pick_eevdf() now is quite complicated which
> makes it really hard to maintain. I'm trying my best to refactor this
> part, hopefully can do some help. Below is only for illustration, I
> need to test more.
>

A passing version of that single-loop code minus the cfs_rq->curr
handling is here (just pasting the curr handling back on the start/end
should do):

static struct sched_entity *pick_eevdf_abel(struct cfs_rq *cfs_rq)
{
	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
	struct sched_entity *best = NULL;
	struct sched_entity *cand = NULL;
	bool all_eligible = false;

	while (node || cand) {
		struct sched_entity *se = __node_2_se(node);
		if (!node) {
			BUG_ON(!cand);
			node = &cand->run_node;
			se = __node_2_se(node);
			all_eligible = true;
			cand = NULL;

			/*
			 * Our initial pass ran into an eligible node which is
			 * itself the best
			 */
			if (best && (s64)(se->min_deadline - best->deadline) > 0)
				break;
		}

		/*
		 * If this entity is not eligible, try the left subtree.
		 */
		if (!all_eligible && !entity_eligible(cfs_rq, se)) {
			node = node->rb_left;
			continue;
		}

		if (node->rb_left) {
			struct sched_entity *left = __node_2_se(node->rb_left);

			BUG_ON(left->min_deadline < se->min_deadline);

			/* Tiebreak on vruntime */
			if (left->min_deadline == se->min_deadline) {
				node = node->rb_left;
				all_eligible = true;
				continue;
			}

			if (!all_eligible) {
				/*
				 * We're going to search right subtree and the one
				 * with min_deadline can be non-eligible, so record
				 * the left subtree as a candidate.
				 */
				if (!cand || deadline_gt(min_deadline, cand, left))
					cand = left;
			}
		}

		if (!all_eligible && (!best || deadline_gt(deadline, best, se)))
			best = se;

		/* min_deadline is at this node, no need to look right */
		if (se->deadline == se->min_deadline) {
			if (all_eligible && (!best || deadline_gte(deadline, best, se)))
				best = se;
			if (!all_eligible && (!best || deadline_gt(deadline, best, se)))
				best = se;
			node = NULL;
			continue;
		}

		node = node->rb_right;
	}

	return best;
}

This does exactly as well on the tiebreak condition of vruntime as the
improved two-loop version you suggested. If we don't care about the
tiebreak we can replace the ugly if(all_eligible) if(!all_eligible) in
the last section with a single version that just uses deadline_gt (or
gte) throughout.

Personally with all the extra bits I added for correctness this winds up
definitely uglier than the two-loop version, but it might be possible to
clean it up further. (And a bunch of it is just personal style
preference in the first place)

I've also attached my ugly userspace EEVDF tester as an attachment,
hopefully I attached it in a correct mode to go through lkml.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment; filename=eevdf-tester.patch
Content-Description: EEVDF tester

diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
index 099ee9213557..10e38c7afe5e 100644
--- a/tools/testing/selftests/sched/Makefile
+++ b/tools/testing/selftests/sched/Makefile
@@ -6,9 +6,11 @@ endif
 
 CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -Wl,-rpath=./ \
 	  $(CLANG_FLAGS)
 LDLIBS += -lpthread
 
-TEST_GEN_FILES := cs_prctl_test
-TEST_PROGS := cs_prctl_test
+TEST_GEN_FILES := cs_prctl_test sim_rbtree
+TEST_PROGS := cs_prctl_test sim_rbtree
 
 include ../lib.mk
+
+CFLAGS += -I$(top_srcdir)/tools/include
diff --git a/tools/testing/selftests/sched/sim_rbtree.c b/tools/testing/selftests/sched/sim_rbtree.c
new file mode 100644
index 000000000000..dad2544e4d9d
--- /dev/null
+++ b/tools/testing/selftests/sched/sim_rbtree.c
@@ -0,0 +1,681 @@
+#include "linux/rbtree_augmented.h"
+#include <stdio.h>
+#include <string.h>
+#include <time.h>
+#include <stdlib.h>
+#include <assert.h>
+
+#include "../../../lib/rbtree.c"
+
+static inline s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder)
+{
+	*remainder = dividend % divisor;
+	return dividend / divisor;
+}
+static inline s64 div_s64(s64 dividend, s32 divisor)
+{
+	s32 remainder;
+	return div_s64_rem(dividend, divisor, &remainder);
+}
+
+static __always_inline struct rb_node *
+rb_add_augmented_cached(struct rb_node *node, struct rb_root_cached *tree,
+			bool (*less)(struct rb_node *, const struct rb_node *),
+			const struct rb_augment_callbacks *augment)
+{
+	struct rb_node **link = &tree->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	bool leftmost = true;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent)) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(node, parent, link);
+	augment->propagate(parent, NULL); /* suboptimal */
+	rb_insert_augmented_cached(node, tree, leftmost, augment);
+
+	return leftmost ? node : NULL;
+}
+
+
+# define SCHED_FIXEDPOINT_SHIFT		10
+# define NICE_0_LOAD_SHIFT	(SCHED_FIXEDPOINT_SHIFT + SCHED_FIXEDPOINT_SHIFT)
+# define scale_load(w)		((w) << SCHED_FIXEDPOINT_SHIFT)
+# define scale_load_down(w) \
+({ \
+	unsigned long __w = (w); \
+	if (__w) \
+		__w = max(2UL, __w >> SCHED_FIXEDPOINT_SHIFT); \
+	__w; \
+})
+
+struct load_weight {
+	unsigned long			weight;
+	u32				inv_weight;
+};
+
+struct sched_entity {
+	char name;
+	struct load_weight		load;
+	struct rb_node			run_node;
+	u64				deadline;
+	u64				min_deadline;
+
+	unsigned int			on_rq;
+
+	u64				vruntime;
+	s64				vlag;
+	u64				slice;
+};
+
+struct cfs_rq {
+	struct load_weight	load;
+	s64			avg_vruntime;
+	u64			avg_load;
+	u64			min_vruntime;
+	struct rb_root_cached	tasks_timeline;
+	struct sched_entity	*curr;
+};
+
+void print_se(char *label, struct sched_entity *se);
+
+static inline bool entity_before(const struct sched_entity *a,
+				 const struct sched_entity *b)
+{
+	return (s64)(a->vruntime - b->vruntime) < 0;
+}
+
+static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	return (s64)(se->vruntime - cfs_rq->min_vruntime);
+}
+
+#define __node_2_se(node) \
+	rb_entry((node), struct sched_entity, run_node)
+
+int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	s64 avg = cfs_rq->avg_vruntime;
+	long load = cfs_rq->avg_load;
+
+	if (curr && curr->on_rq) {
+		unsigned long weight = scale_load_down(curr->load.weight);
+
+		avg += entity_key(cfs_rq, curr) * weight;
+		load += weight;
+	}
+
+	return avg >= entity_key(cfs_rq, se) * load;
+}
+
+static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
+{
+	return entity_before(__node_2_se(a), __node_2_se(b));
+}
+
+#define deadline_gt(field, lse, rse) ({ (s64)((lse)->field - (rse)->field) > 0; })
+
+static inline void __update_min_deadline(struct sched_entity *se, struct rb_node *node)
+{
+	if (node) {
+		struct sched_entity *rse = __node_2_se(node);
+		if (deadline_gt(min_deadline, se, rse))
+			se->min_deadline = rse->min_deadline;
+	}
+}
+
+/*
+ * se->min_deadline = min(se->deadline, left->min_deadline, right->min_deadline)
+ */
+static inline bool min_deadline_update(struct sched_entity *se, bool exit)
+{
+	u64 old_min_deadline = se->min_deadline;
+	struct rb_node *node = &se->run_node;
+
+	se->min_deadline = se->deadline;
+	__update_min_deadline(se, node->rb_right);
+	__update_min_deadline(se, node->rb_left);
+
+	return se->min_deadline == old_min_deadline;
+}
+
+static void
+avg_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	unsigned long weight = scale_load_down(se->load.weight);
+	s64 key = entity_key(cfs_rq, se);
+
+	cfs_rq->avg_vruntime += key * weight;
+	cfs_rq->avg_load += weight;
+}
+
+static void
+avg_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	unsigned long weight = scale_load_down(se->load.weight);
+	s64 key = entity_key(cfs_rq, se);
+
+	cfs_rq->avg_vruntime -= key * weight;
+	cfs_rq->avg_load -= weight;
+}
+
+static inline
+void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
+{
+	/*
+	 * v' = v + d ==> avg_vruntime' = avg_runtime - d*avg_load
+	 */
+	cfs_rq->avg_vruntime -= cfs_rq->avg_load * delta;
+}
+
+u64 avg_vruntime(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	s64 avg = cfs_rq->avg_vruntime;
+	long load = cfs_rq->avg_load;
+
+	if (curr && curr->on_rq) {
+		unsigned long weight = scale_load_down(curr->load.weight);
+
+		avg += entity_key(cfs_rq, curr) * weight;
+		load += weight;
+	}
+
+	if (load)
+		avg = div_s64(avg, load);
+
+	return cfs_rq->min_vruntime + avg;
+}
+
+
+RB_DECLARE_CALLBACKS(static, min_deadline_cb, struct sched_entity,
+		     run_node, min_deadline, min_deadline_update);
+
+/*
+ * Enqueue an entity into the rb-tree:
+ */
+static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	avg_vruntime_add(cfs_rq, se);
+	se->min_deadline = se->deadline;
+	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
+				__entity_less, &min_deadline_cb);
+}
+
+void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
+				  &min_deadline_cb);
+	avg_vruntime_sub(cfs_rq, se);
+}
+
+struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *left = rb_first_cached(&cfs_rq->tasks_timeline);
+
+	if (!left)
+		return NULL;
+
+	return __node_2_se(left);
+}
+
+
+static struct sched_entity *pick_eevdf_orig(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct sched_entity *curr = cfs_rq->curr;
+	struct sched_entity *best = NULL;
+
+	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
+		curr = NULL;
+
+	/*
+	 * Once selected, run a task until it either becomes non-eligible or
+	 * until it gets a new slice. See the HACK in set_next_entity().
+	 */
+	//if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
+	//return curr;
+
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		/*
+		 * If this entity is not eligible, try the left subtree.
+		 */
+		if (!entity_eligible(cfs_rq, se)) {
+			node = node->rb_left;
+			continue;
+		}
+
+		/*
+		 * If this entity has an earlier deadline than the previous
+		 * best, take this one. If it also has the earliest deadline
+		 * of its subtree, we're done.
+		 */
+		if (!best || deadline_gt(deadline, best, se)) {
+			best = se;
+			if (best->deadline == best->min_deadline)
+				break;
+		}
+
+		/*
+		 * If the earlest deadline in this subtree is in the fully
+		 * eligible left half of our space, go there.
+		 */
+		if (node->rb_left &&
+		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
+			node = node->rb_left;
+			continue;
+		}
+
+		node = node->rb_right;
+	}
+
+	return best;
+}
+
+#if 1
+#define print_se(...)
+#define printf(...)
+#endif
+
+static struct sched_entity *pick_eevdf_improved(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct sched_entity *best_left = NULL;
+	struct sched_entity *best = NULL;
+
+	if (!node)
+		return NULL;
+
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+		print_se("search1", se);
+
+		/*
+		 * If this entity is not eligible, try the left subtree.
+		 */
+		if (!entity_eligible(cfs_rq, se)) {
+			node = node->rb_left;
+			printf("not eligible\n");
+			continue;
+		}
+
+		/*
+		 * Now we heap search eligible trees the best (min_)deadline
+		 */
+		if (!best || deadline_gt(deadline, best, se)) {
+			print_se("best found", se);
+			best = se;
+		}
+
+		/*
+		 * Every se in a left branch is eligible, keep track of the one
+		 * with the best min_deadline
+		 */
+		if (node->rb_left) {
+			struct sched_entity *left = __node_2_se(node->rb_left);
+			print_se("going right, has left", left);
+			if (!best_left || deadline_gt(min_deadline, best_left, left)) {
+				printf("new best left\n");
+				best_left = left;
+			}
+
+			/*
+			 * min_deadline is in the left branch. rb_left and all
+			 * descendants are eligible, so immediately switch to the second
+			 * loop.
+			 */
+			if (left->min_deadline == se->min_deadline) {
+				printf("left");
+				break;
+			}
+		}
+
+		/* min_deadline is at node, no need to look right */
+		if (se->deadline == se->min_deadline) {
+			printf("found\n");
+			break;
+		}
+
+		/* else min_deadline is in the right branch. */
+		BUG_ON(__node_2_se(node->rb_right)->min_deadline != se->min_deadline);
+		node = node->rb_right;
+	}
+	BUG_ON(!best);
+	print_se("best_left", best_left);
+	print_se("best", best);
+
+	/* We ran into an eligible node which is itself the best */
+	if (!best_left || (s64)(best_left->min_deadline - best->deadline) > 0)
+		return best;
+	
+	/*
+	 * Now best_left and all of its children are eligible, and we are just
+	 * looking for deadline == min_deadline
+	 */
+	node = &best_left->run_node;
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		/* min_deadline is the current node */
+		if (se->deadline == se->min_deadline)
+			return se;
+
+		/* min_deadline is in the left branch */
+		if (node->rb_left &&
+		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
+			node = node->rb_left;
+			continue;
+		}
+
+		/* else min_deadline is in the right branch */
+		BUG_ON(__node_2_se(node->rb_right)->min_deadline != se->min_deadline);
+		node = node->rb_right;
+	}
+	BUG();
+	return NULL;
+}
+
+#undef printf
+#undef print_se
+
+static struct sched_entity *pick_eevdf_improved_ndebug(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct sched_entity *best_left = NULL;
+	struct sched_entity *best = NULL;
+
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		/*
+		 * If this entity is not eligible, try the left subtree.
+		 */
+		if (!entity_eligible(cfs_rq, se)) {
+			node = node->rb_left;
+			continue;
+		}
+
+		/*
+		 * Now we heap search eligible trees the best (min_)deadline
+		 */
+		if (!best || deadline_gt(deadline, best, se))
+			best = se;
+
+		/*
+		 * Every se in a left branch is eligible, keep track of the one
+		 * with the best min_deadline
+		 */
+		if (node->rb_left) {
+			struct sched_entity *left = __node_2_se(node->rb_left);
+			if (!best_left || deadline_gt(min_deadline, best_left, left))
+				best_left = left;
+
+			/*
+			 * min_deadline is in the left branch. rb_left and all
+			 * descendants are eligible, so immediately switch to the second
+			 * loop.
+			 */
+			if (left->min_deadline == se->min_deadline)
+				break;
+		}
+
+		/* min_deadline is at node, no need to look right */
+		if (se->deadline == se->min_deadline)
+			break;
+
+		/* else min_deadline is in the right branch. */
+		BUG_ON(__node_2_se(node->rb_right)->min_deadline != se->min_deadline);
+		node = node->rb_right;
+	}
+	BUG_ON(!best && best_left);
+
+	/* We ran into an eligible node which is itself the best */
+	if (!best_left || (s64)(best_left->min_deadline - best->deadline) > 0)
+		return best;
+	
+	/*
+	 * Now best_left and all of its children are eligible, and we are just
+	 * looking for deadline == min_deadline
+	 */
+	node = &best_left->run_node;
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		/* min_deadline is in the left branch */
+		if (node->rb_left &&
+		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
+			node = node->rb_left;
+			continue;
+		}
+
+		/* min_deadline is the current node */
+		if (se->deadline == se->min_deadline)
+			return se;
+
+		/* else min_deadline is in the right branch */
+		BUG_ON(__node_2_se(node->rb_right)->min_deadline != se->min_deadline);
+		node = node->rb_right;
+	}
+	BUG();
+	return NULL;
+}
+
+static struct sched_entity *pick_eevdf_abel(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct sched_entity *best = NULL;
+	struct sched_entity *cand = NULL;
+	bool all_eligible = false;
+
+	while (node || cand) {
+		struct sched_entity *se = __node_2_se(node);
+		if (!node) {
+			BUG_ON(!cand);
+			node = &cand->run_node;
+			se = __node_2_se(node);
+			all_eligible = true;
+			cand = NULL;
+
+			/*
+			 * Our initial pass ran into an eligible node which is
+			 * itself the best
+			 */
+			if (best && (s64)(se->min_deadline - best->deadline) > 0)
+				break;
+		}
+
+		/*
+		 * If this entity is not eligible, try the left subtree.
+		 */
+		if (!all_eligible && !entity_eligible(cfs_rq, se)) {
+			node = node->rb_left;
+			continue;
+		}
+		if (!all_eligible && (!best || deadline_gt(deadline, best, se)))
+			best = se;
+
+		if (node->rb_left) {
+			struct sched_entity *left = __node_2_se(node->rb_left);
+
+			BUG_ON(left->min_deadline < se->min_deadline);
+
+			/* Tiebreak on vruntime */
+			if (left->min_deadline == se->min_deadline) {
+				node = node->rb_left;
+				all_eligible = true;
+				continue;
+			}
+
+			if (!all_eligible) {
+				/*
+				 * We're going to search right subtree and the one
+				 * with min_deadline can be non-eligible, so record
+				 * the left subtree as a candidate.
+				 */
+				if (!cand || deadline_gt(min_deadline, cand, left))
+					cand = left;
+			}
+		}
+
+		/* min_deadline is at this node, no need to look right */
+		if (se->deadline == se->min_deadline) {
+			if (!best || deadline_gt(deadline, best, se))
+				best = se;
+			node = NULL;
+			continue;
+		}
+
+		node = node->rb_right;
+	}
+
+	return best;
+}
+
+
+
+void init_se(struct cfs_rq *cfs_rq, struct sched_entity *se, char name, u64 vruntime, u64 deadline) {
+	memset(se, 0, sizeof(*se));
+	se->name = name;
+	se->slice = 1;
+	se->load.weight = 1024;
+	se->vruntime = vruntime;
+	se->deadline = deadline;
+	__enqueue_entity(cfs_rq, se);
+}
+
+void print_se(char *label, struct sched_entity *se) {
+	if (!se) {
+		printf("%s is null\n", label);
+	} else {
+		struct rb_node *parent = rb_parent(&se->run_node);
+		printf("%s(%c) vrun %ld dl %ld, min_dl %ld, parent: %c\n", label, se->name,
+		       se->vruntime, se->deadline, se->min_deadline, parent ? __node_2_se(parent)->name : ' ');
+	}
+}
+
+struct sched_entity *correct_pick_eevdf(struct cfs_rq *cfs_rq) {
+	struct rb_node *node = rb_first_cached(&cfs_rq->tasks_timeline);
+	struct sched_entity *best = NULL;
+
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		/*
+		 * If this entity is not eligible, try the left subtree.
+		 */
+		if (!entity_eligible(cfs_rq, se)) {
+			return best;
+		}
+
+		/*
+		 * If this entity has an earlier deadline than the previous
+		 * best, take this one. If it also has the earliest deadline
+		 * of its subtree, we're done.
+		 */
+		if (!best || deadline_gt(deadline, best, se)) {
+			best = se;
+		}
+
+		node = rb_next(node);
+	}
+	return best;
+}
+
+
+void test_pick_function(struct sched_entity *(*pick_fn)(struct cfs_rq *), unsigned long skip_to) {
+#define MAX_SIZE 26
+	int size;
+	unsigned long n = 0;
+	struct sched_entity se[MAX_SIZE];
+	for (size = 0; size < MAX_SIZE; size++) {
+		int runs = 100000;
+		int count;
+		if (size <= 1)
+			runs = 1;
+		else if (size == 2)
+			runs = 100;
+		for (count = 0; count < runs; count++) {
+			int i;
+			struct cfs_rq cfs_rq = {0};
+			struct sched_entity *pick, *correct_pick;
+			cfs_rq.tasks_timeline = RB_ROOT_CACHED;
+			for (i = 0; i < size; i++) {
+				u64 v = (random() % size) * 10;
+				u64 d = v + (random() % size) * 10 + 1;
+				init_se(&cfs_rq, &se[i], 'A'+i, v, d);
+			}
+			n++;
+			if (n < skip_to)
+				continue;
+			pick = pick_fn(&cfs_rq);
+			correct_pick = correct_pick_eevdf(&cfs_rq);
+
+			if (size == 0) {
+				assert(!pick);
+				assert(!correct_pick);
+				continue;
+			}
+			if (!pick ||
+			    pick->deadline != correct_pick->deadline ||
+			    !entity_eligible(&cfs_rq, pick)) {
+
+				printf("Error (run %lu):\n", n);
+				print_se("correct pick", correct_pick);
+				print_se("actual pick ", pick);
+				printf("All ses:\n");
+				for (i = 0; i < size; i++) {
+					print_se("", &se[i]);
+				}
+				return;
+			}
+			//puts("");
+		}
+	}
+}
+
+void orig_check(void) {
+	struct cfs_rq cfs_rq = {0};
+	struct sched_entity sa, sb, sc;
+	struct sched_entity *root;
+
+
+	cfs_rq.tasks_timeline = RB_ROOT_CACHED;
+
+	init_se(&cfs_rq, &sa, 'a', 5, 9);
+	init_se(&cfs_rq, &sb, 'b', 4, 8);
+	init_se(&cfs_rq, &sc, 'c', 6, 7);
+
+	printf("cfs_rq min %ld avg %ld load %ld\n", cfs_rq.min_vruntime, cfs_rq.avg_vruntime, cfs_rq.avg_load);
+
+	root = __node_2_se(cfs_rq.tasks_timeline.rb_root.rb_node);
+	print_se("root", root);
+	if (root->run_node.rb_left)
+		print_se("left", __node_2_se(root->run_node.rb_left));
+	if (root->run_node.rb_right)
+		print_se("right", __node_2_se(root->run_node.rb_right));
+	print_se("picked", pick_eevdf_orig(&cfs_rq));
+}
+
+int main(int argc, char *argv[]) {
+	unsigned int seed = (unsigned int)time(NULL);
+	unsigned long skip_to = 0;
+	if (argc > 1)
+		seed = (unsigned int)atol(argv[1]);
+	srandom(seed);
+	if (argc > 2)
+		skip_to = (unsigned long)atol(argv[2]);
+	printf("Seed: %d\n", seed);
+	
+	test_pick_function(pick_eevdf_improved_ndebug, skip_to);
+	printf("Seed: %d\n", seed);
+}

--=-=-=--
