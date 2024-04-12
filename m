Return-Path: <linux-kernel+bounces-142525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D265A8A2CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D4C1F21843
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841B25474D;
	Fri, 12 Apr 2024 10:44:59 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143C53811
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918699; cv=none; b=rIKnAD02NFjOyDkXPx099Do1/TgrstAxme5uCwpIuSkNoE8PsmmoYpOpHN68BKlzcb+gazZawLzkDqcUoYOtLJL8sTJBfYddq94r4fqTNdXU2SH8oE+SKYYke3GJmhLeepevF9p8xusiDAB18KlAjUKrjmdewLu/2xYoR4/JOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918699; c=relaxed/simple;
	bh=8nFo+yRqMv596zXcQc6sLKYB+Lj/1HuhPa2dqAQa7Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUbA/rnlrfVugta1hA8DAzY8cvpj/330P9Z/7cyqqNVFfIjC5LOCEf0V26jEnbXEasHQX4t3IGjhfr/ETqRwxp7nr3DMuiNPdTVQffO3DVTL9cBANDAy13T3cjRIS5b07psTXU5t3p7xQjWhUjZrpNcPIjhHQEqxhSXrdzxf7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.151])
	by sina.com (172.16.235.24) with ESMTP
	id 6619109B00004B38; Fri, 12 Apr 2024 18:44:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 93202645089280
X-SMAIL-UIID: 755B8131DDD049A3A1211D4265FD5FEC-20240412-184445-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+27209997e4015fb4702e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __hci_req_sync
Date: Fri, 12 Apr 2024 18:44:39 +0800
Message-Id: <20240412104439.824-1-hdanton@sina.com>
In-Reply-To: <0000000000009ffb1d0615deec6b@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 21:44:17 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    00dcf5d862e8 Merge tag 'acpi-6.9-rc4' of git://git.kernel...
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179a3b4d180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  00dcf5d862e8

--- x/net/bluetooth/hci_request.c
+++ y/net/bluetooth/hci_request.c
@@ -102,6 +102,7 @@ void hci_req_sync_complete(struct hci_de
 {
 	bt_dev_dbg(hdev, "result 0x%2.2x", result);
 
+	hci_req_sync_lock(hdev);
 	if (hdev->req_status == HCI_REQ_PEND) {
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
@@ -111,6 +112,7 @@ void hci_req_sync_complete(struct hci_de
 		}
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
+	hci_req_sync_unlock(hdev);
 }
 
 /* Execute request and wait for completion. */
--

