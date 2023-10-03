Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676057B64B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbjJCIx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJCIxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2112AA9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696323185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5s2Ad1cHseKPs9i0UTTN7qGqTWkyboLDzDLOcr/RbuM=;
        b=O+SjTG9YMriRgmzla857CN59GcwELzAdTmks+syI2/XaXYqRrFEnURwCLGcbmootICD3zV
        YEEQAO10NmY9xSakEB2w52mM5cu4rfP5rUjGw6XIIjfxHEIPBpq5Vaqa/hnmMD7XMxpdQF
        c9bs86nOc1mVqW5JHcSyVzIgYM/qFZ0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-0EOsjNtHPhqkKsxK64_rYw-1; Tue, 03 Oct 2023 04:52:54 -0400
X-MC-Unique: 0EOsjNtHPhqkKsxK64_rYw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae56805c41so16984366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696323173; x=1696927973;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5s2Ad1cHseKPs9i0UTTN7qGqTWkyboLDzDLOcr/RbuM=;
        b=AseuYxjDDbJP3+Tdy6Zh/jYjfEOZ1voBGmI6FAazysEXimN9LZENxQSgMqCdHN1rG/
         DQWz63f0ptbkXb66bvFXYhaBGvuoxlsHQFoppvkeS1cK/q6b0qnRF5QkPY2DDXeaU1fe
         1YfbMZxkBlyJNpoEy315Ht3k3abbQ54FUDXRJ6kGS6S7FhpCpVMyprJBt6TXLEZYQkTz
         gfT0JB+SREOCr7RTrFnRBVLT48UdEGeNkg5W1OYMdTRlgPD+WoNCfA2u2g7GwwTkQ1az
         A+RhBrStvHx7bumgiUTrrPBuVn+J2RZZxlXG9npZbKWy7de5CYUpFscX+HaDRKHdceVm
         0jaA==
X-Gm-Message-State: AOJu0YxNRGevGF0o7p3YAdoJZba4EBzbpqDf3/1HnQC0kIcBxu3l7+zz
        4pyS4Ej0lGxpxn8BIXfPfMq4IGda8qPMqxnemTO3kXmAEqZQHBAVgg45uPLc3aOcM6gavlwhrBz
        3g3ezxAvhp6vV7qaig3XylBuI
X-Received: by 2002:a17:906:7389:b0:9b2:71f2:bd11 with SMTP id f9-20020a170906738900b009b271f2bd11mr10668533ejl.4.1696323173073;
        Tue, 03 Oct 2023 01:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkqfkfi05afVVxdCtyKKHjoPbljkyoK7MqPJucy+vrGZC5KK3O16ZcqEvqKNw03xPDeJLvCg==
X-Received: by 2002:a17:906:7389:b0:9b2:71f2:bd11 with SMTP id f9-20020a170906738900b009b271f2bd11mr10668518ejl.4.1696323172716;
        Tue, 03 Oct 2023 01:52:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906449600b0099bcf1c07c6sm687365ejo.138.2023.10.03.01.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:52:51 -0700 (PDT)
Message-ID: <6d5e295b2c22743a44f268363ec28293052e0d2b.camel@redhat.com>
Subject: Re: [PATCH] tipc: Fix uninit-value access in
 __tipc_nl_bearer_enable()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>, jmaloy@redhat.com,
        ying.xue@windriver.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Date:   Tue, 03 Oct 2023 10:52:50 +0200
In-Reply-To: <20230926125120.152133-1-syoshida@redhat.com>
References: <20230926125120.152133-1-syoshida@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-26 at 21:51 +0900, Shigeru Yoshida wrote:
> syzbot reported the following uninit-value access issue:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in strscpy+0xc4/0x160
>  strscpy+0xc4/0x160
>  bearer_name_validate net/tipc/bearer.c:147 [inline]
>  tipc_enable_bearer net/tipc/bearer.c:259 [inline]
>  __tipc_nl_bearer_enable+0x634/0x2220 net/tipc/bearer.c:1043
>  tipc_nl_bearer_enable+0x3c/0x70 net/tipc/bearer.c:1052
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
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2540
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2594
>  __sys_sendmsg net/socket.c:2623 [inline]
>  __do_sys_sendmsg net/socket.c:2632 [inline]
>  __se_sys_sendmsg net/socket.c:2630 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2630
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> Uninit was created at:
>  slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
>  slab_alloc_node mm/slub.c:3478 [inline]
>  kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
>  kmalloc_reserve+0x148/0x470 net/core/skbuff.c:559
>  __alloc_skb+0x318/0x740 net/core/skbuff.c:644
>  alloc_skb include/linux/skbuff.h:1286 [inline]
>  netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
>  netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  sock_sendmsg net/socket.c:753 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2540
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2594
>  __sys_sendmsg net/socket.c:2623 [inline]
>  __do_sys_sendmsg net/socket.c:2632 [inline]
>  __se_sys_sendmsg net/socket.c:2630 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2630
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> Bearer names must be null-terminated strings. If a bearer name which is n=
ot
> null-terminated is passed through netlink, strcpy() and similar functions
> can cause buffer overrun. This causes the above issue.
>=20
> This patch fixes this issue by returning -EINVAL if a non-null-terminated
> bearer name is passed.
>=20
> Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api"=
)
> Reported-and-tested-by: syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D9425c47dccbcb4c17d51
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/tipc/bearer.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
> index 2cde375477e3..62047d20e14d 100644
> --- a/net/tipc/bearer.c
> +++ b/net/tipc/bearer.c
> @@ -1025,6 +1025,10 @@ int __tipc_nl_bearer_enable(struct sk_buff *skb, s=
truct genl_info *info)
> =20
>  	bearer =3D nla_data(attrs[TIPC_NLA_BEARER_NAME]);
> =20
> +	if (bearer[strnlen(bearer,
> +			   nla_len(attrs[TIPC_NLA_BEARER_NAME]))] !=3D '\0')

if 'bearer' is not NULL terminated, the above will access the first
byte after the TIPC_NLA_BEARER_NAME attribute.

I think it would cleaner and safer using nla_strscpy() instead.

Quickly skimming over the tpic code, most TIPC_NLA_BEARER_NAME access
looks unsafe, and possibly a similar fix should be applied in more
places.

Thanks,

Paolo

