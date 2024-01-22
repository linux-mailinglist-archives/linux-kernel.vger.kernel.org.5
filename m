Return-Path: <linux-kernel+bounces-34082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B98372FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869991F24596
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F734123F;
	Mon, 22 Jan 2024 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNPmfxRM"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF023FE35
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952648; cv=none; b=Zxj3vEZMT6H9q0rR79PCz4tZqTrr0MhJrq0DO6o2XSw8IKkkyKrt5CmVwGYyK8+4cFV4JtP5F15L2qFyp30E02lF4rOVnu+spbzOY2EMwSQXUajq8+v/b0wY8LQe0Lm/fKXEj7h4JfaP1iokFuTjJF1QVl5an1w1GnwFLU0K5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952648; c=relaxed/simple;
	bh=8YtNK/+ycoZlfj6U3vKhn9f5tGwOc+MSst2Orzy0QWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tzm1rF39MgZSw+G9r0MgmaDGG+vK6uY8PE3eMrsKVndnYaMvCWGyAwk3mHZ+UGgZtVqfZ+FfJPWURpR/9CcnnnrUsO9HZ+uzn+/YjZpGDJxxarxyEAg37+dcMUcyYfX0jJcABfzY8JGe2gqdJHoEd0vIMnpmhoemgPSKmEHWjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNPmfxRM; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce942efda5so2766818a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705952646; x=1706557446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhvnJ1zPFZKF2xF5l7klcYJLTNgBFSu49KaFf3uRqbM=;
        b=fNPmfxRMJiuV+WHllYzGP73rf1czFPlHEQhA0diktRGjZRjVN6M4d/+A9NmHnd2w18
         7+eqtRFCSFrfbU1t0gmKTfNPAXm9XuCo9JgG73FP9e3h+7O4mxRzBVqiUWx5vS2pPwll
         o5mo74Bs3e2fIkfFOA/n1FFmkgEHDTthgBo7Qr5H3WE9bNLwQdyByf9aqkw//YOJey0s
         FsxJvkULNn0SdoM9pv8bz/E/YqxfJ5SLE7OXoFn7+iYK0BMzMn+QGkb8zPa0LnRVleGl
         I9vrVlvt4ciTpigDwRiGZ91prJdd85vcRiR6I96uSu9ZGkXH0JNvIHYtDsJQ2C3AaZ4B
         Q/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952646; x=1706557446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhvnJ1zPFZKF2xF5l7klcYJLTNgBFSu49KaFf3uRqbM=;
        b=H/rNFhcoRZReIUMNKzJbPyMgHXthcwqM1xh5pdImB2yFveSxqQl22YwtR+cZYvGpYc
         1/zEga+gS+J8ceI6xmMxSXSEN4pFXMmO82/PH/RX3m9PtRUk8S0rZ+CnCWQP3vQYEkJN
         PQ20i7KshzkCZZ/e1sifTbUSW1+6yyD0y2JYO9MVFZ1owPWRsdiyu0z/rU7BD/AazBTR
         CU2APXQSXFGTMHubmAcWgLshihvHb9lYkNEl9uWZbLBtb4GYcDuca6RKx8FK3n4Dtk3N
         4KgGjYwPCLfAZNEMyWpoNTF87AUk7eyo2jM1yAd758k9Adko9mc+r48nzy+7wo3T+Ln9
         X9ww==
X-Gm-Message-State: AOJu0YxzvJ3b+GHj6LJJ5Aph/zBkzqHgbnm6twhJGLLu7aLyZa+atJYk
	/3PREcu3GnkfoPy83xDavvZfEfODCUk0QYPRK+zm9Z7tZj6aqJ8TNI5vg8wuqHa3Sr7sJBxfQb+
	Hj4WGN/JKzyujmkGNskvCBTqSmO9jqWuGy7g=
X-Google-Smtp-Source: AGHT+IEy30QcCOvpCXa3tuPzVS8jmnDIyVxIJztKYFfTkJPPcRsEgf0PNlmHT/LsFK4+3FQczRsiQFTMJVYJmrLy/Mw=
X-Received: by 2002:a17:90a:8d0d:b0:290:1451:2cd0 with SMTP id
 c13-20020a17090a8d0d00b0029014512cd0mr2215010pjo.35.1705952646125; Mon, 22
 Jan 2024 11:44:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com> <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
In-Reply-To: <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 22 Jan 2024 11:43:53 -0800
Message-ID: <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP boundaries
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, 
	cl@linux.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 3:37=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 20/01/2024 16:39, Matthew Wilcox wrote:
> > On Sat, Jan 20, 2024 at 12:04:27PM +0000, Ryan Roberts wrote:
> >> However, after this patch, each allocation is in its own VMA, and ther=
e is a 2M
> >> gap between each VMA. This causes 2 problems: 1) mmap becomes MUCH slo=
wer
> >> because there are so many VMAs to check to find a new 1G gap. 2) It fa=
ils once
> >> it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting this limit=
 then
> >> causes a subsequent calloc() to fail, which causes the test to fail.
> >>
> >> Looking at the code, I think the problem is that arm64 selects
> >> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area() a=
llocates
> >> len+2M then always aligns to the bottom of the discovered gap. That ca=
uses the
> >> 2M hole. As far as I can see, x86 allocates bottom up, so you don't ge=
t a hole.
> >
> > As a quick hack, perhaps
> > #ifdef ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> > take-the-top-half
> > #else
> > current-take-bottom-half-code
> > #endif
> >
> > ?

Thanks for the suggestion. It makes sense to me. Doing the alignment
needs to take into account this.

>
> There is a general problem though that there is a trade-off between abutt=
ing
> VMAs, and aligning them to PMD boundaries. This patch has decided that in
> general the latter is preferable. The case I'm hitting is special though,=
 in
> that both requirements could be achieved but currently are not.
>
> The below fixes it, but I feel like there should be some bitwise magic th=
at
> would give the correct answer without the conditional - but my head is go=
ne and
> I can't see it. Any thoughts?

Thanks Ryan for the patch. TBH I didn't see a bitwise magic without
the conditional either.

>
> Beyond this, though, there is also a latent bug where the offset provided=
 to
> mmap() is carried all the way through to the get_unmapped_area()
> impelementation, even for MAP_ANONYMOUS - I'm pretty sure we should be
> force-zeroing it for MAP_ANONYMOUS? Certainly before this change, for arc=
hes
> that use the default get_unmapped_area(), any non-zero offset would not h=
ave
> been used. But this change starts using it, which is incorrect. That said=
, there
> are some arches that override the default get_unmapped_area() and do use =
the
> offset. So I'm not sure if this is a bug or a feature that user space can=
 pass
> an arbitrary value to the implementation for anon memory??

Thanks for noticing this. If I read the code correctly, the pgoff used
by some arches to workaround VIPT caches, and it looks like it is for
shared mapping only (just checked arm and mips). And I believe
everybody assumes 0 should be used when doing anonymous mapping. The
offset should have nothing to do with seeking proper unmapped virtual
area. But the pgoff does make sense for file THP due to the alignment
requirements. I think it should be zero'ed for anonymous mappings,
like:

diff --git a/mm/mmap.c b/mm/mmap.c
index 2ff79b1d1564..a9ed353ce627 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1830,6 +1830,7 @@ get_unmapped_area(struct file *file, unsigned
long addr, unsigned long len,
                pgoff =3D 0;
                get_area =3D shmem_get_unmapped_area;
        } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+               pgoff =3D 0;
                /* Ensures that larger anonymous mappings are THP aligned. =
*/
                get_area =3D thp_get_unmapped_area;
        }

>
> Finally, the second test failure I reported (ksm_tests) is actually cause=
d by a
> bug in the test code, but provoked by this change. So I'll send out a fix=
 for
> the test code separately.
>
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4f542444a91f..68ac54117c77 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -632,7 +632,7 @@ static unsigned long __thp_get_unmapped_area(struct f=
ile *filp,
>  {
>         loff_t off_end =3D off + len;
>         loff_t off_align =3D round_up(off, size);
> -       unsigned long len_pad, ret;
> +       unsigned long len_pad, ret, off_sub;
>
>         if (off_end <=3D off_align || (off_end - off_align) < size)
>                 return 0;
> @@ -658,7 +658,13 @@ static unsigned long __thp_get_unmapped_area(struct =
file *filp,
>         if (ret =3D=3D addr)
>                 return addr;
>
> -       ret +=3D (off - ret) & (size - 1);
> +       off_sub =3D (off - ret) & (size - 1);
> +
> +       if (current->mm->get_unmapped_area =3D=3D arch_get_unmapped_area_=
topdown &&
> +           !off_sub)
> +               return ret + size;
> +
> +       ret +=3D off_sub;
>         return ret;
>  }

I didn't spot any problem, would you please come up with a formal patch?

