Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C9475C4C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjGUKfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGUKfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:35:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D90E4C;
        Fri, 21 Jul 2023 03:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689935750; x=1721471750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L/NJ/w10IQWUlEjyQLiO2uYOGxQAL9QJNmq1vUB6K94=;
  b=Zs2ia3kzcbfkEdy3u7PEylQ31UpjU/azrllNlQjCMaCZPf87Mob0S0Ps
   voUKC0c2Zb56wF/1X78+Uv8cUuNvTxO4ZXNASavgAoRZKuEEYnxgk+Ftr
   8wy864u1MK/eGYsn4yPXr8AxqfE5r40REaB/PoJ4u8NbKHcp2m3ep4qZZ
   ErGUMV/arTbq//2C3har9VaPfs0burOdpv7LdFXaZ528aABayFHLAsFLx
   9lha/XX7xk0sz87OrY4NMVyBplPX526jBglPe6bixUEnopiqQY2mmGkNh
   4W/kXnHGIbmj+afGY2F3iADbYBFD+MtrHZADmnKN2lnL1C/h2GoA0Kh1t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="364456802"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="364456802"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868201893"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 03:35:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMnU9-000Inx-2u;
        Fri, 21 Jul 2023 13:35:45 +0300
Date:   Fri, 21 Jul 2023 13:35:45 +0300
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
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <ZLpfgcDD6UeOAh/e@smile.fi.intel.com>
References: <20230721072147.59121-1-tony@atomide.com>
 <20230721072147.59121-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721072147.59121-4-tony@atomide.com>
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

On Fri, Jul 21, 2023 at 10:21:42AM +0300, Tony Lindgren wrote:
> We are missing the serial core controller id for the serial core port
> name. Let's fix the issue for sane /sys/bus/serial-core/devices, and to
> avoid issues addressing serial ports later on.

...

> +	if (type == &serial_ctrl_type)
> +		return dev_set_name(dev, "%s.%s.%d", type->name,

> +	else if (type == &serial_port_type)
> +		return dev_set_name(dev, "%s.%s.%d.%d", type->name,
> +				    dev_name(port->dev), ctrl_id,
> +				    port_id);
> +	else

Redundant 'else' in both cases.

> +		return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


