Return-Path: <linux-kernel+bounces-134361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E969689B0B2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB6E1C20AFE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D7F24219;
	Sun,  7 Apr 2024 12:17:14 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1333D69
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712492234; cv=none; b=eO2x7s8iA3Teljc4YtSc9JACsLFZ54Zbj+HtAXSnOVkAvMZ9y9ZYtJkvi/BfZApX3WWHQBD6RZW7BnVTC4V1YGeCX1p91LUyGHoHD4YT5CjeLuHyW43gkIx2LVKoetMoRFEKivzNLm0DEaETJkLsxnsGuG43j7JR6j6BUcw+4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712492234; c=relaxed/simple;
	bh=f7SPIuuCdNbAM4S4kKz2ib0Fu5P+A+ERPG5+x4LiZSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3C1Pp9MSxgrLmJtVO85lES9GAjSqNx6BPFTxibigt+mR5JsjIMu7VXKZLY9iVq2yj7Jc8DUV4AOiiYEmNKs5eze4FDy/4MuEcZoal8QpmjU4/erX47cLatuzSwnZ1fFqxXTI6euFl4yApY1femHa4ivsSQReQA6VdruG1/cVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.236])
	by sina.com (172.16.235.25) with ESMTP
	id 66128E9000006C5A; Sun, 7 Apr 2024 20:16:18 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 74111434210371
X-SMAIL-UIID: 45049ADE17EA44AD82D1AF77D4FFD1A6-20240407-201618-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid context in hci_le_create_big_complete_evt
Date: Sun,  7 Apr 2024 20:16:09 +0800
Message-Id: <20240407121609.1426-1-hdanton@sina.com>
In-Reply-To: <000000000000dd84650615800e67@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 07 Apr 2024 04:33:29 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ee2e75180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  480e035fc4c7

--- x/net/bluetooth/hci_event.c
+++ y/net/bluetooth/hci_event.c
@@ -6936,8 +6936,8 @@ static void hci_le_create_big_complete_e
 			continue;
 		}
 
-		hci_connect_cfm(conn, ev->status);
 		rcu_read_unlock();
+		hci_connect_cfm(conn, ev->status);
 		hci_conn_del(conn);
 		rcu_read_lock();
 	}
--

