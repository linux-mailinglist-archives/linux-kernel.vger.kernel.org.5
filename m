Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84978F79B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 06:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345030AbjIAED3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 00:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjIAED2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 00:03:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CB4E4C;
        Thu, 31 Aug 2023 21:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693541005; x=1725077005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R+W9qyDSelNlpR13hEosbhX72kNCmpu5QOTLPT7lfD8=;
  b=mn2WeLvx+ntYsT6F5ewlizr+iwEF7pK8FB9spXbZ9nM4jjl8fsfRUN2m
   AxBJiUuWQ1ZRr6MQHQUkqqV0qFHiHuAIFTKSGJoBESj/7acfQs8q/AMiJ
   YW9UK8MLBDLueaacYWwtFcYnEghDXAAxQ6HmczBMh2UQhYpFvxkCeDKOE
   WjaIyXxjo52XcLMG5maOvv5dG1GfP7cO9q4N3UZaPSAwMjYp1r1yUyOmy
   qPPILmyuG2DuVnE7/tf21rVhYvkenmnUdX/KJGBawjcQX+UJijB2l03cx
   QcwSuomnYgNi3/SKJNrUvE/Lxo95G7Ba8aHw/e8PiZq5xtQb+fvQq+otI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356444025"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="356444025"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 21:03:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986503554"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="986503554"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2023 21:03:21 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbvNP-0000r5-0i;
        Fri, 01 Sep 2023 04:03:19 +0000
Date:   Fri, 1 Sep 2023 12:02:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukasz Majewski <lukma@denx.de>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2 2/4] net: dsa: Extend ksz9477 TAG setup to support HSR
 frames duplication
Message-ID: <202309011123.BsWErQvO-lkp@intel.com>
References: <20230831111827.548118-3-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831111827.548118-3-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.5]
[also build test ERROR on next-20230831]
[cannot apply to net-next/main net/main linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Majewski/net-dsa-Extend-the-ksz_device-structure-to-hold-info-about-HSR-ports/20230831-192012
base:   v6.5
patch link:    https://lore.kernel.org/r/20230831111827.548118-3-lukma%40denx.de
patch subject: [PATCH v2 2/4] net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
config: openrisc-randconfig-r026-20230901 (https://download.01.org/0day-ci/archive/20230901/202309011123.BsWErQvO-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309011123.BsWErQvO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309011123.BsWErQvO-lkp@intel.com/

All errors (new ones prefixed by >>):

   or1k-linux-ld: net/dsa/tag_ksz.o: in function `ksz9477_xmit':
>> net/dsa/tag_ksz.c:298:(.text+0xcf8): undefined reference to `ksz_hsr_get_ports'
   net/dsa/tag_ksz.c:298:(.text+0xcf8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `ksz_hsr_get_ports'


vim +298 net/dsa/tag_ksz.c

   269	
   270	static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
   271					    struct net_device *dev)
   272	{
   273		u16 queue_mapping = skb_get_queue_mapping(skb);
   274		u8 prio = netdev_txq_to_tc(dev, queue_mapping);
   275		struct dsa_port *dp = dsa_slave_to_port(dev);
   276		struct ethhdr *hdr;
   277		__be16 *tag;
   278		u16 val;
   279	
   280		if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
   281			return NULL;
   282	
   283		/* Tag encoding */
   284		ksz_xmit_timestamp(dp, skb);
   285	
   286		tag = skb_put(skb, KSZ9477_INGRESS_TAG_LEN);
   287		hdr = skb_eth_hdr(skb);
   288	
   289		val = BIT(dp->index);
   290	
   291		val |= FIELD_PREP(KSZ9477_TAIL_TAG_PRIO, prio);
   292	
   293		if (is_link_local_ether_addr(hdr->h_dest))
   294			val |= KSZ9477_TAIL_TAG_OVERRIDE;
   295	
   296		if (dev->features & NETIF_F_HW_HSR_DUP) {
   297			val &= ~KSZ9477_TAIL_TAG_LOOKUP;
 > 298			val |= ksz_hsr_get_ports(dp->ds);
   299		}
   300	
   301		*tag = cpu_to_be16(val);
   302	
   303		return ksz_defer_xmit(dp, skb);
   304	}
   305	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
