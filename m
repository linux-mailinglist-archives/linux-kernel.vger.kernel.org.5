Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2EF77CD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjHONzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjHONzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:55:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263F1198C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692107710; x=1723643710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HnOf0gzbls3T+k+P19EKNMRrb0oHlrBwaXdZmkcQNV8=;
  b=L2oWeO56OIMXQ3o4CnNRpaoS9ML/6Gmlk+6dABqS5O9MaNG+wMngxrZ8
   DcwDOzhzkKbt8RpG5eSdT+b/gkoJXySgQTJ6l68Wn1/qb+FysGfgPw0J/
   1dCaPnXp4IroWRGjS2hMnBG4gGRL26/h2AFjIqw+UxdyY7DIvHNjIqxJE
   zx4tvTcejOcjHtGMIBC6rmOnLVtj34oOsOU7/G4VNWAKRLrCD2q3Fd2l0
   XFvDzGmeOSQXOqx1zJggGFEqFJy8V8mHuR9zEkfI709PGnCEsFHIpBaiR
   MyACtsTB1sxjWbsoovkeJpR9pv5Q68ZfXrn9t0VE9dYsA0Bv4AtE5bmPn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375049999"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="375049999"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 06:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="683660176"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="683660176"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2023 06:55:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qVuVn-0044Pr-0l;
        Tue, 15 Aug 2023 16:55:07 +0300
Date:   Tue, 15 Aug 2023 16:55:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/25] ALSA: korg1212: Convert to generic PCM copy ops
Message-ID: <ZNuDugkvHrh7J/fF@smile.fi.intel.com>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-9-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-9-tiwai@suse.de>
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

On Mon, Aug 14, 2023 at 01:55:06PM +0200, Takashi Iwai wrote:
> This patch converts the korg1212 driver code to use the new unified
> PCM copy callback.  The open-coded conditional memory copies are
> replaced with simpler copy_from/to_iter() calls.
> 
> Note that copy_from/to_iter() returns the copied bytes, hence the
> error condition is inverted from copy_from/to_user().

...

> +		if (!copy_to_iter(src, size, dst))

	!= size ?


>  			return -EFAULT;

...

> +		if (!copy_from_iter(dst, size, src))
>  			return -EFAULT;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


