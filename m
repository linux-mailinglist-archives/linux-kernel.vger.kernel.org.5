Return-Path: <linux-kernel+bounces-160956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192468B451B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2091C226A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8969E44C66;
	Sat, 27 Apr 2024 08:15:52 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450BB38DEC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714205752; cv=none; b=k7tNZq74VuxkE9FXxShu0TAil//SlyYHlSiZzz1rdRoiFTY5l11oLyGGh3V11b0xTipO5N638quphabi9aCvMNO+ufYaA+zdii82xvIc/PCJrgcFOBN6069QoBHqtW6xgdEyX0lQcB71GQM2W3Qhb+yc3LZ5VqQxtqc0eCIyRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714205752; c=relaxed/simple;
	bh=91AqmYS4dPpa3C0JU9J6JrPihNjNaPAQoZjNESjEk2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZEQT4DHNFv5WUWlk4gReKxvA5O23Y1JuriERP1+RdhPL2Y8TlK3X217lGyxqzF73E/KNnyM50JT75TxcRm5rEcw5bDm/Y6w+GMtzbxjf8+fCvu40oGUUmhazPuNCvCeCM4hR2+idSKzZItf7pao73UX+Iblcdbfpa7/WoKYVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.155])
	by sina.com (10.75.12.45) with ESMTP
	id 662CB425000007F1; Sat, 27 Apr 2024 16:15:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 33095731457767
X-SMAIL-UIID: 240E622A0B8A43E89AC6FDCDECFE2333-20240427-161535-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem (2)
Date: Sat, 27 Apr 2024 16:15:36 +0800
Message-Id: <20240427081536.3770-1-hdanton@sina.com>
In-Reply-To: <000000000000d0b87206170dd88f@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Apr 2024 23:08:19 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    b2ff42c6d3ab Merge tag 'for-netdev' of https://git.kernel...
> git tree:       bpf
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c06aa0980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git  b2ff42c6d3ab

--- x/net/core/sock_map.c
+++ y/net/core/sock_map.c
@@ -928,6 +928,7 @@ static void sock_hash_delete_from_link(s
 	spin_unlock_bh(&bucket->lock);
 }
 
+static DEFINE_PER_CPU(int, subclass);
 static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_shtab *htab = container_of(map, struct bpf_shtab, map);
@@ -935,6 +936,7 @@ static long sock_hash_delete_elem(struct
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
+	int *class;
 
 	if (irqs_disabled())
 		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
@@ -942,7 +944,10 @@ static long sock_hash_delete_elem(struct
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	spin_lock_bh(&bucket->lock);
+	local_bh_disable();
+	class = this_cpu_ptr(&subclass);
+	*class += 1;
+	spin_lock_nested(&bucket->lock, *class);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -950,6 +955,7 @@ static long sock_hash_delete_elem(struct
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
+	*class -= 1;
 	spin_unlock_bh(&bucket->lock);
 	return ret;
 }
--

