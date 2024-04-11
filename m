Return-Path: <linux-kernel+bounces-140875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BAD8A1953
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587AB1C20D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C1152531;
	Thu, 11 Apr 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="as8DhfU7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF717152174
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849692; cv=none; b=lpumJbDCF+c4zBG+1X6zf6nyK4EZ4Q95yXaLubfJhu4yCp2eJke8B/12Ggx3Lat5xWIHlRyWrAhbMae3l2yG3Q/DI2porDn8ZaSUoqxcECFvvkZd0Bp5c7fyhLbHdeY1ojj9eGQAabHZ21gkAFbAtI0GYBwZgIImP16BUTaBwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849692; c=relaxed/simple;
	bh=Mjx8UlD9WBy9SEkNXWPpJFk80JRWycedcJjktGF/uW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCaHRyaTLQPcrC/hIiJefG1Jg5nG+Q0SRqvj9o1HAHf9Kceb7LtbfbDoH6WieiCyNz+dedsn+HwSEB7FGufm0+m9DlhJBBjXaUxHf/yrIIik1UYSEi1/Biq3+h3q0m5saC+lC/gQ9UhD05DdNPsg7MWre9HdjQh9dg6DvuIofbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=as8DhfU7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712849689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=avxqW5icrlL/wJOMzFGMgKqJg8lEP9EgTCeFt7eX5jo=;
	b=as8DhfU7T0uNzo5V4dROXdwj+InjH5NDAWN8eEf6TWYouQM2EKKn68WIjbmwCe/E+z8Ujy
	/4a4f8erWkNtu+b07cP6Vahh6cujJlGzZYgvoM/Pqqm+cYAucF4sYfkL2CK4OQFc+/vkAl
	9uoT7D+AMxA4etj2egm9K1QetC7+PI4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-4djwQol7OfCtYdui7_3ueQ-1; Thu, 11 Apr 2024 11:34:48 -0400
X-MC-Unique: 4djwQol7OfCtYdui7_3ueQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5aa28828071so1034101eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849688; x=1713454488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avxqW5icrlL/wJOMzFGMgKqJg8lEP9EgTCeFt7eX5jo=;
        b=atSdzOmm7FxMSwcrTwXrMMIn7oMSS+4qUOXB0Ko1BRj4JiegJIjCkQTAMdqRB6a4Yb
         RupNDrsqj98xhMdIvOP6GgPj+mKNrfiA0jkfI3kc/zAPdTNrwhC1jIzGRwnrezUyF3CO
         7ffX+xNkpZ/kOURKwS6CpZzpOiir+j/7ikJ5PaifFL6MgMESkZ7z/c/BrSweYsMg/73g
         7rREtbmzPx7sxZDvscaYf8l6sQ67in4SPRE4bihgG/TO8idF+15lc1PjsshaCmLijEEh
         NSM1ZDXgZF3EhYNtf/adAvt63Z8wJISvtwuZD9FjnqBlbGN5F8/izOKwZLW9Z6D+WvgK
         w21Q==
X-Gm-Message-State: AOJu0Yyjsrs6Vkh3O3L92DAXIfYgkdW7CcoZYrQpKz2id0lGcxspBoP7
	gbcqgt3uFfNAk/lNXjg5QsAS3ILockLwVuhRVAaqdpK/qPMfblqFEsCpx7wvfMfxIe48RIMTzTQ
	zZeklhHajd5kLC92wQJz7XhSJxTwwotHPnr6JOhFSnGBex2tLfoU58ggMg+PxJw==
X-Received: by 2002:a05:6870:7183:b0:222:81cc:ac9c with SMTP id d3-20020a056870718300b0022281ccac9cmr6013597oah.5.1712849687454;
        Thu, 11 Apr 2024 08:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENCPttxDxnqyLDvpsNEEi1TWNb4KAi5sScPfv0sxEc/cpCWMTUy2cy8iLk6skyzbDcqc2/AQ==
X-Received: by 2002:a05:6870:7183:b0:222:81cc:ac9c with SMTP id d3-20020a056870718300b0022281ccac9cmr6013563oah.5.1712849686948;
        Thu, 11 Apr 2024 08:34:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id s11-20020ac8528b000000b0043476c7f668sm1040828qtn.5.2024.04.11.08.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:46 -0700 (PDT)
Date: Thu, 11 Apr 2024 11:34:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhgDFJGsFsTjWokU@x1n>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <Zhb2BWntckP3ZhDc@casper.infradead.org>
 <Zhb6B8UsidEEbFu3@x1n>
 <ZhcAVYVFSdX5Binc@casper.infradead.org>
 <ZhcDRmyYkMGPgs4F@x1n>
 <ZhcnzS1S6zOMJwSL@casper.infradead.org>
 <ZhcstFcjOuOmr0wx@x1n>
 <Zhf4zqsfkz1XCwBN@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zhf4zqsfkz1XCwBN@casper.infradead.org>

On Thu, Apr 11, 2024 at 03:50:54PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 10, 2024 at 08:20:04PM -0400, Peter Xu wrote:
> > On Thu, Apr 11, 2024 at 12:59:09AM +0100, Matthew Wilcox wrote:
> > > On Wed, Apr 10, 2024 at 05:23:18PM -0400, Peter Xu wrote:
> > > > On Wed, Apr 10, 2024 at 10:10:45PM +0100, Matthew Wilcox wrote:
> > > > > > I can do some tests later today or tomorrow. Any suggestion you have on
> > > > > > amplifying such effect that you have concern with?
> > > > > 
> > > > > 8 socket NUMA system, 800MB text segment, 10,000 threads.  No, I'm not
> > > > > joking, that's a real customer workload.
> > > > 
> > > > Well, I believe you, but even with this, that's a total of 800MB memory on
> > > > a giant moster system... probably just to fault in once.
> > > > 
> > > > And even before we talk about that into details.. we're talking about such
> > > > giant program running acorss hundreds of cores with hundreds of MB text,
> > > > then... hasn't the program developer already considered mlockall() at the
> > > > entry of the program?  Wouldn't that greatly beneficial already with
> > > > whatever granule of locks that a future fault would take?
> > > 
> > > I don't care what your theory is, or even what your benchmarking shows.
> > > I had basically the inverse of this patch, and my customer's workload
> > > showed significant improvement as a result.  Data talks, bullshit walks.
> > > Your patch is NAKed and will remain NAKed.
> > 
> > Either would you tell me your workload, I may try it.
> > 
> > Or, please explain why it helps?  If such huge library is in a single VMA,
> > I don't see why per-vma lock is better than mmap lock.  If the text is
> > combined with multiple vmas, it should only help when each core faults at
> > least on different vmas, not the same.
> 
> Oh, you really don't understand.  The mmap_lock is catastrophically
> overloaded.  Before the per-VMA lock, every page fault took it for read,
> and every call to mmap() took it for write.  Because our rwsems are
> fair, once one thread has called mmap() it waits for all existing page
> faults to complete _and_ blocks all page faults from starting until
> it has completed.  That's a huge source of unexpected latency for any
> multithreaded application.
> 
> Anything we can do to avoid taking the mmap_sem, even for read, helps any
> multithreaded workload.  Your suggestion that "this is rare, it doesn't
> matter" shows that you don't get it.  That you haven't found a workload
> where you can measure it shows that your testing is inadequate.
> 
> Yes, there's added complexity with the per-VMA locks.  But we need it for
> good performance.  Throwing away performance on a very small reduction
> in complexity is a terrible trade-off.

Yes, this is a technical discussion, and such comments are what I'm looking
for.  Thank you.

What I am not sure so far is that what you worried on a performance degrade
for "this small corner case" doesn't exist.

Let's first check when that vmf_anon_prepare() lines are introduced:

commit 17c05f18e54158a3eed0c22c85b7a756b63dcc01
Author: Suren Baghdasaryan <surenb@google.com>
Date:   Mon Feb 27 09:36:25 2023 -0800

    mm: prevent do_swap_page from handling page faults under VMA lock

It didn't seem like a plan to do late anon_vma check for any performance
reasons.

To figure these out, let me ask some more questions.

1) When you said "you ran a customer workload, and that greatly improved
   performance", are you comparing between:

   - with/without file-typed per-vma lock, or,
   - with/without this patch?

   Note that I'm hopefully not touching that fact that file per-vma should
   work like before for the majority.  And I'm surprised to see your
   comment because I didn't expect this is even measured before.

   To ask in another way: do you mean that it's your intention to check
   anon_vma late for private file mappings when working on file support on
   per-vma lock?

   If the answer is yes, I'd say please provide some document patch to
   support such behavior, you can stop my patch from getting merged now,
   but it's never clear whether someone else will see this and post it
   again.  If it wasn't obviously to Suren who introduced per-vma lock [1],
   then I won't be surprised it's unknown to most developers on the list.

2) What happens if lock_vma_under_rcu() keeps spreading its usage?

   Now it's already spread over to the uffd world.  Uffd has that special
   check to make sure file private mappings are fine in lock_vma().

   When it keeps going like that, I won't be surprised to see future users
   of lock_vma_under_rcu() forget the private file mappings and it can
   cause hard to debug issues.  Even if lock_vma_under_rcu() is exactly
   what you're looking for, I think we may need lock_vma_under_rcu_fault(),
   then lock_vma_under_rcu() should cover private file mappings to make
   sure future users don't expose easily to hard to debug issues.

[1] https://lore.kernel.org/r/CAJuCfpGj5xk-NxSwW6Mt8NGZcV9N__8zVPMGXDPAYKMcN9=Oig@mail.gmail.com

Thanks,

-- 
Peter Xu


