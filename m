Return-Path: <linux-kernel+bounces-4915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64178183CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4B71C23869
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68F179B0;
	Tue, 19 Dec 2023 08:46:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F1B156E5;
	Tue, 19 Dec 2023 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34EAC1FB;
	Tue, 19 Dec 2023 00:46:48 -0800 (PST)
Received: from [10.57.85.227] (unknown [10.57.85.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 975A33F738;
	Tue, 19 Dec 2023 00:46:01 -0800 (PST)
Message-ID: <581606cc-79ca-4f49-8ae4-cf4a18def0cb@arm.com>
Date: Tue, 19 Dec 2023 08:47:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/23] Documentation: EM: Update with runtime
 modification design
Content-Language: en-US
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-24-lukasz.luba@arm.com>
 <CAB8ipk_BmdOYWKo_b7g=e6LJVyt1=Yo=wuG5dvUtTvNnmCw+Zg@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk_BmdOYWKo_b7g=e6LJVyt1=Yo=wuG5dvUtTvNnmCw+Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/19/23 04:42, Xuewen Yan wrote:
> On Wed, Nov 29, 2023 at 7:11 PM Lukasz Luba <lukasz.luba@arm.com> wrote:

[snip]

>> +
>> +  -> drivers/soc/example/example_em_mod.c
>> +
>> +  01   static void foo_get_new_em(struct device *dev)
>> +  02   {
>> +  03           struct em_perf_table __rcu *runtime_table;
>> +  04           struct em_perf_state *table, *new_table;
>> +  05           struct em_perf_domain *pd;
>> +  06           unsigned long freq;
>> +  07           int i, ret;
>> +  08
>> +  09           pd = em_pd_get(dev);
>> +  10           if (!pd)
>> +  11                   return;
>> +  12
>> +  13           runtime_table = em_allocate_table(pd);
>> +  14           if (!runtime_table)
>> +  15                   return;
>> +  16
>> +  17           new_table = runtime_table->state;
>> +  18
>> +  19           table = em_get_table(pd);
>> +  20           for (i = 0; i < pd->nr_perf_states; i++) {
>> +  21                   freq = table[i].frequency;
>> +  22                   foo_get_power_perf_values(dev, freq, &new_table[i]);
>> +  23           }
>> +  24           em_put_table();
>> +  25
>> +  26           /* Calculate 'cost' values for EAS */
>> +  27           ret = em_dev_compute_costs(dev, table, pd->nr_perf_states);
>> +  28           if (ret) {
>> +  29                   dev_warn(dev, "EM: compute costs failed %d\n", ret);
>> +  30                   em_free_table(runtime_table);
>> +  31                   return;
>> +  32           }
>> +  33
>> +  34           ret = em_dev_update_perf_domain(dev, runtime_table);
>> +  35           if (ret) {
>> +  36                   dev_warn(dev, "EM: update failed %d\n", ret);
>> +  37                   em_free_table(runtime_table);
>> +  38                   return;
>> +  39           }
>> +  40
>> +  41           ctx->runtime_table = runtime_table;
> 
> Because here is ctx, maybe the foo_get_new_em(struct device *dev)
> shoule be foo_get_new_em(struct foo_context *ctx)?

Make sense, I will change that bit. Thanks!

