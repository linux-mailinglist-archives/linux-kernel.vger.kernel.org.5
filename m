Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5F37E1013
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjKDPTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKDPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:19:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2F81BF;
        Sat,  4 Nov 2023 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699111183; x=1730647183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9kTJouWlfB3X4L8wqzWu8FVlY2ZnZtX7+kHFsCc/oSY=;
  b=Jk3fi7P9L1Ibkdjl9IBzOdp6vRhFv46pqayP6suRNR/muxtu+CdmPGqw
   SqjPXOotUtNmrB79JzMxZ80JuLZSsT8SjokTDnzjmFL7xpGCof9mvwCMD
   kKYj0r77gJ0f09a+r04+sSTBQce7u1HoGpp274GR8w0/l//pvdTCmY//e
   LW7uvABnzX/Of0FfEaoAoeWVs9m4flnOhmp0xj33OF8atvf6mre6RQplo
   glup4lQ+7HdlF4nk04U75gkMMIwlfvalh/E3PxpdvByQzbkPY+znPS01Q
   bWXHWgP1CD+e0I53TeYrDPPZKQop6I01OguBYDFss955A5ef7pN2/TXuD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="453391113"
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="453391113"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 08:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="9668703"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Nov 2023 08:19:39 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzIQy-0004VY-2H;
        Sat, 04 Nov 2023 15:19:36 +0000
Date:   Sat, 4 Nov 2023 23:18:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH net 4/4] net: ethernet: cortina: Handle large frames
Message-ID: <202311042310.Kl043sv2-lkp@intel.com>
References: <20231104-gemini-largeframe-fix-v1-4-9c5513f22f33@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-gemini-largeframe-fix-v1-4-9c5513f22f33@linaro.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 90b0c2b2edd1adff742c621e246562fbefa11b70]

url:    https://github.com/intel-lab-lkp/linux/commits/Linus-Walleij/net-ethernet-cortina-Fix-MTU-max-setting/20231104-204432
base:   90b0c2b2edd1adff742c621e246562fbefa11b70
patch link:    https://lore.kernel.org/r/20231104-gemini-largeframe-fix-v1-4-9c5513f22f33%40linaro.org
patch subject: [PATCH net 4/4] net: ethernet: cortina: Handle large frames
config: arc-randconfig-001-20231104 (https://download.01.org/0day-ci/archive/20231104/202311042310.Kl043sv2-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311042310.Kl043sv2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311042310.Kl043sv2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/cortina/gemini.c: In function 'gmac_map_tx_bufs':
>> drivers/net/ethernet/cortina/gemini.c:1148:13: warning: unused variable 'ret' [-Wunused-variable]
    1148 |         int ret;
         |             ^~~


vim +/ret +1148 drivers/net/ethernet/cortina/gemini.c

  1132	
  1133	static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
  1134				    struct gmac_txq *txq, unsigned short *desc)
  1135	{
  1136		struct gemini_ethernet_port *port = netdev_priv(netdev);
  1137		struct skb_shared_info *skb_si =  skb_shinfo(skb);
  1138		unsigned short m = (1 << port->txq_order) - 1;
  1139		short frag, last_frag = skb_si->nr_frags - 1;
  1140		struct gemini_ethernet *geth = port->geth;
  1141		unsigned int word1, word3, buflen;
  1142		unsigned short w = *desc;
  1143		struct gmac_txdesc *txd;
  1144		skb_frag_t *skb_frag;
  1145		dma_addr_t mapping;
  1146		unsigned short mtu;
  1147		void *buffer;
> 1148		int ret;
  1149	
  1150		mtu  = ETH_HLEN;
  1151		mtu += netdev->mtu;
  1152		if (skb->protocol == htons(ETH_P_8021Q))
  1153			mtu += VLAN_HLEN;
  1154	
  1155		if (mtu > MTU_SIZE_BIT_MASK) {
  1156			netdev_err(netdev, "%s: MTU too big, max size 2047 bytes, capped\n", __func__);
  1157			mtu = MTU_SIZE_BIT_MASK;
  1158		}
  1159	
  1160		if (skb->len > 65535) {
  1161			/* The field for length is only 16 bits */
  1162			netdev_err(netdev, "%s: frame too big, max size 65535 bytes\n", __func__);
  1163			return -EINVAL;
  1164		}
  1165	
  1166		word1 = skb->len;
  1167		word3 = SOF_BIT;
  1168	
  1169		if (word1 > mtu) {
  1170			word1 |= TSS_MTU_ENABLE_BIT;
  1171			word3 |= mtu;
  1172		}
  1173	
  1174		if (skb->len >= ETH_FRAME_LEN) {
  1175			/* Hardware offloaded checksumming isn't working on frames
  1176			 * bigger than 1514 bytes. Perhaps the buffer is only 1518
  1177			 * bytes fitting mach a normal frame and a checksum?
  1178			 * Just bypass on bigger frames.
  1179			 */
  1180			word1 |= TSS_BYPASS_BIT;
  1181		} else if (skb->ip_summed != CHECKSUM_NONE) {
  1182			int tcp = 0;
  1183	
  1184			if (skb->protocol == htons(ETH_P_IP)) {
  1185				word1 |= TSS_IP_CHKSUM_BIT;
  1186				tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
  1187			} else { /* IPv6 */
  1188				word1 |= TSS_IPV6_ENABLE_BIT;
  1189				tcp = ipv6_hdr(skb)->nexthdr == IPPROTO_TCP;
  1190			}
  1191	
  1192			word1 |= tcp ? TSS_TCP_CHKSUM_BIT : TSS_UDP_CHKSUM_BIT;
  1193		}
  1194	
  1195		frag = -1;
  1196		while (frag <= last_frag) {
  1197			if (frag == -1) {
  1198				buffer = skb->data;
  1199				buflen = skb_headlen(skb);
  1200			} else {
  1201				skb_frag = skb_si->frags + frag;
  1202				buffer = skb_frag_address(skb_frag);
  1203				buflen = skb_frag_size(skb_frag);
  1204			}
  1205	
  1206			if (frag == last_frag) {
  1207				word3 |= EOF_BIT;
  1208				txq->skb[w] = skb;
  1209			}
  1210	
  1211			mapping = dma_map_single(geth->dev, buffer, buflen,
  1212						 DMA_TO_DEVICE);
  1213			if (dma_mapping_error(geth->dev, mapping))
  1214				goto map_error;
  1215	
  1216			txd = txq->ring + w;
  1217			txd->word0.bits32 = buflen;
  1218			txd->word1.bits32 = word1;
  1219			txd->word2.buf_adr = mapping;
  1220			txd->word3.bits32 = word3;
  1221	
  1222			word3 &= MTU_SIZE_BIT_MASK;
  1223			w++;
  1224			w &= m;
  1225			frag++;
  1226		}
  1227	
  1228		*desc = w;
  1229		return 0;
  1230	
  1231	map_error:
  1232		while (w != *desc) {
  1233			w--;
  1234			w &= m;
  1235	
  1236			dma_unmap_page(geth->dev, txq->ring[w].word2.buf_adr,
  1237				       txq->ring[w].word0.bits.buffer_size,
  1238				       DMA_TO_DEVICE);
  1239		}
  1240		return -ENOMEM;
  1241	}
  1242	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
