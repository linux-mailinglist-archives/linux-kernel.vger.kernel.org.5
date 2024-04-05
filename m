Return-Path: <linux-kernel+bounces-132482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CFC89959A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522F91C21619
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D419121A19;
	Fri,  5 Apr 2024 06:38:20 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2DE14288
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299100; cv=none; b=fdfnd9ud73qvlyjrfZ/0Wx1iG2ute8oky33O32Lv7XOCq9eYJGfFGMMHBXpKZsMRiyI6iULMmEe64sOsMu6m+TmkiKyQfaa/yu9egWQOXdmpAxoZ++zTA5VbJ73JWrkWwmKmzIKs11tTCn81tdCnX5qSsuLkRzKOxtws/Sr12G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299100; c=relaxed/simple;
	bh=oNymYZovpHKQUVHHNR3z7XBkT03f7VT+VWP2ziykCAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGml/PBTeA3B5OGrQKzcc35jErq4T8durdqmDwgcP6KdsL3FVC7rMNi/nb4d2E8Crb2ZUMDAOTzaVhROqbnICmIC0gB1c/NgXjA8CKMlshmz2378ANKdldPlE+PRWtDiS9J+nQuTw38iT3+t/GsDtVqwGzhsm/25RdJhCrOD1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.172])
	by sina.com (172.16.235.25) with ESMTP
	id 660F9C4800007FB4; Fri, 5 Apr 2024 14:38:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 80760834210454
X-SMAIL-UIID: 68458447AD4142DEA3B716A34E1E1B00-20240405-143803-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
Date: Fri,  5 Apr 2024 14:37:51 +0800
Message-Id: <20240405063751.835-1-hdanton@sina.com>
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
 
 
@@ -353,7 +353,7 @@ static inline void __netns_tracker_free(
 static inline struct net *get_net_track(struct net *net,
 					netns_tracker *tracker, gfp_t gfp)
 {
-	get_net(net);
+	refcount_inc(&net->passive);
 	netns_tracker_alloc(net, tracker, gfp);
 	return net;
 }
@@ -361,7 +361,7 @@ static inline struct net *get_net_track(
 static inline void put_net_track(struct net *net, netns_tracker *tracker)
 {
 	__netns_tracker_free(net, tracker, true);
-	put_net(net);
+	net_drop_ns(net);
 }
 
 typedef struct {
--

