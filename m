Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60057BB54F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjJFKcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjJFKcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:32:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B58AD;
        Fri,  6 Oct 2023 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696588368; x=1728124368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9fUH6EXJbYRX6bscbdM7bdFvMC19mlqyuBFWSrlZ5AY=;
  b=XoyMdcCIuy2axET8LAdhHdGubDlZRdru+yzog9lHfArVwGW9D5sAAAn7
   zNJO6z3eMr4oMjWQMEhb80jwogKwjSEnzHXE53CH6HWvqtIAuKb3jz11s
   Bnh03gUU+3b/jTMhPK9bvtaR1MKmT04fJwKf/0XXgtGb6AcwjWVrwe/7p
   CR+3r1KmQwOucPGWAm/KmLnR385D6d7y5DSaK8oVA09WjtGYY0XL3KqbD
   yPR3SVWSm3Vi0y4QH5/FfnQ0o9xBKnZ0xb1GVgPQzKX8YJPooT33/fV3Y
   eR9svauC6EpPaYaFAecGR9GWC5Dku+CiRBeepE4qidXZCD2ltFy9eyxdH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="387603541"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="387603541"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875899566"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875899566"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:32:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qoi8R-00000003Gd9-3LLj;
        Fri, 06 Oct 2023 13:32:43 +0300
Date:   Fri, 6 Oct 2023 13:32:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1 2/2] pinctrl: cherryview: Simplify code with cleanup
 helpers
Message-ID: <ZR/iSzJP7kaf2uVe@smile.fi.intel.com>
References: <20231006094033.3082468-1-andriy.shevchenko@linux.intel.com>
 <20231006094033.3082468-2-andriy.shevchenko@linux.intel.com>
 <20231006102641.GZ3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006102641.GZ3208943@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 01:26:41PM +0300, Mika Westerberg wrote:
> On Fri, Oct 06, 2023 at 12:40:33PM +0300, Andy Shevchenko wrote:

...

> >  	if (cfg == CHV_PADCTRL0_GPIOCFG_GPO)
> >  		return !!(ctrl0 & CHV_PADCTRL0_GPIOTXSTATE);
> > +
> 
> Unrelated whitespace change.

Will drop it.

> Otherwise looks good,
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


