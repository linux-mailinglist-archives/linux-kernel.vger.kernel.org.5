Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0E67917FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbjIDNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjIDNYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:24:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24632C1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 06:24:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B37268AFE; Mon,  4 Sep 2023 15:23:58 +0200 (CEST)
Date:   Mon, 4 Sep 2023 15:23:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: db1000.c:undefined reference to `mmc_detect_change'
Message-ID: <20230904132358.GA4741@lst.de>
References: <202309031319.FjILvr3H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309031319.FjILvr3H-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, looks like the problem is that the mips arch code is still built
without the au1mmc driver.  I think the code just needs to become
conditional, I'll look into it.

On Sun, Sep 03, 2023 at 01:47:19PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   92901222f83d988617aee37680cb29e1a743b5e4
> commit: d4a5c59a955bba96b273ec1a5885bada24c56979 mmc: au1xmmc: force non-modular build and remove symbol_get usage
> date:   4 weeks ago
> config: mips-randconfig-r003-20230903 (https://download.01.org/0day-ci/archive/20230903/202309031319.FjILvr3H-lkp@intel.com/config)
> compiler: mipsel-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230903/202309031319.FjILvr3H-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309031319.FjILvr3H-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    mipsel-linux-ld: arch/mips/alchemy/devboards/db1000.o: in function `db1100_mmc_cd':
> >> db1000.c:(.text+0x1f0): undefined reference to `mmc_detect_change'
>    mipsel-linux-ld: arch/mips/alchemy/devboards/db1200.o: in function `pb1200_mmc1_cdfn':
> >> db1200.c:(.text+0x3b0): undefined reference to `mmc_detect_change'
>    mipsel-linux-ld: arch/mips/alchemy/devboards/db1200.o: in function `db1200_mmc_cdfn':
>    db1200.c:(.text+0x428): undefined reference to `mmc_detect_change'
>    mipsel-linux-ld: arch/mips/alchemy/devboards/db1300.o: in function `db1300_mmc_cdfn':
> >> db1300.c:(.text+0x240): undefined reference to `mmc_detect_change'
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
---end quoted text---
