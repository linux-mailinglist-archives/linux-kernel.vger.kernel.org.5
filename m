Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4FC7D2E27
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjJWJZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjJWJZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:25:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903AB10CC;
        Mon, 23 Oct 2023 02:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698053123; x=1729589123;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BPcJleJXfgS4giacNwHEY9onpzFBQYYKxKALjBr+ncI=;
  b=Hg/KNbQPAjcqU8Pd8EI5MospZQT0RTuK7pX7oGYbhOVhBEUOR7PE6pze
   UB0dR1Ya1/CBcUsLSiVJCHrRZC/WCMgrf0LX5+UGTu+tps4oXGu2YCu+g
   Qzi2zJ3XMrG0FNDOn+LKOpdmv0ELkVhf762P2k9gGk/wJu6oa/1mJO2RQ
   tF8GqlDzPfVBRZrdVO79xXMVdZKnxE4Lb9VGzx+nz4yhjUwnrkDNTtR5N
   J6WlmS4OGQ0BNB1Z07EV/Tuh/MUbsxQrn2ww+8l23YWYecwgpWxUekAn8
   UVjsVGMJlOT6O69+fmw1cwF0KNNahKeN7Sa4KlrJhVTUOqiV6+Vze7tN0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="390690036"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="390690036"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:25:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="751573917"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="751573917"
Received: from foliveix-mobl5.amr.corp.intel.com ([10.251.211.194])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:25:20 -0700
Date:   Mon, 23 Oct 2023 12:25:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] tty: serial: 8250: Add support for MOXA PCIe
 boards to switch interface between RS422/RS485
In-Reply-To: <20231018091739.10125-7-crescentcy.hsieh@moxa.com>
Message-ID: <f49feb43-e255-43bb-4271-8a13db2859fc@linux.intel.com>
References: <20231018091739.10125-1-crescentcy.hsieh@moxa.com> <20231018091739.10125-7-crescentcy.hsieh@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023, Crescent CY Hsieh wrote:

> MOXA PCIe boards have 4 serial interfaces and don't require additional
> stuff to switch between interfaces:
> 
> - RS232
> - RS422
> - RS485_2W (half-duplex)
> - RS485_4W (full-duplex)
> 
> By using ioctl command "TIOCRS485", it can switch between default
> interface and RS485 if supported.
> 
> That means, for RS422/RS485 board, it can switch between RS422 and
> RS485 by setting the flags within struct serial_rs485.
> 
> However, for the RS232/RS422/RS485 board, it can only switch between
> RS232 and RS485, there's no flag for switching interface into RS422.
> 
> This patch uses "SER_RS485_TERMINATE_BUS" to represent RS422 as a
> workaround solution:
> 
> - RS232                   = (no flags are set)
> - RS422                   = SER_RS485_ENABLED | SER_RS485_TERMINATE_BUS
> - RS485_2W (half-duplex)  = SER_RS485_ENABLED
> - RS485_4W (full-duplex)  = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 58 ++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 29a28e72b..098ac466b 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1974,6 +1974,10 @@ pci_sunix_setup(struct serial_private *priv,
>  #define MOXA_RS485_2W	0x0F
>  #define MOXA_UIR_OFFSET	0x04
>  
> +static const struct serial_rs485 pci_moxa_rs485_supported = {
> +	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,

As recently discussed on linux-serial list, one of the RTS flags should be
enabled (the one the HW uses even if it's not configurable).

> +};
> +
>  static bool pci_moxa_is_mini_pcie(unsigned short device)
>  {
>  	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
> @@ -2024,6 +2028,46 @@ static int pci_moxa_set_interface(const struct pci_dev *dev,
>  	return 0;
>  }
>  
> +/*
> + * MOXA PCIe boards support switching the serial interface using the ioctl
> + * command "TIOCSRS485", but there is currently no dedicated flag for switching
> + * to RS422. As a workaround, we utilize the "SER_RS485_TERMINATE_BUS" flag to
> + * represent RS422.
> + *
> + *	RS232			= (no flags are set)
> + *	RS422			= SER_RS485_ENABLED | SER_RS485_TERMINATE_BUS
> + *	RS485_2W (half-duplex)	= SER_RS485_ENABLED
> + *	RS485_4W (full-duplex)	= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
> + */
> +static int pci_moxa_rs485_config(struct uart_port *port,
> +				 struct ktermios *termios,
> +				 struct serial_rs485 *rs485)
> +{
> +	struct pci_dev *dev = to_pci_dev(port->dev);
> +	unsigned short device = dev->device;
> +	u8 mode = MOXA_RS232;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		if (rs485->flags & SER_RS485_TERMINATE_BUS) {
> +			mode = MOXA_RS422;
> +		} else {
> +			if (rs485->flags & SER_RS485_RX_DURING_TX)
> +				mode = MOXA_RS485_4W;
> +			else
> +				mode = MOXA_RS485_2W;
> +		}
> +	} else {
> +		/*
> +		 * RS232 is not supported for MOXA PCIe boards with device IDs
> +		 * matching the pattern 0x*3**.
> +		 */
> +		if (pci_moxa_match_second_digit(device, 0x0300))
> +			return -EOPNOTSUPP;

This is not the correct error code I think. Maybe return -ENXIO instead.

> +	}
> +
> +	return pci_moxa_set_interface(dev, port->port_id, mode);
> +}
> +
>  static int pci_moxa_init(struct pci_dev *dev)
>  {
>  	unsigned short device = dev->device;
> @@ -2063,9 +2107,23 @@ pci_moxa_setup(struct serial_private *priv,
>  		const struct pciserial_board *board,
>  		struct uart_8250_port *port, int idx)
>  {
> +	struct pci_dev *dev = priv->dev;
> +	unsigned short device = dev->device;
>  	unsigned int bar = FL_GET_BASE(board->flags);
>  	int offset;
>  
> +	/*
> +	 * For the device IDs of MOXA PCIe boards match the pattern 0x*1** and 0x*3**,
> +	 * these boards support switching interface between RS422/RS485 using TIOCSRS485.
> +	 */
> +	if (pci_moxa_match_second_digit(device, 0x0100) ||
> +	    pci_moxa_match_second_digit(device, 0x0300)) {

As mentioned in the other patch, all these literals must be named.

> +		port->port.rs485_config = pci_moxa_rs485_config;
> +		port->port.rs485_supported = pci_moxa_rs485_supported;
> +
> +		if (pci_moxa_match_second_digit(device, 0x0300))
> +			port->port.rs485.flags |= SER_RS485_ENABLED | SER_RS485_TERMINATE_BUS;
> +	}
>  	if (board->num_ports == 4 && idx == 3)
>  		offset = 7 * board->uart_offset;
>  	else
> 

-- 
 i.

