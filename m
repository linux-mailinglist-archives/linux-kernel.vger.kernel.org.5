Return-Path: <linux-kernel+bounces-80982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47736866E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DFB1C21D83
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA2563402;
	Mon, 26 Feb 2024 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ9y1P6+"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF1633F8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937723; cv=none; b=D4UMZIogLO9RVGgCStV+bJjdXCYwlbGBkx/K6au5cw/2hgv4GVt1H1xoFkHJk5/e/IizsDXQ9dDoYzZ7sG4PT78WLWr4nxh4fDVpAIP+gmgNG3fYqEpStWE6XRohl9xtMuNy9BAsg4Vb/3hahYE0cMwAuPQxObZRNdxn014Jx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937723; c=relaxed/simple;
	bh=FXpxeWXQkgRg7/0hnbUUrk9DWMBqlRXoPwgtM8kCONY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFWWzCce5BR79zHTmUa9IDnsRa+hv5IkStoDNR+eLvo5obZInWC3aJkmCBihGj6h0Zqzn4rz6oFDXkomYqeGluff9SvEJQdyiT4nqKcjmB3j0idMN3apH7Qdz9ZteQT2U8ElyhzZOJQrp/JLRCePSrKgoqlfky4/lkQnPiImny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ9y1P6+; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-608342633b8so23655947b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708937721; x=1709542521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkCFtlqoX39H9E2dfaJPOMPy21LrIumnHS1T319uwME=;
        b=mJ9y1P6+GP0t3vfBVuaznWuVDkVPOnraYcc3y73d101Hje/DpMDR38mbqo3jaCAlg1
         ESpT9ADiLHvfIdg5nlwUYfp4tJEL24ntuwGKHuVerGZ8sQ1mnLafIw3kEvP5CSTN9fpQ
         eIlkXVM+9Tpk4f2IJ5eU1BM0dvYWr/9sk4CnOn+hNOsdcgNwXb0/Cw3eCiS8CvZ7nddO
         4bAsfqPmWJtnvQ3jYiLQ5jEyhrMh8wJxHNG4rx6X47CvJ1AgAe75oOGz8DLE1Xsn2Nm6
         ehR1FWYCIpLUimTOD9rYd68lUW2dF6utvpIN5ZsusbPfPQBBrAeZ3jR9fI6xBYj+tc35
         Emcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708937721; x=1709542521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkCFtlqoX39H9E2dfaJPOMPy21LrIumnHS1T319uwME=;
        b=lHfnR7qEIMwSZyFB6AUjNUetBK+Y2w65LQ0KoF5XmRj3m02xWfwp7Dw+K7NpEdnk6A
         Y5JyY8G9OaoDajcRSdmG8uL+Vpe0VIr8KguRv/TlO772RpQd0WNO7HKyuovNAZIiC6Ho
         an2zT/KWXFz8cdmQE3DOkgUFZBurRBfZakTp4a2cN9mMbtP0r9ZOxgubqNAQPFHqInta
         8mxhZ9M9/byMRIJ782L2To6oF9uBK//gABLQsuI4m4HdAcS0lbuc0hCtf2lrHGfbnvEj
         3UpVBLIKljwPZ91jCkXEyxsRI2L3PUUWInTqx/0vtF1e9V6fYf+wF4y0yXQxSh+dVvcU
         7Rcg==
X-Forwarded-Encrypted: i=1; AJvYcCVYGrSFAeL+nv+lc5jfoNhgJnFeH1HFdsx0EjK4hSbFxObQVF3dg0EOvNflmQIr5NVYMOcqKAGARKXGpGdNj2FDoIVXvueLMx2k0oDc
X-Gm-Message-State: AOJu0Yzhzf9gMv8zIEd2iR48+vJfA0WdO4GaZSaSTE2mGuSLwvp67zkP
	0GVQbWr4XFFBGdW21k5XyO/ST9nTKFVimomaDHmXF+yoxXYIEd9U4Itrou/6HE7pkr3lqE/N56s
	UJxYuYBAFZwTyYxhXxUpuZhDJoeI=
X-Google-Smtp-Source: AGHT+IFpshRlCDcswRxHKDpIYcNPkCMA9n8AA4i9TFIC7v6bKQyn7cCMPvsPzoO9pgN/fqS3O/m2xsrUVN2tnVuvAdg=
X-Received: by 2002:a81:af5f:0:b0:608:e122:88 with SMTP id x31-20020a81af5f000000b00608e1220088mr3737137ywj.9.1708937720800;
 Mon, 26 Feb 2024 00:55:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com> <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
In-Reply-To: <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 26 Feb 2024 16:55:09 +0800
Message-ID: <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: David Hildenbrand <david@redhat.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, songmuchun@bytedance.com, 
	wangkefeng.wang@huawei.com, zokeefe@google.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey David,

Thanks for your suggestion!

On Mon, Feb 26, 2024 at 4:41=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
[...]
> > On Mon, Feb 26, 2024 at 12:00=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> > [...]
> >> On Mon, Feb 26, 2024 at 1:33=E2=80=AFAM Lance Yang <ioworker0@gmail.co=
m> wrote:
> > [...]
[...]
> > +static inline bool pte_range_cont_mapped(pte_t *pte, unsigned long nr)
> > +{
> > +     pte_t pte_val;
> > +     unsigned long pfn =3D pte_pfn(pte);
> > +     for (int i =3D 0; i < nr; i++) {
> > +             pte_val =3D ptep_get(pte + i);
> > +             if (pte_none(pte_val) || pte_pfn(pte_val) !=3D (pfn + i))
> > +                     return false;
> > +     }
> > +     return true;
> > +}
>
> I dislike the "cont mapped" terminology.
>
> Maybe folio_pte_batch() does what you want?

folio_pte_batch() is a good choice. Appreciate it!

Best,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

