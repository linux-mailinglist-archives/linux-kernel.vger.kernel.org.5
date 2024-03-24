Return-Path: <linux-kernel+bounces-115797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2236588968C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19FC29AE70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12878158851;
	Mon, 25 Mar 2024 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vdgcgoee"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B802145339;
	Sun, 24 Mar 2024 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321985; cv=none; b=KbiszEPKJ7VO8GBFD3sS4bArDWrDZtfDjzUoiqwKKd3W2D2+8cVzr95/9++WCVER6aIqVrWJgEQtg253/JGLPE28YjzoV6fJph9dvk+2oMbpIQq38AIcT+KT82sjEMNx95N2zewyBtexJ+5VHM7oWd/BBQghpi7MctSAZmq9SW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321985; c=relaxed/simple;
	bh=Kh34Wl5Hm35G11oz9z4Kp6zAuV/vNfZQ04qtSDbysKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDwZSARP4v2xVZWavRmXN2eV6kbV1m0MLpfuWW6oU+8mU5CIi6EDOMsQexfEnngVdz5Fzxv/jLjFE3G2B28VNfiW8VDpUif3g8oPT/xnH3U+zxP+l5eIevA5FxxnAFwmk14lcazYxRIIi47TgI21Ol1x1SuGybVbbF1DmmSQ9Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vdgcgoee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A9BC433F1;
	Sun, 24 Mar 2024 23:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321985;
	bh=Kh34Wl5Hm35G11oz9z4Kp6zAuV/vNfZQ04qtSDbysKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VdgcgoeergCDouIrV1nvvln6G8qGZqym0xPwOwJRwjZtVX90kaCnZ5K+CnQAbndOO
	 o8BkfFrKyMB2cs+Bb38/NqU2l14/AV0blzH7G6UIlkprl/hzsWzsE7Di9Vg4/sH/eb
	 g0cAD5DDwTm8+xO/fT+erPEqmb1WuVUAfc6Cb2DLujkQdGWBKVG1x3K92QLbA+lQez
	 HImZS+YP8IglafCGRlQ/zqPLHtq4c5uCZmNx513FRwyB2Cvajpr7oxg2BPB+ZAd/Ol
	 1xBxcNYQHNSqD3fJfOgThFeMs9K2+lTFDRFHlnNEjNioDR2JkK4oCtG2O2Yd+ctP10
	 hMNAT1JKQmU0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Chuck Lever III <chuck.lever@oracle.com>,
	syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 058/451] do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak
Date: Sun, 24 Mar 2024 19:05:34 -0400
Message-ID: <20240324231207.1351418-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 3948abaa4e2be938ccdfc289385a27342fb13d43 ]

syzbot identified a kernel information leak vulnerability in
do_sys_name_to_handle() and issued the following report [1].

[1]
"BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:191 [inline]
 do_sys_name_to_handle fs/fhandle.c:73 [inline]
 __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
 __se_sys_name_to_handle_at+0x949/0xb10 fs/fhandle.c:94
 __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
 ...

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 do_sys_name_to_handle fs/fhandle.c:39 [inline]
 __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
 __se_sys_name_to_handle_at+0x441/0xb10 fs/fhandle.c:94
 __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
 ...

Bytes 18-19 of 20 are uninitialized
Memory access of size 20 starts at ffff888128a46380
Data copied to user address 0000000020000240"

Per Chuck Lever's suggestion, use kzalloc() instead of kmalloc() to
solve the problem.

Fixes: 990d6c2d7aee ("vfs: Add name to file handle conversion support")
Suggested-by: Chuck Lever III <chuck.lever@oracle.com>
Reported-and-tested-by: <syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com>
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Link: https://lore.kernel.org/r/20240119153906.4367-1-n.zhandarovich@fintech.ru
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index f2bc27d1975e1..a8c25557c8c12 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -37,7 +37,7 @@ static long do_sys_name_to_handle(const struct path *path,
 	if (f_handle.handle_bytes > MAX_HANDLE_SZ)
 		return -EINVAL;
 
-	handle = kmalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
+	handle = kzalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
 			 GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
-- 
2.43.0


