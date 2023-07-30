Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C095E7687D1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjG3UPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjG3UPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:15:50 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B55184;
        Sun, 30 Jul 2023 13:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690748148; x=1722284148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oqi/5hV9zFCtVGyV0q21JNckf57HO2PFnTjvDdxWCzA=;
  b=bBJZaBcoOqUfI59oKEaKP/BP2MR/tNS5nHzrEkFi7gWxiA8N32sM4Fyq
   OFP5/agQaF4aVwLTrW3vgAzRuwTzd8HKdFulBdwg9PURnE/2pEn8nI0B9
   sCRNjmc7572iWaJt2b++EhFtea/yCSOcS7WLZuMsePg/SmWtHgNpsRxoW
   W+VmCyKUQxuHsD7+surnMacPVev9iO08aZRSPJ3FUcFkdxemxLDhWqY7i
   5iR8iXXCK4dED2/+Bd3EGSr29XtzJc2bcq8MkFJn2TCw5/UcmyLLLuW13
   y9APVqx1J5TmHUMVTncB145JuzhATJ3IGWUSL7icvvFT4PDkqilS+JFZa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="367764439"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="367764439"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 13:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="728072372"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="728072372"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Jul 2023 13:15:45 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQCpM-0004lL-1h;
        Sun, 30 Jul 2023 20:15:44 +0000
Date:   Mon, 31 Jul 2023 04:14:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] power: max17040: get thermal data from adc if
 available
Message-ID: <202307310455.Om3VuGqo-lkp@intel.com>
References: <20230730172648.71578-4-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730172648.71578-4-clamor95@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Svyatoslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on krzk-dt/for-next]
[also build test ERROR on linus/master v6.5-rc3 next-20230728]
[cannot apply to sre-power-supply/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-power-supply-maxim-max17040-update-properties/20230731-012920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git for-next
patch link:    https://lore.kernel.org/r/20230730172648.71578-4-clamor95%40gmail.com
patch subject: [PATCH v2 3/3] power: max17040: get thermal data from adc if available
config: i386-randconfig-i013-20230731 (https://download.01.org/0day-ci/archive/20230731/202307310455.Om3VuGqo-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230731/202307310455.Om3VuGqo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307310455.Om3VuGqo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: devm_iio_channel_get
   >>> referenced by max17040_battery.c:483 (drivers/power/supply/max17040_battery.c:483)
   >>>               drivers/power/supply/max17040_battery.o:(max17040_probe) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: iio_read_channel_processed_scale
   >>> referenced by max17040_battery.c:413 (drivers/power/supply/max17040_battery.c:413)
   >>>               drivers/power/supply/max17040_battery.o:(max17040_get_property) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
