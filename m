Return-Path: <linux-kernel+bounces-44514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC4842319
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A60828DED0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8606466B5B;
	Tue, 30 Jan 2024 11:31:06 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077FA66B33
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614266; cv=none; b=qsRY/mNlLsrvBDqqPI/LVRCI80J0IuML3NcDL0P0jHZx/misF4jAtla+CSjQY4xAOyGFzYuzCFnDKy1RYkhaMOwyGYyRtECnFHu/yCVkOttTixav8ryY99xgeh/968gpAbmIFMlSvY6eFN4d6MuzxX8l99fzxYENuxHs3U721c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614266; c=relaxed/simple;
	bh=8izGayVFiylM6e6Nv0jsppZ+9+/0Qelwm4RqoWSLt/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bS5XqkSvhi0UQxI058KjpS9BLUj3EgNzZ+USFVcEW033ja0BEkfHcpD4ly7fxswthkQENWhD3ShwE16MX+VaCxPp31RG091TE4KA2UAoiXRdgj9OCCSBzVuTB0vQIhEqqjUBoiLtlqbR+mxnxClUC8xKWrNXS3tWHh0o1HAnrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.30])
	by sina.com (10.75.12.45) with ESMTP
	id 65B8DDE6000075BC; Tue, 30 Jan 2024 19:30:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 48242231457765
X-SMAIL-UIID: 1F60C372F9BC48C7B815906CE64D145F-20240130-193052-1
From: Hillf Danton <hdanton@sina.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>,
	eadavis@qq.com,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Date: Tue, 30 Jan 2024 19:30:37 +0800
Message-Id: <20240130113037.1390-1-hdanton@sina.com>
In-Reply-To: <ZbgJqc06rEZ_FqRw@boqun-archlinux>
References: <tencent_4A66EF6ACD6878526F542C2D6D109794E80A@qq.com> <20240129044824.1218-1-hdanton@sina.com> <20240129104753.1328-1-hdanton@sina.com> <afb57c55-5fd0-4f79-9653-67ef0c1e341e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 12:25:13 -0800 Boqun Feng <boqun.feng@gmail.com>
> 
> Looks to me that debug_show_all_locks() doesn't hold the lockdep lock,
> so it's really a best effort race read of all tasks on lock hold
> information. Maybe Hillf wants the following? (Completely untested, it
> will stop your whole system and print lock holding information).

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6611,6 +6611,8 @@ void debug_show_all_locks(void)
 	}
 	pr_warn("\nShowing all locks held in the system:\n");
 
+	local_irq_disable();
+	lockdep_lock();
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		if (!p->lockdep_depth)
@@ -6620,6 +6622,8 @@ void debug_show_all_locks(void)
 		touch_all_softlockup_watchdogs();
 	}
 	rcu_read_unlock();
+	lockdep_unlock();
+	local_irq_enable();
 
 	pr_warn("\n");
 	pr_warn("=============================================\n\n");
--

