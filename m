Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57927DDA7C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376981AbjKABEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345068AbjKABEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:04:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE410C9;
        Tue, 31 Oct 2023 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698800685; x=1730336685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kmVtTe8yZZhwGEv3fwHYpE27eB8B9HkShe2k3vvydso=;
  b=KTzxf1StetAWnbJmgzfDdOv2w+eoJJNhPKlHYxBtvMWvhOKGvKbfJL52
   8ZTzJaL5HuNh13bmibyVMdDBVwD39WaU/8UiiU4iZSEIS2M9zBBLles0i
   aCdUSWuanOlTWIRiLQX1gJa8c8fQo0PRivedmAAFhD0J00yYTXACzII21
   aJSsOJfG8HF/cJ1ENHL7ZoVH4AUd4+C5h5FdfKkUFDM/NVRvhMKbeX9SB
   uLy5AhLHN9PS/ZmsoKvumySz9CYva665sbMQDw9fESYuc67kRH6Z92eY/
   WazVTDBgJiPYpLvgmgT2Vqbz4GP0pOuM2/TP1A37zJnx+kMXNpqJSVC3C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="368614301"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="368614301"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 18:03:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760790591"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="760790591"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 Oct 2023 18:03:54 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxzeB-0000Uy-2R;
        Wed, 01 Nov 2023 01:03:51 +0000
Date:   Wed, 1 Nov 2023 09:03:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ronald Wahl <rwahl@gmx.de>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ronald Wahl <ronald.wahl@raritan.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250: 8250_omap: Do not start RX DMA on THRI
 interrupt
Message-ID: <202311010816.kXNniDbT-lkp@intel.com>
References: <20231031110950.11714-1-rwahl@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031110950.11714-1-rwahl@gmx.de>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ronald,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.6 next-20231031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ronald-Wahl/serial-8250-8250_omap-Do-not-start-RX-DMA-on-THRI-interrupt/20231031-191258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20231031110950.11714-1-rwahl%40gmx.de
patch subject: [PATCH v3] serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20231101/202311010816.kXNniDbT-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231101/202311010816.kXNniDbT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311010816.kXNniDbT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_omap.c: In function 'omap_8250_dma_handle_irq':
>> drivers/tty/serial/8250/8250_omap.c:1301:12: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
    1301 |         if ((iir & 0x3f) != UART_IIR_THRI)
         |            ^


vim +/else +1301 drivers/tty/serial/8250/8250_omap.c

  1279	
  1280	/*
  1281	 * This is mostly serial8250_handle_irq(). We have a slightly different DMA
  1282	 * hoook for RX/TX and need different logic for them in the ISR. Therefore we
  1283	 * use the default routine in the non-DMA case and this one for with DMA.
  1284	 */
  1285	static int omap_8250_dma_handle_irq(struct uart_port *port)
  1286	{
  1287		struct uart_8250_port *up = up_to_u8250p(port);
  1288		struct omap8250_priv *priv = up->port.private_data;
  1289		u16 status;
  1290		u8 iir;
  1291	
  1292		iir = serial_port_in(port, UART_IIR);
  1293		if (iir & UART_IIR_NO_INT) {
  1294			return IRQ_HANDLED;
  1295		}
  1296	
  1297		uart_port_lock(port);
  1298	
  1299		status = serial_port_in(port, UART_LSR);
  1300	
> 1301		if ((iir & 0x3f) != UART_IIR_THRI)
  1302			if (priv->habit & UART_HAS_EFR2)
  1303				am654_8250_handle_rx_dma(up, iir, status);
  1304			else
  1305				status = omap_8250_handle_rx_dma(up, iir, status);
  1306	
  1307		serial8250_modem_status(up);
  1308		if (status & UART_LSR_THRE && up->dma->tx_err) {
  1309			if (uart_tx_stopped(&up->port) ||
  1310			    uart_circ_empty(&up->port.state->xmit)) {
  1311				up->dma->tx_err = 0;
  1312				serial8250_tx_chars(up);
  1313			} else  {
  1314				/*
  1315				 * try again due to an earlier failer which
  1316				 * might have been resolved by now.
  1317				 */
  1318				if (omap_8250_tx_dma(up))
  1319					serial8250_tx_chars(up);
  1320			}
  1321		}
  1322	
  1323		uart_unlock_and_check_sysrq(port);
  1324	
  1325		return 1;
  1326	}
  1327	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
