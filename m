Return-Path: <linux-kernel+bounces-96871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD87876270
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17AC1C21239
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEDD5577A;
	Fri,  8 Mar 2024 10:51:22 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D7853E01
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895082; cv=none; b=AFKtxap2SWZMo5sGbHSYSnwJ0Yh8uu6VUzmElBPbQJW9fMNvXE8eMcP1p5Dsv2TtN44quH8enCXoqEzLVYdyIRRBs0/CSKwNfUjSp1vt8UdmQtzUZOHBrErmSc0giHVXvfbpBr+mzaRFnPgDfNdbySb+cmKfEja6bB4+kFKTAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895082; c=relaxed/simple;
	bh=HKKmwPokzeOnsazasyJ4qqi+8LB9VrLZUir14E9dx+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWjHigI2jrjLinYyXPipRh7/98Aftotp42GRRkXbXuNbHCDNcHsKsALkzzySXH6J6TD+cdq1qcOnH5iEfl5MSzJfbpFf+Xo2Ii2JgTmcbU0lhcpog0gaQtaHEHRniV5+A7upcJl5/3VzsYI7srifV1uDcfBzmSix//v1e1rgrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.186])
	by sina.com (10.75.12.45) with ESMTP
	id 65EAED9900006EA2; Fri, 8 Mar 2024 18:51:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7857831457937
X-SMAIL-UIID: 91E987F7BEFC43AB890708690BA6036D-20240308-185108-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
Date: Fri,  8 Mar 2024 18:50:58 +0800
Message-Id: <20240308105058.1649-1-hdanton@sina.com>
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
@@ -439,7 +440,10 @@ static noinline_for_stack int ipvlan_pro
 
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 
+	sk = skb->sk;
+	refcount_inc(&sk->sk_wmem_alloc);
 	err = ip_local_out(net, skb->sk, skb);
+	sk_free(sk);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
--

