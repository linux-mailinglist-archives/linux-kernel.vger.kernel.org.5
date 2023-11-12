Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2D27E8F7D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 11:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjKLKZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 05:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 05:25:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D65B2D61
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 02:25:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C12C433C7;
        Sun, 12 Nov 2023 10:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699784723;
        bh=0QkLo9IpYIbHDWyOm+BKqCtxL99jBaY9bKdH4NXtmJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGCaXIxSRxIMnCY6UiUqIg0d1r5hI521GzoIUoSwW8kZJ862Zhzr+j7DcYlgCxU/1
         IUgQ7RuEh7u8V6epkCzBWap/VA1XGRPeZo3H66vmzwzVz2ApYJLaHoy6DZIqnazI6u
         0y1sbg0gXbjxTmImFcAFtAZ5x+hBAtxOJUpCSdgm9FNpQ281sMRZXup3WD2Z3SbPoa
         ZvZKIr1JwLfIFQ9ctq9JaIIASrpDZBLYbXnoeX5F8VRWrTIVS48b3Ne8WZhiAexm/H
         fI4EMnfBEdXLCqlTazld6QX3bTSZ28Y0ZtI623rOLzdinXwyStiVTeoYOhUCTu+eUG
         V4NO1WLJEtUVQ==
Date:   Sun, 12 Nov 2023 10:25:13 +0000
From:   Simon Horman <horms@kernel.org>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: Fix kernel-infoleak due to uninitialized TLV
 value
Message-ID: <20231112102513.GJ705326@kernel.org>
References: <20231110163947.1605168-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110163947.1605168-1-syoshida@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 01:39:47AM +0900, Shigeru Yoshida wrote:
> KMSAN reported the following kernel-infoleak issue:
> 
> =====================================================
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x4ec/0x2bc0 lib/iov_iter.c:186
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  copy_to_user_iter lib/iov_iter.c:24 [inline]
>  iterate_ubuf include/linux/iov_iter.h:29 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
>  iterate_and_advance include/linux/iov_iter.h:271 [inline]
>  _copy_to_iter+0x4ec/0x2bc0 lib/iov_iter.c:186
>  copy_to_iter include/linux/uio.h:197 [inline]
>  simple_copy_to_iter net/core/datagram.c:532 [inline]
>  __skb_datagram_iter.5+0x148/0xe30 net/core/datagram.c:420
>  skb_copy_datagram_iter+0x52/0x210 net/core/datagram.c:546
>  skb_copy_datagram_msg include/linux/skbuff.h:3960 [inline]
>  netlink_recvmsg+0x43d/0x1630 net/netlink/af_netlink.c:1967
>  sock_recvmsg_nosec net/socket.c:1044 [inline]
>  sock_recvmsg net/socket.c:1066 [inline]
>  __sys_recvfrom+0x476/0x860 net/socket.c:2246
>  __do_sys_recvfrom net/socket.c:2264 [inline]
>  __se_sys_recvfrom net/socket.c:2260 [inline]
>  __x64_sys_recvfrom+0x130/0x200 net/socket.c:2260
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Uninit was created at:
>  slab_post_alloc_hook+0x103/0x9e0 mm/slab.h:768
>  slab_alloc_node mm/slub.c:3478 [inline]
>  kmem_cache_alloc_node+0x5f7/0xb50 mm/slub.c:3523
>  kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:560
>  __alloc_skb+0x2fd/0x770 net/core/skbuff.c:651
>  alloc_skb include/linux/skbuff.h:1286 [inline]
>  tipc_tlv_alloc net/tipc/netlink_compat.c:156 [inline]
>  tipc_get_err_tlv+0x90/0x5d0 net/tipc/netlink_compat.c:170
>  tipc_nl_compat_recv+0x1042/0x15d0 net/tipc/netlink_compat.c:1324
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:972 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
>  genl_rcv_msg+0x1220/0x12c0 net/netlink/genetlink.c:1067
>  netlink_rcv_skb+0x4a4/0x6a0 net/netlink/af_netlink.c:2545
>  genl_rcv+0x41/0x60 net/netlink/genetlink.c:1076
>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>  netlink_unicast+0xf4b/0x1230 net/netlink/af_netlink.c:1368
>  netlink_sendmsg+0x1242/0x1420 net/netlink/af_netlink.c:1910
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x997/0xd60 net/socket.c:2588
>  ___sys_sendmsg+0x271/0x3b0 net/socket.c:2642
>  __sys_sendmsg net/socket.c:2671 [inline]
>  __do_sys_sendmsg net/socket.c:2680 [inline]
>  __se_sys_sendmsg net/socket.c:2678 [inline]
>  __x64_sys_sendmsg+0x2fa/0x4a0 net/socket.c:2678
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Bytes 34-35 of 36 are uninitialized
> Memory access of size 36 starts at ffff88802d464a00
> Data copied to user address 00007ff55033c0a0
> 
> CPU: 0 PID: 30322 Comm: syz-executor.0 Not tainted 6.6.0-14500-g1c41041124bd #10
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
> =====================================================
> 
> tipc_add_tlv() puts TLV descriptor and value onto `skb`. This size is
> calculated with TLV_SPACE() macro. It adds the size of struct tlv_desc and
> the length of TLV value passed as an argument, and aligns the result to a
> multiple of TLV_ALIGNTO, i.e., a multiple of 4 bytes.
> 
> If the size of struct tlv_desc plus the length of TLV value is not aligned,
> the current implementation leaves the remaining bytes uninitialized. This
> is the cause of the above kernel-infoleak issue.
> 
> This patch resolves this issue by clearing data up to an aligned size.
> 
> Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Thanks Yoshida-san,

I agree with both your analysis and that the fix is correct.
I also agree that the problem was introduced by the cited commit.

I did wonder if there would be an advantage to only zeroing the
otherwise uninitialised portion of tlv, but I guess that the complexity
isn't worth any gain: all of TLV likely fits into a single cacheline
anyway.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/tipc/netlink_compat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
> index 5bc076f2fa74..c763008a8adb 100644
> --- a/net/tipc/netlink_compat.c
> +++ b/net/tipc/netlink_compat.c
> @@ -102,6 +102,7 @@ static int tipc_add_tlv(struct sk_buff *skb, u16 type, void *data, u16 len)
>  		return -EMSGSIZE;
>  
>  	skb_put(skb, TLV_SPACE(len));
> +	memset(tlv, 0, TLV_SPACE(len));
>  	tlv->tlv_type = htons(type);
>  	tlv->tlv_len = htons(TLV_LENGTH(len));
>  	if (len && data)
> -- 
> 2.41.0
> 
> 
