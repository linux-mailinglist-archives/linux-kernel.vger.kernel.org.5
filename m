Return-Path: <linux-kernel+bounces-54054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 907C684AA14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0AFB2453D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A34D52F77;
	Mon,  5 Feb 2024 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKIa8RP5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81203482F9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173884; cv=none; b=r/GyDeG5UGxPl2i1IP1DLMQ2tvmp32JNoGUrFTBhkWfLiUlw0JTGRS0B0AsRJ1RPoxvfRgq2zCeKxHjHzbw1FjE+OuT0B/OObTsRjEwZ339fZs26P7IaQJ1XHWt2dYWgJSrHSsupdZ/NqVTmyXz2kftCnHQIB3DiR6v5z5Pq6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173884; c=relaxed/simple;
	bh=cOQGLVhiiObfyloDgcZhWjtXBhQA9sfsF7RZwDC1qa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qswpv7C4Bi2A3X6HwPnOhmzjlBcXlA7vauYmF4cY74XZ/3IbxtVJiGldSEVK4S487OkIYzgIjCOMwAB/0toJOgGGmXqSbdIdf36F2ZX2D9dl4FxN0VAqtOz5EK0q3Q+M/9AaQ/yu2ngsDU/PmwFlrNHjJ8v+rJgCVEmTrNLoHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKIa8RP5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707173881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m84d7QF2RHzKEpc2iYUiWaNTbg9vVp06SyHcrHDZtG0=;
	b=ZKIa8RP5csSBNHvj2Q1jlFPFWgeWPbnTZqBsgvaIuuNrSfgPBEVgbJUp9+A983h7ELB5+m
	J6HBk+WnIxa20EJKYYFsS/VW/DGYeRuw4eaGRB0y3FEFiwlrEkRfw1G6fENHrdnv8tnGZK
	7BndK6S6ZVCJIbL9rnk1moJ2CGt9pNk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-kn07yk8aMjSd8XV0XktC_Q-1; Mon, 05 Feb 2024 17:57:31 -0500
X-MC-Unique: kn07yk8aMjSd8XV0XktC_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35A77845DC0;
	Mon,  5 Feb 2024 22:57:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19C7B1121312;
	Mon,  5 Feb 2024 22:57:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/12] netfs, cifs: Delegate high-level I/O to netfslib
Date: Mon,  5 Feb 2024 22:57:12 +0000
Message-ID: <20240205225726.3104808-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi Steve,

Here are patches to convert cifs to use the netfslib library.  With this I
can run a certain amount of xfstests on CIFS, though not all the tests work
correctly because of fallocate issues.

The patches remove around 2000 lines from CIFS

To do:

 (*) Implement write-retry.  Currently, netfslib errors out on a failed DIO
     write and relies on the VM to drive writepages again on a failed
     buffered write.  This needs some retry logic adding into
     fs/netfs/output.c.

     I'm not sure what the best way to handle this is.  One way is to
     resend each failing subreq as it fails, offloading this to a kernel
     thread that re-splits the subreq, calling out to a rreq->op to do the
     splitting, thereby allowing cifs to renegotiate credits.  If a subreq
     is split, the two parts need to be adjacent in the rreq->subrequests
     list.

     An alternative way might be to try and combine failing tests and then
     split them.

     Yet a third way might be to try each failing subreq a smaller bit at a
     time and keep track of what has been sent in
     wdata->subreq.transferred.

     Whichever way is chosen, NETFS_SREQ_RETRYING should be set in
     wdata->subreq.flags instead of setting wdata->replay.

Notes:

 (1) CIFS is made to use unbuffered I/O for unbuffered caching modes and
     write-through caching for cache=strict.

 (2) Various cifs fallocate() function implementations have issues that
     aren't easily fixed without enhanced protocol support.

 (3) It should be possible to turn on multipage folio support in CIFS now.

 (4) The then-unused CIFS code is removed in three patches, not one, to
     avoid the git patch generator from producing confusing patches in
     which it thinks code is being moved around rather than just being
     removed.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-netfs

Changes
=======
ver #5)
 - Rebased to -rc3 plus SteveF's for-next branch as netfslib is now
   upstream, as are a couple of patches from this series.
 - Replace the ->replay bool Shyam added with a flag on the netfs
   subrequest.  This is tested by the code, but not currently set (see
   above).

ver #4)
 - Slimmed down the branch:
   - Split the cifs-related patches off to a separate branch (cifs-netfs)
   - Deferred the content-encryption to the in-progress ceph changes.
   - Deferred the use-PG_writeback rather than PG_fscache patch
 - Rebased on a later linux-next with afs-rotation patches.

ver #3)
 - Moved the fscache module into netfslib to avoid export cycles.
 - Fixed a bunch of bugs.
 - Got CIFS to pass as much of xfstests as possible.
 - Added a patch to make 9P use all the helpers.
 - Added a patch to stop using PG_fscache, but rather dirty pages on
   reading and have writepages write to the cache.

ver #2)
 - Folded the addition of NETFS_RREQ_NONBLOCK/BLOCKED into first patch that
   uses them.
 - Folded addition of rsize member into first user.
 - Don't set rsize in ceph (yet) and set it in kafs to 256KiB.  cifs sets
   it dynamically.
 - Moved direct_bv next to direct_bv_count in struct netfs_io_request and
   labelled it with a __counted_by().
 - Passed flags into netfs_xa_store_and_mark() rather than two bools.
 - Removed netfs_set_up_buffer() as it wasn't used.

David

Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.com/ [1]
Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.com/ # v3
Link: https://lore.kernel.org/r/20231213154139.432922-1-dhowells@redhat.com/ # v4

David Howells (12):
  cifs: Replace cifs_readdata with a wrapper around netfs_io_subrequest
  cifs: Set zero_point in the copy_file_range() and remap_file_range()
  cifs: Replace cifs_writedata with a wrapper around netfs_io_subrequest
  cifs: Use more fields from netfs_io_subrequest
  cifs: Make wait_mtu_credits take size_t args
  cifs: Implement netfslib hooks
  cifs: Replace the writedata replay bool with a netfs sreq flag
  cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c
  cifs: Cut over to using netfslib
  cifs: Remove some code that's no longer used, part 1
  cifs: Remove some code that's no longer used, part 2
  cifs: Remove some code that's no longer used, part 3

 fs/netfs/buffered_write.c    |    3 +
 fs/netfs/io.c                |    7 +-
 fs/smb/client/Kconfig        |    1 +
 fs/smb/client/cifsfs.c       |   69 +-
 fs/smb/client/cifsfs.h       |   10 +-
 fs/smb/client/cifsglob.h     |   59 +-
 fs/smb/client/cifsproto.h    |   14 +-
 fs/smb/client/cifssmb.c      |  111 +-
 fs/smb/client/file.c         | 2911 ++++++----------------------------
 fs/smb/client/fscache.c      |  109 --
 fs/smb/client/fscache.h      |   54 -
 fs/smb/client/inode.c        |   19 +-
 fs/smb/client/smb2ops.c      |   10 +-
 fs/smb/client/smb2pdu.c      |  169 +-
 fs/smb/client/smb2proto.h    |    5 +-
 fs/smb/client/trace.h        |  144 +-
 fs/smb/client/transport.c    |   17 +-
 include/linux/netfs.h        |    2 +
 include/trace/events/netfs.h |    1 +
 19 files changed, 852 insertions(+), 2863 deletions(-)


