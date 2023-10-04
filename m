Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879A57B7B11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbjJDJGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241910AbjJDJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:05:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0D2F4;
        Wed,  4 Oct 2023 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696410342; x=1727946342;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TuSBtMiLTwOnYSwHDKjzTnmtHNlxvtFoBDS51b++/4w=;
  b=PRYrE4Y1Y/m86hN8qkap8onWEBgZHsMWITvehV5I7Mn1beSSAeRAFfws
   3+tllcAtp0VIeBx6K165sHqGafEpEzCQ87INn4vMk5NLnnwR5F6R8fipt
   zilVPC95OMWowMLeEtFvMlktBHO49Rcb+zQ8QFVB63nNtvMBEG0l6q6Fg
   IOGgCVY6rktMIlFm9d1Gq6QsKfan+vXfK/i4PZxjXCdZLgWUv4uonoikA
   C3wdmYqbf1siWAplYJ4hE4ljIlz74ekDeENO/zoH0JXltu7+/uAX776Yr
   AIPfzCHuJkfB09V2GqkXeseDO3Rz7AGfO+nfQIWTo4+3uxPnWka2nzp7h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381970906"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="381970906"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="786427644"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="786427644"
Received: from cyrillet-mobl.ger.corp.intel.com ([10.252.55.203])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:05:37 -0700
Date:   Wed, 4 Oct 2023 12:05:35 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Check for valid console index
In-Reply-To: <20231004085511.42645-1-tony@atomide.com>
Message-ID: <1fc2dc1d-33f2-6d65-6bdb-d4c7421cbc57@linux.intel.com>
References: <20231004085511.42645-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023, Tony Lindgren wrote:

> Let's not allow negative numbers for console index.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -611,7 +611,7 @@ static int univ8250_console_setup(struct console *co, char *options)
>  	 * if so, search for the first available port that does have
>  	 * console support.
>  	 */
> -	if (co->index >= UART_NR)
> +	if (co->index < 0 || co->index >= UART_NR)
>  		co->index = 0;

The inconsistencies how different serial drivers handle this situation 
seem staggering. Perhaps there should be some effort to make the behavior
uniform across them?

-- 
 i.

