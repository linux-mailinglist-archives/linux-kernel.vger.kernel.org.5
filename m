Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF47F34D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjKURV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjKURV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:21:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F41D1;
        Tue, 21 Nov 2023 09:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700587283; x=1732123283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HHrIRlMBTyInkH+l0rimL1tcWgoB1ctm59Y6OgeclBc=;
  b=XLqwXpL0myNy5qWpsAjK2prhXxGZKoPW+WkW7+HuZfOKW4UbnkWUdwDa
   +emvXx54Pqwpa6KdijRT6iNJvL3+dv55PQgnAb7zcfSKek7+lhxet1xzC
   e9/gOD6xJ2GTiEbgu7xW3lM/Ha0WF9Ol4U51SiJhn3CAwipRMZedw01O+
   Y24B7iMOPdRoW23DFnhOwxOjHQ5IvW5TdVjAwF+rnXQxwCy9/BifAOwCO
   ZdfsL9Bnk3yd9zEZWM9+YLt7inHHTkCzIPpsFUP9j2Adle3QY4PTO1Mb3
   hsrihslmaJg0QOfCA4lxscdJxx998PDgMox7GkZfm67m4bUWNmTUrS4YH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10555004"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="10555004"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1013974521"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="1013974521"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:21:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r5UR2-0000000FsBl-0F8J;
        Tue, 21 Nov 2023 19:21:16 +0200
Date:   Tue, 21 Nov 2023 19:21:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] serial: core: Revert checks for tx runtime PM
 state
Message-ID: <ZVznC9PUTz-ZAZK3@smile.fi.intel.com>
References: <20231113080758.30346-1-tony@atomide.com>
 <20231113080758.30346-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113080758.30346-2-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 10:07:53AM +0200, Tony Lindgren wrote:
> This reverts commit 81a61051e0ce5fd7e09225c0d5985da08c7954a7.
> 
> With tty and serdev controller moved to be children of the serial core
> port device, runtime PM usage count of the serdev controller now
> propagates to the serial hardware controller parent device as expected.

Both are fine to me, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


