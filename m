Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFAC780AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376518AbjHRK74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376507AbjHRK7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:59:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A62708;
        Fri, 18 Aug 2023 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692356388; x=1723892388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ArsRhl9lFuD/vKwJesp8W4PKFrP31bCab33WXlfDyIo=;
  b=Va4B4fgHffbI047IYtAQgNSNaklD5mVKR0TFIEhnMrFgcl4e0QsubcuF
   +n1JmAeiy7P865HLyB8YN8+v+DsgRnn/QhrfH/zrR+So/PgZ8SHgBk3eo
   QIuAgZV1WE2AfDblt8gLdgYfJXmRPFbU+znt5zwvb4BWxWz2HBMmIVF7S
   +8HxIQeKIIQMsh+R9C26YVLrY+YunrY1URYFvD/LAFUByygPrX+KT5hrH
   nDNHqhksaWgAJGQIDp19pReXg9SW7wLknXx/2rS0fMC9TeT9xXds5aVVU
   PuEYd20EseS9sDLmAeFXOzkF9j62YZ3LrV1c7xAngLcQlDS4FrpaXqnIt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="459429189"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="459429189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878645077"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 18 Aug 2023 03:59:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWxCg-004ldN-2c;
        Fri, 18 Aug 2023 13:59:42 +0300
Date:   Fri, 18 Aug 2023 13:59:42 +0300
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
Subject: Re: [PATCH v2] serial: 8250_bcm7271: improve bcm7271 8250 port
Message-ID: <ZN9PHgS3Ds/Su8Tu@smile.fi.intel.com>
References: <1692306801-13191-1-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692306801-13191-1-git-send-email-justin.chen@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:13:18PM -0700, Justin Chen wrote:
> The 8250 BCM7271 UART is not a direct match to PORT_16550A and other
> generic ports do not match its hardware capabilities. PORT_ALTR matches
> the rx trigger levels, but its vendor configurations are not compatible.
> Unfortunately this means we need to create another port to fully capture
> the hardware capabilities of the BCM7271 UART.
> 
> To alleviate some latency pressures, we default the rx trigger level to 8.

...

> +		.flags		= UART_CAP_FIFO | UART_CAP_AFE

Leave trailing comma

...

> +/* Broadcom BCM7271 UART */
> +#define PORT_BCM7271    76

13 is free why not using it?


-- 
With Best Regards,
Andy Shevchenko


