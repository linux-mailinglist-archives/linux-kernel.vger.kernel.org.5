Return-Path: <linux-kernel+bounces-139582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C738A04C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDA2286FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE6320A;
	Thu, 11 Apr 2024 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZ1ZiCcE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B132581
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794813; cv=none; b=VS9qHWYyagm9dQkYYfr7y0a1iggO+wT+JeHy8tSxuqN3eImhyXOh0sRUdnoGHWbGtj34hjGzNP93HdC+OCj2fXRKIoIC6UJRgXb5xPLWTZRKegXt/NTDHgtVHg38+0GpsFDhtiM+aISC2eionGlMLNRLBDLRS85MeTcBV/V/+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794813; c=relaxed/simple;
	bh=TFlCWSbGF3Sy6Br3PDKhslNSdWATHavQlwC2wDNbgX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2kzntmXKEDLKwv88D3NeMoeN9o8r8A4+VRgX6nMNsgJBIk1V/EiTt8dg9iqt2r8y3wu/r74M/HT6bfZcUgayBvZEfm9juyjECXEAkbxYsH0c6fqbEkbf6qEKEIy3k04Cw91m4z9976TbMYNK+Vyqf4jUQyug53DftfSt241aLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZ1ZiCcE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712794810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XW7lRdMaw49DZlorZ9rEchurtH6In5AXgWpUcaiLQ0E=;
	b=cZ1ZiCcEMr/EI16cxWe1hqosQX4tUX0YxUWMXpuqZM4qVwoKKRZzFeB87f718gALskjwKG
	LQQJpjkYP0mrYsBbLyg55xT8hu0ZVsmdbHr+ub5Tm/4GAaDWGJ8pVWsVFahPj30wYbPmXu
	wjOC8imJi5nibDsDoVYEjZuiWNnKrXQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-p4_fMAxtMh2cDQquaQ0H5A-1; Wed, 10 Apr 2024 20:20:08 -0400
X-MC-Unique: p4_fMAxtMh2cDQquaQ0H5A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69b147e856aso15958836d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794808; x=1713399608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW7lRdMaw49DZlorZ9rEchurtH6In5AXgWpUcaiLQ0E=;
        b=LLC0NS2oD2+IctEZyvamQNjd6uexKAxjY2Qfii6zRYam+uGlIx3w1Oegb2TNwExTTe
         uAlOLJO/+JZMOaZCz6ipkxTAgr6eDDCB4tR7AliQZ0aJlLHYcmpWgRQClQX3+FMbrf+5
         FIG27Ot6BNjN5y8nCdX8FTIZnjL20SSCJ+3YQ8nbtBeQ2FdBxqUu4v7gjPD+tJtvv3C6
         m0hHUYL/pQg4IxEcqOuyvDZ5M5sXnjL8dslPDZJsdupSK3UaRLcY5UDpOk1OIj3LL8ZQ
         RCpgB9b/mRkUu1Lytp4iNCsadan+rhDqQjgRAmxcxGhJiK23d24hi6ICTZJq9LnQOqcR
         CPYw==
X-Gm-Message-State: AOJu0Yyoan8nZkaBbdaZtLuCY0G0gXr3+rsyefy/8kar1Lc4ssWUYPJn
	Dc4nVJssY+/Qd8XAO/kjIPWPKmsCB0izbcI9/UDA2PO+/LeyadzhQmctDojShwlfePVcj6yZLMA
	1KOwCMEo/Cv59aCBLdmqtL5Vxxzjwq78KIx1JBaz8447g+UTOR0fxTy115/hR6g==
X-Received: by 2002:a05:620a:2a11:b0:78e:bd2d:173c with SMTP id o17-20020a05620a2a1100b0078ebd2d173cmr2006287qkp.1.1712794808023;
        Wed, 10 Apr 2024 17:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUsAzWUcIZoiDeMpE848/lveSpzZmlHz92Aa5PXkLq+ZGgz5DO21Z/mblLyjSYoBpkBxm5Lw==
X-Received: by 2002:a05:620a:2a11:b0:78e:bd2d:173c with SMTP id o17-20020a05620a2a1100b0078ebd2d173cmr2006260qkp.1.1712794807341;
        Wed, 10 Apr 2024 17:20:07 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id pw5-20020a05620a63c500b0078a593b54e6sm255620qkn.96.2024.04.10.17.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:20:06 -0700 (PDT)
Date: Wed, 10 Apr 2024 20:20:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhcstFcjOuOmr0wx@x1n>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <Zhb2BWntckP3ZhDc@casper.infradead.org>
 <Zhb6B8UsidEEbFu3@x1n>
 <ZhcAVYVFSdX5Binc@casper.infradead.org>
 <ZhcDRmyYkMGPgs4F@x1n>
 <ZhcnzS1S6zOMJwSL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhcnzS1S6zOMJwSL@casper.infradead.org>

On Thu, Apr 11, 2024 at 12:59:09AM +0100, Matthew Wilcox wrote:
> On Wed, Apr 10, 2024 at 05:23:18PM -0400, Peter Xu wrote:
> > On Wed, Apr 10, 2024 at 10:10:45PM +0100, Matthew Wilcox wrote:
> > > > I can do some tests later today or tomorrow. Any suggestion you have on
> > > > amplifying such effect that you have concern with?
> > > 
> > > 8 socket NUMA system, 800MB text segment, 10,000 threads.  No, I'm not
> > > joking, that's a real customer workload.
> > 
> > Well, I believe you, but even with this, that's a total of 800MB memory on
> > a giant moster system... probably just to fault in once.
> > 
> > And even before we talk about that into details.. we're talking about such
> > giant program running acorss hundreds of cores with hundreds of MB text,
> > then... hasn't the program developer already considered mlockall() at the
> > entry of the program?  Wouldn't that greatly beneficial already with
> > whatever granule of locks that a future fault would take?
> 
> I don't care what your theory is, or even what your benchmarking shows.
> I had basically the inverse of this patch, and my customer's workload
> showed significant improvement as a result.  Data talks, bullshit walks.
> Your patch is NAKed and will remain NAKed.

Either would you tell me your workload, I may try it.

Or, please explain why it helps?  If such huge library is in a single VMA,
I don't see why per-vma lock is better than mmap lock.  If the text is
combined with multiple vmas, it should only help when each core faults at
least on different vmas, not the same.

Would you go either way, please?

For now my patch got strongly NACKed without yet a real proof.  If that
really matters, I am happy to learn, and I agree this patch shouldn't go in
if that's provided.  Otherwise I am not convinced.  If you think data
talks, I'm happy to try any workload that I am in access with, then we
compare data.

-- 
Peter Xu


