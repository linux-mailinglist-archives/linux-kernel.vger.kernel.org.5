Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A128377C1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjHNUve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjHNUvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:51:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699DEBB;
        Mon, 14 Aug 2023 13:51:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ECC4237B;
        Mon, 14 Aug 2023 20:51:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ECC4237B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1692046276; bh=YaOh+Llh3YvNhYzt3jIakLsWO63bI8qmIxVIAbCca9Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j+EymPLVTv/QpiSf7x3fbHdorBdnO8Jex9jGMZeOGr4vgbA5GSmiqhfwSHUWbmnRG
         UYB9+wrgDVAt0RYNpxwwCj7L9pp8CQMOncz8qHavYTaYDCxLvcjQM7o2Ps/D8vrmxx
         +dZl0doZujeYK4E126u91FKlh9BrjjQfOt5C4C0h4A3L2L/hJv9fAqMRhGe39Y6CRq
         prDfFavjYwClJ/A5dC7jtV+4UJ1EEsgqdH2+RxLfkAre3nJ29FvWS8sCGSw2o01NrZ
         +ec8936o0Y15bVx0IezkeCXVrehzS7ZEaloORuJ57GIR9EoC8L5FumCJYciXRNf4Z9
         ngz6Oa7Rr85bg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [RFC PATCH v2 2/5] mm: Add policy_name to identify OOM policies
In-Reply-To: <20230810081319.65668-3-zhouchuyi@bytedance.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-3-zhouchuyi@bytedance.com>
Date:   Mon, 14 Aug 2023 14:51:15 -0600
Message-ID: <87h6p1uz3w.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chuyi Zhou <zhouchuyi@bytedance.com> writes:

> This patch adds a new metadata policy_name in oom_control and report it
> in dump_header(), so we can know what has been the selection policy. In
> BPF program, we can call kfunc set_oom_policy_name to set the current
> user-defined policy name. The in-kernel policy_name is "default".
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  include/linux/oom.h |  7 +++++++
>  mm/oom_kill.c       | 42 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 3 deletions(-)

So I have a possibly dumb question here...

> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 7d0c9c48a0c5..69d0f2ec6ea6 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -22,6 +22,10 @@ enum oom_constraint {
>  	CONSTRAINT_MEMCG,
>  };
>  
> +enum {
> +	POLICY_NAME_LEN = 16,
> +};

We've defined our name length, fine...

>  /*
>   * Details of the page allocation that triggered the oom killer that are used to
>   * determine what should be killed.
> @@ -52,6 +56,9 @@ struct oom_control {
>  
>  	/* Used to print the constraint info. */
>  	enum oom_constraint constraint;
> +
> +	/* Used to report the policy info. */
> +	char policy_name[POLICY_NAME_LEN];
>  };

...that is the length of the array, appended to the structure...

>  extern struct mutex oom_lock;
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 255c9ef1d808..3239dcdba4d7 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -443,6 +443,35 @@ static int dump_task(struct task_struct *p, void *arg)
>  	return 0;
>  }
>  
> +__bpf_kfunc void set_oom_policy_name(struct oom_control *oc, const char *src, size_t sz)
> +{
> +	memset(oc->policy_name, 0, sizeof(oc->policy_name));
> +
> +	if (sz > POLICY_NAME_LEN)
> +		sz = POLICY_NAME_LEN;
> +
> +	memcpy(oc->policy_name, src, sz);
> +}

This truncates the name, possibly leaving it without a terminating NUL
character, right?

> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "kfuncs which will be used in BPF programs");
> +
> +__weak noinline void bpf_set_policy_name(struct oom_control *oc)
> +{
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(bpf_oom_policy_kfunc_ids)
> +BTF_ID_FLAGS(func, set_oom_policy_name)
> +BTF_SET8_END(bpf_oom_policy_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set bpf_oom_policy_kfunc_set = {
> +	.owner          = THIS_MODULE,
> +	.set            = &bpf_oom_policy_kfunc_ids,
> +};
> +
>  /**
>   * dump_tasks - dump current memory state of all system tasks
>   * @oc: pointer to struct oom_control
> @@ -484,8 +513,8 @@ static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
>  
>  static void dump_header(struct oom_control *oc, struct task_struct *p)
>  {
> -	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
> -		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
> +	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, policy_name=%s, oom_score_adj=%hd\n",
> +		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order, oc->policy_name,

...and if the policy name is unterminated, this print will run off the
end of the structure.

Am I missing something here?

Thanks,

jon

