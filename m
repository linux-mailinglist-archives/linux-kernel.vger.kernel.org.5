Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E09E77CDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbjHOOAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbjHOOAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:00:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A51D1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692108009; x=1723644009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jFg6+ygBgtTz0t27/ZViFNE4X16j6COx/+N58kJrkiA=;
  b=cdtKUM81Ma98OicPFrTe+S5DDGfdXttmEbyAQi1CiqR2o/Fn43rxIGYs
   KX5Ul1P2hkVC2Hf0oD/uhQD24wLaJREckUQPitAHbISoop9Yy1YFH1/MR
   1QDkSr4sbXxVW64BrjJWiPNs+hidophjo01EJuzXwF3bAMj8E3x0URQgj
   9qk4itiEK2UmdsiAPRrTg1yGk6n5LStiOgWKNkoQKRL0yu0YrIl8ecAuH
   JQWsghB5zwxBs6GRTYtt8IT+KpJFsJ5WL1/8NeNn3Wt7ZX2Z20GqVo20g
   eod0RJJBiWdgmuI8/zCxaWwNBBLaiEc1uEcy4iCurSr+7tUQEHe8NquZe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375051125"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="375051125"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="683660812"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="683660812"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2023 07:00:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qVuab-004EoF-2h;
        Tue, 15 Aug 2023 17:00:05 +0300
Date:   Tue, 15 Aug 2023 17:00:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/25] ASoC: dmaengine: Convert to generic PCM copy ops
Message-ID: <ZNuE5UunDd40e8vW@smile.fi.intel.com>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-22-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-22-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:55:19PM +0200, Takashi Iwai wrote:
> This patch converts the ASoC dmaenging driver code to use the new
> unified PCM copy callback.  It's a straightforward conversion from
> *_user() to *_iter() variants.
> 
> The process callback is still using the direct pointer as of now, but
> it'll be converted in the next patch.
> 
> Note that copy_from/to_iter() returns the copied bytes, hence the
> error condition is inverted from copy_from/to_user().

...

>  	if (is_playback)
> -		if (copy_from_user(dma_ptr, buf, bytes))
> +		if (!copy_from_iter(dma_ptr, bytes, buf))

!= bytes ?

>  			return -EFAULT;

Can be compressed to a single conditional:

	if (is_playback && copy_from_iter(dma_ptr, bytes, buf) != bytes)

...

>  	if (!is_playback)
> -		if (copy_to_user(buf, dma_ptr, bytes))
> +		if (!copy_to_iter(dma_ptr, bytes, buf))
>  			return -EFAULT;

As per above.

-- 
With Best Regards,
Andy Shevchenko


