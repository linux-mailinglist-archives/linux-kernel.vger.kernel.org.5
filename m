Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7F797C34
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344289AbjIGSrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbjIGSq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:46:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D78C9D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:46:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2B7F150C;
        Thu,  7 Sep 2023 02:14:07 -0700 (PDT)
Received: from entos-thunderx2-desktop.shanghai.arm.com (entos-thunderx2-desktop.shanghai.arm.com [10.169.214.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21FF03F64C;
        Thu,  7 Sep 2023 02:13:26 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     axboe@kernel.dk, akpm@linux-foundation.org, brauner@kernel.org
Cc:     loic.poulain@linaro.org, wsa+renesas@sang-engineering.com,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        jianyong.wu@arm.com
Subject: [PATCH] init/mount: print pretty name of root device when panics
Date:   Thu,  7 Sep 2023 09:10:25 +0000
Message-Id: <20230907091025.3436878-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given a wrong root device, current log may not give the pretty name
which is useful to locate root cause.

For example, there are 2 blk devs in a VM, /dev/vda which has 2 partitials
/dev/vda1 and /dev/vda2 and /dev/vdb which is blank. /dev/vda2 is the
right root dev. When set "root=/dev/vdb", we get error log:

[    0.635575] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(254,16)

It's not straightforward to find out the root cause as there is lack of
the root devive name therefore hard for people to get those info from the
device number, in the example, (254,16).

It is more comprehensive way to hint the root cause if pretty name is
given here, like:

[    0.559887] Kernel panic - not syncing: VFS: Unable to mount root fs on "/dev/vdb" or unknown-block(254,16)

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 init/do_mounts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5dfd30b13f48..5fdef94f0864 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -244,7 +244,7 @@ void __init mount_root_generic(char *name, char *pretty_name, int flags)
 	for (i = 0, p = fs_names; i < num_fs; i++, p += strlen(p)+1)
 		printk(" %s", p);
 	printk("\n");
-	panic("VFS: Unable to mount root fs on %s", b);
+	panic("VFS: Unable to mount root fs on \"%s\" or %s", pretty_name, b);
 out:
 	put_page(page);
 }
-- 
2.34.1

