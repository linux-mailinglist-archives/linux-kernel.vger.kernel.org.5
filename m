Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37C27FCC71
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjK2BvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2BvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4AD10CB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701222674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLLM+EHuQYt9L5vF7q4+i6iLVhWI2heiCS5DH48CB7I=;
        b=H8xbeaQqtyw25eLQqQ/C4ILXY3FCxsZcKshBEEVnsAF6TMsOCSllvYJFGCjH1rfv+KS+sn
        i5E2ypCGSkX3O6ZDw96trn8fzbaZLvhyAyVip7cJD8uaA6dfFu1y/lkwM4Rk6kYtDCXaEp
        cUL4UEnYstToJUhn4d7E98qXlIC5hvU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-g1yIrysjOxWpCwbiQYJURA-1; Tue, 28 Nov 2023 20:51:11 -0500
X-MC-Unique: g1yIrysjOxWpCwbiQYJURA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cfb96854daso51831025ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701222670; x=1701827470;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cLLM+EHuQYt9L5vF7q4+i6iLVhWI2heiCS5DH48CB7I=;
        b=Zfl+FmssJ8L/sIk3R2fbsUr0ZnlFMgl+PALUJ0TKcO+o9mHQANvyZsR5CaFrXXXXSx
         1s2+EWuSegtvYZYXHuSrKKctRZyBQKYaBxhNbPnYSrmWl2FK0dfwK10hRBtEbuQWgJ9u
         2mauSPLq9UCNGdtto1TfEw8FTEfhGqQRvEzy03mM4LxsW4QeRjxB58GMFgNYsBPQm0jR
         lHTDSusBKcXXU9+zj6nCMNwhSRcfIJXEveakrFdRf9g8PKaw3cwQf9TarRx1EuBkHAdU
         GOV/lw6/pvHn5Ijl60+n0m2vCRjSlDFSmick4W04godGL6kaiI2P+NMAORftNoNW/bbk
         4TTw==
X-Gm-Message-State: AOJu0YyUpoNWC6WG2HOGv5ZoXx/jAeCurcxQ1iRQTBC26nsO7/nbX9CB
        Tqtyt4X1EulMV5dBT+f7ZIwqjRD14fIoShdLNrx90CzlfFTkKhlBgwxMMMJO02IVabEvwDl0sSe
        YFR/3DJSQyi6YkC7mH6M8oSVY
X-Received: by 2002:a17:902:e88a:b0:1cf:cf34:d504 with SMTP id w10-20020a170902e88a00b001cfcf34d504mr10647252plg.36.1701222670714;
        Tue, 28 Nov 2023 17:51:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjcyx3N+DNToUL9Hv4An0WzWRGQGeKo8qG1Mreu4smi9ox2DwD/fiqiB1BZRc1igeaFX+hpA==
X-Received: by 2002:a17:902:e88a:b0:1cf:cf34:d504 with SMTP id w10-20020a170902e88a00b001cfcf34d504mr10647240plg.36.1701222670394;
        Tue, 28 Nov 2023 17:51:10 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:3342:3fe3:7275:954])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903230a00b001cfc44aac0fsm5613445plh.111.2023.11.28.17.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 17:51:09 -0800 (PST)
Date:   Wed, 29 Nov 2023 10:50:46 +0900 (JST)
Message-Id: <20231129.105046.2126277148145584341.syoshida@redhat.com>
To:     willemdebruijn.kernel@gmail.com, edumazet@google.com,
        pabeni@redhat.com
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in
 ipgre_xmit()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <6564bbd5580de_8a1ac29481@willemb.c.googlers.com.notmuch>
References: <20231126151652.372783-1-syoshida@redhat.com>
        <6564bbd5580de_8a1ac29481@willemb.c.googlers.com.notmuch>
X-Mailer: Mew version 6.9 on Emacs 29.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 10:55:01 -0500, Willem de Bruijn wrote:
> Shigeru Yoshida wrote:
>> In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
>> true. For example, applications can create a malformed packet that causes
>> this problem with PF_PACKET.
> 
> It may fail because because pskb_inet_may_pull does not account for
> tunnel->hlen.
> 
> Is that what you are referring to with malformed packet? Can you
> eloborate a bit on in which way the packet has to be malformed to
> reach this?

Thank you very much for your prompt feedback.

Actually, I found this problem by running syzkaller. Syzkaller
reported the following uninit-value issue (I think the root cause of
this issue is the same as the one Eric mentioned):

=====================================================
BUG: KMSAN: uninit-value in __gre_xmit net/ipv4/ip_gre.c:469 [inline]
BUG: KMSAN: uninit-value in ipgre_xmit+0xdf4/0xe70 net/ipv4/ip_gre.c:662
 __gre_xmit net/ipv4/ip_gre.c:469 [inline]
 ipgre_xmit+0xdf4/0xe70 net/ipv4/ip_gre.c:662
 __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
 netdev_start_xmit include/linux/netdevice.h:4932 [inline]
 xmit_one net/core/dev.c:3543 [inline]
 dev_hard_start_xmit+0x24a/0xa10 net/core/dev.c:3559
 __dev_queue_xmit+0x32f6/0x50e0 net/core/dev.c:4344
 dev_queue_xmit include/linux/netdevice.h:3112 [inline]
 packet_xmit+0x8f/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x8c24/0x9aa0 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x717/0xa00 net/socket.c:2194
 __do_sys_sendto net/socket.c:2206 [inline]
 __se_sys_sendto net/socket.c:2202 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2202
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 __gre_xmit net/ipv4/ip_gre.c:469 [inline]
 ipgre_xmit+0xded/0xe70 net/ipv4/ip_gre.c:662
 __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
 netdev_start_xmit include/linux/netdevice.h:4932 [inline]
 xmit_one net/core/dev.c:3543 [inline]
 dev_hard_start_xmit+0x24a/0xa10 net/core/dev.c:3559
 __dev_queue_xmit+0x32f6/0x50e0 net/core/dev.c:4344
 dev_queue_xmit include/linux/netdevice.h:3112 [inline]
 packet_xmit+0x8f/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x8c24/0x9aa0 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x717/0xa00 net/socket.c:2194
 __do_sys_sendto net/socket.c:2206 [inline]
 __se_sys_sendto net/socket.c:2202 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2202
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x103/0x9e0 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5f7/0xb50 mm/slub.c:3523
 kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:560
 pskb_expand_head+0x20b/0x19a0 net/core/skbuff.c:2098
 __skb_cow include/linux/skbuff.h:3586 [inline]
 skb_cow_head include/linux/skbuff.h:3620 [inline]
 ipgre_xmit+0x73c/0xe70 net/ipv4/ip_gre.c:638
 __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
 netdev_start_xmit include/linux/netdevice.h:4932 [inline]
 xmit_one net/core/dev.c:3543 [inline]
 dev_hard_start_xmit+0x24a/0xa10 net/core/dev.c:3559
 __dev_queue_xmit+0x32f6/0x50e0 net/core/dev.c:4344
 dev_queue_xmit include/linux/netdevice.h:3112 [inline]
 packet_xmit+0x8f/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x8c24/0x9aa0 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x717/0xa00 net/socket.c:2194
 __do_sys_sendto net/socket.c:2206 [inline]
 __se_sys_sendto net/socket.c:2202 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2202
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 11318 Comm: syz-executor.7 Not tainted 6.6.0-14500-g1c41041124bd #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
=====================================================

The simplified version of the repro is shown below:

#include <linux/if_ether.h>
#include <sys/ioctl.h>
#include <netinet/ether.h>
#include <net/if.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <linux/if_packet.h>

int main(void)
{
	int s, s1, s2, data = 0;
	struct ifreq ifr;
	struct sockaddr_ll addr = { 0 };
	unsigned char mac_addr[] = {0x1, 0x2, 0x3, 0x4, 0x5, 0x6};

	s = socket(AF_PACKET, SOCK_DGRAM, 0x300);
	s1 = socket(AF_PACKET, SOCK_RAW, 0x300);
	s2 = socket(AF_NETLINK, SOCK_RAW, 0);

	strcpy(ifr.ifr_name, "gre0");
	ioctl(s2, SIOCGIFINDEX, &ifr);

	addr.sll_family = AF_PACKET;
	addr.sll_ifindex = ifr.ifr_ifindex;
	addr.sll_protocol = htons(0);
	addr.sll_hatype = ARPHRD_ETHER;
	addr.sll_pkttype = PACKET_HOST;
	addr.sll_halen = ETH_ALEN;
	memcpy(addr.sll_addr, mac_addr, ETH_ALEN);

	sendto(s1, &data, 1, 0, (struct sockaddr *)&addr, sizeof(addr));

	return 0;
}

The repro sends a 1-byte packet that doesn't have the correct IP
header. I meant this as "malformed pachet", but that might be a bit
confusing, sorry.

I think the cause of the uninit-value access is that ipgre_xmit()
reallocates the skb with skb_cow_head() and copies only the 1-byte
data, so any IP header access through `tnl_params` can cause the
problem.

At first I tried to modify pskb_inet_may_pull() to detect this type of
packet, but I ended up doing this patch.

Any advice is welcome!

Thanks,
Shigeru

> 
> FYI: I had a quick look at the IPv6 equivalent code.
> ip6gre_tunnel_xmit is sufficiently different. It makes sense that this
> is an IPv4 only patch.
> 
>> This patch fixes the problem by dropping skb and returning from the
>> function if skb_pull() fails.
>> 
>> Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> ---
>>  net/ipv4/ip_gre.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
>> index 22a26d1d29a0..95efa97cb84b 100644
>> --- a/net/ipv4/ip_gre.c
>> +++ b/net/ipv4/ip_gre.c
>> @@ -643,7 +643,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
>>  		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
>>  		 * to gre header.
>>  		 */
>> -		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
>> +		if (!skb_pull(skb, tunnel->hlen + sizeof(struct iphdr)))
>> +			goto free_skb;
>>  		skb_reset_mac_header(skb);
>>  
>>  		if (skb->ip_summed == CHECKSUM_PARTIAL &&
>> -- 
>> 2.41.0
>> 
> 
> 

