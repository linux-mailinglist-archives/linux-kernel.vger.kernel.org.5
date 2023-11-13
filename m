Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D007EA141
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjKMQ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjKMQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:29:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9654EDB;
        Mon, 13 Nov 2023 08:29:54 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4CAF01F854;
        Mon, 13 Nov 2023 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699892993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FhLEf7PwUl5m1a6zkQ/7/27iUHODDboH6M40W8JHdbg=;
        b=UaZYMI7fmc5dY6+fAUmur29QFSk+cLMFaOLXgt8dnhHZwFF8MMWjv4dDSujWTHtnExnPCj
        F4e9Y2GaSfvuPYGa/KPjzxmCXabr411j3h5tqTC2sT8mjM2xfIWhYyXF7jt9FRjlyXAZz0
        gIgr9ijskWfttixffU8GmjQ3FHYvov8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2C2D22C1BA;
        Mon, 13 Nov 2023 16:29:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F7C4DA86C; Mon, 13 Nov 2023 17:22:49 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.7-rc2
Date:   Mon, 13 Nov 2023 17:22:47 +0100
Message-ID: <cover.1699891630.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please pull the following fixes that accumulated in the past weeks.

- fix potential overflow in returned value from SEARCH_TREE_V2 ioctl on
  32bit architecture

- zoned mode fixes

  - drop unnecessary write pointer check for RAID0/RAID1/RAID10
    profiles, now it works because of raid-stripe-tree

  - wait for finishing the zone when direct IO needs a new allocation

- simple quota fixes

  - pass correct owning root pointer when cleaning up an aborted
    transaction

  - fix leaking some structures when processing delayed refs

  - change key type number of BTRFS_EXTENT_OWNER_REF_KEY, reorder it
    before inline refs that are supposed to be sorted, keeping the
    original number would complicate a lot of things; this change needs
    an updated version of btrfs-progs to work and filesystems need to be
    recreated

- fix error pointer dereference after failure to allocate fs devices

- fix race between accounting qgroup extents and removing a qgroup

----------------------------------------------------------------
The following changes since commit c6e8f898f56fae2cb5bc4396bec480f23cd8b066:

  btrfs: open code timespec64 in struct btrfs_inode (2023-10-12 16:44:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc1-tag

for you to fetch changes up to d3933152442b7f94419e9ea71835d71b620baf0e:

  btrfs: make OWNER_REF_KEY type value smallest among inline refs (2023-11-09 14:02:12 +0100)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: make OWNER_REF_KEY type value smallest among inline refs

Dan Carpenter (1):
      btrfs: directly return 0 on no error code in btrfs_insert_raid_extent()

Filipe Manana (4):
      btrfs: use u64 for buffer sizes in the tree search ioctls
      btrfs: fix error pointer dereference after failure to allocate fs devices
      btrfs: fix race between accounting qgroup extents and removing a qgroup
      btrfs: fix qgroup record leaks when using simple quotas

Josef Bacik (1):
      btrfs: get correct owning_root when dropping snapshot

Naohiro Aota (2):
      btrfs: zoned: drop no longer valid write pointer check
      btrfs: zoned: wait for data BG to be finished on direct IO allocation

Qu Wenruo (1):
      btrfs: make found_logical_ret parameter mandatory for function queue_scrub_stripe()

 fs/btrfs/ctree.c                |  2 +-
 fs/btrfs/delayed-ref.c          |  4 ++--
 fs/btrfs/extent-tree.c          | 25 +++++++++++++++++--------
 fs/btrfs/extent-tree.h          |  3 ++-
 fs/btrfs/inode.c                |  7 +++++++
 fs/btrfs/ioctl.c                | 10 +++++-----
 fs/btrfs/qgroup.c               | 10 ++++++++--
 fs/btrfs/raid-stripe-tree.c     |  2 +-
 fs/btrfs/scrub.c                | 10 +++++++---
 fs/btrfs/volumes.c              |  6 +++---
 fs/btrfs/zoned.c                |  7 -------
 include/uapi/linux/btrfs_tree.h | 24 ++++++++++++++++--------
 12 files changed, 69 insertions(+), 41 deletions(-)
