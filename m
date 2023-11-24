Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A94F7F75E0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjKXOBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:01:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5893D41;
        Fri, 24 Nov 2023 06:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700834482; x=1701439282; i=wahrenst@gmx.net;
        bh=2RHDVyt5/moemHHoQmT1rzjjAAaif5thTqOsAXsDqsA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=GOD36E9DdPyzK/aCP7jRXPcr9XV9PnZFDmtOQbNKcDrM4EYPi6eE5kHup010WlES
         mzQUgSJE1hiC4kgj0UPkFd854GUS7ipvVS/mG/hebzWT5HNv0Yvc0TE2I1APxJjgm
         hdzNJdm7upVsbnlh+Upws4rj227l1EcPV0jnUZEMtbN+WbHO4amePtFgSXap6vjDm
         2gqxswthCfvk40Xu+eILMw5+/TK1mpx3ibvSiorVZlYdD8HfuIQRtH5qHrhxp9IVM
         ph8IfnM29hSgTZSWHvR5SqUdN1t2FVG5zbRapFIYzmM/hJ8gg20SW7XwrxmQvll0y
         0EPnHZGqACi2mZ2Mnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6DWi-1rD8Ru2QNk-006jdo; Fri, 24
 Nov 2023 15:01:22 +0100
Message-ID: <bf3dd03e-a1f2-4586-8f00-7003848016aa@gmx.net>
Date:   Fri, 24 Nov 2023 15:01:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4 net] qca_spi: Fix SPI IRQ handling
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231121163004.21232-1-wahrenst@gmx.net>
 <20231121163004.21232-3-wahrenst@gmx.net>
 <a24433f86e39cbb45a9606621e01446e7ad6fa53.camel@redhat.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <a24433f86e39cbb45a9606621e01446e7ad6fa53.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:73pD02ceFv9jYjDGVqjxtrTbdmqUspOJI6R9fWjllimsvxhzTBt
 CQHPuXhJU48lRVcNDMOTloA+++/GnwJmo5uslAKFbzY/we8TPY3Hcb/k0gtd3Sf5Or9rvoa
 LcACcYrBsEDOEk1d6jbzUmtzftwGQi109uLPl87sMfAPjPVft/mhvTSKtzza3h/7OTnOomH
 y2vTvvzOiQe2XfRixhqfg==
UI-OutboundReport: notjunk:1;M01:P0:NJbxcN48qoA=;xJWy61p3j0lBiTHP+UxcxAkrjuT
 nvxMI8PJwQG2h2GUXmg6qWjgxYTfT23ZjBWqXd7mkka6On5sgsLUBfguCsTPH/M6p2qOcFOuv
 p/doWmewYhn33f3//+cnk5JZj/mb+Io1ot56d5u0e7m8e9m+azUxTHUUn0ixEpIzdm+qKEsga
 4TE3Z63Xg+/LXSag2ATimkQguj8LXLINREfzZhMuxK0cQo+1gaidOA4MOJbUj+EdlyUGl/vB9
 0kRTf/YvqnywkBHzo8kby23H07DK7hILxSuVOQaLSXyNlJgruy/PvdWMUIRUzKQiMNZYx4fbB
 qAL/SWWZSdl0lKFKYHqZpRE7M4QYhIwsgXNz227fdQtz7JQrmMsoTfV3kiQzwa75F5b5ZY5UJ
 uKROEvPNXQ1vTAQEToS6sGMDPU4NG8AuXfaM5m43Vx4JdK6hkTym7H9sReTWOVmW1MN4I2oEt
 eCzMrkZWp4LyyNnjNt+3u8eeTxBQgSOQdAAEgREs9TM/WM0ej+sJM7QBE74/wqt9rbDZKnUhb
 pGzOPoWRiFq9s3cG3nTw/98AbVotFS7plT/6pDsqPT8S9kUAqP3c4vX7GIxfrLynkYJS+CuAa
 EPb/reV5ZWMtujQFI8uZTgBHlPt3AQ6IBE4bBEuqnB49cITMjNGEWWiWNJsyhVYbPUoIP1nQ7
 IAcEqrZ6v1NvhPUhmhtUAb+GRz+Mo+rKSxJrzZTUxM7c7m3CQEYR2pfd7a4lNlB/6ikgyXGXC
 sFK7LupaPsWbGBWzIf4ZLK/OWEY5xjHAN0Qin+k0ySkMMaS4kPs/tQLhCeLIYD55BL4YH3VPh
 C0u/FhLEPzTZad/+p6gY7Sswlugf+guMry5p6VC830ijupT1X62RglWGNjbLo8TGcZXepCVgK
 10OGGT+OlZVvKMEF0fG2gKqJUm3Mlqb02snctwb5Jtk7qVwK0mbtMCq+WpKRYAw6Q7xC4IrqU
 ydyQew==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

Am 23.11.23 um 12:37 schrieb Paolo Abeni:
> On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
>> The functions qcaspi_netdev_open/close are responsible of request &
>> free of the SPI interrupt, which wasn't the best choice. Currently
>> it's possible to trigger a double free of the interrupt by calling
>> qcaspi_netdev_close() after qcaspi_netdev_open() has failed.
>> So let us split IRQ allocation & enabling, so we can take advantage
>> of a device managed IRQ and also fix the issue.
>>
>> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for Q=
CA7000")
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> The change makes sense, but the changelog is confusing.
>
> qcaspi_netdev_close() and qcaspi_netdev_open() are invoked only via
> ndo_open and ndo_close(), right? So qcaspi_netdev_close() will never be
> invoked qcaspi_netdev_open(), failure - that is when IFF_UP is not set.
sorry, i missed to mention an important part. This issue is partly
connected to patch 3.
Please look at qcaspi_set_ringparam() which also call ndo_close() and
ndo_open(). If you only apply patch 3 you could trigger this issue by
running the following script, interrupt via Strg+C and start again:

#!/bin/bash

while [ true ]; do
 =C2=A0 ethtool -G eth1 tx 8
 =C2=A0 ethtool -g eth1
 =C2=A0 ethtool -G eth1 tx 10
done


[=C2=A0=C2=A0 75.713471] qcaspi spi1.0 eth1: SPI thread exit
[=C2=A0=C2=A0 75.721814] qcaspi spi1.0 eth1: SPI thread created
[=C2=A0=C2=A0 76.795239] qcaspi spi1.0 eth1: SPI thread exit
[=C2=A0=C2=A0 76.815801] qcaspi spi1.0 eth1: SPI thread created
[=C2=A0=C2=A0 77.915872] qcaspi spi1.0 eth1: SPI thread exit
[=C2=A0=C2=A0 77.933982] qcaspi spi1.0 eth1: SPI thread created
[=C2=A0=C2=A0 79.036024] qcaspi spi1.0 eth1: SPI thread exit
[=C2=A0=C2=A0 79.055595] qcaspi spi1.0 eth1: SPI thread created
[=C2=A0=C2=A0 80.076223] qcaspi spi1.0 eth1: SPI thread exit
[=C2=A0=C2=A0 80.097305] qcaspi spi1.0 eth1: SPI thread created
[=C2=A0=C2=A0 81.196471] qcaspi spi1.0 eth1: SPI thread exit
[=C2=A0=C2=A0 81.217351] qcaspi spi1.0 eth1: SPI thread created
[=C2=A0=C2=A0 82.316592] qcaspi spi1.0 eth1: SPI thread exit
[=C2=A0=C2=A0 82.336963] qcaspi spi1.0 eth1: SPI thread created
[=C2=A0=C2=A0 83.436864] qcaspi spi1.0 eth1: SPI thread exit
[=C2=A0=C2=A0 83.461252] qcaspi spi1.0 eth1: SPI thread created
[=C2=A0=C2=A0 84.556950] qcaspi spi1.0 eth1: SPI thread exit
[=C2=A0=C2=A0 84.575897] qcaspi spi1.0 eth1: SPI thread created
[=C2=A0=C2=A0 85.677105] qcaspi spi1.0 eth1: SPI thread exit
[=C2=A0=C2=A0 85.695061] qcaspi spi1.0 eth1: SPI thread created
[=C2=A0=C2=A0 86.717215] qcaspi spi1.0 eth1: SPI thread exit
[=C2=A0=C2=A0 86.739535] qcaspi spi1.0 eth1: SPI thread created
[=C2=A0=C2=A0 87.837355] qcaspi spi1.0 eth1: SPI thread exit
<-- Strg + C
[=C2=A0=C2=A0 87.841072] qcaspi spi1.0 eth1: qcaspi: unable to start kerne=
l thread.
root@tarragon:/srv# ./test_ring_fast.sh
=2D-----------[ cut here ]------------
WARNING: CPU: 0 PID: 724 at kernel/irq/manage.c:1887 free_irq+0x23c/0x288
Trying to free already-free IRQ 73
CPU: 0 PID: 724 Comm: ethtool Not tainted
6.1.49-chargebyte-00029-g8c38d497af8a-dirty #108
Hardware name: Freescale i.MX6 Ultralite (Device Tree)
 =C2=A0unwind_backtrace from show_stack+0x10/0x14
 =C2=A0show_stack from dump_stack_lvl+0x24/0x2c
 =C2=A0dump_stack_lvl from __warn+0x74/0xbc
 =C2=A0__warn from warn_slowpath_fmt+0xc8/0x120
 =C2=A0warn_slowpath_fmt from free_irq+0x23c/0x288
 =C2=A0free_irq from qcaspi_netdev_close+0x38/0x5c
 =C2=A0qcaspi_netdev_close from qcaspi_set_ringparam+0x48/0x90
 =C2=A0qcaspi_set_ringparam from ethnl_set_rings+0x2dc/0x320
 =C2=A0ethnl_set_rings from genl_rcv_msg+0x2c4/0x344
 =C2=A0genl_rcv_msg from netlink_rcv_skb+0x98/0xfc
 =C2=A0netlink_rcv_skb from genl_rcv+0x20/0x34
 =C2=A0genl_rcv from netlink_unicast+0x114/0x1a4
 =C2=A0netlink_unicast from netlink_sendmsg+0x314/0x340
 =C2=A0netlink_sendmsg from sock_sendmsg_nosec+0x14/0x24
 =C2=A0sock_sendmsg_nosec from __sys_sendto+0xc4/0xf8
 =C2=A0__sys_sendto from ret_fast_syscall+0x0/0x54
Exception stack(0xe115dfa8 to 0xe115dff0)
dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b6ed24dc 0000000c 00000003 005c423=
8 0000002c
00000000
dfc0: b6ed24dc 0000000c b6f6a5a0 00000122 00472e04 005c41f0 00436b60
005c4190
dfe0: 00000122 bec50b68 b6e5f841 b6dd1ae6
=2D--[ end trace 0000000000000000 ]---
>
> Cheers,
>
> Paolo
>

