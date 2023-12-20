Return-Path: <linux-kernel+bounces-6647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82C5819BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185072842C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F771F61D;
	Wed, 20 Dec 2023 09:46:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B51F602
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rFt9w-00032F-RJ; Wed, 20 Dec 2023 10:46:36 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rFt9t-000DKM-LV; Wed, 20 Dec 2023 10:46:34 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rFt9u-007uXL-LS; Wed, 20 Dec 2023 10:46:34 +0100
Date: Wed, 20 Dec 2023 10:46:34 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
Message-ID: <20231220094634.GG1697233@pengutronix.de>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <20231207002823.2qx24nxjhn6e43w4@skbuf>
 <20231207051502.GB1324895@pengutronix.de>
 <20231207140030.ki625ety6cg3ujxn@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207140030.ki625ety6cg3ujxn@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 04:00:30PM +0200, Vladimir Oltean wrote:
> On Thu, Dec 07, 2023 at 06:15:02AM +0100, Oleksij Rempel wrote:
> > On Thu, Dec 07, 2023 at 02:28:23AM +0200, Vladimir Oltean wrote:
> > > On Tue, Nov 21, 2023 at 04:24:26PM +0100, Oleksij Rempel wrote:
> > > > Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
> > > > ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
> > > > driver. Previously, the code erroneously used Bit 7 of port register 0xD
> > > > for both chip variants, which is actually for LED configuration. This
> > > > update ensures the correct registers and bits are used for the PHY
> > > > loopback feature:
> > > > 
> > > > - For KSZ8794: Use 0xF / Bit 7.
> > > > - For KSZ8873: Use 0xD / Bit 0.
> > > > 
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > ---
> > > 
> > > How did you find, and how did you test this, and on which one of the switches?
> > 
> > I tested it by using "ethtool -t lanX" command on KSZ8873. Before this
> > patch the link will stop to work _after_ end of the selftest. The
> > selftest will fail too.
> > 
> > After this patch, the selftest is passed, except of the TCP test. And
> > link is working _after_ the selftest,
> 
> So you are suggesting that this far-end loopback mode does work as
> expected by the kernel.
> 
> But is that consistent with the description from the datasheet? It speaks
> about an "originating PHY port", but maybe this is confusing, because
> based on your test, even the CPU port could be originating the traffic
> that gets looped back?
> 
> I see it says that far-end loopback goes through the switching fabric.
> So the packet, on its return path from the loopback port, gets forwarded
> by its MAC DA? That can't be, because the MAC DA lookup has already
> determined the destination to be the loopback port (and no MAC SA<->DA
> swapping should take place). Or it is forced by the switch to return
> specifically to the originating port?
> 
> With a bridge between the 2 LAN ports, and lan1 put in loopback, what
> happens if you send a broadcast packet towards lan1? Will you also see
> it on lan2's link partner, or only on the CPU port?
> 
> It's not your fault, but this is all a bit confusing, and I'm not quite
> able to match up the documentation with your results. I will trust the
> experimental results, however.

I did following tests:
ip l a name br0 type bridge
ip l s dev br0 up
ip l s lan1 master br0
ip l s dev lan1 up
ip l s lan2 master br0
ip l s dev lan2 up

# to avoid link drop with the loopback mode
ethtool -s lan1 speed 100 duplex full autoneg off
# currently no tool support loopback configuration, so set it directly
# to the register
mii -i lan1 -p 0 -r 0 -v 6120

################# Test 1 ###########################
# on DUT
ping 192.168.2.200 -I lan1

on eth0/cpu interface:
00:03:20.656445 AF Unknown (4294967295), length 61: 
        0x0000:  ffff 000e cd00 cdbe 0806 0001 0800 0604  ................
        0x0010:  0001 000e cd00 cdbe c0a8 010e 0000 0000  ................
        0x0020:  0000 c0a8 02c8 0000 0000 0000 0000 0000  ................
        0x0030:  0000 0000 0000 0000 01                   .........
00:03:20.656548 AF Unknown (4294967295), length 61: 
        0x0000:  ffff 000e cd00 cdbe 0806 0001 0800 0604  ................
        0x0010:  0001 000e cd00 cdbe c0a8 010e 0000 0000  ................
        0x0020:  0000 c0a8 02c8 0000 0000 0000 0000 0000  ................
        0x0030:  0000 0000 0000 0000 00                   .........

on lan1 remote system:
100 701.752654927 00:0e:cd:00:cd:be → ff:ff:ff:ff:ff:ff ARP 60 Who has 192.168.2.200? Tell 192.168.1.14

on lan2 remote system:
347 1071.154437549 00:0e:cd:00:cd:be → ff:ff:ff:ff:ff:ff ARP 60 Who has 192.168.2.200? Tell 192.168.1.14


################# Test 2 ###########################
# send ping on on lan1 remote system:
ping 172.17.0.1

on eth0/cpu interface DUT:
-- nothing --

on lan1 remote system:
109 946.617862621 80:61:5f:0c:29:54 → ff:ff:ff:ff:ff:ff ARP 42 Who has 172.17.0.1? Tell 172.17.0.12

on lan2 remote system:
-- nothing --

################# Test 3 ###########################
# send ping on on lan2 remote system:
ping 172.17.0.122

on eth0/cpu interface DUT:
00:12:18.034220 AF Unknown (4294967295), length 61: 
        0x0000:  ffff 8061 5f0c 2955 0806 0001 0800 0604  ...a_.)U........
        0x0010:  0001 8061 5f0c 2955 ac11 000d 0000 0000  ...a_.)U........
        0x0020:  0000 ac11 007a 0000 0000 0000 0000 0000  .....z..........
        0x0030:  0000 0000 0000 0000 01                   .........
00:12:18.034228 AF Unknown (4294967295), length 61: 
        0x0000:  ffff 8061 5f0c 2955 0806 0001 0800 0604  ...a_.)U........
        0x0010:  0001 8061 5f0c 2955 ac11 000d 0000 0000  ...a_.)U........
        0x0020:  0000 ac11 007a 0000 0000 0000 0000 0000  .....z..........
        0x0030:  0000 0000 0000 0000 00

on lan1 remote system:
-- nothing --

on lan2 remote system:
476 1608.560311470 80:61:5f:0c:29:55 → ff:ff:ff:ff:ff:ff ARP 42 Who has 172.17.0.122? Tell 172.17.0.13
477 1608.560361808 80:61:5f:0c:29:55 → ff:ff:ff:ff:ff:ff ARP 60 Who has 172.17.0.122? Tell 172.17.0.13

I also retest selftest results and noted that it is not working if
port is part of bridge.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

