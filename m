Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA48813207
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573241AbjLNNqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjLNNqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:46:36 -0500
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C3128;
        Thu, 14 Dec 2023 05:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702561602; x=1734097602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOEVUJq9OoG8R5is92GBHXhyEM+foNZh7lJCCzZq/p8=;
  b=FJSB+xO5KtbyZyKyZfVxN9pFQ00s18Ta4dcMWJSvKq6VDMm+3tSHo713
   iwtHYwty+kiqOlJVrE/ty6Imty1SXrqGBUJiM/2qHDn1otlQ9R5SIOzDr
   TGVoCemJ9QL3rL2RDQmfox+jzykB8rO9GKNrO9+eEcyx7zCcvDGjn70Sy
   E=;
X-IronPort-AV: E=Sophos;i="6.04,275,1695686400"; 
   d="scan'208";a="625228632"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 13:46:40 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
        by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id CD0A61619CB;
        Thu, 14 Dec 2023 13:46:37 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:16235]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 0e3acdb6-9070-4956-aa60-7f5ffd5e720a; Thu, 14 Dec 2023 13:46:36 +0000 (UTC)
X-Farcaster-Flow-ID: 0e3acdb6-9070-4956-aa60-7f5ffd5e720a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 13:46:35 +0000
Received: from 88665a182662.ant.amazon.com (10.143.92.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 13:46:30 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <syoshida@redhat.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <kuniyu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>,
        <syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] net: Return error from sk_stream_wait_connect() if sk_wait_event() fails
Date:   Thu, 14 Dec 2023 22:46:14 +0900
Message-ID: <20231214134615.55389-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214.223106.2284573595890480656.syoshida@redhat.com>
References: <20231214.223106.2284573595890480656.syoshida@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.143.92.5]
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shigeru Yoshida <syoshida@redhat.com>
Date: Thu, 14 Dec 2023 22:31:06 +0900 (JST)
> On Thu, 14 Dec 2023 17:46:22 +0900, Kuniyuki Iwashima wrote:
> > From: Shigeru Yoshida <syoshida@redhat.com>
> > Date: Thu, 14 Dec 2023 14:09:22 +0900
> >> The following NULL pointer dereference issue occurred:
> >> 
> >> BUG: kernel NULL pointer dereference, address: 0000000000000000
> >> <...>
> >> RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
> >> RIP: 0010:dccp_write_xmit+0x49/0x140 net/dccp/output.c:356
> >> <...>
> >> Call Trace:
> >>  <TASK>
> >>  dccp_sendmsg+0x642/0x7e0 net/dccp/proto.c:801
> >>  inet_sendmsg+0x63/0x90 net/ipv4/af_inet.c:846
> >>  sock_sendmsg_nosec net/socket.c:730 [inline]
> >>  __sock_sendmsg+0x83/0xe0 net/socket.c:745
> >>  ____sys_sendmsg+0x443/0x510 net/socket.c:2558
> >>  ___sys_sendmsg+0xe5/0x150 net/socket.c:2612
> >>  __sys_sendmsg+0xa6/0x120 net/socket.c:2641
> >>  __do_sys_sendmsg net/socket.c:2650 [inline]
> >>  __se_sys_sendmsg net/socket.c:2648 [inline]
> >>  __x64_sys_sendmsg+0x45/0x50 net/socket.c:2648
> >>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >>  do_syscall_64+0x43/0x110 arch/x86/entry/common.c:82
> >>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >> 
> >> sk_wait_event() returns an error (-EPIPE) if disconnect() is called on the
> >> socket waiting for the event. However, sk_stream_wait_connect() returns
> >> success, i.e. zero, even if sk_wait_event() returns -EPIPE, so a function
> >> that waits for a connection with sk_stream_wait_connect() may misbehave.
> >> 
> >> In the case of the above DCCP issue, dccp_sendmsg() is waiting for the
> >> connection. If disconnect() is called in concurrently, the above issue
> >> occurs.
> >> 
> >> This patch fixes the issue by returning error from sk_stream_wait_connect()
> >> if sk_wait_event() fails.
> >> 
> >> Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
> >> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > 
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > 
> > I guess you picked this issue from syzbot's report.
> > https://lore.kernel.org/netdev/0000000000009e122006088a2b8d@google.com/
> > 
> > If so, let's give a proper credit to syzbot and its authors:
> > 
> > Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
> 
> Hi Kuniyuki-san,
> 
> Thank you very much for your review. I didn't notice the syzbot's
> report. Actually, I found this issue by running syzkaller on my
> machine.

Thanks for clarifying.

I'm also running syzkaller locally and used to add

  Reported-by: syzbot <syzkaller@googlegroups.com>

But, it was confusing for syzbot's owners, and I got a mail from one of
the authors, Aleksandr Nogikh.  Since then, if syzkaller found an issue
that was not on the syzbot dashboard, I have used

  Reported-by: syzkaller <syzkaller@googlegroups.com>

.  FWIW, here's Aleksandr's words from the mail.

---8<---
Maybe it would be just a little more clear if instead of
Reported-by: syzbot <syzkaller@googlegroups.com>
you'd write
Reported-by: syzkaller <syzkaller@googlegroups.com>
if the bug was found only by a local syzkaller instance, because
otherwise it implies that the bug was found by syzbot, which is not
really the case here :)
---8<---


> 
> Now, I tested this patch with syzbot, and it looks good.
> 
> Reported-and-tested-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com

This time, this tag is best.

Thanks!

