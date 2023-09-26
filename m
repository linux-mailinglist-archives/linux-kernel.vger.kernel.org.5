Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911AE7AED83
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjIZNAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjIZNAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1461ACCC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695733173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UqxXzmMvP8NFAv3ZN9+oJyNJ16533RmhYaiAN1MoQNI=;
        b=BGjl4YQYduUvQd6v/XeJ2Tnlq/MfJZmulDXB4o/tih/L0tkflO67b8howbuTI6cndsx4oZ
        b4JKolwj4LMyq0FW2f2wdmQNEaepWVy9K5t4SJwiES4bT/uH63+n7JxvdHUFkLfvdw1qmw
        /ngUeLWnGSnERpsmxphvvPst6veQxLY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-vmBtm1IkMb-HuT7pRveWkw-1; Tue, 26 Sep 2023 08:59:31 -0400
X-MC-Unique: vmBtm1IkMb-HuT7pRveWkw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ae377d74b1so12246413b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695733171; x=1696337971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqxXzmMvP8NFAv3ZN9+oJyNJ16533RmhYaiAN1MoQNI=;
        b=vsLSNWs3NqeeBjgze9q++2kRUWOhxjeGc04EI/zPsRbHBPYy2OhOx6k5fyAEEmc6/k
         eCciDH7BGOFRTwLxv31Dcw4FE/q0gKtBz257QV/wLQhIpxHPc+KmCa9AyRxVk3C5kZyQ
         hUojxxre0zMkvCQEH7JWWBfDM3avnXpXAaM84Y6rThssrDX/QHOxE5dabV5WadNYUfkj
         4N2Y5ein+rT4thb7yxNTu+SIufaxUS0aNBTFbm1Te8tMzx5HZ0FvebC93QS8l1k9x3qG
         6sSVqDxlaCmnSd85M5saoBp8GTFNtMqkHkzhN+qemeRttUmz94XUONL8kOsI6t8FxLZo
         Z2uw==
X-Gm-Message-State: AOJu0YyNtXimTpfYABaWeBS1tfwkwAKrG08kt2FELPS9/6WnodrOeIun
        XpHsT0DSfRgS8I5h/nTfm1VYQWAsjaHzybRU5AqCWk9c0J+CVsgnXL2aOE4hX564/r6a0dM4fNJ
        xiYeNZVCKRACqRmoqomcZohVL
X-Received: by 2002:aca:d17:0:b0:3ae:5c14:8686 with SMTP id 23-20020aca0d17000000b003ae5c148686mr579422oin.2.1695733170917;
        Tue, 26 Sep 2023 05:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkwflebs1+GFyASqCe4hFg5FMJnbHZG3/VB40LZYpDYGNgdspzcMuDcuwxht0BuZ+jXyYfEQ==
X-Received: by 2002:aca:d17:0:b0:3ae:5c14:8686 with SMTP id 23-20020aca0d17000000b003ae5c148686mr579404oin.2.1695733170597;
        Tue, 26 Sep 2023 05:59:30 -0700 (PDT)
Received: from ?IPV6:240d:1a:c0d:9f00:f0fd:a9ac:beeb:ad24? ([240d:1a:c0d:9f00:f0fd:a9ac:beeb:ad24])
        by smtp.gmail.com with ESMTPSA id i13-20020aa78d8d000000b00689f8dc26c2sm9875306pfr.133.2023.09.26.05.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 05:59:30 -0700 (PDT)
Message-ID: <f6c4aa78-1ecc-d654-ba3a-23e0ae935e49@redhat.com>
Date:   Tue, 26 Sep 2023 21:59:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tipc: Fix uninit-value access in
 tipc_nl_node_reset_link_stats()
To:     Jon Maloy <jmaloy@redhat.com>
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com,
        ying.xue@windriver.com
References: <20230924060325.3779150-1-syoshida@redhat.com>
 <a9f6e851-5f41-a114-a7f8-493c639c664d@redhat.com>
Content-Language: en-US
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <a9f6e851-5f41-a114-a7f8-493c639c664d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/23 20:19, Jon Maloy wrote:
> 
> 
> On 2023-09-24 02:03, Shigeru Yoshida wrote:
>> syzbot reported the following uninit-value access issue:
>>
>> =====================================================
>> BUG: KMSAN: uninit-value in strlen lib/string.c:418 [inline]
>> BUG: KMSAN: uninit-value in strstr+0xb8/0x2f0 lib/string.c:756
>>   strlen lib/string.c:418 [inline]
>>   strstr+0xb8/0x2f0 lib/string.c:756
>>   tipc_nl_node_reset_link_stats+0x3ea/0xb50 net/tipc/node.c:2595
>>   genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
>>   genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
>>   genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
>>   netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
>>   genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>>   netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
>>   netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
>>   sock_sendmsg_nosec net/socket.c:730 [inline]
>>   sock_sendmsg net/socket.c:753 [inline]
>>   ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
>>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
>>   __sys_sendmsg net/socket.c:2624 [inline]
>>   __do_sys_sendmsg net/socket.c:2633 [inline]
>>   __se_sys_sendmsg net/socket.c:2631 [inline]
>>   __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Uninit was created at:
>>   slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
>>   slab_alloc_node mm/slub.c:3478 [inline]
>>   kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
>>   kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
>>   __alloc_skb+0x318/0x740 net/core/skbuff.c:650
>>   alloc_skb include/linux/skbuff.h:1286 [inline]
>>   netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
>>   netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
>>   sock_sendmsg_nosec net/socket.c:730 [inline]
>>   sock_sendmsg net/socket.c:753 [inline]
>>   ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
>>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
>>   __sys_sendmsg net/socket.c:2624 [inline]
>>   __do_sys_sendmsg net/socket.c:2633 [inline]
>>   __se_sys_sendmsg net/socket.c:2631 [inline]
>>   __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Link names must be null-terminated strings. If a link name which is not
>> null-terminated is passed through netlink, strstr() and similar functions
>> can cause buffer overrun. This causes the above issue.
>>
>> This patch fixes this issue by returning -EINVAL if a non-null-terminated
>> link name is passed.
>>
>> Fixes: ae36342b50a9 ("tipc: add link stat reset to new netlink api")
>> Reported-and-tested-by: syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=5138ca807af9d2b42574
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> ---
>>   net/tipc/node.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/net/tipc/node.c b/net/tipc/node.c
>> index 3105abe97bb9..f167bdafc034 100644
>> --- a/net/tipc/node.c
>> +++ b/net/tipc/node.c
>> @@ -2586,6 +2586,10 @@ int tipc_nl_node_reset_link_stats(struct sk_buff *skb, struct genl_info *info)
>>         link_name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
>>   +    if (link_name[strnlen(link_name,
>> +                  nla_len(attrs[TIPC_NLA_LINK_NAME]))] != '\0')
>> +        return -EINVAL;
>> +
>>       err = -EINVAL;
>>       if (!strcmp(link_name, tipc_bclink_name)) {
>>           err = tipc_bclink_reset_stats(net, tipc_bc_sndlink(net));
> Acked-by: Jon Maloy <jmaloy@redhat.com>

Thanks! syzbot reported very similar issue regarding bearer name too.
I've sent a patch for that issue.

Thanks,
Shigeru 

