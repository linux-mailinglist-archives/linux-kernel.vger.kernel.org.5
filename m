Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098657CF374
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345005AbjJSJCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345007AbjJSJCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:02:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ADE129
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697706159; x=1729242159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M4oXe3D2wRhIVGv77DBG/RcdR/vxLrUWgL7kXKfufCo=;
  b=MTSNA2iaPUSHdqokuXmDPTCTBkd9kl4UThoYQNTlu4wUptFiA3XntXWH
   hV26ldHp0AMRWu3F6GxKBMn1g3aDAM3l6IzSyQpNRLQMBvlDxGCFl6LOS
   TiRsJZ/tXvInwO0cX0DPVkvsVAA6kZ5I/Rc00jMWYwJTu2fa9gPiB/i36
   xbwlbSroXcOXr9Me3jOeacFiQodyFpn2F2X/7A4E3U90NzfgI512+2Eum
   sv7RRnSQP0RKK5ojLynBgOfklufrV34dQU150RrjVaszfL4yvuBqHR8kU
   09+QSXzsquqxwaUmFAURpOhL9MZnTFIwMH1+WrcVU3Lhal+t3VUpdGSzj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472437937"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="472437937"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 02:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="827256620"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="827256620"
Received: from vgowrish-mobl1.ger.corp.intel.com (HELO [10.213.218.20]) ([10.213.218.20])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 02:02:32 -0700
Message-ID: <693e18a9-1485-f31e-e820-ed5a4c6fd42d@linux.intel.com>
Date:   Thu, 19 Oct 2023 10:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 9/9] drm/i915: Use kmap_local_page() in
 gem/i915_gem_execbuffer.c
Content-Language: en-US
To:     Zhao Liu <zhao1.liu@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Zhao Liu <zhao1.liu@linux.intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=ef=bf=bdm?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?Q?Christian_K=ef=bf=bdnig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>
References: <20230329073220.3982460-1-zhao1.liu@linux.intel.com>
 <64265ef8725fe_375f7e294a@iweiny-mobl.notmuch>
 <fdc8a470-1e6b-815d-e367-a9df1b0b14dd@linux.intel.com>
 <2177327.1BCLMh4Saa@suse>
 <1b341218-f0e2-a613-2ac6-107064a813ca@linux.intel.com>
 <ZDku5SJhl2Ve51UC@liuzhao-OptiPlex-7080>
 <048d4dba-153f-5d32-75fc-d7e7144d1e9c@linux.intel.com>
 <ZD1daLWcOslJ/wdt@intel.com> <ZTAFltHj1mNS/Ok3@liuzhao-OptiPlex-7080>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <ZTAFltHj1mNS/Ok3@liuzhao-OptiPlex-7080>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 18/10/2023 17:19, Zhao Liu wrote:
> Hi Rodrigo and Tvrtko,
> 
> It seems this series is missed in v6.5.
> This work should not be forgotten. Let me rebase and refresh the version.

Right it seems we did not manage to social engineer any reviews. Please 
do respin and we will try again.

Regards,

Tvrtko

> 
> Regards,
> Zhao
> 
> On Mon, Apr 17, 2023 at 10:53:28AM -0400, Rodrigo Vivi wrote:
>> Date: Mon, 17 Apr 2023 10:53:28 -0400
>> From: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Subject: Re: [PATCH v2 9/9] drm/i915: Use kmap_local_page() in
>>   gem/i915_gem_execbuffer.c
>>
>> On Mon, Apr 17, 2023 at 12:24:45PM +0100, Tvrtko Ursulin wrote:
>>>
>>> On 14/04/2023 11:45, Zhao Liu wrote:
>>>> Hi Tvrtko,
>>>>
>>>> On Wed, Apr 12, 2023 at 04:45:13PM +0100, Tvrtko Ursulin wrote:
>>>>
>>>> [snip]
>>>>
>>>>>>
>>>>>> [snip]
>>>>>>> However I am unsure if disabling pagefaulting is needed or not. Thomas,
>>>>>>> Matt, being the last to touch this area, perhaps you could have a look?
>>>>>>> Because I notice we have a fallback iomap path which still uses
>>>>>>> io_mapping_map_atomic_wc. So if kmap_atomic to kmap_local conversion is
>>>>>>> safe, does the iomap side also needs converting to
>>>>>>> io_mapping_map_local_wc? Or they have separate requirements?
>>>>>>
>>>>>> AFAIK, the requirements for io_mapping_map_local_wc() are the same as for
>>>>>> kmap_local_page(): the kernel virtual address is _only_ valid in the caller
>>>>>> context, and map/unmap nesting must be done in stack-based ordering (LIFO).
>>>>>>
>>>>>> I think a follow up patch could safely switch to io_mapping_map_local_wc() /
>>>>>> io_mapping_unmap_local_wc since the address is local to context.
>>>>>>
>>>>>> However, not being an expert, reading your note now I suspect that I'm missing
>>>>>> something. Can I ask why you think that page-faults disabling might be
>>>>>> necessary?
>>>>>
>>>>> I am not saying it is, was just unsure and wanted some people who worked on this code most recently to take a look and confirm.
>>>>>
>>>>> I guess it will work since the copying is done like this anyway:
>>>>>
>>>>> 		/*
>>>>> 		 * This is the fast path and we cannot handle a pagefault
>>>>> 		 * whilst holding the struct mutex lest the user pass in the
>>>>> 		 * relocations contained within a mmaped bo. For in such a case
>>>>> 		 * we, the page fault handler would call i915_gem_fault() and
>>>>> 		 * we would try to acquire the struct mutex again. Obviously
>>>>> 		 * this is bad and so lockdep complains vehemently.
>>>>> 		 */
>>>>> 		pagefault_disable();
>>>>> 		copied = __copy_from_user_inatomic(r, urelocs, count * sizeof(r[0]));
>>>>> 		pagefault_enable();
>>>>> 		if (unlikely(copied)) {
>>>>> 			remain = -EFAULT;
>>>>> 			goto out;
>>>>> 		}
>>>>>
>>>>> Comment is a bit outdated since we don't use that global "struct mutex" any longer, but in any case, if there is a page fault on the mapping where we need to recurse into i915 again to satisfy if, we seem to have code already to handle it. So kmap_local conversion I *think* can't regress anything.
>>>>
>>>> Thanks for your explanation!
>>>>
>>>>>
>>>>> Patch to convert the io_mapping_map_atomic_wc can indeed come later.
>>>>
>>>> Okay, I will also look at this.
>>>>
>>>>>
>>>>> In terms of logistics - if we landed this series to out branch it would be queued only for 6.5. Would that work for you?
>>>>
>>>> Yeah, it's ok for me. But could I ask, did I miss the 6.4 merge time?
>>>
>>> Yes, but just because we failed to review and merge in time, not because you
>>> did not provide patches in time.
>>
>> It is worth mentioning that under drm we close the merge window earlier.
>> Around -rc5.
>>
>> So, Linus' merge window for 6.4 didn't happen yet. But our drm-next that
>> is going to be sent there is already closed.
>>
>>>
>>> Regards,
>>>
>>> Tvrtko
>>>
