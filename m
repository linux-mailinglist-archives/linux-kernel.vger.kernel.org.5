Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E897B6AF9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbjJCOBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjJCOBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:01:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9608DA3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696341704; x=1727877704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uePwa7VPltT+jw5/W9K9jgZRk0qXIMPCBgYp21qPHok=;
  b=D6MiQroaQ51XgqdSu5EmjYser4f9tJLmQE1XI2UGAVYnJajZtimd7ddk
   wVIwcwqQcdSOnU6rvlWRRCJJhgHbpxh1/xBQMHjeR/Y9sVxHjFxNfEmRr
   TaoQd7Y9a+RxF9oMjoh7B7fOENhgLFeo99wUq7Kh/eYJd08+ijYSg3Jgn
   44cFyYoaYCVF/uzA7CRVmnkxiN0F1IGpjabqnuIgMpuFEOE5y2cynjBMZ
   rXoOUJQ1Py7OKG/XBApYc9N/KdwbQHERqH0vJSPP1Wq+6TwsBJ5IQc8wY
   +v5zdh6v4u77dXbJgJJvYZHfdmaBQW7RNT/L65BA4HTtvohkzw2zIAfes
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1475228"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1475228"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="780303304"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="780303304"
Received: from sknagara-mobl2.amr.corp.intel.com (HELO [10.209.121.241]) ([10.209.121.241])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:01:42 -0700
Message-ID: <1019158c-a854-4e29-b9ec-961fb878bab3@linux.intel.com>
Date:   Tue, 3 Oct 2023 07:01:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/tdx: Dump TDX version During the TD Bootup
Content-Language: en-US
To:     Yi Sun <yi.sun@intel.com>
Cc:     kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        heng.su@intel.com, yi.sun@linux.intel.com,
        Dongcheng Yan <dongcheng.yan@intel.com>
References: <20230930161110.3251107-1-yi.sun@intel.com>
 <483ee0eb-cc14-44a4-9c3b-77a6d0860359@linux.intel.com>
 <ZRwdj9mZz+Qt5FPP@ysun46-mobl.ccr.corp.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ZRwdj9mZz+Qt5FPP@ysun46-mobl.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2023 6:56 AM, Yi Sun wrote:
> On 03.10.2023 06:26, Kuppuswamy Sathyanarayanan wrote:
>>
>>
>> On 9/30/2023 9:11 AM, Yi Sun wrote:
>>> +static int tdg_get_sysinfo(struct tdg_sys_info *td_sys)
>>> +{
>>> +    struct tdx_module_output out;
>>> +    u64 ret;
>>> +
>>> +    if (!td_sys)
>>> +        return -EINVAL;
>>> +
>>> +    ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_VENDOR_ID_FID, 0, 0,
>>> +                &out);
>>> +    if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
>>> +        goto version_1_0;
>>> +    else if (ret)
>>> +        return ret;
>>
>> For this failure case, do you want to reset tdg_sys_info to some value like zero
>> or some constants to specify unknown?
> Yes, that would be better for this case.
> 
>>> +
>>> +    td_sys->vendor_id = (u32)out.r8;
>>> +
>>> +    ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_MAJOR_FID, 0, 0, &out);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    td_sys->major_version = (u16)out.r8;
>>> +
>>> +    ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_MINOR_FID, 0, 0, &out);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    td_sys->minor_version = (u16)out.r8;
>>> +
>>> +    return 0;
>>> +
>>> +    /* TDX 1.0 does not have the TDCALL TDG.SYS.RD */
>>> +version_1_0:
>>> +    td_sys->vendor_id = TDX_VENDOR_INTEL;
>>> +    td_sys->major_version = 1;
>>> +    td_sys->minor_version = 0;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>  void __init tdx_early_init(void)
>>>  {
>>>      u64 cc_mask;
>>>      u32 eax, sig[3];
>>> +    struct tdg_sys_info td_sys_info;
>>>
>>>      cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
>>>
>>> @@ -820,5 +882,9 @@ void __init tdx_early_init(void)
>>>       */
>>>      x86_cpuinit.parallel_bringup = false;
>>>
>>> -    pr_info("Guest detected\n");
>>> +    tdg_get_sysinfo(&td_sys_info);
>>
>> Why not check the return value before dumping the info?
>>
> I overlooked that. I will add it in the next version.
> Thanks Sathya for your comments.

if you plan to zero out the td_sys_info value in error case, I think it
is better to make the tdg_get_sysinfo as void

> 
> Thanks
>      --Yi Sun

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
