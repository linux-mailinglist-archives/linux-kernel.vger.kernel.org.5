Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBCB7ABB46
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjIVVzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIVVzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:55:24 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C13783;
        Fri, 22 Sep 2023 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695419718; x=1726955718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=87E7mtfB2qX5W2uM6XS3drZgIYry5UgJKaVpkDfmn2Q=;
  b=W8zd4cB894rzlUpmrHDydw6opE6X7NfC7D1zOjMFDu7ukbWVyzrUiMM6
   qzvQg9oRlCeOKzkjTVbzWDGruD1FTPILPfuLdPjAnHimkwnWI/IyWWtsy
   bsRy8bjh8BnZd1JUwsoR25DmtfBSu2gvQj5SgZkKyEEk/PpaLi4VyO6tx
   8=;
X-IronPort-AV: E=Sophos;i="6.03,169,1694736000"; 
   d="scan'208";a="674035514"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 21:55:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id BC83380FAB;
        Fri, 22 Sep 2023 21:55:15 +0000 (UTC)
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 22 Sep 2023 21:55:14 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.187.171.29) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 22 Sep 2023 21:55:13 +0000
From:   Suraj Jitindar Singh <surajjs@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <sjitindarsingh@gmail.com>, <linux-kernel@vger.kernel.org>,
        <jslaby@suse.com>, George Kennedy <george.kennedy@oracle.com>,
        stable <stable@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>
Subject: [PATCH stable 4.14.y] vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF
Date:   Fri, 22 Sep 2023 14:55:02 -0700
Message-ID: <20230922215502.678169-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.187.171.29]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D030UWB002.ant.amazon.com (10.13.139.182)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Kennedy <george.kennedy@oracle.com>

commit 8fb9ea65c9d1338b0d2bb0a9122dc942cdd32357 upstream.

After a call to console_unlock() in vcs_write() the vc_data struct can be
freed by vc_port_destruct(). Because of that, the struct vc_data pointer
must be reloaded in the while loop in vcs_write() after console_lock() to
avoid a UAF when vcs_size() is called.

Syzkaller reported a UAF in vcs_size().

BUG: KASAN: slab-use-after-free in vcs_size (drivers/tty/vt/vc_screen.c:215)
Read of size 4 at addr ffff8880beab89a8 by task repro_vcs_size/4119

Call Trace:
 <TASK>
__asan_report_load4_noabort (mm/kasan/report_generic.c:380)
vcs_size (drivers/tty/vt/vc_screen.c:215)
vcs_write (drivers/tty/vt/vc_screen.c:664)
vfs_write (fs/read_write.c:582 fs/read_write.c:564)
...
 <TASK>

Allocated by task 1213:
kmalloc_trace (mm/slab_common.c:1064)
vc_allocate (./include/linux/slab.h:559 ./include/linux/slab.h:680
    drivers/tty/vt/vt.c:1078 drivers/tty/vt/vt.c:1058)
con_install (drivers/tty/vt/vt.c:3334)
tty_init_dev (drivers/tty/tty_io.c:1303 drivers/tty/tty_io.c:1415
    drivers/tty/tty_io.c:1392)
tty_open (drivers/tty/tty_io.c:2082 drivers/tty/tty_io.c:2128)
chrdev_open (fs/char_dev.c:415)
do_dentry_open (fs/open.c:921)
vfs_open (fs/open.c:1052)
...

Freed by task 4116:
kfree (mm/slab_common.c:1016)
vc_port_destruct (drivers/tty/vt/vt.c:1044)
tty_port_destructor (drivers/tty/tty_port.c:296)
tty_port_put (drivers/tty/tty_port.c:312)
vt_disallocate_all (drivers/tty/vt/vt_ioctl.c:662 (discriminator 2))
vt_ioctl (drivers/tty/vt/vt_ioctl.c:903)
tty_ioctl (drivers/tty/tty_io.c:2778)
...

The buggy address belongs to the object at ffff8880beab8800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 424 bytes inside of
 freed 1024-byte region [ffff8880beab8800, ffff8880beab8c00)

The buggy address belongs to the physical page:
page:00000000afc77580 refcount:1 mapcount:0 mapping:0000000000000000
    index:0x0 pfn:0xbeab8
head:00000000afc77580 order:3 entire_mapcount:0 nr_pages_mapped:0
    pincount:0
flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
page_type: 0xffffffff()
raw: 000fffffc0010200 ffff888100042dc0 ffffea000426de00 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880beab8880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880beab8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880beab8980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff8880beab8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880beab8a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Disabling lock debugging due to kernel taint

Fixes: ac751efa6a0d ("console: rename acquire/release_console_sem() to console_lock/unlock()")
Cc: stable <stable@kernel.org>
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/1683889728-10411-1-git-send-email-george.kennedy@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Adjust context due to missing commit
  71d4abfab322 ("vc_screen: rewrite vcs_size to accept vc, not inode")
  in 4.14.y stable ]
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 drivers/tty/vt/vc_screen.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 85b6634f518a..42c9ef64108f 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -437,10 +437,17 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 			}
 		}
 
-		/* The vcs_size might have changed while we slept to grab
-		 * the user buffer, so recheck.
+		/* The vc might have been freed or vcs_size might have changed
+		 * while we slept to grab the user buffer, so recheck.
 		 * Return data written up to now on failure.
 		 */
+		vc = vcs_vc(inode, &viewed);
+		if (!vc) {
+			if (written)
+				break;
+			ret = -ENXIO;
+			goto unlock_out;
+		}
 		size = vcs_size(inode);
 		if (size < 0) {
 			if (written)
-- 
2.34.1

