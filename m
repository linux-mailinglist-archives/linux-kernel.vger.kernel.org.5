Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C4778605
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjHKDet convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Aug 2023 23:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjHKDer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:34:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19F7F2D66;
        Thu, 10 Aug 2023 20:34:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37B3Xx7yA009363, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37B3Xx7yA009363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 11:33:59 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 11 Aug 2023 11:34:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 11 Aug 2023 11:34:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 11 Aug 2023 11:34:17 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/2] net/ethernet/realtek: Add Realtek automotive PCIe driver code
Thread-Topic: [PATCH net-next v2 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Thread-Index: AQHZy1QCmgVf5/SQ0U+g6HlrD3yFj6/jFKEAgAFd0RA=
Date:   Fri, 11 Aug 2023 03:34:17 +0000
Message-ID: <1e79bf4cdb8e4a75873d029cb7c56227@realtek.com>
References: <20230810062915.252881-1-justinlai0215@realtek.com>
 <20230810062915.252881-2-justinlai0215@realtek.com>
 <8746dad6-a6f1-4db0-958b-7b66d9dbd1f5@lunn.ch>
In-Reply-To: <8746dad6-a6f1-4db0-958b-7b66d9dbd1f5@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#include <linux/version.h>
> > +#include <linux/ethtool.h>
> > +
> > +#define RTL_ALLOC_SKB_INTR(napi, length) napi_alloc_skb(&(napi),
> > +length)
> > +
> > +#define NETIF_F_ALL_CSUM NETIF_F_CSUM_MASK
> > +
> > +#define NETIF_F_HW_VLAN_RX NETIF_F_HW_VLAN_CTAG_RX #define
> > +NETIF_F_HW_VLAN_TX NETIF_F_HW_VLAN_CTAG_TX
> > +
> > +#define CONFIG_SRIOV 1
> > +
> > +#ifndef NETIF_F_RXALL
> > +#define NETIF_F_RXALL 0u
> > +#endif
> > +
> > +#ifndef NETIF_F_RXFCS
> > +#define NETIF_F_RXFCS 0u
> > +#endif
> > +
> > +#ifndef SET_NETDEV_DEV
> > +#define SET_NETDEV_DEV(net, pdev)
> > +#endif
> > +
> > +#ifndef SET_MODULE_OWNER
> > +#define SET_MODULE_OWNER(dev)
> > +#endif
> > +
> > +#ifndef SA_SHIRQ
> > +#define SA_SHIRQ IRQF_SHARED
> > +#endif
> > +
> > +#ifndef NETIF_F_GSO
> > +#define gso_size tso_size
> > +#define gso_segs tso_segs
> > +#endif
> > +
> > +#ifndef dma_mapping_error
> > +#define dma_mapping_error(a, b) 0
> > +#endif
> > +
> > +#ifndef netif_err
> > +#define netif_err(a, b, c, d)
> > +#endif
> > +
> > +#ifndef FALSE
> > +#define FALSE 0
> > +#endif
> > +
> > +#ifndef TRUE
> > +#define TRUE 1
> > +#endif
> > +
> > +#ifndef false
> > +#define false 0
> > +#endif
> > +
> > +#ifndef true
> > +#define true 1
> > +#endif
> 
> When i see code like this, it just shouts 'vendor crap, don't bother reviewing'.
> 
> Really, truly, get help from an experienced mainline developer to rewrite this
> code to mainline quality. Then post version 3.
> 
> Just as a hint, you are targeting net-next/main, and only net-next/main. You
> can and should use everything which is in net-next/main, and you should
> assume it exists. You are not targeting older kernels, and you should not have
> 'vendor crap' like this so it will compile with older kernels.
> 
> Spend some time looking at other drivers in mainline. If you are doing
> something which other driver don't do, very likely you are doing something
> wrong. Do you see other drivers looking to see if NETIF_F_RXALL exists, and it
> not setting it to 0?
> 
> And please don't just fix this and repost. There is a lot more wrong.
> Find a mentor to help you. The community would like to see this driver in the
> kernel, but an entity the size of Realtek can easily contract somebody to help
> get the code into shape.
> 
>     Andrew

Thank you for your suggestions, I will check our code again and make changes.
