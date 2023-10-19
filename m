Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091CE7D0002
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjJSQyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjJSQyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:54:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E492F12F;
        Thu, 19 Oct 2023 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697734476; x=1729270476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LeVge4ZyAQ43SwbJRJwC0GXIoRIycv1Ay0F3olMiVIg=;
  b=ShlOQ1mCcYP7C5WkreY4/GD3Ph9h0K1ffVPKGQwciIYpHOgIJBUjtdlv
   RZBevccPCfdaVcM9g+YluWz/Q0HR1qZbplJ18xL9kcjrGjSpdhA9q9bYz
   Wq5qfcsHjAknexm55k6sEvwMXeRW4Ozge+QVZshOUPcv26zgBjUf7jX0D
   RxjP9hbJvWMpNdBPV51f6/2mVMmmnDAiwXe4jo7eMHJJ5uaQP6GeRs//H
   wxTgNyPfpzKcNuEwhTBVFEg3P7UUf9AJlR71Ono/SrNLsl5H2k/DWnlJi
   Fk+M0F5VsoAxyq7MJWv5QoIM5Om1x8hatGNdTeho0E3lgutUWeKLaM827
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="417423593"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="417423593"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 09:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="706903612"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="706903612"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 09:54:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtWI1-00000006vyR-2m5y;
        Thu, 19 Oct 2023 19:54:29 +0300
Date:   Thu, 19 Oct 2023 19:54:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergei Korolev <dssoftsk@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: bmp280: fix eoc interrupt usage
Message-ID: <ZTFfRaShatWdxGB9@smile.fi.intel.com>
References: <20231018152816.56589-1-ak@it-klinger.de>
 <20231019162209.18872-1-ak@it-klinger.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019162209.18872-1-ak@it-klinger.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 06:22:09PM +0200, Andreas Klinger wrote:
> Only the bmp085 can have an End-Of-Conversion (EOC) interrupt. But the
> bmp085 and bmp180 share the same chip id. Therefore it's necessary to
> distinguish the case in which the interrupt is set.
> 
> Fix the if statement so that only when the interrupt is set and the chip
> id is recognized the interrupt is requested.
> 
> This bug exists since the support of EOC interrupt was introduced.

> Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")

As Jonathan already commented, this is part of a tag block below...

> Also add a link to bmp085 datasheet for reference.
> 

...somewhere here.

> Suggested-by: Sergei Korolev <dssoftsk@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  v1 -> v2: Remove extra space (seen by Andy)


And seems Jonathan mentioned that this is already fixed in his tree.
Did I understand that correctly?

-- 
With Best Regards,
Andy Shevchenko


