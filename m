Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857867D344D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjJWLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjJWLiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:38:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212B9FD;
        Mon, 23 Oct 2023 04:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698061096; x=1729597096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WI0PePkdjm80l6TXZuuvvHh3AmbwA3xAEz4yXz4Whpo=;
  b=DjHywYZvovT8amsyr1X+HY5UxAk9vcWbK7Z2mw7LSrOWHUkijgLI/2RF
   GrDxVsuR/uMsQQr0AH3+E62BgzLUyNbf05WV4g8pwvO7Y8spOfl31W3lP
   syc31KoDfFCeB0yb+kbjgoBbuvHoHMuhGyX2tHCBcoG515dg9o8T8LJbb
   cVTdhTbKX7l8XrKXDjIw/+F6h8AZQ/BGB5wXctf9RxuKHxlYVphpyaJy9
   sYhzfCdy3TIxz6I+NoSlrn5/uJockg1niEAV+F2yIloduwOH61Q4IxTX2
   bygL6cyBa/i+0obqzJxW+33u9YutfPzEw30UmryIc66C2ohz8Xb63XynI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="389667036"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="389667036"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="793099976"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="793099976"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.40.60])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:38:12 -0700
Message-ID: <78bb4ad2-853a-4ed4-9998-c4e1122545b6@intel.com>
Date:   Mon, 23 Oct 2023 14:38:09 +0300
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAD=NsqybNrf-=9=5wvoj+9MT3xK3SbX7nDk3N3VLBMyA_u3KTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/23 11:53, Kornel Dulęba wrote:
> On Fri, Oct 20, 2023 at 9:41 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 16/10/23 12:56, Kornel Dulęba wrote:
>>> There are several reasons for controller to generate an error interrupt.
>>> They include controller<->card timeout, and CRC mismatch error.
>>> Right now we only get one line in the logs stating that CQE recovery was
>>> triggered, but with no information about what caused it.
>>> To figure out what happened be more verbose and dump the registers from
>>> irq error handler logic.
>>> This matches the behaviour of the software timeout logic, see
>>> cqhci_timeout.
>>>
>>> Signed-off-by: Kornel Dulęba <korneld@chromium.org>
>>> ---
>>>  drivers/mmc/host/cqhci-core.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
>>> index b3d7d6d8d654..33abb4bd53b5 100644
>>> --- a/drivers/mmc/host/cqhci-core.c
>>> +++ b/drivers/mmc/host/cqhci-core.c
>>> @@ -700,8 +700,9 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
>>>
>>>       terri = cqhci_readl(cq_host, CQHCI_TERRI);
>>>
>>> -     pr_debug("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d TERRI: 0x%08x\n",
>>> -              mmc_hostname(mmc), status, cmd_error, data_error, terri);
>>> +     pr_warn("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d\n",
>>> +              mmc_hostname(mmc), status, cmd_error, data_error);
>>> +     cqhci_dumpregs(cq_host);
>>
>> For debugging, isn't dynamic debug seems more appropriate?
> 
> Dynamic debug is an option, but my personal preference would be to
> just log more info in the error handler.

Interrupt handlers can get called very rapidly, so some kind of rate
limiting should be used if the message is unconditional.  Also you need
to provide actual reasons for your preference.

For dynamic debug of the register dump, something like below is
possible.

#define cqhci_dynamic_dumpregs(cqhost) \
	_dynamic_func_call_no_desc("cqhci_dynamic_dumpregs", cqhci_dumpregs, cqhost)

> To give you some background.
> We're seeing some "running CQE recovery" lines in the logs, followed
> by a dm_verity mismatch error.
> The reports come from the field, with no feasible way to reproduce the
> issue locally.

If it is a software error, some kind of error injection may well
reproduce it.  Also if it is a hardware error that only happens
during recovery, error injection could increase the likelihood of
reproducing it.

> 
> I'd argue that logging only the info that CQE recovery was executed is
> not particularly helpful for someone looking into those logs.

As the comment says, that message is there because recovery reduces
performance, it is not to aid debugging per se.

> Ideally we would have more data about the state the controller was in
> when the error happened, or at least what caused the recovery to be
> triggered.
> The question here is how verbose should we be in this error scenario.
> Looking at other error scenarios, in the case of a software timeout
> we're dumping the controller registers. (cqhci_timeout)

Timeout means something is broken - either the driver, the cq engine
or the card.  On the other hand, an error interrupt is most likely a
CRC error which is not unexpected occasionally, due to thermal drift
or perhaps interference.

> Hence I thought that I'd be appropriate to match that and do the same
> in CQE recovery logic.

It needs to be consistent. There are other pr_debugs, such as:

		pr_debug("%s: cqhci: Failed to clear tasks\n",
		pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
		pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname(mmc));

which should perhaps be treated the same.

And there are no messages for errors from the commands in
mmc_cqe_recovery().

> 
>>
>>>
>>>       /* Forget about errors when recovery has already been triggered */
>>>       if (cq_host->recovery_halt)
>>

