Return-Path: <linux-kernel+bounces-130822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D4897D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835B71F264A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9710A19;
	Thu,  4 Apr 2024 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MAsj+9YR"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E4CA62
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712195419; cv=none; b=I+FWP5MhmU6xpgh/1ASNa7bKHuZFrVD5LsKrQdzNbn+5Q0wSQiV3xiO3y86xHHrPOFIbOi1aHcBYbSwEp+LS8iAguysGWOSIPExJq5cGynccjUr+K7cexugTlELs4Yb1rJaBOC7p+jFEGCuRf9YO1cYOdFptqJ9EPzDsE+ICzQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712195419; c=relaxed/simple;
	bh=Mx9Tm+6e58W+cI+RdjMOcUNxPJCbIFneqMHNM0qT98w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEtrs0EjVJGqKdDSh29C5JZ4S+grAeTMd1cn3pLbRHZu57A+06jrH6mEXJogxYq7de6OBTwKSSMe8tq/3hX9qrkjrtaaamnj9CTtWrqob9bcXo7b9tpDXsV60n5xma3Bse36XHFhkt5ibeB7KvYT39Wij1HwJSf02isqw5kc9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MAsj+9YR; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so1472599276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 18:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712195416; x=1712800216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjyUXBEbZolu4R+4mdtK858xY7CCuNq3MZLz81KaKUo=;
        b=MAsj+9YRFpuBbNiZO5npNBxiTB03pm7XlWPYG5TxiAm8L/7gjsiJs4XVDn/AB9RmBQ
         MZnc7V8ErdQqPvcGhGXvC9e7LlG56zsLykEYjZhLngHLfxMqcEl4WaSX9y4tPq/ffmnI
         pXvqcJ8kanLGdUb5yfUEpZ/jfRFK99Fz6q0ZvjEfvz5VpM474ZvaCxCNFDBI05muWpBX
         lfCgkmU1odt+E4Z2vEmJRONsMSuCyG0HHwJsdNQJVOdWGtKOtJuSGyvIv6WlsqSTXdqB
         fUGfw4Gkr4HFiE54RhxF4oWdjQxcryJr9J033yU9GrMdLAdjAnHtF33N3ZSaCcwXXp2L
         AcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712195416; x=1712800216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjyUXBEbZolu4R+4mdtK858xY7CCuNq3MZLz81KaKUo=;
        b=nYC8j5WBqQV9BGjFIZFylkXabAMZWCuDxBmWZP2+pvXlWU2WBFJXchx67toaxmd2eg
         cGV0HTkbYL9I8X/9sXHuFzQoSGO0ZA4lMIfFHbMUrYUkRSyXqINV6mwMw0Fl3WykmlC3
         dBzoiTXzw2CWpEQDJRigfjJzUzEIUtvqKPuVkWwD+33QZ0PRi20AnH0Co9FBNztGTxWf
         RqrO5VkDRj5kd8vEnYw/oLrPLlO8xapYrnCfxVXKk/JdMXBFm+o+9Vl6Seud8GnZqRah
         /Kgv8/Y2qu4GnQaJgT/w70Oz1Fpcl9DvGpOgQJh5gpT6qAqGU54MzbUe534xngF0wda1
         96eA==
X-Forwarded-Encrypted: i=1; AJvYcCXQRFiwqteVuYPUz/gQF9Tm1262G3sGpDL0w8IFvBiv/WTMg5FjfKGQFw33xvPOT60LdlkLhuzW5uuXzciz5mYGb3GCIAHYCAEa8Zz3
X-Gm-Message-State: AOJu0YwmbJGUGf8nUg0oJV2BDDzgf8PXbLsx9LcDRIwwsurk8JgLWkPK
	m4iFXwOTjQJ2QlFB0ScxwA7yE/Yi0mh/zCMHpuk26z+HpRYj4AmHQ6GQWfibSgfeL4sUO4MuBLD
	RxFFMyhPFlWRnDVq8p6yIAFXTXnEGx6cx487K
X-Google-Smtp-Source: AGHT+IGAysqV52BGyDKFLUgTf4MFZje3HOcB4AeU6v5pQmUTWzkKvYVZpzsr+kl5yzUdyGDkX/R09oJNrbzta/FQWNg=
X-Received: by 2002:a25:8085:0:b0:ddd:7ab7:2320 with SMTP id
 n5-20020a258085000000b00ddd7ab72320mr3162428ybk.27.1712195416050; Wed, 03 Apr
 2024 18:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328020711.125070-1-jiapeng.chong@linux.alibaba.com> <20240403182320.93491c23ed5ae19e94158ceb@linux-foundation.org>
In-Reply-To: <20240403182320.93491c23ed5ae19e94158ceb@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Apr 2024 18:50:03 -0700
Message-ID: <CAJuCfpF8jrZx80j_6DgAKt0d_OSUwktpubY5kEHBp_dgU5A3bQ@mail.gmail.com>
Subject: Re: [PATCH] mm/slab_common: Modify mismatched function name
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 6:23=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
org> wrote:
>
> On Thu, 28 Mar 2024 10:07:11 +0800 Jiapeng Chong <jiapeng.chong@linux.ali=
baba.com> wrote:
>
> > No functional modification involved.
> >
> > mm/slab_common.c:1215: warning: expecting prototype for krealloc(). Pro=
totype was for krealloc_noprof() instead.
> >
> > ...
> >
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1199,7 +1199,7 @@ __do_krealloc(const void *p, size_t new_size, gfp=
_t flags)
> >  }
> >
> >  /**
> > - * krealloc - reallocate memory. The contents will remain unchanged.
> > + * krealloc_noprof - reallocate memory. The contents will remain uncha=
nged.
> >   * @p: object to reallocate memory for.
> >   * @new_size: how many bytes of memory are required.
> >   * @flags: the type of memory to allocate.

Nack.

>
> Well ok, but krealloc_noprof() is just an internal implementation
> detail.  I suggest this documentation be moved to the new krealloc()
> wrapper site.  Because krealloc() remains the thing which people
> actually call.
>
> Presumably the same applies to more of the new _noprof functions.

We don't need this fixup. Randy Dunlap's change [1] should handle
_noprof suffixes correctly. The warning was likely generated because
his change was not yet picked up.

[1] https://lore.kernel.org/all/20240326054149.2121-1-rdunlap@infradead.org=
/

