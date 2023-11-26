Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9107D7F9460
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjKZREk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:04:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF14FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:04:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DD0C433C8;
        Sun, 26 Nov 2023 17:04:43 +0000 (UTC)
Date:   Sun, 26 Nov 2023 18:04:41 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.7-rc3
Message-ID: <ZWN6qUkUEewrKNOe@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this patchset fixes and enforces correct section alignments for the ex_table,
altinstructions, parisc_unwind, jump_table and bug_table which are created by
inline assembly.
Due to not being correctly aligned at link & load time they can trigger
unnecessarily the kernel unaligned exception handler at runtime.
While at it, I switched the bug table to use relative addresses which reduces
the size of the table by half on 64-bit.

We still had the ENOSYM and EREMOTERELEASE errno symbols as left-overs from
HP-UX, which now trigger build-issues with glibc. We can simply remove them.

Most of the patches are tagged for stable kernel series.

Please pull.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc3

for you to fetch changes up to 43266838515d30dc0c45d5c7e6e7edacee6cce92:

  parisc: Reduce size of the bug_table on 64-bit kernel by half (2023-11-25 09:43:18 +0100)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.7-rc3:

- Drop HP-UX ENOSYM and EREMOTERELEASE return codes to avoid glibc
  build issues
- Fix section alignments for ex_table, altinstructions, parisc unwind
  table, jump_table and bug_table
- Reduce size of bug_table on 64-bit kernel by using relative
  pointers

----------------------------------------------------------------
Helge Deller (9):
      parisc: Mark ex_table entries 32-bit aligned in assembly.h
      parisc: Mark ex_table entries 32-bit aligned in uaccess.h
      parisc: Mark altinstructions read-only and 32-bit aligned
      parisc: Mark jump_table naturally aligned
      parisc: Mark lock_aligned variables 16-byte aligned on SMP
      parisc: Ensure 32-bit alignment on parisc unwind section
      parisc: Use natural CPU alignment for bug_table
      parisc: Drop the HP-UX ENOSYM and EREMOTERELEASE error codes
      parisc: Reduce size of the bug_table on 64-bit kernel by half

 arch/parisc/Kconfig                        |  7 ++++--
 arch/parisc/include/asm/alternative.h      |  9 ++++---
 arch/parisc/include/asm/assembly.h         |  1 +
 arch/parisc/include/asm/bug.h              | 38 +++++++++++++++++-------------
 arch/parisc/include/asm/jump_label.h       |  8 +++++--
 arch/parisc/include/asm/ldcw.h             |  2 +-
 arch/parisc/include/asm/uaccess.h          |  1 +
 arch/parisc/include/uapi/asm/errno.h       |  2 --
 arch/parisc/kernel/vmlinux.lds.S           |  1 +
 lib/errname.c                              |  6 -----
 tools/arch/parisc/include/uapi/asm/errno.h |  2 --
 11 files changed, 43 insertions(+), 34 deletions(-)
