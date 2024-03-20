Return-Path: <linux-kernel+bounces-108810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA0D881051
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485852834C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AA13A1BB;
	Wed, 20 Mar 2024 10:56:38 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF738384
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932198; cv=none; b=MWWNoifaurxFrDfqE7OS4vuMx7VPr/Ss4Lk4OFwoNcg7zRJiIjNQpMGatSw/sq9PcKJxZbqtkI0TGAlHSgH1iYMhn7j43DuOLkr43oO8kLvJSrMAtOGQAlSK7lXZ1zzdsDKzPhqwESWfOZaBHtGSRxByDmByC+/ymG5zTHIkX+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932198; c=relaxed/simple;
	bh=brTj4ki1UXquLCalyQed1q20K5Mf3tXooUOhxC4FRu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9mBcaC5cfZfjt60DkFUf39ZwjeRU2e+ro+2Ga9C0kSGx9gZbaxsOdtATNeFpzEk6dcy7atmxn6lbkLrIpQteOc4dYAQPO+B2D5Jz/+RJvOpiS8+hbULkNJBAtV7LUYk4iDFTuc8IpFPl6Oy/eLzGKRfL+VC+lmujw4B8HRZbzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.154])
	by sina.com (172.16.235.25) with ESMTP
	id 65FAC0AF00000B32; Wed, 20 Mar 2024 18:55:47 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 32788534210202
X-SMAIL-UIID: 5CF71BAC696348EEB0776A3B820D89DE-20240320-185547-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f311e026553fee3459a0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in hrtimer_run_queues
Date: Wed, 20 Mar 2024 18:55:38 +0800
Message-Id: <20240320105538.2238-1-hdanton@sina.com>
In-Reply-To: <0000000000004b02a206140b016b@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Mar 2024 15:29:19 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    ea80e3ed09ab net: ethernet: mtk_eth_soc: fix PPE hanging i..
> git tree:       net
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c64e31180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git  ea80e3ed09ab

--- x/net/core/sock_map.c
+++ y/net/core/sock_map.c
@@ -932,11 +932,12 @@ static long sock_hash_delete_elem(struct
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
+	unsigned long flags;
 
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	spin_lock_bh(&bucket->lock);
+	spin_lock_irqsave(&bucket->lock, flags);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -944,7 +945,7 @@ static long sock_hash_delete_elem(struct
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	spin_unlock_bh(&bucket->lock);
+	spin_unlock_irqrestore(&bucket->lock, flags);
 	return ret;
 }
 
--

