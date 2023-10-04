Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB97B8582
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243443AbjJDQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243450AbjJDQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF8C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696437555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YIAoi2N6jKSNdTGNnxQ4r70nxai8Q1Dqlauk6QORHI=;
        b=e/lwVFgJ46ZIXoqVUUExJ+TnCFp5b1qefIF7hPTTUa/uuZjsQXlRhqDvs0f2S9GIwYrMco
        kY/VsbrBQh9POvI4SGD34vMvRH4xJ2zCzfJ61vF9ycC9K3ABz6l4Kp0yzePgt091hxChC+
        9K3yda03zTPuufhBgxOT+eoN2XH8y7Q=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-rw0IxPkyPWCDwbrSWc7Siw-1; Wed, 04 Oct 2023 12:39:14 -0400
X-MC-Unique: rw0IxPkyPWCDwbrSWc7Siw-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35143053d55so70565ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437553; x=1697042353;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9YIAoi2N6jKSNdTGNnxQ4r70nxai8Q1Dqlauk6QORHI=;
        b=E8WjJJwn0VyigPbm92JXuKVXHQIzCnI+oCxDsz4ZiPoeR2GfLQlfMciQyeG4icLufj
         OoOuyIvkYN+vYRd6A8DmeWKBZaeakhRduLgr7OOBa3bQsN/EpKjh6UHtw1K/Vh6HyFFX
         dXFMUKNxJhy2VDvqm+R8rWrzzOf4u2xNSAbYJhjh0E3ptyQUGcR5X9gzpBO2pJ9hzJNh
         FXRNfDi4dZoaurAJsnukk6Igncr/QLEoJinrhIfnJXx7huPk3Ro65EKRTLZbDh5176na
         Zk1ahy25t5sST+hWI0EkFFFTHuRUZIsorpkWMFfiIFyuKCdVth3Dme716Weav5hbAUMC
         Q4tQ==
X-Gm-Message-State: AOJu0Yz1DnkCHp5B1S03u0owVkgXo8UXFCldIq8aXz98DhMH3lhcznQN
        g3oCwEPYJd6s8fUGp7cNwz7wSJhfZ+DE0cIZQXgowxl4MDNnlF/xUq8N38Sct6f1/QOatTLiwM+
        sV3BsD6Qv7a9CIlUwdFvwCdNbf1iCasOMOB4=
X-Received: by 2002:a05:6e02:164f:b0:351:57d5:51bb with SMTP id v15-20020a056e02164f00b0035157d551bbmr3716949ilu.16.1696437553514;
        Wed, 04 Oct 2023 09:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFytBl337LJl7fnH1tEMNvTVvdRyzepj/SY9LKBkr/2JIKcfKvUBQL/k9u0YI41kDHAabFHUw==
X-Received: by 2002:a05:6e02:164f:b0:351:57d5:51bb with SMTP id v15-20020a056e02164f00b0035157d551bbmr3716932ilu.16.1696437553292;
        Wed, 04 Oct 2023 09:39:13 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id m19-20020a638c13000000b0057411f9a516sm3584673pgd.7.2023.10.04.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:39:12 -0700 (PDT)
Date:   Thu, 05 Oct 2023 01:39:09 +0900 (JST)
Message-Id: <20231005.013909.1713937955475096940.syoshida@redhat.com>
To:     jmaloy@redhat.com, pabeni@redhat.com
Cc:     ying.xue@windriver.com, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Subject: Re: [PATCH] tipc: Fix uninit-value access in
 tipc_nl_node_reset_link_stats()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <3666c3b4628d6d82ccff593d051706db3896e5af.camel@redhat.com>
References: <20230924060325.3779150-1-syoshida@redhat.com>
        <3666c3b4628d6d82ccff593d051706db3896e5af.camel@redhat.com>
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

On Tue, 03 Oct 2023 10:58:54 +0200, Paolo Abeni wrote:
> On Sun, 2023-09-24 at 15:03 +0900, Shigeru Yoshida wrote:
>> syzbot reported the following uninit-value access issue:
>> 
>> =====================================================
>> BUG: KMSAN: uninit-value in strlen lib/string.c:418 [inline]
>> BUG: KMSAN: uninit-value in strstr+0xb8/0x2f0 lib/string.c:756
>>  strlen lib/string.c:418 [inline]
>>  strstr+0xb8/0x2f0 lib/string.c:756
>>  tipc_nl_node_reset_link_stats+0x3ea/0xb50 net/tipc/node.c:2595
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
>>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
>>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
>>  __sys_sendmsg net/socket.c:2624 [inline]
>>  __do_sys_sendmsg net/socket.c:2633 [inline]
>>  __se_sys_sendmsg net/socket.c:2631 [inline]
>>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> 
>> Uninit was created at:
>>  slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
>>  slab_alloc_node mm/slub.c:3478 [inline]
>>  kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
>>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
>>  __alloc_skb+0x318/0x740 net/core/skbuff.c:650
>>  alloc_skb include/linux/skbuff.h:1286 [inline]
>>  netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
>>  netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
>>  sock_sendmsg_nosec net/socket.c:730 [inline]
>>  sock_sendmsg net/socket.c:753 [inline]
>>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
>>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
>>  __sys_sendmsg net/socket.c:2624 [inline]
>>  __do_sys_sendmsg net/socket.c:2633 [inline]
>>  __se_sys_sendmsg net/socket.c:2631 [inline]
>>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
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
>>  net/tipc/node.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/net/tipc/node.c b/net/tipc/node.c
>> index 3105abe97bb9..f167bdafc034 100644
>> --- a/net/tipc/node.c
>> +++ b/net/tipc/node.c
>> @@ -2586,6 +2586,10 @@ int tipc_nl_node_reset_link_stats(struct sk_buff *skb, struct genl_info *info)
>>  
>>  	link_name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
>>  
>> +	if (link_name[strnlen(link_name,
>> +			      nla_len(attrs[TIPC_NLA_LINK_NAME]))] != '\0')
>> +		return -EINVAL;
> 
> I have the same comment as for the other tipc patch, please use
> nla_strscpy instead, thanks!

Thank you for your comment.  I'll send a v2 patch using nla_strscpy()
and check if other usage of TIPC_NLA_LINK_NAME have the same issue.

Thanks,
Shigeru

> 
> Paolo
> 

