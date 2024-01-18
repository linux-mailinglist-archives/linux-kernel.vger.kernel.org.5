Return-Path: <linux-kernel+bounces-30632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C1832245
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9071C2110A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B611EB52;
	Thu, 18 Jan 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2USuHK8"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17021DA5E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705620622; cv=none; b=OTLjiNfx1MTIKTFBtQqGKpOEvOBbtoM/wmBsx2rKY6zcl8FsuaiyxgGafkZv8qnjCoi4SAe2lbWYWl9MlWFY53zKLD9I6xSwxkwi4DUMWOrBrpCtZ8huF0DSUc5X+75rZwG52XLxdTceYSFpAkcHoid3Fht0w2TNeSfOcVFBztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705620622; c=relaxed/simple;
	bh=z5fPf7zN0RtXmSKi8h8UwIiB1VTg5/bPLOeaIMJh1hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOFVI21NdqP3+lUhWpIMG/nOMCkcW+Y5VBDlCOEGwTAId2SofsPqGDoy7D044uUQ6KMQVROtoKcaicCrptV7faKNZHXJYU9/J+a/9QTPWqMYHMkFI+WLc5mUocrF0E/I11n/PXXrGvs2SCQN5C+nTtWNmvimAtM0PU8eGrcA3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b2USuHK8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-336746c7b6dso150155f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705620619; x=1706225419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5fPf7zN0RtXmSKi8h8UwIiB1VTg5/bPLOeaIMJh1hA=;
        b=b2USuHK8iK7DMZDGYMC+kPDshk32tuLAUEMRcaqF5D54H+Vbc4vaGk7eV+AgqfB3Av
         58ZJqHTb+GHSopV6zWwRPyc64mrwwMNGw7HiUWN1+l0VP45wF9TQ0pLcs6g9U8jmrVfn
         8IIEeQVSI69/tmAbqSg74cE9zNfODO443jdwV1lgJ3n1LdG5LktdhzUFfTEA6YTeDzLz
         QqjJSYxh0Fc1PVWVJR45CCuLfOmx/FccDSrGhPueYbVYgyP8mIhUO0/z2Zi7EX3DSC78
         9NCgFvkx4RVZpS+xCXc/xPS2/6nFE4GC6H6rlpu2hIMcBwpA57AtKoSYxc3x5p7PaJhT
         9JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705620619; x=1706225419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5fPf7zN0RtXmSKi8h8UwIiB1VTg5/bPLOeaIMJh1hA=;
        b=xLaZOupxb3uRZGSWYx91CurH4DHEItjlf1T517NmY+kSWDw2YkNxYf8QshAJOojR21
         J6h5nzco0xR+T8N1FxOO3RQQcgLJTHIudqz8llFyyEe+AtwetZLH9QFfm3jbuv5eRl4M
         GJrbBaNikDq/Z5frRA+vgYHhv7xBw+g4uJtGAYUd1Fh8bCMDklN+4BDjcZp4/GHtU/ZM
         IX/ObLT117U1+yjkkH3NFiDhTyFI02fSrtTqESheCkHUfsAmAv605u46qd9TglLR7jUQ
         lBC7MzQNQL8TVixuthKV1wbowTAPG+VYsczpNymBx56+TSj6pdSPKmBZEfMlnaMpo4NA
         dzdA==
X-Gm-Message-State: AOJu0YwpH8UdIkhtpgCCTV7rEK7UMXfo2W0PGuREcBT1sWVbZFWKQ/d3
	xVvwnjA8q7b6z9GkrFeGa4eWnLDIbQ0bUnFYWmo9Y1w82anNHubMb6fpFzcJd2KxLDokKgh0DMT
	Jp3r0MPElRAeBub/diIw9MCImyajGRm050BWP
X-Google-Smtp-Source: AGHT+IERBKIRZXhUEwT/FvY141cn7UHvj0sDW/KQK0D2C8nJKn7gUoNFHy2qzmo8U2RTdv+h1bRnz1oyiSScKyNcOhE=
X-Received: by 2002:a5d:5092:0:b0:337:c117:10c with SMTP id
 a18-20020a5d5092000000b00337c117010cmr1049929wrt.113.1705620618937; Thu, 18
 Jan 2024 15:30:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117223729.1444522-1-lokeshgidra@google.com> <20240118135941.c7795d52881f486aa21aeea8@linux-foundation.org>
In-Reply-To: <20240118135941.c7795d52881f486aa21aeea8@linux-foundation.org>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Thu, 18 Jan 2024 15:29:42 -0800
Message-ID: <CAJHvVcgcRVB75oevri-KH3=cayez7Wjn=G3nXkuO36r11Y98zQ@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lokesh Gidra <lokeshgidra@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com, 
	peterx@redhat.com, david@redhat.com, bgeffon@google.com, willy@infradead.org, 
	jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies, I had forgotten to re-check the "send plaintext" checkbox
in my e-mail client, so the mailing lists rejected my previous mail. I
am duly ashamed. Allow me to try once more. :)

On Thu, Jan 18, 2024 at 1:59=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 17 Jan 2024 14:37:29 -0800 Lokesh Gidra <lokeshgidra@google.com> =
wrote:
>
> > In mfill_atomic_hugetlb(), mmap_changing isn't being checked
> > again if we drop mmap_lock and reacquire it. When the lock is not held,
> > mmap_changing could have been incremented. This is also inconsistent
> > with the behavior in mfill_atomic().

The change looks reasonable to me. I'm not sure I can conclusively say
there isn't some other mechanism specific to hugetlbfs which means
this isn't needed, though.

>
> Thanks. Could you and reviewers please consider
>
> - what might be the userspace-visible runtime effects?
>
> - Should the fix be backported into earlier kernels?
>
> - A suitable Fixes: target?

Hmm, 60d4d2d2b40e4 added __mcopy_atomic_hugetlb without this. But, at
that point in history, none of the other functions had mmap_changing
either.

So, I think the right Fixes: target is df2cc96e77011 ("userfaultfd:
prevent non-cooperative events vs mcopy_atomic races") ? It seems to
have missed the hugetlb path. This was introduced in 4.18.

Based on that commit's message, essentially what can happen if the
race "succeeds" is, memory can be accessed without userfaultfd being
notified of this fact. Depending on what userfaultfd is being used
for, from userspace's perspective this can appear like memory
corruption for example. So, based on that it seems to me reasonable to
backport this to stable kernels (4.19+).

