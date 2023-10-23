Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FC97D2DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjJWJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJWJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:21:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33338F5;
        Mon, 23 Oct 2023 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698052870; x=1729588870;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=p1SAne+x2Vqn1d6KCvK50Z1tyZPw11rQLG9JPCmxBzc=;
  b=hcrlfluXJjwzz25dpO1hf1++djIm+WBKaCWBfTkITLBFwwBOBEACXY9x
   gsRdKAoj3xbbMXDlk4ZAko0kIA6KPy/GUcXBSw4WdfiXIWV0T7W5dAs2K
   kEp6ga8/8NgioM8ODCQ5ba3pO25yOJVnmtm4bDEUA+EsnaFRyUHSItAd+
   wOXMLrLFlGQGsRjhZmRSlRxJj7k+vOqBsBWAHBukoVBYH/oU3vBeIWBMh
   GuqeaNhRZXrXiKA0vO6Sl9V3LG17crEt0wlJLFqKYSyL9CEgEBGf76KtX
   mPvtvSyLJv3J19rxrg5DLouwUOyaOphkOH0AmIxYAWvUVddI6iV3IQXzr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="453270585"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="453270585"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="848737994"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="848737994"
Received: from foliveix-mobl5.amr.corp.intel.com ([10.251.211.194])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:21:07 -0700
Date:   Mon, 23 Oct 2023 12:21:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 5/6] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe
 boards not work by default
In-Reply-To: <20231018091739.10125-6-crescentcy.hsieh@moxa.com>
Message-ID: <f04e4269-0d9-ed2d-cfd1-6a9d462182a5@linux.intel.com>
References: <20231018091739.10125-1-crescentcy.hsieh@moxa.com> <20231018091739.10125-6-crescentcy.hsieh@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023, Crescent CY Hsieh wrote:

> MOXA PCIe RS422/RS485 boards will not function by default because of the
> initial default serial interface of all MOXA PCIe boards is set to RS232.
> 
> This patch fixes the problem above by setting the initial default serial
> interface to RS422 for those MOXA RS422/RS485 PCIe boards.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 52 ++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index b2be3783f..29a28e72b 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1968,6 +1968,12 @@ pci_sunix_setup(struct serial_private *priv,
>  
>  #define MOXA_GPIO_PIN2	BIT(2)
>  
> +#define MOXA_RS232	0x00
> +#define MOXA_RS422	0x01
> +#define MOXA_RS485_4W	0x0B
> +#define MOXA_RS485_2W	0x0F
> +#define MOXA_UIR_OFFSET	0x04
> +
>  static bool pci_moxa_is_mini_pcie(unsigned short device)
>  {
>  	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
> @@ -1981,13 +1987,59 @@ static bool pci_moxa_is_mini_pcie(unsigned short device)
>  	return false;
>  }
>  
> +/*
> + * The second digit of the MOXA PCIe device ID in hexadecimal indicates
> + * which serial interface modes this board supports:
> + *
> + *	0x*0** - RS232
> + *	0x*1** - RS232/RS422/RS485
> + *	0x*3** - RS422/RS485
> + *	0x*6** - RS232
> + */
> +static bool pci_moxa_match_second_digit(unsigned short device,
> +					unsigned short pattern)
> +{
> +	return (device & 0x0F00) == pattern;

Define a named field, not literal.

IMO, the function name is not good because it tells what code does, not 
why it does. I think the name should be based on .

> +}
> +
> +static int pci_moxa_set_interface(const struct pci_dev *dev,
> +				  unsigned int port_idx,
> +				  u8 mode)
> +{
> +	resource_size_t iobar_addr = pci_resource_start(dev, 2);
> +	resource_size_t UIR_addr = iobar_addr + MOXA_UIR_OFFSET + port_idx / 2;
> +	u8 val;
> +
> +	val = inb(UIR_addr);
> +
> +	if (port_idx % 2) {
> +		val &= 0x0F;
> +		val |= mode << 4;
> +	} else {
> +		val &= 0xF0;
> +		val |= mode;

These should use the typical pattern instead:

	val &= ~NAMED_DEFINE;
	val |= FIELD_PREP(NAMED_DEFINE, mode);

Also, don't forget to add bitfield.h if it's not there yet among the 
includes.

-- 
 i.



> +	}
> +	outb(val, UIR_addr);
> +
> +	return 0;
> +}
> +
>  static int pci_moxa_init(struct pci_dev *dev)
>  {
>  	unsigned short device = dev->device;
>  	resource_size_t iobar_addr = pci_resource_start(dev, 2);
> +	unsigned int i;
>  	unsigned int num_ports = (device & 0x00F0) >> 4;

Put declaration of i after num_ports.

>  	u8 val;
>  
> +	/*
> +	 * For the device IDs of MOXA PCIe boards match the pattern 0x*3**,
> +	 * the initial default serial interface mode should be set to RS422.
> +	 */
> +	if (pci_moxa_match_second_digit(device, 0x0300)) {

Name the literal with define, once you have better name for the function 
and no literal, the comment is no longer necessary at all because the code 
will document itself much better!

> +		for (i = 0; i < num_ports; ++i)
> +			pci_moxa_set_interface(dev, i, MOXA_RS422);
> +	}
>  	/*
>  	 * Enable hardware buffer to prevent break signal output when system boots up.
>  	 * This hardware buffer is only supported on Mini PCIe series.
> 
