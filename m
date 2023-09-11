Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC1879BA27
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjIKXVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 19:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbjIKVV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 17:21:56 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD8A55AD;
        Mon, 11 Sep 2023 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694466273; x=1726002273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X3Q27kYNxWNQTn1CHGttQYeD3rLuSlY5VQ5jO9+lUSQ=;
  b=lr7OksrvojYxwCqYHdxXX+vtfjRv8TRUmHURVI2lVxVUC3ka4a27drmq
   YcntTD6nORF5jaFpp3MYjceRjztsBnmg0R5qsIN/Ihk8y+vwPYc2FLB01
   /CIxihh4FOprscPdxQBtZ7tEUetoP1B2BKSKwwIt0IDemz6Chm2rjCP3q
   c=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="238024874"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 21:03:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id D9739A0A28;
        Mon, 11 Sep 2023 21:03:39 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 21:03:39 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Mon, 11 Sep 2023 21:03:36 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <syoshida@redhat.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>,
        <syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com>
Subject: Re: [PATCH net v2] kcm: Fix memory leak in error path of kcm_sendmsg()
Date:   Mon, 11 Sep 2023 14:03:28 -0700
Message-ID: <20230911210328.87174-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230909170310.1978851-1-syoshida@redhat.com>
References: <20230909170310.1978851-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shigeru Yoshida <syoshida@redhat.com>
Date: Sun, 10 Sep 2023 02:03:10 +0900
> syzbot reported a memory leak like below:
> 
> BUG: memory leak
> unreferenced object 0xffff88810b088c00 (size 240):
>   comm "syz-executor186", pid 5012, jiffies 4294943306 (age 13.680s)
>   hex dump (first 32 bytes):
>     00 89 08 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff83e5d5ff>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:634
>     [<ffffffff84606e59>] alloc_skb include/linux/skbuff.h:1289 [inline]
>     [<ffffffff84606e59>] kcm_sendmsg+0x269/0x1050 net/kcm/kcmsock.c:815
>     [<ffffffff83e479c6>] sock_sendmsg_nosec net/socket.c:725 [inline]
>     [<ffffffff83e479c6>] sock_sendmsg+0x56/0xb0 net/socket.c:748
>     [<ffffffff83e47f55>] ____sys_sendmsg+0x365/0x470 net/socket.c:2494
>     [<ffffffff83e4c389>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2548
>     [<ffffffff83e4c536>] __sys_sendmsg+0xa6/0x120 net/socket.c:2577
>     [<ffffffff84ad7bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84ad7bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> In kcm_sendmsg(), kcm_tx_msg(head)->last_skb is used as a cursor to append
> newly allocated skbs to 'head'. If some bytes are copied, an error occurred,
> and jumped to out_error label, 'last_skb' is left unmodified. A later
> kcm_sendmsg() will use an obsoleted 'last_skb' reference, corrupting the
> 'head' frag_list and causing the leak.
> 
> This patch fixes this issue by properly updating the last allocated skb in
> 'last_skb'.
> 
> Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
> Reported-and-tested-by: syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6f98de741f7dbbfc4ccb
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
> v1->v2:
> - Update the commit message to include more detailed root cause. 
> ---
>  net/kcm/kcmsock.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index 393f01b2a7e6..34d4062f639a 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -939,6 +939,8 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  
>  	if (head != kcm->seq_skb)
>  		kfree_skb(head);
> +	else if (copied)
> +		kcm_tx_msg(head)->last_skb = skb;
>

Sorry for being late, but this seems wrong to me.

I think we should purge the queue as we do so for UDP by
udp_flush_pending_frames(); otherwise, even when we get an
error, there could be some data appended to the tail of the
buffer and we cannot know how many bytes it is.

I'll send the following patch:

---8<---
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 740539a218b7..fb27ca675acb 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -937,10 +937,8 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		goto partial_message;
 	}
 
-	if (head != kcm->seq_skb)
-		kfree_skb(head);
-	else if (copied)
-		kcm_tx_msg(head)->last_skb = skb;
+	kfree_skb(head);
+	kcm->seq_skb = NULL;
 
 	err = sk_stream_error(sk, msg->msg_flags, err);
 
---8<---
