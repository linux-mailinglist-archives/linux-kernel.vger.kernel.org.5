Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DE978C519
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjH2NWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbjH2NWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:22:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6C5198;
        Tue, 29 Aug 2023 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693315337; x=1724851337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d8sp4qSQkZUEOkUFOpWIf+WUTXVK3m5MY9l3IVgWXKI=;
  b=Goehiy7y78EuzRm+KsAAk3TMrjdtXE2saw7NcFZWSS1YkCmbMENGeb+T
   DoW4SzlvgJmi7ns3746agQQ2+WfDdjN36zIBKc047yA13QDMFrKSKEiP4
   29avHoi/sLYi3m39zgIuOBCyo1pNl2AItWlzE8dN1woNzodMb6bfwjfJp
   oU1+OTkJxU4i+UrFTvm24H9ap/mdtXta0/h6uYUiqBsmJhmXezed5C/wg
   2HfJGi6bg7hQAVfZrDzwfZZmh2LDbmcj2oq1zMQbd98cFS9oASx10V3j0
   fCv4XAy2XPVdbMtDQKD3sdH6FV80hvEleF+5n9NeXWa1TAWqEwCmvOWlI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="378082265"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="378082265"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="882321012"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2023 06:22:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qayfc-004t8Y-1B;
        Tue, 29 Aug 2023 16:22:12 +0300
Date:   Tue, 29 Aug 2023 16:22:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 3/3] iio: hid-sensor: Use aligned data type for
 timestamp
Message-ID: <ZO3xBHClZIXXHJVn@smile.fi.intel.com>
References: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
 <20230815154027.12468-3-andriy.shevchenko@linux.intel.com>
 <20230828170928.5264dadf@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828170928.5264dadf@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:09:28PM +0100, Jonathan Cameron wrote:
> On Tue, 15 Aug 2023 18:40:27 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > -	/* Ensure timestamp is naturally aligned */
> 
> Comment is still true and no more or less obvious than it was with the old code
> I think so I don't really see why it should be removed with this change.

Doesn't the prefix "aligned" make this comment somehow redundant?

> >  	struct {
> >  		u32 accel_val[3];
> > -		s64 timestamp __aligned(8);
> > +		aligned_s64 timestamp;
> >  	} scan;

...

> > -		s32 sampled_vals[4] __aligned(16);
> > +		s32 sampled_vals[4];
> 
> Hmm. I can't immediately recall why that aligned(16) is therebut
> it's not related to the rest of this change so I'm not sure we should touch
> it. I don't think we ever required quaternions to be aligned as a whole so
> this does feel odd but in the category of something we should be careful
> touching or at very least do it in a different patch where it stands out.

I have checked the code and find nothing that justifies this, I can split it
to a separate patch, though.

Note, among ISH HID drivers it's the only one with a such...

> > +		aligned_s64 timestamp;
> >  	} scan;


-- 
With Best Regards,
Andy Shevchenko


