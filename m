Return-Path: <linux-kernel+bounces-97816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F880876FE0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FF61C20C7D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBE0374FE;
	Sat,  9 Mar 2024 08:45:55 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8A1DA58
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709973954; cv=none; b=uRG8Tzn+3c1HlSN5Anr3E5m0D26GwGrZcehZ1v6QGPguf5OnndAoHmXtmlik0tps1z4n1jCtDWNjZ9QtEITPPQtm2ZmnpUcNXtOwYH61uyp0N+DO1H37QEBv+GO1D3nxjsSubua0V0Kfda2CLsqKZQngxn6yRrq2uBH2pjHhD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709973954; c=relaxed/simple;
	bh=z0vziq730r0rbGxpWWfEs2MxuHCDeJDqpQf7hapyd3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rGZfIxU1bAodXoQM+PPg0jOoAWpU3Dw6q8hBVq8iybiX45PFMTfT9bXf9BSbIkHAAHSfUQYnuCKkybgDd6KJ+xAQhLdZM9wtcd3kaJJrd+DMFvNPF1m31oUBR5f/K6lrP/HGzkDBOGzfXJnPr7O7xJzBKjkY/8E/dhZlgcBoLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.120])
	by sina.com (10.75.12.45) with ESMTP
	id 65EC21B100000E77; Sat, 9 Mar 2024 16:45:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 78475331457290
X-SMAIL-UIID: 1E7A401DEEEE444C935E6B9CC412C67D-20240309-164542-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
Date: Sat,  9 Mar 2024 16:45:27 +0800
Message-Id: <20240309084527.1943-1-hdanton@sina.com>
In-Reply-To: <0000000000008b9c410612fbd266@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 06 Mar 2024 02:57:18 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    805d849d7c3c Merge tag 'acpi-6.8-rc7' of git://git.kernel...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1025fa6a180000

#syz test https://github.com/fbq/linux.git  rcu-exp.2024.01.29b

--- x/drivers/net/ipvlan/ipvlan_core.c
+++ y/drivers/net/ipvlan/ipvlan_core.c
@@ -426,6 +426,7 @@ static noinline_for_stack int ipvlan_pro
 		.daddr = ip4h->daddr,
 		.saddr = ip4h->saddr,
 	};
+	struct sock *sk;
 
 	rt = ip_route_output_flow(net, &fl4, NULL);
 	if (IS_ERR(rt))
@@ -439,7 +440,12 @@ static noinline_for_stack int ipvlan_pro
 
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 
+	sk = skb->sk;
+	if (!sk)
+		goto err;
+	refcount_inc(&sk->sk_wmem_alloc);
 	err = ip_local_out(net, skb->sk, skb);
+	sk_free(sk);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
--

