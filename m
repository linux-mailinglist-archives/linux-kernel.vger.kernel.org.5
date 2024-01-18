Return-Path: <linux-kernel+bounces-29575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A30F83105B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2AE1C221D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505AB658;
	Thu, 18 Jan 2024 00:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klUaV1yj"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632D623
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536438; cv=none; b=tF/D6alqeRX90kjaqkglYGkNk+UQlW55BjmUimWtWKmnr6ASNJMlGkymTKg7g829dKZUfK9DUV8CuWJZA6LCIXJOVSDiHJG1a/g8IzWE8K/mBIO3btEkBKQchpX3mudCIO+6/4JdBbVqRCFuGwn6Oe9AuWDH6CL0XoZ8aq5yUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536438; c=relaxed/simple;
	bh=NU3LCCZ44HSvaVqKZ296+stkUROf3JeeuHPjbU8CZtc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=hShC046u9qI0g/i8Aav144gV7T6CMLVYYACm63R7GpOq/67V5MlV8sLlXGl83OsAMJTQ10bgR1A6c5sO9/vxjLa6yv+gucJP2WVlVKMt8cyg7OgNny/dLBvdRuSabVvfsRM4akujdfuZncjKVdXAgWE9NgDYIUj1qiZiB31Vb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klUaV1yj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9c2db82b0so6490335b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705536436; x=1706141236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy8czIk2rbohhNTQxzmNyAw9METMhxbRPhYbJMUzgcs=;
        b=klUaV1yjAefC2vRh4P43E8Pw84nLBXsJ/LFCOp/7SxiwNthJzm05+D7InLLfWcsjAZ
         ornyXneJyP+HsYgnr+zxQPMgm/VFn4JMq8SgHGMjWZVh3eTALgh4/p9DOVWxSpqOtX0M
         +QXV4Sap5/oqcrD8h+5ItMCCfPy4KQBeIZnmy7bB8P8wwgW2ZusPAhlCb3XP7W7vyM4X
         8CGXRV6QdgHjoJvpSnzhwgGRub23YiqE+kO2le9eIhWCxNPodCdnr309necRcZjgNwiG
         SqjLepunq1LBEQ0Q8mSfvBhGiAf/iWZHB8L6fa1OiDtBCBlZeD+wEGBQhaP3FhObtOaH
         ZqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705536436; x=1706141236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yy8czIk2rbohhNTQxzmNyAw9METMhxbRPhYbJMUzgcs=;
        b=MF91u/qpAawHW++o+BMm17qIxtCHxa95KHVVs78H3JfJ3mKrCZKGHaC5NTEqaeTg8m
         cWgTOYHbSXWEWI8DmfdOOlsNLMSP3Q2v8BIA/jAmVF+CALII9QdKHonfOOJZLeNqKFl6
         wTHPqNTiAv8KCPn2gTVu7iAf8jFNHrKcB/3JM71nAfeO3bVIOC/5vLOZMm0piSO3b1P/
         HTAVHVqL8ItOAhmo9cym2DDf22b6QgGTn6U4o2UxfK90DAP7LbDVHwrAyMbkwoVLFBOj
         LZiD1Y3B1EbWLgvWV+fWInUdyXFqsoS/AigbC2KiHjUWFD3uoPrCk/wbdjFP8h6qaCDP
         GlcA==
X-Gm-Message-State: AOJu0Yy4v7IPrO+lJptxp4ieIfv4EDPqpcp35RNtXAwpKETJvdi51gg2
	/meKBA0GT4FcJBertvMoRbQTqfKknVYkKWiI80RkEhQLvgrtZE8FOGPZMpWr4MnUPvUg3oA6CQy
	BkW9xf6zZZiMfYUiMt/M8sXutaxo=
X-Google-Smtp-Source: AGHT+IGTZ3/9oOp+KJxua5AWIKkzAEY2l07bP3Xtgz2flb3B+FV2NhazsCG2blxZb0yeSxDv3ekJIDwj5bL8uLcaZEw=
X-Received: by 2002:a05:6a20:9c8f:b0:199:bcca:f090 with SMTP id
 mj15-20020a056a209c8f00b00199bccaf090mr41480pzb.47.1705536436426; Wed, 17 Jan
 2024 16:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org>
In-Reply-To: <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 17 Jan 2024 16:07:04 -0800
Message-ID: <CAHbLzkoL6sCDciHqVMJga288853CHdOTa5thOPQ9SHKSqjGGPQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > Hi,
> >
> > On 09. 08. 22, 20:24, Rik van Riel wrote:
> >> Align larger anonymous memory mappings on THP boundaries by
> >> going through thp_get_unmapped_area if THPs are enabled for
> >> the current process.
> >>
> >> With this patch, larger anonymous mappings are now THP aligned.
> >> When a malloc library allocates a 2MB or larger arena, that
> >> arena can now be mapped with THPs right from the start, which
> >> can result in better TLB hit rates and execution time.
> >
> > This appears to break 32bit processes on x86_64 (at least). In
> > particular, 32bit kernel or firefox builds in our build system.
> >
> > Reverting this on top of 6.7 makes it work again.
> >
> > Downstream report:
> >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> >
> > So running:
> > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlinux=
btf
> >
> > crashes or errors out with some random errors:
> > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_size=3D0 type=
=3D181346
> > Error emitting field
> >
> > strace shows mmap() fails with ENOMEM right before the errors:
> > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > ...
> > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cannot allocate
> > memory)
> >
> > Note the .tmp_vmlinux.btf above can be arbitrary, but likely large
> > enough. For reference, one is available at:
> > https://decibel.fi.muni.cz/~xslaby/n/btf
> >
> > Any ideas?
>
> This works around the problem, of course (but is a band-aid, not a fix):
>
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned long
> addr, unsigned long len,
>                   */
>                  pgoff =3D 0;
>                  get_area =3D shmem_get_unmapped_area;
> -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> !in_32bit_syscall()) {
>                  /* Ensures that larger anonymous mappings are THP
> aligned. */
>                  get_area =3D thp_get_unmapped_area;
>          }
>
>
> thp_get_unmapped_area() does not take care of the legacy stuff...

Could you please help test the below patch? It is compiled, but I
don't have 32 bit userspace or machine to test it.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94ef5c02b459..a4d0839e5f31 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -811,6 +811,9 @@ static unsigned long
__thp_get_unmapped_area(struct file *filp,
        loff_t off_align =3D round_up(off, size);
        unsigned long len_pad, ret;

+       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
+               return 0;
+
        if (off_end <=3D off_align || (off_end - off_align) < size)
                return 0;


>
> regards,
> --
> js
> suse labs
>

