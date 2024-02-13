Return-Path: <linux-kernel+bounces-64198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0479853BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852261F238B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB060B86;
	Tue, 13 Feb 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z0jk3FZU"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB260885
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854126; cv=none; b=gu/4jRt/3BkHuqhgGJJzXpmObOxjWqL8yF5AQCsuKX7z9eIpuA+YnJw4qO2X7Vpv1IXfVWOKOlAEtgkRNDjSjx0Xq0YlNNFSQXsh827NLLmJTbCBRoRQL92ieYEx0ba7me4xUixTgYxf92i8LKrE3pwRArtT6bI2AbETFlugO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854126; c=relaxed/simple;
	bh=wCNV3+N+xUXw6aiO9cmWCuAOUAtC1r54THKKfvL6V50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mcs1umtrPZFE9b3S8MKgdWAAThfCD0f/Y7LdWRGk+bq9oarZ29xUD0gKAxPcUiQOAMY8V2PRn737BZ4TIyjOC0qyAgHc3qDgbKjhs01sCquCU1PsmmvVRlVVZrTqssWh9DxWYEF40n4NZiKCBzAOYluxYSs+SX9g9H7hUu2BCNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z0jk3FZU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-411dd149bd9so1141275e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707854123; x=1708458923; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4FCa1V10al25x2H6TCYXD+ZgK9d/r75JguWzXT91NQ=;
        b=z0jk3FZUMPyV1u8Imb+DIBEQF1DEpBE3EGMKEHAY4HToz/jDHQ6EItUfVjAFuCrQ8/
         7flweKN0VPkVaOc4F1ui43oAh4U1jZBQuEiIsk/1onU9HZie+nRVdHRTez+c6YofvFn4
         O6NunSR/FXAxDrA2KD3jzBnhPVORcTXwrEFSjVEhnXnGApfbD+IDCrtFcq2IQcBwjuYQ
         rgpgoAeJEob0hDvWnTOppewLswvKmNlpRn2keU59BT2TUDHq/UQniBuKgLfYAlkLYnIJ
         0s+wXYfp0yWRfNQ8Mpi1xUDLmOKJPWEFyWF3AbyS99VnfdF3T0IZosR+cm+iUQ5ubf+d
         x1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707854123; x=1708458923;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4FCa1V10al25x2H6TCYXD+ZgK9d/r75JguWzXT91NQ=;
        b=OfGdA5zjw3IVdzZbFbLYg30SRHl3kH8Jylux6e1GHzDaKPP+iuT8fChANHRFUSiBQG
         aJZdwFDzlaV+FbFxjTmvTIgRMUr1yaVh71a6/KMFtG/NKWHedt+cnSnAUJ2NddXjX3JE
         6AEl6LvkJ+Dae4PW/bXYblqoEbKW0VxxMNpetQ2mPpZ285yyJZSf/N2aQCKOWNi2Na7j
         O+1dnjIILYJKfpt91QM9xfpo6zCplRKfhzndVv9CQXRpUgOxCUgEzU5EPGkDEnrm8U3M
         lNXBPzaoq9DVx6j6SeYc/0EyI0ARcz03IE5pwxljwVOzrSFG2VL9/ZZAaJNL52pi3uEs
         mkrw==
X-Forwarded-Encrypted: i=1; AJvYcCVxF/8LeOx64tleCa+eyqZkioyUrSU0FD9DjFXE4BVU7u28FrxwDG6+Pdg6m/lTLKeChm0r509gcCp/4CBa2WU8m4Ya7Wqe9tPdzG8y
X-Gm-Message-State: AOJu0YxPfzW6Kcbf2hWYqSlkk42EUb/q5PqhY1aiyr4T8D7MZNeHcFoC
	TFzER7sW66sVP8cDp7Hm5N5oFqb/3fSsKcX6lCeilT2g8S09ZdwsJP7WmXRlWYc6yHdaQmscpse
	v4n8aHQYSsXunwLJb9OgWA8QOerQB3gJuuo1x
X-Google-Smtp-Source: AGHT+IFWXIXONMt5zEShnmDZcWhv7RgwcR3a9xWQLu/Tf+5zhkKq9vpvvpAG+xYDdOhe8qKwW8Xr2MTM/tJoxmlie5c=
X-Received: by 2002:a5d:6ac5:0:b0:33a:e2d3:c3ec with SMTP id
 u5-20020a5d6ac5000000b0033ae2d3c3ecmr210990wrw.60.1707854123043; Tue, 13 Feb
 2024 11:55:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
 <20240213170609.s3queephdyxzrz7j@revolver> <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
 <20240213184905.tp4i2ifbglfzlwi6@revolver> <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
 <CA+EESO6M5VudYK-CqT2snvs25dnrdTLzzKAjoSe7368X-PcFew@mail.gmail.com>
 <20240213192744.5fqwrlqz5bbvqtf5@revolver> <CAJuCfpEvdK-jOS9a7yv1_KnFeyu8665gFtk871ac-y+3BiMbVw@mail.gmail.com>
 <CA+EESO6TowKNh10+tzwawBemykVcVDP+_ep1fg-_RiqBzfR7ew@mail.gmail.com> <20240213195125.yhg5ti6qrchpela6@revolver>
In-Reply-To: <20240213195125.yhg5ti6qrchpela6@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 13 Feb 2024 11:55:11 -0800
Message-ID: <CA+EESO5F7RB-_AwgxPV=9tCKx=E59sbaxvtc4q3u4sCL6PpcTg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:51=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240213 14:37]:
> ...
>
> > Asking to avoid any more iterations: these functions should call the
> > currently defined ones or should replace them. For instance, should I
> > do the following:
> >
> > #ifdef CONFIG_PER_VMA_LOCK
> > ... uffd_mfill_lock()
> > {
> >         return find_and_lock_dst_vma(...);
> > }
> > #else
> > ...uffd_mfill_lock()
> > {
> >        return lock_mm_and_find_dst_vma(...);
> > }
> > #endif
> >
> > or have the function replace
> > find_and_lock_dst_vma()/lock_mm_and_find_dst_vma() ?
>
> Since the two have the same prototype, then you can replace the function
> names directly.
>
> The other side should take the vma and use vma->vm_mm to get the mm to
> unlock the mmap_lock in the !CONFIG_PER_VMA_LOCK.  That way those
> prototypes also match and can use the same names directly.
>
> move_pages() requires unlocking two VMAs or one, so pass both VMAs
> through and do the check in there.  This, unfortunately means that one
> of the VMAs will not be used in the !CONFIG_PER_VMA_LOCK case.  You
> could add an assert to ensure src_vma is locked prior to using dst_vma
> to unlock the mmap_lock(), to avoid potential bot emails.
>
Perfect. Will do that and address the other comments you had on v5 as well.

Regarding int vs long for 'err' type, I'm assuming you are ok with my
explanation and I should keep long?

> Thanks,
> Liam

