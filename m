Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD027DB963
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjJ3MA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3MA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:00:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579D0E1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:00:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso6837671a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698667221; x=1699272021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eD/Hku5WqOIioJLR7k0Stytz0LCcxDS5zuThuxZH3V0=;
        b=OBHjmSKFu05TB83BwUChpVYHYJ4/rhgRXe0sQ0nwZKc2e+fWzRIJYPZigaLmdVZqxL
         78+MIYsQoqnmHX1/ap0x3VRNdUMAYIQkMAHMXD5M+EyGtFJlXxxwEc6OGBiI3LeYquH7
         8iZTigYYHkztWVAF94xR9cOKIQTyu5jaZreMpCbfWJJ1GnR0Zd8SL6+WTcN9NxQKDJ99
         /LDr/pIXHNNxeJIHOk5nGCDSrBcrp979nbsT7WMgyLn8S3gIUdZymsQ5SKoZgmWyxJ9e
         UGYUGumxDfE/ApkYWPu9r+pVDsZ4nXgIcfap5kiN27JqRbiA0nC4zANb3HK1zZiRSTUo
         dj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667221; x=1699272021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eD/Hku5WqOIioJLR7k0Stytz0LCcxDS5zuThuxZH3V0=;
        b=eTHIK4JQNO3Z1u5tWLWClStVpnXwVPXMgdyn3O3b1t20I4Grn4WPeX5prHV1mAoVZi
         vNrRxGAVuz4FpQ8bDtp765RjBxjKvuvCSq6frUlaIgNTe8IYkL5Dggaplb/MlB3Jb8ut
         190EDB9odt17v+wXkHMV5q0huaxc/H9BGzHpVJYMfPktomC+MzGzSPaikIPell6lxjaf
         032H3g7+AsivRjUIVC+OctDAMPQjlXHmBo6JykvpSU5esyj55fEa9yuuRR4YZdY8uaNX
         9oRcWK4yDI2A8QRacRc35VdzWCNCMQxW0ocjLnpwlgawXa0lt/2CjGK9m3H8Xme1wbDj
         Ul2Q==
X-Gm-Message-State: AOJu0Yyk8QCpcWeSnt72FbQSzY2DZMTYW2RCapb8y2j0/dmS4LjIXBj3
        nPmsVo4ECx9M84OVad4HhfMfQw==
X-Google-Smtp-Source: AGHT+IEu6pYcuAdxr8KM6ya/Cfy3+ocS+J14sUsIKB4T8zEWt11CS+7dZS44KS+gjWW9iDuewhT57Q==
X-Received: by 2002:a17:906:fd8c:b0:9c7:5a01:ffea with SMTP id xa12-20020a170906fd8c00b009c75a01ffeamr9315203ejb.30.1698667220758;
        Mon, 30 Oct 2023 05:00:20 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c16-20020a1709060fd000b0098ce63e36e9sm5958410ejk.16.2023.10.30.05.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:00:20 -0700 (PDT)
Date:   Mon, 30 Oct 2023 13:00:18 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com,
        syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] tipc: Change nla_policy for bearer-related names
 to NLA_NUL_STRING
Message-ID: <ZT+a0upR3QjrZJBK@nanopsycho>
References: <20231030075540.3784537-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030075540.3784537-1-syoshida@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Oct 30, 2023 at 08:55:40AM CET, syoshida@redhat.com wrote:
>syzbot reported the following uninit-value access issue [1]:
>
>=====================================================
>BUG: KMSAN: uninit-value in strlen lib/string.c:418 [inline]
>BUG: KMSAN: uninit-value in strstr+0xb8/0x2f0 lib/string.c:756
> strlen lib/string.c:418 [inline]
> strstr+0xb8/0x2f0 lib/string.c:756
> tipc_nl_node_reset_link_stats+0x3ea/0xb50 net/tipc/node.c:2595
> genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
> genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
> genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
> netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
> genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
> netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
> netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
> netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
> sock_sendmsg_nosec net/socket.c:730 [inline]
> sock_sendmsg net/socket.c:753 [inline]
> ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
> ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
> __sys_sendmsg net/socket.c:2624 [inline]
> __do_sys_sendmsg net/socket.c:2633 [inline]
> __se_sys_sendmsg net/socket.c:2631 [inline]
> __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>Uninit was created at:
> slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
> slab_alloc_node mm/slub.c:3478 [inline]
> kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
> kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
> __alloc_skb+0x318/0x740 net/core/skbuff.c:650
> alloc_skb include/linux/skbuff.h:1286 [inline]
> netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
> netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
> sock_sendmsg_nosec net/socket.c:730 [inline]
> sock_sendmsg net/socket.c:753 [inline]
> ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
> ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
> __sys_sendmsg net/socket.c:2624 [inline]
> __do_sys_sendmsg net/socket.c:2633 [inline]
> __se_sys_sendmsg net/socket.c:2631 [inline]
> __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>TIPC bearer-related names including link names must be null-terminated
>strings. If a link name which is not null-terminated is passed through
>netlink, strstr() and similar functions can cause buffer overrun. This
>causes the above issue.
>
>This patch changes the nla_policy for bearer-related names from NLA_STRING
>to NLA_NUL_STRING. This resolves the issue by ensuring that only
>null-terminated strings are accepted as bearer-related names.
>
>syzbot reported similar uninit-value issue related to bearer names [2]. The
>root cause of this issue is that a non-null-terminated bearer name was
>passed. This patch also resolved this issue.
>
>Fixes: 7be57fc69184 ("tipc: add link get/dump to new netlink api")
>Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
>Reported-and-tested-by: syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=5138ca807af9d2b42574 [1]
>Reported-and-tested-by: syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=9425c47dccbcb4c17d51 [2]
>Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
