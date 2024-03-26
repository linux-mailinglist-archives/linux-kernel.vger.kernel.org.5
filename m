Return-Path: <linux-kernel+bounces-119267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC0A88C662
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEEB1C23F07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3B313C809;
	Tue, 26 Mar 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqzpyW/O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01413C69A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465828; cv=none; b=ccet4T7L3pkl+/neZy2FV6N5aNCqRAW/klSKxx9I6EQrSzq09q6ROF+CpJa/f1HphB3p2U8q3vtIexa9CImqSp/I2/1vWp9AbnL5WjZe2l9A6WHwwCHgTVshSG6ggamoXBn5tp9H5EzB5DHjA5bIarh8mi7lCe74CEyKzaI3pqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465828; c=relaxed/simple;
	bh=e5EeTl3wYXOA8HWoN02Gkhrn5/pml2nfdGqSgR5aucs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0SfyrQMNjxTs1206Acbak9ZRL4jRSi5iOgrD8pyycx1LZxQrQh0iGuRWGT0r3MpHm2O7NS+Z0Z51QzGZIMFob+2gturdC6z2MU8oQpwYKKOG4bqUggnbTyb88H4fgvLZX4cZa6FSv9jYpC+zO4S8Aw8h2bOz1ALir6Yb3ReF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqzpyW/O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711465826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHBAVem4f68aO9p9lIl2iAeX/K7t0SIt6WI+yo8kk5A=;
	b=NqzpyW/OD2WbI/zFOjk1khDSwyLXh9N0/U9opTbQZ1OXYo455Fs4oL/BNINs2C6QPtzCCH
	YBD6eAzfFNhxNFN0yH5Q39Gfh/GOO9tAB35j7lbanECChYvEs/iDCXXL877SOShTBAQVDF
	rdsWqakcCrK1/asc671RXtBNL79ncno=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-z8SDUwxSONu8QpaHxGLhzA-1; Tue, 26 Mar 2024 11:10:25 -0400
X-MC-Unique: z8SDUwxSONu8QpaHxGLhzA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29df4ec4304so4635955a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465823; x=1712070623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHBAVem4f68aO9p9lIl2iAeX/K7t0SIt6WI+yo8kk5A=;
        b=g9hK9/E6InecVJSXb5dQ2JJDwtZc+E0LfIyXqxDEzMv0g2H7ZToukLlybL05nKsavG
         g/VW+egVlRyl5Nj3ZkxI6BnAvjuJUraJ5vcz2OhejQfmRCpIJkM5CITtvgv/KCnGvUkn
         lWQwNjmc/UXSSv3x8Xb5f7tbrZsaVJV0AxXZ0x//U061+0v8jSGZT82z5AUPeKlp61+y
         fPjFdgK02uHltGi2OtGra/RGqJApaUmHzfbn5FOKtCVpsf5pwvFEatkkZKmCNOKzHQvT
         a6dSrmTilksUnoL6JUmvIuMy6gkWia/u4gpLImLeCLT0Dt58+uvOvfiUkxxI/aEZWLuu
         lhpA==
X-Gm-Message-State: AOJu0Ywv6a2TpSok2R4VsYigkzpd/JBiSxDNh0pnLEtvefb7EEozYwY5
	Zf0BUeqFm69fZL724DaNp/4acUfeq064ZVcmB8G+NccBHk4lrUEPbCg91idIpPZQtaPXncRhE/o
	pllc7Oy7KcMRb1282tztp/CwAM6twBvdE7jBa1eu1mSje1+YWDo+kEYZifMIqrGbi2bPX6T+xtn
	pD7hkW1zcwonpa92YwYOz/z/ztshzunD/keAkS
X-Received: by 2002:a17:90a:fe85:b0:2a0:33c2:997e with SMTP id co5-20020a17090afe8500b002a033c2997emr8413639pjb.41.1711465822877;
        Tue, 26 Mar 2024 08:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAJWrGzQomM3G/TFjykkA3Nu+aRm+SLIK3wmvcd0KA8T1wqDiVw9EewPPyP3FnLGu1d7WEN7AavJuwcxUDtgs=
X-Received: by 2002:a17:90a:fe85:b0:2a0:33c2:997e with SMTP id
 co5-20020a17090afe8500b002a033c2997emr8413608pjb.41.1711465822503; Tue, 26
 Mar 2024 08:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326143210.291116-1-david@redhat.com> <20240326143210.291116-3-david@redhat.com>
In-Reply-To: <20240326143210.291116-3-david@redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 26 Mar 2024 16:10:11 +0100
Message-ID: <CAOssrKdKaYua48K5F2xD68cFCoiGZSxcYdqgVXrdYTocey2pTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selftests/memfd_secret: add vmsplice() test
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, xingwei lee <xrivendell7@gmail.com>, 
	yue sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 3:32=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> Let's add a simple reproducer for a scenario where GUP-fast could succeed
> on secretmem folios, making vmsplice() succeed instead of failing. The
> reproducer is based on a reproducer [1] by Miklos Szeredi.
>
> We want to perform two tests: vmsplice() when a fresh page was just
> faulted in, and vmsplice() on an existing page after munmap() that
> would drain certain LRU caches/batches in the kernel.
>
> In an ideal world, we could use fallocate(FALLOC_FL_PUNCH_HOLE) /
> MADV_REMOVE to remove any existing page. As that is currently not
> possible, run the test before any other tests that would allocate memory
> in the secretmem fd.
>
> Perform the ftruncate() only once, and check the return value.
>
> [1] https://lkml.kernel.org/r/CAJfpegt3UCsMmxd0taOY11Uaw5U=3DeS1fE5dn0wZX=
3HF0oy8-oQ@mail.gmail.com
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tools/testing/selftests/mm/memfd_secret.c | 51 ++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/se=
lftests/mm/memfd_secret.c
> index 9b298f6a04b3..9a0597310a76 100644
> --- a/tools/testing/selftests/mm/memfd_secret.c
> +++ b/tools/testing/selftests/mm/memfd_secret.c
> @@ -20,6 +20,7 @@
>  #include <unistd.h>
>  #include <errno.h>
>  #include <stdio.h>
> +#include <fcntl.h>
>
>  #include "../kselftest.h"
>
> @@ -83,6 +84,45 @@ static void test_mlock_limit(int fd)
>         pass("mlock limit is respected\n");
>  }
>
> +static void test_vmsplice(int fd, const char *desc)
> +{
> +       ssize_t transferred;
> +       struct iovec iov;
> +       int pipefd[2];
> +       char *mem;
> +
> +       if (pipe(pipefd)) {
> +               fail("pipe failed: %s\n", strerror(errno));
> +               return;
> +       }
> +
> +       mem =3D mmap(NULL, page_size, prot, mode, fd, 0);
> +       if (mem =3D=3D MAP_FAILED) {
> +               fail("Unable to mmap secret memory\n");
> +               goto close_pipe;
> +       }
> +
> +       /*
> +        * vmsplice() may use GUP-fast, which must also fail. Prefault th=
e
> +        * page table, so GUP-fast could find it.
> +        */
> +       memset(mem, PATTERN, page_size);

Shouldn't the non-prefault case be tested as well?

Thanks,
Miklos


