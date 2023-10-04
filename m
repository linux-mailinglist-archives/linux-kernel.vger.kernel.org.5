Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79EB7B8570
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbjJDQho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjJDQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C39FC0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696437414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGlBt7bTvhe8OpNdjk0WVt8Ei5icwRybJL1TWWQ+z30=;
        b=FWPzHuIcbZJXtfE/BFwM33Ix6+TD5b4/bx//9ye7K/k95G7TnrF3PcXQeDaRZF+LA2CX++
        QhlroGThyYWe0kdCxJVw6EWCHKMkGi+phcZlTdlwl3fzAvZ6FiSYWKQupUXTpMIhdA2eII
        +HXp+btSpoCAZZIzfOX1BbvQVGIagQo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Si5pf1awPzWuOI3AuwbKvQ-1; Wed, 04 Oct 2023 12:36:42 -0400
X-MC-Unique: Si5pf1awPzWuOI3AuwbKvQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c729a25537so19522535ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437401; x=1697042201;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zGlBt7bTvhe8OpNdjk0WVt8Ei5icwRybJL1TWWQ+z30=;
        b=jweN1ehSR10Wodv5qz7FLlPQ0jOdlyRAUW4pizP3VC0DpIhwuH9oR4344C+noO1caK
         KAc+tIucOXPYBlIwLok9hd+aR37+MAyiQhXul0vNYe+dWxrrTDW876cXF6icZ/CC5OjY
         m3t9dNofE3+rTDk+yFQ+1F2wNtQFZFA9b9rAfjX5gCb6O59gva+RDnJp4OFBzrDARrb0
         H8weEgM13o6x08nEU45N0XtEyTzxATZbNXCz9//fjkavTl4siFbie8tsK2H52d4qgCpC
         B+pcg2CVxEK6rX8TGCyv5Xt/BdIHloIMyv8pfDbVZL0ck9T4ebMOOym40AWPO0OCrNIj
         xWgw==
X-Gm-Message-State: AOJu0YxHhdNBJ99zqioToxnizwY0H6UEHo2qiYbeJ9ZdaWLMrq/yCsLG
        7ETspceSWPrUxD52zdVjaRZTIaaMMMLnOkzwe7512GhOJT3DJlhtaBn9Ue4vK9GLcGUulmoW2mF
        nfjgggsHGcIGkszBuz3nLUQhL
X-Received: by 2002:a17:902:e743:b0:1c3:2ee6:380d with SMTP id p3-20020a170902e74300b001c32ee6380dmr3423730plf.48.1696437401273;
        Wed, 04 Oct 2023 09:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5vIPSizNEYIKnPH3bApRyiDFAirVaLfj9Nlk7YIPtPnWKD44MJI1eKF5ILc8nEfm6A9Kovg==
X-Received: by 2002:a17:902:e743:b0:1c3:2ee6:380d with SMTP id p3-20020a170902e74300b001c32ee6380dmr3423710plf.48.1696437400983;
        Wed, 04 Oct 2023 09:36:40 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090322cb00b001c407fac227sm3935842plg.41.2023.10.04.09.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:36:40 -0700 (PDT)
Date:   Thu, 05 Oct 2023 01:36:36 +0900 (JST)
Message-Id: <20231005.013636.556295594018360621.syoshida@redhat.com>
To:     pabeni@redhat.com
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Subject: Re: [PATCH] tipc: Fix uninit-value access in
 __tipc_nl_bearer_enable()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <6d5e295b2c22743a44f268363ec28293052e0d2b.camel@redhat.com>
References: <20230926125120.152133-1-syoshida@redhat.com>
        <6d5e295b2c22743a44f268363ec28293052e0d2b.camel@redhat.com>
X-Mailer: Mew version 6.9 on Emacs 28.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 10:52:50 +0200, Paolo Abeni wrote:
> On Tue, 2023-09-26 at 21:51 +0900, Shigeru Yoshida wrote:
>> syzbot reported the following uninit-value access issue:
>> 
>> =====================================================
>> BUG: KMSAN: uninit-value in strscpy+0xc4/0x160
>>  strscpy+0xc4/0x160
>>  bearer_name_validate net/tipc/bearer.c:147 [inline]
>>  tipc_enable_bearer net/tipc/bearer.c:259 [inline]
>>  __tipc_nl_bearer_enable+0x634/0x2220 net/tipc/bearer.c:1043
>>  tipc_nl_bearer_enable+0x3c/0x70 net/tipc/bearer.c:1052
>>  genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
>>  genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
>>  genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
>>  netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
>>  genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
>>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>>  netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
>>  netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
>>  sock_sendmsg_nosec net/socket.c:730 [inline]
>>  sock_sendmsg net/socket.c:753 [inline]
>>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2540
>>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2594
>>  __sys_sendmsg net/socket.c:2623 [inline]
>>  __do_sys_sendmsg net/socket.c:2632 [inline]
>>  __se_sys_sendmsg net/socket.c:2630 [inline]
>>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2630
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> 
>> Uninit was created at:
>>  slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
>>  slab_alloc_node mm/slub.c:3478 [inline]
>>  kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
>>  kmalloc_reserve+0x148/0x470 net/core/skbuff.c:559
>>  __alloc_skb+0x318/0x740 net/core/skbuff.c:644
>>  alloc_skb include/linux/skbuff.h:1286 [inline]
>>  netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
>>  netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
>>  sock_sendmsg_nosec net/socket.c:730 [inline]
>>  sock_sendmsg net/socket.c:753 [inline]
>>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2540
>>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2594
>>  __sys_sendmsg net/socket.c:2623 [inline]
>>  __do_sys_sendmsg net/socket.c:2632 [inline]
>>  __se_sys_sendmsg net/socket.c:2630 [inline]
>>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2630
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> 
>> Bearer names must be null-terminated strings. If a bearer name which is not
>> null-terminated is passed through netlink, strcpy() and similar functions
>> can cause buffer overrun. This causes the above issue.
>> 
>> This patch fixes this issue by returning -EINVAL if a non-null-terminated
>> bearer name is passed.
>> 
>> Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
>> Reported-and-tested-by: syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=9425c47dccbcb4c17d51
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> ---
>>  net/tipc/bearer.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
>> index 2cde375477e3..62047d20e14d 100644
>> --- a/net/tipc/bearer.c
>> +++ b/net/tipc/bearer.c
>> @@ -1025,6 +1025,10 @@ int __tipc_nl_bearer_enable(struct sk_buff *skb, struct genl_info *info)
>>  
>>  	bearer = nla_data(attrs[TIPC_NLA_BEARER_NAME]);
>>  
>> +	if (bearer[strnlen(bearer,
>> +			   nla_len(attrs[TIPC_NLA_BEARER_NAME]))] != '\0')
> 
> if 'bearer' is not NULL terminated, the above will access the first
> byte after the TIPC_NLA_BEARER_NAME attribute.
> 
> I think it would cleaner and safer using nla_strscpy() instead.

Thank you so much for your comment.  I didn't notice the existence of
nla_strscpy().

> Quickly skimming over the tpic code, most TIPC_NLA_BEARER_NAME access
> looks unsafe, and possibly a similar fix should be applied in more
> places.

I've checked the usage of TIPC_NLA_BEARER_NAME accesses.  These might
cause the same issue, so the same fix should be needed, as you say.

I'll send a v2 patch.

Thanks,
Shigeru

> 
> Thanks,
> 
> Paolo
> 

