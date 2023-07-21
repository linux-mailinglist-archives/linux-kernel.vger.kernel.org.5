Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D745375C73D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGUM6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGUM6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:58:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F5535B5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689944291; x=1721480291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zHA3NMVEahQuxN9TbalHSR//3tVFIu25x6Hg5W/vUXk=;
  b=P3v9pQJNu97v24wqfha6VqqeF8IqR+upQlAFo108ea7Qob6gg/BpeW3T
   jULk347b6EXBOsUFt3R6cA1vRrKNWvftxkLYZPmfY1r4f28yQRKEgH4qJ
   4VEVLgLC4oyGofwM6gMfm6cf0h4eWCSddGJEYiqHh+aMHF+fMJQ/nsdH4
   MVDIiYDKr9CO8F91Nlrm8MX02aQEs3Zz3ciclvnxstG1e1sNV1NMeRssp
   /FWqHo0VCfxthoBKoDSKGrt0fqweqtwsnrYbUmBuhE6yF5Eb4q9T/mZkM
   D2umiwwQeLZhKE/XZSgORRbwT6S1J/gTgpJlnsuiwqtxj9G3Dk1nVw+hl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346614674"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346614674"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="718806314"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="718806314"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2023 05:58:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMpht-005DfM-2R;
        Fri, 21 Jul 2023 15:58:05 +0300
Date:   Fri, 21 Jul 2023 15:58:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 1/1] ALSA: korg1212: Re-use sockptr_t and respective
 APIs
Message-ID: <ZLqA3f8tdqxzZn/k@smile.fi.intel.com>
References: <20230721100146.67293-1-andriy.shevchenko@linux.intel.com>
 <878rb9h901.wl-tiwai@suse.de>
 <ZLphAJG4Tz8zLUSN@smile.fi.intel.com>
 <87y1j9fs55.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1j9fs55.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 12:58:14PM +0200, Takashi Iwai wrote:
> On Fri, 21 Jul 2023 12:42:08 +0200,
> Andy Shevchenko wrote:
> > On Fri, Jul 21, 2023 at 12:08:46PM +0200, Takashi Iwai wrote:
> > > On Fri, 21 Jul 2023 12:01:46 +0200,
> > > Andy Shevchenko wrote:

...

> > > While I see the benefit, I feel this is very confusing.  If we use the
> > > API for a generic use, it should be renamed at first.

> > Any suggestion for the name?
> 
> It's a universal pointer...  uniptr_t?
> Or a generic pointer, genptr_t?
> 
> I'm not good at naming, and I'm open for it.

It seems it's already spread enough with this name, I would rather stick with
it for now (besides net it's used in crypto, nvme, and security).

The (new) callback though makes a lot of sense on its own.

What do you think?

-- 
With Best Regards,
Andy Shevchenko


