Return-Path: <linux-kernel+bounces-60247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF085022A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 03:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6AB28911E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04E74C6C;
	Sat, 10 Feb 2024 02:25:51 +0000 (UTC)
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEADC2119
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707531951; cv=none; b=pFdsO68VLGNit55yz8T4AxQBovGErMku8ap6SeNk0WxA3eBKQ9o0bUXJuVwXwiij3/wrznqv21h4Fxw9DdPZacFIJGqBW9SpwHy7qwsI3S6pjy5VHA8z2P/fKeUnBdhx1DRuk2yX3MClbwbOkDVojOQzBkoPxezyg8z3cZrvIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707531951; c=relaxed/simple;
	bh=RJLEaSg+FYQoepQjpqTmkY6iVzwvm2LFLKLBMAIgNwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMuB119zr4ZyS5t+ZGd0uYp03Gh/hsL8EPIKs1vZjN2msSW2/hzhaJGGQAHQhoVjvhDd1nrEJcmHZhMjB4RJwNcGdgSMlfMczZyDvzHX7kvCdwp9G/ZgMker+Tm0geRe0weXgaAiLX+cKJpt6RldGnyGAno6OVbgT6Zhug+8aJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.22) with ESMTP
	id 65C6DE7F00006955; Sat, 10 Feb 2024 10:25:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7644666816216
X-SMAIL-UIID: 861C7A751C854AFB8BA62E992CAFFF89-20240210-102505-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5a630f8ca0120ab43f55@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in __unix_gc
Date: Sat, 10 Feb 2024 10:24:51 +0800
Message-ID: <20240210022453.773-1-hdanton@sina.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git  e7689879d14e

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

