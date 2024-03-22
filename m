Return-Path: <linux-kernel+bounces-112031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B69CE88745F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569BBB21A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB7E7FBC5;
	Fri, 22 Mar 2024 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Tq47jvbP"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62477FBAC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711142050; cv=none; b=JHXXgMDTx9DgEorX7s7WfsA5Y/C/5YEoT0BBzsjKW8t62ET1FZpOUvXGriyHeQPATYkyR/w4uFt2SbHharPG35TVTI+PgoayH3wyKeA0SJqFZ0YMY6QAWmbrp5Yssti2d4UBV7+4LlJIEhzboLrSlTZhgIqfDymrzzBGR0e3F24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711142050; c=relaxed/simple;
	bh=YK8oWB/5jtIhX0dRO1eYJBGTD8O4TPyHeQZLJnKitag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdXmxTfCVqbJqyiT7+mOdtOjPqiTDcpRcL716P2iYZxeGxEqGWGgd/aOmzK73g/ufE6wNOBGZwspus88pL/OV9ymVwkJAOWqT3QgOzQatSbocpKmf/aP8Cnm94TEdJF7N9Rx3BbfbQSYfbORXnH720yGvxw4vWQImF8Zs9BC3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Tq47jvbP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a466a27d30aso336637166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1711142047; x=1711746847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KmgzYVb0qHzcH73XxTT4tk5ZPnrch6O0LrMU5dSxuQ4=;
        b=Tq47jvbPrBpg0pRpjlqi9YL/LJWBpyxn1sfm+6hBKAJuwRJMSyfsTYNK7nyVpfDq9k
         9ffDwARUo0DIPaU9m1E+ldk5tRX9AO26y6Mf1uGapXWB9au1NjHtjv7LDCJhtaQorJVf
         2cLU56jLh6CL3OICfvrQS+VaNeZZGjbFEYghc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711142047; x=1711746847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmgzYVb0qHzcH73XxTT4tk5ZPnrch6O0LrMU5dSxuQ4=;
        b=aqsoYoIkA+6UUt48xcFojhV2sMhmg8w+JYSufmAC4kVxxZ/x+af2GDR0EDYJZ2aJSx
         jMcKe8giZRDIguw6/RLqqDx81flChlYCQYc3kSC3W8kYsM+cdqQe2yipc3+KSGgPilKW
         AyRpwxgUTvIOO7uzKrWVfzCeXeZkOFxEZ6kbbfao60QjEl/cUqkUsWY8dU+EbjVeR71Y
         1XFmH1ZoEx5fLU4Fa/M+b1Ian5JR0Qkr9p8D0KMiL9CbSdSa4lrhQPUl2Xll7GvVSSdX
         OBlGtHHRgjA4qb2IL7SnkYx5gY+uknjSbsgsFjp4tSeurXTq0dx5+4ZVUZIc5/QxaEYw
         JHBg==
X-Forwarded-Encrypted: i=1; AJvYcCWxk3Pi5N9F/2AnrSI7W67Gpo8ji2OeM+Kh2wWZXVXHMvutP7DP6pca01167ZDQWOD84qV3RrECx0T++oAYuQFAzheaT4V4phztFUPa
X-Gm-Message-State: AOJu0YyX9OWSG7M0yxoWhkgoyAatN0SYiMTau4QerMp8vJ+MFlCeDmP8
	M5Ux/l9pD3qUcrVnLtUs1BV7QDxrj4/36HMRtOJutgBO/glzRXA+zx6qD5PTZ7MmFhtOsl/viWg
	MFYvpvpKe8qpL9D6CFjiSXiMW1aP2NmCNypkQ7Q==
X-Google-Smtp-Source: AGHT+IHKQa75GXq/U1NjxtoNfEyHGpXqUM7XHMqglu9Eh8+LxUFFMfvLnYffCDOzrMaHkijgXtHtYKVc5oxO/rNlAOA=
X-Received: by 2002:a17:907:77ce:b0:a46:d049:6de2 with SMTP id
 kz14-20020a17090777ce00b00a46d0496de2mr496828ejc.70.1711142046762; Fri, 22
 Mar 2024 14:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
 <CAJfpegu8qTARQBftZSaiif0E6dbRcbBvZvW7dQf8sf_ymoogCA@mail.gmail.com>
 <c58a8dc8-5346-4247-9a0a-8b1be286e779@redhat.com> <CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com>
 <620f68b0-4fe0-4e3e-856a-dedb4bcdf3a7@redhat.com>
In-Reply-To: <620f68b0-4fe0-4e3e-856a-dedb4bcdf3a7@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 22 Mar 2024 22:13:55 +0100
Message-ID: <CAJfpegub5Ny9kyX+dDbRwx7kd6ZdxtOeQ9RTK8n=LGGSzA9iOQ@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in fuse_copy_do
To: David Hildenbrand <david@redhat.com>
Cc: xingwei lee <xrivendell7@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samsun1006219@gmail.com, 
	syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>, 
	Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 22:08, David Hildenbrand <david@redhat.com> wrote:
>
> On 22.03.24 20:46, Miklos Szeredi wrote:
> > On Fri, 22 Mar 2024 at 16:41, David Hildenbrand <david@redhat.com> wrote:
> >
> >> But at least the vmsplice() just seems to work. Which is weird, because
> >> GUP-fast should not apply (page not faulted in?)
> >
> > But it is faulted in, and that indeed seems to be the root cause.
>
> secretmem mmap() won't populate the page tables. So it's not faulted in yet.
>
> When we GUP via vmsplice, GUP-fast should not find it in the page tables
> and fallback to slow GUP.
>
> There, we seem to pass check_vma_flags(), trigger faultin_page() to
> fault it in, and then find it via follow_page_mask().
>
> ... and I wonder how we manage to skip check_vma_flags(), or otherwise
> managed to GUP it.
>
> vmsplice() should, in theory, never succeed here.
>
> Weird :/
>
> > Improved repro:
> >
> > #define _GNU_SOURCE
> >
> > #include <fcntl.h>
> > #include <unistd.h>
> > #include <stdio.h>
> > #include <errno.h>
> > #include <sys/mman.h>
> > #include <sys/syscall.h>
> >
> > int main(void)
> > {
> >          int fd1, fd2;
> >          int pip[2];
> >          struct iovec iov;
> >          char *addr;
> >          int ret;
> >
> >          fd1 = syscall(__NR_memfd_secret, 0);
> >          addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
> >          ftruncate(fd1, 7);
> >          addr[0] = 1; /* fault in page */

Here the page is faulted in and GUP-fast will find it.  It's not in
the kernel page table, but it is in the user page table, which is what
matter for GUP.

Thanks,
Miklos

