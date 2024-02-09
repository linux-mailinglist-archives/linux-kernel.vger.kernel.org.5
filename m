Return-Path: <linux-kernel+bounces-59079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5895884F0E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02451B216FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A9265BA4;
	Fri,  9 Feb 2024 07:40:06 +0000 (UTC)
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74325657D4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464405; cv=none; b=RYX7w8Tazdqyz54O+pcQAvDoNvBvRVlRUHDSeJ6l6e7FQvumLCukkE0ARyMdvNd9Hn6xihN1yu6OVrhcphRXr7v9E/b6s2yZebpkxE0ObBNCJtDHVshjwDtlt+YmTrhEf63jLUjlsHbowuo/u5NHHL77pCyhpRU9JV8StVk+wF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464405; c=relaxed/simple;
	bh=pg9RKeltE5cqAky31o6Cy7jAxAxoEeCNTyYDOghAJwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdFDFwudRFHRTAUKnvnkFkReWNLBsCV+LUNH/5R90dnGukx534M7gaZqQubxIs5OxPkZb5OSXqsKupXuWbC4S3h3Rr4biCT9mi7Dvx8n2mOcZyNu3WN7ENtq270sVQioyHdduhyxhCEkavs0NJh0zh5yyjmRJwnzrep+rNUkVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.25) with ESMTP
	id 65C5D6390000462E; Fri, 9 Feb 2024 15:37:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 24899012059340
X-SMAIL-UIID: A9EB986AE86E468482C8D66ACB7B951F-20240209-153732-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __hci_acl_create_connection_sync
Date: Fri,  9 Feb 2024 15:37:18 +0800
Message-ID: <20240209073719.84-1-hdanton@sina.com>
In-Reply-To: <000000000000b7b62e0610db6b8a@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 08 Feb 2024 01:27:31 -0800
> HEAD commit:    b1d3a0e70c38 Add linux-next specific files for 20240208
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107c2d8fe80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  master

--- x/net/bluetooth/hci_sync.c
+++ y/net/bluetooth/hci_sync.c
@@ -6553,12 +6553,14 @@ static int __hci_acl_create_connection_s
 	if (err == -ETIMEDOUT)
 		hci_abort_conn_sync(hdev, conn, HCI_ERROR_LOCAL_HOST_TERM);
 
+	hci_conn_put(conn);
 	return err;
 }
 
 int hci_acl_create_connection_sync(struct hci_dev *hdev,
 				   struct hci_conn *conn)
 {
+	hci_conn_get(conn);
 	return hci_cmd_sync_queue(hdev, __hci_acl_create_connection_sync,
 				  conn, NULL);
 }
--

