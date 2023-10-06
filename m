Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185357BB0A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjJFEDg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 00:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJFEDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:03:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C664FDB;
        Thu,  5 Oct 2023 21:03:30 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39642neN61336496, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39642neN61336496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Oct 2023 12:02:51 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 6 Oct 2023 12:02:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 6 Oct 2023 12:02:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 6 Oct 2023 12:02:49 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v9 08/13] net:ethernet:realtek:rtase: Implement net_device_ops
Thread-Topic: [PATCH net-next v9 08/13] net:ethernet:realtek:rtase: Implement
 net_device_ops
Thread-Index: AQHZ8fl5hDe6qB9qzkmKif0/hXC9sLAvvsaAgAxiTMA=
Date:   Fri, 6 Oct 2023 04:02:48 +0000
Message-ID: <99dfcd7363dc412f877730fab4a9f7dd@realtek.com>
References: <20230928104920.113511-1-justinlai0215@realtek.com>
 <20230928104920.113511-9-justinlai0215@realtek.com>
 <b28a3ea6-d75e-45e0-8b87-0b062b5c3a64@lunn.ch>
In-Reply-To: <b28a3ea6-d75e-45e0-8b87-0b062b5c3a64@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

> > +static int rtase_change_mtu(struct net_device *dev, int new_mtu) {
> > +     struct rtase_private *tp = netdev_priv(dev);
> > +     int ret;
> > +
> > +     dev->mtu = new_mtu;
> > +
> > +     if (!netif_running(dev))
> > +             goto out;
> > +
> > +     rtase_down(dev);
> > +
> > +     rtase_set_rxbufsize(tp, dev);
> > +
> > +     ret = rtase_init_ring(dev);
> > +
> > +     if (ret)
> > +             return ret;
> 
> If this fails, what state is the interface in?
> 
> What you often see is that the new ring is first allocated. If that is successful,
> you free the old rung. If the allocation fails, it does not matter, you still have
> the old ring, and you keep using it.
> 

If it fails, the driver will not work properly. We will make modifications based on your suggestions.

> > +
> > +     netif_stop_queue(dev);
> > +     netif_carrier_off(dev);
> > +     rtase_hw_config(dev);
> > +
> > +     /* always link, so start to transmit & receive */
> > +     rtase_hw_start(dev);
> > +     netif_carrier_on(dev);
> > +     netif_wake_queue(dev);
> 
> I don't think you need to down/up the carrier when changing the MTU.

Thank you for your suggestion, we will confirm this part again.

> 
> > +static void rtase_sw_reset(struct net_device *dev) {
> > +     struct rtase_private *tp = netdev_priv(dev);
> > +     int ret;
> > +
> > +     netif_stop_queue(dev);
> > +     netif_carrier_off(dev);
> > +     rtase_hw_reset(dev);
> > +
> > +     /* let's wait a bit while any (async) irq lands on */
> > +     rtase_wait_for_quiescence(dev);
> > +     rtase_tx_clear(tp);
> > +     rtase_rx_clear(tp);
> > +
> > +     ret = rtase_init_ring(dev);
> > +     if (ret)
> > +             netdev_alert(dev, "unable to init ring\n");
> > +
> > +     rtase_hw_config(dev);
> > +     /* always link, so start to transmit & receive */
> > +     rtase_hw_start(dev);
> > +
> > +     netif_carrier_on(dev);
> > +     netif_wake_queue(dev);
> > +}
> > +
> > +static void rtase_tx_timeout(struct net_device *dev, unsigned int
> > +txqueue) {
> > +     rtase_sw_reset(dev);
> 
> Do you actually see this happening? The timeout is set pretty high, i think 5
> seconds. If it does happen, it probably means you have a hardware/firmware
> bug. So you want to be noisy here, so you get to know about these problems,
> rather than silently work around them.

I would like to ask if we can dump some information that will help us understand the cause of the problem before doing the reset? And should we use netdev_warn to print this information?

> 
> > +static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type type,
> > +                       void *type_data) {
> > +     struct rtase_private *tp = netdev_priv(dev);
> > +     int ret = 0;
> > +
> > +     switch (type) {
> > +     case TC_SETUP_QDISC_MQPRIO:
> > +             break;
> > +     case TC_SETUP_BLOCK:
> > +             break;
> 
> This looks odd. You silently return 0, doing nothing?

Thank you for your reminder, we will remove it.

> 
> > +     case TC_SETUP_QDISC_CBS:
> > +             ret = rtase_setup_tc_cbs(tp, type_data);
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static netdev_features_t rtase_fix_features(struct net_device *dev,
> > +                                         netdev_features_t
> features)
> > +{
> > +     netdev_features_t features_fix = features;
> > +
> > +     if (dev->mtu > MSS_MAX)
> > +             features_fix &= ~NETIF_F_ALL_TSO;
> > +
> > +     if (dev->mtu > ETH_DATA_LEN) {
> > +             features_fix &= ~NETIF_F_ALL_TSO;
> > +             features_fix &= ~NETIF_F_CSUM_MASK;
> > +     }
> 
> So the hardware does not support TSO and checksumming for jumbo frames?

This hardware supports checksumming for jumbo frames, but does not support TSO. We will modify this part, thank you.

> 
>    Andrew
