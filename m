Return-Path: <linux-kernel+bounces-137471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D043989E297
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853492837C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DE0156F38;
	Tue,  9 Apr 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COcOd5JN"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8013E3E8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687535; cv=none; b=jKNfZin0wdhBzefqVlpM5Ce8uvm/n4vj1Wk2NgVo0RIuNtT9I6B5gp3Iar8ETALixYs9nX9iS8KHNveVlz6qZQb4RngSkE1+cATgp5VlteCHN6mNLoCchB1imdzRe5gWTa3z8+av/RbxGljXaN9/u3gtCkRLiGFGna9yAeAT1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687535; c=relaxed/simple;
	bh=wZoQgVLBw4VDFXd6FLxwRTI9oeMsgJ4z1xvKHfucR6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDrGj3pkbKY5lY0lZmmiHosCph/O1rZ0ykXTiflSUGAmXJndx+vCtFe1/LTQJX4faoP97IaJk5ToMR4UGM8RtiL6huYtMR7ZWyFVmWvHgsWCSxGfntKpstHtXiBQB3WcYdp7JPl8T9LREqMpvP3+TQuluAfCJxwswAv4tlo3ZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=COcOd5JN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e42a6158d5so24605ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712687530; x=1713292330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5abdwPMGcw7HwoxC4O5J3s+hF9tO/lLXB8776mOmRQ=;
        b=COcOd5JN8A365gC8bKx/NlrMFJQR3rCRfLBFpY97kmqG9iJjcZNsCpVH0dSojG4LyS
         s+QfkdxfSP9vfi6E0La3mp2n2smrVWBqQf/AV7sUTFuf69Z4RrFK9177nDro9QhqJ9L/
         zz5oxDvohNJ6Mgz+j2zjLRufsI3XhBcsjoI7YshEc3LG77DIj70xNE7MpZec6EtXEQb0
         A9JVvTEmahpy4Ic/l8ZXjg5F7b76+JcC7XX0pKW9I6kX7gbJLpo/0Ouye31y+NuSQysL
         7z03nPdYVcMnZ8zvJZyOEMK1R/JTDyIGL8k6Uaq81/dEXFHJwvIF8DYKqzdsu5N8v5SW
         yypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712687530; x=1713292330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5abdwPMGcw7HwoxC4O5J3s+hF9tO/lLXB8776mOmRQ=;
        b=CBiXCvSU1XrBgRxKuDamVcrxZ/15WDXZtotUkNRdCkhZbRDERjb2hWbgx1j56C0CsD
         HCMP/fvbF7HfoSnf1RBCxpcslOfHSwmeRlQWQemc9D7DXO70C7eCp8MtMJaBS+TQhx6f
         9VzRYecas+JLlEkIYuwFU5ra5zcoal/6cZXBxwv7xgHYECic6xQ6OCLT6o5y0KToKnqa
         2wY5bw0yp2ah3XdqP8tWEs63RUA3u4TdDxlfpu27z6jxya2p8vQ7ZjEPARzLHmqDaoOy
         mDRdKDK4ldkC4Tw4wKDzqgEkodORkFVrPcngtgxpzJFgxwX7tmPNcBa20f2kG+6nZTs8
         yucg==
X-Forwarded-Encrypted: i=1; AJvYcCW8xbgEWNnbZSjHW7pd9Tz/yLTT2RpDgaocnTAPK8JuabJku2RMyynl8SMwUDVM0v7B+xqODRV0hGb2QToDtx+lNcsLn5FTrruBlq92
X-Gm-Message-State: AOJu0YxaEyJtQXBG1K2/VNGPqVkl9lYRHvJB6SKelYw+OzUAKmW+QVr7
	HKdQzKQ+OENS21iRL4Ijl2giygxCT4vsYZYf3DszLdurAmbVLT5jml4VEurpiPyzv/BwFeMW6uw
	i/JVY5fmkEg0KZzej2Fo36zCC9+e5IpRlT+2r
X-Google-Smtp-Source: AGHT+IGasFNl4zWnhHzHdsfe5RR8e786OEjTNDXrnKxiWvA1Zc0Whu+C9yfBrzIuflmTKPt/f3PNAqmuUJdBFDt8Z5g=
X-Received: by 2002:a17:902:d4c5:b0:1e3:dff3:2a3b with SMTP id
 o5-20020a170902d4c500b001e3dff32a3bmr11701plg.17.1712687530152; Tue, 09 Apr
 2024 11:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401232946.1837665-1-jthoughton@google.com>
 <20240401232946.1837665-2-jthoughton@google.com> <cce476f7-2f52-428a-8ae4-fc5dec714666@redhat.com>
In-Reply-To: <cce476f7-2f52-428a-8ae4-fc5dec714666@redhat.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 9 Apr 2024 11:31:32 -0700
Message-ID: <CADrL8HVPEjdAs3PoTa3sPCvQpimZJG6pP9wbiLjnF5cROxfapA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mm: Add a bitmap into mmu_notifier_{clear,test}_young
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Yu Zhao <yuzhao@google.com>, David Matlack <dmatlack@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Gavin Shan <gshan@redhat.com>, Ricardo Koller <ricarkol@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Rientjes <rientjes@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, I didn't see this in my inbox, sorry David!

On Thu, Apr 4, 2024 at 11:52=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 02.04.24 01:29, James Houghton wrote:
> > diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.=
h
> > index f349e08a9dfe..daaa9db625d3 100644
> > --- a/include/linux/mmu_notifier.h
> > +++ b/include/linux/mmu_notifier.h
> > @@ -61,6 +61,10 @@ enum mmu_notifier_event {
> >
> >   #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> >
> > +#define MMU_NOTIFIER_YOUNG                   (1 << 0)
> > +#define MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE (1 << 1)
>
> Especially this one really deserves some documentation :)

Yes, will do. Something like

    MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE indicates that the passed-in
bitmap either (1) does not accurately represent the age of the pages
(in the case of test_young), or (2) was not able to be used to
completely clear the age/access bit (in the case of clear_young).

>
> > +#define MMU_NOTIFIER_YOUNG_FAST                      (1 << 2)
>
> And that one as well.

Something like

   Indicates that (1) passing a bitmap ({test,clear}_young_bitmap)
would have been supported for this address range.

The name MMU_NOTIFIER_YOUNG_FAST really comes from the fact that KVM
is able to harvest the access bit "fast" (so for x86, locklessly, and
for arm64, with the KVM MMU read lock), "fast" enough that using a
bitmap to do look-around is probably a good idea.

>
> Likely best to briefly document all of them, and how they are
> supposed to be used (return value for X).

Right. Will do.

>
> > +
> >   struct mmu_notifier_ops {
> >       /*
> >        * Called either by mmu_notifier_unregister or when the mm is
> > @@ -106,21 +110,36 @@ struct mmu_notifier_ops {
> >        * clear_young is a lightweight version of clear_flush_young. Lik=
e the
> >        * latter, it is supposed to test-and-clear the young/accessed bi=
tflag
> >        * in the secondary pte, but it may omit flushing the secondary t=
lb.
> > +      *
> > +      * If @bitmap is given but is not supported, return
> > +      * MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
> > +      *
> > +      * If the walk is done "quickly" and there were young PTEs,
> > +      * MMU_NOTIFIER_YOUNG_FAST is returned.
> >        */
> >       int (*clear_young)(struct mmu_notifier *subscription,
> >                          struct mm_struct *mm,
> >                          unsigned long start,
> > -                        unsigned long end);
> > +                        unsigned long end,
> > +                        unsigned long *bitmap);
> >
> >       /*
> >        * test_young is called to check the young/accessed bitflag in
> >        * the secondary pte. This is used to know if the page is
> >        * frequently used without actually clearing the flag or tearing
> >        * down the secondary mapping on the page.
> > +      *
> > +      * If @bitmap is given but is not supported, return
> > +      * MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
> > +      *
> > +      * If the walk is done "quickly" and there were young PTEs,
> > +      * MMU_NOTIFIER_YOUNG_FAST is returned.
> >        */
> >       int (*test_young)(struct mmu_notifier *subscription,
> >                         struct mm_struct *mm,
> > -                       unsigned long address);
> > +                       unsigned long start,
> > +                       unsigned long end,
> > +                       unsigned long *bitmap);
>
> What does "quickly" mean (why not use "fast")? What are the semantics, I
> don't find any existing usage of that in this file.

"fast" means fast enough such that using a bitmap to scan adjacent
pages (e.g. with MGLRU) is likely to be beneficial. I'll write more in
this comment. Perhaps I should just rename it to
MMU_NOTIFIER_YOUNG_BITMAP_SUPPORTED and drop the whole "likely to be
beneficial" thing -- that's for MGLRU/etc. to decide really.

>
> Further, what is MMU_NOTIFIER_YOUNG you introduce used for?

MMU_NOTIFIER_YOUNG is the return value when the page was young, but we
(1) didn't use a bitmap, and (2) the "fast" access bit harvesting
wasn't possible. In this case we simply return 1, which is
MMU_NOTIFIER_YOUNG. I'll make kvm_mmu_notifier_test_clear_young()
properly return MMU_NOTIFIER_YOUNG instead of relying on the fact that
it will be 1.

Thanks David!

