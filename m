Return-Path: <linux-kernel+bounces-159486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9808B2F38
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CEF283BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D7C78C6F;
	Fri, 26 Apr 2024 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtrIsZ6y"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB387604D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103193; cv=none; b=Nsc1gBPKmzHOUVdkP6j5rhqNlkANJBdj8xKbIpbsrgcP8LEZ8rD121DSWghZqdNseb36XgLkErn4s3KJXoOwTuNDuRLyKknHWYaclrxLaS3aLXwtRXGAqnnaOKqm9sjCGw31FtDWKSOXVfAKa05NxM/hhrqjaUL7Jb+AR2x33ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103193; c=relaxed/simple;
	bh=pRC//LvuGtpP82d38hhF3gkqaFj594fJoemwwmcaR2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERErLVo6qdpEZBRWhf8tS/WxkT6BYYM7RMSVqIFcq0vQlL9q/74/z9DOABuOUy0Hhj1j4k461TGoYg9wfG01PZbhO93FuqUmvvPAsYfaB8Zg4tre7UzzbAXS2W9mhvnlvoZWE0XaWmbcja/3OqhdRnqBeUe75rOIJlVy935OT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtrIsZ6y; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de59daab3f3so1006844276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714103187; x=1714707987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1BiNqNhU+y+tI1tYv0T3j8xw4UhvzM3meLf5Vht+lc=;
        b=XtrIsZ6ydXuEygtQweV5xllWNrH//9pXHTwcHdQl5oejAm8fWjW9BH584LulDQpAzS
         e00Wz6Zyio5y7arGDipi3GefkYDzjQaWnEMT2lh1gUODlvuhNF3mLIRpYUNrxkYMBEwI
         pnry9ILjtaw+0tTV+Gau71NTN4pCxXSfC78SjBy11QsXj5QAndvVB/FGjy/NHRsp53Fm
         4qf17mi2lIzF150OLQHGYcAQBUFMHA3yOhP+Ema+gJA9Q930D2s2vYySop7myDkKH+ai
         azpR9dW10Rqh7mX9NDWvdAHDJDG0mBf+jpYsI+mghE5hE2DY/9jI0wYDpKVsfQ69sRpZ
         0xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714103187; x=1714707987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1BiNqNhU+y+tI1tYv0T3j8xw4UhvzM3meLf5Vht+lc=;
        b=RWgWxV1704ZDpW2P6xgts5DZPJDLYwRMaBjyerlF6Whyp+jPszHaP02QXLmYbPPUY4
         NuviYGGx5b3QXN3Jxi9kZ/D75x/6RrQ6TLG0anBd0LN5fAO9UdJ4RDfWvw9qS9P22kcN
         n8o0Op3kxQBuXTw2mgFVU7fHVMupDrl5/uw7+cq4RhS3UYRXe5MhsyO+Pe6PcVy/ff+7
         RsfREG7PnNSlwjEpdnzhrQiTmhH3dQtGKGwvlPAEd9zi28ASqySRsMSyqKTsgTq9GCFn
         iaUSQbgdKVfgOMW0WGsvDZavGVKFqX5+iB/jOJfbMGOxHBZ4LTpXTqnaRSBxCsX+LZIC
         wcAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUIRin1rSgDdfK5bBLYQPZ+wsaiyNDumZZRX4orNONljbHp8FJGR5Nj271U44f1KptRWvLCam3ZxoPU91skizJ/4ujo5iLK4ndB5JW
X-Gm-Message-State: AOJu0YxVJXmawRCqPUnbtREvJATYYtqnlckQLVKxeNCDa6nsfmFBw4cd
	ozFIwymUd4mSQnXOPxilRHd49lPd2BW1/A626w+4Rcm473zYIO+U7aL8zXZb1C9EG4i2P7Y4lhq
	P1Nd0BFo9sEcnzCH5QDIS2XTtctkTJhSiwRNx
X-Google-Smtp-Source: AGHT+IHG8gnB6NwCs1Ig87OYpAz51zhJ6Ahd1omFdRNn0ihKP/xNtsMkS2kZCOMjK8QJbafJTYx+/tOH6dK5Suh45jA=
X-Received: by 2002:a25:df48:0:b0:de5:49a4:8a9d with SMTP id
 w69-20020a25df48000000b00de549a48a9dmr1666176ybg.39.1714103186722; Thu, 25
 Apr 2024 20:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425205516.work.220-kees@kernel.org> <ebc6pcoq4cle3ge526ch6q5hz2vvphmgwu2yqdveypjm24pa3b@cwsggjnoepaq>
 <CAJuCfpEMK-6+1CUDfiiKLGLfTEomJGjaeHOfsWZZBdaJ6DcvFQ@mail.gmail.com>
 <20240425164917.8c9603387b4cce11121024a8@linux-foundation.org> <t6iykbzqfwt3d7j537shnvebwqy4u5fmzw2gwyeb6a7cosp3hu@eugiwl3t6zfn>
In-Reply-To: <t6iykbzqfwt3d7j537shnvebwqy4u5fmzw2gwyeb6a7cosp3hu@eugiwl3t6zfn>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Apr 2024 20:46:13 -0700
Message-ID: <CAJuCfpGLZ88KMTH93gxfFC++AMCEcObyS1FG_S_w6Ce+koai9A@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: Avoid recursive loop with kmemleak
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:19=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Apr 25, 2024 at 04:49:17PM -0700, Andrew Morton wrote:
> > On Thu, 25 Apr 2024 14:30:55 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > > > --- a/mm/kmemleak.c
> > > > > +++ b/mm/kmemleak.c
> > > > > @@ -463,7 +463,7 @@ static struct kmemleak_object *mem_pool_alloc=
(gfp_t gfp)
> > > > >
> > > > >       /* try the slab allocator first */
> > > > >       if (object_cache) {
> > > > > -             object =3D kmem_cache_alloc(object_cache, gfp_kmeml=
eak_mask(gfp));
> > > > > +             object =3D kmem_cache_alloc_noprof(object_cache, gf=
p_kmemleak_mask(gfp));
> > > >
> > > > What do these get accounted to, or does this now pop a warning with
> > > > CONFIG_MEM_ALLOC_PROFILING_DEBUG?
> > >
> > > Thanks for the fix, Kees!
> > > I'll look into this recursion more closely to see if there is a bette=
r
> > > way to break it. As a stopgap measure seems ok to me. I also think
> > > it's unlikely that one would use both tracking mechanisms on the same
> > > system.
> >
> > I'd really like to start building mm-stable without having to route
> > around memprofiling.  How about I include Kees's patch in that for now?
>
> Agreed

Yes, please. When I figure out a better way, I'll post a separate patch. Th=
anks!

