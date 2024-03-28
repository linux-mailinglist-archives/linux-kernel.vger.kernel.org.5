Return-Path: <linux-kernel+bounces-123837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE12890EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97BE28C85D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9211384A9;
	Thu, 28 Mar 2024 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUx9Vye0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61E383AC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669836; cv=none; b=Rr1SZ4Fh9KUu/+4FHDZSXg4BV44hI8b9JpoH5H7IpQNOXVFqgifhxGkcD5XoV9HmCJ83VAZrogw+5LAG6mu83gLQfE0PVX6+QkEo4abLs1Wd2pooj3k1lAEHOn7HweEeD/uRaUeHTVr4CZ4iwPEHzn0xcJWU2Pv9Dm4NMQSwrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669836; c=relaxed/simple;
	bh=rnAgD8QyYSqlHtwiyhdPnjbT9pkWQMe2yKGBxL3Qi4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfhP61ttpF8qi5pwidX2hFdRzlPH9NOLNF9d4v0yBQ5kRLOmZYEh6HYZk8tQ6IF/WYcyTaTW3RBYlkvqyuQGVxGKTcQy4LjQXuGKyBTroHMW2y9Go8p86cXjsJhDYYGD0XlJXit8u/ylw5WbudMXBpb+FWOf3Hlq8owKBkBUHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUx9Vye0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711669833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Vn/NzwmdIpWsn5nWXict56VBOKf11qYNjS4a8/2VBk=;
	b=MUx9Vye00a4q//ScfnW5slHP1ebvL1z74ZOBDFeQOlcW5KQ+q2YjR3gv9y/xpQWBvjX+z+
	lt3Ec/STCQoADISoigKDeDLxapOC4CwvYcfOlRdVPJp61Vw7p9zo9dLCwECGRMqjL+BdCA
	qi+uTMxeLyoYuqS+0tw1M5XsrMLa1+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-0Y4hxj8HM0-5DFISrRGQsg-1; Thu, 28 Mar 2024 19:50:30 -0400
X-MC-Unique: 0Y4hxj8HM0-5DFISrRGQsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0FE9101A523;
	Thu, 28 Mar 2024 23:50:29 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 45A5C200A384;
	Thu, 28 Mar 2024 23:50:27 +0000 (UTC)
Date: Thu, 28 Mar 2024 18:50:21 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 1/9] block: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <pmwdm323zz7p6adwooc4stxkpimhtte2whtbfyhh6c34brol7z@3jrb42y74y7y>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-2-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328203910.2370087-2-stefanha@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Thu, Mar 28, 2024 at 04:39:02PM -0400, Stefan Hajnoczi wrote:
> The SEEK_HOLE/SEEK_DATA interface is used by userspace applications to
> detect sparseness. This makes copying and backup applications faster and
> reduces space consumption because only ranges that do not contain data
> can be skipped.

s/only //

> 
> Handle SEEK_HOLE/SEEK_DATA for block devices. No block drivers implement
> the new callback yet so the entire block device will appear to contain
> data. Later patches will add support to drivers so this actually becomes
> useful.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/linux/blkdev.h |  7 +++++++
>  block/fops.c           | 43 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 49 insertions(+), 1 deletion(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


