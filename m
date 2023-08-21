Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65034782AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbjHUNjO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 09:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbjHUNjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:39:13 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBCC5BC;
        Mon, 21 Aug 2023 06:39:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37LDcSG91006626, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37LDcSG91006626
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Aug 2023 21:38:28 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 21 Aug 2023 21:38:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 21 Aug 2023 21:38:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 21 Aug 2023 21:38:12 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Jiri Pirko <jiri@resnulli.us>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v5 1/2] net/ethernet/realtek: Add Realtek automotive PCIe driver code
Thread-Topic: [PATCH net-next v5 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Thread-Index: AQHZ0crXtvCkECTdcEuScM6fwcV+uq/vccWAgAVSagA=
Date:   Mon, 21 Aug 2023 13:38:12 +0000
Message-ID: <371e0e25bee34ad7bf6f9fa44713ac1b@realtek.com>
References: <20230818115501.209945-1-justinlai0215@realtek.com>
 <20230818115501.209945-2-justinlai0215@realtek.com>
 <ZN9g+dwZcqaX8hTO@nanopsycho>
In-Reply-To: <ZN9g+dwZcqaX8hTO@nanopsycho>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

> Fri, Aug 18, 2023 at 01:55:00PM CEST, justinlai0215@realtek.com wrote:
> V>This patch is to add the ethernet device driver for the PCIe interface
> V>of Realtek Automotive Ethernet Switch,
> >applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
> >
> >Below is a simplified block diagram of the chip and its relevant interfaces.
> >
> >          *************************
> >          *                       *
> >          *  CPU network device   *
> >          *    ____________       *
> >          *   |            |      *
> >          *   |  PCIE Host |      *
> >          *************************
> >                    ||
> >                   PCIE
> >                    ||
> >  ****************************************
> >  *          | PCIE Endpoint |           *
> >  *          |---------------|           *
> >  *              | GMAC |                *
> >  *              |------|  Realtek       *
> >  *                 ||   RTL90xx Series  *
> >  *                 ||                   *
> >  *    _____________||______________     *
> >  *   |            |MAC|            |    *
> >  *   |            |---|            |    *
> >  *   |                             |    *
> >  *   |     Ethernet Switch Core    |    *
> >  *   |                             |    *
> >  *   |  -----             -----    |    *
> >  *   |  |MAC| ............|MAC|    |    *
> >  *   |__|___|_____________|___|____|    *
> >  *      |PHY| ............|PHY|         *
> >  *      -----             -----         *
> >  *********||****************||***********
> >
> >The block of the Realtek RTL90xx series is our entire chip
> >architecture, the GMAC is connected to the switch core, and there is no
> >PHY in between. In addition, this driver is mainly used to control GMAC, but
> does not control the switch core, so it is not the same as DSA.
> 
> [..]
> 
> 
> >+
> >+#define NETIF_F_ALL_CSUM NETIF_F_CSUM_MASK
> >+
> >+#define NETIF_F_HW_VLAN_RX NETIF_F_HW_VLAN_CTAG_RX #define
> >+NETIF_F_HW_VLAN_TX NETIF_F_HW_VLAN_CTAG_TX
> 
> [..]
> 
> I see 3 essentials wrong from 10sec review:
> 1) You don't cc people who commented your previous versions
> 2) You don't respect 72cols for patch description text (checkpatch did
>    warn you, didn't it?)
> 3) You are defining very odd macros like these 3
> 
> No need to read any longer... Really, can't you please ask someone who knows
> to help you with the submission preparation? You are vasting time of people :/
> 

Thank you for your reply, I will re-check this driver and the content you mentioned above.

