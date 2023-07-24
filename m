Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7141775EE85
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGXI4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjGXI4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:56:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659AE77;
        Mon, 24 Jul 2023 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690188994; x=1721724994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Sanj8x3txkk1MfhvdUrm4JxfTPXk0pxg4AntIVUl48=;
  b=A97+HbW4kBEW+rsL2KD3F1RVeLHc6Jw3lsQPXO1Z1ulH8AYfG9u8/e/V
   DO1F6d6m3M96Mysj9DiMHQOVa3kOD9jheQ6HM5rMrvd78R4IFFDdPpWfZ
   eJozOCzJ3HXSRldixJNpLeAsl6gDIiygrhSIBuzWdn4givzEmaYMBv+i9
   pqVpuAKIefyYkK2YMImalPdLArXHkTQDxGMpdjUYrzA6NO3S80Lr4z04n
   MIHnylYO0DGW4wedzC/cy5E2LuAhBDIUkJU2IBYJsFYTPZVTugF5mMIwZ
   Yjhryhdkk55Vp06xoOT3jfjc0QnXSMmti4eHhussw+1DVZOwAMRUEDSTj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="370989162"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="370989162"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="790889249"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="790889249"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2023 01:55:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNrM9-005Npy-1t;
        Mon, 24 Jul 2023 11:55:53 +0300
Date:   Mon, 24 Jul 2023 11:55:53 +0300
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
Subject: Re: [PATCH v4 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <ZL48mdJbBXPdcf25@smile.fi.intel.com>
References: <20230724050709.17544-1-tony@atomide.com>
 <20230724050709.17544-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724050709.17544-4-tony@atomide.com>
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

On Mon, Jul 24, 2023 at 08:07:05AM +0300, Tony Lindgren wrote:
> We are missing the serial core controller id for the serial core port
> name. Let's fix the issue for sane /sys/bus/serial-core/devices, and to
> avoid issues addressing serial ports later on.

...

> -	return dev_set_name(dev, "%s.%s.%d", type->name, dev_name(port->dev), id);
> -}
> +	if (type == &serial_ctrl_type)

	...

> +}

While at it, have you tried to use --patience when forming patches? Does it
make any (better) difference?

-- 
With Best Regards,
Andy Shevchenko


