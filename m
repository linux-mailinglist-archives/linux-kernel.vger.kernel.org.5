Return-Path: <linux-kernel+bounces-159993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47558B375F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92881C210A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F684146A80;
	Fri, 26 Apr 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JomG5SZ/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FC5145B0C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135445; cv=none; b=t6u/nswYL7D6qx26zQ5EEXTStKnsOWt9H6DlwD6Gl6G0nAkW/ai+rcaPcZFKwZ1mG9/GMNLwDyc+zuju5gj06JGSjP3Wsvy1kvn+vaLtW6ZE/pPxagXZE02+BN9r9ty5HHOY7cHo+0ZsvOCGEVbB2UhCEGtNuaxEAW+pWcPkc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135445; c=relaxed/simple;
	bh=4osWF3z7TVSnKXwxzghbXZwzHfp+R/4Uz9B9jm/RxLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTS7UVJqdZ2JWLhPF/PFXmN8iINPdhnac/0wTJHrEUoZkZSe6RAKEPCR/lZUng+b3L2DjzIB1I+1wEjyNgbY/z1+ylQ7oLV6HIUfDbGlTnqiv5VoUHtPAg5quEoN+KCgZg3mQQUKLbdGZ24osJ4hGHlbcvx+mXfuVl5XWcA+G4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JomG5SZ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714135443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCVM+mcR/zAidOTS4y72huxA4HPGOw6uU5hpLDITtQk=;
	b=JomG5SZ/nk6Blimqcva7r25SpBqNcvAdiOU+VpGXwILHJ9HeJMN4nhPqIDAKcG+0fo82rM
	lrHzJvh3YH9xjXY4htmpkNSpz3DhQ1sEjOKag3UWGiY6Tv8fhSvbaYp0yKAM5vYbJAnPdE
	QwaO+nWjIx0DJvGvbUWWfa30OF0P21M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-O05rPKkQP2uQT5wmnySeHA-1; Fri, 26 Apr 2024 08:43:59 -0400
X-MC-Unique: O05rPKkQP2uQT5wmnySeHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7791A802352;
	Fri, 26 Apr 2024 12:43:58 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 11904AC6A;
	Fri, 26 Apr 2024 12:43:58 +0000 (UTC)
Date: Fri, 26 Apr 2024 08:46:13 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, djwong@kernel.org,
	chandan.babu@oracle.com, syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] KASAN: slab-out-of-bounds Read in xlog_cksum
Message-ID: <ZiuiFfWEOCiO9wVA@bfoster>
References: <CAEkJfYO++C-pxyqzfoXFKEvmMQEnrgkQ2QcG6radAWJMqdXQCQ@mail.gmail.com>
 <ZipWt03PhXs2Yc84@infradead.org>
 <ZiphYrREkQvxkE-U@bfoster>
 <ZitF8eqWEYECruXo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZitF8eqWEYECruXo@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Thu, Apr 25, 2024 at 11:13:05PM -0700, Christoph Hellwig wrote:
> On Thu, Apr 25, 2024 at 09:57:54AM -0400, Brian Foster wrote:
> > On Thu, Apr 25, 2024 at 06:12:23AM -0700, Christoph Hellwig wrote:
> > > This triggers the workaround for really old xfsprogs putting in a
> > > bogus h_size:
> > > 
> > > [   12.101992] XFS (loop0): invalid iclog size (0 bytes), using lsunit (65536 bytes)
> > > 
> > > but then calculates the log recovery buffer size based on the actual
> > > on-disk h_size value.  The patch below open codes xlog_logrec_hblks and
> > > fixes this particular reproducer.  But I wonder if we should limit the
> > > workaround.  Brian, you don't happpen to remember how old xfsprogs had
> > > to be to require your workaround (commit a70f9fe52daa8)?
> > > 
> > 
> > No, but a little digging turns up xfsprogs commit 20fbd4593ff2 ("libxfs:
> > format the log with valid log record headers"), which I think is what
> > you're looking for..? That went in around v4.5 or so, so I suppose
> > anything earlier than that is affected.
> 
> Thanks.  I was kinda hoping we could exclude v5 file systems from that
> workaround, but it is needed way too recent for that.
> 
> Maybe we can specificly check for the wrongly hardcoded
> XLOG_HEADER_CYCLE_SIZE instead of allowing any value?
> 

That seems like a reasonable option to me if you wanted to make it a bit
more limited to its purpose. You might just want to double check that
the size used in libxfs hadn't changed at any point previously, because
that 1. apparently wouldn't have been an issue up until the record
verification stuff and 2. the existing size-agnostic check in the kernel
would have still handled it (prior to being broken).

It might also be worth a separately named macro or something in the
kernel just for extra indication that this particular check is unique
and warrants extra thought on future changes. Not so much that I'd
expect the original macro value to change, but just that I suspect
something like that might have helped flag this logic as semi-special
and maybe helped avoid breaking it in commit 0c771b99d6c9. In hindsight,
maybe it would have been a little better even to just put that logic
into its own special fixup function or something. Anyways, just some
random thoughts..

Brian


