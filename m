Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8FB7DA7CF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjJ1Pbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjJ1Pbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:31:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E7FD3;
        Sat, 28 Oct 2023 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698507091; x=1730043091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lXhBg7CyUNDTmqFAHnbpKEyoQJs4rn3WPxNcO3/MONs=;
  b=UQ5ewBDMQ9+S0B9EYLLj3KEoWBs6Hv/kwnz2b4KliUwX4zI6JRmW751q
   alpjHaxxTvZtpSwLcaJUZorL8C+XsQHqvD+FVuw9BanQfkY/entWUaMRT
   cIv676P4n2KKTJ4rh3CDfzNDkr2untMrSN2z4msKixo0IsRiX4mziaiZc
   YlYnLrUZIcfCs+VxeLecI0kHM1Vaudz9czFg19qaW3i1SEK3oIzoKSJZb
   rswqlG0TV7DW2PGsZRqE98ueuEoEtbeLP1q0Wh0eFkLe3coOPgjI5JVum
   V4NNwqN1aH/OeATspkwxLS5glfoZwxsVFFyIKJu9x3SE8o4HDGIxULoWE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="387717868"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="387717868"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 08:31:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="1120418"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Oct 2023 08:31:15 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwlHY-000Br5-3D;
        Sat, 28 Oct 2023 15:31:25 +0000
Date:   Sat, 28 Oct 2023 23:30:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xingxing Luo <xingxing.luo@unisoc.com>, b-liu@ti.com,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, xingxing0070.luo@gmail.com,
        Zhiyong.Liu@unisoc.com, Cixi.Geng1@unisoc.com,
        Orson.Zhai@unisoc.com, zhang.lyra@gmail.com
Subject: Re: [PATCH] usb: musb: Check requset->buf before use to avoid crash
 issue
Message-ID: <202310282331.d4wx1Z6b-lkp@intel.com>
References: <20231023093153.6748-1-xingxing.luo@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023093153.6748-1-xingxing.luo@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xingxing,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.6-rc7 next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xingxing-Luo/usb-musb-Check-requset-buf-before-use-to-avoid-crash-issue/20231023-173938
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231023093153.6748-1-xingxing.luo%40unisoc.com
patch subject: [PATCH] usb: musb: Check requset->buf before use to avoid crash issue
config: arm-davinci_all_defconfig (https://download.01.org/0day-ci/archive/20231028/202310282331.d4wx1Z6b-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310282331.d4wx1Z6b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310282331.d4wx1Z6b-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/musb/musb_gadget_ep0.c:534:7: error: use of undeclared identifier 'requset'; did you mean 'request'?
     534 |         if (!requset->buf) {
         |              ^~~~~~~
         |              request
   drivers/usb/musb/musb_gadget_ep0.c:521:22: note: 'request' declared here
     521 |         struct usb_request      *request;
         |                                  ^
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PINCTRL_SINGLE
   Depends on [n]: PINCTRL [=n] && OF [=y] && HAS_IOMEM [=y]
   Selected by [y]:
   - ARCH_DAVINCI [=y] && ARCH_MULTI_V5 [=y] && CPU_LITTLE_ENDIAN [=y]


vim +534 drivers/usb/musb/musb_gadget_ep0.c

   510	
   511	/*
   512	 * transmitting to the host (IN), this code might be called from IRQ
   513	 * and from kernel thread.
   514	 *
   515	 * Context:  caller holds controller lock
   516	 */
   517	static void ep0_txstate(struct musb *musb)
   518	{
   519		void __iomem		*regs = musb->control_ep->regs;
   520		struct musb_request	*req = next_ep0_request(musb);
   521		struct usb_request	*request;
   522		u16			csr = MUSB_CSR0_TXPKTRDY;
   523		u8			*fifo_src;
   524		u8			fifo_count;
   525	
   526		if (!req) {
   527			/* WARN_ON(1); */
   528			musb_dbg(musb, "odd; csr0 %04x", musb_readw(regs, MUSB_CSR0));
   529			return;
   530		}
   531	
   532		request = &req->request;
   533	
 > 534		if (!requset->buf) {
   535			musb_dbg(musb, "request->buf is NULL");
   536			return;
   537		}
   538	
   539		/* load the data */
   540		fifo_src = (u8 *) request->buf + request->actual;
   541		fifo_count = min((unsigned) MUSB_EP0_FIFOSIZE,
   542			request->length - request->actual);
   543		musb_write_fifo(&musb->endpoints[0], fifo_count, fifo_src);
   544		request->actual += fifo_count;
   545	
   546		/* update the flags */
   547		if (fifo_count < MUSB_MAX_END0_PACKET
   548				|| (request->actual == request->length
   549					&& !request->zero)) {
   550			musb->ep0_state = MUSB_EP0_STAGE_STATUSOUT;
   551			csr |= MUSB_CSR0_P_DATAEND;
   552		} else
   553			request = NULL;
   554	
   555		/* report completions as soon as the fifo's loaded; there's no
   556		 * win in waiting till this last packet gets acked.  (other than
   557		 * very precise fault reporting, needed by USB TMC; possible with
   558		 * this hardware, but not usable from portable gadget drivers.)
   559		 */
   560		if (request) {
   561			musb->ackpend = csr;
   562			musb_g_ep0_giveback(musb, request);
   563			if (!musb->ackpend)
   564				return;
   565			musb->ackpend = 0;
   566		}
   567	
   568		/* send it out, triggering a "txpktrdy cleared" irq */
   569		musb_ep_select(musb->mregs, 0);
   570		musb_writew(regs, MUSB_CSR0, csr);
   571	}
   572	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
