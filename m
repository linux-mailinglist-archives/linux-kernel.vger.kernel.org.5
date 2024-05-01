Return-Path: <linux-kernel+bounces-165047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B88B8707
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CC6B21A79
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5482550285;
	Wed,  1 May 2024 08:48:59 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767439FFB
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714553338; cv=none; b=urb8OrlbK2JkPhEh15rvuKjAP64Twl8pUvnGAM3FALpEubV0ej4LX4Tx7XUtDqkrX0zlnXKFDxOrhcsEfsKVAfzLBEG870A9GrrwnGogiysAlleVRWW0FeopErY9fhUvC+RoeXS+mVDuV+2RzRYTPOCrMfEPajI66ZkBFktG/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714553338; c=relaxed/simple;
	bh=p7x6vJ2NqYHM4U+gU+kkTRG+vJJvgqgZSUDT/soswVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRVvMigrB8h9G12N4DHihENS2KWBjQ6hwEwspzS8HznuH8sEuU7TGkO3bf0VI2e0WBC14LEOQbdgAeawETz7p8HjVXvdGnGkg2kQxOK6oGRHKMkOJyxYvdqnvb69Fz0fpBKPtt5CcDsx9jTm4RoCHA+XM3cbfiaOGYwHvMpqfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.115])
	by sina.com (172.16.235.24) with ESMTP
	id 663201F0000011C8; Wed, 1 May 2024 16:48:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 99079545089343
X-SMAIL-UIID: 807D76E1FAEC407CB8B51EBC7BF65897-20240501-164850-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d863bc2d28ef7ff42984@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in skb_release_head_state
Date: Wed,  1 May 2024 16:48:53 +0800
Message-Id: <20240501084853.1748-1-hdanton@sina.com>
In-Reply-To: <0000000000006c25b806175ccab3@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Apr 2024 21:19:20 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    50dffbf77180 Merge tag 'for-v6.9-rc' of git://git.kernel.o..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ba57bb180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  50dffbf77180

--- l/net/bluetooth/hci_request.c
+++ y/net/bluetooth/hci_request.c
@@ -181,7 +181,6 @@ int __hci_req_sync(struct hci_dev *hdev,
 		break;
 	}
 
-	kfree_skb(hdev->req_skb);
 	hdev->req_skb = NULL;
 	hdev->req_status = hdev->req_result = 0;
 
--

