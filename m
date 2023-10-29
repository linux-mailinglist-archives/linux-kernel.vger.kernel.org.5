Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5E97DAEC5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjJ2WSO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 29 Oct 2023 18:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2WSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:18:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED9EBD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 15:18:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-317-UlBHNFbGNfOFxGkrYIZEWg-1; Sun, 29 Oct 2023 22:18:06 +0000
X-MC-Unique: UlBHNFbGNfOFxGkrYIZEWg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 29 Oct
 2023 22:18:18 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 29 Oct 2023 22:18:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Lunn' <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dsa: tag_rtl4_a: Bump min packet size
Thread-Topic: [PATCH] dsa: tag_rtl4_a: Bump min packet size
Thread-Index: AQHaCSnhGWzkfBO9PU2ZFG9wM9DcyLBhVnbQ
Date:   Sun, 29 Oct 2023 22:18:17 +0000
Message-ID: <7f6684f1f3d84a208daee16321197315@AcuMS.aculab.com>
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
 <95f324af-88de-4692-966f-588287305e09@gmail.com>
 <3ffe7ea1-4dfb-4db8-a2ce-67733a190138@lunn.ch>
In-Reply-To: <3ffe7ea1-4dfb-4db8-a2ce-67733a190138@lunn.ch>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn
> Sent: 28 October 2023 00:04
> 
> On Fri, Oct 27, 2023 at 02:23:13PM -0700, Florian Fainelli wrote:
> > You would want your subject to be:
> >
> > net: dsa: tag_rtl4_a: Bump min packet size
> >
> > On 10/27/23 13:21, Linus Walleij wrote:
> > > It was reported that the "LuCI" web UI was not working properly
> > > with a device using the RTL8366RB switch. Disabling the egress
> > > port tagging code made the switch work again, but this is not
> > > a good solution as we want to be able to direct traffic to a
> > > certain port.
> > >
> > > It turns out that sometimes, but not always, small packets are
> > > dropped by the switch for no reason.
> >
> > And we are positive that the Ethernet MAC is also properly padding frames
> > before having them ingress the switch?
> 
> It might be interesting to run a script which systematically does a
> ping, or similar, for all frame sizes.
> 
> > > If we pad the ethernet frames to a minimum of ETH_FRAME_LEN + FCS
> > > (1518 bytes) everything starts working fine.

Thought - is that just because it slows everything down??

> > That is quite unprecedented, either the switch is very bogus or there is
> > something else we do not fully understand...
> 
> It would also be interesting to know if the frames on the wire have
> the padding removed when needed. Its not going to be good for
> performance if a TCP ACK is 1500bytes in size, rather than the usual
> ~64.

Non IP protocols are very likely to object to unexpected frame padding.
I'm also sure I've seen systems do (the equivalent of) printk for
overlong UDP packets.

If you search the right place you'll find reports of packets
being discarded before one of the VM network implementations
padded ethernet frames to an even byte length.
(I can't remember which, but have some fpga logic that adjusts
the MAC address based on the TCP port number and manages to
require there be no unexpected padding - yes it is broken.)

	David

> 
> Have problems also been noticed with traffic going from user port to
> user port?
> 
> 	Andrew

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

