Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637757825CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjHUItv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbjHUItt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:49:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7299BBB;
        Mon, 21 Aug 2023 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692607787; x=1724143787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4OvhXE9BEH8lho9tHmIhx8J5oxgCxOBcUfxNpjfihmc=;
  b=BvXwRbVcYp8fJsiDqgWmW4kw4HzgZZ+QExr47DOlFUH1P3MmNJseMNG8
   iSZsOC9sN/719A7IF5zULUKx0W6HZeEKwIKmMP/s+ZEhZIwioRIeXn9Ed
   TmJW+2wiOz08TRfGTvWqmqXooMalLPdShO1bdddyFwAwqmGVimxhP+2zd
   Fx9B9Qej5zyLyBm/BhaR3oX/+A62kiZWMgEYz4BNknlHQjsddkODCHtnb
   o70CVC6VNKRaU+dPx1eHdqpvt6HBjJJG+98qcHGUm2XJTSEvA83Xe/Cmo
   IlPO+jZlhgNrXPwvPBfmB1Gq6dZklrCrW1FUPQkXw0LabTPGV5POki3Tc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="377274510"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="377274510"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="859409797"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="859409797"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2023 01:49:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY0bV-006Myi-0E;
        Mon, 21 Aug 2023 11:49:41 +0300
Date:   Mon, 21 Aug 2023 11:49:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     linux-serial@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        "open list:TTY LAYER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] serial: 8250_bcm7271: improve bcm7271 8250 port
Message-ID: <ZOMlJAKfQC8W6OkE@smile.fi.intel.com>
References: <1692393971-31361-1-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692393971-31361-1-git-send-email-justin.chen@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:26:08PM -0700, Justin Chen wrote:
> The 8250 BCM7271 UART is not a direct match to PORT_16550A and other
> generic ports do not match its hardware capabilities. PORT_ALTR matches
> the rx trigger levels, but its vendor configurations are not compatible.
> Unfortunately this means we need to create another port to fully capture
> the hardware capabilities of the BCM7271 UART.
> 
> To alleviate some latency pressures, we default the rx trigger level to 8.

...

> v3
> 	- Switch PORT_BCM7271 to 13

This was very bad suggestion, sorry. You need to use another gap.

So, that seventy something was good enough.


-- 
With Best Regards,
Andy Shevchenko


