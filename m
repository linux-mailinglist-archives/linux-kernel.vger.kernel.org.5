Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE2783F85
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjHVLiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbjHVLh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:37:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A251BE;
        Tue, 22 Aug 2023 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692704252; x=1724240252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qTy2dsEMxoSY4LsyRuCSkODsgDqQ6tQo1/+kl7l0kv0=;
  b=k8jHIvrvcL/XB4HSw2lgKH/RWh/GEI+tiXyOB5EVaRqifrCXp4FWaLyA
   Cr33tlhUdb/GK3219quTix7gZQ/WHlCNdI2mToDJ+6Fh+JMXWZc+qDXO+
   rhYQ7KC858MxfzvyaYLghkjrwfz/ExekcEWKiBOVm6SwGmzMW1TgZgywO
   WKfYgh66DDyXr/cIe+aMIIVEf7p/9tvmD3x3AZUWPRQ//90ct0NALWYFa
   trLP74mYLqndxCluOAdTiLUWFOMBeyyu6hHF6GXfuP6KD0XQXFp4jd2Qg
   dBc4OBW/HlLYbwU+CwFp1i6NP7NlYP7EKZqXHuwvNnTThyuiWEU3AY62W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="377612957"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="377612957"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 04:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826302594"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="826302594"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2023 04:36:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYPgN-008MbU-0o;
        Tue, 22 Aug 2023 14:36:23 +0300
Date:   Tue, 22 Aug 2023 14:36:22 +0300
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
Subject: Re: [PATCH v4] serial: 8250_bcm7271: improve bcm7271 8250 port
Message-ID: <ZOSdthfLS1v4TJlH@smile.fi.intel.com>
References: <1692643978-16570-1-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692643978-16570-1-git-send-email-justin.chen@broadcom.com>
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

On Mon, Aug 21, 2023 at 11:52:51AM -0700, Justin Chen wrote:
> The 8250 BCM7271 UART is not a direct match to PORT_16550A and other
> generic ports do not match its hardware capabilities. PORT_ALTR matches
> the rx trigger levels, but its vendor configurations are not compatible.
> Unfortunately this means we need to create another port to fully capture
> the hardware capabilities of the BCM7271 UART.
> 
> To alleviate some latency pressures, we default the rx trigger level to 8.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +	[PORT_BCM7271] = {
> +		.name		= "Broadcom BCM7271 UART",
> +		.fifo_size	= 32,
> +		.tx_loadsz	= 32,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
> +		.rxtrig_bytes	= {1, 8, 16, 30},
> +		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
> +	},

Strictly speaking it's better to keep this ordered according to the number, but
it's fine like this anyway.

-- 
With Best Regards,
Andy Shevchenko


