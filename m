Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC647C6EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378801AbjJLNN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347209AbjJLNN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:13:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D642BD9;
        Thu, 12 Oct 2023 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697116434; x=1728652434;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yi2xANWw2YYcm+3e3TDZn8x272XR7PLBLDKZ4nuOZao=;
  b=ANkOP15ssbWilVSykwFuziHQsY5sfJdI3m+51g63OLcNdojRAf8wFG2s
   WtdjaStsUwBPGE87gqDUdacWIerGMcx+CFdGohI3nJuW3qLIZBhpm4DQD
   WRuuNfcc3tZUbvQnKFcsxvYr94aZm1OZOYn7dQxWjPMQdtq0wH0mVHi0F
   18NujmlA9eHh9fCphlweLXJsIHUhW2wvsplxSQT9Cjs/+ra4CKTjGvr9E
   ukVFiCGFYzKZN4dav8MgE8cJUB7Kxy2SsPuhhBM1yxALPoQxtDc6VMwm3
   mAT/stc+hJwQrfd5QkHdmQgo51XUmlUWPEjGDZuvcC8fyghLdb6a8diNv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="415963768"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="415963768"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="730921046"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="730921046"
Received: from asroczyn-mobl.ger.corp.intel.com ([10.249.36.107])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:10:29 -0700
Date:   Thu, 12 Oct 2023 16:10:27 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LinoSanfilippo@gmx.de, Lukas Wunner <lukas@wunner.de>,
        p.rosenberger@kunbus.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/6] serial: core: fix sanitizing check for RTS
 settings
In-Reply-To: <20231011181544.7893-4-l.sanfilippo@kunbus.com>
Message-ID: <40e4c6b1-e217-2926-a351-bf685a5b775f@linux.intel.com>
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com> <20231011181544.7893-4-l.sanfilippo@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023, Lino Sanfilippo wrote:

> Among other things uart_sanitize_serial_rs485() tests the sanity of the RTS
> settings in a RS485 configuration that has been passed by userspace.
> If RTS-on-send and RTS-after-send are both set or unset the configuration
> is adjusted and RTS-after-send is disabled and RTS-on-send enabled.
> 
> This however makes only sense if both RTS modes are actually supported by
> the driver.
> 
> With commit be2e2cb1d281 ("serial: Sanitize rs485_struct") the code does
> take the driver support into account but only checks if one of both RTS
> modes are supported. This may lead to the errorneous result of RTS-on-send
> being set even if only RTS-after-send is supported.
> 
> Fix this by changing the implemented logic: First clear all unsupported
> flags in the RS485 configuration, then adjust an invalid RTS setting by
> taking into account which RTS mode is supported.
> 
> Cc: stable@vger.kernel.org
> Fixes: be2e2cb1d281 ("serial: Sanitize rs485_struct")
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/serial_core.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 697c36dc7ec8..f4feebf8200f 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1370,19 +1370,27 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
>  		return;
>  	}
>  
> +	rs485->flags &= supported_flags;
> +
>  	/* Pick sane settings if the user hasn't */
> -	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
> -	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
> +	if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
>  	    !(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
> -		dev_warn_ratelimited(port->dev,
> -			"%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
> -			port->name, port->line);
> -		rs485->flags |= SER_RS485_RTS_ON_SEND;
> -		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
> -		supported_flags |= SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND;
> -	}
> +		if (supported_flags & SER_RS485_RTS_ON_SEND) {
> +			rs485->flags |= SER_RS485_RTS_ON_SEND;
> +			rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
>  
> -	rs485->flags &= supported_flags;
> +			dev_warn_ratelimited(port->dev,
> +				"%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
> +				port->name, port->line);
> +		} else {
> +			rs485->flags |= SER_RS485_RTS_AFTER_SEND;
> +			rs485->flags &= ~SER_RS485_RTS_ON_SEND;

So if neither of the flags is supported, what will happen? You might want 
add if after that else?

-- 
 i.

