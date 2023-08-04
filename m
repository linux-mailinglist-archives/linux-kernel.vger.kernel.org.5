Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4360D770931
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHDTpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjHDTov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:44:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EA10EA;
        Fri,  4 Aug 2023 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691178289; x=1722714289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hiLa5bnO/3w0AksEbI4uz4TnVZWx9uhje/BssYC/EA0=;
  b=nAteuVbYX9Bz600+0vNHjYyEDEte/VHkfYFp6EHkkKzjS4KwSJ6nayVD
   B7kEwfJpHBQlxbx0UMBMisxjUDx1l5ZWFhiOTcZI6J4bmUeLrwfnos2fT
   4US0gSV/nc9pF0Dviipni/JRMTn9V/CVV0gvXkiFboFSMl4ldRlvfm9oP
   eNDhAagZTp6D6uM14puiwcRv+7g02vbJ8QZVaYXsh09KiECtudFCisJyC
   FkvIZNhsfzFJhQc/NpbmQkOwxmqRYM/ugQQTP8oL7uyyHGjuDugZifFlS
   wg5Lkuqqs49J9GXFLoxDWcma5X+rRpWXPV1V/sIgFZYga16Bigug6Ap9Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="350544378"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="350544378"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:44:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="853883691"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="853883691"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 04 Aug 2023 12:44:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qS0j6-005Kg8-0V;
        Fri, 04 Aug 2023 22:44:44 +0300
Date:   Fri, 4 Aug 2023 22:44:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Fix oops for port->pm on uart_change_pm()
Message-ID: <ZM1VK6hYGYfPN0Rd@smile.fi.intel.com>
References: <20230804131553.52927-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804131553.52927-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:15:51PM +0300, Tony Lindgren wrote:
> Unloading a hardware specific 8250 driver can produce error "Unable to
> handle kernel paging request at virtual address" about ten seconds after
> unloading the driver. This happens on uart_hangup() calling
> uart_change_pm().
> 
> Turns out commit 04e82793f068 ("serial: 8250: Reinit port->pm on port
> specific driver unbind") was only a partial fix. If the hardware specific
> driver has initialized port->pm function, we need to clear port->pm too.
> Just reinitializing port->ops does not do this. Otherwise serial8250_pm()
> will call port->pm() instead of serial8250_do_pm().

Oh, good catch!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


