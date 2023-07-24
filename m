Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD50375EE61
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjGXIxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjGXIxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:53:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F4E7;
        Mon, 24 Jul 2023 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690188795; x=1721724795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LcRTXW7A98A1iH6wH475L2ndJh4dAaJUqJWpj/zpQZ8=;
  b=EtRdQvbfhF+roVoOP8fJfn0HTmRtcKFVklDmXO7/2p8LnQphb/gFRlkp
   1akFkyOSs7dXjH85pMKiZm19JMZRX3ziktTpMgo1jDmhIbQ8kvFX2TzVm
   vjZlkwE3TxkhWUXWgTr6pQUA9kCBXkaD+Cx2byUVuX24dPeC/+Uz4Rvu5
   f2PcQxgkZj3y+9823HExsFVz5nF/EmGjiRFW9s/cEgnZT4C2Ex3CB5kGx
   elnznVeEVSHbluOec5cHLCSrBmIdjljsKq9P4yCDDPcjkD2ZcOaKk2Bc2
   Fxp3Car/LJCfxIq76OF3tzs7G2yFodlXnVII2FXrKsnv3DLiN6h6dhK+P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="366279758"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366279758"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="869003822"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2023 01:53:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNrJV-005Hoz-2y;
        Mon, 24 Jul 2023 11:53:09 +0300
Date:   Mon, 24 Jul 2023 11:53:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/3] serial: core: Controller id cannot be negative
Message-ID: <ZL479clNYW4YG1mE@smile.fi.intel.com>
References: <20230724050709.17544-1-tony@atomide.com>
 <20230724050709.17544-2-tony@atomide.com>
 <ZL471yzIKu1xG/PF@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL471yzIKu1xG/PF@smile.fi.intel.com>
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

On Mon, Jul 24, 2023 at 11:52:39AM +0300, Andy Shevchenko wrote:
> On Mon, Jul 24, 2023 at 08:07:03AM +0300, Tony Lindgren wrote:
> > The controller id cannot be negative. Let's fix the ctrl_id in preparation
> > for adding port_id to fix the device name.
> > 
> > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ???
> Missing Reviewed-by: I suppose?

Seems like it wen in all patches... :-(

-- 
With Best Regards,
Andy Shevchenko


