Return-Path: <linux-kernel+bounces-28907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE36E830474
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0F9287FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884031DDDA;
	Wed, 17 Jan 2024 11:23:41 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C51DDCB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490621; cv=none; b=qP5NGC788ntPGQkOhJxIInHqU4/D4PGcZilUHi/pXKH2e4WsfAy5omWIwjyaWIetsGIVg9J7NWNmQegNKmuAbXFKph3ymPeaHKDVICDojqvfrUbKlXYAj54+w2Kb3VXbUbAJdjJTGlJI7Hs9IvImglJOLiLqbtd7GJJdy3iY800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490621; c=relaxed/simple;
	bh=EgjVdcaam5yk8DdqPwl3a7MJbD1pZEwtm5sb8iGrc2o=;
	h=X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:X-SMAIL-MID:X-SMAIL-UIID:
	 From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=mk8AXEcVD7gDuUEq+J7K9C4+d/jVDgxgFjdG4kuN4Py97UJaocM57WEknF1vhG09VKiRuIZ1HKwYBwAHC+69XABwYEki0o4SVOeYTz8QzFgzaIFK6UGEgMC3xwYcgkUrPLPtha4BgNpsjvIZ6zPJSw7u5io30lRqs29ufM8fojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.226])
	by sina.com (172.16.235.24) with ESMTP
	id 65A7B8B000002254; Wed, 17 Jan 2024 19:23:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 53875245089160
X-SMAIL-UIID: 7EE77213AAAD48A08006071526C3D3B2-20240117-192330-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Wed, 17 Jan 2024 19:23:18 +0800
Message-Id: <20240117112318.1038-1-hdanton@sina.com>
In-Reply-To: <000000000000498a02060de59162@google.com>
References: <000000000000498a02060de59162@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 01 Jan 2024 09:18:16 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122dfc65e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/ipv4/ipip.c
+++ y/net/ipv4/ipip.c
@@ -277,8 +277,9 @@ static netdev_tx_t ipip_tunnel_xmit(stru
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	const struct iphdr  *tiph = &tunnel->parms.iph;
 	u8 ipproto;
+	int pull_len = tunnel->hlen + sizeof(struct iphdr);
 
-	if (!pskb_inet_may_pull(skb))
+	if (!pskb_network_may_pull(skb, pull_len))
 		goto tx_error;
 
 	switch (skb->protocol) {
--

