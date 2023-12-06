Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF18063AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376359AbjLFAyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376332AbjLFAyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:54:10 -0500
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCEBC6;
        Tue,  5 Dec 2023 16:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701824057; x=1733360057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+toNEd6sJyTVAzItwkGE2GFEaCVIxst9NVhvx21Yx0=;
  b=tf3em3NZa1AtnRxMS7Uzh9OgtdlXjoDEhUJojrD4JBhVs42czDX6BV4a
   aru8MijSi280D+pCtqcMedD1NzlrW6JiSeWqhtaRaN2Hi8C2JDzShAvKh
   J9x/DtXV7FRJYVdx2CNU9qxmsS0JFATksWskzdXLTMuL+y2qLnY/nk/0P
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,253,1695686400"; 
   d="scan'208";a="620027210"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:54:15 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id 0EFEF10475D;
        Wed,  6 Dec 2023 00:54:11 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:36668]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.101:2525] with esmtp (Farcaster)
 id 915ed644-9b82-4c55-925c-77a86dfa36d9; Wed, 6 Dec 2023 00:54:11 +0000 (UTC)
X-Farcaster-Flow-ID: 915ed644-9b82-4c55-925c-77a86dfa36d9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 00:54:11 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.13.242) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 00:54:05 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>,
        <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
Date:   Wed, 6 Dec 2023 09:53:40 +0900
Message-ID: <20231206005340.11534-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0000000000001b9bed060bc75cbc@google.com>
References: <0000000000001b9bed060bc75cbc@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.13.242]
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
Date: Tue, 05 Dec 2023 10:25:31 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1c41041124bd Merge tag 'i3c/for-6.7' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10429eeb680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=956549bd1d1e9efd
> dashboard link: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b6a00f680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121471ef680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/20fd86e677f1/disk-1c410411.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ccd39cb0b7b6/vmlinux-1c410411.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/156fc60f97bc/bzImage-1c410411.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com
> 
> syz-executor994 uses obsolete (PF_INET,SOCK_PACKET)
> =====================================================
> BUG: KMSAN: uninit-value in __llc_lookup_established+0xe9d/0xf90
>  __llc_lookup_established+0xe9d/0xf90
>  __llc_lookup net/llc/llc_conn.c:611 [inline]
>  llc_conn_handler+0x4bd/0x1360 net/llc/llc_conn.c:791
>  llc_rcv+0xfbb/0x14a0 net/llc/llc_input.c:206
>  __netif_receive_skb_one_core net/core/dev.c:5527 [inline]
>  __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5641
>  netif_receive_skb_internal net/core/dev.c:5727 [inline]
>  netif_receive_skb+0x58/0x660 net/core/dev.c:5786
>  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
>  tun_get_user+0x53af/0x66d0 drivers/net/tun.c:2002
>  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
>  call_write_iter include/linux/fs.h:2020 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x8ef/0x1490 fs/read_write.c:584
>  ksys_write+0x20f/0x4c0 fs/read_write.c:637
>  __do_sys_write fs/read_write.c:649 [inline]
>  __se_sys_write fs/read_write.c:646 [inline]
>  __x64_sys_write+0x93/0xd0 fs/read_write.c:646
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Local variable daddr created at:
>  llc_conn_handler+0x53/0x1360 net/llc/llc_conn.c:783
>  llc_rcv+0xfbb/0x14a0 net/llc/llc_input.c:206
> 
> CPU: 1 PID: 5004 Comm: syz-executor994 Not tainted 6.6.0-syzkaller-14500-g1c41041124bd #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
> =====================================================

llc_pdu_decode_[sd]a() initialises addr.mac only for ETH_P_802_2.
Otherwise, llc_estab_match() reads an uninit value form both [sd]addr.

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1c41041124bd

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 0a3f5e0bec00..730561e186ce 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -780,7 +780,7 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 
 void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 {
-	struct llc_addr saddr, daddr;
+	struct llc_addr saddr = {}, daddr = {};
 	struct sock *sk;
 
 	llc_pdu_decode_sa(skb, saddr.mac);
