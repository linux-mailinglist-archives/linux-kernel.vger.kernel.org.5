Return-Path: <linux-kernel+bounces-132792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273B4899A35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305E01C215E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECB4161339;
	Fri,  5 Apr 2024 10:06:48 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAB27447
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311608; cv=none; b=fvuSqJzyggUdO+ooZ2ClLJ8TosvNk27ey3UYa7ITVfE/aztwa9YsqOvcymOdwixwVQJAjnWVE2A6UbvxfQLGY18zOgApP69L7G3HIxLzI+KHjMLz1kiN6lwZJlhqz9KncCavHWnyisXKC/z1JFHkNta1oUt4z84AKAv+I+Jz0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311608; c=relaxed/simple;
	bh=uhE3Dtr5vLTtIukfMKSwe22iwlUD3pTNUmH5IJLzTzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRLNqlxHSGLMlUjxqX0bGHzIalcIWFoZ2fDsX6b7F6pQYg3TM3OMJyxDhgx57+32aalwYsxOF73t2aX60qW1ONzGLO0fIXrvyqSo9VhkcNPtBTRzdMeYhuP15UE8PTYwDVlQ7TiwPxWjErI/vRsa6lKy0lmjc/w/c9xaLLbus1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.172])
	by sina.com (172.16.235.25) with ESMTP
	id 660FCD2600007381; Fri, 5 Apr 2024 18:06:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 0451634210153
X-SMAIL-UIID: 6827D1A4AD6C4FD4BFA4499AE196B6B2-20240405-180634-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8a1d152fba6b41f760ae@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in l2cap_sock_setsockopt
Date: Fri,  5 Apr 2024 18:06:20 +0800
Message-Id: <20240405100620.953-1-hdanton@sina.com>
In-Reply-To: <000000000000b48cb0061553f087@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 04 Apr 2024 23:55:25 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c6098d180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  fe46a7dd189e

--- x/net/bluetooth/l2cap_sock.c
+++ y/net/bluetooth/l2cap_sock.c
@@ -960,7 +960,7 @@ static int l2cap_sock_setsockopt(struct
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (optlen < sizeof(u32) || copy_from_sockptr(&opt, optval, sizeof(u32))) {
 			err = -EFAULT;
 			break;
 		}
--

