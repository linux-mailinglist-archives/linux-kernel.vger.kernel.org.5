Return-Path: <linux-kernel+bounces-161630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060EC8B4ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945171F21180
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1919A22318;
	Sun, 28 Apr 2024 23:42:55 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84311A286
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714347774; cv=none; b=hP9PlMlj7G9qYZtxuo5lkdxVxvOcn2CojtbUkMfzKOsBbJ93Y9FOQMKwgbe8rIcWjQtLpCERen+E2t02RCT0rnvwtDylBgoWQ9BodGtU/cYMVHu/i8S6LrwPud32c09pu5HRIn8E+XWAuTesD+m5NKc6qUvcmm9bfppD4CkXDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714347774; c=relaxed/simple;
	bh=tFUxIMsjuq39FrUAVBlvbyQAQIpVe5TAnUUNhKlSS04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrq0NvArLXYSW5pIquNBKGXoo+o7jVS6I7p+/77tnkSn35FcjzCk7aYwAEMme9F++PlFYGUObPnrphubkIkfpXKzWA3ljZ+JHfTP2dTaXWsORa+9WBxs0lopPMIxFZyCEjnBvVAhK1/SvcUhktsV4bX+bczl5l1oPZEJNTqaOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.20])
	by sina.com (172.16.235.25) with ESMTP
	id 662EDEEC0000574E; Sun, 29 Apr 2024 07:42:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 37071634210377
X-SMAIL-UIID: 52780ECE419C4C52962F68EA0E13E21B-20240429-074238-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c55f7bc8d4809b2bad59@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] possible deadlock in hci_dev_do_close (2)
Date: Mon, 29 Apr 2024 07:42:40 +0800
Message-Id: <20240428234240.4096-1-hdanton@sina.com>
In-Reply-To: <000000000000eda1e806172fc058@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Apr 2024 15:35:27 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    bb7a2467e6be Add linux-next specific files for 20240426
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1349ee9b180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  bb7a2467e6be

--- x/net/bluetooth/hci_sync.c
+++ y/net/bluetooth/hci_sync.c
@@ -306,11 +306,9 @@ static void hci_cmd_sync_work(struct wor
 		if (entry->func) {
 			int err;
 
-			hci_req_sync_lock(hdev);
 			err = entry->func(hdev, entry->data);
 			if (entry->destroy)
 				entry->destroy(hdev, entry->data, err);
-			hci_req_sync_unlock(hdev);
 		}
 
 		kfree(entry);
--

