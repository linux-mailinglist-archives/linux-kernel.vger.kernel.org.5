Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4D37DD998
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376892AbjKAAYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjKAAYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:24:36 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26648ED;
        Tue, 31 Oct 2023 17:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698798274; x=1730334274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C1ijJfA84sdw2N5xqDWTVIUJa7Os+IAgqDYcgevk44w=;
  b=eWgmUK49qdcbFUnxQ8elqgHmorqrTCZFOCKpuNfW3+m+7osuaoDYkjgZ
   V7OcT+cviT6HxPw+1rBMkb1mPBqV33joOedMpO7H6HhujeAAX0REVgeqy
   CXXBVfAFvomGTTGOV93oEJZSi6HoUx7Xw/NRp0kQZLnThymWLsvPmQIZd
   k=;
X-IronPort-AV: E=Sophos;i="6.03,266,1694736000"; 
   d="scan'208";a="40092128"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:24:33 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com (Postfix) with ESMTPS id 56176804B2;
        Wed,  1 Nov 2023 00:24:31 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:44159]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.252:2525] with esmtp (Farcaster)
 id a6afe38b-6f63-4009-be6e-39d7d5250157; Wed, 1 Nov 2023 00:24:30 +0000 (UTC)
X-Farcaster-Flow-ID: a6afe38b-6f63-4009-be6e-39d7d5250157
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 1 Nov 2023 00:24:30 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.111.85.42) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 1 Nov 2023 00:24:29 +0000
From:   Suraj Jitindar Singh <surajjs@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <surajjs@amazon.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <george.kennedy@oracle.com>,
        <linux-kernel@vger.kernel.org>, <sjitindarsingh@gmail.com>
Subject: [PATCH stable 4.14.y] vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF
Date:   Tue, 31 Oct 2023 17:24:21 -0700
Message-ID: <20231101002421.1674851-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.111.85.42]
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D030UWB002.ant.amazon.com (10.13.139.182)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Kennedy <george.kennedy@oracle.com>

commit 226fae124b2dac217ea5436060d623ff3385bc34 upstream.

After a call to console_unlock() in vcs_read() the vc_data struct can be
freed by vc_deallocate(). Because of that, the struct vc_data pointer
load must be done at the top of while loop in vcs_read() to avoid a UAF
when vcs_size() is called.

Syzkaller reported a UAF in vcs_size().

BUG: KASAN: use-after-free in vcs_size (drivers/tty/vt/vc_screen.c:215)
Read of size 4 at addr ffff8881137479a8 by task 4a005ed81e27e65/1537

CPU: 0 PID: 1537 Comm: 4a005ed81e27e65 Not tainted 6.2.0-rc5 #1
Hardware name: Red Hat KVM, BIOS 1.15.0-2.module
Call Trace:
  <TASK>
__asan_report_load4_noabort (mm/kasan/report_generic.c:350)
vcs_size (drivers/tty/vt/vc_screen.c:215)
vcs_read (drivers/tty/vt/vc_screen.c:415)
vfs_read (fs/read_write.c:468 fs/read_write.c:450)
...
  </TASK>

Allocated by task 1191:
...
kmalloc_trace (mm/slab_common.c:1069)
vc_allocate (./include/linux/slab.h:580 ./include/linux/slab.h:720
     drivers/tty/vt/vt.c:1128 drivers/tty/vt/vt.c:1108)
con_install (drivers/tty/vt/vt.c:3383)
tty_init_dev (drivers/tty/tty_io.c:1301 drivers/tty/tty_io.c:1413
     drivers/tty/tty_io.c:1390)
tty_open (drivers/tty/tty_io.c:2080 drivers/tty/tty_io.c:2126)
chrdev_open (fs/char_dev.c:415)
do_dentry_open (fs/open.c:883)
vfs_open (fs/open.c:1014)
...

Freed by task 1548:
...
kfree (mm/slab_common.c:1021)
vc_port_destruct (drivers/tty/vt/vt.c:1094)
tty_port_destructor (drivers/tty/tty_port.c:296)
tty_port_put (drivers/tty/tty_port.c:312)
vt_disallocate_all (drivers/tty/vt/vt_ioctl.c:662 (discriminator 2))
vt_ioctl (drivers/tty/vt/vt_ioctl.c:903)
tty_ioctl (drivers/tty/tty_io.c:2776)
...

The buggy address belongs to the object at ffff888113747800
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 424 bytes inside of
  1024-byte region [ffff888113747800, ffff888113747c00)

The buggy address belongs to the physical page:
page:00000000b3fe6c7c refcount:1 mapcount:0 mapping:0000000000000000
     index:0x0 pfn:0x113740
head:00000000b3fe6c7c order:3 compound_mapcount:0 subpages_mapcount:0
     compound_pincount:0
anon flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0010200 ffff888100042dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888113747880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888113747900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888113747980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff888113747a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888113747a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Disabling lock debugging due to kernel taint

Fixes: ac751efa6a0d ("console: rename acquire/release_console_sem() to console_lock/unlock()")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Link: https://lore.kernel.org/r/1674577014-12374-1-git-send-email-george.kennedy@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ 4.14: Adjust context ]
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 drivers/tty/vt/vc_screen.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 42c9ef64108f..aa67730f5cc6 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -219,10 +219,6 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	console_lock();
 
 	attr = (currcons & 128);
-	ret = -ENXIO;
-	vc = vcs_vc(inode, &viewed);
-	if (!vc)
-		goto unlock_out;
 
 	ret = -EINVAL;
 	if (pos < 0)
@@ -238,6 +234,11 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		ssize_t orig_count;
 		long p = pos;
 
+		ret = -ENXIO;
+		vc = vcs_vc(inode, &viewed);
+		if (!vc)
+			goto unlock_out;
+
 		/* Check whether we are above size each round,
 		 * as copy_to_user at the end of this loop
 		 * could sleep.
-- 
2.34.1

