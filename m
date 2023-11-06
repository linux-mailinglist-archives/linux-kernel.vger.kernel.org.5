Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16E87E1E13
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjKFKPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjKFKPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:15:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CF493;
        Mon,  6 Nov 2023 02:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699265726; x=1730801726;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x338Ogbpp9uWR2sIcLcKna5qVpCr3xQ+iG9tZ2WPL/g=;
  b=jgbbYbfmxTAOJA77GviU4LKgrJ6UmAuveOvnIV3zjJ/+wE7Pj9Jm3wJl
   sC4SqsC3dBeosQLlLaSWdNiZ2uHKvMX2dD1aqjBOcSIAY8MtxUW8H3ISO
   +82eUjBx6OIHyam33HgxZ1KYb7729477vWFB2wCEzJFi6nM5gil+e+W53
   SiDmi/E3vtxNzKq+WeVVkfb/pfHxMRX+dsDEfmwo/+pIYvuV882mT402w
   c+wRiR9yLsUbpx6TOiVl70uYkSBL78Lp+A1ifO+v01CeaVK4tLAleYL42
   NR+ffED14Lv+pltmKl/6qaFZOI2U/VtkgwOlqqedQLem3JWjlwQqRV7ea
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="455729333"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="455729333"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:15:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="765906552"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="765906552"
Received: from ajayshan-mobl.ger.corp.intel.com (HELO [10.213.234.152]) ([10.213.234.152])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:15:22 -0800
Message-ID: <b4fa0e2b-53f6-4015-9be0-41b45a6b5f4e@linux.intel.com>
Date:   Mon, 6 Nov 2023 10:15:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/i915: Fix potential spectre vulnerability
Content-Language: en-US
To:     Andi Shyti <andi.shyti@linux.intel.com>,
        Kunwu Chan <chentao@kylinos.cn>
Cc:     airlied@gmail.com, alan.previn.teres.alexis@intel.com,
        andrzej.hajda@intel.com, chris.p.wilson@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jonathan.cavitt@intel.com,
        joonas.lahtinen@linux.intel.com, kunwu.chan@hotmail.com,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        rodrigo.vivi@intel.com, stable@vger.kernel.org
References: <d300506c-ab82-4cc1-b750-61e54ec2ad9e@linux.intel.com>
 <20231103023257.58199-1-chentao@kylinos.cn>
 <ZUi4ploYfYyZvmO7@ashyti-mobl2.lan>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <ZUi4ploYfYyZvmO7@ashyti-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/11/2023 09:57, Andi Shyti wrote:
> Hi Kunwu,
> 
> On Fri, Nov 03, 2023 at 10:32:57AM +0800, Kunwu Chan wrote:
>> Fix smatch warning:
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:847 set_proto_ctx_sseu()
>> warn: potential spectre issue 'pc->user_engines' [r] (local cap)
>>
>> Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
>> Cc: <stable@vger.kernel.org> # v5.15+
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>> Link: https://lore.kernel.org/all/20231102101642.52988-1-chentao@kylinos.cn
>> ---
>>   drivers/gpu/drm/i915/gem/i915_gem_context.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> index 9a9ff84c90d7..e38f06a6e56e 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> @@ -844,6 +844,7 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
>>   		if (idx >= pc->num_user_engines)
>>   			return -EINVAL;
>>   
>> +		idx = array_index_nospec(idx, pc->num_user_engines);
> 
> you ignored my comment, though.

Sorry it was me, I considered it fine as is given it is the same pattern 
as elsewhere in the file. I've merged the patch btw.

Regards,

Tvrtko

> 
> Andi
> 
>>   		pe = &pc->user_engines[idx];
>>   
>>   		/* Only render engine supports RPCS configuration. */
>> -- 
>> 2.34.1
