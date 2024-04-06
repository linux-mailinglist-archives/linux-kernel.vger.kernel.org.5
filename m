Return-Path: <linux-kernel+bounces-134098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C77A89AD97
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 00:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C88B1C20C07
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 22:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00B557881;
	Sat,  6 Apr 2024 22:49:58 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831157339
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712443798; cv=none; b=nKvSiI67yVWuXT5tJfihBTBXaeQ0UhSq33ZoTPujPugtyS2n+v1fLmF4nvEu0p4UJXCfvuZO3vdDSiuYV4LPC2i4Lxx/4AuoneiUH21jrxJpCnOxlR5ya+FixQVhHZIpn+4kJHgGgW64PuVsXccWkLH540ZHL5GiVI9Kwob+dLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712443798; c=relaxed/simple;
	bh=lv6hN5+6pEeaKYcsI5q9TuzzxUlJb9ppk6hDBYFEvrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQ4KOdl33B1mozKCDpJPtd6sG/9syo1SPIEVhFIvdGwVTe1T+w/AlNdQ3PuusO2iXMBn04RZFnUpGRVqvrttc9uCzsi3DfJNQcvj/GrsZeojn+nOjyLsvLY11PVYXdnmTT/5AVKR2opgMFYxLZhuL/+exDV/yLboAet1YL4y5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.84])
	by sina.com (10.75.12.45) with ESMTP
	id 6611D16100001AC1; Sat, 7 Apr 2024 06:49:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 84251431457705
X-SMAIL-UIID: D0A6F5E6411648DEA00001E700966CD6-20240407-064907-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
Date: Sun,  7 Apr 2024 06:48:57 +0800
Message-Id: <20240406224857.1297-1-hdanton@sina.com>
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
--

