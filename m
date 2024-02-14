Return-Path: <linux-kernel+bounces-64624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8646D8540FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF201F2A2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556B0B654;
	Wed, 14 Feb 2024 00:56:51 +0000 (UTC)
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65087B64A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707872210; cv=none; b=izj3Nl6A5zQdrw2TVw0/PmzjavJV4bSshiWeHzmlbTQNAYAbiKdUtc2BxW3mPXy/CEpRPZ3gfgKE/I+vqE86hNuh14JsM1Dj2zvjAn6jxr3ASUeSbUybHFMntaGXH+lnLM1aNy+cimE6T81dkorLPZm4XLTojgcpwvZ3Y5IWFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707872210; c=relaxed/simple;
	bh=9RiqoT09HHJBvhKjtXYrd+e8trSV6v0VOjtI+bKKk4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU4xWAOOb/Vx/l8U8HKbtJ6e7awThTkdqZwKiyk3hKBAHmiBqbW10OrOFENqYr9Ffqbv8PjYDq4kL6GY611JAvK9o2gEmZ7mjdLXrWjfYsgvtP9QAGHs8KbrXi4gDrVIHBYf/MYBudZIzmc2/tVDgA2RG16w+cP8ENmtWxrWu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.24) with ESMTP
	id 65CC0FA30000398F; Wed, 14 Feb 2024 08:56:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6793441048654
X-SMAIL-UIID: 1B9F12CFAE57421D9346C6E232AE8020-20240214-085605-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in ip_set_free
Date: Wed, 14 Feb 2024 08:55:51 +0800
Message-ID: <20240214005553.1060-1-hdanton@sina.com>
In-Reply-To: <000000000000d42dae0611477922@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 10:22:24 -0800
> HEAD commit:    f735966ee23c Merge branches 'for-next/reorg-va-space' and ..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161a6ba2180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ y/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -60,6 +60,7 @@ mtype_destroy(struct ip_set *set)
 {
 	struct mtype *map = set->data;
 
+	del_timer_sync(&map->gc);
 	if (set->dsize && set->extensions & IPSET_EXT_DESTROY)
 		mtype_ext_cleanup(set);
 	ip_set_free(map->members);
--

