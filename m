Return-Path: <linux-kernel+bounces-154186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE08AD8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F87B25297
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937D3FBA0;
	Mon, 22 Apr 2024 23:18:54 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96723DBBC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713827933; cv=none; b=CUaZsxvTpTeLRYoXIf9RVcF6shq9rajSI4T36f5VmpdWps1UZoDeMVK5gZ+TUPQoZT5cLLup0YBdJt9Z+bPDYVyTLUNhChUMrY79gInn1nn5MdafAjpH+baH49WQB7jzRL52t7cunmeInSQh6EURiHYMMTyNSJBNrMLZYp25qAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713827933; c=relaxed/simple;
	bh=mOWY7WRhj3h2nUUEgjc1y6NeqHK9LhEIHincGXGZqXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dy4v6Nb8YstFRywlkS1sO+1liueQjFnfE6e2gs7T1Z2UR+3M6+D8/Y9qH0S07Z2Xm10eTUC/YPmwrsL4QerIY4xnz7F+JOdaeSdckGfeSCiPAhItdnqJJQ0i3QkTHpDFrU7SiuAE7ume6iI0fNRMoS/3NozaLQT/ptbuB9xRZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.40])
	by sina.com (172.16.235.25) with ESMTP
	id 6626EFC000005C44; Mon, 23 Apr 2024 07:16:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 38118134210409
X-SMAIL-UIID: 3EF4C64A57D049A5AEC96D785C3AA858-20240423-071619-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
Date: Tue, 23 Apr 2024 07:16:17 +0800
Message-Id: <20240422231617.2916-1-hdanton@sina.com>
In-Reply-To: <000000000000afab690616b12f99@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Apr 2024 08:35:25 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    3cdb45594619 Merge tag 's390-6.9-4' of git://git.kernel.or..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144067cb180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  3cdb45594619

--- x/net/bluetooth/bnep/core.c
+++ y/net/bluetooth/bnep/core.c
@@ -659,7 +659,7 @@ int bnep_del_connection(struct bnep_conn
 	if (req->flags & ~valid_flags)
 		return -EINVAL;
 
-	down_read(&bnep_session_sem);
+	down_write(&bnep_session_sem);
 
 	s = __bnep_get_session(req->dst);
 	if (s) {
@@ -668,7 +668,7 @@ int bnep_del_connection(struct bnep_conn
 	} else
 		err = -ENOENT;
 
-	up_read(&bnep_session_sem);
+	up_write(&bnep_session_sem);
 	return err;
 }
 
--

