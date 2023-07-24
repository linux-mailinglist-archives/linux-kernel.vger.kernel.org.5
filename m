Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA94375F490
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGXLLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjGXLL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:11:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4031D8;
        Mon, 24 Jul 2023 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197089; x=1721733089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tZ+Mn45U9cntff8ECmc6tXrlWTvi0j6loy/gyXruB4Y=;
  b=eVNbP1csUdohmHKt+JqlYhux2pe790iY8u9rKgTeC7bnf10DX3EoNKOq
   zKMFpAkZZ5eEbNR7l+yGznkYgq2REHeMD3UZ25OASe/5TIrM4sYP4n4Bl
   cYMm7J6A5vEyZfcOkyPN1HVIhzSbddK6fGOIOUGcZDUGdNixL5mS6cb1O
   xWNBlWQvmQ0nm1h3TtnOeCLf1KZGtLpm4EEhqu34IJK0MqIRDNL4K50eq
   BdKyq+K9HGoTCVPoRf11cojzYNrXaEPuGj3MGEJN0QOMBQOd8ZzLO0u7M
   IBaM6K8W9xo/hFcPOS/Pj7f4Q9DMp8LRMYVtmrAv8WYKFYgC2L1bNR/04
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="371011576"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="371011576"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="869037552"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2023 04:11:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNtTI-00A6JR-2l;
        Mon, 24 Jul 2023 14:11:24 +0300
Date:   Mon, 24 Jul 2023 14:11:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kees Cook <keescook@chromium.org>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 2/4] iio: core: Add opaque_struct_size() helper and
 use it
Message-ID: <ZL5cXHAM/y1eg42D@smile.fi.intel.com>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
 <20230724110204.46285-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724110204.46285-3-andriy.shevchenko@linux.intel.com>
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

On Mon, Jul 24, 2023 at 02:02:02PM +0300, Andy Shevchenko wrote:
> Introduce opaque_struct_size() helper, which may be moved
> to overflow.h in the future, and use it in the IIO core.
> 
> Potential users could be (among possible others):
> 
> 	__spi_alloc_controller() in drivers/spi/spi.c
> 	alloc_netdev_mqs in net/core/dev.c

...

> +#define opaque_struct_size(p, a, s)	size_add(ALIGN(sizeof(*(p)), (a)), (s))

This actually might need something like __safe_aling() which takes care about
possible overflow.

Whatever, I want to hear Kees on this.

-- 
With Best Regards,
Andy Shevchenko


