Return-Path: <linux-kernel+bounces-132423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362BD8994B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A2E1C22885
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18979224CE;
	Fri,  5 Apr 2024 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v7RFvLW2"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1C12E5B;
	Fri,  5 Apr 2024 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712294937; cv=none; b=b07vktWh+xtFtYawwD7SYAXwlIQ0yfBFcmiCDfsaTf4R0CRM7xs6QbtbIH/xQnxU74R++RhhMeOyN3DYwWdcdKw3Zsbr5dha5WKvEDd+gvb6iLK7J/fq7rkcZQ+/RmfjSq/jHZ9/Ekea8uRrfezIuBSLSBYX7B8KIQp8AU5O3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712294937; c=relaxed/simple;
	bh=2jDrx5TnUP03qST0ipJsr0jECAlWZRf6WLY966I8BBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qh71jKWa+YcQTd8YeeIwL425svPenv5G3ctqBhQu+2yLFMaHH+mJTEW5VZlc6w0bTmXCDhZWoeX2YXH6iaSX/okoMi54USFINCwGthnk9Bhn3vNTaNCDR6PZs6H8fjwWG2kdyAOfaAPuz+sA/9hkkDwmGTbnQz5uZ2AaFgQOZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=v7RFvLW2; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712294935; x=1743830935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BWW2Jf5I/yLrIow5X1Nkd6FWow1Z58dJ6HmB5+6EhQA=;
  b=v7RFvLW2c2tKFgsygB+mRjwCqwaz/196N5PTtaEp4LCQ/G2HXJ8ilREN
   3ElFeRbEcunFN2JtI5ZqvVkmTDKn74DinjqkfbOzlF2MbT0ZdU3PJpG2d
   sx1aGAhqEHLLPm2OFjlc3vdQkFKX+7p8Q6po8+u71AySWi2yicfOZ6Prl
   I=;
X-IronPort-AV: E=Sophos;i="6.07,180,1708387200"; 
   d="scan'208";a="78855516"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 05:28:53 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:31505]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.106:2525] with esmtp (Farcaster)
 id b7d1c686-5f05-4e9e-99da-686457547e3a; Fri, 5 Apr 2024 05:28:53 +0000 (UTC)
X-Farcaster-Flow-ID: b7d1c686-5f05-4e9e-99da-686457547e3a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 5 Apr 2024 05:28:52 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 5 Apr 2024 05:28:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] possible deadlock in unix_del_edges
Date: Thu, 4 Apr 2024 22:28:41 -0700
Message-ID: <20240405052841.97772-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <00000000000083ca480615479e79@google.com>
References: <00000000000083ca480615479e79@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
Date: Thu, 04 Apr 2024 09:13:26 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2b3d5988ae2c Add linux-next specific files for 20240404
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13114d8d180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c48fd2523cdee5e
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f7f201cc2668a8fd169
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113c7103180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1133aaa9180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/136270ed2c7b/disk-2b3d5988.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/466d2f7c1952/vmlinux-2b3d5988.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7dfaf3959891/bzImage-2b3d5988.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com

The boot failure for the previous patch is not related to the patch.
Probably I should've specified the gc commit.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git 4090fa373f0e763c43610853d2774b5979915959

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 61ecfa9c9c6b..d3bf9f49012d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2619,7 +2619,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 				}
 			} else if (!(flags & MSG_PEEK)) {
 				skb_unlink(skb, &sk->sk_receive_queue);
-				consume_skb(skb);
+				WRITE_ONCE(u->oob_skb, NULL);
+				kfree_skb(skb);
+				kfree_skb(skb);
 				skb = skb_peek(&sk->sk_receive_queue);
 			}
 		}

