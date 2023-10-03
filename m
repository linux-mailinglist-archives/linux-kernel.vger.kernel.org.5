Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406EC7B64DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbjJCI7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbjJCI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F4EB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696323540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3nmu3krFFKLD3v68LyglQg7qgblXckqiH4dxOfI2bk=;
        b=ZJitK2gpuSMO1DzNomlqTwmOncpzu1kwo2I5zbe+tRzV05X+CyZSCRpDRUTYuFkIgnOfP/
        32JYDIdYCZyNN+xAB1CbAAu1jZrj4oFWluD0OBHrs55helDzdNwycn2NlKAaFPsEKL1tTc
        noo3Xwd0MwOQBCw6hPQLD7q32xx7sEg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-iUJWnKshN2KCtgRyUTlcfA-1; Tue, 03 Oct 2023 04:58:59 -0400
X-MC-Unique: iUJWnKshN2KCtgRyUTlcfA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae56805c41so17130966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696323537; x=1696928337;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3nmu3krFFKLD3v68LyglQg7qgblXckqiH4dxOfI2bk=;
        b=PkP5Dc0564ESqjO3erokvBYI6ndz79fwzwlTDjXbNkRIgVhG5Eh+1bSxRHpU5Utrw7
         ho/nOIXzae3hML3KsjpDGTg4PkKXzEFcL0sUpONp1YaKHNFMH9t4KQ84+gGEH7CFgwF4
         D2EuwEYObgdDPHL+Qbl8TOXmS1oo6TCiW1AFvAp1RNOa88TgUasu7TYxvGELl+QN+HUM
         I7bTVjLnpi1TlZ8kupyS8jPuqE5JSroI6QfD0XaWInqd/DPRSnkxfZg42kPVbBvyERMg
         zkHTSOblo2d9AxTcBQW65bAhOzQZc/Gt6KnUb0Z12+Arv/zD0NzNcgcrh17E488ZHbI0
         6LnQ==
X-Gm-Message-State: AOJu0YwzPvL9Ju05hx1WHA+TgXSeYJknV4KgD2uJKBGkJjb2B5H/rX4U
        eY3Fsmn4CENPi/kIpJ5LJnUqt9A22FVo78kYzyQT4BgoHIAKLhjlRFui7Up0lRKt1Fh3wQpE2Y4
        wxfHfbv+Bn5AfOt7/4j0lXq2K6uNrxxMI
X-Received: by 2002:a17:906:104e:b0:9b2:bf2d:6b66 with SMTP id j14-20020a170906104e00b009b2bf2d6b66mr11343752ejj.7.1696323537100;
        Tue, 03 Oct 2023 01:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOGHxezddx/k9c/xd7a1xIrTtNSX3Kw69ebXCBRbveikheH+aXxzB2h+sVJviiUN7DHVvROw==
X-Received: by 2002:a17:906:104e:b0:9b2:bf2d:6b66 with SMTP id j14-20020a170906104e00b009b2bf2d6b66mr11343741ejj.7.1696323536738;
        Tue, 03 Oct 2023 01:58:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id si13-20020a170906cecd00b009ad850d4760sm690402ejb.219.2023.10.03.01.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:58:56 -0700 (PDT)
Message-ID: <3666c3b4628d6d82ccff593d051706db3896e5af.camel@redhat.com>
Subject: Re: [PATCH] tipc: Fix uninit-value access in
 tipc_nl_node_reset_link_stats()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>, jmaloy@redhat.com,
        ying.xue@windriver.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Date:   Tue, 03 Oct 2023 10:58:54 +0200
In-Reply-To: <20230924060325.3779150-1-syoshida@redhat.com>
References: <20230924060325.3779150-1-syoshida@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-09-24 at 15:03 +0900, Shigeru Yoshida wrote:
> syzbot reported the following uninit-value access issue:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in strlen lib/string.c:418 [inline]
> BUG: KMSAN: uninit-value in strstr+0xb8/0x2f0 lib/string.c:756
>  strlen lib/string.c:418 [inline]
>  strstr+0xb8/0x2f0 lib/string.c:756
>  tipc_nl_node_reset_link_stats+0x3ea/0xb50 net/tipc/node.c:2595
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
>  genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
>  netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
>  genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>  netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
>  netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  sock_sendmsg net/socket.c:753 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
>  __sys_sendmsg net/socket.c:2624 [inline]
>  __do_sys_sendmsg net/socket.c:2633 [inline]
>  __se_sys_sendmsg net/socket.c:2631 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> Uninit was created at:
>  slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
>  slab_alloc_node mm/slub.c:3478 [inline]
>  kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
>  __alloc_skb+0x318/0x740 net/core/skbuff.c:650
>  alloc_skb include/linux/skbuff.h:1286 [inline]
>  netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
>  netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  sock_sendmsg net/socket.c:753 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
>  __sys_sendmsg net/socket.c:2624 [inline]
>  __do_sys_sendmsg net/socket.c:2633 [inline]
>  __se_sys_sendmsg net/socket.c:2631 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> Link names must be null-terminated strings. If a link name which is not
> null-terminated is passed through netlink, strstr() and similar functions
> can cause buffer overrun. This causes the above issue.
>=20
> This patch fixes this issue by returning -EINVAL if a non-null-terminated
> link name is passed.
>=20
> Fixes: ae36342b50a9 ("tipc: add link stat reset to new netlink api")
> Reported-and-tested-by: syzbot+5138ca807af9d2b42574@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D5138ca807af9d2b42574
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/tipc/node.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 3105abe97bb9..f167bdafc034 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -2586,6 +2586,10 @@ int tipc_nl_node_reset_link_stats(struct sk_buff *=
skb, struct genl_info *info)
> =20
>  	link_name =3D nla_data(attrs[TIPC_NLA_LINK_NAME]);
> =20
> +	if (link_name[strnlen(link_name,
> +			      nla_len(attrs[TIPC_NLA_LINK_NAME]))] !=3D '\0')
> +		return -EINVAL;

I have the same comment as for the other tipc patch, please use
nla_strscpy instead, thanks!

Paolo

