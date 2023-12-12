Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A342780F5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjLLSt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376685AbjLLStZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:49:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1749CF4;
        Tue, 12 Dec 2023 10:49:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F5451FB;
        Tue, 12 Dec 2023 10:50:17 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D4D43F762;
        Tue, 12 Dec 2023 10:49:28 -0800 (PST)
Message-ID: <985618de-73cf-4b54-aef4-6e7bbfe86b17@arm.com>
Date:   Tue, 12 Dec 2023 19:49:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/23] PM: EM: Refactor em_pd_get_efficient_state() to
 be more flexible
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-5-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231129110853.94344-5-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 12:08, Lukasz Luba wrote:
> The Energy Model (EM) is going to support runtime modification. There
> are going to be 2 EM tables which store information. This patch aims
> to prepare the code to be generic and use one of the tables. The function
> will no longer get a pointer to 'struct em_perf_domain' (the EM) but
> instead a pointer to 'struct em_perf_state' (which is one of the EM's
> tables).
I thought the 2 EM tables design is gone?

IMHO it would be less code changes and hence a more enjoyable review
experience if you would add the 'modifiable' feature to the existing EM
(1) and not add (2) and then remove (1) in [21/23].


 struct em_perf_domain {
-	struct em_perf_state *table;                <-- (1)
 	struct em_perf_table __rcu *runtime_table;  <-- (2)

> Prepare em_pd_get_efficient_state() for the upcoming changes and
> make it possible to re-use. Return an index for the best performance

s/make it possible to re-use/make it possible to be re-used ?

> state for a given EM table. The function arguments that are introduced
> should allow to work on different performance state arrays. The caller of
> em_pd_get_efficient_state() should be able to use the index either
> on the default or the modifiable EM table.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/linux/energy_model.h | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b9caa01dfac4..8069f526c9d8 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -175,33 +175,35 @@ void em_dev_unregister_perf_domain(struct device *dev);
>  
>  /**
>   * em_pd_get_efficient_state() - Get an efficient performance state from the EM
> - * @pd   : Performance domain for which we want an efficient frequency
> - * @freq : Frequency to map with the EM
> + * @state:		List of performance states, in ascending order

(3)

> + * @nr_perf_states:	Number of performance states
> + * @freq:		Frequency to map with the EM
> + * @pd_flags:		Performance Domain flags
>   *
>   * It is called from the scheduler code quite frequently and as a consequence
>   * doesn't implement any check.
>   *
> - * Return: An efficient performance state, high enough to meet @freq
> + * Return: An efficient performance state id, high enough to meet @freq
>   * requirement.
>   */
> -static inline
> -struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> -						unsigned long freq)
> +static inline int
> +em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
> +			  unsigned long freq, unsigned long pd_flags)

(3) but em_pd_get_efficient_state(struct em_perf_state *table
                                                        ^^^^^
[...]
