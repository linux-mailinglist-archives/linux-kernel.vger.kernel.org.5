Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A047A9FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjIUU2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjIUU1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:27:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC6E19B9;
        Thu, 21 Sep 2023 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318594; x=1726854594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=blnPFyBCmuj49NnWuIH57vg9ki5lW+1BgUnV5MZfDW4=;
  b=CmeEmsrL8xns8rbJ8J/gNtiBlayut9T5t5sXsQ13mQOAfVRStrfXJyF5
   QaCAbPWSfM7lDUkC1qa4A/ZziJ2LDdvPaIbycW9G95RC+PrvODisflzGR
   w8Zm+4HmJGs74QCmlfDhzz6hNuyYbXoNYfyPXJ/mqADdB4iVgLHcvv2Vx
   AP4wSStD/9e+j3Kg+wcwlvDqhe9X9JwAkEDg8Y+C6z8gnM/MBaRnGtb0v
   v71Rec8qkwnpRrCpeaCUl0bLV9nh5DqRmZcNyqPvTPbQ4aafsrGqZ5Ehg
   Ho7sHCGx4Elc7aZ/i9BP3qlK7X1kJJd+W34f6h0EI2ViUVECXw2zKbUR9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="446976775"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="446976775"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="920709593"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="920709593"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 21 Sep 2023 05:37:31 -0700
Message-ID: <2bb2122e-e91c-868c-5385-a1b84549a154@intel.com>
Date:   Thu, 21 Sep 2023 15:38:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2] usb: xhci-plat: fix usb disconnect issue after s4
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230809095826.18183-1-zhuyinbo@loongson.cn>
 <4862ba2c-fa6b-de12-2ad9-4099d2eddbb1@loongson.cn>
From:   Mathias Nyman <mathias.nyman@intel.com>
In-Reply-To: <4862ba2c-fa6b-de12-2ad9-4099d2eddbb1@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.9.2023 4.58, Yinbo Zhu wrote:
> 
> 
> Friendly ping ?
> 
> 
> 在 2023/8/9 下午5:58, Yinbo Zhu 写道:
>> The xhci retaining bogus hardware states cause usb disconnect devices
>> connected before hibernation(s4) and refer to the commit 'f3d478858be
>> ("usb: ohci-platform: fix usb disconnect issue after s4")' which set
>> flag "hibernated" as true when resume-from-hibernation and that the
>> drivers will reset the hardware to get rid of any existing state and
>> make sure resume from hibernation re-enumerates everything for xhci.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>> Change in v2:
>>         1. Add CONFIG_PM_SLEEP in xhci_plat_pm_ops that for fix
>>            compile issue when CONFIG_PM not enable.
>>
>>   drivers/usb/host/xhci-plat.c | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> index 28218c8f1837..112468fdcca2 100644
>> --- a/drivers/usb/host/xhci-plat.c
>> +++ b/drivers/usb/host/xhci-plat.c
>> @@ -451,7 +451,7 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
>>       return 0;
>>   }
>> -static int __maybe_unused xhci_plat_resume(struct device *dev)
>> +static int __maybe_unused xhci_plat_resume_common(struct device *dev, struct pm_message pmsg)
>>   {
>>       struct usb_hcd    *hcd = dev_get_drvdata(dev);
>>       struct xhci_hcd    *xhci = hcd_to_xhci(hcd);
>> @@ -466,7 +466,7 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
>>       if (ret)
>>           return ret;
>> -    ret = xhci_resume(xhci, PMSG_RESUME);
>> +    ret = xhci_resume(xhci, pmsg);
>>       if (ret)
>>           return ret;
>> @@ -477,6 +477,16 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
>>       return 0;
>>   }
>> +static int __maybe_unused xhci_plat_resume(struct device *dev)
>> +{
>> +    return xhci_plat_resume_common(dev, PMSG_RESUME);
>> +}
>> +
>> +static int __maybe_unused xhci_plat_restore(struct device *dev)
>> +{
>> +    return xhci_plat_resume_common(dev, PMSG_RESTORE);
>> +}
>> +
>>   static int __maybe_unused xhci_plat_runtime_suspend(struct device *dev)
>>   {
>>       struct usb_hcd  *hcd = dev_get_drvdata(dev);
>> @@ -499,8 +509,14 @@ static int __maybe_unused xhci_plat_runtime_resume(struct device *dev)
>>   }
>>   const struct dev_pm_ops xhci_plat_pm_ops = {
>> -    SET_SYSTEM_SLEEP_PM_OPS(xhci_plat_suspend, xhci_plat_resume)
>> -
>> +#ifdef CONFIG_PM_SLEEP
>> +    .suspend = xhci_plat_suspend,
>> +    .resume = xhci_plat_resume,
>> +    .freeze = xhci_plat_suspend,
>> +    .thaw = xhci_plat_resume,
>> +    .poweroff = xhci_plat_suspend,
>> +    .restore = xhci_plat_restore,
>> +#endif

How about using pm_ptr() and pm_sleep_ptr() macros instead of the #ifdef CONFIG_PM_SLEEP?
should be able to get rif of the __maybe_unused flags as well.

Thanks
-Mathias

