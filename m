Return-Path: <linux-kernel+bounces-105121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F00087D95B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DCE1C20D57
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD91101D5;
	Sat, 16 Mar 2024 09:00:51 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176EB79F2
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710579651; cv=none; b=T2cO48coD3dyL+EeGuRtvC3vi20zKX1p+4h1WGYfjCJ/FDmCSAfN8yuhi3VQHcqabO7OtRvSg7weEfQXjh9SGBnjXQXtB3qYVRzvKfv0O0zsuiwXrrUwSVSw4N6A19TkvR0V4OozI+BXK+zUtujEFp/aSvhoW1FyaOKYPlEPLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710579651; c=relaxed/simple;
	bh=ZVegiQPS5+8I1ahet6J5rYnfmSyWlCOY352DU1JHyoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTjf60qBTcn9rVo2cpuOStH2UWX85y3/skexLycFyQvKHldyGPulWRjFELAe6IuK80IEynKP8fINFiTWmK0KrIn2iJFWle3Gf900icxivRCHvtTQIZdgcSantGHPcA3HySaKQIeJC/iQr9iYTOJWU92QL2U2fMmP6x4du0aXcts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.117.148])
	by sina.com (172.16.235.24) with ESMTP
	id 65F55FB700006E2C; Sat, 16 Mar 2024 17:00:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1369645089437
X-SMAIL-UIID: E72123976B914BAD87C3CB9453EC155A-20240316-170041-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
Date: Sat, 16 Mar 2024 17:00:30 +0800
Message-Id: <20240316090031.1922-1-hdanton@sina.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

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

