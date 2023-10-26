Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543717D819A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjJZLOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:13:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF18D1AE;
        Thu, 26 Oct 2023 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698318836; x=1729854836;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3TAab8TB4vv1p66SQlnTI2bAv1DAoX27ePZ2oXPLufM=;
  b=HuE1j0LlpNSXoiM1Xf38fyy63ylasWnknFre5x6ULCDy42jictep2mdN
   rO89OU5NrHVQTaTkCtJBUmdf9TUdNfoU0p0CMgsTO1tsf6hRzrw8VhYX6
   akQhY1tWrA1XiZFXTnksjWl76WqO1FRIPzWWjIiFSaK8PxrpFWYYZpl5E
   aousc+OrB76DDFuF6W/57+g7UzSaYPGp6tPCCHmSjg7Sa5I6RPYlA9/C8
   MdxBatMDWVx24fYzwCb/7rwVvbiwvQy5sLgAoEzSFx/Brt3f5HANswRUU
   exd3+IxElZa3iUOEpjv3RTJPVs8hOeOROPx4Lf4BK6ImKn33haOZTBuh6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9071611"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="9071611"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 04:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="794167959"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="794167959"
Received: from weissenb-mobl1.ger.corp.intel.com ([10.252.32.65])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 04:13:51 -0700
Date:   Thu, 26 Oct 2023 14:13:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>
cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6,
 7 or 8 in _get_options
In-Reply-To: <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
Message-ID: <3cc1f559-468-8a58-a919-bdfb45ecc90@linux.intel.com>
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-427932746-1698318835=:2173"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-427932746-1698318835=:2173
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 26 Oct 2023, Théo Lebrun wrote:

> pl011_console_get_options() gets called to retrieve currently configured
> options from the registers. Previously, LCRH_TX.WLEN was being parsed
> as either 7 or 8 (fallback). Hardware supports values from 5 to 8
> inclusive, which pl011_set_termios() exploits for example.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 5774d48c7f16..b2062e4cbbab 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2384,10 +2384,7 @@ static void pl011_console_get_options(struct uart_amba_port *uap, int *baud,
>  			*parity = 'o';
>  	}
>  
> -	if ((lcr_h & 0x60) == UART01x_LCRH_WLEN_7)
> -		*bits = 7;
> -	else
> -		*bits = 8;
> +	*bits = FIELD_GET(0x60, lcr_h) + 5; /* from 5 to 8 inclusive */

0x60 needs to be replaced with a named define!

-- 
 i.

--8323329-427932746-1698318835=:2173--
