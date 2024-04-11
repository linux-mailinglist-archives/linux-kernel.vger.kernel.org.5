Return-Path: <linux-kernel+bounces-139668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA378A063E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D9F1C23693
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C8A13B585;
	Thu, 11 Apr 2024 02:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eSnqlqEp"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314CD626DD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804078; cv=none; b=e++VHruemMvvhMY7nrTyZU8kr0P6a1rsPzpRPZ53yuo9UwT0D89frmxHBjNYjvRyf1WjlFa4jooXw2SV1+MaNk1AUZ8WHlcjoGdaFi6rHoOLWyXrydFOAQR1vQyYCdyJrgm+iel0XhbdBMTwBGBO2QDXEmXAjccSsYXKMRqW2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804078; c=relaxed/simple;
	bh=uXsuN4wUwAIfsSO+WFyJIu8o15W+PXoOTYaGu0BkidI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SuZJBoIO1wCy62HsBVuQUuj+GDANKll0wGmykVcQ5HqRNva75ETNNXnPL6J4zDTMjm0uR7fYZB89KV1rQm8kn3DC9uVys4XMEFri6Kx2jA8m6Aq5UcpLMbrdfDyuoO/JH/1B5En/Fo9FPzy1g1BV1fhSognYVDBTQNOj0sXpcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eSnqlqEp; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 10 Apr 2024 22:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712804070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JaNPtXr0mm+bEAmXMp73DrXvXkWEkPC0u2C6L0pm1Wo=;
	b=eSnqlqEpD9xe76X0eJ1LfdeRuszqbVEsG9vjQ3zGn3C1As9+jZX2I97VBot7qnL8z/Y61y
	wjvwuV2nb8E6PphsSV4B8D3fdEAGh1nOF+gPuzf0knxdK7RL4/WLUfFCSfkXCc4Qc0kRLe
	/eOm3FszzAZ38qX5TVr4SPZTxg5Vlnc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for rc4
Message-ID: <woux55cy6ms6exoa43hg745ftfo6msc3bsnjge3te2c4pvdzmf@57wrbdc5pp7s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, another batch of fixes for you...

And on the subject of the rc3 announcement - yes, let's please dial back
the excitement _just_ a bit, it's seemed a bit unhinged at times;
bcachefs is still marked as experimental for a reason.

You shouldn't be running bcachefs just yet if you'll be sad if things
are offline for a bit (where a bit has been for a few people a week or
two); IOW, this is still very much for early adopters and people who are
willing and able to help test and debug.

Worst case scenario you're not going to lose data, as long as you can be
patient, but I'm still debugging issues where we get stuck in recovery
(= filesystem offline).

That said - things are coming together quite nicely. Will have more to
say at LSF...

----------------------------------------------------------------

The following changes since commit 09d4c2acbf4c864fef0f520bbcba256c9a19102e:

  bcachefs: reconstruct_inode() (2024-04-03 14:46:51 -0400)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-10

for you to fetch changes up to 1189bdda6c991cbf9342d84410042dd5f3a792e0:

  bcachefs: Fix __bch2_btree_and_journal_iter_init_node_iter() (2024-04-10 22:28:36 -0400)

----------------------------------------------------------------
bcachefs fixes for v6.9-rc4

Notable user impacting bugs

- On multi device filesystems, recovery was looping in
  btree_trans_too_many_iters(). This checks if a transaction has touched
  too many btree paths (because of iteration over many keys), and isuses
  a restart to drop unneeded paths. But it's now possible for some paths
  to exceed the previous limit without iteration in the interior btree
  update path, since the transaction commit will do alloc updates for
  every old and new btree node, and during journal replay we don't use
  the btree write buffer for locking reasons and thus those updates use
  btree paths when they wouldn't normally.

- Fix a corner case in rebalance when moving extents on a durability=0
  device. This wouldn't be hit when a device was formatted with
  durability=0 since in that case we'll only use it as a write through
  cache (only cached extents will live on it), but durability can now be
  changed on an existing device.

- bch2_get_acl() could rarely forget to handle a transaction restart;
  this manifested as the occasional missing acl that came back after
  dropping caches.

- Fix a major performance regression on high iops multithreaded write
  workloads (only since 6.9-rc1); a previous fix for a deadlock in the
  interior btree update path to check the journal watermark introduced a
  dependency on the state of btree write buffer flushing that we didn't
  want.

- Assorted other repair paths and recovery fixes.

----------------------------------------------------------------
Bagas Sanjaya (2):
      Documentation: filesystems: Add bcachefs toctree
      MAINTAINERS: Add entry for bcachefs documentation

Dan Carpenter (1):
      bcachefs: fix ! vs ~ typo in __clear_bit_le64()

Hongbo Li (1):
      bcachefs: fix the count of nr_freed_pcpu after changing bc->freed_nonpcpu list

Kent Overstreet (19):
      bcachefs: Make snapshot_is_ancestor() safe
      bcachefs: Bump limit in btree_trans_too_many_iters()
      bcachefs: Move btree_updates to debugfs
      bcachefs: Further improve btree_update_to_text()
      bcachefs: Print shutdown journal sequence number
      bcachefs: Fix rebalance from durability=0 device
      bcachefs: fix rand_delete unit test
      bcachefs: Fix BCH_IOCTL_FSCK_OFFLINE for encrypted filesystems
      bcachefs: Disable errors=panic for BCH_IOCTL_FSCK_OFFLINE
      bcachefs: JOURNAL_SPACE_LOW
      bcachefs: Fix gap buffer bug in bch2_journal_key_insert_take()
      bcachefs: fix bch2_get_acl() transaction restart handling
      bcachefs: fix eytzinger0_find_gt()
      bcachefs: Fix check_topology() when using node scan
      bcachefs: Don't scan for btree nodes when we can reconstruct
      bcachefs: btree_node_scan: Respect member.data_allowed
      bcachefs: Fix a race in btree_update_nodes_written()
      bcachefs: Kill read lock dropping in bch2_btree_node_lock_write_nofail()
      bcachefs: Fix __bch2_btree_and_journal_iter_init_node_iter()

Thomas Bertschinger (1):
      bcachefs: create debugfs dir for each btree

Thorsten Blum (1):
      bcachefs: Rename struct field swap to prevent macro naming collision

 Documentation/filesystems/bcachefs/index.rst |  11 +++
 Documentation/filesystems/index.rst          |   1 +
 MAINTAINERS                                  |   1 +
 fs/bcachefs/acl.c                            |  30 +++----
 fs/bcachefs/bcachefs_format.h                |  14 +++
 fs/bcachefs/btree_gc.c                       |  13 ++-
 fs/bcachefs/btree_iter.h                     |   2 +-
 fs/bcachefs/btree_journal_iter.c             |  67 ++++++++++----
 fs/bcachefs/btree_key_cache.c                |   4 +-
 fs/bcachefs/btree_locking.c                  |  28 +-----
 fs/bcachefs/btree_node_scan.c                |  11 ++-
 fs/bcachefs/btree_types.h                    |  14 +++
 fs/bcachefs/btree_update_interior.c          | 128 +++++++++++++--------------
 fs/bcachefs/btree_update_interior.h          |   3 +-
 fs/bcachefs/chardev.c                        |  98 +++++++++++---------
 fs/bcachefs/data_update.c                    |  17 +++-
 fs/bcachefs/debug.c                          |  75 ++++++++++++----
 fs/bcachefs/eytzinger.c                      |   8 +-
 fs/bcachefs/eytzinger.h                      |  26 ++++--
 fs/bcachefs/journal_reclaim.c                |   2 +
 fs/bcachefs/journal_types.h                  |   1 +
 fs/bcachefs/recovery.c                       |  14 ---
 fs/bcachefs/snapshot.c                       |  19 ++--
 fs/bcachefs/super.c                          |   5 ++
 fs/bcachefs/sysfs.c                          |   6 --
 fs/bcachefs/tests.c                          |   2 +-
 fs/bcachefs/util.h                           |  10 ++-
 27 files changed, 372 insertions(+), 238 deletions(-)
 create mode 100644 Documentation/filesystems/bcachefs/index.rst

