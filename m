Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3478975C4DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjGUKmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjGUKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:42:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF5D19A6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689936132; x=1721472132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YJlPOuKgHIq7wccQKnt6l+jd6D94pZUedrcfoFEHae4=;
  b=WhOo9qKxuBRCjv+r2zMOTKU7JyjTUg+o3oQZzdurw+l1BtyXdyVCXysH
   h4YRQd+Js5obOgRNsChtD8jQiQQzIdPjcQvm2r/IiR6hv1s5oraaMr1OS
   /528DMkdHIMQrkhqvB/8HmFZFD07hp7WlD9EiKYc9ZmN5Y9Kr3nChgJkE
   JvsVRnUywRBqN/hE5vD/JJvin24w4e7Z87wtQTUIpGzLPVIyCRz6x6EXm
   vvfzyPcphYREXjnGIA9ACi7nOFTCLm/GTcvgPfOT+afCsi7Qxbm5r6FFP
   l2wsgqexmvr0CU4I+NEffrqQ0A9bob0HB9EJKt1Fb7IpUZVsGI4vE48Nz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="367031883"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="367031883"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:42:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838510268"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="838510268"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2023 03:42:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMnaK-000WQ3-2e;
        Fri, 21 Jul 2023 13:42:08 +0300
Date:   Fri, 21 Jul 2023 13:42:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 1/1] ALSA: korg1212: Re-use sockptr_t and respective
 APIs
Message-ID: <ZLphAJG4Tz8zLUSN@smile.fi.intel.com>
References: <20230721100146.67293-1-andriy.shevchenko@linux.intel.com>
 <878rb9h901.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rb9h901.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 12:08:46PM +0200, Takashi Iwai wrote:
> On Fri, 21 Jul 2023 12:01:46 +0200,
> Andy Shevchenko wrote:
> > 
> > The sockptr_t (despite the naming) is a generic type to hold kernel
> > or user pointer and there are respective APIs to copy data to or
> > from it. Replace open coded variants in the driver by them.
> 
> While I see the benefit, I feel this is very confusing.  If we use the
> API for a generic use, it should be renamed at first.
> 
> Also, the current function actually follows the call pattern, and we
> know in the caller side whether it's called for a kernel pointer or a
> user pointer.  So, if any, the PCM core callbacks should be revised to
> use a generic pointer instead of fiddling in each driver side.

Any suggestion for the name?
And I believe for the bigger series the new callback should be added first.

-- 
With Best Regards,
Andy Shevchenko


