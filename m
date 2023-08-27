Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED8F789C2D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjH0Ie5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjH0Ien (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:34:43 -0400
X-Greylist: delayed 53703 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Aug 2023 01:34:40 PDT
Received: from px.funlab.cc (px.funlab.cc [159.69.251.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54E12E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 01:34:40 -0700 (PDT)
Received: from [192.168.1.40] (83.27.115.100.ipv4.supernova.orange.pl [83.27.115.100])
        (Authenticated sender: doka@funlab.cc)
        by px.funlab.cc (Postfix) with ESMTPSA id 6D833602BA;
        Sun, 27 Aug 2023 11:34:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=funlab.cc; s=dkim;
        t=1693125279; bh=jLeu8EeWZrLtW93PihcYh0lxgc/rHXPKXDnE/1PyP1Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=dHRv6tkC6Q3cXyX5b4EezSFrvFh9IhJ6Ayot0z9NRq03gIOXWjnqzrYe8uCEbsp9m
         sKN8u6nhKah8eGJd8AOONap0z2T8/9MXJSkgC0AgnvhkGAEabXWV7p27e/DKQdBvUa
         K79XuvwJzNhM8Fiq92YbtbbVLcpVh/sPwKmnUiV5TtwGqmOuHyIbxUEwieisShuVZA
         oSBkrOeM+Oj/hkpgLlBOeMjN2tnctGOUSWNR/SgXEhzwPRbLMuC4/YqLvHG6j1K++2
         dxcoDSzSgtZ0B5B6w1fwFtF+DDHOBNfzsVgH0lWcEMQSMHkJR9erfKek0vhJ2FA36C
         RyKcTYzWwN4tw==
Message-ID: <4b5b5ce0-e7a0-db7d-f23f-dde4b041f2fe@funlab.cc>
Date:   Sun, 27 Aug 2023 10:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     doka@funlab.cc, "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Netfilter <netfilter-devel@vger.kernel.org>
Subject: Re: [Networking] ERSPAN decapsulation drops DHCP unicast packets
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org
References: <eaf3d0d8-fca2-029e-9c57-ddae31f17726@funlab.cc>
 <ZOqv7E9/Qn2T1GwD@debian.me>
From:   Volodymyr Litovka <doka@funlab.cc>
In-Reply-To: <ZOqv7E9/Qn2T1GwD@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

this tested on:

- 5.19.0-42 on Intel 82599ES 10-Gigabit SFI/SFP+ Network Connection
   -- this is host hardware
- 6.2.0-32 on Virtio network device (under KVM 6.2 on host hardware above)
- 6.5.0-060500rc7 on Virtio network device (under KVM 6.2 on host 
hardware above)

Result is the same for all cases.

Thank you.

On 8/27/23 04:07, Bagas Sanjaya wrote:
> On Sat, Aug 26, 2023 at 09:55:30PM +0200, Volodymyr Litovka wrote:
>> Hi colleagues,
>>
>> I'm trying to catch and process (in 3rd party analytics app) DHCP packets
>> from ERSPAN session, but cannot do this due to absence of DHCP unicast
>> packets after decapsulation.
>>
>> The model is pretty simple: there is PHY interface (enp2s0) which receive
>> ERSPAN traffic and erspan-type interface to get decapsulated packets
>> (inspan, created using command "ip link add inspan type erspan seq key 10
>> local 10.171.165.65 erspan_ver 1", where 10.171.165.65 is ERSPAN target).
>> Then I'm going to rewrite headers in the proper ways (nftable's netdev
>> family) and forward packets to the pool of workers.
>>
>> Having this, I'm expecting everything, which is encapsulated inside ERSPAN,
>> on 'inspan' interface. And there is _almost_ everything except DHCP unicast
>> packets - tcpdump shows about 1kps on this interface of decapsulated
>> packets, but no DHCP unicast (see below traces).
>>
>> To avoid any interactions, I removed and disabled everything that can catch
>> DHCP in userspace - systemd-networkd, netplan, dhcp-client. There is no DHCP
>> server and ifupdown - for test purposes, I'm bringing networking manually.
>> Apparmor disabled as well. Kernel (Linux 5.19.0-42-generic
>> #43~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC) compiled without CONFIG_IP_PNP
>> (according to /boot/config-5.19.0-42-generic). Nothing in userspace listens
>> on UDP/68 and UDP/67:
> Can you reproduce this on latest mainline?
>
>> # netstat -tunlpa
>> Active Internet connections (servers and established)
>> Proto Recv-Q Send-Q Local Address           Foreign Address
>> State       PID/Program name
>> tcp        0      0 0.0.0.0:22 0.0.0.0:*               LISTEN      544/sshd:
>> /usr/sbin
>> tcp6       0      0 :::22 :::*                    LISTEN      544/sshd:
>> /usr/sbin
>>
>> I have no ideas, why this is happening. Decapsulation itself works, but
>> particular kind of packets get lost.
>>
>> I will appreciate if anyone can help me understand where is the bug - in my
>> configuration or somewhere inside the kernel?
>>
>> Evidence of traffic presence/absence is below.
>>
>> Thank you.
>>
>> Encapsulated ERSPAN session (udp and port 67/68) contains lot of different
>> kinds of DHCP packets:
>>
>> # tcpdump -s0 -w- -i enp2s0 'proto gre and ether[73:1]=17 and
>> (ether[84:2]=67 or ether[84:2]=68)' | tshark -r- -l
>>   [ ... ]
>>      7   0.001942  0.0.0.0 → 255.255.255.255 DHCP 392 DHCP Discover -
>> Transaction ID 0x25c096fc
>>      8   0.003432  z.z.z.z → a.a.a.a         DHCP 418 DHCP ACK      -
>> Transaction ID 0x5515126a
>>      9   0.005170  m.m.m.m → z.z.z.z         DHCP 435 DHCP Discover -
>> Transaction ID 0xa7b7
>>     10   0.005171  m.m.m.m → z.z.z.z         DHCP 435 DHCP Discover -
>> Transaction ID 0xa7b7
>>     11   0.015399  n.n.n.n → z.z.z.z         DHCP 690 DHCP Request  -
>> Transaction ID 0x54955233
>>     12   0.025537  z.z.z.z → n.n.n.n         DHCP 420 DHCP ACK      -
>> Transaction ID 0x54955233
>>     13   0.030313  z.z.z.z → m.m.m.m         DHCP 413 DHCP Offer    -
>> Transaction ID 0xa7b7
>>
>> but decapsulated traffic (which I'm seeing on inspan interface) contains
>> just the following:
>>
>> # tcpdump -i inspan 'port 67 or port 68'
>> listening on inspan, link-type EN10MB (Ethernet), snapshot length 262144
>> bytes
>> 17:23:36.540721 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP,
>> Request from 00:1a:64:33:8d:fa (oui Unknown), length 300
>> 17:23:39.760036 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP,
>> Request from 00:1a:64:33:8d:fa (oui Unknown), length 300
>> 17:23:44.135711 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP,
>> Request from 00:1a:64:33:8d:fa (oui Unknown), length 300
>> 17:23:52.008504 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP,
>> Request from 00:1a:64:33:8d:fa (oui Unknown), length 300
>>
> What hardware?
>
-- 
Volodymyr Litovka
   "Vision without Execution is Hallucination." -- Thomas Edison

