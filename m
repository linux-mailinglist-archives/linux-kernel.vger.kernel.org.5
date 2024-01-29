Return-Path: <linux-kernel+bounces-42081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98E83FC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418C31C20976
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A46EED7;
	Mon, 29 Jan 2024 02:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfFdMlGU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B521DF57
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494350; cv=none; b=QYitl+x4J5xhqlZfrSrYUWM59LUUoS2CkUAimEI0mM2D3DecmiYIyVukhEMABQPaK8h/s4en9fhUS/cFB4ZdIvFHX4I5s8SV2a1b6+aWh4eVbaBGb2C2zb9VcxP41HsbeVcf+lcUpfLxEDDZXgxjE8NVWnPDBl5WSsj/8eNCUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494350; c=relaxed/simple;
	bh=74AaJSvp1x+QsqfBEbwtqQ2LgJrbhXQeDnDXDWIVpDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAGi0+Ukujob7/rXq2j1znXkkqQKxiWv6kSMtKE2X6RFSc14209q2KZAi3yCP0WgQHsnQtE+exdVY3hgrFjYy/dRyb0U3WU1aSHG5zlzmQnYqTpDmeqlvTOlHZnEe/CO4j4GvXaPE8saDByqwSU7iS3dBp0maXPmzPdm45an6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfFdMlGU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706494347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJWg2PYEamb3ZegCQzkfF2MUl1gzSlbA9B2qC4uBssM=;
	b=NfFdMlGUrEzLJpHzgbC+ZaydR4aTvApOAHFrJBMyKT1MZBHACDojyUg6IbNDdB85fl0uIC
	y+zzpi0rsDQ14fAXn64owTk6mm3AsS6are+CpXlbbDJKg6wezSH/x8QfYSviKOV+XrsMUO
	nY3D387He2CDEakWk63YACoDIC5Ts44=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-xV24OTZQNiKgzZszeXPhnA-1; Sun, 28 Jan 2024 21:12:25 -0500
X-MC-Unique: xV24OTZQNiKgzZszeXPhnA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2c4e9cb449so110078766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 18:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706494344; x=1707099144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJWg2PYEamb3ZegCQzkfF2MUl1gzSlbA9B2qC4uBssM=;
        b=pNDSUKwCeLDNJWk4blggdz0eppkbodH0x9QWYGi9nSCpA1+hPHHgCXay/9/d5gyAZT
         qGZnZRWbt+wduKO5+N3eXVdYdBnWOGawwmRaK0cT63voZGCkycO4M40EDQOo+dOdyMrK
         l6i8riWLlDvrPXekO5G8us1Hep+jPnd7eIVpq1hdqYl0hcT2VBsJVMfowEotGcWh1hzP
         KVKweEzNhFYerSVyuLlBTXaFE9q9PbCQkFcevJi/IS+EFuMBJG1CesvdO4fDpK+DfPL+
         TYZKYWCeD06hXs9N0pkcv/b8h20rKNcUNKzspc2S2Y8VrKbSglYvZktorkDGs3RUhDoB
         AGlA==
X-Gm-Message-State: AOJu0YwBoj3eHVCRo//zc/fiUJvBbOIXO1G5mvAnfkArFh3MH0GW4GxE
	rPEMOv8HYd6KKlxEhGzrgQqIc7JaVwr5O/GoGu0Yj8oSKv8hNMd8fUO9BQLOmwkcsW8vqDY8xm6
	WgPZ74yjdoUCtqZCmfeNGEFIIYLx/3RsbGw+TVFKNs1I7mijSaGtsXwfOYrvfglrMINWzL3FhCa
	xBJ7Gf6UGRvD+LCg+bt7qPkNwbxUMKLidetiDZSyOOLjMVCA==
X-Received: by 2002:a17:906:c097:b0:a2d:2121:2a93 with SMTP id f23-20020a170906c09700b00a2d21212a93mr3453545ejz.70.1706494344274;
        Sun, 28 Jan 2024 18:12:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiFbrJmKuoTg7NfZCeLeu7gfR1ponzl4sUsXEQJ6nN5S021D9wfOn3F8TWqMMqPdPoyRd2vp8/+YquOqRouIk=
X-Received: by 2002:a17:906:c097:b0:a2d:2121:2a93 with SMTP id
 f23-20020a170906c09700b00a2d21212a93mr3453534ejz.70.1706494343887; Sun, 28
 Jan 2024 18:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128142522.1524741-1-ming.lei@redhat.com> <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com> <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com> <ZbcDvTkeDKttPfJ4@dread.disaster.area>
In-Reply-To: <ZbcDvTkeDKttPfJ4@dread.disaster.area>
From: Mike Snitzer <snitzer@redhat.com>
Date: Sun, 28 Jan 2024 21:12:12 -0500
Message-ID: <CAH6w=azbfYCbC6m-bh-yUt3HMUe-EnWPV71P+Z=jeNwMU5aHaQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops in
 willneed range
To: Dave Chinner <david@fromorbit.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Ming Lei <ming.lei@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>, 
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 8:48=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> > On Sun, Jan 28, 2024 at 7:22=E2=80=AFPM Matthew Wilcox <willy@infradead=
org> wrote:
> > >
> > > On Sun, Jan 28, 2024 at 06:12:29PM -0500, Mike Snitzer wrote:
> > > > On Sun, Jan 28 2024 at  5:02P -0500,
> > > > Matthew Wilcox <willy@infradead.org> wrote:
> > > Understood.  But ... the application is asking for as much readahead =
as
> > > possible, and the sysadmin has said "Don't readahead more than 64kB a=
t
> > > a time".  So why will we not get a bug report in 1-15 years time sayi=
ng
> > > "I put a limit on readahead and the kernel is ignoring it"?  I think
> > > typically we allow the sysadmin to override application requests,
> > > don't we?
> >
> > The application isn't knowingly asking for readahead.  It is asking to
> > mmap the file (and reporter wants it done as quickly as possible..
> > like occurred before).
>
> .. which we do within the constraints of the given configuration.
>
> > This fix is comparable to Jens' commit 9491ae4aade6 ("mm: don't cap
> > request size based on read-ahead setting") -- same logic, just applied
> > to callchain that ends up using madvise(MADV_WILLNEED).
>
> Not really. There is a difference between performing a synchronous
> read IO here that we must complete, compared to optimistic
> asynchronous read-ahead which we can fail or toss away without the
> user ever seeing the data the IO returned.
>
> We want required IO to be done in as few, larger IOs as possible,
> and not be limited by constraints placed on background optimistic
> IOs.
>
> madvise(WILLNEED) is optimistic IO - there is no requirement that it
> complete the data reads successfully. If the data is actually
> required, we'll guarantee completion when the user accesses it, not
> when madvise() is called.  IOWs, madvise is async readahead, and so
> really should be constrained by readahead bounds and not user IO
> bounds.
>
> We could change this behaviour for madvise of large ranges that we
> force into the page cache by ignoring device readahead bounds, but
> I'm not sure we want to do this in general.
>
> Perhaps fadvise/madvise(willneed) can fiddle the file f_ra.ra_pages
> value in this situation to override the device limit for large
> ranges (for some definition of large - say 10x bdi->ra_pages) and
> restore it once the readahead operation is done. This would make it
> behave less like readahead and more like a user read from an IO
> perspective...

I'm not going to pretend like I'm an expert in this code or all the
distinctions that are in play.  BUT, if you look at the high-level
java reproducer: it is requesting mmap of a finite size, starting from
the beginning of the file:
FileChannel fc =3D new RandomAccessFile(new File(args[0]), "rw").getChannel=
();
MappedByteBuffer mem =3D fc.map(FileChannel.MapMode.READ_ONLY, 0, fc.size()=
);

Yet you're talking about the application like it is stabbingly
triggering unbounded async reads that can get dropped, etc, etc.  I
just want to make sure the subtlety of (ab)using madvise(WILLNEED)
like this app does isn't incorrectly attributed to something it isn't.
The app really is effectively requesting a user read of a particular
extent in terms of mmap, right?

BTW, your suggestion to have this app fiddle with ra_pages and then
reset it is pretty awful (that is a global setting, being tweaked for
a single use, and exposing random IO to excessive readahead should
there be a heavy mix of IO to the backing block device).  Seems the
app is providing plenty of context that it shouldn't be bounded in
terms of readahead limits, so much so that Ming's patch is conveying
the range the madvise(WILLNEED) is provided by the app so as to _know_
if the requested page(s) fall within the requested size; Linux just
happens to be fulfilling the syscall in terms of readahead.

FYI, here is the evolution of this use-case back from when it issued
larger IO back in 3.14, Ming documented it I'm just sharing in case it
helps:

3.14:
madvise_willneed() -> force_page_cache_readahead()
force_page_cache_readahead() will read all pages in the specified range

3.15:
madvise_willneed() -> vfs_fadvise() -> generic_fadvise() ->
  force_page_cache_readahead()

force_page_cache_readahead() only reads at most device max_sectors bytes,
and the remainder is read in filemap_fault()

Things start to change since:

1) 6d2be915e589 ("mm/readahead.c: fix readahead failure for memoryless
NUMA nodes
and limit readahead max_pages")
which limits at most 2Mbytes to be read in madvise_willneed()
so the remained bytes are read in filemap_fault() via normal readahead

2) 600e19afc5f8 ("mm: use only per-device readahead limit")
limits at most .ra_pages bytes to read in madvise_willneed()

3) 9491ae4aade6 ("mm: don't cap request size based on read-ahead setting")
relax the limit by reading at most max sectors bytes in madvise_willneed()


