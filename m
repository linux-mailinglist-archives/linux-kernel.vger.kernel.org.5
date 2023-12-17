Return-Path: <linux-kernel+bounces-2485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3945815DC9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6055E283D6A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39451854;
	Sun, 17 Dec 2023 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7MCZsrB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC8184F;
	Sun, 17 Dec 2023 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702795415; x=1734331415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5JlpsvbWOqFLfck4pPpsmwWV8XlbmxCzw6ZMnROIL8c=;
  b=O7MCZsrBUdbFpKOZn5f3MVLezqplKXtkQfn9l9GlCwrXw/ivQUa+XyxP
   9Vp1emaLhE2AvvwI5PQWNLUBIVXy+Z2fZ+ky7dww6wwlt6ZZnbNlZFXWU
   culzqHo7nU0sngmHiGoDg4ZJUsxYI+zZ0CHbjJOzKFWm31sVKhRLByiv8
   0nNWN2POPZ7Gv3elGWJKNkN+eR5oD0edqN8c+spwlJvDNKpJaiUDNITKB
   TI8junveoeAKH0Q8Ouw4DQUqlKHkIf7lYzK+lzyb/BPeg21uPKSplm2ku
   uLtyYcKb6pkbHwayLvdilNLMHJ8JHDo3hu+gZTuAspTBBS+ZSFh/FOV3N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="8827571"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="8827571"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 22:43:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="948412847"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="948412847"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2023 22:43:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEks5-0002lD-1l;
	Sun, 17 Dec 2023 06:43:29 +0000
Date: Sun, 17 Dec 2023 14:43:02 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: oe-kbuild-all@lists.linux.dev, daniel.thompson@linaro.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	jason.wessel@windriver.com, jirislaby@kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: kgdboc: Fix 8250_* kgd over serial
Message-ID: <202312171453.mT4pH4uH-lkp@intel.com>
References: <20231216173409.1264655-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216173409.1264655-1-michael@amarulasolutions.com>

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Trimarchi/tty-serial-kgdboc-Fix-8250_-kgd-over-serial/20231217-013726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20231216173409.1264655-1-michael%40amarulasolutions.com
patch subject: [PATCH] tty: serial: kgdboc: Fix 8250_* kgd over serial
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231217/202312171453.mT4pH4uH-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312171453.mT4pH4uH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171453.mT4pH4uH-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/serial_core.c: In function 'uart_poll_init':
>> drivers/tty/serial/serial_core.c:2636:33: error: lvalue required as left operand of assignment
    2636 |         if (!port || port->type = PORT_UNKNOWN || !(port->ops->poll_get_char && port->ops->poll_put_char)) {
         |                                 ^


vim +2636 drivers/tty/serial/serial_core.c

  2618	
  2619	static int uart_poll_init(struct tty_driver *driver, int line, char *options)
  2620	{
  2621		struct uart_driver *drv = driver->driver_state;
  2622		struct uart_state *state = drv->state + line;
  2623		enum uart_pm_state pm_state;
  2624		struct tty_port *tport;
  2625		struct uart_port *port;
  2626		int baud = 9600;
  2627		int bits = 8;
  2628		int parity = 'n';
  2629		int flow = 'n';
  2630		int ret = 0;
  2631	
  2632		tport = &state->port;
  2633		mutex_lock(&tport->mutex);
  2634	
  2635		port = uart_port_check(state);
> 2636		if (!port || port->type = PORT_UNKNOWN || !(port->ops->poll_get_char && port->ops->poll_put_char)) {
  2637			ret = -1;
  2638			goto out;
  2639		}
  2640	
  2641		pm_state = state->pm_state;
  2642		uart_change_pm(state, UART_PM_STATE_ON);
  2643	
  2644		if (port->ops->poll_init) {
  2645			/*
  2646			 * We don't set initialized as we only initialized the hw,
  2647			 * e.g. state->xmit is still uninitialized.
  2648			 */
  2649			if (!tty_port_initialized(tport))
  2650				ret = port->ops->poll_init(port);
  2651		}
  2652	
  2653		if (!ret && options) {
  2654			uart_parse_options(options, &baud, &parity, &bits, &flow);
  2655			console_list_lock();
  2656			ret = uart_set_options(port, NULL, baud, parity, bits, flow);
  2657			console_list_unlock();
  2658		}
  2659	out:
  2660		if (ret)
  2661			uart_change_pm(state, pm_state);
  2662		mutex_unlock(&tport->mutex);
  2663		return ret;
  2664	}
  2665	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

