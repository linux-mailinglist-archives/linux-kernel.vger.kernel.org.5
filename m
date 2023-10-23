Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094957D431B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjJWXKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWXKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:10:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C0C0;
        Mon, 23 Oct 2023 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698102629; x=1729638629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XK5pkAOuUAUIv7kLf8nY8tzcC1YIWf+l3Z9h22jOQ0g=;
  b=Xo2ZCHrVm2EB4bsOwGnEw+Pr1aNz/83cIi6xV2JxSOiW73/zfG1PRY0N
   thYjUgSTs+DmXzw1GeKVPbfrhqIyDZ69czZ1hzEBcn4twDmCUz6UrTv7f
   m1OfsVyoabuaVt4HjrrhSIWW/e3bRMV9wNbXnnqkz+6c8JjU21LKYBVjW
   j8siSnclYa1kY+FCMNC5Hzi6emhnWZRb4YSNBeba2vElfkMsZ+81fXHVZ
   VHx1AowoaIdusF8GSbqhIbUH/vgFiUyWyNfrBaXFtWbGE+G8gBkosMEnr
   dV+5iiG2OmdeUjyYkXeVYDemKU/62+NqpyGIiNozIOjmn2VOSETqQT18H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385841775"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="385841775"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:10:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="881924055"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="881924055"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2023 16:10:23 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qv43x-0007MK-0v;
        Mon, 23 Oct 2023 23:10:21 +0000
Date:   Tue, 24 Oct 2023 07:09:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        andrew@lunn.ch
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, horatiu.vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: Re: [PATCH net-next v2 1/9] net: ethernet: implement OPEN Alliance
 control transaction interface
Message-ID: <202310240609.nPpYbL1B-lkp@intel.com>
References: <20231023154649.45931-2-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023154649.45931-2-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parthiban,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Parthiban-Veerasooran/net-ethernet-implement-OPEN-Alliance-control-transaction-interface/20231023-235310
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231023154649.45931-2-Parthiban.Veerasooran%40microchip.com
patch subject: [PATCH net-next v2 1/9] net: ethernet: implement OPEN Alliance control transaction interface
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231024/202310240609.nPpYbL1B-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310240609.nPpYbL1B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310240609.nPpYbL1B-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/oa_tc6.c:250: warning: Function parameter or member 'len' not described in 'oa_tc6_read_registers'


vim +250 drivers/net/ethernet/oa_tc6.c

   238	
   239	/**
   240	 * oa_tc6_read_registers - function for reading multiple consecutive registers.
   241	 * @tc6: oa_tc6 struct.
   242	 * @addr: address of the first register to be read in the MACPHY.
   243	 * @val: values to be read from the starting register address @addr.
   244	 *
   245	 * Maximum of 128 consecutive registers can be read starting at @addr.
   246	 *
   247	 * Returns 0 on success otherwise failed.
   248	 */
   249	int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len)
 > 250	{
   251		return oa_tc6_perform_ctrl(tc6, addr, val, len, false, tc6->prote);
   252	}
   253	EXPORT_SYMBOL_GPL(oa_tc6_read_registers);
   254	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
