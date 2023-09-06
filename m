Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80364794467
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244363AbjIFUVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjIFUVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:21:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA61E59;
        Wed,  6 Sep 2023 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694031669; x=1725567669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3kMW/s9vc1JzXHZ7uyADzsTe7V4Y9mN4qtrmBkPH9GE=;
  b=ZCckbjlWeOK67v8tA72mEN7VbAzynj8+tKKGoOvINPcJFu3ep15eQAuc
   tdlu41HHjFWwfpo6hF+krlmZCJtmK9iPMz0Pasn21c3c4n6XNL8nGlxNr
   Ijt95IKiqXdPdi2Qi+HsqLcjfDvGVspRVXLpRyd3erpRFd51JcAsdDHYG
   PcDTR+ghlxJnVKJJMun4H0bhzSxPQy5mZEdp9m9gkgfIzdU75tfSq8UN8
   1SQWDE+vqHLK9NHxTkn32i0A1Q4dvgJ71Lt/dzIkf5ScOq0TPq5BbgMLl
   NhTN8aw++R7DREIiSE2BWJdSHe17NEjt4kvOO9toHCO0DJo7Z3S80ugQg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="380968198"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="380968198"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:20:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="744813919"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="744813919"
Received: from jseong-mobl45.amr.corp.intel.com (HELO [10.209.51.7]) ([10.209.51.7])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:20:48 -0700
Message-ID: <1248ebb9-ff14-418a-ae01-cfa5c8ca9d68@linux.intel.com>
Date:   Wed, 6 Sep 2023 13:20:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Check status after
 timeout in busy_loop()
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
References: <20230906180944.2197111-1-swboyd@chromium.org>
 <20230906180944.2197111-2-swboyd@chromium.org>
 <ZPjbZqIQBlIGpoCK@smile.fi.intel.com>
 <CAE-0n52REGuVrqG8LUdWzjgqAun7uvDFPJeSkjX02OxD=fUhqg@mail.gmail.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAE-0n52REGuVrqG8LUdWzjgqAun7uvDFPJeSkjX02OxD=fUhqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2023 1:14 PM, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2023-09-06 13:04:54)
>> On Wed, Sep 06, 2023 at 11:09:41AM -0700, Stephen Boyd wrote:
>>> It's possible for the polling loop in busy_loop() to get scheduled away
>>> for a long time.
>>>
>>>   status = ipc_read_status(scu); // status = IPC_STATUS_BUSY
>>>   <long time scheduled away>
>>>   if (!(status & IPC_STATUS_BUSY))
>>>
>>> If this happens, then the status bit could change while the task is
>>> scheduled away and this function would never read the status again after
>>> timing out. Instead, the function will return -ETIMEDOUT when it's
>>> possible that scheduling didn't work out and the status bit was cleared.
>>> Bit polling code should always check the bit being polled one more time
>>> after the timeout in case this happens.
>>>
>>> Fix this by reading the status once more after the while loop breaks.
>>
>> ...
>>
>>>  static inline int busy_loop(struct intel_scu_ipc_dev *scu)
>>>  {
>>>       unsigned long end = jiffies + IPC_TIMEOUT;
>>> +     u32 status;
>>>
>>>       do {
>>> -             u32 status;
>>> -
>>>               status = ipc_read_status(scu);
>>>               if (!(status & IPC_STATUS_BUSY))
>>
>>> -                     return (status & IPC_STATUS_ERR) ? -EIO : 0;
>>> +                     goto not_busy;
>>
>> Wouldn't simple 'break' suffice here?
> 
> Yes, at the cost of reading the status again when it isn't busy, or
> checking the busy bit after the loop breaks out and reading it once
> again when it is busy. I suppose the compiler would figure that out and
> optimize so that break would simply goto the return statement.
> 
> The code could look like this without a goto.
> 
> 	do {
> 		status = ipc_read_status(scu);
> 		if (!(status & IPC_STATUS_BUSY))
> 			break;
> 	} while (time_before(jiffies, end));
> 
> 	if (status & IPC_STATUS_BUSY)
> 		status = ipc_read_status(scu);

IMO, you can remove the if condition and read again the status in all cases.
It is more readable. But it is up to you.

/* Always read again to double check and get the latest status */
status = ipc_read_status(scu);

> 
> 	if (status & IPC_STATUS_BUSY)
> 		return -ETIMEDOUT;
> 	
> 	return (status & IPC_STATUS_ERR) ? -EIO : 0;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
