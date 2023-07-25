Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AE9760FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjGYJ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjGYJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:57:26 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EABE19A2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EQLUig3Re9LcJ5mfyjD3+YbubofBeqbAurKOO5MYjuE=; b=QPzFytEVJ8x0h7xQWIcFUsxBvU
        9StUmtWVWbcsmM4sHaRHd0NEEATJBxLIflPhnULaBvDZECuETW/ngeTdShu+gCLthe4sN7IFoY8RK
        dSjRXR9RS0Vkjat/Mbl9jww2Q2uE6O6pq/Bj3Q1s9emy9UKWtznKazBOJUbZLfEWtxu60F5XcTbrU
        PAyEfzx7muoImrbIFRRJIghqdq7quUdRBwZ+vjbJdTbEP7ELqVAfQV68tTUfQqd/cVI/QhOwAzEef
        5ql+kJdD2e9JEe3X2N883FawILiYPFLHP+wz1fK8Raxzb5y2tz8kbi6mc2rOY+YXGoRkK/MzxYNeX
        Q1/IpgcA==;
Received: from [192.168.1.4] (port=54635 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qOEn5-0007Pg-2Q;
        Tue, 25 Jul 2023 11:57:15 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 25 Jul 2023 11:57:14 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <andrew@lunn.ch>
CC:     <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <olteanv@gmail.com>, <pabeni@redhat.com>
Subject: [PATCH net-next] net: dsa: mv88e6xxx: enable automedia on 6190x and 6390x devices
Date:   Tue, 25 Jul 2023 11:57:12 +0200
Message-ID: <20230725095712.24771-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <d3f45312-882d-4667-89da-c562e0828589@lunn.ch>
References: <d3f45312-882d-4667-89da-c562e0828589@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 20:34:27 +0200 Anrew Lunn wrote:
>By auto-media, you mean both a copper PHY and an SFP? And whichever
>gets link first wins the MAC?
>

Yes, that is correct.

On Mon, 24 Jul 2023 20:34:27 +0200 Anrew Lunn wrote:
>auto-media has been discussed a few times, and rejected, since Linux
>has no concept of multiple 'phy like devices' connected to one MAC.
>
>How are you representing this in DT? I assume you have both an SFP
>socket, and a phy-handle pointing to a PHY? phylink will not drive
>both at the same time. So you cannot have them admin up at the same
>time? How do you get the SFP out of TX disable, when phylink sees a
>PHY? What does ethtool return? What the PHY is advertising as its link
>modes? Or nothing since an SFP does not advertise speeds?

Patch simply covers the automedia aspect of the device while the
exact mode is specified by the DT. So for example if you would like
to connect an SFP to port 3 of the device you would create a "regular"
sfp node just like for ports 9/10 along the lines of:
                        port@3 {
                                reg = <3>;
                                label = "SFP";
                                phy-mode = "1000base-x";
                                managed = "in-band-status";
                                sfp = <&sfp1>;
                        };

From then on, phylink will handle the sfp just as if it was connected
to ports 9/10 - the ethtool reports advertised and supported link mode
as 1000baseX, "Port" is "FIBRE", etc.

Patch looks for "1000base-x" phy-mode in the dt node so in case it
is not found the device can be linked only against a copper PHY.

The "real" automedia you are refering to is of course not covered here
and maybe the commit message is a "bit" misleading.
