Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FC18112FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379201AbjLMNd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379108AbjLMNdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:33:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A519C;
        Wed, 13 Dec 2023 05:33:31 -0800 (PST)
Received: from ds.suse.cz (unknown [10.100.12.205])
        by smtp-out1.suse.de (Postfix) with ESMTP id B811D220E9;
        Wed, 13 Dec 2023 13:33:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E3FF5DA7F1; Wed, 13 Dec 2023 14:26:39 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.7-rc6
Date:   Wed, 13 Dec 2023 14:26:37 +0100
Message-ID: <cover.1702473248.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 5.30
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 5.10
X-Spamd-Result: default: False [5.10 / 50.00];
         ARC_NA(0.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_DN_SOME(0.00)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
         RCVD_COUNT_ZERO(0.00)[0];
         MIME_TRACE(0.00)[0:+];
         FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz]
X-Spam-Flag: NO
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there are some fixes to quota accounting code, mostly around error
handling and correctness. Please pull, thanks.

- free reserves on various error paths, after IO errors or transaction
  abort

- don't clear reserved range at the folio release time, it'll be
  properly cleared after final write

- fix integer overflow due to int used when passing around size of freed
  reservations

- fix a regression in squota accounting that missed some cases with
  delayed refs

----------------------------------------------------------------
The following changes since commit 0ac1d13a55eb37d398b63e6ff6db4a09a2c9128c:

  btrfs: send: ensure send_fd is writable (2023-11-24 18:50:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc5-tag

for you to fetch changes up to e85a0adacf170634878fffcbf34b725aff3f49ed:

  btrfs: ensure releasing squota reserve on head refs (2023-12-06 22:32:57 +0100)

----------------------------------------------------------------
Boris Burkov (5):
      btrfs: free qgroup reserve when ORDERED_IOERR is set
      btrfs: fix qgroup_free_reserved_data int overflow
      btrfs: free qgroup pertrans reserve on transaction abort
      btrfs: don't clear qgroup reserved bit in release_folio
      btrfs: ensure releasing squota reserve on head refs

 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/disk-io.c        | 28 +++++++++++++++++++++++++++
 fs/btrfs/extent-tree.c    | 48 +++++++++++++++++++++++++++++++++--------------
 fs/btrfs/extent_io.c      |  3 ++-
 fs/btrfs/file.c           |  2 +-
 fs/btrfs/inode.c          | 16 ++++++++--------
 fs/btrfs/ordered-data.c   | 11 +++++++----
 fs/btrfs/qgroup.c         | 44 ++++++++++++++++++++++++++++---------------
 fs/btrfs/qgroup.h         |  7 +++----
 fs/btrfs/transaction.c    |  2 --
 fs/btrfs/transaction.h    |  3 +++
 11 files changed, 116 insertions(+), 50 deletions(-)
