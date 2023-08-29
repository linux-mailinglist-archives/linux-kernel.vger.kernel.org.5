Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2231478C504
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjH2NTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjH2NSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:18:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F321F7;
        Tue, 29 Aug 2023 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693315128; x=1724851128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7J2QJDwfsMXgCfWqfJMKUpM0mvVbSNEniUpWtVl4Uzw=;
  b=azbDd4i1GJgBZYSFbc/Uxi832wh/m3V4j8Tkua2gQXc5+oncWB2aF7fc
   tpz6c2paVNxMlDh8Hhlq1t5kZqj971pbYLA6eHL1P2IMuKwG5wwqI8r2Y
   OOZ0LrhB2GQp+Tc45ZzJD6fKEPtqmUTNr9AuOmpLnm8bTffttyRX50By0
   dOfaHbqdtu8fA6LXoTsal4m+EzW5B62UIQj0TvZDsJx5NYLpcM/96ANR1
   m5tJCf1/64MG03SKq5IWRm0iiFetYP5R+nIwQE8hrPrq6Vnb1Jg0VJQix
   DIRiuxJt/7mY+kupvTmRD5crONnnQ5D6fokNyMEuymvG+T2DX1n8QRcnK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372776934"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="372776934"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="808662221"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="808662221"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2023 06:18:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qaycE-004t5p-2s;
        Tue, 29 Aug 2023 16:18:42 +0300
Date:   Tue, 29 Aug 2023 16:18:42 +0300
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
Subject: Re: [PATCH v1 2/3] iio: imu: st_lsm6dsx: Use aligned data type for
 timestamp
Message-ID: <ZO3wMlze3HRkkoMY@smile.fi.intel.com>
References: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
 <20230815154027.12468-2-andriy.shevchenko@linux.intel.com>
 <20230828170341.3a9641f0@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828170341.3a9641f0@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:03:41PM +0100, Jonathan Cameron wrote:
> On Tue, 15 Aug 2023 18:40:26 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> >  	struct {
> >  		__le16 channels[3];
> > -		s64 ts __aligned(8);
> > +		__aligned_s64 ts;
> 
> aligned_s64 as it's internal to the kernel?

Either works, but strictly speaking you are right, better no underscored
variant.

> >  	} scan[ST_LSM6DSX_ID_MAX];

-- 
With Best Regards,
Andy Shevchenko


