Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738AC7EBD0A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjKOG0D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 01:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjKOG0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:26:01 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AEEE9;
        Tue, 14 Nov 2023 22:25:54 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AF6PZwgC1502500, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AF6PZwgC1502500
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:25:35 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 15 Nov 2023 14:25:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 15 Nov 2023 14:25:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 15 Nov 2023 14:25:35 +0800
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
Subject: RE: [PATCH net-next v10 10/13] net:ethernet:realtek:rtase: Implement ethtool function
Thread-Topic: [PATCH net-next v10 10/13] net:ethernet:realtek:rtase: Implement
 ethtool function
Thread-Index: AQHaDaOWhhjxNTqG0kiC4Rl5u77TuLBqDmkAgBDus0A=
Date:   Wed, 15 Nov 2023 06:25:34 +0000
Message-ID: <3d5775e1163845698e0b911f6a591eb6@realtek.com>
References: <20231102154505.940783-1-justinlai0215@realtek.com>
 <20231102154505.940783-11-justinlai0215@realtek.com>
 <726ce350-b2df-4dfb-8401-dc9c70dd8cd6@lunn.ch>
In-Reply-To: <726ce350-b2df-4dfb-8401-dc9c70dd8cd6@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static int rtase_get_settings(struct net_device *dev,
> > +                           struct ethtool_link_ksettings *cmd) {
> > +     u32 supported = SUPPORTED_MII | SUPPORTED_Pause;
> > +
> > +
> ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
> > +                                             supported);
> > +     cmd->base.speed = SPEED_5000;
> > +     cmd->base.duplex = DUPLEX_FULL;
> > +     cmd->base.port = PORT_MII;
> > +     cmd->base.autoneg = AUTONEG_DISABLE;
> > +
> > +     return 0;
> > +}
> > +
> 
> > +static int rtase_set_pauseparam(struct net_device *dev,
> > +                             struct ethtool_pauseparam *pause) {
> > +     const struct rtase_private *tp = netdev_priv(dev);
> > +     u16 value = rtase_r16(tp, RTASE_CPLUS_CMD);
> > +
> > +     if (pause->autoneg)
> > +             return -EOPNOTSUPP;
> > +
> > +     value &= ~(FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
> > +
> > +     if (pause->tx_pause)
> > +             value |= FORCE_TXFLOW_EN;
> > +
> > +     if (pause->rx_pause)
> > +             value |= FORCE_RXFLOW_EN;
> 
> It appears the hardware supports asymmetric pause? So i think your
> rtase_get_settings() is wrong.
> 
>         Andrew

Thank you for your review, I will confirm this part again and make corresponding corrections.
