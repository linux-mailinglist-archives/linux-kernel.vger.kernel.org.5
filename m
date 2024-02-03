Return-Path: <linux-kernel+bounces-50795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF69847DF4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A01A1C23734
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A34223A7;
	Sat,  3 Feb 2024 00:44:06 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391C1FB2
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921045; cv=none; b=GJhVs6wo3XLhHr4vJ6PxQzWStNZLZP4CdJcSoZ0q41wtrc/bgo6OFRzH3cszLlUK9kvAjpT2Aeh2kJenGIdh+n/PMw0kw5iQr20o0GpTqXwCA4PfrZSUHssW829brTm+tQ6ftlPF7XqvqEphKqo6dq94CV94xpoGUJ/oasZGgio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921045; c=relaxed/simple;
	bh=Iex1O2tO1cn1lvKcNF5xwKw1S3qkF5JiJoARhRTEN3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DniBrOki5R8dtKVmLgL6G6HoiCca7Kxh4B0TPkMlCLSMPsxISq/Yjpd2EKnKJdvF5iRqnUx9JCWP6OLwteT3v80Yc6NhdbpdABAqvsI8GK5sXLz6evNO5yCjwW3TK0DYi712tWYe9YsgjM3q5gzINA37zJWOJJrDj/4BRjiAhXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.27])
	by sina.com (10.75.12.45) with ESMTP
	id 65BD8BBA00007161; Sat, 3 Feb 2024 08:41:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 87338931458171
X-SMAIL-UIID: 60426E2BFD414186A3F139DCDC2497A6-20240203-084132-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in __unix_gc
Date: Sat,  3 Feb 2024 08:41:22 +0800
Message-Id: <20240203004122.1625-1-hdanton@sina.com>
In-Reply-To: <0000000000003555920610660fbc@google.com>
References: <0000000000003555920610660fbc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 02 Feb 2024 05:26:28 -0800
> HEAD commit:    1701940b1a02 Merge branch 'tools-net-ynl-add-features-for-..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d6927be80000

#syz test 

--- x/net/unix/garbage.c
+++ y/net/unix/garbage.c
@@ -237,6 +237,8 @@ static void inc_inflight(struct unix_soc
 	usk->inflight++;
 }
 
+static int recycle;
+
 static void inc_inflight_move_tail(struct unix_sock *u)
 {
 	u->inflight++;
@@ -245,8 +247,10 @@ static void inc_inflight_move_tail(struc
 	 * of the list, so that it's checked even if it was already
 	 * passed over
 	 */
-	if (test_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags))
+	if (test_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags)) {
 		list_move_tail(&u->link, &gc_candidates);
+		recycle++;
+	}
 }
 
 static bool gc_in_progress;
@@ -259,6 +263,7 @@ static void __unix_gc(struct work_struct
 	struct list_head cursor;
 
 	spin_lock(&unix_gc_lock);
+	recycle = 0;
 
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
@@ -342,7 +347,7 @@ static void __unix_gc(struct work_struct
 	spin_lock(&unix_gc_lock);
 
 	/* All candidates should have been detached by now. */
-	WARN_ON_ONCE(!list_empty(&gc_candidates));
+	WARN_ON_ONCE(!list_empty(&gc_candidates) && !recycle);
 
 	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
 	WRITE_ONCE(gc_in_progress, false);
--

