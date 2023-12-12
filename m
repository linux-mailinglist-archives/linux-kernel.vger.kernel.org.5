Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896F380F569
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjLLSWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjLLSWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:22:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39BFEA7;
        Tue, 12 Dec 2023 10:22:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D329FEC;
        Tue, 12 Dec 2023 10:23:14 -0800 (PST)
Received: from [10.1.35.59] (e133649.arm.com [10.1.35.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F72A3F762;
        Tue, 12 Dec 2023 10:22:25 -0800 (PST)
Message-ID: <e1c7edc6-440b-467e-9552-afa40cf4ed67@arm.com>
Date:   Tue, 12 Dec 2023 18:22:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
To:     Qais Yousef <qyousef@layalina.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <47ef274b-d9cc-4f4f-8134-2dced46005fa@arm.com>
 <20231212123535.3yns5f4b6awiuesk@airbuntu>
Content-Language: en-US
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20231212123535.3yns5f4b6awiuesk@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 12:35, Qais Yousef wrote:
> On 12/12/23 11:46, Dietmar Eggemann wrote:
>> On 08/12/2023 02:52, Qais Yousef wrote:
>>> Due to the way code is structured, it makes a lot of sense to trigger
>>> cpufreq_update_util() from update_load_avg(). But this is too aggressive
>>> as in most cases we are iterating through entities in a loop to
>>> update_load_avg() in the hierarchy. So we end up sending too many
>>> request in an loop as we're updating the hierarchy.
>>
>> But update_load_avg() calls cfs_rq_util_change() which only issues a
>> cpufreq_update_util() call for the root cfs_rq?
> 
> Yes I've noticed that and wondered. Maybe my analysis was flawed and I was just
> hitting the issue of iowait boost request conflicting with update_load_avg()
> request.
> 
> Let me have another look. I think we'll still end up needing to take the update
> out of util_avg to be able to combine the two calls.

I agree. Currently it does not express the intention clearly. We only 
want to update the root CFS but the code was written in a misleading way 
that suggests we want to update for every cfs_rq. A single update at the 
end looks much nicer and makes other patches easier.

Hongyan
