Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0039E75F3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjGXKxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjGXKxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:53:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13B5109;
        Mon, 24 Jul 2023 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196004; x=1721732004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I3RsDyPZmFH/6hLZYAuRnBtWMLHHTvXV7RIFZdVLPwU=;
  b=k954BaFiN4FXr+SgZd7A3ZLdHpJ4rW+bbG6QbUx0voiJPsvLyKCYjXfJ
   lc5nNjuLb1tWORwrALuusYAW6C/uGvtklCvmss3dhYs5aOS14RPObS5bv
   GYG/bXQByCnYa3KI+dZ3VHxnIr72aGfkbHZFqZJ76TvpRSj2xjWdFeA40
   gEm55GbRsKTtN1pptgtrPhcTI0kjABBVifhaj+bZe8bD2tTTHymAraq02
   uvaL1Ud85X52hxs9MRWNI6rUDkvcC2lQsBjczzF6qN8oqnee5pFQJ92rU
   O9eTmkw4p7jU3IdheKcMONetf7uDP66Cmn8OL9pPc3tzY37GL5ees/0NX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="453784008"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="453784008"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839406654"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839406654"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 03:53:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNtBp-009TG8-1p;
        Mon, 24 Jul 2023 13:53:21 +0300
Date:   Mon, 24 Jul 2023 13:53:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 7/8] iio: core: Move initcalls closer to the
 respective calls
Message-ID: <ZL5YIUFeASdx+J4w@smile.fi.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
 <20230721170022.3461-8-andriy.shevchenko@linux.intel.com>
 <20230723102335.6df07e6d@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723102335.6df07e6d@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 10:23:35AM +0100, Jonathan Cameron wrote:
> On Fri, 21 Jul 2023 20:00:21 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Move subsys_initcall() and module_exit() closer to the respective calls.
> 
> Why? For this particular set of macros I can see advantages to them being
> near the code and to them being in a fairly predictable location (end of
> file).
> 
> I think the patch description should make the why argument. 

The documented case is about exported symbols.
Now I looked for the module_*() stuff and there is no consensus
between subsystems. Both styles are being documented and used.

I think I may drop this. Someone also can investigate the trends,
but I won't spend my time on this.

Thank you for the review.

-- 
With Best Regards,
Andy Shevchenko


