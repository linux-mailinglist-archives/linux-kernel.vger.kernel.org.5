Return-Path: <linux-kernel+bounces-151387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370058AADEE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8DE1F220AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E6083A09;
	Fri, 19 Apr 2024 11:54:27 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E666381720
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713527666; cv=none; b=tCw9P67Xe7k1INJeBTMJvS0ECxaaiP/ajyEHkdJCBqs83F5nhJ73WZFdIgz4/dKWtCmkTBeZHGVKG9tLk8HVrAA3+7GBiykBS6zk+YEyDBacJ6UaMs5aX9wUCggvj7f/uS6fhhT1juKUIWlBHrJ1Zo7olilARksuzrVL5jydrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713527666; c=relaxed/simple;
	bh=8vHirs8rA35/8bWtCtEYJFllQ2Aot13NJRR6SdUiE2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpOyD6NvLnveDrLce1rsBlJxIJX5rODjpCu+0Stz/QzPw1Iklp9CK3fX7dCOHQnO/M1lMegsGJJIhSjSEqMnh1LZJYLB3M1EPiatBRt5XsYSzat45vyPmyhEvHLCmrDiL18njVgJueMyp02bdEccmqoyLtdsBS5kWZewOpElKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.253])
	by sina.com (172.16.235.24) with ESMTP
	id 66225B630000135A; Fri, 19 Apr 2024 19:54:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8291945089467
X-SMAIL-UIID: 02C566C14E804937B17EB28983344192-20240419-195413-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_del_edges
Date: Fri, 19 Apr 2024 19:54:10 +0800
Message-Id: <20240419115410.2816-1-hdanton@sina.com>
In-Reply-To: <000000000000c1fa0506166fdcfe@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Apr 2024 02:39:21 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    7b4f2bc91c15 Add linux-next specific files for 20240418
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128b1d53180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  7b4f2bc91c15

--- x/net/unix/garbage.c
+++ y/net/unix/garbage.c
@@ -205,6 +205,7 @@ void unix_add_edges(struct scm_fp_list *
 		edge = fpl->edges + i++;
 		edge->predecessor = inflight;
 		edge->successor = receiver;
+		sock_hold((struct sock *)receiver);
 
 		unix_add_edge(fpl, edge);
 	} while (i < fpl->count_unix);
@@ -225,6 +226,7 @@ void unix_del_edges(struct scm_fp_list *
 {
 	struct unix_sock *receiver;
 	int i = 0;
+	int j;
 
 	spin_lock(&unix_gc_lock);
 
@@ -246,6 +248,12 @@ out:
 	spin_unlock(&unix_gc_lock);
 
 	fpl->inflight = false;
+
+	for (j = 0; j < i; j++) {
+		struct unix_edge *edge = fpl->edges + j;
+
+		sock_put((struct sock *)(edge->successor));
+	}
 }
 
 void unix_update_edges(struct unix_sock *receiver)
--

