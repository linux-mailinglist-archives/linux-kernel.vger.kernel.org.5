Return-Path: <linux-kernel+bounces-145537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99808A5787
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898861F210FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1ED7F7C1;
	Mon, 15 Apr 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="K/eeZLy/"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5922D2E40F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197959; cv=none; b=XZJSQo5vsRN/IjyJ2axB3u9DxU4HU0deQyNCWfArIhgZpbeo1NTeoGMZaMeeAAMOQPxIn2LxC8s1nmZt1DHOiDMOV1DMuNZLS3ud2IU17zZNf3WhLfVi+q2raXphTX7N4wkmNdaI5A1CGtFjWzjPVc9Q0VLNcxt9X/SuDMKslNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197959; c=relaxed/simple;
	bh=sFWqj0MxFEzmV/dJCFfJa0tzV6KTqfIG57eNL/QetZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofYlSCKSSiulZ+f7DABbOeLt/0k1E+KjkbpfIevdercRJFIFoIWfT2PpquZr0XNz1twERW8QA4+uKVHLJ2Gb4hRFlwmMuSYw8O61DgGBrcTHwBwffKGJ1/42lCB0D/dIRzJrTQEthpRKSijoGTg7s8sShrjOXJvS3elS4TKF8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/eeZLy/; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3407543276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713197957; x=1713802757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqUuv9fxx4EarUb3kFRLC/klI4ssEw0WfUtLM6EuUlg=;
        b=K/eeZLy/R+5MRoAxLpyOyLUYEQBpNvIyF4sBcAuHeZBcUlJiatjc3Vs2v8G+AHbbxU
         RT5xMEfKzSIWm2B+NXUm3gEwp7y/RvO1kqm9teApZw3qc5tcA/EgPmuMh8bng22Qkeyq
         FpZCKzqIRnkvNhvTQ5dLikYZ6pmnahb8oFUz3q29uh2fe/tVGzntPTysrJ5nUnS51WI8
         mFyuZX+yEHQbHXrktwJupfxy7q3kD/rvj0j9TzjpoUPzly6N5ocIlQHcpkvTRw983hcM
         sz5WrRVs/ps6fFIXJaatcRmnfM9PX8RNmz8/PAOkFLgvPRFUSyflvZNXG4fcCkrt+uCO
         quYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197957; x=1713802757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqUuv9fxx4EarUb3kFRLC/klI4ssEw0WfUtLM6EuUlg=;
        b=Nr3X0SljvTwLnd6K5vVd5EdqccHqoTtv94S1nQJ+2624oARjB6lHQebulJ5mxG6JQY
         4ZCm88EyTz7AFVY5HlXUhys4P6+knIqc1g8sTIILQia2UmSZUx+C0nFdi53/fUVkPISj
         OjkL8A4u19Lk0hNwROmhigZcHONzhdc/HwSMLm2heO9kVkUkiY3jxBMzY7HWkJyO6U3o
         xsejeQwE9aKzgIpcs9Du8ie+Cq7M+icZhyLxOpVtWSVhP6qNwTCQr6QCyOiTGpNLhRxC
         ZNtrK8K1utrFMZZyEnzjKVGck2fP6g6fv6RlApH5m+rRVMprWEf50uCCihavvTsYeETM
         zJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeqlPfLJkFkp6ONzR7QV6/TAS8nKHjJpKByiRxs33spaFkmijmuhKBy78xW0e+vxoDr9EYlK2HGPPOCmwXk9SEk0+6zB8deASu8pX+
X-Gm-Message-State: AOJu0YxkWOe6irpH5hjmKDkhmsRkL7rSQkZd0/Y2xisV7FikPmld4TlA
	S07COA5w5fatA1UmkgZ27EgVhGbpzpfZGEo9PNWzUDvy6itF3JshxnIfTDLlvaaEVolB2Y339TZ
	SRW/h5SGgiVG5OgWo1pns9LDC/9BxNUiIGoDA
X-Google-Smtp-Source: AGHT+IHQ1hSvcEI2XatWFIotdHbIdMS88GTemv+Jc97ykRM2AbU4LHYqkuGNtXF9fHUCT1K16Qwrmbue3o9cH+MwjAQ=
X-Received: by 2002:a25:b10b:0:b0:de0:d515:259b with SMTP id
 g11-20020a25b10b000000b00de0d515259bmr8502533ybj.59.1713197956946; Mon, 15
 Apr 2024 09:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhhV3PKgEX9d7_vA@casper.infradead.org> <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org> <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZhkrY5tkxgAsL1GF@x1n> <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
 <ZhlCVOz7qaDtldfL@casper.infradead.org> <CAJuCfpGGUD6ev-KFhON2D2RqQRZSgjxFXvkNqeux-LrJw4L+iw@mail.gmail.com>
 <ZhlQ_4Ve0vYNbWbl@casper.infradead.org> <CAJuCfpH3sKvczqRix6Q6QX9L4FsHQbmnyFXetvY+TzVUk38soA@mail.gmail.com>
 <Zh1SMHdN9xK9N2U_@casper.infradead.org>
In-Reply-To: <Zh1SMHdN9xK9N2U_@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 15 Apr 2024 09:19:06 -0700
Message-ID: <CAJuCfpFjhfEYzG2zBNnE0Spv1=DbamKTc46ie0U3r7QniOnqRA@mail.gmail.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 9:13=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Apr 15, 2024 at 08:58:28AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Apr 12, 2024 at 8:19=E2=80=AFAM Matthew Wilcox <willy@infradead=
org> wrote:
> > >
> > > On Fri, Apr 12, 2024 at 09:53:29AM -0500, Suren Baghdasaryan wrote:
> > > > Unless vmf_anon_prepare() already explains why vma->anon_vma poses =
a
> > > > problem for per-vma locks, we should have an explanation there. Thi=
s
> > > > comment would serve that purpose IMO.
> > >
> > > I'll do you one better; here's some nice kernel-doc for
> > > vmd_anon_prepare():
> >
> > I was looking at the find_tcp_vma(), which seems to be the only other
> > place where lock_vma_under_rcu() is currently used. I think it's used
> > there only for file-backed pages, so I don't think your change affects
> > that usecase but this makes me think that we should have some kind of
> > a warning for lock_vma_under_rcu() future users... Maybe your addition
> > of mmap_assert_locked() inside __anon_vma_prepare() is enough. Please
> > don't forget to include that assertion into your final patch.
>
> That's patch 1/3 on the git branch I pointed you to.

Ah, good!

>
> The tcp vma is not file backed, but I'm pretty sure that COW is not
> something they want, so there's never an anon_vma.  It's for pages
> that contain received TCP packets; ie it's mmaped TCP.

I was following
tcp_zerocopy_receive()->tcp_zerocopy_vm_insert_batch()->vm_insert_pages()->=
insert_page_in_batch_locked()->validate_page_before_insert()
which errors out for PageAnon(page). So, I assumed this path works on
file-backed pages but I'm not familiar with this code at all.

