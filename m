Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C378314F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjHUT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjHUT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:29:49 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D46DCC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=580Z0I15XQ014kRTgw5NCRR9DpeFoKg96Ka6fGXGnO0=; b=Js9AA4MZQ5/Va6EBvy0h4fzdJc
        xrmcAfZVtdHtEdxFefdy+dtffmc74atdry6uMG1JKY13UaLvsrUzGlOAS7TlzAZsSjxM/kgHGRk02
        Cm/yp+hOtMlsr097Ns6Itxsj5rUQ+2Te2fC+f7q7MRINVLKDgoKgXvDTTub7ROOEt5cw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qYAam-004iY4-2E; Mon, 21 Aug 2023 21:29:36 +0200
Date:   Mon, 21 Aug 2023 21:29:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ninad Palsule <ninad@linux.ibm.com>
Cc:     joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v1 1/1] soc/aspeed: Add host side BMC device driver
Message-ID: <5159abb8-1b4c-4576-b370-4dd9db142beb@lunn.ch>
References: <20230821183525.3427144-1-ninad@linux.ibm.com>
 <20230821183525.3427144-2-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821183525.3427144-2-ninad@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Testing:
>   - This is tested on IBM rainier system with BMC. It requires BMC side
>     BMC device driver which is available in the ASPEED's 5.15 SDK
>     kernel.

How relevant is that? To the host side, it just appears to be an
16550A. Is the SDK emulating an 16550A? If you where to use a
different kernel, is it still guaranteed to be an 16550A? I also
notice there is a mainline
drivers/tty/serial/8250/8250_aspeed_vuart.c. Could that be used on the
BMC? That would be a better testing target than the vendor kernel.

> +config ASPEED_HOST_BMC_DEV
> +	bool "ASPEED SoC Host BMC device driver"
> +	default ARCH_ASPEED
> +	select SOC_BUS
> +	default ARCH_ASPEED

same default twice?

> +static int __init aspeed_host_bmc_device_init(void)
> +{
> +	int ret;
> +
> +	/* register pci driver */
> +	ret = pci_register_driver(&aspeed_host_bmc_dev_driver);
> +	if (ret < 0) {
> +		pr_err("pci-driver: can't register pci driver\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +}
> +
> +static void aspeed_host_bmc_device_exit(void)
> +{
> +	/* unregister pci driver */
> +	pci_unregister_driver(&aspeed_host_bmc_dev_driver);
> +}
> +
> +late_initcall(aspeed_host_bmc_device_init);
> +module_exit(aspeed_host_bmc_device_exit);

It looks like you can use module_pci_driver() ?
