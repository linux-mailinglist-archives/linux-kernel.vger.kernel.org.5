Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEBC7A79D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjITK43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjITK40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:56:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED19D3;
        Wed, 20 Sep 2023 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695207380; x=1726743380;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gOPASgTUaTDhCAFxC5YuBhI+3Lyk6hWmJdybfQUtMWg=;
  b=n/zxCFjVu4pQ+3U8ElMrRdavk5LG7RDjCa1I07IG9OR9CqtSjSEvpWyl
   58zgBpYDWk1J5aMGHTUwf8kfK3xINacYpjcn7Egx3lFdiV2U4VxpsMEGu
   NVb4m8XVwS8qb6qWBdrlGQ6vP2zvzUER8PqeKt/+UJctrpLWp4bv/T7EJ
   on8z+BVFW0HfbrxO01PwGkBVB9MbwYON2PMmbG3GpPSxGNMHFTJOWtF0r
   24mWEhfB3vKQ4oWXx2fL0QpXWiw0BV6Y6AgDQNIG/rdc6aPruaO9zxOXL
   GAbqSyCzFIWTK3S7ivXJmxXlapoB9Mv96EUD9xEyVghclsZu+6L9CddAQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="360446705"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="360446705"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 03:56:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="723228889"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="723228889"
Received: from swegrzyn-mobl.ger.corp.intel.com ([10.252.52.91])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 03:56:14 -0700
Date:   Wed, 20 Sep 2023 13:56:12 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] printk: Constify name for
 add_preferred_console()
In-Reply-To: <ZQrGtIfqGWk-iO87@alley>
Message-ID: <d92c84c-512-22d5-58a6-f7a9e554be1@linux.intel.com>
References: <20230912110350.14482-1-tony@atomide.com> <20230912110350.14482-2-tony@atomide.com> <ZQrGtIfqGWk-iO87@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023, Petr Mladek wrote:

> On Tue 2023-09-12 14:03:43, Tony Lindgren wrote:
> > While adding a preferred console handling for serial_core for serial port
> > hardware based device addressing, Jiri suggested we constify name for
> > add_preferred_console(). The gets copied anyways. This allows serial core

Hi Tony,

"The gets copied" seems to lack a word (name?).

-- 
 i.


> > to add a preferred console using serial drv->dev_name without copying it.
> > 
> > Note that constifying options causes changes all over the place because of
> > struct console for match().
> > 
> > Cc: John Ogness <john.ogness@linutronix.de>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Makes sense:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I assume that this patch would via Greg's tree together with
> the rest of the patchset. Please, tell me if you would prefer to
> queue this via printk tree.
> 
> Best Regards,
> Petr
> 
