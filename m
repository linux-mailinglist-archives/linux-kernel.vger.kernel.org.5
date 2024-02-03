Return-Path: <linux-kernel+bounces-50930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EDC8483E6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 06:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C6C288D82
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2CA10A1D;
	Sat,  3 Feb 2024 05:11:17 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C610A0E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 05:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706937077; cv=none; b=oRrMpdhif5OEMbGXKDjJ+ed0ZAc68lekak9fvUFaYf7lT66CybooCJ4LQQOe+MBoWKWOP7jRH6JV04ww22laZkGm9kWl57YoxHGZwXifJbE1Zr9iwL5hp0R6JTNY3zefNDEtiaasT1/Kr2hX12uVPR5IOaPjI3XExlKCYLzBE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706937077; c=relaxed/simple;
	bh=G4YJejtd5CLe/ZWimmEmKHjz6GMhmWId0LQFmnbW3NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NrXbxpkcYFBHmkg0N1LZHdwJKMleSwvIs23B5DpRuK5H1DdMTqDLP/e9ob+K5xX4OnWOniuTRw1MBgsN6+D5LQQ2lRS5Dk49ibpctdBlKhCZPflyEi3serKIyRrF6Xy2CMxqY6xbglYokfXe5lqtnkpikshQkD9TzG6cvo1qci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.27])
	by sina.com (172.16.235.24) with ESMTP
	id 65BDCA530000029B; Sat, 3 Feb 2024 13:08:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 42734145089464
X-SMAIL-UIID: 5BD7989DF770498AB55A7F426CE8E865-20240203-130838-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+52bbc0ad036f6f0d4a25@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in hash_netiface4_destroy
Date: Sat,  3 Feb 2024 13:08:28 +0800
Message-Id: <20240203050828.427-1-hdanton@sina.com>
In-Reply-To: <0000000000000e28060610719994@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 02 Feb 2024 19:12:25 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    6897cea71837 Merge tag 'for-6.8/dm-fixes' of git://git.ker..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fcf5b0180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/netfilter/ipset/ip_set_hash_gen.h
+++ y/net/netfilter/ipset/ip_set_hash_gen.h
@@ -452,6 +452,7 @@ mtype_destroy(struct ip_set *set)
 	struct htype *h = set->data;
 	struct list_head *l, *lt;
 
+	cancel_delayed_work_sync(&h->gc.dwork);
 	mtype_ahash_destroy(set, ipset_dereference_nfnl(h->table), true);
 	list_for_each_safe(l, lt, &h->ad) {
 		list_del(l);
--

