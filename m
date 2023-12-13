Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B10811045
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378152AbjLMLgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjLMLgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:36:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD3DC26A1;
        Wed, 13 Dec 2023 03:34:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFF58C15;
        Wed, 13 Dec 2023 03:35:03 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBA133F738;
        Wed, 13 Dec 2023 03:34:15 -0800 (PST)
Message-ID: <0640a9bf-b864-45ef-ab39-14b0e85ff9ad@arm.com>
Date:   Wed, 13 Dec 2023 12:34:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/23] Introduce runtime modifiable Energy Model
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <d920867d-5572-48c3-bd54-b9e989ab6bd5@arm.com>
 <ec8dc77f-364c-443b-a63d-35a2e37d2ccc@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <ec8dc77f-364c-443b-a63d-35a2e37d2ccc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2023 10:23, Lukasz Luba wrote:
> Hi Dietmar,
> 
> Thank you for the review, I will go one-by-one to respond
> your comments in patches as well. First comments are below.
> 
> On 12/12/23 18:48, Dietmar Eggemann wrote:
>> On 29/11/2023 12:08, Lukasz Luba wrote:

[...]

>>> Changelog:
>>> v5:
>>> - removed 2 tables design
>>> - have only one table (runtime_table) used also in thermal (Wei, Rafael)
>>
>> Until v4 you had 2 EM's, the static and the modifiable (runtime). Now in
>> v5 this changed to only have one, the modifiable. IMHO it would be
>> better to change the existing table to be modifiable rather than staring
>> with two EM's and then removing the static one. I assume you end up with
>> way less code changes and the patch-set will become easier to digest for
>> reviewers.
> 
> The patches are structured in this way following Daniel's recommendation
> I got when I was adding similar big changes to EM in 2020 (support all
> devices in kernel). The approach is as follows:
> 0. Do some basic clean-up/refactoring if needed for a new feature, to
>    re-use some code if possible in future
> 1. Introduce new feature next to the existing one
> 2. Add API and all needed infrastructure (structures, fields) for
>    drivers
> 3. Re-wire the existing drivers/frameworks to the new feature via new
>    API; ideally keep 1 patch per driver so the maintainer can easily
>    grasp the changes and ACK it, because it will go via different tree
>    (Rafael's tree); in case of some code clash in the driver's code
>    during merge - it will be a single driver so easier to handle
> 4. when all drivers and frameworks are wired up with the new feature
>    remove the old feature (structures, fields, APIs, etc)
> 5. Update the documentation with new latest state of desing
> 
> In this approach the patches are less convoluted. Because if I remove
> the old feature and add new in a single patch (e.g. the main structure)
> that patch will have to modify all drivers to still compile. It
> would be a big messy patch for this re-design.
> 
> I can see in some later comment from Rafael that he is OK with current
> patch set structure.

OK, in case Rafael and Daniel prefer this, then it's fine.

I just find it weird that we now have

70 struct em_perf_domain {
71         struct em_perf_table __rcu *runtime_table;
                                       ^^^^^^^^^^^^^

as the only EM table.
