Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2B7B8192
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242748AbjJDOAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242720AbjJDOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:00:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9E6C1;
        Wed,  4 Oct 2023 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696428047; x=1727964047;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ND6e8zppS+/0buxG1psBpDzddtzWLjPsHvkMnqKjyIs=;
  b=Wn2eAFRIHsJsYhhqLHmhuuhM9SxbbJRL6dXf8bdsYVnvVmTgSMHEzN1O
   cSQVCETWJt0xyohJH3Vjgea7XCjcdhZtmsSNkiQUWtZmj0kyxpzv2qYKx
   ODx6D76BqwdMQ52fHyrHr5DNUxqBhZXJQT1/VYu82Pjaq/wxIinD7TOD6
   Jv3Lo+Q5AMn7GMV1l/N276Ln7XfLsodSmxyAmAkOOh78W2DXx0sOTyWfK
   HdsZI3Bp5e6btSgdkW9iwcEjU+9FuQR437PIXOJRsVgDTF6NfFtWmPvjw
   AyTPrVLJNA/06GJKqYPnCIsxcmW6qqZYJv0VwhbxKFCPnxYMb7nqw3yIG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="382040999"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="382040999"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 07:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="1082512034"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="1082512034"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 04 Oct 2023 07:00:41 -0700
Message-ID: <843897f1-3ce5-f8da-5f10-7d8a68849fd2@intel.com>
Date:   Wed, 4 Oct 2023 17:02:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v7 01/33] xhci: add support to allocate several
 interrupters
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <20230921214843.18450-2-quic_wcheng@quicinc.com>
 <10ad0613-7e88-dbe8-c5a2-d535f8e9db03@linux.intel.com>
 <e3f3c8cd-6338-da08-d988-4d2ed68280e6@quicinc.com>
Content-Language: en-US
From:   Mathias Nyman <mathias.nyman@intel.com>
In-Reply-To: <e3f3c8cd-6338-da08-d988-4d2ed68280e6@quicinc.com>
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

On 2.10.2023 23.07, Wesley Cheng wrote:
> Hi Mathias,
> 
> On 9/28/2023 3:31 AM, Mathias Nyman wrote:
>> On 22.9.2023 0.48, Wesley Cheng wrote:
>>> From: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>
>>> Modify the XHCI drivers to accommodate for handling multiple event rings in
>>> case there are multiple interrupters.  Add the required APIs so clients are
>>> able to allocate/request for an interrupter ring, and pass this information
>>> back to the client driver.  This allows for users to handle the resource
>>> accordingly, such as passing the event ring base address to an audio DSP.
>>> There is no actual support for multiple MSI/MSI-X vectors.
>>>
>>> Factoring out XHCI interrupter APIs and structures done by Wesley Cheng, in
>>> order to allow for USB class drivers to utilze them.
>>>
>>>   }
>>> +void xhci_remove_secondary_interrupter(struct usb_hcd *hcd, struct xhci_interrupter *ir)
>>> +{
>>> +    struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>>> +    unsigned int intr_num;
>>> +
>>> +    /* interrupter 0 is primary interrupter, don't touchit */
>>> +    if (!ir || !ir->intr_num || ir->intr_num >= xhci->max_interrupters) {
>>> +        xhci_dbg(xhci, "Invalid secondary interrupter, can't remove\n");
>>> +        return;
>>> +    }
>>> +
>>> +    /* fixme, should we check xhci->interrupter[intr_num] == ir */
>>> +    spin_lock(&xhci->lock);
>>
>> Needs to be spin_lock_irq() ir spin_lock_irqsave() as xhci->lock is used in interrupt handler.
>>
>>
>>> +    intr_num = ir->intr_num;
>>> +    xhci_free_interrupter(xhci, ir);
>>> +    xhci->interrupters[intr_num] = NULL;
>>> +    spin_unlock(&xhci->lock);
>>
>> likewise
>>
> 
> Let me check these again.  In general, I think I will use both the xhci->mutex and 
> xhci->lock where needed, because I believe we'd run into sleep while atomic issues
> while freeing the DMA memory.  Will rework this and submit in the next rev.
> 

Maybe we need to split xhci_free_interrupter() into separate remove and free functions

Did some work on this, and on the sideband api in general.

Code still has a lot of FIXMEs, and it's completely untested, but to avoid us
from doing duplicate work I pushed it to my feature_interrupters branch anyway

git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git feature_interrupters
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters

Thanks
-Mathias

