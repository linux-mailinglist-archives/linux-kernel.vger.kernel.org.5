Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC497F0FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjKTKCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTKCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:02:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271358F;
        Mon, 20 Nov 2023 02:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700474519; x=1732010519;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zKggXAZlS8YgibFlT38P+9qlRp4mLDSsXnLg/K6JlEY=;
  b=X/EgsJmFh1RSoh3FMXp0VuOK59pGQ1nxvRdfr/Tc11kIYcyMwcD56tVa
   qyrD2aAla4vhpSu6+lQ4b646++TewdK/sCcN33P9Ek2dx5ovVqRvBtaEr
   auRm1FcLFyu6ST0EcILD91F25YgGTo7hdIHrFxfju4Ok6XHRI2pi+ReyI
   BWlZLrtc8nmGZtFqEqWtBrXMqjZXNNndqa+cSJEM3Uau59MtOLDYbOq2j
   EAzzSYWIr1MKlhmqspIS1WkIVlpfONGXzStX3ziCfTtBECo9HQUBs/wS6
   PDLEI3isuGCFJ4gZx7I5PtYtQiwDwFdGWJdlsShg8grc8Lhz+N6tG5864
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="455914400"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="455914400"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:55:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769841610"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769841610"
Received: from akeren-mobl.ger.corp.intel.com ([10.252.40.26])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:55:23 -0800
Date:   Mon, 20 Nov 2023 11:55:21 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>
cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?ISO-8859-15?Q?Gr=E9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v3 6/6] tty: serial: amba-pl011: factor QDF2400 SoC
 erratum 44 out of probe
In-Reply-To: <20231120-mbly-uart-v3-6-07ae35979f1f@bootlin.com>
Message-ID: <5c10e247-3fe-7455-a13-fde4c3cb0b4@linux.intel.com>
References: <20231120-mbly-uart-v3-0-07ae35979f1f@bootlin.com> <20231120-mbly-uart-v3-6-07ae35979f1f@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-557729899-1700474126=:2032"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-557729899-1700474126=:2032
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 20 Nov 2023, Théo Lebrun wrote:

> On this platform, different vendor data is used. That requires a
> compile-time check as we access (1) a global boolean & (2) our local
> vendor data. Both symbols are accessible only when
> CONFIG_ACPI_SPCR_TABLE is enabled.
> 
> Factor the vendor data overriding to a separate function that is empty
> when CONFIG_ACPI_SPCR_TABLE is not defined.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 4185d6fd243b..e08a32eb0ed1 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2874,6 +2874,22 @@ static int pl011_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume);
>  
> +#ifdef CONFIG_ACPI_SPCR_TABLE
> +static void qpdf2400_erratum44_workaround(struct device *dev,
> +					  struct uart_amba_port *uap)
> +{
> +	if (qdf2400_e44_present)

This should be !qdf2400_e44_present.

-- 
 i.


> +		return;
> +
> +	dev_info(dev, "working around QDF2400 SoC erratum 44\n");
> +	uap->vendor = &vendor_qdt_qdf2400_e44;
> +}
> +#else
> +static void qpdf2400_erratum44_workaround(struct device *dev,
> +					  struct uart_amba_port *uap)
> +{ /* empty */ }
> +#endif
> +
>  static int sbsa_uart_probe(struct platform_device *pdev)
>  {
>  	struct uart_amba_port *uap;
> @@ -2909,13 +2925,8 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>  		return ret;
>  	uap->port.irq	= ret;
>  
> -#ifdef CONFIG_ACPI_SPCR_TABLE
> -	if (qdf2400_e44_present) {
> -		dev_info(&pdev->dev, "working around QDF2400 SoC erratum 44\n");
> -		uap->vendor = &vendor_qdt_qdf2400_e44;
> -	} else
> -#endif
> -		uap->vendor = &vendor_sbsa;
> +	uap->vendor = &vendor_sbsa;
> +	qpdf2400_erratum44_workaround(&pdev->dev, uap);
>  
>  	uap->reg_offset	= uap->vendor->reg_offset;
>  	uap->fifosize	= 32;
> 
> 
--8323329-557729899-1700474126=:2032--
