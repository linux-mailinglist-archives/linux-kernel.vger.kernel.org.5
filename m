Return-Path: <linux-kernel+bounces-112120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDF48875EC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604CA283855
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDE538F;
	Sat, 23 Mar 2024 00:02:48 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0178F623
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711152168; cv=none; b=oa8jXoikEumm4oN2qSpY34DLremLeQOmE10FLTkeHAX0fijVKm6Mv47gQ66bdHgGFibGH9NYBkfKRONN1f2l8bpJewBbYcGmoUHLBhN4Ui93n1r6vHkxi/kgrNxf6fDc33buz3FAjZBuVHG4/mmDJx/LHf5NVqCwaOP1xOhHPTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711152168; c=relaxed/simple;
	bh=ktuAHPJXuWVXMDzzrOyXAsC9SsVMIHoG6YG0n4ziAQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sz4RzuPIFBTvUULE031hnuCbmFqZXMhajv9EtHdMS2tY1KNywXF7H59d+vYp9uN8wPOOVjgWyDfgAP311LiuRgCkYXq27fX4CHWWG5Vok23Q2fZEI/e+fRdetf/WJbdkRyFJTkcQoorZcpe2X+vX88hwRT2DB1ZWBkHLQiVcGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.21])
	by sina.com (172.16.235.25) with ESMTP
	id 65FE1C1700001705; Sat, 23 Mar 2024 08:02:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 96954634209979
X-SMAIL-UIID: 0B426B5A3FA247B4B995E5C70EBFEA9E-20240323-080233-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [tipc?] BUG: soft lockup in do_sock_setsockopt
Date: Sat, 23 Mar 2024 08:02:23 +0800
Message-Id: <20240323000223.2660-1-hdanton@sina.com>
In-Reply-To: <000000000000bb900e061440909c@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Mar 2024 07:23:18 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114e4c81180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git  for-kernelci

--- x/net/tipc/socket.c
+++ y/net/tipc/socket.c
@@ -2488,6 +2488,11 @@ void tipc_sk_rcv(struct net *net, struct
 	struct tipc_sock *tsk;
 	struct sock *sk;
 	struct sk_buff *skb;
+	static int reent = 0;
+
+	if (reent)
+		return;
+	reent++;
 
 	__skb_queue_head_init(&xmitq);
 	while (skb_queue_len(inputq)) {
@@ -2524,6 +2529,7 @@ xmit:
 		dnode = msg_destnode(buf_msg(skb));
 		tipc_node_xmit_skb(net, skb, dnode, dport);
 	}
+	--reent;
 }
 
 static int tipc_wait_for_connect(struct socket *sock, long *timeo_p)
--

