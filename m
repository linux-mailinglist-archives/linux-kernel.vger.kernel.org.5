Return-Path: <linux-kernel+bounces-81331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0808867459
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E70B237C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6537E5FBBB;
	Mon, 26 Feb 2024 12:07:26 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8D5B03B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949246; cv=none; b=pnbs2v1KjDj172zfImfdY2pAR6iq1y8OUXyiT8QUddab/fqbbBQNumOFyhX2ToQ+LKVzl+68s77frDPn6bMB4L6uo049WnlhUJPKow5mU1mykd2wZuXlCIHSFesMg0puJ6R88leQ/7UDKII/6Xp2uFe40wIXUXyfaOSnhzmpIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949246; c=relaxed/simple;
	bh=pLt7uW/tLWOix+u8T0EY+yCzxoIKPC5tGiwPgZA82wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tkc8w8ojzDCMXSkF66hQFk5DTkcYoRJFPvp0vll9KHUIJORozvvoFnN1zgyrNskFFjBu4L2MallM9VR9vWtq1CZD73yh1RL2Q3/baDUVgFCPQwbawA1rOOpRZRaHiZDu5l7MYwVLBfphx1T/vdqO9tTN5mYOvezkwt9eiM5YfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.169])
	by sina.com (172.16.235.25) with ESMTP
	id 65DC7EC900006951; Mon, 26 Feb 2024 20:06:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 74897934210316
X-SMAIL-UIID: B7F26EFD82E247E782670C81FCE0147F-20240226-200635-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com,
	boqun.feng@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	penguin-kernel@i-love.sakura.ne.jp,
	syzkaller-bugs@googlegroups.com,
	torvalds@linux-foundation.org
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
Date: Mon, 26 Feb 2024 20:06:23 +0800
Message-Id: <20240226120623.1464-1-hdanton@sina.com>
In-Reply-To: <00000000000044c2da06124774f7@google.com> (raw)
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test non-zero subkey against the mainline tree.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/ntfs3/fsntfs.c
+++ y/fs/ntfs3/fsntfs.c
@@ -944,7 +944,7 @@ int ntfs_set_state(struct ntfs_sb_info *
 	if (!ni)
 		return -EINVAL;
 
-	mutex_lock_nested(&ni->ni_lock, NTFS_INODE_MUTEX_DIRTY);
+	mutex_lock_nested(&ni->ni_lock, (1 + NTFS_INODE_MUTEX_PARENT2));
 
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_VOL_INFO, NULL, 0, NULL, &mi);
 	if (!attr) {
--

