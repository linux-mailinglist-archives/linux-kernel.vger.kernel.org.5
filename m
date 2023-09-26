Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830327AEB57
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjIZLUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZLUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DCA194
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695727164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0Iyp1Fl1NBtWSyLWXxoQnKzRIJwB/IjhW80zLNFEwM=;
        b=J9ITmEWyakF7F0hsE2pfXMZwYuxIAxm9Co5xu/CwFdxB4W2OyqVnL8cj1Aa+/KuavU5Wvk
        w9uBFXLLsgNn0gcRTQ0dVwJYM9A9A0bQivePw6RXtBjjAYcgvX82qXudpme1+29C5oV/VH
        k0PIZLU817X5DfkqW6ZKgaa4XoeO5oA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-8cfco_i4O8KB2y1Oz2CqZw-1; Tue, 26 Sep 2023 07:19:22 -0400
X-MC-Unique: 8cfco_i4O8KB2y1Oz2CqZw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-59c0327b75dso153288127b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727162; x=1696331962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0Iyp1Fl1NBtWSyLWXxoQnKzRIJwB/IjhW80zLNFEwM=;
        b=DmrvPQGq6nM1izn/tBjEOyxF8C99UTsCDyAcv42aU+OGOc3S+0meNQGwFQCWCYeKUA
         paFl3AiGDOB8uuyMqZs1WYRP4ffgeFRqKfsaiXhJnAi60U9y7Ba6FKHw6V+wwI2/NDTP
         9XUa9EVH4lfiK1nhYB16B0t/f3h1FygV2e82o8xszlvsj/jcuSd8tKNDnYg9REGbXsj0
         a0DTEoxa/uRKqr8QGU7GZRiAyHChJ0D+VtYBmGxKfhhfojTcSzb8alMkZPseAXO7e+zc
         BmOWyGgJXzS3WH5Ts/6NKFC2/99emeYrdXD7qUmR65HwAUjO6DE4KMmCvtq1PN3Qk1Ll
         EKNQ==
X-Gm-Message-State: AOJu0YyUa97prSs5D4IE5fXr4azQrIyHu/3BmZcKrUVS+kuRYpmSOikc
        9F9Hkg+wV8ymQJRvjQ+4VKXk6PSc2TmHs38JPvMdu9h7przfumHLQO+my0NxaztTtBvOuhkSqVW
        9DvO3XC84Za312JDA/iiMiat4xisokJ0k
X-Received: by 2002:a0d:ce07:0:b0:59b:1f6d:1958 with SMTP id q7-20020a0dce07000000b0059b1f6d1958mr8255450ywd.46.1695727162233;
        Tue, 26 Sep 2023 04:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEErMMOQnWajQcblaBvwvLcA3K0dGeREYTIb/E0Vgm3POYB6pB5b9/qc0fjxmCGqtU+lkGmaw==
X-Received: by 2002:a0d:ce07:0:b0:59b:1f6d:1958 with SMTP id q7-20020a0dce07000000b0059b1f6d1958mr8255441ywd.46.1695727161946;
        Tue, 26 Sep 2023 04:19:21 -0700 (PDT)
Received: from [10.0.0.97] ([24.225.234.80])
        by smtp.gmail.com with ESMTPSA id l5-20020a37f505000000b0076f21383b6csm4607490qkk.112.2023.09.26.04.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 04:19:21 -0700 (PDT)
Message-ID: <a9f6e851-5f41-a114-a7f8-493c639c664d@redhat.com>
Date:   Tue, 26 Sep 2023 07:19:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tipc: Fix uninit-value access in
 tipc_nl_node_reset_link_stats()
Content-Language: en-US
To:     Shigeru Yoshida <syoshida@redhat.com>, ying.xue@windriver.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
References: <20230924060325.3779150-1-syoshida@redhat.com>
From:   Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <20230924060325.3779150-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-24 02:03, Shigeru Yoshida wrote:
> syzbot reported the following uninit-value access issue:
>
> =====================================================
> BUG: KMSAN: uninit-value in strlen lib/string.c:418 [inline]
> BUG: KMSAN: uninit-value in strstr+0xb8/0x2f0 lib/string.c:756
>   strlen lib/string.c:418 [inline]
>   strstr+0xb8/0x2f0 lib/string.c:756
>   tipc_nl_node_reset_link_stats+0x3ea/0xb50 net/tipc/node.c:2595
>   genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
>   genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
>   genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
>   netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
>   genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
>   netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>   netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
>   netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   sock_sendmsg net/socket.c:753 [inline]
>   ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
>   __sys_sendmsg net/socket.c:2624 [inline]
>   __do_sys_sendmsg net/socket.c:2633 [inline]
>   __se_sys_sendmsg net/socket.c:2631 [inline]
>   __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Uninit was created at:
>   slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
>   slab_alloc_node mm/slub.c:3478 [inline]
>   kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
>   kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
>   __alloc_skb+0x318/0x740 net/core/skbuff.c:650
>   alloc_skb include/linux/skbuff.h:1286 [inline]
>   netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
>   netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   sock_sendmsg net/socket.c:753 [inline]
>   ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
>   __sys_sendmsg net/socket.c:2624 [inline]
>   __do_sys_sendmsg net/socket.c:2633 [inline]
>   __se_sys_sendmsg net/socket.c:2631 [inline]
>   __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Link names must be null-terminated strings. If a link name which is not
> null-terminated is passed through netlink, strstr() and similar functions
> can cause buffer overrun. This causes the above issue.
>
> This patch fixes this issue by returning -EINVAL if a non-null-terminated
> link name is passed.
>
> Fixes: ae36342b50a9 ("tipc: add link stat reset to new netlink api")
> Reported-and-tested-by: syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5138ca807af9d2b42574
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>   net/tipc/node.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 3105abe97bb9..f167bdafc034 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -2586,6 +2586,10 @@ int tipc_nl_node_reset_link_stats(struct sk_buff *skb, struct genl_info *info)
>   
>   	link_name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
>   
> +	if (link_name[strnlen(link_name,
> +			      nla_len(attrs[TIPC_NLA_LINK_NAME]))] != '\0')
> +		return -EINVAL;
> +
>   	err = -EINVAL;
>   	if (!strcmp(link_name, tipc_bclink_name)) {
>   		err = tipc_bclink_reset_stats(net, tipc_bc_sndlink(net));
Acked-by: Jon Maloy <jmaloy@redhat.com>

