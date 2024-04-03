Return-Path: <linux-kernel+bounces-130240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E315B8975D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB01C1C26C60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E724F152513;
	Wed,  3 Apr 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4tJgJR9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582C1411FD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163754; cv=none; b=nNoGijw94wpeLzAP32jZiwWGClWE9jBf8S6HhMJRyGrKfHoeJxWJDEy6axVQaQSmkGGmz4SH3CvS+kbdvDaK4Rjj5UBGcVXikw7kAYbCJjowzHDIYeLJTQOQzg91eo3HOn2IbpMUhp8INCbE/4iDAp0ZNzcU0EB90dhoydx744Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163754; c=relaxed/simple;
	bh=Ka2XBtHojXmQUntIvVIeiS+w7Alxi2joEQy4FL+ruYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBvGFNGYtW8vgON5opjBZbD965Glt8bm0DGphWYl1KOXiNtio6ZRQpeTnW4FhKq4BJ5spigUYp1tXCTW7I1fuqe3OjMJG3Agr8zcefdtY7j7Du8lD6dqvVHjmDLMS6qAqmhFZs7Kz3Gm0Yd9BIHm4s0M/1E3hnWRM1BVCIbE66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4tJgJR9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712163750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PvD24Gz3vP6mwRZR6roKTP8B0DvgtjySY7yBjOsMWK0=;
	b=K4tJgJR9FdUiVn4iv4p+gH/ki8vAbQuYKP3ee8ybw8Xxrc67LsJ/2NXEshnjswDrEgEtTj
	SWdFa95bBBRz9zEpkWkxtUZPwwUyP591ri9tieuEV+qXIKMDpzQCWp0JBQGNB33agQPloz
	g6spa1lAyAvmpZz1aH+hpWeNa4zfwEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-NA0bh8ygOJGTWGJDE_96tA-1; Wed, 03 Apr 2024 13:02:28 -0400
X-MC-Unique: NA0bh8ygOJGTWGJDE_96tA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 048F4101A56D;
	Wed,  3 Apr 2024 17:02:28 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.181])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 42AA9C15778;
	Wed,  3 Apr 2024 17:02:24 +0000 (UTC)
Date: Wed, 3 Apr 2024 12:02:19 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 4/9] dm: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <mi3yp4kel6junjk2corv4hi56s56pmwilnm2bb4gg2tbbvyq2n@zmzaqpdq2rlq>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-5-stefanha@redhat.com>
 <6awt5gq36kzwhuobabtye5vhnexc6cufuamy4frymehuv57ky5@esel3f5naqyu>
 <20240403141147.GD2524049@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403141147.GD2524049@fedora>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Wed, Apr 03, 2024 at 10:11:47AM -0400, Stefan Hajnoczi wrote:
..
> > > +static loff_t dm_blk_do_seek_hole_data(struct dm_table *table, loff_t offset,
> > > +		int whence)
> > > +{
> > > +	struct dm_target *ti;
> > > +	loff_t end;
> > > +
> > > +	/* Loop when the end of a target is reached */
> > > +	do {
> > > +		ti = dm_table_find_target(table, offset >> SECTOR_SHIFT);
> > > +		if (!ti)
> > > +			return whence == SEEK_DATA ? -ENXIO : offset;
> > 
> > ...but this blindly returns offset for SEEK_HOLE, even when offset is
> > beyond the end of the dm.  I think you want 'return -ENXIO;'
> > unconditionally here.
> 
> If the initial offset is beyond the end of the table, then SEEK_HOLE
> should return -ENXIO. I agree that the code doesn't handle this case.
> 
> However, returning offset here is correct when there is data at the end
> with SEEK_HOLE.
> 
> I'll update the code to address the out-of-bounds offset case, perhaps
> by checking the initial offset before entering the loop.

You are correct that if we are on the second loop iteration of
SEEK_HOLE (because the first iteration saw all data), then we have
found the offset of the start of a hole and should return that offset,
not -ENXIO.  This may be a case where we just have to be careful on
whether the initial pass might have any corner cases different from
later times through the loop, and that we end the loop with correct
results for both SEEK_HOLE and SEEK_DATA.

> 
> > 
> > > +
> > > +		end = (ti->begin + ti->len) << SECTOR_SHIFT;
> > > +
> > > +		if (ti->type->seek_hole_data)
> > > +			offset = ti->type->seek_hole_data(ti, offset, whence);
> > 
> > Are we guaranteed that ti->type->seek_hole_data will not return a
> > value exceeding end?  Or can dm be used to truncate the view of an
> > underlying device, and the underlying seek_hold_data can now return an
> > answer beyond where dm_table_find_target should look for the next part
> > of the dm's view?
> 
> ti->type->seek_hole_data() must not return a value larger than
> (ti->begin + ti->len) << SECTOR_SHIFT.

Worth adding as documentation then.

> 
> > 
> > In which case, should the blkdev_seek_hole_data callback be passed a
> > max size parameter everywhere, similar to how fixed_size_llseek does
> > things?
> > 
> > > +		else
> > > +			offset = dm_blk_seek_hole_data_default(offset, whence, end);
> > > +
> > > +		if (whence == SEEK_DATA && offset == -ENXIO)
> > > +			offset = end;
> > 
> > You have a bug here.  If I have a dm contructed of two underlying targets:
> > 
> > |A  |B  |
> > 
> > and A is all data, then whence == SEEK_HOLE will have offset = -ENXIO
> > at this point, and you fail to check whether B is also data.  That is,
> > you have silently treated the rest of the block device as data, which
> > is semantically not wrong (as that is always a safe fallback), but not
> > optimal.
> > 
> > I think the correct logic is s/whence == SEEK_DATA &&//.
> 
> No, with whence == SEEK_HOLE and an initial offset in A, the new offset
> will be (A->begin + A->end) << SECTOR_SHIFT. The loop will iterate and
> continue seeking into B.
> 
> The if statement you commented on ensures that we also continue looping
> with whence == SEEK_DATA, because that would otherwise prematurely end
> with the new offset = -ENXIO.
> 
> > 
> > > +	} while (offset == end);
> > 
> > I'm trying to make sure that we can never return the equivalent of
> > lseek(dm, 0, SEEK_END).  If you make my above suggested changes, we
> > will iterate through the do loop once more at EOF, and
> > dm_table_find_target() will then fail to match at which point we do
> > get the desired -ENXIO for both SEEK_HOLE and SEEK_DATA.
> 
> Wait, lseek() is supposed to return the equivalent of lseek(dm, 0,
> SEEK_END) when whence == SEEK_HOLE and there is data at the end.

It was confusing enough for me to write my initial review, I apologize
if I'm making it harder for you.  Yes, we want to ensure that:

off1 = lseek(fd, -1, SEEK_END);
off2 = off1 + 1; // == lseek(fd, 0, SEEK_END)

if off1 belongs to a data extent:
  - lseek(fd, off1, SEEK_DATA) == off1
  - lseek(fd, off1, SEEK_HOLE) == off2
  - lseek(fd, off2, SEEK_DATA) == -ENXIO
  - lseek(fd, off2, SEEK_HOLE) == -ENXIO

if off1 belongs to a hole:
  - lseek(fd, off1, SEEK_DATA) == -ENXIO
  - lseek(fd, off1, SEEK_HOLE) == off1
  - lseek(fd, off2, SEEK_DATA) == -ENXIO
  - lseek(fd, off2, SEEK_HOLE) == -ENXIO

Anything in my wall of text from the earlier message inconsistent with
this table can be ignored; but at the same time, I was not able to
quickly convince myself that your code properly had those properties,
even after writing up the table.

Reiterating what I said elsewhere, it may be smarter to document that
for callbacks, it is wiser to require intermediate behavior that the
input value 'offset' is always between the half-open range
[ti->begin<<SECTOR_SHIFT, (ti->begin+ti->len)<<SECTOR_SHIFT), and on
success, the output must be in the fully-closed range [offset,
(ti->begin+ti->len)<<SECTOR_SHIFT], errors like -EIO are permitted but
-ENXIO should not be returned; and let the caller worry about
synthesizing -ENXIO from that (since the caller knows whether or not
there is a successor ti where adjacency concerns come into play).

That is, we can never pass in off2 (beyond the bounds of the table),
and when passing in off1, I think this interface may be easier to work
with in the intermediate layers, even though it differs from the
lseek() interface above.  For off1 in data:
  - dm_blk_do_seek_hole_data(dm, off1, SEEK_DATA) == off1
  - dm_blk_do_seek_hole_data(dm, off1, SEEK_HOLE) == off2
and for a hole:
  - dm_blk_do_seek_hole_data(dm, off1, SEEK_DATA) == off2
  - dm_blk_do_seek_hole_data(dm, off1, SEEK_HOLE) == off1

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


