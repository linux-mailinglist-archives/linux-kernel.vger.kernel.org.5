Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B84980F5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376730AbjLLSu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376685AbjLLSuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:50:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EF691A1;
        Tue, 12 Dec 2023 10:50:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CC581FB;
        Tue, 12 Dec 2023 10:51:03 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CE553F762;
        Tue, 12 Dec 2023 10:50:14 -0800 (PST)
Message-ID: <2236f098-b889-4d70-b863-11a3f246889c@arm.com>
Date:   Tue, 12 Dec 2023 19:50:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/23] PM: EM: Add API for updating the runtime
 modifiable EM
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-12-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231129110853.94344-12-lukasz.luba@arm.com>
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

[...]

> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 489a358b9a00..614891fde8df 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -221,6 +221,52 @@ static int em_allocate_perf_table(struct em_perf_domain *pd,
>  	return 0;
>  }
>  
> +/**
> + * em_dev_update_perf_domain() - Update runtime EM table for a device
> + * @dev		: Device for which the EM is to be updated
> + * @table	: The new EM table that is going to used from now

s/going to used/going to be used

> + *
> + * Update EM runtime modifiable table for the @dev using the privided @table.

s/privided/provided

> + *
> + * This function uses mutex to serialize writers, so it must not be called
> + * from non-sleeping context.
> + *
> + * Return 0 on success or a proper error in case of failure.
> + */
> +int em_dev_update_perf_domain(struct device *dev,
> +			      struct em_perf_table __rcu *new_table)
> +{
> +	struct em_perf_table __rcu *old_table;
> +	struct em_perf_domain *pd;
> +
> +	/*
> +	 * The lock serializes update and unregister code paths. When the
> +	 * EM has been unregistered in the meantime, we should capture that
> +	 * when entering this critical section. It also makes sure that

What do you want to capture here? You want to block in this moment,
right? Don't understand the 2. sentence here.

[...]
