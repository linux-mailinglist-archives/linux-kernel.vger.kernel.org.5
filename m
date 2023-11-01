Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD007DE09E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 13:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjKAMA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjKAMAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:00:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0454E120;
        Wed,  1 Nov 2023 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698840046; x=1730376046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E+Uh1OHEdBFabkdiVD2/Wli1AlPdaNL2ak9CEXe2Saw=;
  b=B4rdbg+Nsd8ncXuV/Txkhm8DXuf0vSQ6A+fnDXu9IfoNXTWNGrVftjeR
   OWvyMAX5JolsgmndvGwyI5vOdDo0nUjt6fP7sS97l5FFgR8Fi0uohlBTO
   sI5dmOuS25Mw55GIcK017srB1TL+lqA/6SitF5qFAbKzVnVSDLZjjA2ej
   73I4oWzgdGkHtsINSf1b0aHEs9Mp4Eodg0wljPLNYf6fhe9yisddF9b7Y
   5RpvaKoBipNi33toXMjVBdyValfXOJdF2CW0AU3JHSzHMl21LEc7FEhwe
   iaPuayl9QD8HT42dbl9w0nzliidBUhZ5RXQVQDaoeadw0LMxJkOYiXfC2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="373522179"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="373522179"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 05:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1092330528"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="1092330528"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.17])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 05:00:43 -0700
Message-ID: <638bb5ac-6543-477c-8dd1-bff8ac8d29cb@intel.com>
Date:   Wed, 1 Nov 2023 14:00:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: cqhci: Add a quirk to clear stale TC
Content-Language: en-US
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>
References: <20231027145623.2258723-1-korneld@chromium.org>
 <20231027145623.2258723-2-korneld@chromium.org>
 <e7c12e07-7540-47ea-8891-2cec73d58df1@intel.com>
 <CAD=NsqxXP+SjH-ud8sjHD5y_LxZGUDnwHNPbzr_0RPwqVrwpPw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAD=NsqxXP+SjH-ud8sjHD5y_LxZGUDnwHNPbzr_0RPwqVrwpPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 13:31, Kornel Dulęba wrote:
> On Mon, Oct 30, 2023 at 8:31 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 27/10/23 17:56, Kornel Dulęba wrote:
>>> This fix addresses a stale task completion event issued right after the
>>> CQE recovery. As it's a hardware issue the fix is done in form of a
>>> quirk.
>>>
>>> When error interrupt is received the driver runs recovery logic is run.
>>> It halts the controller, clears all pending tasks, and then re-enables
>>> it. On some platforms a stale task completion event is observed,
>>> regardless of the CQHCI_CLEAR_ALL_TASKS bit being set.
>>>
>>> This results in either:
>>> a) Spurious TC completion event for an empty slot.
>>> b) Corrupted data being passed up the stack, as a result of premature
>>>    completion for a newly added task.
>>>
>>> To fix that re-enable the controller, clear task completion bits,
>>> interrupt status register and halt it again.
>>> This is done at the end of the recovery process, right before interrupts
>>> are re-enabled.
>>>
>>> Signed-off-by: Kornel Dulęba <korneld@chromium.org>
>>> ---
>>>  drivers/mmc/host/cqhci-core.c | 42 +++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/cqhci.h      |  1 +
>>>  2 files changed, 43 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
>>> index b3d7d6d8d654..e534222df90c 100644
>>> --- a/drivers/mmc/host/cqhci-core.c
>>> +++ b/drivers/mmc/host/cqhci-core.c
>>> @@ -1062,6 +1062,45 @@ static void cqhci_recover_mrqs(struct cqhci_host *cq_host)
>>>  /* CQHCI could be expected to clear it's internal state pretty quickly */
>>>  #define CQHCI_CLEAR_TIMEOUT          20
>>>
>>> +/*
>>> + * During CQE recovery all pending tasks are cleared from the
>>> + * controller and its state is being reset.
>>> + * On some platforms the controller sets a task completion bit for
>>> + * a stale(previously cleared) task right after being re-enabled.
>>> + * This results in a spurious interrupt at best and corrupted data
>>> + * being passed up the stack at worst. The latter happens when
>>> + * the driver enqueues a new request on the problematic task slot
>>> + * before the "spurious" task completion interrupt is handled.
>>> + * To fix it:
>>> + * 1. Re-enable controller by clearing the halt flag.
>>> + * 2. Clear interrupt status and the task completion register.
>>> + * 3. Halt the controller again to be consistent with quirkless logic.
>>> + *
>>> + * This assumes that there are no pending requests on the queue.
>>> + */
>>> +static void cqhci_quirk_clear_stale_tc(struct cqhci_host *cq_host)
>>> +{
>>> +     u32 reg;
>>> +
>>> +     WARN_ON(cq_host->qcnt);
>>> +     cqhci_writel(cq_host, 0, CQHCI_CTL);
>>> +     if ((cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)) {
>>> +             pr_err("%s: cqhci: CQE failed to exit halt state\n",
>>> +                     mmc_hostname(cq_host->mmc));
>>> +     }
>>> +     reg = cqhci_readl(cq_host, CQHCI_TCN);
>>> +     cqhci_writel(cq_host, reg, CQHCI_TCN);
>>> +     reg = cqhci_readl(cq_host, CQHCI_IS);
>>> +     cqhci_writel(cq_host, reg, CQHCI_IS);
>>> +
>>> +     /*
>>> +      * Halt the controller again.
>>> +      * This is only needed so that we're consistent across quirk
>>> +      * and quirkless logic.
>>> +      */
>>> +     cqhci_halt(cq_host->mmc, CQHCI_FINISH_HALT_TIMEOUT);
>>> +}
>>
>> Thanks a lot for tracking this down!
>>
>> It could be that the "un-halt" starts a task, so it would be
>> better to force the "clear" to work if possible, which
>> should be the case if CQE is disabled.
>>
>> Would you mind trying the code below?  Note the increased
>> CQHCI_START_HALT_TIMEOUT helps avoid trying to clear tasks
>> when CQE has not halted.
> 
> Sure, I'll try it out tomorrow, as I don't have access to the DUT today.
> BTW do we even need to halt the controller in the recovery_finish logic?
> It has already been halted in recovery_start, I guess it could be
> there in case the recovery_start halt didn't work.
> But in that case shouldn't we do this disable/re-enable dance in recovery_start?

"Halt" might be waiting on an operation to finish, so the STOP
command is meant to help bring that to a conclusion.

