Return-Path: <linux-kernel+bounces-6299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C572E8196EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044851C2568C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B4125DC;
	Wed, 20 Dec 2023 02:46:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA211C88
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BK2k78m079129;
	Wed, 20 Dec 2023 10:46:07 +0800 (+08)
	(envelope-from Jing.Xia@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SvyT46H8Zz2PpYXS;
	Wed, 20 Dec 2023 10:39:52 +0800 (CST)
Received: from bj08259pcu.spreadtrum.com (10.0.73.196) by
 shmbx04.spreadtrum.com (10.0.1.214) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 20 Dec 2023 10:46:06 +0800
From: Jing Xia <jing.xia@unisoc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jing.xia.mail@gmail.com>,
        <xuewen.yan@unisoc.com>, <ke.wang@unisoc.com>,
        <chunyan.zhang@unisoc.com>
Subject: [PATCH V2] class: fix use-after-free in class_register()
Date: Wed, 20 Dec 2023 10:46:03 +0800
Message-ID: <20231220024603.186078-1-jing.xia@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL:SHSQR01.spreadtrum.com 3BK2k78m079129

The lock_class_key is still registered and can be found in
lock_keys_hash hlist after subsys_private is freed in error
handler path.A task who iterate over the lock_keys_hash
later may cause use-after-free.So fix that up and unregister
the lock_class_key before kfree(cp).

On our platform, a driver fails to kset_register because of
creating duplicate filename '/class/xxx'.With Kasan enabled,
it prints a invalid-access bug report.

KASAN bug report:

BUG: KASAN: invalid-access in lockdep_register_key+0x19c/0x1bc
Write of size 8 at addr 15ffff808b8c0368 by task modprobe/252
Pointer tag: [15], memory tag: [fe]

CPU: 7 PID: 252 Comm: modprobe Tainted: G        W
 6.6.0-mainline-maybe-dirty #1

Call trace:
dump_backtrace+0x1b0/0x1e4
show_stack+0x2c/0x40
dump_stack_lvl+0xac/0xe0
print_report+0x18c/0x4d8
kasan_report+0xe8/0x148
__hwasan_store8_noabort+0x88/0x98
lockdep_register_key+0x19c/0x1bc
class_register+0x94/0x1ec
init_module+0xbc/0xf48 [rfkill]
do_one_initcall+0x17c/0x72c
do_init_module+0x19c/0x3f8
...
Memory state around the buggy address:
ffffff808b8c0100: 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a
ffffff808b8c0200: 8a 8a 8a 8a 8a 8a 8a 8a fe fe fe fe fe fe fe fe
>ffffff808b8c0300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                                     ^
ffffff808b8c0400: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03

As CONFIG_KASAN_GENERIC is not set, Kasan reports invalid-access
not use-after-free here.In this case, modprobe is manipulating
the corrupted lock_keys_hash hlish where lock_class_key is already
freed before.

It's worth noting that this only can happen if lockdep is enabled,
which is not true for normal system.

Fixes: dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")
Signed-off-by: Jing Xia <jing.xia@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/base/class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 7e78aee0fd6c..7b38fdf8e1d7 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -213,6 +213,7 @@ int class_register(const struct class *cls)
 	return 0;
 
 err_out:
+	lockdep_unregister_key(key);
 	kfree(cp);
 	return error;
 }
-- 
2.25.1


