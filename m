Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D1977E210
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbjHPNBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbjHPNAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:00:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6231D1BFB;
        Wed, 16 Aug 2023 06:00:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FCDBD75;
        Wed, 16 Aug 2023 06:01:26 -0700 (PDT)
Received: from [192.168.178.38] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5B2D3F6C4;
        Wed, 16 Aug 2023 06:00:41 -0700 (PDT)
Message-ID: <07436e93-7339-e91c-b169-f0ad89cdbc29@arm.com>
Date:   Wed, 16 Aug 2023 15:00:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/12] Introduce runtime modifiable Energy Model
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        mhiramat@kernel.org
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230721155022.2339982-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 17:50, Lukasz Luba wrote:
> Hi all,
> 
> This patch set adds a new feature which allows to modify Energy Model (EM)
> power values at runtime. It will allow to better reflect power model of
> a recent SoCs and silicon. Different characteristics of the power usage
> can be leveraged and thus better decisions made during task placement in EAS.
> 
> It's part of feature set know as Dynamic Energy Model. It has been presented
> and discussed recently at OSPM2023 [3]. This patch set implements the 1st
> improvement for the EM.
> 
> The concepts:
> 1. The CPU power usage can vary due to the workload that it's running or due
> to the temperature of the SoC. The same workload can use more power when the
> temperature of the silicon has increased (e.g. due to hot GPU or ISP).
> In such situation or EM can be adjusted and reflect the fact of increased
> power usage. That power increase is due to a factor called static power
> (sometimes called simply: leakage). The CPUs in recent SoCs are different.
> We have heterogeneous SoCs with 3 (or even 4) different microarchitectures.
> They are also built differently with High Performance (HP) cells or
> Low Power (LP) cells. They are affected by the temperature increase
> differently: HP cells have bigger leakage. The SW model can leverage that
> knowledge.

IMHO it's important to note that this feature will add support for a
'single EM which can be changed during runtime according to the
workload' design.
Instead of the 'single and during the entire runtime static EM' design
we have today.
It won't support a 'multiple EMs and tasks can choose which model to use
based on some form of classification' design.

> 2. It is also possible to change the EM to better reflect the currently
> running workload. Usually the EM is derived from some average power values
> taken from experiments with benchmark (e.g. Dhrystone). The model derived
> from such scenario might not represent properly the workloads usually running
> on the device. Therefore, runtime modification of the EM allows to switch to
> a different model, when there is a need.
> 3. The EM can be adjusted after boot, when all the modules are loaded and
> more information about the SoC is available e.g. chip binning. This would help
> to better reflect the silicon characteristics. Thus, this EM modification
> API allows it now. It wasn't possible in the past and the EM had to be
> 'set in stone'.

Testing perspective:

I know that there is a test module with which we can test the new
em_dev_update_perf_domain() together with CPU hotplug etc.

What's missing is IMHO a test case showing the benefit of this new
feature for at least one of the use-cases (1. - 3.) described above.

Would it be possible to test a workload W at normal temperature with
EM_1 then head up the system and use EM_2 and spot performance/energy
consumption benefits against a vanilla system (case 1.) on Pixel6? This
would actually proof that this more on code complexity pays off.

--

We know that Google uses something similar in there Android kernel for
Pixel7 (CONFIG_PIXEL_EM). The EM is chosen from different EM profiles in
find_energy_efficient_cpu() -> compute_energy() -> em_cpu_energy().

In case we would have evidence that Google is switching their
proprietary implementation to this mainline one in the Android kernel
this would definitely also boost the confidence that we do need this
feature in mainline right now.

> Some design details:
> The internal mechanisms for the memory allocation are handled internally in the 
> EM. Kernel modules can just call the new API to update the EM data and the 
> new memory would be provided and owned by the EM. The EM memory is used by
> EAS, which impacts those design decisions. The EM writers are protected by
> a mutex. This new runtime modified EM table is protected using RCU mechanism,
> which fits the current EAS hot path (which already uses RCU read lock).
> The unregister API handles only non-CPU (e.g. GPU, ISP) devices and uses the
> same mutex as EM modifiers to make sure the memory is safely freed.
> 
> More detailed explanation and background can be found in presentations
> during LPC2022 [1][2] or in the documentation patches.
> 
> The time cost to update EM for 11 OPPs can be found here [6]. It's roughly
> 1.5us per 1 OPP while doing this on Little CPU at max frequency (1.8GHz).

I would list those results in this cover letter in a processed form and
also mention the target platform (Pixel6).

[...]

