Return-Path: <linux-kernel+bounces-60293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF278502C6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34AE1C2320E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4013D171B4;
	Sat, 10 Feb 2024 06:41:12 +0000 (UTC)
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23008523D
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707547271; cv=none; b=WIk0pIOfhLrNht0Td84pK7PAqxOur6NcaF9oZWgCfYcUhG8s0ZsT+wOK5xTLJqKZ4LK0c9Ef58y+/Obt2XL8jB5sS9fAZyy/HH0gVcCHEKvO/iugJtGBudkdaa3TCzagVKI9pN/M2D+Jv79Kz+pvoml9HJN6olScQwr5ykD/uBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707547271; c=relaxed/simple;
	bh=PF6UsNOmi14gBI6D6nUNkaU49FCCmW66E0KyUyb4M5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vqnr8aRJyX4ZsDzemlG6Ha8bdrQ+rx2Nso+vK/GadOgR1z+fqdyAL5KIFxslEy8DVQOGdTFGx3nkJtHJsc9tK3zUCgkROvkbAKQvFfMEoRqOMLjpvpAjd7k/vTUraYVQqlcnR8xFZFC7eXRb/s7g9rplfttUnTbCt9IKhwPYKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.22) with ESMTP
	id 65C7193900006691; Sat, 10 Feb 2024 14:35:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8003956816246
X-SMAIL-UIID: BB43EB1B50054A1C83A83152F4EEC708-20240210-143539-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5a630f8ca0120ab43f55@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in __unix_gc
Date: Sat, 10 Feb 2024 14:35:25 +0800
Message-ID: <20240210063527.792-1-hdanton@sina.com>
In-Reply-To: <000000000000ee09930610f42470@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 09 Feb 2024 06:57:17 -0800
> HEAD commit:    e7689879d14e ethtool: do not use rtnl in ethnl_default_dum..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165f9cec180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git  main

--- x/net/unix/garbage.c
+++ y/net/unix/garbage.c
@@ -119,6 +119,7 @@ void unix_inflight(struct user_struct *u
 		if (!u->inflight) {
 			WARN_ON_ONCE(!list_empty(&u->link));
 			list_add_tail(&u->link, &gc_inflight_list);
+			sock_hold(&u->sk);
 		} else {
 			WARN_ON_ONCE(list_empty(&u->link));
 		}
@@ -350,6 +351,11 @@ static void __unix_gc(struct work_struct
 	}
 #endif
 
+	list_for_each_entry_safe(u, next, &gc_candidates, link) {
+		list_del(&u->link);
+		sock_put(&u->sk);
+	}
+
 	spin_lock(&unix_gc_lock);
 
 	/* All candidates should have been detached by now. */
--

