Return-Path: <linux-kernel+bounces-65119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E500854832
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D011C2142B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69841B26E;
	Wed, 14 Feb 2024 11:23:26 +0000 (UTC)
Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974271A58E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909806; cv=none; b=EcWboLls7TnywBX8JbbS6eG4ben/8iBqtEMFwAlhgQXWKyuXvecwX1zxoHrauN3ndIoPM4ZKlmFOVyPdjJhI5iJOzL9uKN4ixB2LsaruQql+/CVIPp1vboMu5r6uXeKWqRerWhhPFZsMlCnp55VI8NJE7J5mpijTFuRJyYrC+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909806; c=relaxed/simple;
	bh=+/f5EmK46ZI033soIYpriZFMWNGNs++6wwpQJpflDrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlInW6BOPXZEYY7if78CcJhjyMQnJC2t5chB2PyJd8la04MqtoMMr7mDe5hZugwo2CJk7F5CBXE9NIciJXX4v8fP2MuJUqMyjAGCHOx0c4HKV+uBsybcmbCjiFStlYvSTiRN0KOvbes00hFEuaCkBlDKlXHe6c3eOVBB668CpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.25) with ESMTP
	id 65CCA28000001A09; Wed, 14 Feb 2024 19:22:43 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 83075312059032
X-SMAIL-UIID: 40885956F7BB43A6AFCCC558FA2CD639-20240214-192243-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+dfab1425afcdae5ac970@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] WARNING in ida_free (2)
Date: Wed, 14 Feb 2024 19:22:29 +0800
Message-ID: <20240214112230.185-1-hdanton@sina.com>
In-Reply-To: <00000000000084b931061145fe46@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 08:36:20 -0800
> HEAD commit:    c664e16bb1ba Merge tag 'docs-6.8-fixes2' of git://git.lwn...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ee7970180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/bluetooth/hci_conn.c
+++ y/net/bluetooth/hci_conn.c
@@ -970,6 +970,9 @@ struct hci_conn *hci_conn_add(struct hci
 
 	bt_dev_dbg(hdev, "dst %pMR handle 0x%4.4x", dst, handle);
 
+	if (HCI_CONN_HANDLE_UNSET(handle))
+		BUG_ON(!ida_alloc_range(&hdev->unset_handle_ida, handle, handle, GFP_ATOMIC));
+
 	conn = kzalloc(sizeof(*conn), GFP_KERNEL);
 	if (!conn)
 		return NULL;
--

