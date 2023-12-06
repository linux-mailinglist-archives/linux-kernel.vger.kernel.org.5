Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45F28065A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376344AbjLFD27 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 22:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjLFD26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:28:58 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C744CD5F;
        Tue,  5 Dec 2023 19:28:58 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B63SWmuC3311098, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B63SWmuC3311098
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Dec 2023 11:28:32 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 6 Dec 2023 11:28:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 11:28:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 6 Dec 2023 11:28:32 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v13 01/13] rtase: Add pci table supported in this module
Thread-Topic: [PATCH net-next v13 01/13] rtase: Add pci table supported in
 this module
Thread-Index: AQHaI4J1hYqre02tzkGBvHQzDpC7MLCU5PoAgAV9LKA=
Date:   Wed, 6 Dec 2023 03:28:32 +0000
Message-ID: <ae4807e31b53452ebf176098d95cf1fb@realtek.com>
References: <20231130114327.1530225-1-justinlai0215@realtek.com>
        <20231130114327.1530225-2-justinlai0215@realtek.com>
 <20231201203602.7e380716@kernel.org>
In-Reply-To: <20231201203602.7e380716@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 30 Nov 2023 19:43:15 +0800 Justin Lai wrote:
> > +#include <linux/crc32.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/etherdevice.h>
> > +#include <linux/if_vlan.h>
> > +#include <linux/in.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/ip.h>
> > +#include <linux/ipv6.h>
> > +#include <linux/mdio.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> 
> I don't see module params, please trim the includes.

Thanks, I will remove it.

> 
> > +#include <linux/netdevice.h>
> > +#include <linux/pci.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/prefetch.h>
> > +#include <linux/rtnetlink.h>
> > +#include <linux/tcp.h>
> > +#include <asm/irq.h>
> > +#include <net/ip6_checksum.h>
> > +#include <net/page_pool/helpers.h>
> > +#include <net/pkt_cls.h>
> 
> > +static void rtase_get_mac_address(struct net_device *dev) {
> > +     struct rtase_private *tp = netdev_priv(dev);
> > +     u8 mac_addr[ETH_ALEN] __aligned(2) = {};
> > +     u32 i;
> > +
> > +     for (i = 0; i < ETH_ALEN; i++)
> > +             mac_addr[i] = rtase_r8(tp, RTASE_MAC0 + i);
> > +
> > +     if (!is_valid_ether_addr(mac_addr)) {
> > +             eth_random_addr(mac_addr);
> > +             dev->addr_assign_type = NET_ADDR_RANDOM;
> 
> eth_hw_addr_random()

I will use this function instead for this part.

> 
> > +             netdev_warn(dev, "Random ether addr %pM\n",
> mac_addr);
> > +     }
> > +
> > +     eth_hw_addr_set(dev, mac_addr);
> > +     rtase_rar_set(tp, mac_addr);
> > +
> > +     ether_addr_copy(dev->perm_addr, dev->dev_addr);
> 
> Should it be perm if it's random?

No, I will modify this part.

> 
> > +}
> > +
> > +static void rtase_reset_interrupt(struct pci_dev *pdev,
> > +                               const struct rtase_private *tp) {
> > +     if (tp->sw_flag & SWF_MSIX_ENABLED)
> > +             pci_disable_msix(pdev);
> > +     else
> > +             pci_disable_msi(pdev);
> > +}
> > +
> > +static int rtase_alloc_msix(struct pci_dev *pdev, struct
> > +rtase_private *tp) {
> > +     int ret;
> > +     u16 i;
> > +
> > +     memset(tp->msix_entry, 0x0, RTASE_NUM_MSIX * sizeof(struct
> > + msix_entry));
> > +
> > +     for (i = 0; i < RTASE_NUM_MSIX; i++)
> > +             tp->msix_entry[i].entry = i;
> > +
> > +     ret = pci_enable_msix_range(pdev, tp->msix_entry, tp->int_nums,
> > +                                 tp->int_nums);
> 
> pci_enable_msix_exact()

Thanks, I will use this function instead.

> 
> > +     if (ret == tp->int_nums) {
> > +             for (i = 0; i < tp->int_nums; i++) {
> > +                     tp->int_vector[i].irq = pci_irq_vector(pdev, i);
> > +                     tp->int_vector[i].status = 1;
> > +             }
> > +     }
> > +
> > +     return ret;
> > +}
> 
> > +     if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
> > +             dev->features |= NETIF_F_HIGHDMA;
> > +     else if (dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32)))
> > +             goto err_out_free_res;
> > +     else
> > +             dev_info(&pdev->dev, "DMA_BIT_MASK: 32\n");
> 
> This dance is unnecessary, see https://lkml.org/lkml/2021/6/7/398

Thank you for providing this information, I will remove the 32-bit part.

> 
> > +     dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
> > +     if (!dev->tstats)
> > +             goto err_out_1;
> 
> Please use dev->pcpu_stat_type
> Set it before register and core will allocate stats for you.

Thanks for your suggestion, I will allocate stats by setting dev->pcpu_stat_type.

> 
> > +     ret = register_netdev(dev);
> > +     if (ret != 0)
> > +             goto err_out;
> > +
> > +     netdev_dbg(dev, "%pM, IRQ %d\n", dev->dev_addr, dev->irq);
> > +
> > +     netif_carrier_off(dev);
> 
> Should be before register_netdev().
 
Ok, I will do that.

> 
> > +     goto out;
> 
> Just return 0...

I will modify it.

> 
> > +static void rtase_remove_one(struct pci_dev *pdev) {
> > +     struct net_device *dev = pci_get_drvdata(pdev);
> > +     struct rtase_private *tp = netdev_priv(dev);
> > +     struct rtase_int_vector *ivec;
> > +     u32 i;
> > +
> > +     for (i = 0; i < tp->int_nums; i++) {
> > +             ivec = &tp->int_vector[i];
> > +             netif_napi_del(&ivec->napi);
> 
> NAPI instances should be added on ndo_open()

Do you want me to call netif_napi_add() in the .ndo_open function, and netif_napi_del() in the .ndo_stop function?
However, I saw that many drivers do it in probe and remove. What is the purpose of doing this in .ndo_open and .ndo_stop?
