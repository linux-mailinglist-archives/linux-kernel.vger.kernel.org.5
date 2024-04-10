Return-Path: <linux-kernel+bounces-139322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366A78A0167
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4711C24583
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC39181CE3;
	Wed, 10 Apr 2024 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jd/GHqN2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960D31A60
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712781839; cv=none; b=tjWt+0BXsF5nU0g72J28d4Ig8KyeLhN4cdLnz5A24lxFzkhAIamcB7QYoS45KiMn9yKMzy3BDo1dMRQZQVTY7qlq5SJkbbxAq/2L+VShk196xWM0yPQu587gPuEV+7wn43ZQI5+MLx2DOYs0BpsUkLY6ZHuH9bZjlw3Atjg2C5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712781839; c=relaxed/simple;
	bh=T4tfJ+FYEO50sBmKw6wz2gtPCBR/RgMOuZ1SbykJ3JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNGbRUWaU6hraWWvpk50LorE/R4rBBOWCx9k6QI4yQscBsUHYzhwy9+sVCy9u+AFK+Ym7G2IDAZRGtsWhQOQnc4d6z6oF+h8H555H9Pi3iVedDFbqCAgl1egxMwcBSYyvDSg+DEDbcGr4I5UP05OOuanGPC1/xF1kXmE/TYSxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jd/GHqN2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712781836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UBcG336jXcDynX0hKtU5PSOfrByL4AcpxPfaW9145Qs=;
	b=Jd/GHqN23F5n6+rV5Pxcah98gKbg1Y/xe9K/UZyV5HgFh0GndwRen0BxZ3PdFlDFtNy6kg
	mRHlKeVP+9fz+HUZy5AdyXNiCt82ciJ+55yPfZr1p3YqJAHTgxQ0mM0Uju+i76R7sK7In3
	+y2oi2y8b1UfQ7rFtbDLvaaZQz3xi7E=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-GoVYLnLZNJqdNlgFQnQvjg-1; Wed, 10 Apr 2024 16:43:54 -0400
X-MC-Unique: GoVYLnLZNJqdNlgFQnQvjg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c5f0e4c257so673025b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712781834; x=1713386634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBcG336jXcDynX0hKtU5PSOfrByL4AcpxPfaW9145Qs=;
        b=rqSzcnGlRt6nkt1SCvHEcDeeMiqw3/07jUMZOaON8GiNRo2V5tA3GvXBoErG4aCAx5
         ljZ7v4M9YDZgcOxajtGN8ID8emOI8nmCXVFjwdjbkZKBRttQWEfPGQJUWnCG3g5Vu3KO
         8u8/vkkXRZYYH3GzkeVs8XxEwO96jNknSWmEWnGc46NkvitPTstaWO1KIIbjk1Rghw39
         9IZiOExl5XlM3tVCfJs0dGGy02MX6YroolJ9NT4IfArWQTwAHFjpzeACSkcMi6Tl12Tg
         0ObJ8cQhA94+ioolgUFO1ig9OrHCLvq0qQw3U4hSV66Hkqr18oby1UMgyFi7Lk1+zx93
         vVeg==
X-Gm-Message-State: AOJu0YwIc4fmWyEvUztt47D2+JkBSk1B36JOBK0mcj3mCUjP7ZmHkae/
	/s6jsGosfXnPbx+31opzIaRE7qEz5KT7mmjQ232rKZGWLueEbUM0QRuSK9XD2EYs/EYtjo63llW
	8eEdYR6+s/IiHcK7xdIMj9NiJ9QizvaYi7FsfmZGlEDSTQymDYGAnZulW005KcQ==
X-Received: by 2002:a05:6808:1155:b0:3c5:d7ff:1214 with SMTP id u21-20020a056808115500b003c5d7ff1214mr3981895oiu.1.1712781833666;
        Wed, 10 Apr 2024 13:43:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxKK9XK8HKuZ6UDFf98/ZcwlGpmhlfpIse9Lq2ewTMFBD351jt8yTn3mFtY/un/kXnMXnDwQ==
X-Received: by 2002:a05:6808:1155:b0:3c5:d7ff:1214 with SMTP id u21-20020a056808115500b003c5d7ff1214mr3981870oiu.1.1712781833164;
        Wed, 10 Apr 2024 13:43:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id ka2-20020a05622a440200b00434c680abbasm2585004qtb.93.2024.04.10.13.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 13:43:52 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:43:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <Zhb6B8UsidEEbFu3@x1n>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <Zhb2BWntckP3ZhDc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zhb2BWntckP3ZhDc@casper.infradead.org>

On Wed, Apr 10, 2024 at 09:26:45PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 10, 2024 at 01:06:21PM -0400, Peter Xu wrote:
> > anon_vma is a tricky object in the context of per-vma lock, because it's
> > racy to modify it in that context and mmap lock is needed if it's not
> > stable yet.
> 
> I object to this commit message.  First, it's not a "sanity check".  It's
> a check to see if we already have an anon VMA.  Second, it's not "racy
> to modify it" at all.  The problem is that we need to look at other
> VMAs, for which we do not hold the lock.

For that "do not hold locks" part, isn't that "racy"?

When it's racy in that case, can I still word it as "racy to modify"?  We
can't modify it because it's racy to read the other vmas.

For "sanity check".. well, that falls into this category for me but I'm not
a native speaker. So I am open to any rewords for any of above.

> 
> > So the trivial side effect of such patch is:
> > 
> >   - We may do slightly better on the first WRITE of a private file mapping,
> >   because we can retry earlier (in lock_vma_under_rcu(), rather than
> >   vmf_anon_prepare() later).
> > 
> >   - We may always use mmap lock for the initial READs on a private file
> >   mappings, while before this patch it _can_ (only when no WRITE ever
> >   happened... but it doesn't make much sense for a MAP_PRIVATE..) do the
> >   read fault with per-vma lock.
> 
> But that's a super common path!  Look at 'cat /proc/self/maps'.  All
> your program text (including libraries) is mapped PRIVATE, and never
> written to (except by ptrace, I guess).
> 
> NAK this patch.

We're talking about any vma that will first benefit from a per-vma lock
here, right?

I think it should be only relevant to some major VMA or bunch of VMAs that
an userspace maps explicitly, then iiuc the goal is we want to reduce the
cache bouncing of the lock when it used to be per-mm, by replacing it with
a finer lock.  It doesn't sound right that these libraries even fall into
this category as they should just get loaded soon enough when the program
starts.

IOW, my understanding is that per-vma lock doesn't benefit from such normal
vmas or simple programs that much; we take either per-vma read lock, or
mmap read lock, and I would expect similar performance when such cache
bouncing isn't heavy.

I can do some tests later today or tomorrow. Any suggestion you have on
amplifying such effect that you have concern with?

-- 
Peter Xu


