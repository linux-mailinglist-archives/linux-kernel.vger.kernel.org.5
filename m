Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283C17B3C11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjI2Vki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Vki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:40:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603EAC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:40:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c6193d6bb4so42225ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696023636; x=1696628436; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xChmq8XD1i1sEv4fwoHqPdXvuQFp62Vkv9hFLXi+NfM=;
        b=xEVRQBIN5lx72cEDJ+Z5TjTL4q6l29ADM0ySGK+ChYXAn5OssBOl/FBoqz8tBg/Wit
         4UXpA9M5JhgiTwXaiF7e+ezlynoHIxqwByQyc8rsWPNJuIliSem432WWjtZvso8SLBVN
         Gp0Pr2+qMmBeUW5JD87bL51kogjDLQW621Kw6zEhIBKlO+KX36Xebqz4sK++XBzRFvXI
         cjsAs99LB7K+NGGR3pLzpGEGBgwwEbLrJk9zufCNDMiZiNE/MxVdULCxCjXSx4zbmQ24
         Ih6J9PEsK+ZelWxygvGc/Os4D6fLDD2To1EHP1+Sz8oJEJIszsf682qSJNvecUo2tJzZ
         pwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696023636; x=1696628436;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xChmq8XD1i1sEv4fwoHqPdXvuQFp62Vkv9hFLXi+NfM=;
        b=Se1/KmI2xzdaEFRkbQ/L7TVo1M8g4PK4stC7qmuszhuXVVmPf4XizHiYfYN9n+PhP9
         u7hFjsgD6lQ76ePTUMLqBnWrUB2ugzLWexDWhkWM5RHiC2HYNy0pUeLUan7BMjrORG+c
         9STyYqHYganf11DFvQDi4PY6NVXFjTz+zpUbO5ihp5kjbhtWwEeVJRlSydzZzQgTgLi/
         swAWp4CEoq5SAPwHgwQIJTpdOVPVx1RgTzmRKFOEkMIw+vm841dOGQzidsORB9o1FBLg
         NM8rR6VKsgBjVNglCgWQR7JVHEiu6dO+PryIMIkVtOlX0Z12n5lnHkKC5XXZpC26FVs+
         PvlA==
X-Gm-Message-State: AOJu0Yw2uaXPMVR6ihrTyba6S1UWfXAx5t0WHyrWapN2dSfS3P7WmDjC
        WLAzk1y18el76QwI+nvtuWkXBg==
X-Google-Smtp-Source: AGHT+IGkQQJv4v1VYa5iiVkW42cvZAJyml1NiXgXnzmOqREgAaPUA4e3htYKOeuhsrocKTt9qIVlFg==
X-Received: by 2002:a17:902:fa50:b0:1c5:ca8d:136b with SMTP id lb16-20020a170902fa5000b001c5ca8d136bmr7082plb.14.1696023635688;
        Fri, 29 Sep 2023 14:40:35 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id jj15-20020a170903048f00b001c60a2b5c61sm12301554plb.134.2023.09.29.14.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:40:34 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [PATCH 05/15] sched/fair: Implement an EEVDF like policy
In-Reply-To: <20230531124603.931005524@infradead.org> (Peter Zijlstra's
        message of "Wed, 31 May 2023 13:58:44 +0200")
References: <20230531115839.089944915@infradead.org>
        <20230531124603.931005524@infradead.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Fri, 29 Sep 2023 14:40:31 -0700
Message-ID: <xm265y3sodyo.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> +
> +/*
> + * Earliest Eligible Virtual Deadline First
> + *
> + * In order to provide latency guarantees for different request sizes
> + * EEVDF selects the best runnable task from two criteria:
> + *
> + *  1) the task must be eligible (must be owed service)
> + *
> + *  2) from those tasks that meet 1), we select the one
> + *     with the earliest virtual deadline.
> + *
> + * We can do this in O(log n) time due to an augmented RB-tree. The
> + * tree keeps the entries sorted on service, but also functions as a
> + * heap based on the deadline by keeping:
> + *
> + *  se->min_deadline = min(se->deadline, se->{left,right}->min_deadline)
> + *
> + * Which allows an EDF like search on (sub)trees.
> + */
> +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> +{
> +	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
> +	struct sched_entity *curr = cfs_rq->curr;
> +	struct sched_entity *best = NULL;
> +
> +	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> +		curr = NULL;
> +
> +	while (node) {
> +		struct sched_entity *se = __node_2_se(node);
> +
> +		/*
> +		 * If this entity is not eligible, try the left subtree.
> +		 */
> +		if (!entity_eligible(cfs_rq, se)) {
> +			node = node->rb_left;
> +			continue;
> +		}
> +
> +		/*
> +		 * If this entity has an earlier deadline than the previous
> +		 * best, take this one. If it also has the earliest deadline
> +		 * of its subtree, we're done.
> +		 */
> +		if (!best || deadline_gt(deadline, best, se)) {
> +			best = se;
> +			if (best->deadline == best->min_deadline)
> +				break;
> +		}
> +
> +		/*
> +		 * If the earlest deadline in this subtree is in the fully
> +		 * eligible left half of our space, go there.
> +		 */
> +		if (node->rb_left &&
> +		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
> +			node = node->rb_left;
> +			continue;
> +		}
> +
> +		node = node->rb_right;
> +	}

I believe that this can fail to actually find the earliest eligible
deadline, because the earliest deadline (min_deadline) can be in the
right branch, but that se isn't eligible, and the actual target se is in
the left branch. A trivial 3-se example with the nodes represented by
(vruntime, deadline, min_deadline):

   (5,9,7)
 /        \
(4,8,8)  (6,7,7)

AIUI, here the EEVDF pick should be (4,8,8), but pick_eevdf() will
instead pick (5,9,7), because it goes into the right branch and then
fails eligibility.

I'm not sure how much of a problem this is in practice, either in
frequency or severity, but it probably should be mentioned if it's
an intentional tradeoff.



Thinking out loud, I think that it would be sufficient to recheck via something like

for_each_sched_entity(best) {
	check __node_2_se(best->rb_left)->min_deadline, store in actual_best
}

for the best min_deadline, and then go do a heap lookup in actual_best
to find the se matching that min_deadline.

I think this pass could then be combined with our initial descent for
better cache behavior by keeping track of the best rb_left->min_deadline
each time we take a right branch. We still have to look at up to ~2x the
nodes, but I don't think that's avoidable? I'll expand my quick hack I
used to test my simple case into a something of a stress tester and try
some implementations.
