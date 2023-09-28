Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1392A7B2500
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjI1SNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjI1SNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:13:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2F019E;
        Thu, 28 Sep 2023 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695924812; x=1727460812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oWG7lOLK2ncHmaeq7gB1uceRdN0w6sIbgk+5a3Wz1lk=;
  b=KRb4v11da51cbBB1CPfUkNTmo2fFJkA3o86jYJ9Q9c/tbpHdMztlsOs+
   Bd/Rvwm2wHwB1TtiYkvm7cjrxulLuOhPxrDw9FRZevoGpDHqxw4ff8XLw
   w5Dv0ZGzsyaz8E9JyanljZyDvNG3xfbcO6DaUMqHADK3405PZWE1HVuqd
   8jiMGsuRWK7QCY64KNu6W31Fjeei8B98nqUCtm8hQcTJzdKxfTNc6fd28
   fZbFANBj8Ii9LBVl09nrSbii8NjsMTWqw+tZtncZys/19RZ8eJ4O6HRty
   D3hjF9aR03cEiNXQ/LJu/MvXFsIhnxVHP6+hzJLa2Xstk0PCb2kZsXQuD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="362378478"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="362378478"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="753094219"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="753094219"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 28 Sep 2023 11:12:20 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlvUo-0001n3-0x;
        Thu, 28 Sep 2023 18:12:18 +0000
Date:   Fri, 29 Sep 2023 02:11:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: Drop pm_runtime_irq_safe()
Message-ID: <202309290255.uEGVqQAE-lkp@intel.com>
References: <20230928080358.2693-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928080358.2693-1-tony@atomide.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.6-rc3 next-20230928]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Lindgren/serial-8250_omap-Drop-pm_runtime_irq_safe/20230928-160501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230928080358.2693-1-tony%40atomide.com
patch subject: [PATCH] serial: 8250_omap: Drop pm_runtime_irq_safe()
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20230929/202309290255.uEGVqQAE-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290255.uEGVqQAE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290255.uEGVqQAE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_omap.c: In function 'omap8250_irq':
>> drivers/tty/serial/8250/8250_omap.c:688:1: warning: label 'out_runtime_put' defined but not used [-Wunused-label]
     688 | out_runtime_put:
         | ^~~~~~~~~~~~~~~


vim +/out_runtime_put +688 drivers/tty/serial/8250/8250_omap.c

   651	
   652		lsr = serial_port_in(port, UART_LSR);
   653		iir = serial_port_in(port, UART_IIR);
   654		ret = serial8250_handle_irq(port, iir);
   655	
   656		/*
   657		 * On K3 SoCs, it is observed that RX TIMEOUT is signalled after
   658		 * FIFO has been drained, in which case a dummy read of RX FIFO
   659		 * is required to clear RX TIMEOUT condition.
   660		 */
   661		if (priv->habit & UART_RX_TIMEOUT_QUIRK &&
   662		    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
   663		    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
   664			serial_port_in(port, UART_RX);
   665		}
   666	
   667		/* Stop processing interrupts on input overrun */
   668		if ((lsr & UART_LSR_OE) && up->overrun_backoff_time_ms > 0) {
   669			unsigned long delay;
   670	
   671			/* Synchronize UART_IER access against the console. */
   672			uart_port_lock(port);
   673			up->ier = port->serial_in(port, UART_IER);
   674			if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
   675				port->ops->stop_rx(port);
   676			} else {
   677				/* Keep restarting the timer until
   678				 * the input overrun subsides.
   679				 */
   680				cancel_delayed_work(&up->overrun_backoff);
   681			}
   682			uart_port_unlock(port);
   683	
   684			delay = msecs_to_jiffies(up->overrun_backoff_time_ms);
   685			schedule_delayed_work(&up->overrun_backoff, delay);
   686		}
   687	
 > 688	out_runtime_put:
   689		pm_runtime_mark_last_busy(port->dev);
   690		pm_runtime_put(port->dev);
   691	
   692		return IRQ_RETVAL(ret);
   693	}
   694	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
