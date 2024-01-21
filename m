Return-Path: <linux-kernel+bounces-31982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD008354D8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 08:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D586E1C21B75
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4679364A8;
	Sun, 21 Jan 2024 07:35:39 +0000 (UTC)
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6769440;
	Sun, 21 Jan 2024 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.89.151.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705822539; cv=none; b=HabiM3DtUCkqjBFDerqd8zuV53QR4xNHGYWqyiOw43QA1AxSBKT8gr9qNBU5dpNiIQ1PPL5ckX9wIz4PyXPXEDbs1iEt5DGx9HVX+pLLkdviyzbCVS13p9HvPg6IzhJCh6gkuRhV4St++heIo/E6DHi0j99BSM/BPA0ptekfKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705822539; c=relaxed/simple;
	bh=1z3w3EMVjzHYdK/jgN7E1nPAR8qS7efsk0Wnz+TfAbQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ohaLkqLxIB1Wd49JL7kSaVBCTokJHXqwiH4ILBgS4krv19N98mZIUgncLQdWJv0Dyk2rVkqZg9aXxpYNUwjqfcKqs1ZAJEivar6sn5nUcTWJsk71hxu26JS5Ckf6vArGxoDhA5cePKAx1JW+/jKSt3ORqd3N2OAyvDaRUXoGLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=159.89.151.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [115.206.161.25])
	by mail-app3 (Coremail) with SMTP id cC_KCgCXnjktyaxlmz1lAA--.38522S4;
	Sun, 21 Jan 2024 15:35:10 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: linkinjeon@kernel.org,
	sfrench@samba.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	lsahlber@redhat.com,
	hyc.lee@gmail.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v1] ksmbd: fix global oob in ksmbd_nl_policy
Date: Sun, 21 Jan 2024 15:35:06 +0800
Message-Id: <20240121073506.84528-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgCXnjktyaxlmz1lAA--.38522S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4DJr4UGFy3Cw45AFyxKrg_yoW7ZF4fpa
	4DXF97Gr48Xry0qF17AFyUJw12qF1UZa4UGr4xKr18AF4rGw17JF1UtFnxtrnxCr90vr12
	q3WDZFs0yw15J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUU
	UU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Similar to a reported issue (check the commit b33fb5b801c6 ("net:
qualcomm: rmnet: fix global oob in rmnet_policy"), my local fuzzer finds
another global out-of-bounds read for policy ksmbd_nl_policy. See bug
trace below:

==================================================================
BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:386 [inline]
BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
Read of size 1 at addr ffffffff8f24b100 by task syz-executor.1/62810

CPU: 0 PID: 62810 Comm: syz-executor.1 Tainted: G                 N 6.1.0 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x172/0x475 mm/kasan/report.c:395
 kasan_report+0xbb/0x1c0 mm/kasan/report.c:495
 validate_nla lib/nlattr.c:386 [inline]
 __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
 __nla_parse+0x3e/0x50 lib/nlattr.c:697
 __nlmsg_parse include/net/netlink.h:748 [inline]
 genl_family_rcv_msg_attrs_parse.constprop.0+0x1b0/0x290 net/netlink/genetlink.c:565
 genl_family_rcv_msg_doit+0xda/0x330 net/netlink/genetlink.c:734
 genl_family_rcv_msg net/netlink/genetlink.c:833 [inline]
 genl_rcv_msg+0x441/0x780 net/netlink/genetlink.c:850
 netlink_rcv_skb+0x14f/0x410 net/netlink/af_netlink.c:2540
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:861
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x54e/0x800 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x930/0xe50 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0x154/0x190 net/socket.c:734
 ____sys_sendmsg+0x6df/0x840 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdd66a8f359
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd65e00168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdd66bbcf80 RCX: 00007fdd66a8f359
RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000003
RBP: 00007fdd66ada493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc84b81aff R14: 00007fdd65e00300 R15: 0000000000022000
 </TASK>

The buggy address belongs to the variable:
 ksmbd_nl_policy+0x100/0xa80

The buggy address belongs to the physical page:
page:0000000034f47940 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ccc4b
flags: 0x200000000001000(reserved|node=0|zone=2)
raw: 0200000000001000 ffffea00073312c8 ffffea00073312c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffffffff8f24b000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff8f24b080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffff8f24b100: f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9 00 00 07 f9
                   ^
 ffffffff8f24b180: f9 f9 f9 f9 00 05 f9 f9 f9 f9 f9 f9 00 00 00 05
 ffffffff8f24b200: f9 f9 f9 f9 00 00 03 f9 f9 f9 f9 f9 00 00 04 f9
==================================================================

To fix it, add a placeholder named __KSMBD_EVENT_MAX and let
KSMBD_EVENT_MAX to be its original value - 1 according to what other
netlink families do. Also change two sites that refer the
KSMBD_EVENT_MAX to correct value.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 fs/smb/server/ksmbd_netlink.h | 3 ++-
 fs/smb/server/transport_ipc.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index b7521e41402e..0ebf91ffa236 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -304,7 +304,8 @@ enum ksmbd_event {
 	KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST,
 	KSMBD_EVENT_SPNEGO_AUTHEN_RESPONSE	= 15,
 
-	KSMBD_EVENT_MAX
+	__KSMBD_EVENT_MAX,
+	KSMBD_EVENT_MAX = __KSMBD_EVENT_MAX - 1
 };
 
 /*
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index b49d47bdafc9..f29bb03f0dc4 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -74,7 +74,7 @@ static int handle_unsupported_event(struct sk_buff *skb, struct genl_info *info)
 static int handle_generic_event(struct sk_buff *skb, struct genl_info *info);
 static int ksmbd_ipc_heartbeat_request(void);
 
-static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX] = {
+static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX + 1] = {
 	[KSMBD_EVENT_UNSPEC] = {
 		.len = 0,
 	},
@@ -403,7 +403,7 @@ static int handle_generic_event(struct sk_buff *skb, struct genl_info *info)
 		return -EPERM;
 #endif
 
-	if (type >= KSMBD_EVENT_MAX) {
+	if (type > KSMBD_EVENT_MAX) {
 		WARN_ON(1);
 		return -EINVAL;
 	}
-- 
2.17.1


