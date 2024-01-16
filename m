Return-Path: <linux-kernel+bounces-26724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD20C82E597
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCD71C22669
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547711CAAC;
	Tue, 16 Jan 2024 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3rEbTqF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A41CAA0;
	Tue, 16 Jan 2024 00:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB40C43399;
	Tue, 16 Jan 2024 00:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364659;
	bh=elxGgaAJp91wigfr4MN4CaHWnMDnWa3eqNr7Po8FhTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3rEbTqFBq/uSovCDKtRiDxBJ5h82K0MkvbXVkR5OpP8kqHfmj0RGIWkv+JezTUQY
	 QT05cZwgxoLDpWKoFKDUvXjqnp96SXo4zkVhIdFZUbuxiPFtkXTawP/nECtA0WvQHY
	 HvqI8y3+FQZbuVZ5mYaFfMXdkJ+Aa/0Zm/OSzTZK95xeDwqhf14nVKUPjt4b6NcSi1
	 liJ6wDxEVP4QSx38u56XNNRryEHweWnHhyMPLFkKRRDJzslQs2RA75vTL213Bm1N90
	 1+KbbL+uV4aNoT421RS9PwRie/Vvd1285tFG3s9r8PMEPE0/1nwk2Rl7I6rShevt2/
	 UhC9/cIXsdFUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Osama Muhammad <osmtendev@gmail.com>,
	syzbot+d4b1df2e9d4ded6488ec@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	ghandatmanas@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 02/19] UBSAN: array-index-out-of-bounds in dtSplitRoot
Date: Mon, 15 Jan 2024 19:23:37 -0500
Message-ID: <20240116002413.215163-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002413.215163-1-sashal@kernel.org>
References: <20240116002413.215163-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Osama Muhammad <osmtendev@gmail.com>

[ Upstream commit 27e56f59bab5ddafbcfe69ad7a4a6ea1279c1b16 ]

Syzkaller reported the following issue:

oop0: detected capacity change from 0 to 32768

UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:1971:9
index -2 is out of range for type 'struct dtslot [128]'
CPU: 0 PID: 3613 Comm: syz-executor270 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 dtSplitRoot+0x8d8/0x1900 fs/jfs/jfs_dtree.c:1971
 dtSplitUp fs/jfs/jfs_dtree.c:985 [inline]
 dtInsert+0x1189/0x6b80 fs/jfs/jfs_dtree.c:863
 jfs_mkdir+0x757/0xb00 fs/jfs/namei.c:270
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
 do_mkdirat+0x279/0x550 fs/namei.c:4038
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcdc0113fd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb8bc67d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcdc0113fd9
RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000003
RBP: 00007fcdc00d37a0 R08: 0000000000000000 R09: 00007fcdc00d37a0
R10: 00005555559a72c0 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00083878000000f8 R15: 0000000000000000
 </TASK>

The issue is caused when the value of fsi becomes less than -1.
The check to break the loop when fsi value becomes -1 is present
but syzbot was able to produce value less than -1 which cause the error.
This patch simply add the change for the values less than 0.

The patch is tested via syzbot.

Reported-and-tested-by: syzbot+d4b1df2e9d4ded6488ec@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=d4b1df2e9d4ded6488ec
Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 92b7c533407c..f3d3e8b3f50c 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -1970,7 +1970,7 @@ static int dtSplitRoot(tid_t tid,
 		do {
 			f = &rp->slot[fsi];
 			fsi = f->next;
-		} while (fsi != -1);
+		} while (fsi >= 0);
 
 		f->next = n;
 	}
-- 
2.43.0


