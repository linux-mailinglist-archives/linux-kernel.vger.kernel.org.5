Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA89379D96A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjILTQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjILTQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:16:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72966C1;
        Tue, 12 Sep 2023 12:16:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B78C433C7;
        Tue, 12 Sep 2023 19:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694546161;
        bh=1B/YqhKkZLDmCMNMuAosUtGk5QHN9NXXS9k+cDsWH3o=;
        h=From:Subject:Date:To:Cc:From;
        b=LZv3sfD95nm2KEDBO21bnMb63wX0+2V/cOqFJo9GGBlo4GAK9zojsQKla24jnEmBC
         8Zi5WdfsTo8lN0dpWvZX6jfgq22TFR2YCd6bKXg9VSsC4CsmpIGgFqRhLyvutauscY
         0q03dweMoVDarZN4O/lTmJa1JDKwNbp0oii+ZX/Qhl3j4AzyM5A3sxdXGQzn/JYk0R
         +G3AswpHlSDXdig3xI8GO3+HY0k9BxcEgXt0yHJw4Dqe/lEjUQUnvgQTyjBSu3t0NF
         nt4VaTA9esjr+d0ygC1pP6g/Ij44GGmfVmUbcOCXhqDUkKObzp2jflosbGfLTwS5rb
         xpBfJILo2rPXA==
From:   Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/7] bcachefs compiler warning fixes for 32-bit
Date:   Tue, 12 Sep 2023 12:15:37 -0700
Message-Id: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANm4AGUC/x3LQQqAIBBA0avIrBtIBaOuEi1Mx5qNhQMVhHdPW
 j4+/wWhwiQwqRcKXSx85AbdKQi7zxshx2YwvbH9qA2uwYedkuDtS+a8YeKHBJO2LrloLQ0a2nw
 W+kN756XWD2WD1O9oAAAA
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=23439; i=nathan@kernel.org;
 h=from:subject:message-id; bh=1B/YqhKkZLDmCMNMuAosUtGk5QHN9NXXS9k+cDsWH3o=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKkMO973VV5iXN/7ML040+GziMgGv9v5gqXepwRU/NX3B
 by++3pHRykLgxgHg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjI9T2MDHujjIr29GzYqyHL
 +XbqPCH7Ptac70/n5j6TWqD675v19seMDLOeV4n/OuXgXnltx2zFKY89L0rNfhn1dVWm/oZTe47
 GivIDAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a series of fixes for warnings that I now see from bcachefs when
building my test matrix with LLVM in -next, mostly from 32-bit
architectures. Most of the patches should be uncontroversial; the
min_t/max_t changes are probably the worst ones.

I still see several instances of -Wframe-larger-than when building for
32-bit ARM (I am sure they will show up on other 32-bit architectures as
well), which I am not entirely sure how to tackle. It looks like the
majority of the instances are just due to large structures on the stack
in combination with some inlining resulting in some spills, so it seems
like moving to a heap allocation for some of those would the right fix
but I know some maintainers would rather fix them in their own way,
hence just the report. I have included the compiler output (clang and
GCC in some cases) along with the output of clang's
-Rpass-analysis=stack-frame-layout, which helps with seeing where the
extra stack usage comes from. Tallying up the larger variables shows
that most of these functions are pushing the 32-bit limit of 1024 bytes
without any inlining (+/- 50-100 bytes in majority of cases).

===

fs/bcachefs/fs-common.c:356:5: error: stack frame size (1128) exceeds limit (1024) in 'bch2_rename_trans' [-Werror,-Wframe-larger-than]
  356 | int bch2_rename_trans(struct btree_trans *trans,
      |     ^

fs/bcachefs/fs-common.c:364:1: remark: 
Function: bch2_rename_trans
Offset: [SP+52], Type: Variable, Align: 4, Size: 4
Offset: [SP+48], Type: Variable, Align: 8, Size: 4
Offset: [SP+44], Type: Variable, Align: 4, Size: 4
Offset: [SP+40], Type: Variable, Align: 8, Size: 4
Offset: [SP+36], Type: Variable, Align: 4, Size: 4
Offset: [SP+32], Type: Variable, Align: 8, Size: 40
Offset: [SP+28], Type: Variable, Align: 4, Size: 4
Offset: [SP+24], Type: Variable, Align: 8, Size: 4
Offset: [SP+20], Type: Variable, Align: 4, Size: 4
Offset: [SP+16], Type: Variable, Align: 8, Size: 4
Offset: [SP+8], Type: Variable, Align: 8, Size: 4
Offset: [SP+4], Type: Variable, Align: 4, Size: 4
Offset: [SP+0], Type: Variable, Align: 8, Size: 4
Offset: [SP-4], Type: Spill, Align: 4, Size: 4
Offset: [SP-8], Type: Spill, Align: 4, Size: 4
Offset: [SP-12], Type: Spill, Align: 4, Size: 4
Offset: [SP-16], Type: Spill, Align: 4, Size: 4
Offset: [SP-20], Type: Spill, Align: 4, Size: 4
Offset: [SP-24], Type: Spill, Align: 4, Size: 4
Offset: [SP-28], Type: Spill, Align: 4, Size: 4
Offset: [SP-32], Type: Spill, Align: 4, Size: 4
Offset: [SP-36], Type: Spill, Align: 4, Size: 4
Offset: [SP-40], Type: Variable, Align: 4, Size: 4
Offset: [SP-44], Type: Protector, Align: 4, Size: 4
Offset: [SP-424], Type: Variable, Align: 8, Size: 376
Offset: [SP-456], Type: Variable, Align: 8, Size: 32
Offset: [SP-576], Type: Variable, Align: 8, Size: 120
Offset: [SP-696], Type: Variable, Align: 8, Size: 120
Offset: [SP-816], Type: Variable, Align: 8, Size: 120
Offset: [SP-936], Type: Variable, Align: 8, Size: 120
Offset: [SP-960], Type: Variable, Align: 8, Size: 24
Offset: [SP-984], Type: Variable, Align: 8, Size: 24
Offset: [SP-1000], Type: Variable, Align: 8, Size: 16
Offset: [SP-1016], Type: Variable, Align: 8, Size: 16
Offset: [SP-1024], Type: Variable, Align: 8, Size: 8
Offset: [SP-1032], Type: Variable, Align: 8, Size: 8
Offset: [SP-1036], Type: Spill, Align: 4, Size: 4
Offset: [SP-1040], Type: Spill, Align: 4, Size: 4
Offset: [SP-1044], Type: Spill, Align: 4, Size: 4
Offset: [SP-1048], Type: Spill, Align: 4, Size: 4
Offset: [SP-1052], Type: Spill, Align: 4, Size: 4
Offset: [SP-1056], Type: Spill, Align: 4, Size: 4
Offset: [SP-1060], Type: Spill, Align: 4, Size: 4
Offset: [SP-1064], Type: Spill, Align: 4, Size: 4 [-Rpass-analysis=stack-frame-layout]
  364 | {
      | ^

===

fs/bcachefs/reflink.c:244:5: error: stack frame size (1256) exceeds limit (1024) in 'bch2_remap_range' [-Werror,-Wframe-larger-than]
  244 | s64 bch2_remap_range(struct bch_fs *c,
      |     ^

fs/bcachefs/reflink.c: In function 'bch2_remap_range':
fs/bcachefs/reflink.c:399:1: error: the frame size of 1192 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
  399 | }
      | ^

fs/bcachefs/reflink.c:249:1: remark: 
Function: bch2_remap_range
Offset: [SP+56], Type: Variable, Align: 8, Size: 4
Offset: [SP+52], Type: Variable, Align: 4, Size: 4
Offset: [SP+48], Type: Variable, Align: 8, Size: 4
Offset: [SP+44], Type: Variable, Align: 4, Size: 4
Offset: [SP+40], Type: Variable, Align: 8, Size: 4
Offset: [SP+36], Type: Variable, Align: 4, Size: 4
Offset: [SP+32], Type: Variable, Align: 8, Size: 4
Offset: [SP+28], Type: Variable, Align: 4, Size: 4
Offset: [SP+24], Type: Variable, Align: 8, Size: 4
Offset: [SP+20], Type: Variable, Align: 4, Size: 4
Offset: [SP+16], Type: Variable, Align: 8, Size: 4
Offset: [SP+12], Type: Variable, Align: 4, Size: 4
Offset: [SP+8], Type: Variable, Align: 8, Size: 4
Offset: [SP+4], Type: Variable, Align: 4, Size: 4
Offset: [SP+0], Type: Variable, Align: 8, Size: 4
Offset: [SP-4], Type: Spill, Align: 4, Size: 4
Offset: [SP-8], Type: Spill, Align: 4, Size: 4
Offset: [SP-12], Type: Spill, Align: 4, Size: 4
Offset: [SP-16], Type: Spill, Align: 4, Size: 4
Offset: [SP-20], Type: Spill, Align: 4, Size: 4
Offset: [SP-24], Type: Spill, Align: 4, Size: 4
Offset: [SP-28], Type: Spill, Align: 4, Size: 4
Offset: [SP-32], Type: Spill, Align: 4, Size: 4
Offset: [SP-36], Type: Spill, Align: 4, Size: 4
Offset: [SP-40], Type: Variable, Align: 4, Size: 4
Offset: [SP-44], Type: Protector, Align: 4, Size: 4
Offset: [SP-360], Type: Variable, Align: 8, Size: 312
Offset: [SP-464], Type: Variable, Align: 8, Size: 104
Offset: [SP-568], Type: Variable, Align: 8, Size: 104
Offset: [SP-688], Type: Variable, Align: 8, Size: 120
Offset: [SP-808], Type: Variable, Align: 8, Size: 120
Offset: [SP-968], Type: Variable, Align: 8, Size: 160
Offset: [SP-1088], Type: Variable, Align: 8, Size: 120
Offset: [SP-1096], Type: Variable, Align: 4, Size: 8
Offset: [SP-1100], Type: Variable, Align: 4, Size: 4
Offset: [SP-1104], Type: Variable, Align: 4, Size: 4
Offset: [SP-1108], Type: Spill, Align: 4, Size: 4
Offset: [SP-1112], Type: Spill, Align: 4, Size: 4
Offset: [SP-1116], Type: Spill, Align: 4, Size: 4
Offset: [SP-1120], Type: Spill, Align: 4, Size: 4
Offset: [SP-1124], Type: Spill, Align: 4, Size: 4
Offset: [SP-1128], Type: Spill, Align: 4, Size: 4
Offset: [SP-1132], Type: Spill, Align: 4, Size: 4
Offset: [SP-1136], Type: Spill, Align: 4, Size: 4
Offset: [SP-1140], Type: Spill, Align: 4, Size: 4
Offset: [SP-1144], Type: Spill, Align: 4, Size: 4
Offset: [SP-1148], Type: Spill, Align: 4, Size: 4
Offset: [SP-1152], Type: Spill, Align: 4, Size: 4
Offset: [SP-1156], Type: Spill, Align: 4, Size: 4
Offset: [SP-1160], Type: Spill, Align: 4, Size: 4
Offset: [SP-1164], Type: Spill, Align: 4, Size: 4
Offset: [SP-1168], Type: Spill, Align: 4, Size: 4
Offset: [SP-1172], Type: Spill, Align: 4, Size: 4
Offset: [SP-1176], Type: Spill, Align: 4, Size: 4
Offset: [SP-1180], Type: Spill, Align: 4, Size: 4
Offset: [SP-1184], Type: Spill, Align: 4, Size: 4
Offset: [SP-1188], Type: Spill, Align: 4, Size: 4
Offset: [SP-1192], Type: Spill, Align: 4, Size: 4
Offset: [SP-1196], Type: Spill, Align: 4, Size: 4
Offset: [SP-1200], Type: Spill, Align: 4, Size: 4
Offset: [SP-1204], Type: Spill, Align: 4, Size: 4
Offset: [SP-1208], Type: Spill, Align: 4, Size: 4
Offset: [SP-1212], Type: Spill, Align: 4, Size: 4
Offset: [SP-1216], Type: Spill, Align: 4, Size: 4 [-Rpass-analysis=stack-frame-layout]
  249 | {
      | ^

===

fs/bcachefs/recovery.c: In function 'bch2_fs_initialize':
fs/bcachefs/recovery.c:1057:1: error: the frame size of 1096 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
 1057 | }
      | ^

fs/bcachefs/recovery.c:924:5: error: stack frame size (1184) exceeds limit (1024) in 'bch2_fs_initialize' [-Werror,-Wframe-larger-than]
  924 | int bch2_fs_initialize(struct bch_fs *c)
      |     ^

fs/bcachefs/recovery.c:925:1: remark: 
Function: bch2_fs_initialize
Offset: [SP-4], Type: Spill, Align: 4, Size: 4
Offset: [SP-8], Type: Spill, Align: 4, Size: 4
Offset: [SP-12], Type: Spill, Align: 4, Size: 4
Offset: [SP-16], Type: Spill, Align: 4, Size: 4
Offset: [SP-20], Type: Spill, Align: 4, Size: 4
Offset: [SP-24], Type: Spill, Align: 4, Size: 4
Offset: [SP-28], Type: Spill, Align: 4, Size: 4
Offset: [SP-32], Type: Spill, Align: 4, Size: 4
Offset: [SP-36], Type: Spill, Align: 4, Size: 4
Offset: [SP-40], Type: Variable, Align: 4, Size: 4
Offset: [SP-44], Type: Protector, Align: 4, Size: 4
Offset: [SP-440], Type: Variable, Align: 8, Size: 392
Offset: [SP-752], Type: Variable, Align: 8, Size: 312
Offset: [SP-912], Type: Variable, Align: 8, Size: 160
Offset: [SP-1072], Type: Variable, Align: 8, Size: 160
Offset: [SP-1088], Type: Variable, Align: 8, Size: 16
Offset: [SP-1092], Type: Variable, Align: 4, Size: 4
Offset: [SP-1096], Type: Spill, Align: 4, Size: 4
Offset: [SP-1100], Type: Spill, Align: 4, Size: 4
Offset: [SP-1104], Type: Spill, Align: 4, Size: 4
Offset: [SP-1108], Type: Spill, Align: 4, Size: 4
Offset: [SP-1112], Type: Spill, Align: 4, Size: 4
Offset: [SP-1116], Type: Spill, Align: 4, Size: 4 [-Rpass-analysis=stack-frame-layout]
  925 | {
      | ^

===

fs/bcachefs/fs.c: In function 'bch2_rename2':
fs/bcachefs/fs.c:639:1: error: the frame size of 1072 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
  639 | }
      | ^

fs/bcachefs/fs.c:534:12: error: stack frame size (1096) exceeds limit (1024) in 'bch2_rename2' [-Werror,-Wframe-larger-than]
  534 | static int bch2_rename2(struct mnt_idmap *idmap,
      |            ^

fs/bcachefs/fs.c:538:1: remark: 
Function: bch2_rename2
Offset: [SP+4], Type: Variable, Align: 4, Size: 4
Offset: [SP+0], Type: Variable, Align: 8, Size: 4
Offset: [SP-4], Type: Spill, Align: 4, Size: 4
Offset: [SP-8], Type: Spill, Align: 4, Size: 4
Offset: [SP-12], Type: Spill, Align: 4, Size: 4
Offset: [SP-16], Type: Spill, Align: 4, Size: 4
Offset: [SP-20], Type: Spill, Align: 4, Size: 4
Offset: [SP-24], Type: Spill, Align: 4, Size: 4
Offset: [SP-28], Type: Spill, Align: 4, Size: 4
Offset: [SP-32], Type: Spill, Align: 4, Size: 4
Offset: [SP-36], Type: Spill, Align: 4, Size: 4
Offset: [SP-40], Type: Variable, Align: 4, Size: 4
Offset: [SP-44], Type: Protector, Align: 4, Size: 4
Offset: [SP-360], Type: Variable, Align: 8, Size: 312
Offset: [SP-520], Type: Variable, Align: 8, Size: 160
Offset: [SP-680], Type: Variable, Align: 8, Size: 160
Offset: [SP-840], Type: Variable, Align: 8, Size: 160
Offset: [SP-1000], Type: Variable, Align: 8, Size: 160
Offset: [SP-1004], Type: Spill, Align: 4, Size: 4
Offset: [SP-1008], Type: Spill, Align: 4, Size: 4
Offset: [SP-1012], Type: Spill, Align: 4, Size: 4
Offset: [SP-1016], Type: Spill, Align: 4, Size: 4
Offset: [SP-1020], Type: Spill, Align: 4, Size: 4
Offset: [SP-1024], Type: Spill, Align: 4, Size: 4
Offset: [SP-1028], Type: Spill, Align: 4, Size: 4
Offset: [SP-1032], Type: Spill, Align: 4, Size: 4
Offset: [SP-1036], Type: Spill, Align: 4, Size: 4 [-Rpass-analysis=stack-frame-layout]
  538 | {
      | ^

===

fs/bcachefs/fs-io.c: In function 'bchfs_fcollapse_finsert':
fs/bcachefs/fs-io.c:749:1: error: the frame size of 1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
  749 | }
      | ^

fs/bcachefs/fs-io.c:573:13: error: stack frame size (1088) exceeds limit (1024) in 'bchfs_fcollapse_finsert' [-Werror,-Wframe-larger-than]
  573 | static long bchfs_fcollapse_finsert(struct bch_inode_info *inode,
      |             ^

fs/bcachefs/fs-io.c:576:1: remark: 
Function: bchfs_fcollapse_finsert
Offset: [SP+8], Type: Variable, Align: 8, Size: 4
Offset: [SP+4], Type: Variable, Align: 4, Size: 4
Offset: [SP+0], Type: Variable, Align: 8, Size: 4
Offset: [SP-4], Type: Spill, Align: 4, Size: 4
Offset: [SP-8], Type: Spill, Align: 4, Size: 4
Offset: [SP-12], Type: Spill, Align: 4, Size: 4
Offset: [SP-16], Type: Spill, Align: 4, Size: 4
Offset: [SP-20], Type: Spill, Align: 4, Size: 4
Offset: [SP-24], Type: Spill, Align: 4, Size: 4
Offset: [SP-28], Type: Spill, Align: 4, Size: 4
Offset: [SP-32], Type: Spill, Align: 4, Size: 4
Offset: [SP-36], Type: Spill, Align: 4, Size: 4
Offset: [SP-40], Type: Variable, Align: 4, Size: 4
Offset: [SP-44], Type: Protector, Align: 4, Size: 4
Offset: [SP-152], Type: Variable, Align: 8, Size: 104
Offset: [SP-464], Type: Variable, Align: 8, Size: 312
Offset: [SP-584], Type: Variable, Align: 8, Size: 120
Offset: [SP-704], Type: Variable, Align: 8, Size: 120
Offset: [SP-824], Type: Variable, Align: 8, Size: 120
Offset: [SP-864], Type: Variable, Align: 8, Size: 40
Offset: [SP-880], Type: Variable, Align: 8, Size: 16
Offset: [SP-904], Type: Variable, Align: 8, Size: 20
Offset: [SP-908], Type: Variable, Align: 4, Size: 4
Offset: [SP-916], Type: Variable, Align: 4, Size: 8
Offset: [SP-920], Type: Spill, Align: 4, Size: 4
Offset: [SP-924], Type: Spill, Align: 4, Size: 4
Offset: [SP-928], Type: Spill, Align: 4, Size: 4
Offset: [SP-932], Type: Spill, Align: 4, Size: 4
Offset: [SP-936], Type: Spill, Align: 4, Size: 4
Offset: [SP-940], Type: Spill, Align: 4, Size: 4
Offset: [SP-944], Type: Spill, Align: 4, Size: 4
Offset: [SP-948], Type: Spill, Align: 4, Size: 4
Offset: [SP-952], Type: Spill, Align: 4, Size: 4
Offset: [SP-956], Type: Spill, Align: 4, Size: 4
Offset: [SP-960], Type: Spill, Align: 4, Size: 4
Offset: [SP-964], Type: Spill, Align: 4, Size: 4
Offset: [SP-968], Type: Spill, Align: 4, Size: 4
Offset: [SP-972], Type: Spill, Align: 4, Size: 4
Offset: [SP-976], Type: Spill, Align: 4, Size: 4
Offset: [SP-980], Type: Spill, Align: 4, Size: 4
Offset: [SP-984], Type: Spill, Align: 4, Size: 4
Offset: [SP-988], Type: Spill, Align: 4, Size: 4
Offset: [SP-992], Type: Spill, Align: 4, Size: 4
Offset: [SP-996], Type: Spill, Align: 4, Size: 4
Offset: [SP-1000], Type: Spill, Align: 4, Size: 4
Offset: [SP-1004], Type: Spill, Align: 4, Size: 4
Offset: [SP-1008], Type: Spill, Align: 4, Size: 4
Offset: [SP-1012], Type: Spill, Align: 4, Size: 4
Offset: [SP-1016], Type: Spill, Align: 4, Size: 4
Offset: [SP-1020], Type: Spill, Align: 4, Size: 4
Offset: [SP-1024], Type: Spill, Align: 4, Size: 4
Offset: [SP-1028], Type: Spill, Align: 4, Size: 4
Offset: [SP-1032], Type: Spill, Align: 4, Size: 4
Offset: [SP-1036], Type: Spill, Align: 4, Size: 4
Offset: [SP-1040], Type: Spill, Align: 4, Size: 4
Offset: [SP-1044], Type: Spill, Align: 4, Size: 4
Offset: [SP-1048], Type: Spill, Align: 4, Size: 4
Offset: [SP-1052], Type: Spill, Align: 4, Size: 4
Offset: [SP-1056], Type: Spill, Align: 4, Size: 4 [-Rpass-analysis=stack-frame-layout]
  576 | {
      | ^

===

fs/bcachefs/fsck.c:1806:5: error: stack frame size (1232) exceeds limit (1024) in 'bch2_check_dirents' [-Werror,-Wframe-larger-than]
 1806 | int bch2_check_dirents(struct bch_fs *c)
      |     ^

fs/bcachefs/fsck.c:1807:1: remark: 
Function: bch2_check_dirents
Offset: [SP-4], Type: Spill, Align: 4, Size: 4
Offset: [SP-8], Type: Spill, Align: 4, Size: 4
Offset: [SP-12], Type: Spill, Align: 4, Size: 4
Offset: [SP-16], Type: Spill, Align: 4, Size: 4
Offset: [SP-20], Type: Spill, Align: 4, Size: 4
Offset: [SP-24], Type: Spill, Align: 4, Size: 4
Offset: [SP-28], Type: Spill, Align: 4, Size: 4
Offset: [SP-32], Type: Spill, Align: 4, Size: 4
Offset: [SP-36], Type: Spill, Align: 4, Size: 4
Offset: [SP-40], Type: Variable, Align: 4, Size: 4
Offset: [SP-44], Type: Protector, Align: 4, Size: 4
Offset: [SP-424], Type: Variable, Align: 8, Size: 376
Offset: [SP-464], Type: Variable, Align: 8, Size: 40
Offset: [SP-776], Type: Variable, Align: 8, Size: 312
Offset: [SP-816], Type: Variable, Align: 8, Size: 36
Offset: [SP-856], Type: Variable, Align: 8, Size: 36
Offset: [SP-896], Type: Variable, Align: 8, Size: 36
Offset: [SP-1016], Type: Variable, Align: 8, Size: 120
Offset: [SP-1020], Type: Variable, Align: 4, Size: 4
Offset: [SP-1056], Type: Variable, Align: 8, Size: 32
Offset: [SP-1080], Type: Variable, Align: 8, Size: 24
Offset: [SP-1084], Type: Spill, Align: 4, Size: 4
Offset: [SP-1088], Type: Spill, Align: 4, Size: 4
Offset: [SP-1092], Type: Spill, Align: 4, Size: 4
Offset: [SP-1096], Type: Spill, Align: 4, Size: 4
Offset: [SP-1100], Type: Spill, Align: 4, Size: 4
Offset: [SP-1104], Type: Spill, Align: 4, Size: 4
Offset: [SP-1108], Type: Spill, Align: 4, Size: 4
Offset: [SP-1112], Type: Spill, Align: 4, Size: 4
Offset: [SP-1116], Type: Spill, Align: 4, Size: 4
Offset: [SP-1120], Type: Spill, Align: 4, Size: 4
Offset: [SP-1124], Type: Spill, Align: 4, Size: 4
Offset: [SP-1128], Type: Spill, Align: 4, Size: 4
Offset: [SP-1132], Type: Spill, Align: 4, Size: 4
Offset: [SP-1136], Type: Spill, Align: 4, Size: 4
Offset: [SP-1140], Type: Spill, Align: 4, Size: 4
Offset: [SP-1144], Type: Spill, Align: 4, Size: 4
Offset: [SP-1148], Type: Spill, Align: 4, Size: 4
Offset: [SP-1152], Type: Spill, Align: 4, Size: 4
Offset: [SP-1156], Type: Spill, Align: 4, Size: 4
Offset: [SP-1160], Type: Spill, Align: 4, Size: 4
Offset: [SP-1164], Type: Spill, Align: 4, Size: 4
Offset: [SP-1168], Type: Spill, Align: 4, Size: 4
Offset: [SP-1172], Type: Spill, Align: 4, Size: 4
Offset: [SP-1176], Type: Spill, Align: 4, Size: 4
Offset: [SP-1180], Type: Spill, Align: 4, Size: 4
Offset: [SP-1184], Type: Spill, Align: 4, Size: 4
Offset: [SP-1188], Type: Spill, Align: 4, Size: 4
Offset: [SP-1192], Type: Spill, Align: 4, Size: 4
Offset: [SP-1196], Type: Spill, Align: 4, Size: 4 [-Rpass-analysis=stack-frame-layout]
 1807 | {
      | ^

===

fs/bcachefs/fsck.c:1878:5: error: stack frame size (1040) exceeds limit (1024) in 'bch2_check_xattrs' [-Werror,-Wframe-larger-than]
 1878 | int bch2_check_xattrs(struct bch_fs *c)
      |     ^

fs/bcachefs/fsck.c:1879:1: remark: 
Function: bch2_check_xattrs
Offset: [SP-4], Type: Spill, Align: 4, Size: 4
Offset: [SP-8], Type: Spill, Align: 4, Size: 4
Offset: [SP-12], Type: Spill, Align: 4, Size: 4
Offset: [SP-16], Type: Spill, Align: 4, Size: 4
Offset: [SP-20], Type: Spill, Align: 4, Size: 4
Offset: [SP-24], Type: Spill, Align: 4, Size: 4
Offset: [SP-28], Type: Spill, Align: 4, Size: 4
Offset: [SP-32], Type: Spill, Align: 4, Size: 4
Offset: [SP-36], Type: Spill, Align: 4, Size: 4
Offset: [SP-40], Type: Variable, Align: 4, Size: 4
Offset: [SP-44], Type: Protector, Align: 4, Size: 4
Offset: [SP-424], Type: Variable, Align: 8, Size: 376
Offset: [SP-456], Type: Variable, Align: 8, Size: 32
Offset: [SP-768], Type: Variable, Align: 8, Size: 312
Offset: [SP-808], Type: Variable, Align: 8, Size: 36
Offset: [SP-928], Type: Variable, Align: 8, Size: 120
Offset: [SP-952], Type: Variable, Align: 8, Size: 24
Offset: [SP-956], Type: Spill, Align: 4, Size: 4
Offset: [SP-960], Type: Spill, Align: 4, Size: 4
Offset: [SP-964], Type: Spill, Align: 4, Size: 4
Offset: [SP-968], Type: Spill, Align: 4, Size: 4
Offset: [SP-972], Type: Spill, Align: 4, Size: 4
Offset: [SP-976], Type: Spill, Align: 4, Size: 4
Offset: [SP-980], Type: Spill, Align: 4, Size: 4
Offset: [SP-984], Type: Spill, Align: 4, Size: 4
Offset: [SP-988], Type: Spill, Align: 4, Size: 4
Offset: [SP-992], Type: Spill, Align: 4, Size: 4
Offset: [SP-996], Type: Spill, Align: 4, Size: 4
Offset: [SP-1000], Type: Spill, Align: 4, Size: 4
Offset: [SP-1004], Type: Spill, Align: 4, Size: 4
Offset: [SP-1008], Type: Spill, Align: 4, Size: 4 [-Rpass-analysis=stack-frame-layout]
 1879 | {
      | ^

===

fs/bcachefs/fsck.c:359:12: error: stack frame size (1040) exceeds limit (1024) in 'reattach_inode' [-Werror,-Wframe-larger-than]
  359 | static int reattach_inode(struct btree_trans *trans,
      |            ^

fs/bcachefs/fsck.c:362:1: remark: 
Function: reattach_inode
Offset: [SP-4], Type: Spill, Align: 4, Size: 4
Offset: [SP-8], Type: Spill, Align: 4, Size: 4
Offset: [SP-12], Type: Spill, Align: 4, Size: 4
Offset: [SP-16], Type: Spill, Align: 4, Size: 4
Offset: [SP-20], Type: Spill, Align: 4, Size: 4
Offset: [SP-24], Type: Spill, Align: 4, Size: 4
Offset: [SP-28], Type: Spill, Align: 4, Size: 4
Offset: [SP-32], Type: Spill, Align: 4, Size: 4
Offset: [SP-36], Type: Spill, Align: 4, Size: 4
Offset: [SP-40], Type: Variable, Align: 4, Size: 4
Offset: [SP-44], Type: Protector, Align: 4, Size: 4
Offset: [SP-424], Type: Variable, Align: 8, Size: 376
Offset: [SP-456], Type: Variable, Align: 8, Size: 32
Offset: [SP-616], Type: Variable, Align: 8, Size: 160
Offset: [SP-640], Type: Variable, Align: 8, Size: 20
Offset: [SP-648], Type: Variable, Align: 4, Size: 8
Offset: [SP-664], Type: Variable, Align: 8, Size: 16
Offset: [SP-668], Type: Variable, Align: 4, Size: 4
Offset: [SP-696], Type: Variable, Align: 8, Size: 24
Offset: [SP-856], Type: Variable, Align: 8, Size: 160
Offset: [SP-872], Type: Variable, Align: 8, Size: 16
Offset: [SP-880], Type: Variable, Align: 8, Size: 8
Offset: [SP-884], Type: Spill, Align: 4, Size: 4
Offset: [SP-888], Type: Spill, Align: 4, Size: 4
Offset: [SP-892], Type: Spill, Align: 4, Size: 4
Offset: [SP-896], Type: Spill, Align: 4, Size: 4
Offset: [SP-900], Type: Spill, Align: 4, Size: 4
Offset: [SP-904], Type: Spill, Align: 4, Size: 4
Offset: [SP-908], Type: Spill, Align: 4, Size: 4
Offset: [SP-912], Type: Spill, Align: 4, Size: 4
Offset: [SP-916], Type: Spill, Align: 4, Size: 4
Offset: [SP-920], Type: Spill, Align: 4, Size: 4
Offset: [SP-924], Type: Spill, Align: 4, Size: 4
Offset: [SP-928], Type: Spill, Align: 4, Size: 4
Offset: [SP-932], Type: Spill, Align: 4, Size: 4
Offset: [SP-936], Type: Spill, Align: 4, Size: 4
Offset: [SP-940], Type: Spill, Align: 4, Size: 4
Offset: [SP-944], Type: Spill, Align: 4, Size: 4
Offset: [SP-948], Type: Spill, Align: 4, Size: 4
Offset: [SP-952], Type: Spill, Align: 4, Size: 4
Offset: [SP-956], Type: Spill, Align: 4, Size: 4
Offset: [SP-960], Type: Spill, Align: 4, Size: 4
Offset: [SP-964], Type: Spill, Align: 4, Size: 4
Offset: [SP-968], Type: Spill, Align: 4, Size: 4 [-Rpass-analysis=stack-frame-layout]
  362 | {
      | ^

---
Nathan Chancellor (7):
      bcachefs: Fix -Wformat in bch2_set_bucket_needs_journal_commit()
      bcachefs: Fix -Wformat in bch2_btree_key_cache_to_text()
      bcachefs: Fix -Wformat in bch2_alloc_v4_invalid()
      bcachefs: Fix -Wformat in bch2_bucket_gens_invalid()
      bcachefs: Fix -Wincompatible-function-pointer-types-strict from key_invalid callbacks
      bcachefs: Fix -Wcompare-distinct-pointer-types in do_encrypt()
      bcachefs: Fix -Wcompare-distinct-pointer-types in bch2_copygc_get_buckets()

 fs/bcachefs/alloc_background.c            |  4 ++--
 fs/bcachefs/bkey_methods.c                | 10 +++++-----
 fs/bcachefs/btree_key_cache.c             |  2 +-
 fs/bcachefs/buckets_waiting_for_journal.c |  2 +-
 fs/bcachefs/checksum.c                    |  2 +-
 fs/bcachefs/movinggc.c                    |  2 +-
 fs/bcachefs/subvolume.c                   |  2 +-
 fs/bcachefs/subvolume.h                   |  2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)
---
base-commit: e7e6c4189f70ab2d7c21eaec5b9e9c34527ef349
change-id: 20230912-bcachefs-warning-fixes-f136f6d33e71

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

