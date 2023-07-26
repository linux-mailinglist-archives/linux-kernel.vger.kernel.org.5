Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A0676396A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjGZOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGZOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:42:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE4A10DB;
        Wed, 26 Jul 2023 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690382526; x=1721918526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZxC6gwU9yWXdN1PqA4ssVDQ/brLW7zgoTQ9uUdeKKU0=;
  b=YGTAty6qe2KoxsufowERzMEv90MeNvzx/g0Isz5AwL2k773qtPVWbJkf
   ltrPfnXVv0gKmLrgyBc+VupmH2z+/P/rrXw8BvDH0R8b2N6G6Ehl9rC4T
   pbyQTbC5u8o4FDNEd/KiHaSblrpW+Zpl3IOxfJrKJLMOJnsbECuMrwwan
   27LADtK7QBxbZTHJwbUZw1sTfVLE37w0Afyn18Ax/lno2Dra58vEfDRVf
   MBpHtPns02M/tw5VypDSWgUBs2CFnAjetcd58yyWIqENdlTetvSAavKhR
   j/k2l7Z/SmRPnKHRpt32iPT0b9jDYEkYeeDwvGiwFYrQ7+QPgSx2N+Uzz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371645477"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="371645477"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 07:42:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756270101"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="756270101"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2023 07:42:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOfiD-00BKUL-0p;
        Wed, 26 Jul 2023 17:42:01 +0300
Date:   Wed, 26 Jul 2023 17:42:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ruihong Luo <colorsu1922@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        stable@vger.kernel.org, luoruihong@xiaomi.com,
        weipengliang@xiaomi.com, wengjinfei@xiaomi.com
Subject: Re: [PATCH v4] serial: 8250_dw: Preserve original value of DLF
 register
Message-ID: <ZMEwuMLQlwABZeRo@smile.fi.intel.com>
References: <20230713004235.35904-1-colorsu1922@gmail.com>
 <5fac4a28-ff70-d6e6-dcee-8cb45916789@linux.intel.com>
 <ZLFAD8lblUA6/cVd@smile.fi.intel.com>
 <2023072546-ladies-landlord-8a6d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023072546-ladies-landlord-8a6d@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:31:17PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 14, 2023 at 03:31:11PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 14, 2023 at 03:07:42PM +0300, Ilpo Järvinen wrote:
> > > On Thu, 13 Jul 2023, Ruihong Luo wrote:
> > > 
> > > > Preserve the original value of the Divisor Latch Fraction (DLF) register.
> > > > When the DLF register is modified without preservation, it can disrupt
> > > > the baudrate settings established by firmware or bootloader, leading to
> > > > data corruption and the generation of unreadable or distorted characters.
> > > > 
> > > > Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
> > 
> > > You forgot to add:
> > > 
> > > Cc: stable@vger.kernel.org
> > 
> > It's there. Just not in the commit message. It's fine.
> 
> No it isn't, that's not how to have a patch added to the stable tree, as
> my form letter says:
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>
> 
> I'll go fix it up by hand...

Good to know, thank you for the clarification!


-- 
With Best Regards,
Andy Shevchenko


