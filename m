Return-Path: <linux-kernel+bounces-96990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED276876421
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3351C210A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD5B5675D;
	Fri,  8 Mar 2024 12:16:24 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED356756
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900184; cv=none; b=Z10sUZK8XnKsYx7mmoZkRAcuy1w8CEgZEGSI0RxPYdUV3GVMe3HwHAmsIbsHsWyzGTyuo9QRSmsmUTxkOi+74XsEtpuYHaP90MJkv+Ym2Z3+3wkLgbQxGQH+rWirFdjHQyLzhYUkZaR4jW1Iik3/tc3pSw5ixTjMXuRtRjt4OwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900184; c=relaxed/simple;
	bh=2QGSRu7BUzleeEDO/yhReetdaBO6XLLG2HCqyTrLhi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxeFJD6acOPWj4ub6q4kHlh9r2pjKCYE0F6pGIDicLExXbj/wIPZw8DUAGwvQHHP7MPLshFprjNu90ORi9xNVhLmwv6E7I/hPRppZhwAgjaUG8nPKNRQqBg4/hDmClHmLmfS7Ph1zzrJhSgH933/W5Rqt38oY9usaLlzuG8h+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.223])
	by sina.com (172.16.235.25) with ESMTP
	id 65EB018600000EC6; Fri, 8 Mar 2024 20:16:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 94914634210400
X-SMAIL-UIID: 278DBD6DEDDD43C9AC93399E2BB7018B-20240308-201612-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
Date: Fri,  8 Mar 2024 20:15:58 +0800
Message-Id: <20240308121558.1773-1-hdanton@sina.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

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

