Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2699762F94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjGZIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjGZIUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:20:22 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A258A26A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dTPecCXuv8hKImfNCoAlPlEQbIut43mykpyXbbtAN1Q=; b=BkMEijpaNK24OtzRFTmhKJmrcU
        VQ14NNkqh5PGBFak7oAblghWh7zOLZ+5LasJJ0B7C8sv/CulV66QpejfqHktFytRRv9A94hvKc2wl
        inBZJq2NVV3pb33pu2tlnJ3+afKbRXjSiEQT9SrnbOpH8qLNnxSBPC9lJR43UP+CEeZztT4XmvkL+
        OFl+zUKtPeTnspYR7aQC+ah7QGUaQYlMYOhbmDaY06rsuSXzBlVR9xX2NWRqqD7PxCOcy6BRfKEwC
        DdmsxxoWUjw4MloROjFuGaftSpDXNrTPtY4NK80eqI98cR1EzMVeM28/TExHUAy1Re00eWyN75wcm
        +yfTURCw==;
Received: from [192.168.1.4] (port=27878 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qOZZv-0001ol-0I;
        Wed, 26 Jul 2023 10:09:03 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 26 Jul 2023 10:09:02 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <andrew@lunn.ch>
CC:     <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <olteanv@gmail.com>, <pabeni@redhat.com>
Subject: [PATCH net-next] net: dsa: mv88e6xxx: enable automedia on 6190x and 6390x devices
Date:   Wed, 26 Jul 2023 10:08:58 +0200
Message-ID: <20230726080858.12322-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <e408ed0a-94fc-438f-b279-79f9253531d5@lunn.ch>
References: <e408ed0a-94fc-438f-b279-79f9253531d5@lunn.ch>
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

On Tue, 25 Jul 2023 23:22:06 +0200, Andrew Lunn wrote:
>On Tue, Jul 25, 2023 at 11:57:12AM +0200, Ante Knezic wrote:
>> On Mon, 24 Jul 2023 20:34:27 +0200 Anrew Lunn wrote:
>> >By auto-media, you mean both a copper PHY and an SFP? And whichever
>> >gets link first wins the MAC?
>> >
>> 
>> Yes, that is correct.
>> 
>> On Mon, 24 Jul 2023 20:34:27 +0200 Anrew Lunn wrote:
>> >auto-media has been discussed a few times, and rejected, since Linux
>> >has no concept of multiple 'phy like devices' connected to one MAC.
>> >
>> >How are you representing this in DT? I assume you have both an SFP
>> >socket, and a phy-handle pointing to a PHY? phylink will not drive
>> >both at the same time. So you cannot have them admin up at the same
>> >time? How do you get the SFP out of TX disable, when phylink sees a
>> >PHY? What does ethtool return? What the PHY is advertising as its link
>> >modes? Or nothing since an SFP does not advertise speeds?
>> 
>> Patch simply covers the automedia aspect of the device while the
>> exact mode is specified by the DT.
>
>So i would not call this automedia. You are not supporting both copper
>and SFP at the same time, and you are not supporting first win. You
>are just allowing the lower ports to use the SERDES interfaces for
>SFPs.
>

That is true, but in order to be able to use SERDES interface for lower
ports the switch needs to be operating in automedia mode. Automedia here 
simply means power up serdes lane and connect to whichever links first,
but there is no way to deny linking the PHY and allow only SERDES (as
far as I am aware).
I agree that commit message is misleading and wrongly assumes that 
reader has any knowledge of chip details.

>> So for example if you would like
>> to connect an SFP to port 3 of the device you would create a "regular"
>> sfp node just like for ports 9/10 along the lines of:
>>                         port@3 {
>>                                 reg = <3>;
>>                                 label = "SFP";
>>                                 phy-mode = "1000base-x";
>>                                 managed = "in-band-status";
>>                                 sfp = <&sfp1>;
>>                         };
>> 
>> >From then on, phylink will handle the sfp just as if it was connected
>> to ports 9/10 - the ethtool reports advertised and supported link mode
>> as 1000baseX, "Port" is "FIBRE", etc.
>> 
>> Patch looks for "1000base-x" phy-mode in the dt node so in case it
>> is not found the device can be linked only against a copper PHY.
>
>So this used to work. It got broken at some point, and i have a much
>simpler patch in one of the branches:
>
>https://github.com/lunn/linux/commit/74e2c2a9a56fd4e2baeee4d5fbe897c21f394ede
>
>Please try this and see if it works for you.
>

The provided patch does work, however I believe there are some drawbacks to
such simplification:
Firstly, it writes data to READ ONLY bits of the Port Status Register. As
indicated by the datasheet, the CMODE is R/W only for ports 9 and 10, other
ports actually reflect the actual connection via CMODE bits.
Secondly, there is no filtering on setting the ports phy mode. You could be
setting cmode of port 3 to sgmii for example, which is not supported.
And thirdly, during probing of the device set_cmode is called with argument
PHY_INTERFACE_MODE_NA from mv88e6xxx_setup_port. As we would now allow lower
ports to set the cmode, it would be automatically assigned a cmode of 
1000BASE-X because of:

static int mv88e6xxx_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
                                    phy_interface_t mode, bool force)
{
        u16 cmode;
        u16 reg;
        int err;

        /* Default to a slow mode, so freeing up SERDES interfaces for
         * other ports which might use them for SFPs.
         */
        if (mode == PHY_INTERFACE_MODE_NA)
                mode = PHY_INTERFACE_MODE_1000BASEX;

So ultimately, when the pcs->init is called it sees that cmode for
all ports is set to 1000BASE-X and proceeds with intialisation (assuming
ports 9 or 10 are configured in XAUI/RXAUI depending on which lane is
being accessed).

If however you believe the above points are irrelevant and there is 
nothing to be gained by the proposed patch than there is nothing more 
to be done here.
