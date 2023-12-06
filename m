Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA3C8068C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377085AbjLFHjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjLFHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:38:39 -0500
Received: from 13.mo582.mail-out.ovh.net (13.mo582.mail-out.ovh.net [188.165.56.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE4A1FCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:55 -0800 (PST)
Received: from director1.ghost.mail-out.ovh.net (unknown [10.109.143.223])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id E380226B8D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:18:26 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-q659j (unknown [10.110.115.40])
        by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 971DE1FD9C;
        Wed,  6 Dec 2023 07:18:25 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.95])
        by ghost-submission-6684bf9d7b-q659j with ESMTPSA
        id A1YgHUEgcGUGAgAAR7yEqA
        (envelope-from <jose.pekkarinen@foxhound.fi>); Wed, 06 Dec 2023 07:18:25 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-95G0017f6f2474-d401-4c27-b95a-0dbe6361eaae,
                    FCDADBFD6B1B663F5159E0C54ABC6405D1BD97D1) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.249.133.109
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     viro@zeniv.linux.org.uk
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        linux-kernel@vger.kernel.org,
        syzbot+cb729843d0f42a5c1a50@syzkaller.appspotmail.com
Subject: [PATCH RESEND] iov_iter: fix memleak in iov_iter_extract_pages
Date:   Wed,  6 Dec 2023 09:18:08 +0200
Message-Id: <20231206071808.7646-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2324420358037480968
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeevveeileeukeefjeevkeffudehhedtvdeuhffgteelvdejieefheffveelhfekheenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhenucfkphepuddvjedrtddrtddruddpkeejrddvgeelrddufeefrddutdelpdefjedrheelrddugedvrdelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reports there is a memory leak in iov_iter_extract_pages where in
the unlikely case of having an error in pin_user_pages_fast, the pages
aren't free. This patch will free it before returning. Output of mem
leak follows:

BUG: memory leak
unreferenced object 0xffff888109d2e400 (size 1024):
  comm "syz-executor121", pid 5006, jiffies 4294943225 (age 17.760s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81554bbb>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff81554bbb>] __kmalloc_node+0x4b/0x150 mm/slab_common.c:992
    [<ffffffff815440f9>] kmalloc_node include/linux/slab.h:602 [inline]
    [<ffffffff815440f9>] kvmalloc_node+0x99/0x170 mm/util.c:604
    [<ffffffff824c52fe>] kvmalloc include/linux/slab.h:720 [inline]
    [<ffffffff824c52fe>] kvmalloc_array include/linux/slab.h:738 [inline]
    [<ffffffff824c52fe>] want_pages_array lib/iov_iter.c:985 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_user_pages lib/iov_iter.c:1765 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_pages+0x1ee/0xa40 lib/iov_iter.c:1831
    [<ffffffff824125a7>] bio_map_user_iov+0x167/0x5d0 block/blk-map.c:297
    [<ffffffff82412df3>] blk_rq_map_user_iov+0x3e3/0xb30 block/blk-map.c:664
    [<ffffffff82413943>] blk_rq_map_user block/blk-map.c:691 [inline]
    [<ffffffff82413943>] blk_rq_map_user_io+0x143/0x160 block/blk-map.c:724
    [<ffffffff82ca0925>] sg_io+0x285/0x510 drivers/scsi/scsi_ioctl.c:456
    [<ffffffff82ca1025>] scsi_cdrom_send_packet+0x1b5/0x480 drivers/scsi/scsi_ioctl.c:820
    [<ffffffff82ca13ba>] scsi_ioctl+0xca/0xd30 drivers/scsi/scsi_ioctl.c:903
    [<ffffffff82d35964>] sg_ioctl+0x5f4/0x10a0 drivers/scsi/sg.c:1163
    [<ffffffff8168e602>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff8168e602>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff8168e602>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff8168e602>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:856
    [<ffffffff84ad2bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad2bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109d2dc00 (size 1024):
  comm "syz-executor121", pid 5007, jiffies 4294943747 (age 12.540s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81554bbb>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff81554bbb>] __kmalloc_node+0x4b/0x150 mm/slab_common.c:992
    [<ffffffff815440f9>] kmalloc_node include/linux/slab.h:602 [inline]
    [<ffffffff815440f9>] kvmalloc_node+0x99/0x170 mm/util.c:604
    [<ffffffff824c52fe>] kvmalloc include/linux/slab.h:720 [inline]
    [<ffffffff824c52fe>] kvmalloc_array include/linux/slab.h:738 [inline]
    [<ffffffff824c52fe>] want_pages_array lib/iov_iter.c:985 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_user_pages lib/iov_iter.c:1765 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_pages+0x1ee/0xa40 lib/iov_iter.c:1831
    [<ffffffff824125a7>] bio_map_user_iov+0x167/0x5d0 block/blk-map.c:297
    [<ffffffff82412df3>] blk_rq_map_user_iov+0x3e3/0xb30 block/blk-map.c:664
    [<ffffffff82413943>] blk_rq_map_user block/blk-map.c:691 [inline]
    [<ffffffff82413943>] blk_rq_map_user_io+0x143/0x160 block/blk-map.c:724
    [<ffffffff82ca0925>] sg_io+0x285/0x510 drivers/scsi/scsi_ioctl.c:456
    [<ffffffff82ca1025>] scsi_cdrom_send_packet+0x1b5/0x480 drivers/scsi/scsi_ioctl.c:820
    [<ffffffff82ca13ba>] scsi_ioctl+0xca/0xd30 drivers/scsi/scsi_ioctl.c:903
    [<ffffffff82d35964>] sg_ioctl+0x5f4/0x10a0 drivers/scsi/sg.c:1163
    [<ffffffff8168e602>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff8168e602>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff8168e602>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff8168e602>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:856
    [<ffffffff84ad2bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad2bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109d2d800 (size 1024):
  comm "syz-executor121", pid 5010, jiffies 4294944269 (age 7.320s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81554bbb>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff81554bbb>] __kmalloc_node+0x4b/0x150 mm/slab_common.c:992
    [<ffffffff815440f9>] kmalloc_node include/linux/slab.h:602 [inline]
    [<ffffffff815440f9>] kvmalloc_node+0x99/0x170 mm/util.c:604
    [<ffffffff824c52fe>] kvmalloc include/linux/slab.h:720 [inline]
    [<ffffffff824c52fe>] kvmalloc_array include/linux/slab.h:738 [inline]
    [<ffffffff824c52fe>] want_pages_array lib/iov_iter.c:985 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_user_pages lib/iov_iter.c:1765 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_pages+0x1ee/0xa40 lib/iov_iter.c:1831
    [<ffffffff824125a7>] bio_map_user_iov+0x167/0x5d0 block/blk-map.c:297
    [<ffffffff82412df3>] blk_rq_map_user_iov+0x3e3/0xb30 block/blk-map.c:664
    [<ffffffff82413943>] blk_rq_map_user block/blk-map.c:691 [inline]
    [<ffffffff82413943>] blk_rq_map_user_io+0x143/0x160 block/blk-map.c:724
    [<ffffffff82ca0925>] sg_io+0x285/0x510 drivers/scsi/scsi_ioctl.c:456
    [<ffffffff82ca1025>] scsi_cdrom_send_packet+0x1b5/0x480 drivers/scsi/scsi_ioctl.c:820
    [<ffffffff82ca13ba>] scsi_ioctl+0xca/0xd30 drivers/scsi/scsi_ioctl.c:903
    [<ffffffff82d35964>] sg_ioctl+0x5f4/0x10a0 drivers/scsi/sg.c:1163
    [<ffffffff8168e602>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff8168e602>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff8168e602>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff8168e602>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:856
    [<ffffffff84ad2bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad2bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Reported-by: syzbot+cb729843d0f42a5c1a50@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=99c8551967f413d108cfdd2950a0cb5652de07b8
Fixes: 7d58fe7310281 ("iov_iter: Add a function to extract a page list from an iterator")
Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 lib/iov_iter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 27234a820eeb..c3fd0448dead 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1780,8 +1780,10 @@ static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
 	if (!maxpages)
 		return -ENOMEM;
 	res = pin_user_pages_fast(addr, maxpages, gup_flags, *pages);
-	if (unlikely(res <= 0))
+	if (unlikely(res <= 0)) {
+		kvfree(*pages);
 		return res;
+	}
 	maxsize = min_t(size_t, maxsize, res * PAGE_SIZE - offset);
 	iov_iter_advance(i, maxsize);
 	return maxsize;
-- 
2.39.2

