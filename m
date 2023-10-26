Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0240B7D7CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343862AbjJZGZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZGZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:25:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA72189;
        Wed, 25 Oct 2023 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698301520; x=1729837520;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9dwbtHL/Eb13EI84Wvbp0wfhWl3liifdx/FKkioH6mA=;
  b=F9atq2u77tFrIZNDO7CQwDMVUcWaxn1MkT7a3dLWNV0PX4jBWeLVdU1c
   tZdrDVlYAVnFKEpEHQ0n7RPHCeWoVJWc1Q2aSE79k2PlKkI9QO9POOgAW
   rzba+wi4mKSZF4TgIri+rdX867n9dSzIqP2/t+b2GXzWr/qxJi4ybZQcb
   SZdyLh9QiAnMsy4qqfqs4oRG5Lq1DbUkkdUoCsUCtlyxG7tGLzCzfK/A8
   eZM9AeLA8KzHALf7FeVskvacV+POc4jdoEd0jm3DvAgq/fZ2oPrQ+Biz4
   B6iBTqKPu0eRTUPNxSUJOIqOdfWlF7KTXoQ+Gww3K+Ovr25c79kMi/4+Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="418597908"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="418597908"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 23:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="393267"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.211.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 23:25:06 -0700
Message-ID: <f0aecb28-6f82-456e-a319-8d13a2e313b6@intel.com>
Date:   Thu, 26 Oct 2023 09:25:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: cqhci: Be more verbose in error irq handler
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, upstream@semihalf.com
References: <20231016095610.1095084-1-korneld@chromium.org>
 <613c51f0-c32e-4de5-9627-525d92fb06ed@intel.com>
 <CAD=NsqybNrf-=9=5wvoj+9MT3xK3SbX7nDk3N3VLBMyA_u3KTQ@mail.gmail.com>
 <78bb4ad2-853a-4ed4-9998-c4e1122545b6@intel.com>
 <CAD=NsqxDA=usDRa-KV48RkeEROARsw8JqBF5vyJcEEV5r_Fg1w@mail.gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAD=NsqxDA=usDRa-KV48RkeEROARsw8JqBF5vyJcEEV5r_Fg1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/23 11:01, Kornel Dulęba wrote:
> On Mon, Oct 23, 2023 at 1:38 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 20/10/23 11:53, Kornel Dulęba wrote:
>>> On Fri, Oct 20, 2023 at 9:41 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 16/10/23 12:56, Kornel Dulęba wrote:
>>>>> There are several reasons for controller to generate an error interrupt.
>>>>> They include controller<->card timeout, and CRC mismatch error.
>>>>> Right now we only get one line in the logs stating that CQE recovery was
>>>>> triggered, but with no information about what caused it.
>>>>> To figure out what happened be more verbose and dump the registers from
>>>>> irq error handler logic.
>>>>> This matches the behaviour of the software timeout logic, see
>>>>> cqhci_timeout.
>>>>>
>>>>> Signed-off-by: Kornel Dulęba <korneld@chromium.org>
>>>>> ---
>>>>>  drivers/mmc/host/cqhci-core.c | 5 +++--
>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
>>>>> index b3d7d6d8d654..33abb4bd53b5 100644
>>>>> --- a/drivers/mmc/host/cqhci-core.c
>>>>> +++ b/drivers/mmc/host/cqhci-core.c
>>>>> @@ -700,8 +700,9 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
>>>>>
>>>>>       terri = cqhci_readl(cq_host, CQHCI_TERRI);
>>>>>
>>>>> -     pr_debug("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d TERRI: 0x%08x\n",
>>>>> -              mmc_hostname(mmc), status, cmd_error, data_error, terri);
>>>>> +     pr_warn("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d\n",
>>>>> +              mmc_hostname(mmc), status, cmd_error, data_error);
>>>>> +     cqhci_dumpregs(cq_host);
>>>>
>>>> For debugging, isn't dynamic debug seems more appropriate?
>>>
>>> Dynamic debug is an option, but my personal preference would be to
>>> just log more info in the error handler.
>>
>> Interrupt handlers can get called very rapidly, so some kind of rate
>> limiting should be used if the message is unconditional.  Also you need
>> to provide actual reasons for your preference.
>>
>> For dynamic debug of the register dump, something like below is
>> possible.
>>
>> #define cqhci_dynamic_dumpregs(cqhost) \
>>         _dynamic_func_call_no_desc("cqhci_dynamic_dumpregs", cqhci_dumpregs, cqhost)
>>
> Fair point.
> The reason I'm not a fan of using dynamic debug for this is that my
> goal here is to improve the warning/error logging information that we
> get from systems running in production.
> I.e. if we get a lot of "running CQE recovery" messages, at the very
> least I'd like to know what is causing them.

So you are saying you want to collect debug information from production
systems, but don't want to use dynamic debug to do it?

>>> To give you some background.
>>> We're seeing some "running CQE recovery" lines in the logs, followed
>>> by a dm_verity mismatch error.
>>> The reports come from the field, with no feasible way to reproduce the
>>> issue locally.
>>
>> If it is a software error, some kind of error injection may well
>> reproduce it.  Also if it is a hardware error that only happens
>> during recovery, error injection could increase the likelihood of
>> reproducing it.
> 
> We tried software injection and it didn't yield any results.
> We're currently looking into "injecting" hw errors by using a small
> burst field generator to interfere with transfers on the data line
> directly.

I just tried instrumenting a driver to inject CRC errors and it
revealed several CQE recovery issues, including spurious TCN for
tag 31.  I will send some patches when they are ready.

>>
>>>
>>> I'd argue that logging only the info that CQE recovery was executed is
>>> not particularly helpful for someone looking into those logs.
>>
>> As the comment says, that message is there because recovery reduces
>> performance, it is not to aid debugging per se.
>>
>>> Ideally we would have more data about the state the controller was in
>>> when the error happened, or at least what caused the recovery to be
>>> triggered.
>>> The question here is how verbose should we be in this error scenario.
>>> Looking at other error scenarios, in the case of a software timeout
>>> we're dumping the controller registers. (cqhci_timeout)
>>
>> Timeout means something is broken - either the driver, the cq engine
>> or the card.  On the other hand, an error interrupt is most likely a
>> CRC error which is not unexpected occasionally, due to thermal drift
>> or perhaps interference.
> 
> Right, but my point is that we don't know what triggered CQE recovery.

True, although probably a CRC error.

> 
>>
>>> Hence I thought that I'd be appropriate to match that and do the same
>>> in CQE recovery logic.
>>
>> It needs to be consistent. There are other pr_debugs, such as:
>>
>>                 pr_debug("%s: cqhci: Failed to clear tasks\n",
>>                 pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
>>                 pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname(mmc));
>>
>> which should perhaps be treated the same.
>>
>> And there are no messages for errors from the commands in
>> mmc_cqe_recovery().
> 
> How about this.
> As a compromise would it be okay to just do a single pr_warn directly
> from cqhci_error_irq.

Sure, printk_ratelimited() or __ratelimit()

> We could simply promote the existing pr_debug to pr_warn at the
> beginning of that function.
> This would tell us what triggered the recovery. (controller timeout,
> CRC mismatch)
> We can also consider removing the "running CQE recovery" print for the
> sake of brevity.

No, that serves a different purpose.

> The only downside of this that I can see is that we'd be running the
> logic from the interrupt handler directly, but I can't see an easy way
> around that.
> What do you think?

Should be OK with rate limiting.

>>
>>>
>>>>
>>>>>
>>>>>       /* Forget about errors when recovery has already been triggered */
>>>>>       if (cq_host->recovery_halt)
>>>>
>>

