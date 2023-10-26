Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C57D7E31
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbjJZIOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344444AbjJZIOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:14:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA442B8;
        Thu, 26 Oct 2023 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698308078; x=1729844078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MFaMMnglpoDnzneeiuDNtTRmMj3rXcOLeCMqZ4UP8s4=;
  b=YAnEEhXzVo7A+Dno6tUEBnE0R4LBZAH9Qap7ccBZjGQ572KqKjY/tlWW
   SaVsILfzULfri+ykymwGuLzzKiIPuxvKy35mGzYQAlLO7T6WRCZwJeYk7
   1/tUDzBnMxh31waR+J6Xv2dSSM4bc3dsMDK5iL6SvvKsIDG+G9qBCi8SJ
   J2dAV/MFB3inAfnY/lRlUNNTiP1m7qQeuMoOQInhwuCCMwzfou/N8h2wJ
   MIYwb7z9rtiZzHIm1C8U+jJH4ZJ2Husdonk7J1o7uvodQCF0tyH/TUgpk
   TnaRZfoybiYhJuRF8IWlAQDdpI0kxBGG/keOIBb40P7/TuYLs07Gr3iAm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="384692660"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="384692660"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708985716"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="708985716"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.211.218])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:14:26 -0700
Message-ID: <cf207da8-8ec4-4b9c-8f01-00e1a8a46238@intel.com>
Date:   Thu, 26 Oct 2023 11:14:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: cqhci: Be more verbose in error irq handler
Content-Language: en-US
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
 <f0aecb28-6f82-456e-a319-8d13a2e313b6@intel.com>
 <CAD=NsqyJHv4nrtrqU4igtaMR=u6xmUtCpoYk66XzarLpu95idA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAD=NsqyJHv4nrtrqU4igtaMR=u6xmUtCpoYk66XzarLpu95idA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/23 10:56, Kornel Dulęba wrote:
> On Thu, Oct 26, 2023 at 8:25 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 25/10/23 11:01, Kornel Dulęba wrote:
>>> On Mon, Oct 23, 2023 at 1:38 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 20/10/23 11:53, Kornel Dulęba wrote:
>>>>> On Fri, Oct 20, 2023 at 9:41 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>
>>>>>> On 16/10/23 12:56, Kornel Dulęba wrote:
>>>>>>> There are several reasons for controller to generate an error interrupt.
>>>>>>> They include controller<->card timeout, and CRC mismatch error.
>>>>>>> Right now we only get one line in the logs stating that CQE recovery was
>>>>>>> triggered, but with no information about what caused it.
>>>>>>> To figure out what happened be more verbose and dump the registers from
>>>>>>> irq error handler logic.
>>>>>>> This matches the behaviour of the software timeout logic, see
>>>>>>> cqhci_timeout.
>>>>>>>
>>>>>>> Signed-off-by: Kornel Dulęba <korneld@chromium.org>
>>>>>>> ---
>>>>>>>  drivers/mmc/host/cqhci-core.c | 5 +++--
>>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
>>>>>>> index b3d7d6d8d654..33abb4bd53b5 100644
>>>>>>> --- a/drivers/mmc/host/cqhci-core.c
>>>>>>> +++ b/drivers/mmc/host/cqhci-core.c
>>>>>>> @@ -700,8 +700,9 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
>>>>>>>
>>>>>>>       terri = cqhci_readl(cq_host, CQHCI_TERRI);
>>>>>>>
>>>>>>> -     pr_debug("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d TERRI: 0x%08x\n",
>>>>>>> -              mmc_hostname(mmc), status, cmd_error, data_error, terri);
>>>>>>> +     pr_warn("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d\n",
>>>>>>> +              mmc_hostname(mmc), status, cmd_error, data_error);
>>>>>>> +     cqhci_dumpregs(cq_host);
>>>>>>
>>>>>> For debugging, isn't dynamic debug seems more appropriate?
>>>>>
>>>>> Dynamic debug is an option, but my personal preference would be to
>>>>> just log more info in the error handler.
>>>>
>>>> Interrupt handlers can get called very rapidly, so some kind of rate
>>>> limiting should be used if the message is unconditional.  Also you need
>>>> to provide actual reasons for your preference.
>>>>
>>>> For dynamic debug of the register dump, something like below is
>>>> possible.
>>>>
>>>> #define cqhci_dynamic_dumpregs(cqhost) \
>>>>         _dynamic_func_call_no_desc("cqhci_dynamic_dumpregs", cqhci_dumpregs, cqhost)
>>>>
>>> Fair point.
>>> The reason I'm not a fan of using dynamic debug for this is that my
>>> goal here is to improve the warning/error logging information that we
>>> get from systems running in production.
>>> I.e. if we get a lot of "running CQE recovery" messages, at the very
>>> least I'd like to know what is causing them.
>>
>> So you are saying you want to collect debug information from production
>> systems, but don't want to use dynamic debug to do it?
>>
>>>>> To give you some background.
>>>>> We're seeing some "running CQE recovery" lines in the logs, followed
>>>>> by a dm_verity mismatch error.
>>>>> The reports come from the field, with no feasible way to reproduce the
>>>>> issue locally.
>>>>
>>>> If it is a software error, some kind of error injection may well
>>>> reproduce it.  Also if it is a hardware error that only happens
>>>> during recovery, error injection could increase the likelihood of
>>>> reproducing it.
>>>
>>> We tried software injection and it didn't yield any results.
>>> We're currently looking into "injecting" hw errors by using a small
>>> burst field generator to interfere with transfers on the data line
>>> directly.
>>
>> I just tried instrumenting a driver to inject CRC errors and it
>> revealed several CQE recovery issues, including spurious TCN for
>> tag 31.  I will send some patches when they are ready.
> 
> Sorry, what I meant by it didn't yield results is that Ii didn't
> trigger the dm-verity error that we're seeing on production.
> With SW injection there are two potential issues that come to my mind:
> 
> 1. In the cqhci_error_irq when TERRI is not valid only a single,
> "random" task is marked as bad.
> Then in cqhci_recover_mrq we're marking all pending requests as done.
> For data transfers this is somewhat bening as it will return with
> bytes_xfered=0.
> IIUC this will then cause the upper layer to re-enqueue this request.

Yes

> The bigger problem is a CMD only mrq, which will be mistakenly marked
> as completed successfully.

I noticed that also.  Notably the only non-data CMD is cache flush.

There are several other issues, but patches will describe
them better.

> 
> 2. As for the spurious task completion warning.
> I initially thought that it was bening.
> The check for !mrq is done before checking if we're currently doing recovery.
> So if it's called just right at the end of recovery, right after the
> cqhci_recover_mrqs is executed that would explain it.
> With that being said if that irq handler is run right after the
> recovery is finished we'll end up with a race where a new request,
> that was just enqueued, might be mistakenly marked as done.
> This would explain the dm-verity errors we're seeing.
> 
>>
>>>>
>>>>>
>>>>> I'd argue that logging only the info that CQE recovery was executed is
>>>>> not particularly helpful for someone looking into those logs.
>>>>
>>>> As the comment says, that message is there because recovery reduces
>>>> performance, it is not to aid debugging per se.
>>>>
>>>>> Ideally we would have more data about the state the controller was in
>>>>> when the error happened, or at least what caused the recovery to be
>>>>> triggered.
>>>>> The question here is how verbose should we be in this error scenario.
>>>>> Looking at other error scenarios, in the case of a software timeout
>>>>> we're dumping the controller registers. (cqhci_timeout)
>>>>
>>>> Timeout means something is broken - either the driver, the cq engine
>>>> or the card.  On the other hand, an error interrupt is most likely a
>>>> CRC error which is not unexpected occasionally, due to thermal drift
>>>> or perhaps interference.
>>>
>>> Right, but my point is that we don't know what triggered CQE recovery.
>>
>> True, although probably a CRC error.
>>
>>>
>>>>
>>>>> Hence I thought that I'd be appropriate to match that and do the same
>>>>> in CQE recovery logic.
>>>>
>>>> It needs to be consistent. There are other pr_debugs, such as:
>>>>
>>>>                 pr_debug("%s: cqhci: Failed to clear tasks\n",
>>>>                 pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
>>>>                 pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname(mmc));
>>>>
>>>> which should perhaps be treated the same.
>>>>
>>>> And there are no messages for errors from the commands in
>>>> mmc_cqe_recovery().
>>>
>>> How about this.
>>> As a compromise would it be okay to just do a single pr_warn directly
>>> from cqhci_error_irq.
>>
>> Sure, printk_ratelimited() or __ratelimit()
>>
>>> We could simply promote the existing pr_debug to pr_warn at the
>>> beginning of that function.
>>> This would tell us what triggered the recovery. (controller timeout,
>>> CRC mismatch)
>>> We can also consider removing the "running CQE recovery" print for the
>>> sake of brevity.
>>
>> No, that serves a different purpose.
>>
>>> The only downside of this that I can see is that we'd be running the
>>> logic from the interrupt handler directly, but I can't see an easy way
>>> around that.
>>> What do you think?
>>
>> Should be OK with rate limiting.
> 
> OK, I'll look into the rate limiting and will send a v2.
> 
>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>       /* Forget about errors when recovery has already been triggered */
>>>>>>>       if (cq_host->recovery_halt)
>>>>>>
>>>>
>>

