Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802D38118FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjLMQRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjLMQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:17:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DC4D5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702484242; x=1734020242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rfezO9YRuzsS//mN/UEJzPu92Rwbsp/onIfsLfcaw00=;
  b=QXpXycAQKENM2e5BnAo/mnFaDeHRDY7XCDlkkXgB4DoUSgPXIIQepm3b
   YRtribFgaX2yvQ/ah351wnlYeAwV4V+1Tkdxoy5c/kVTZO9y78OcZXSmB
   58a/efFZdtgBb0qBRQN1GUGjMedBqmir5LgkBcYOQLci1nhOjWky5JhUv
   yROit6VIQ2XbJ15Pbl3F0ILF1F/N7ZuaXz0eZhJe1z687mVlGs+hC5VGs
   mOksU+J1rsoQy+65ARn93asQSaxTVwxzSfvdWagZZ8N8/s4D/I8GYRE4t
   L3KAPSevO62W6DWAAP30qEZjOWAMFwd2p4DVx0+hrYZ6mh1f3CaIxcgrX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="461461365"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="461461365"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:17:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774001788"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="774001788"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:17:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rDRvC-00000005ZMQ-1EHC;
        Wed, 13 Dec 2023 18:17:18 +0200
Date:   Wed, 13 Dec 2023 18:17:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alex Vinarskis <alex.vinarskis@gmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Fix the fractional clock divider
 flags
Message-ID: <ZXnZDjnor8oQNo2g@smile.fi.intel.com>
References: <20231211111441.3910083-1-andriy.shevchenko@linux.intel.com>
 <20231213161352.GQ111411@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213161352.GQ111411@google.com>
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

On Wed, Dec 13, 2023 at 04:13:52PM +0000, Lee Jones wrote:
> On Mon, 11 Dec 2023, Andy Shevchenko wrote:

...

> >  	tmp = clk_register_fractional_divider(NULL, name, __clk_get_name(tmp),
> > +					      0, lpss->priv, 1, 15, 16, 15,
> >  					      CLK_FRAC_DIVIDER_POWER_OF_TWO_PS,
> > -					      lpss->priv, 1, 15, 16, 15, 0,
> >  					      NULL);
> 
> What an ugly interface.  Intel-only too, right?

Nope, de facto way how custom clocks are being introduced.
See clk-provider.h for several similar APIs (that require an
additional, custom, flags to be supplied).

...

> Have you also fixed this in: drivers/acpi/acpi_lpss.c

Already pending in Rafael's tree, yes.

-- 
With Best Regards,
Andy Shevchenko


