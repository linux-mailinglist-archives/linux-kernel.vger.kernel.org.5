Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D276580C7D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjLKKlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjLKKlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:41:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B39A9;
        Mon, 11 Dec 2023 02:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702291276; x=1733827276;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ce2nDwoDwwwDy0UWSZtRXe6Ee4Cu3/Y2wE3oWfmwO4I=;
  b=c0RPyRIaiAiMLIdaFw31Anwas1Xk5kqBIAkG0E8ElF8AXDypipoG/qWv
   SdG1ZQzAJOPDWQ2/VnXTB8SOEWdnzEdJtEIq6G38JF/RGXsUFRiu5yhPx
   GbFucxZeTESuenp+EBtOid37nvqaFfUvWJO/H9O+VDhkcPjvrHV0CEPyW
   Mk44Xx/KfdlAzX8Axa+I/LlXLTbRr2rtZ2W0Zijohiyydm85YIeDIylGF
   KrboU1+k6qzlQwXXEDZvva+RqNG718+Srd98zsxxYkjoIIkNrFe/yQwQ7
   0viLcU3YhvY3PxiJgnL2TioLKNT1aS3ySBjj1jzwSFkQUgYl4FCclkYKl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="425753432"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="425753432"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:40:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1104428709"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1104428709"
Received: from lmckeon-mobl.ger.corp.intel.com (HELO iboscu-mobl2.ger.corp.intel.com) ([10.252.48.111])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:40:55 -0800
Date:   Mon, 11 Dec 2023 12:40:53 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        hugo@hugovil.com, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LinoSanfilippo@gmx.de, Lukas Wunner <lukas@wunner.de>,
        p.rosenberger@kunbus.com, stable@vger.kernel.org
Subject: Re: [PATCH v5 3/7] serial: core: fix sanitizing check for RTS
 settings
In-Reply-To: <20231209125836.16294-4-l.sanfilippo@kunbus.com>
Message-ID: <6d3f6867-3090-a8ca-f72a-c645a358087@linux.intel.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com> <20231209125836.16294-4-l.sanfilippo@kunbus.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-764256907-1702291259=:1867"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-764256907-1702291259=:1867
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 9 Dec 2023, Lino Sanfilippo wrote:

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
> index c254e88c8452..4eae1406cb6c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1371,19 +1371,27 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
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
> +
> +			dev_warn_ratelimited(port->dev,
> +				"%s (%d): invalid RTS setting, using RTS_AFTER_SEND instead\n",
> +				port->name, port->line);
> +		}
> +	}

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-764256907-1702291259=:1867--
