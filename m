Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5353D758649
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGRUu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGRUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A227DBD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 370A660F61
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9939C433C8;
        Tue, 18 Jul 2023 20:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689713421;
        bh=wdHcO86GhIiXHF8rYMzNJ7fSVisTzDsPgf8QmB0zTrE=;
        h=From:Subject:Date:To:Cc:From;
        b=oxgDB8IrFIoMskhEA9683+Pjhn1hNY8uYX5JFhBunsvS8kI2S0drZu33H/yVHS6nO
         LukFOdQq+A6k0S6g+3aFhq5GP2MTu3+XN9o33BD8Yy/hRdmMHE9XlSaoLaEJGjXheq
         XYQ+TugLJUnFbfuLanIVvdhjkPRwZJN8QBb0U2dgIyqF4U8PVpiRcZF0cKjXCrb8Vp
         KdQtF/jltp3fvRge+lnZahxjWHhjNwkYPOzhozMjpCqucaLhXwf75XHMcdum5HsbAs
         +bTmcrjFtOQga6MaibR3ri4VSy3WRkEhDdZXMOwDwnunRQCjTl1JvHq6v+zXp6bB5P
         zrSXi5JVyRlow==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v2 0/4] fs/9p: fix mmap regression
Date:   Tue, 18 Jul 2023 20:50:14 +0000
Message-Id: <20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAb7tmQC/42OSw6DMAwFr4Kyrtt8VKBd9R4Vi5AaiAoJcqIIh
 Lh7Ayfowovxs+Z5YwHJYmDPYmOEyQbrXQZ5KZgZtOsR7Cczk1wqXokSOrtgAJ+QxhUIQyRrok0
 I06RnUFxLdecCq7pi2dHqgNCSdmY4LLnLpOHWeQKHSzwuZsJTmeN3k3mwIXpaz4eSOLb/dicBH
 HhZq1bmeSj5+iI5HK+eetbs+/4D/XYt4+0AAAA=
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3777; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=wdHcO86GhIiXHF8rYMzNJ7fSVisTzDsPgf8QmB0zTrE=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBktvsMrcekCj24zWkZnXxLVRFqlqjVKY04bE5XE
 iVYCi6mEuiJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLb7DAAKCRCI/9X7Sl//
 mNmUD/4/yx7xZG0er5JytNqJ3MLZKALZf1s48ZgC7jHkCVAn+JZlStZgewXeqB+8Iv3KgjahhDc
 fkpQdoPARCesauILsbEueOYUQNzyhH9oCon9WOl3G5t/EORpyRApKoPGczhMOQXdVmGufqCeOrQ
 jodQCvD3cSbi9TGiZefSUTxZL86X6wikARFZH0UOfU9/2GUr7+cS01jD2uwXDmKZKhZgpFR8MY/
 ymJaR1bBk7/EJESGOuGFa2xqPvPM4BDzerwsEz24xs10Pi3mywoTJlE72V4piVxinnHlEn5MUHd
 xkIpDE7SoRum85MB5K49sOngOh7FA9p2nXkFfgNuzCKuV9jb20aly8pnjHpckJawSUnA3b1g2J6
 gziuajTTL9pHGKDT8kNpFZZMC9IKf8Em8KuqiNIcYORo+fNErQLYdaUYiApQdYEt+zJ7cNjPy5N
 EbfzSkIx4BWZO16w1tm+8M/7664iFWmVr8GVUGdj3DepnEJUyT5vvm+YDeATPO23w4J48HmZN79
 Rr5vzeXaD04sKuLrCs004s+ZcQ1k8QrTM8LIslqM8w0H275KCJBXE45MbEK8MsNtFWxOFHPxGhV
 jxD17yNyRKAbVRkKiUUtF5R290ex9Htuhj2plY282H5fHOvtzya7BqjU+EoBSVY8jmE2Xgso+RI
 q+hTj38zAnljIHw==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to fix a reported exception with mmap
on newer kernels. 

original regression report follows:

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

Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
Changes in v2:
- fix requested changes in commit messages
- add patch to remove unnecessary invalidate_inode_pages in mmap readonly path
- Link to v1: https://lore.kernel.org/r/20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org

---
Eric Van Hensbergen (4):
      fs/9p: remove unnecessary and overrestrictive check
      fs/9p: fix typo in comparison logic for cache mode
      fs/9p: fix type mismatch in file cache mode helper
      fs/9p: remove unnecessary invalidate_inode_pages2

 fs/9p/fid.h      | 6 +++---
 fs/9p/vfs_file.c | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)
---
base-commit: 95f41d87810083d8b3dedcce46a4e356cf4a9673
change-id: 20230716-fixes-overly-restrictive-mmap-30a23501e787

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

