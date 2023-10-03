Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE77B6935
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjJCMlG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjJCMlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:41:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77ADB0;
        Tue,  3 Oct 2023 05:40:58 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 393CeLGW11998446, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 393CeLGW11998446
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 20:40:23 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Oct 2023 20:40:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 3 Oct 2023 20:40:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 3 Oct 2023 20:40:21 +0800
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
Subject: RE: [PATCH net-next v9 02/13] net:ethernet:realtek:rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v9 02/13] net:ethernet:realtek:rtase: Implement
 the .ndo_open function
Thread-Index: AQHZ8fl23iE5gfcWPUefA6LhXZT8grAvrIqAgAhbNIA=
Date:   Tue, 3 Oct 2023 12:40:20 +0000
Message-ID: <f3ff51ce080b441cbfe9309e286fc039@realtek.com>
References: <20230928104920.113511-1-justinlai0215@realtek.com>
 <20230928104920.113511-3-justinlai0215@realtek.com>
 <714dbb7d-3fb8-481e-aba1-01a1be992950@lunn.ch>
In-Reply-To: <714dbb7d-3fb8-481e-aba1-01a1be992950@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h
> > b/drivers/net/ethernet/realtek/rtase/rtase.h
> > index bae04cfea060..5314fceb72a2 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase.h
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> > @@ -51,8 +51,6 @@
> >
> >  #define RX_BUF_SIZE (1522 + 1)
> >
> > -#define IVEC_NAME_SIZE IFNAMSIZ + 10
> > -
> >
> >
> /***************************************************************
> ******
> > ********/
> >  enum rtase_registers {
> >       RTASE_MAC0   = 0x0000,
> > @@ -261,6 +259,8 @@ union rx_desc {
> >  #define RTASE_IDLESLOPE_INT_SHIFT 25
> >  #define RTASE_IDLESLOPE_INT_MASK  GENMASK(31, 25)
> >
> > +#define IVEC_NAME_SIZE IFNAMSIZ + 10
> > +
> 
> Please try to avoid moving things around which you just added in the previous
> patch.
> 
> > +static int rtase_open(struct net_device *dev) {
> > +     struct rtase_private *tp = netdev_priv(dev);
> > +     struct rtase_int_vector *ivec = &tp->int_vector[0];
> > +     const struct pci_dev *pdev = tp->pdev;
> > +     int ret;
> > +     u16 i;
> > +
> 
> > +     netif_carrier_on(dev);
> > +     netif_wake_queue(dev);
> > +     netdev_info(dev, "link up\n");
> 
> No need to spam the log with this. Given the hardware architecture, the link is
> always going to be up.
> 
>     Andrew

Hi, Andrew
Thank you for your reply, I will modify what you mentioned.
