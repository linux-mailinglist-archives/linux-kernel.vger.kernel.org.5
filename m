Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E76B7FB91A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjK1LMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjK1LMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:12:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BDAD6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701169934; x=1732705934;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4sQGMsoKH4XsBlVx0DVZlFut2gRlSwx7PwBvuuYhn4w=;
  b=T4GeaJRcTTUh1WW5b/5jF4CdjVS3X9agR4DO1qaSweyFEpChyjEWUiYs
   IGrYtkH1p7mAUAMlH5nn5LVmvhL55v8ChIaTuKQD6NohAwEuNcJy+TTxm
   PKReP7qzlOq9wM8e6kPA7/9P3jwihuhobGbAfXEIM7EtKYOKFaSnZpqWR
   niRBTUzrZ0Z5PVHN+Y4vR6n3aomu/3qzIlOntzmOpOgOR94tUsoHDpEmP
   nNt3AJEEtRCcWncLCBFDrjxouJJGo0IMXvMDyvHi6RpXatViKsuKyXIMg
   Hh0KUcoz3PNxysbkm1gUA+LGg8ZA0vDeHt8WLJD3lkv/2sjcqGfe1Ay18
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="14460251"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="14460251"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 03:12:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="859398036"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="859398036"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.14.21]) ([10.213.14.21])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 03:12:10 -0800
Message-ID: <51baffb9-2249-4080-a245-eb1e03c02b9b@intel.com>
Date:   Tue, 28 Nov 2023 12:12:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-gfx] [PATCH] drm/i915/display: Fix phys_base to be
 relative not absolute
Content-Language: en-US
To:     Paz Zcharya <pazz@chromium.org>
Cc:     Subrata Banik <subratabanik@google.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Marcin Wojtas <mwojtas@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sean Paul <seanpaul@chromium.org>, matthew.auld@intel.com,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Drew Davenport <ddavenport@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Nirmoy Das <nirmoy.das@intel.com>
References: <20231105172718.18673-1-pazz@chromium.org>
 <ZVQ3d8FFqxsy0OX7@intel.com> <ZVfw3ghfBLdHB7uk@google.com>
 <8dd6f4da-dcc9-4ea3-8395-bf048b0dbc93@intel.com>
 <6f08cfee-a60b-4f6e-b69a-20517c563259@intel.com>
 <ZWVizpRkf5iJ2LnQ@google.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <ZWVizpRkf5iJ2LnQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.2023 04:47, Paz Zcharya wrote:
> 
> On Mon, Nov 27, 2023 at 8:20 PM Paz Zcharya <pazz@chromium.org> wrote:
>>
>> On 21.11.2023 13:06, Andrzej Hajda wrote:
>>> On 18.11.2023 00:01, Paz Zcharya wrote:
>>>> On Tue, Nov 14, 2023 at 10:13:59PM -0500, Rodrigo Vivi wrote:
>>>>> On Sun, Nov 05, 2023 at 05:27:03PM +0000, Paz Zcharya wrote:
>>>>
>>>> Hi Rodrigo, thanks for the great comments.
>>>>
>>>> Apologies for using a wrong/confusing terminology. I think 'phys_base'
>>>> is supposed to be the offset in the GEM BO, where base (or
>>>> "Surface Base Address") is supposed to be the GTT offset.
>>>
>>> Since base is taken from PLANE_SURF register it should be resolvable via
>>> GGTT to physical address pointing to actual framebuffer.
>>> I couldn't find anything in the specs.
>>
>> It was quite cryptic. I meant I have not found anything about assumption
>> from commit history that for iGPU there should be 1:1 mapping, this is why
>> there was an assignment "phys_base = base". Possibly the assumption is not
>> valid anymore for MTL(?).
>> Without the assumption we need to check GGTT to determine phys address.
>>
>>> The simplest approach would be then do the same as in case of DGFX:
>>>           gen8_pte_t __iomem *gte = to_gt(i915)->ggtt->gsm;
>>>           gen8_pte_t pte;
>>>
>>>           gte += base / I915_GTT_PAGE_SIZE;
>>>
>>>           pte = ioread64(gte);
>>>           phys_base = pte & I915_GTT_PAGE_MASK;
>>>
>>> Regards
>>> Andrzej
> 
> Hey Andrzej,
> 
> On a second thought, what do you think about something like
> 
> +               gen8_pte_t __iomem *gte = to_gt(i915)->ggtt->gsm;
> +               gen8_pte_t pte;
> +               gte += base / I915_GTT_PAGE_SIZE;
> +               pte = ioread64(gte);
> +               pte = pte & I915_GTT_PAGE_MASK;
> +               phys_base = pte - i915->mm.stolen_region->region.start;
> 
> The only difference is the last line.

Bingo :) It seems to be generic algorithm to get phys_base for all 
platforms:
- on older platforms stolen_region points to system memory which starts 
at 0,
- on DG2 it uses lmem region which starts at 0 as well,
- on MTL stolen_region points to stolen-local which starts at 0x800000.

So this whole "if (IS_DGFX(i915)) {...} else {...}" could be replaced
with sth generic.
1. Find pte.
2. if(IS_DGFX(i915) && pte & GEN12_GGTT_PTE_LM) mem = 
i915->mm.regions[INTEL_REGION_LMEM_0] else mem = i915->mm.stolen_region
3. phys_base = (pte & I915_GTT_PAGE_MASK) - mem->region.start;

Regards
Andrzej


> 
> Based on what I wrote before, I think `phys_base` is named incorrectly and
> that it does not reflect the physical address, but the start offset of
> i915->mm.stolen_region. So if we offset the start value of the stolen
> region, this code looks correct to me (and it also works on my
> MeteorLake device).
> 
> What do you think?
> 
> 
> Many thanks,
> Paz
> 

