Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEAA7898D9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 21:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjHZTzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 15:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjHZTzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 15:55:36 -0400
Received: from px.funlab.cc (px.funlab.cc [IPv6:2a01:4f8:c010:6bd5::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4039E1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 12:55:33 -0700 (PDT)
Received: from [192.168.1.40] (83.27.115.100.ipv4.supernova.orange.pl [83.27.115.100])
        (Authenticated sender: doka@funlab.cc)
        by px.funlab.cc (Postfix) with ESMTPSA id 0579960273;
        Sat, 26 Aug 2023 22:55:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=funlab.cc; s=dkim;
        t=1693079732; bh=Nq3E/C8MCYZ1MyUM+3Izi3Rw+2P9w68chIky07w10lg=;
        h=Date:From:Subject:To:Cc:From;
        b=IjSmHpWmwOWJ/CDnl4bLhyDZI+bDQOcWjQN1UEvEydXyvAuZdh48zIdK3xBv/sEd7
         jCCbwOAW0TijS/dOBaqHpEN2yOZaKE3MIWHgsqofuPnCrp+V510OtAwwAp/d0LxNB1
         FKkH5mxjOZP3d3tgf6dcxEkY84yYhY4TYOOu7l9cRNzO2dH9RXCHwzU4Cq/pFdshpw
         /eAfUsjU3OefbgRv8NCxBSO1TVqsPNmt0ygjBid9gLRmr4t23gJeFpnRned426GQNY
         BCr81B8qqeJb5ucgAJypcql8F6cDJAFZrDXe/+rzmRwbCVYjpq7Fp1iKhn0HKOY4l4
         g+UIhhjLV0T3Q==
Message-ID: <eaf3d0d8-fca2-029e-9c57-ddae31f17726@funlab.cc>
Date:   Sat, 26 Aug 2023 21:55:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Volodymyr Litovka <doka@funlab.cc>
Subject: [Networking] ERSPAN decapsulation drops DHCP unicast packets
To:     linux-kernel@vger.kernel.org
Cc:     doka@funlab.cc
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi colleagues,

I'm trying to catch and process (in 3rd party analytics app) DHCP 
packets from ERSPAN session, but cannot do this due to absence of DHCP 
unicast packets after decapsulation.

The model is pretty simple: there is PHY interface (enp2s0) which 
receive ERSPAN traffic and erspan-type interface to get decapsulated 
packets (inspan, created using command "ip link add inspan type erspan 
seq key 10 local 10.171.165.65 erspan_ver 1", where 10.171.165.65 is 
ERSPAN target). Then I'm going to rewrite headers in the proper ways 
(nftable's netdev family) and forward packets to the pool of workers.

Having this, I'm expecting everything, which is encapsulated inside 
ERSPAN, on 'inspan' interface. And there is _almost_ everything except 
DHCP unicast packets - tcpdump shows about 1kps on this interface of 
decapsulated packets, but no DHCP unicast (see below traces).

To avoid any interactions, I removed and disabled everything that can 
catch DHCP in userspace - systemd-networkd, netplan, dhcp-client. There 
is no DHCP server and ifupdown - for test purposes, I'm bringing 
networking manually. Apparmor disabled as well. Kernel (Linux 
5.19.0-42-generic #43~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC) compiled 
without CONFIG_IP_PNP (according to /boot/config-5.19.0-42-generic). 
Nothing in userspace listens on UDP/68 and UDP/67:

# netstat -tunlpa
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         
State       PID/Program name
tcp        0      0 0.0.0.0:22 0.0.0.0:*               LISTEN      
544/sshd: /usr/sbin
tcp6       0      0 :::22 :::*                    LISTEN      544/sshd: 
/usr/sbin

I have no ideas, why this is happening. Decapsulation itself works, but 
particular kind of packets get lost.

I will appreciate if anyone can help me understand where is the bug - in 
my configuration or somewhere inside the kernel?

Evidence of traffic presence/absence is below.

Thank you.

Encapsulated ERSPAN session (udp and port 67/68) contains lot of 
different kinds of DHCP packets:

# tcpdump -s0 -w- -i enp2s0 'proto gre and ether[73:1]=17 and 
(ether[84:2]=67 or ether[84:2]=68)' | tshark -r- -l
  [ ... ]
     7   0.001942  0.0.0.0 → 255.255.255.255 DHCP 392 DHCP Discover - 
Transaction ID 0x25c096fc
     8   0.003432  z.z.z.z → a.a.a.a         DHCP 418 DHCP ACK      - 
Transaction ID 0x5515126a
     9   0.005170  m.m.m.m → z.z.z.z         DHCP 435 DHCP Discover - 
Transaction ID 0xa7b7
    10   0.005171  m.m.m.m → z.z.z.z         DHCP 435 DHCP Discover - 
Transaction ID 0xa7b7
    11   0.015399  n.n.n.n → z.z.z.z         DHCP 690 DHCP Request  - 
Transaction ID 0x54955233
    12   0.025537  z.z.z.z → n.n.n.n         DHCP 420 DHCP ACK      - 
Transaction ID 0x54955233
    13   0.030313  z.z.z.z → m.m.m.m         DHCP 413 DHCP Offer    - 
Transaction ID 0xa7b7

but decapsulated traffic (which I'm seeing on inspan interface) contains 
just the following:

# tcpdump -i inspan 'port 67 or port 68'
listening on inspan, link-type EN10MB (Ethernet), snapshot length 262144 
bytes
17:23:36.540721 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, 
Request from 00:1a:64:33:8d:fa (oui Unknown), length 300
17:23:39.760036 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, 
Request from 00:1a:64:33:8d:fa (oui Unknown), length 300
17:23:44.135711 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, 
Request from 00:1a:64:33:8d:fa (oui Unknown), length 300
17:23:52.008504 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, 
Request from 00:1a:64:33:8d:fa (oui Unknown), length 300

Thanks again for the help.


-- 
Volodymyr Litovka
   "Vision without Execution is Hallucination." -- Thomas Edison

