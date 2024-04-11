Return-Path: <linux-kernel+bounces-141177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A768A1ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6BD285CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94461F82C9;
	Thu, 11 Apr 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpQFmWsX"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42C01F786F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850164; cv=none; b=EWLjvuEiVNSsdDzUy3iIzZz5zvRKC+aVFuoh0f3+AXHQcRxJDmAHxrKQIJ364ScutWyBel/a+EgcBleGFhScDPQj9EZemShDHz7qKZh9RVUgLtvHBTXBSICDKKRoO0jG55OqV1moadaaSsjn++9QOlDO9ziidCIG9bdwksFBfgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850164; c=relaxed/simple;
	bh=QZbH30wbKxgTA91ANcVOQZJdEUlr13dkhciBnGreMAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFjySj3mTZ0IwHcgskpk4/qTi2i3WjmJ4Z85f9y0K0LHHIXu1qoTZeHmAhkubB0vZWLwlAtsLkxrvI8tVy/r1NJ0htMvUhhxNZO0fdo9xMyk2rF6VwaeBgOWtt0jJSKtgerzNKZmzf9lGF71eneyoBluMEi81QOEaY2EMrQR1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpQFmWsX; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de0f9a501d6so4394799276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712850162; x=1713454962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emVrn6/X7HIVwrwVbAdXhWseE0fgME6QfLwQFErW8lw=;
        b=dpQFmWsXe2Jsld+ALs4saIwkWT8mS6bbVXg5YKYRSfRDESBJ8jPYQUmTYR2vQNDtdV
         yDIJNHhO9FplR1T38HyW1jfazeQ4GjheoEhJSxBhp1m+QosBgy8n0VEQA6SRCm+gzmvb
         vUI5GCalGFkk77cnaXOL/dETbsfVnswYZeXjL12qcQ8GVdzwpj3hbG4Irf2pYY/RZ8mu
         11mPO2NbGBaJSMFW4M73cP7Sq9r4vEE0q3Y0uOq+i+acjhqghRS9xQfjhBxl2BMbIe8s
         ZOxilpwlEtoPLt2zRihDXktxUBO1ELUgBDvQ3TXQs/YK3pQCnuUKOvNiEwo5JDmAf+Eq
         9I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850162; x=1713454962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emVrn6/X7HIVwrwVbAdXhWseE0fgME6QfLwQFErW8lw=;
        b=RGXgI+DQtQRwwalTy1d6mipNaJkG/v6h0j07oeBNnz45i771Prp0iFFrmnKfHFoDa+
         NALkCfHzb92d//sDYhE9A9A/wIjQldnhozf44uuGzKmwSSy4rPBWw4etq8j5WGXngumc
         i39NlzgSjxrS8nhu23xkzR1c+nai86J2FvuPJtw7bLVOmbJ10cpypZ8PanfhZAA6q0rm
         5bKmRDb5cuca8OSGX6lBk2IVjRneqaj2svSQqN7LGOmlLSM2vLg7tKLz2429I1YRlvTS
         JQPxBN3dliNaTXotcV9s5ZMXfqMG+/RqJkfWZv4e+IsFoMTNn4nkW0FIfS3XhUnVNsN2
         7PoA==
X-Forwarded-Encrypted: i=1; AJvYcCUqXYJyDRB6W8jqrQSUTWjlq/NaNn7IgFmNZNUOtD7cVCa9FHimM+bsWKfTkKgmrqZ8kPEilnqffDTxfbQsiwYps6Jc64G0CdBQOpWL
X-Gm-Message-State: AOJu0YwFJfXCu1rnWbdvqt3IJBvmCvUbaEa/mhPuB+X617cJqqqTxcgP
	C+s6p/QgTdY73cNGDuYgJBPN5PLYSEv0HVXIiMmsPURff3Ks4AKV2zY6AwcIQBBnrx1yRUjj8Af
	IiJhPCxSjhgVl4IFj1DyLZJRuJpt5JLoa9wXG
X-Google-Smtp-Source: AGHT+IHdqaGJdNHQZfv8/iARuu43IXA9KciendMfPcOMNTNNrWbe69SecPwxLIupNq50imWvq+MmoXztMkheqgcH3OE=
X-Received: by 2002:a25:a527:0:b0:dc6:bbeb:d889 with SMTP id
 h36-20020a25a527000000b00dc6bbebd889mr5412038ybi.52.1712850156683; Thu, 11
 Apr 2024 08:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410170621.2011171-1-peterx@redhat.com> <Zhb2BWntckP3ZhDc@casper.infradead.org>
In-Reply-To: <Zhb2BWntckP3ZhDc@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Apr 2024 08:42:23 -0700
Message-ID: <CAJuCfpHKAP6vP98VCYx+UVeHUkYZMkG+oksQBzUJk4myssUniQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 1:26=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Apr 10, 2024 at 01:06:21PM -0400, Peter Xu wrote:
> > anon_vma is a tricky object in the context of per-vma lock, because it'=
s
> > racy to modify it in that context and mmap lock is needed if it's not
> > stable yet.
>
> I object to this commit message.  First, it's not a "sanity check".  It's
> a check to see if we already have an anon VMA.  Second, it's not "racy
> to modify it" at all.  The problem is that we need to look at other
> VMAs, for which we do not hold the lock.
>
> > So the trivial side effect of such patch is:
> >
> >   - We may do slightly better on the first WRITE of a private file mapp=
ing,
> >   because we can retry earlier (in lock_vma_under_rcu(), rather than
> >   vmf_anon_prepare() later).
> >
> >   - We may always use mmap lock for the initial READs on a private file
> >   mappings, while before this patch it _can_ (only when no WRITE ever
> >   happened... but it doesn't make much sense for a MAP_PRIVATE..) do th=
e
> >   read fault with per-vma lock.
>
> But that's a super common path!  Look at 'cat /proc/self/maps'.  All
> your program text (including libraries) is mapped PRIVATE, and never
> written to (except by ptrace, I guess).

Uh, indeed I didn't realize this would be the side-effect from this
early check. And that's exactly why I wanted Matthew's input on this
in [1].

>
> NAK this patch.
>

