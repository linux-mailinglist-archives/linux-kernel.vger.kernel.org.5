Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ADF758D32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGSFek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSFei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:34:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BB01BF5;
        Tue, 18 Jul 2023 22:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689744877; x=1721280877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OBalWpngnhMPgJxMwpZBYm8SQHbLKJ7zpmUckfVSeh4=;
  b=XGXnNMd6dfsFWPi2DOExfF9EO63uYLtde0kNCJwD8B/iRBO/Os2j7Gf4
   D+8P9Z9Vlq6nDaEPev5t0rvZyZ9EQ2HvKHks9SvRVm8hM85MGRdnJeEUd
   wlUPwoNd7qct/eoW83oTfK22+eqcl5zoC5IuQORvGp9ZX44ESbQMraYfg
   1YRvUujR62AImoV43tb9V2Fo/BooYv3+I3ipB5cB66zBN7GJrhxMYiat5
   dL8WqLhPeYYVSbbNak+WjKMr/n8c2wBSLLDkLwCwGqcEkPvetZKiffXOr
   /v2+qN+CJhCHX7Cv1Z08me3mG0ZpCwNKe17pTccy0SSFxfFXil/esOgVK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369022924"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="369022924"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 22:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="789289419"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="789289419"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2023 22:34:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLzpX-00DKc8-1C;
        Wed, 19 Jul 2023 08:34:31 +0300
Date:   Wed, 19 Jul 2023 08:34:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix serial core port id to not use
 port->line
Message-ID: <ZLd154hdaSG2lnue@smile.fi.intel.com>
References: <20230719051235.46396-1-tony@atomide.com>
 <82c49602-8c6e-51c2-6f73-28fb9b458db8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82c49602-8c6e-51c2-6f73-28fb9b458db8@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 07:26:41AM +0200, Jiri Slaby wrote:
> On 19. 07. 23, 7:12, Tony Lindgren wrote:

...

> >   	int			ctrl_id;		/* optional serial core controller id */
> > +	int			port_id;		/* optional serial core port id */
> 
> Can the id be negative? If not, please use uint.

Does this suggestion apply to ctrl_id as well?

-- 
With Best Regards,
Andy Shevchenko


