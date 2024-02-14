Return-Path: <linux-kernel+bounces-64607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA2D8540D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C95283657
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9648472;
	Wed, 14 Feb 2024 00:24:31 +0000 (UTC)
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF37F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870270; cv=none; b=BfLS7bWAMzCfT8907pv+eKDe+fcLaEElLFCdWo2eY10ipV9vaR6BCxvbiQccVUvbqZvwjMLuCrB7BIi27mWlBWPxWw6n9SVBn/xkWz3fwHnWKhIJJWi6SYRXfYnGm1O3WEkcerCOcARqvq3q0TPCEruyLpyeNmBg9mccJwaNw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870270; c=relaxed/simple;
	bh=EgZc8Cjsiwrsbynzkb2nJSqyJ4Yet779f6umXLjNS1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjgC/AX1Pm8B70wcc8PkY3983WGtOd2NZNoX2rO71YMJRphTRhSd+wWxMSOvf14bWlP+fRnEDbWP2YwYa6qu/a8FIhGzEGb+JqY2hD7L2n8/QoHlBH0AbnmO2On6AugtO8qBjRN+3Np9/7LlpnxDE93s4YVo1OX1rVzn3uXG7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.22) with ESMTP
	id 65CC083300002235; Wed, 14 Feb 2024 08:24:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5164186816170
X-SMAIL-UIID: 80191F2B6BA74F68B2970C7C2801EF42-20240214-082421-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+dfab1425afcdae5ac970@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] WARNING in ida_free (2)
Date: Wed, 14 Feb 2024 08:24:05 +0800
Message-ID: <20240214002407.1035-1-hdanton@sina.com>
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
+		BUG_ON(!ida_alloc_range(&hdev->unset_handle_ida, handle, handle +1, GFP_ATOMIC));
+
 	conn = kzalloc(sizeof(*conn), GFP_KERNEL);
 	if (!conn)
 		return NULL;
--

