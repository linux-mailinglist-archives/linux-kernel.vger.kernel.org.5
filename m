Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09574756921
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjGQQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjGQQ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A0F191
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87CB561158
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ECFC433C9;
        Mon, 17 Jul 2023 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689611344;
        bh=ir2LRgwhWi4ddtv8rgCcqYVWlrMeJGpwfocr8iIy/p0=;
        h=From:Subject:Date:To:Cc:From;
        b=mnk12LJ8GBaji2fyDjGy+8fAySY4YwyOjBpW0oaXHYjvUU0iAhY8oK/Ez39XgP1T/
         7X+zqaN2yT42eTvUffoghcIhRycYipGSmSswS9D8E0TdmajM0rj45UypsKuuuFgpqU
         AoX8/0gP/zxHnCrf33cLp6elS1hKdr4D5aUx/oZK+jYhT824dn9TIWeIN4IfNWr0km
         trvEEOU0UhIs/IpjCmr17UdeYz4AKb+QIBIQ+/Jg837igJbximk3ExrouShyMghYFd
         Z+qFAw+2DpA30MLWjYLy1xWMHdXSgjPApCAOiEtwuUJUCvTumQHGRzs0dnjO0BAuKj
         XwLOOTOS+G8AQ==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH 0/3] fs/9p: fix mmap regression
Date:   Mon, 17 Jul 2023 16:28:59 +0000
Message-Id: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtstWQC/x2NywrCMBBFf6XM2sE80Ii/Ii7SODUDNimTECql/
 27q8nAu525QSJgK3IcNhBoXzqmDPg0Qok9vQn51BqOMVU5fceKVCuZG8vmiUKnCoXIjnGe/oFX
 e2IvS5G4OemP0hXAUn0I8Kv0rtHiesmCitR6LReif7Prx3PcfZ2pKZpEAAAA=
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3483; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=ir2LRgwhWi4ddtv8rgCcqYVWlrMeJGpwfocr8iIy/p0=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBktWxPQJSgRV4xsEEKPHjs0tbPSygZninqK7doV
 eyCkR+8stuJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLVsTwAKCRCI/9X7Sl//
 mB9mD/9RXa+T/k/O9N2lPCYTgxbX0W1ZFhGcx2k8wdrzF+wmcRd6/P2nWPaXyd8gs7SqgFik5iN
 D4K8La5WWZzIXhpoKrBWb8GoN3x0s59fHvoQ1gonxZk9/2OOUDUNyjdUClp0P60jfz0fIuEKeM8
 H69ib/nC7mdT4dZiBOFvdASU8ZhnLVE9Aeq0AxlzweK1n903BTlI07j36kCX4gZhml8lD6YVBAe
 TnrDnbxaLgysdKGbVayWyRG6FCkeTMPTUj7y33thzFKCqvmSysDu52LqyObGBNGMf3UyBgPdGyi
 9Kd4qn5WangonqrENWg0triLY1GmYxFwzsV6t3Q4n3GAY96+wk+rfonvt+sQFMQcXbikqRbElvQ
 7nYED1WuxawH/GqJZsMEdWMg3RcYIrqY6Iexw/ZT5X2VTtz0mUdGUj367nzGUOzRfHWB2F16E7W
 JddWvB190ub2NQ+fa3Gl4SQk3a76lwxHQtodYa+QoUzl39YRJ6IOj5DD+2uNpvkYn2m/K7yiQ80
 9Xb/ZNyNxGtHfcMeJDH45NmV7Ma3dzmw3xAqu0lG00nArsL0bz8QyqmQi/4lrRZEGwG/8Ak9/6L
 t1P7PTstKI7oJPREw5xdQWp7zIosPtbhk6PWbcwx6eyW7kZSR+hIbJU1HHLIjCATUAHmLPyWad1
 ZyxutFZKkv/rmGA==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to fix a reported exception with mmap
on newer kernels. 

-- original regression report --

TL;DR: mmap() seems to be broken on 9pfs on Linux 6.4. setting
"rootflags=ignoreqv" fixes it as well, but it feels like a regression.

I'm tracking down an issue which recently turned up in DistroKit [1] (an
embedded Linux distro based on the ptxdist build system). The issue was a bit
uggly, as my CI didn't find it (systems boot up normally after a while, and I
only use 9p for virtual qemu machines, while most of the test farm is real
hardware).

The qemu machine in question is qemu-system-arm, emulating an ARM v7a machine.

When starting the systems interactively, I get a lot of error output from
ldconfig, like this:

[   17.412964] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libgcc_s.so.1.
[   17.418851] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libstdc++.so.
[   17.425009] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libstdc++.so.6.0.30.
[   17.436671] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libstdc++.so.6.
[   17.448451] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libatomic.so.
[   17.456418] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libatomic.so.1.2.0.
...

Running ldconfig with strace shows this, for all libraries::

| statx(AT_FDCWD, "/lib/libnm.so.0", AT_STATX_SYNC_AS_STAT|AT_SYMLINK_NOFOLLOW|AT_NO_AUTOMOUNT, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFLNK|0777, stx_size=14, ...}) = 0
| statx(AT_FDCWD, "/lib/libnm.so.0", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|064 4, stx_size=862228, ...}) = 0
| openat(AT_FDCWD, "/lib/libnm.so.0", O_RDONLY|O_LARGEFILE) = 4
| statx(4, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0644, stx_s ize=862228, ...}) = 0
| mmap2(NULL, 862228, PROT_READ, MAP_SHARED, 4, 0) = -1 ENODEV (No such device)
| write(2, "ldconfig: ", 10ldconfig: )              = 10
| write(2, "Cannot mmap file /lib/libnm.so.0"..., 34Cannot mmap file /lib/libnm.so.0.) = 34
| write(2, "\n", 1)                       = 1
| close(4)                                = 0

I could track down the breakage to

  1543b4c5071c54d76aad7a7a26a6e43082269b0c

My test setup has, in addition to the patch above, the following patches also
reverted on top of a vanilla 6.4 kernel:

  4eb3117888a923f6b9b1ad2dd093641c49a63ae5
  21e26d5e54ab7cfe6b488fd27d4d70956d07e03b

as 1543b cannot be reverted without those; however, the effect only goes away
when I also revert 1543b. The kernel has no other patches applied, only these
three reverts.

-- end bug report --

Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
Eric Van Hensbergen (3):
      fs/9p: remove unecessary and overrestrictive check
      fs/9p: fix typo in comparison logic for cache mode
      fs/9p: fix type mismatch in file cache mode helper

 fs/9p/fid.h      | 6 +++---
 fs/9p/vfs_file.c | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)
---
base-commit: 95f41d87810083d8b3dedcce46a4e356cf4a9673
change-id: 20230716-fixes-overly-restrictive-mmap-30a23501e787

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

