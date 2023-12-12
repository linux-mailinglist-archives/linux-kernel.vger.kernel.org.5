Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE1C80F5BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376742AbjLLSuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376732AbjLLSt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:49:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 002DBBD;
        Tue, 12 Dec 2023 10:50:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17E371FB;
        Tue, 12 Dec 2023 10:50:50 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C0133F762;
        Tue, 12 Dec 2023 10:50:01 -0800 (PST)
Message-ID: <fbee5e3b-4c32-443a-b756-943762ae07b8@arm.com>
Date:   Tue, 12 Dec 2023 19:50:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/23] PM: EM: Refactor how the EM table is allocated
 and populated
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-8-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231129110853.94344-8-lukasz.luba@arm.com>
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
> Split the process of allocation and data initialization for the EM table.
> The upcoming changes for modifiable EM will use it.
> 
> This change is not expected to alter the general functionality.

NIT: IMHO, I guess you wanted to say: "No functional changes
introduced"? I.e. all not only general functionality ...

[...]

>  static int em_create_pd(struct device *dev, int nr_states,
> @@ -234,11 +234,15 @@ static int em_create_pd(struct device *dev, int nr_states,
>  			return -ENOMEM;
>  	}
>  
> -	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
> -	if (ret) {
> -		kfree(pd);
> -		return ret;
> -	}
> +	pd->nr_perf_states = nr_states;

Why does `pd->nr_perf_states = nr_states;` have to move from
em_create_perf_table() to em_create_pd()?

> +
> +	ret = em_allocate_perf_table(pd, nr_states);
> +	if (ret)
> +		goto free_pd;
> +
> +	ret = em_create_perf_table(dev, pd, pd->table, nr_states, cb, flags);

If you set it in em_create_pd() then you can use 'pd->nr_perf_states' in
em_create_perf_table() and doesn't have to pass `nr_states`.

[...]
