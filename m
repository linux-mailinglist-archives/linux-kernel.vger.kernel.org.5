Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B71278C689
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjH2N6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjH2N6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:58:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739A2D2;
        Tue, 29 Aug 2023 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693317479; x=1724853479;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=jJQQo1IAEKezy8aHFkMUIHU66zepq2CUgR9YfDIPtcI=;
  b=CTJrmGvf19LNNSp53XKCGvlf6DdxDB/tW5Gp9M1YpBaT0PkLdQaRa5v+
   sW79p5xaHPbBPL7WVsMRW7UUfVRYlBvWor9jBzmt8DzA5PUtmXKuIJuv9
   W+rzEfmF858RTEUXlLVP/ILqm3Hy7qICUVX2PlsVakuKB/eqFYGGdHmB4
   4gJ9jqXowur6jGABl2XMec+JDcVHmKUrtXbGzV2NkKFM+QEVqXN/5hHlj
   HdL39AP5ZkQh5e3MFCLwKyDjtCBMiNIAqINe6eK9vHbMtI/o9y4JYianO
   nrESenOBljaCVosnCvW6lraKyDlBqLY/gIAt5lLPYaL+sU9mQvt6jm9+w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="354886145"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="354886145"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="773699008"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="773699008"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2023 06:56:36 -0700
Message-ID: <d88dbe7e-4558-970d-5601-d4d906829d47@linux.intel.com>
Date:   Tue, 29 Aug 2023 16:57:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        stern@rowland.harvard.edu, yangyingliang@huawei.com,
        jinpu.wang@ionos.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, erosca@de.adit-jv.com
References: <20230818092353.124658-1-hgajjar@de.adit-jv.com>
 <2c029018-a926-6fda-ed71-937ac74d00b0@linux.intel.com>
 <20230821095547.GA9820@vmlxhi-118.adit-jv.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: hcd: xhci: Add set command timer delay API
In-Reply-To: <20230821095547.GA9820@vmlxhi-118.adit-jv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.8.2023 12.55, Hardik Gajjar wrote:
> On Fri, Aug 18, 2023 at 04:18:30PM +0300, Mathias Nyman wrote:
>> On 18.8.2023 12.23, Hardik Gajjar wrote:
>>> xHCI driver starts the response timer after sending each
>>> command to the device. The default value of this timer is
>>> 5 seconds (XHCI_CMD_DEFAULT_TIMEOUT = HZ*5). This seems
>>> too high in time crtical use case.
>>>
>>> This patch provides an API to change the default value of
>>> the timer from the vendor USB driver.
>>>
>>> The default value will be XHCI_CMD_DEFAULT_TIMEOUT (5 sec)
>>>
>>> Use case:
>>> According to the Smartphone integration certification
>>> requirement in the automotive, the phone connected via USB
>>> should complete enumeration and user space handshake
>>> within 3 sec.
>>
>> The above incorrectly makes it sound as if the command timeout
>> timer causes the delay.
>>
> Thank you, Mathias, for your prompt response. I will enhance the message
> to provide more specificity in the subsequent patch.
>>>
>>> Reducing the response waiting time by setting the smaller
>>> command timer delay helps to speed up overall re-enumeration
>>> process of the USB device in case of device is not responding
>>> properly in first enumeration iteration.
>>
>> So is this a case where addressing a usb device behind xHC always
>> fail on the first attempt, i.e. address device command in xhci
>> never completes. Solution proposed here is to fail faster and
>> retry?
>>
>> Is the rootcause known why first enumeration fails?
>>
>> Does setting old_scheme_first module parameter help?
>>
> Yes, you are correct. The problem occurs when setting the address,
> and in such cases, this patch helps to fail faster and retry.
> 
> Unfortunately, the root cause is unknown. This problem is mainly
> observed with Android phones. Upon analyzing the USB analyzer logs,
> it seems that the device is not responding to the SET_ADDRESS request.

Is this only seen when connecting the device to a Linux xHCI host at USB 3 speeds?
How about connecting to a windows machine? or USB 2 Linux machine with a EHCI host?

> 
> I tried using "old_scheme_first=Y," but that did not help. Below are
> the short logs of the first iteration enumeration failure.
>>
>> The xhci command timeout is more of a xhci internal thing, not sure it's a good
>> idea to add this to hcd.
>>
>> Would it make sense to add a timeout parameter to hcd->driver->address_device(hcd, udev)
>> instead?
>>
>> First priority should of course be finding out why the first enumeration fails,
>> and solve that.
>>
>> Thanks
>> Mathias
> Thanks for the suggestion to modify hcd->driver->address_device.
> I will definitely implement it.However to confirm.
> 
> So, if I understand correctly, the idea is to avoid exposing any
> API from the xhci driver, but instead, create an interface in hcd.c (such as sysfs or API)
> and incorporate the delay in address_device as an additional parameter.

On second thought it only makes sense to do this if we can identify the device in advance
and make a quirk for it. But at this stage we don't know anything about the device.

So I guess this depends on the width of the problem.

If this works on windows then we need to figure out what we do differently.

If this fails with all hosts (well xHCI and EHCI) then hcd level change is probably needed.
For xhci we would pass timeout parameter when calling address_device, for other hosts
the timeout for the SET_ADDRESS control transfer would be adjusted.

If this only fails when connected behind a xHCI host then a local xHCI change should do.

> However, in that case, modifying xhci is still necessary as the timer is controlled from there.

Yes, xhci changes will be needed.

I suggest adding a timeout parameter to struct xhci_command, and use that when calling
xhci_mod_cmd_timer(). This way we can tailor different timeouts for different commands.

-Mathias
