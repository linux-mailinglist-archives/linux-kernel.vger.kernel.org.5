Return-Path: <linux-kernel+bounces-123767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CC3890D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07EC1F26BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B58D13CAAD;
	Thu, 28 Mar 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbBY/xh8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC613AA3A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664245; cv=none; b=Gsy+HGZnhkjSuLl8mtEAWocZsPix/AopaH6B4tOedEJ8DcC2Ni1EOTNuQgzxs9RZSqnZ9HvbI1/9giyZ5rip/m4lCOXhDnGdkMExljjWbhGUN4cr/9kXfpL3/EIsBoJ0TF5Adm86GLBDEU/MCBlUs6esMTFExSSb/c/dsSR0jl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664245; c=relaxed/simple;
	bh=VXnhaaKU33+tHF5mbKEdgreqcKhfv4lLGZol/7nwD0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVkyEonCm3vtAUY5sHlFw0SNnTrV9AEPqtXmEfjuXngSjN0eWkaeEm1wN61nyxcXCh+OceE/Pit9rwZXO5QwieXyfPcq1eSATKplWN9U9mDi4snHnqJwd6ri+HPgl1hIhwFQzngt/5VKIX5RedSaPW7hTsU1zmyfpO5+iiyWDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbBY/xh8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711664242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rNZU2QXk2ogZj79fBqMGTUF0KyS+J6WMZo1HESMP3P4=;
	b=EbBY/xh8m1HZtxpZu/J8wRJT71FPX2Ky5JsPdjYZrE3qqkoj5ZxaQEYLKmcbBev4whLdT9
	DF71uT9kgUOMIj+79355G5xs2Y25PXs1dGkDz+fEyzU8xtbTH3hxBH1RCynM2/8kY2KsiN
	YVMge0HX/ctffCFOb1ZbYZLMoffyVP4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-IpWhAem8PQu9RuynnIXXjQ-1; Thu, 28 Mar 2024 18:17:19 -0400
X-MC-Unique: IpWhAem8PQu9RuynnIXXjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD8F8101A523;
	Thu, 28 Mar 2024 22:17:18 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 20EC43C54;
	Thu, 28 Mar 2024 22:17:16 +0000 (UTC)
Date: Thu, 28 Mar 2024 17:16:54 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 0/9] block: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <e2lcp3n5gpf7zmlpyn4nj7wsr36sffn23z5bmzlsghu6oapi5u@sdkcbpimi5is>
References: <20240328203910.2370087-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328203910.2370087-1-stefanha@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Thu, Mar 28, 2024 at 04:39:01PM -0400, Stefan Hajnoczi wrote:
> cp(1) and backup tools use llseek(SEEK_HOLE/SEEK_DATA) to skip holes in files.

As a minor point of clarity (perhaps as much for my own records for
documenting research I've done over the years, and not necessarily
something you need to change in the commit message):

Userspace apps generally use lseek(2) from glibc or similar (perhaps
via its alias lseek64(), depending on whether userspace is using large
file offsets), rather than directly calling the _llseek() syscall.
But it all boils down to the same notion of seeking information about
various special offsets.

Also, in past history, coreutils cp(1) and dd(1) did experiment with
using FS_IOC_FIEMAP ioctls when SEEK_HOLE was not available, but it
proved to cause more problems than it solved, so that is not currently
in favor.  Yes, we could teach more and more block devices to expose
specific ioctls for querying sparseness boundaries, and then teach
userspace apps a list of ioctls to try; but as cp(1) already learned,
having one common interface is much easier than an ever-growing ioctl
ladder to be copied across every client that would benefit from
knowing where the unallocated portions are.

> This can speed up the process by reducing the amount of data read and it
> preserves sparseness when writing to the output file.
> 
> This patch series is an initial attempt at implementing
> llseek(SEEK_HOLE/SEEK_DATA) for block devices. I'm looking for feedback on this
> approach and suggestions for resolving the open issues.

One of your open issues was whether adjusting the offset of the block
device itself should also adjust the file offset of the underlying
file (at least in the case of loopback and dm-linear).  What would the
community think of adding two additional constants to the entire
family of *seek() functions, that have the effect of returning the
same offset as their SEEK_HOLE/SEEK_DATA counterparts but without
moving the file offset?

Explaining the idea by example, although I'm not stuck on these names:
suppose you have an fd visiting a file description of 2MiB in size,
with the first 1MiB being a hole and the second being data.

#define MiB (1024*1024)
lseek64(fd, MiB, SEEK_SET); // returns MiB, file offset changed to MiB
lseek64(fd, 0, SEEK_HOLE); // returns 0, file offset changed to 0
lseek64(fd, 0, SEEK_DATA); // returns MiB, file offset changed to MiB
lseek64(fd, 0, SEEK_PEEK_HOLE); // returns 0, but file offset left at MiB
lseek64(fd, 0, SEEK_SET); // returns 0, file offset changed to MiB
lseek64(fd, 0, SEEK_PEEK_DATA); // returns MiB, but file offset left at MiB

With semantics like that, it might be easier to implement just
SEEK_PEEK* in devices (don't worry about changing offsets, just about
reporting where the requested offset is), and then have a common layer
do the translation from llseek(...,offs,SEEK_HOLE) into a 2-step
llseek(...,llseek(...,offs,SEEK_PEEK_HOLE),SEEK_SET) if that makes life
easier under the hood.

> 
> In the block device world there are similar concepts to holes:
> - SCSI has Logical Block Provisioning where the "mapped" state would be
>   considered data and other states would be considered holes.

BIG caveat here: the SCSI spec does not necessarily guarantee that
unmapped regions read as all zeroes; compare the difference between
FALLOC_FL_ZERO_RANGE and FALLOC_FL_PUNCH_HOLE.  While lseek(SEEK_HOLE)
on a regular file guarantees that future read() in that hole will see
NUL bytes, I'm not sure whether we want to make that guarantee for
block devices.  This may be yet another case where we might want to
add new SEEK_* constants to the *seek() family of functions that lets
the caller indicate whether they want offsets that are guaranteed to
read as zero, vs. merely offsets that are not allocated but may or may
not read as zero.  Skipping unallocated portions, even when you don't
know if the contents reliably read as zero, is still a useful goal in
some userspace programs.

> - NBD has NBD_CMD_BLOCK_STATUS for querying whether blocks are present.

However, utilizing it in nbd.ko would require teaching the kernel to
handle structured or extended headers (right now, that is an extension
only supported in user-space implementations of the NBD protocol).  I
can see why you did not tackle that in this RFC series, even though
you mention it in the cover letter.

> - Linux loop block devices and dm-linear targets can pass through queries to
>   the backing file.
> - dm-thin targets can query metadata to find holes.
> - ...and you may be able to think of more examples.
> 
> Therefore it is possible to offer this functionality in block drivers.
> 
> In my use case a QEMU process in userspace copies the contents of a dm-thin
> target. QEMU already uses SEEK_HOLE but that doesn't work on dm-thin targets
> without this patch series.
> 
> Others have also wished for block device support for SEEK_HOLE. Here is an open
> issue from the BorgBackup project:
> https://github.com/borgbackup/borg/issues/5609
> 
> With these patches userspace can identify holes in loop, dm-linear, and dm-thin
> devices. This is done by adding a seek_hole_data() callback to struct
> block_device_operations. When the callback is NULL the entire device is
> considered data. Device-mapper is extended along the same lines so that targets
> can provide seek_hole_data() callbacks.
> 
> I'm unfamiliar with much of this code and have probably missed locking
> requirements. Since llseek() executes synchronously like ioctl() and is not an
> asynchronous I/O request it's possible that my changes to the loop block driver
> and dm-thin are broken (e.g. what if the loop device fd is changed during
> llseek()?).
> 
> To run the tests:
> 
>   # make TARGETS=block_seek_hole -C tools/testing/selftests run_tests
> 
> The code is also available here:
> https://gitlab.com/stefanha/linux/-/tree/block-seek-hole
> 
> Please take a look and let me know your thoughts. Thanks!
> 
> Stefan Hajnoczi (9):
>   block: add llseek(SEEK_HOLE/SEEK_DATA) support
>   loop: add llseek(SEEK_HOLE/SEEK_DATA) support
>   selftests: block_seek_hole: add loop block driver tests
>   dm: add llseek(SEEK_HOLE/SEEK_DATA) support
>   selftests: block_seek_hole: add dm-zero test
>   dm-linear: add llseek(SEEK_HOLE/SEEK_DATA) support
>   selftests: block_seek_hole: add dm-linear test
>   dm thin: add llseek(SEEK_HOLE/SEEK_DATA) support
>   selftests: block_seek_hole: add dm-thin test
> 
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/block_seek_hole/Makefile        |  17 +++
>  include/linux/blkdev.h                        |   7 ++
>  include/linux/device-mapper.h                 |   5 +
>  block/fops.c                                  |  43 ++++++-
>  drivers/block/loop.c                          |  36 +++++-
>  drivers/md/dm-linear.c                        |  25 ++++
>  drivers/md/dm-thin.c                          |  77 ++++++++++++
>  drivers/md/dm.c                               |  68 ++++++++++
>  .../testing/selftests/block_seek_hole/config  |   3 +
>  .../selftests/block_seek_hole/dm_thin.sh      |  80 ++++++++++++
>  .../selftests/block_seek_hole/dm_zero.sh      |  31 +++++
>  .../selftests/block_seek_hole/map_holes.py    |  37 ++++++
>  .../testing/selftests/block_seek_hole/test.py | 117 ++++++++++++++++++
>  14 files changed, 540 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/block_seek_hole/Makefile
>  create mode 100644 tools/testing/selftests/block_seek_hole/config
>  create mode 100755 tools/testing/selftests/block_seek_hole/dm_thin.sh
>  create mode 100755 tools/testing/selftests/block_seek_hole/dm_zero.sh
>  create mode 100755 tools/testing/selftests/block_seek_hole/map_holes.py
>  create mode 100755 tools/testing/selftests/block_seek_hole/test.py
> 
> -- 
> 2.44.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


