Return-Path: <linux-kernel+bounces-134337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959CA89B075
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49116280718
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED861CAA4;
	Sun,  7 Apr 2024 10:33:31 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1CF1642B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712486011; cv=none; b=RMyrr5x0UHpOQQE/46hBiPP4wo6hVy8B1l2lrNq5xPT1sRPHX7J0gnbsyP+XP7HFlkfk/YenxN577/Ctu53kub+ubGvq/mmWfHoiFRFbkPr8mLVbVt4h6dSr3QPkxieHEqqCGWLv3SnEVnjiVSfaBtIKnwo6BZgwyWVSMH+VqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712486011; c=relaxed/simple;
	bh=bs9IiglcaewCf9BJhk7XOGqRWAt2/f8DEWXRkNCdAVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PRBU/99sA4ZViw2VhfdzF9wsIYya5i4tIomlkz48P0LXQtOc/W6ffImuP9vJQGwITx7vL6pyPRsWPTvyrAoL8LmXv/MEllgxVCsB9/HPKUcaNKUkfvP8/40Diy3Ym0DGkFyJI/HZCXUq48j1wc/jBejyA6y6ni3YxY0Jbil7XOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.236])
	by sina.com (10.75.12.45) with ESMTP
	id 6612766900006929; Sun, 7 Apr 2024 18:33:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 76270331457761
X-SMAIL-UIID: 9853DABC97404C9CBFC417B5C4699FB4-20240407-183316-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
Date: Sun,  7 Apr 2024 18:33:06 +0800
Message-Id: <20240407103306.1364-1-hdanton@sina.com>
In-Reply-To: <0000000000009c0f98061550a827@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 04 Apr 2024 20:00:30 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16696223180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  fe46a7dd189e

--- x/include/net/net_namespace.h
+++ y/include/net/net_namespace.h
@@ -318,7 +318,7 @@ static inline int check_net(const struct
 	return 1;
 }
 
-#define net_drop_ns NULL
+static void net_drop_ns(void *p) {}
 #endif
 
 
@@ -353,6 +353,7 @@ static inline void __netns_tracker_free(
 static inline struct net *get_net_track(struct net *net,
 					netns_tracker *tracker, gfp_t gfp)
 {
+	refcount_inc(&net->passive);
 	get_net(net);
 	netns_tracker_alloc(net, tracker, gfp);
 	return net;
@@ -362,6 +363,7 @@ static inline void put_net_track(struct
 {
 	__netns_tracker_free(net, tracker, true);
 	put_net(net);
+	net_drop_ns(net);
 }
 
 typedef struct {
--- x/net/netfilter/nf_nat_masquerade.c
+++ y/net/netfilter/nf_nat_masquerade.c
@@ -123,11 +123,12 @@ static void nf_nat_masq_schedule(struct
 		INIT_WORK(&w->work, iterate_cleanup_work);
 		w->ifindex = ifindex;
 		w->net = net;
-		netns_tracker_alloc(net, &w->ns_tracker, gfp_flags);
+		get_net_track(net, &w->ns_tracker, gfp_flags);
 		w->iter = iter;
 		if (addr)
 			w->addr = *addr;
 		schedule_work(&w->work);
+		put_net(net);
 		return;
 	}
 
--

