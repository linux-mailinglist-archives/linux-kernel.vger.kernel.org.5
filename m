Return-Path: <linux-kernel+bounces-143639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3308A3BC8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFBB283023
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA91E2032B;
	Sat, 13 Apr 2024 08:56:03 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C698F9D4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712998563; cv=none; b=cnBefbDFkvusmvd3fpCsk9W7qIavVVb3KbqGdi02TajVvEJhH5UhMIx89pxxJvg02fK5hxYRBstyOh7qFSDQE5k8ihEUqpm5gtGlB6u/w3AQvkVSrJQ8ydFwmbWA88mMF1AKDF/MR2GrwqoJpJNJmXmfQAhf++SKnzoZbXiWL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712998563; c=relaxed/simple;
	bh=FkKWQjItjpe2kZpO3M/4BDhqIfxnrFz73LhNMpvGh7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B4Sji+KPcMBxOhaQ52xSVN5S1E4SNyQmBj/8ivlk6Ev21zrtOh56oq+MZrwgeJC0SKr0Kjy8gSI8yUTZYBDzaLhwSk5yMKUb9vuFgLaiGunc7rFXjrj2ehsZXzw/l1ibbsPKojV7Oxte7A0j6kwA38qG1evu+rD7AHnHh/l+UIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.22])
	by sina.com (172.16.235.25) with ESMTP
	id 661A489200002096; Sat, 13 Apr 2024 16:55:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 70657634210238
X-SMAIL-UIID: 4A984F3758DE4559811232CB97AEF650-20240413-165548-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+27209997e4015fb4702e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __hci_req_sync
Date: Sat, 13 Apr 2024 16:55:42 +0800
Message-Id: <20240413085542.1836-1-hdanton@sina.com>
In-Reply-To: <0000000000009e80a40615f5c189@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Apr 2024 00:58:39 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    8f2c057754b2 Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171da243180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  8f2c057754b2

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

