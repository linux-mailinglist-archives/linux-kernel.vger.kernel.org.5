Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04347E8F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 11:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjKLKb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 05:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjKLKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 05:31:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC82D73
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 02:31:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC18FC433C7;
        Sun, 12 Nov 2023 10:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699785082;
        bh=TxX4txCL/uRk/fD1yN7nT9Vlx5JaDrUWP488dS697wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obpAjzkPT6C0OAAwzG+ymbOcFqzz9sP9aMtBCXnvx1iHXamYbX7dkLMFH0At4iOge
         dDjhxG4mmk+aQt78IEymeXwuoVrVwbNhgUcuVXn713qbmMHDdIOdsHK6/+/XlH9+FU
         uIg9CD1HG13zt+gn5o+DhS7ouCki1IC/XnuI5leZTBtHbImzXwcYfRDHCLL77qaA5t
         pawUMGWf6txMPVV5whqoed3b8Tym6xZNgwrjdmtMg/2uqaAfBfEkhv4sx3729TbUrq
         G4HZySOv4h9k7u35sAOkfyDQqcwAyYiWwwHJWn6cp55CZiyQFRl3rm7RGj5WATEwc4
         1dZVCzh/1izDA==
Date:   Sun, 12 Nov 2023 10:31:12 +0000
From:   Simon Horman <horms@kernel.org>
To:     Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/7] net/sched: taprio: fix too early schedules
 switching
Message-ID: <20231112103112.GK705326@kernel.org>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-2-faizal.abdul.rahim@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231107112023.676016-2-faizal.abdul.rahim@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:20:17AM -0500, Faizal Rahim wrote:
> In the current taprio code for dynamic schedule change,
> admin/oper schedule switching happens immediately when
> should_change_schedules() is true. Then the last entry of
> the old admin schedule stops being valid anymore from
> taprio_dequeue_from_txq’s perspective.
> 
> To solve this, we have to delay the switch_schedules() call via
> the new cycle_time_correction variable. The variable serves 2
> purposes:
> 1. Upon entering advance_sched(), if the value is set to a
> non-initialized value, it indicates that we need to change
> schedule.
> 2. Store the cycle time correction value which will be used for
> negative or positive correction.
> 
> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  net/sched/sch_taprio.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 2e1949de4171..dee103647823 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -41,6 +41,7 @@ static struct static_key_false taprio_have_working_mqprio;
>  #define TXTIME_ASSIST_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST)
>  #define FULL_OFFLOAD_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
>  #define TAPRIO_FLAGS_INVALID U32_MAX
> +#define INIT_CYCLE_TIME_CORRECTION S64_MIN
>  
>  struct sched_entry {
>  	/* Durations between this GCL entry and the GCL entry where the
> @@ -75,6 +76,7 @@ struct sched_gate_list {
>  	ktime_t cycle_end_time;
>  	s64 cycle_time;
>  	s64 cycle_time_extension;
> +	s64 cycle_time_correction;
>  	s64 base_time;
>  };
>  
> @@ -940,8 +942,10 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  	admin = rcu_dereference_protected(q->admin_sched,
>  					  lockdep_is_held(&q->current_entry_lock));
>  
> -	if (!oper)
> +	if (!oper || oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {

Hi Faizal,

The first condition above expects that oper may be NULL, but the line below
dereferences it unconditionally. This doesn't seem correct, one way or the
other.

As flagged by Smatch and Coccinelle.

> +		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
>  		switch_schedules(q, &admin, &oper);
> +	}
>  
>  	/* This can happen in two cases: 1. this is the very first run
>  	 * of this function (i.e. we weren't running any schedule

...
