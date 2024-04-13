Return-Path: <linux-kernel+bounces-143918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4495F8A3F87
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 01:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79BE1F21762
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC7F446BA;
	Sat, 13 Apr 2024 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="xnts0B9l"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CC1E892
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713049886; cv=none; b=CKAk0lpFUt423YYD5fVMmMb3fYgExPMnISHqKSt8TdSZ7TDL7x8mbmdB4O/mpv5HTO1MEFYqfBRwfU7piEUxBR1QDyZdeGa91Bf7RMnWF14l8H7AcNDLud5Xm3MCJfri1n3Y0gGId/V/7mKP1HH784MSzhr5aGW5f4wPK2dw9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713049886; c=relaxed/simple;
	bh=WOCFtt0c46SWdiDs8r2PoPm+DbunefgRyl83pbxigBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVDhpS6oySVCfMTcVFc+jsXtOwHIWXYYNjKfMyIpcdWqdzzbRnGIFQUeKAsO9GVdBBk0lLcTZD8Dj/ttD3yzBNkzxn8WQgqaZsHxptsDUrZga6zZDsVUiadIe0hWq0Mkc5+Opg8Ru9mtifVqopW1VCfUbOe2qbRX9qbeywr/MJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xnts0B9l; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso1943404276.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 16:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713049883; x=1713654683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csSeqaFAe6Z+ul1ySqtt8/CstapSGfvhsytWycvEOOs=;
        b=xnts0B9loguRYkjJQOD3Kco0L7wIRXW4K9WDTaMz1he72X5utJgGiZ+YP0x0Tg9kHq
         H3/QSepSU1SF8M+goqFLSFyWSK4K0TNFTjambkoDcyAYwusLpLoRiGCcood6a4TAoEV/
         7fo/DsMKo5waSy/bIiqWK8u3vwbmBs54MAMnC8D2nx/y7vAdeiVt+EdagIVMfTOpAHWX
         Vt//4T2fJvS83uW7heE2xtxc0BUSFOml02eB3FDuj+KCIdlYwhW4qhSF2e4xt/iUjfPL
         r/bW6rHlyL+cU77OoQbbyCqziXoKUSNXv7LF3MIKuKYjPdAlJ88IZKQmTXpZIG2EYSC6
         YP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713049883; x=1713654683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csSeqaFAe6Z+ul1ySqtt8/CstapSGfvhsytWycvEOOs=;
        b=sRkYxhZKz4oEQ/tzdfh7HK5aPlyyyGUJCoUduVHXhzoVpI/Ac/bgPclepzbCq/FVQl
         YmdN8cfFC490OhkW6l29h7ZGIHU+5AZoeTBMNQC/ild+wl+je7ZpiHuclOTJ+nFJXj6r
         1Pyg/7WXXeVTLStzimHuRlr+GcmUlrVPg4ogvonXWcXauqQT4MflevGXut6BlasFpRYG
         JArpbdmO8lfyA3KdfvIkpmQ8F+eGx+cHvqGpZrneOiUeyz9qIo3CFmzr9LlhWG8wunQX
         ABBbyDimNn6DYl2Vv9ILoVK9frdbC24u/KwbkxJ/L8NkDVFCoSWagTnFmDBy4GRRoi1T
         Ep+g==
X-Forwarded-Encrypted: i=1; AJvYcCWmm3cWgzfFw8ZjSRzN6khacd95jHAdUZohedR2sBNb+VWMttAvELaNMSHvResRos/na2g73XcJB/izAIWvI3cONXIh0KVskbFCGiWo
X-Gm-Message-State: AOJu0Yz3hj2TuR5+SPUkUBZKKy+RDpjTrFJkQnSGLfMk7G2HxzVSXaGZ
	tPqBU2YHhbLRq/4TTAQ2x2E9xBiUFqEQ9m5eG3GICfWRJ3MIXPvLiTd3S59wFcEu/imVidIvThu
	dG++8VQqNvGg/j3xblQVhKLggoSYdyTM4LsMGtrYBk85kGvHLMw==
X-Google-Smtp-Source: AGHT+IFtxU98M1BnEWEv3QfPEmkPfn29XAjP54gzFcyaJNpV7r83njK1Vbln3Z6d2auODyARE7hwMeA/AA7uLaHZ7vE=
X-Received: by 2002:a05:6902:3c8:b0:dcf:30dc:127c with SMTP id
 g8-20020a05690203c800b00dcf30dc127cmr5325849ybs.18.1713049883140; Sat, 13 Apr
 2024 16:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhhaRXHKk7w_hKgi@x1n> <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org> <ZhkrY5tkxgAsL1GF@x1n>
 <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
 <ZhlCVOz7qaDtldfL@casper.infradead.org> <CAJuCfpGGUD6ev-KFhON2D2RqQRZSgjxFXvkNqeux-LrJw4L+iw@mail.gmail.com>
 <ZhlQ_4Ve0vYNbWbl@casper.infradead.org> <ZhlT4eG05mUcOQQJ@casper.infradead.org>
 <CAJuCfpENhnjnrDPfJPyYaNNLT9VT414VbT45WBoN-EkqTjGMtA@mail.gmail.com> <ZhsMru7gcqR6gL9q@casper.infradead.org>
In-Reply-To: <ZhsMru7gcqR6gL9q@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 13 Apr 2024 16:11:09 -0700
Message-ID: <CAJuCfpH8OpNF3vpcRAoBy_k9G_bMicgoHXipe=93Ub4dLjGOug@mail.gmail.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 3:52=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Apr 13, 2024 at 02:46:56PM -0700, Suren Baghdasaryan wrote:
> > On Fri, Apr 12, 2024 at 8:31=E2=80=AFAM Matthew Wilcox <willy@infradead=
org> wrote:
> > >  - Rename lock_vma() to uffd_lock_vma() because it really is uffd
> > >    specific.
> >
> > I'm planning to expand the scope of lock_vma() and reuse it for
> > /proc/pid/maps reading under per-VMA locks. No objection to renaming
> > it for now but I'll likely rename it back later once it's used in more
> > places.
>
> That would seem like a mistake.  The uffd lock_vma() will create an
> anon_vma for VMAs that don't have one, and you wouldn't want that.
> It seems to me that lock_vma_under_rcu() does everything you want except
> the fallback to mmap_read_lock().  And I'm not sure there's a good way
> to package that up ... indeed, I don't see why you'd want the "take
> the mmap_lock, look up the VMA, drop the mmap read lock" part at all --
> once you've got the mmap_lock, just hold it until you're done.

Yeah, you are right about anon_vma creation. I definitely don't want
that part when reading maps files.

Not sure about holding mmap_lock until I'm done. The goal of that
patch is to minimize blocking of any modifications while we are
reading maps files, so locking smaller parts might still make sense.
But it would be hard to argue one way or another without any data.

