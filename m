Return-Path: <linux-kernel+bounces-27748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCAA82F53E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06701C238BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068581D524;
	Tue, 16 Jan 2024 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u526PYOy"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD731CFAE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432979; cv=none; b=jr/ARGFj6D+mgbG7cE+8DsWUmidswLpTmkc+cVpfTMe85t/RU5bUqVC1lDIJb6hkY3zoTrge6jwlhe11UJnfJY8NaFNdO9xRew0dYnH5+FQ9bt4UBHI6jrvRaFBWDMVXqfl1yVVZr7/mxpOKwoE7UAyxWSO7gDFbX8AJiuXdAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432979; c=relaxed/simple;
	bh=zWpMJClAJpegRSjC1PPQ9eyh9UzxST5eokD55OPU79Y=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=D17Gn9OTaQm5kC4POpeNFkZRgwTxMHXmG9bef9lpVyrEDVXKQvj9lgBtwTkF1NmLqECnrt0ZtyMXXaA5sid4Rx0Nxv5hQvQ8nCTOdb//FjkLwGDiED+KAbo9p40CGuz1bkEHYr6lUdpL5aBwYwomANhYCaPU4XYIM9rH8eU5xoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u526PYOy; arc=none smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so1877a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705432972; x=1706037772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBoJHADn5yia5WgZYpyN6Z8v9Xu4OCPM9aFDyk79ezc=;
        b=u526PYOySrch1+1U8lb2onVLN6zkebGLBHR/ylODntpgkdVjBIjGY5N46U2UMfKU7Y
         /npp5fHJmI/2dpLjcYBh8FvFZx3dFUHD+dxX0ofzhEbGKBPuyozTGUs2L/PgatPNfe80
         35F3AMdOGSLwUoeryYcAylUSRzKAOHtJnkUnN7FKkvjcEpbl0BgRVKQlA7OJMzDSKC1l
         K7SIdy7qTFKSdbpa8ADETQVmCr+1PWLv9+To1KavqQK4gElyHogFajVoMgFAL9NgaoSA
         bYohpzqP0hYYhdUqmMSiqkz5jGh2cw8kF40po+yAzx8JK9C5YXZlhn7j9ptJWt6S0ZLu
         SbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705432972; x=1706037772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBoJHADn5yia5WgZYpyN6Z8v9Xu4OCPM9aFDyk79ezc=;
        b=h7KLx1SrEDIuU7UV0tj8gOK9P9EPHk3XjyzyEqhh5d1t+MgRL3bN1VOTtEMu3lISBa
         4hlahMiPEyp8DLZtUNoJsixlcynxOo20flHiqRJN8Zq+vKibIRXEB5Bx3Yobjyfzm1Kn
         4ToUoArwmZ9d3GeGS6vfdDar7H5MSVdbbMsNOTfXn/Rfj3/EunpKGuq6ry6KMioeMTRt
         nncoTXyQ2JAnBFcoUvHyEcwu/8Uqvq+TjEFBb2y5Ql00Q3MRAQmuCkMDah+b4E/dGRZi
         NSi3zatRVnxAJVOvQcrkLN6IitMilPt1w4YqXsGRyMmI80iQUjyk1IC1iR9bVntZzrZl
         1c2w==
X-Gm-Message-State: AOJu0YxBujd82O7CiZTx4DOYtzVmMgcNz6dYxdBWJlvrddWuXYMUBPHj
	pkF5YMqyPWyZgmZo1nOrpnqGLODZJKYff1vQvkSN7BUQ3Jo0
X-Google-Smtp-Source: AGHT+IHjxPzR+jyYslzWJdRx0ShHrQ+cELtQ2GVWJL4y2I1GjvncbTVaousm9xpzKDlssVPkT68QRXbUu7JlrMymDqw=
X-Received: by 2002:a05:6402:2287:b0:558:8096:5c2f with SMTP id
 cw7-20020a056402228700b0055880965c2fmr14455edb.1.1705432971859; Tue, 16 Jan
 2024 11:22:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221065943.2803551-1-shy828301@gmail.com> <20231221065943.2803551-2-shy828301@gmail.com>
 <7433e325-9af7-4b8c-888e-07a0debf8e46@intel.com>
In-Reply-To: <7433e325-9af7-4b8c-888e-07a0debf8e46@intel.com>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Tue, 16 Jan 2024 11:22:14 -0800
Message-ID: <CAAa6QmQjE=7qYBWSsMF=J2dir+1q9-zmAEkj7Jqg52cC7hy-xQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
To: Yin Fengwei <fengwei.yin@intel.com>
Cc: Yang Shi <shy828301@gmail.com>, oliver.sang@intel.com, riel@surriel.com, 
	willy@infradead.org, cl@linux.com, ying.huang@intel.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Yang,

Should this be marked for stable? Given how easily it is for pthreads
to allocate hugepages w/o this change, it can easily cause memory
bloat on larger systems and/or users with high thread counts. I don't
think that will be welcomed, and seems odd that just 6.7 should suffer
this.

Thanks,
Zach

On Tue, Jan 9, 2024 at 5:36=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com> =
wrote:
>
>
>
> On 2023/12/21 14:59, Yang Shi wrote:
> > From: Yang Shi <yang@os.amperecomputing.com>
> >
> > The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> > boundaries") incured regression for stress-ng pthread benchmark [1].
> > It is because THP get allocated to pthread's stack area much more possi=
ble
> > than before.  Pthread's stack area is allocated by mmap without VM_GROW=
SDOWN
> > or VM_GROWSUP flag, so kernel can't tell whether it is a stack area or =
not.
> >
> > The MAP_STACK flag is used to mark the stack area, but it is a no-op on
> > Linux.  Mapping MAP_STACK to VM_NOHUGEPAGE to prevent from allocating
> > THP for such stack area.
> >
> > With this change the stack area looks like:
> >
> > fffd18e10000-fffd19610000 rw-p 00000000 00:00 0
> > Size:               8192 kB
> > KernelPageSize:        4 kB
> > MMUPageSize:           4 kB
> > Rss:                  12 kB
> > Pss:                  12 kB
> > Pss_Dirty:            12 kB
> > Shared_Clean:          0 kB
> > Shared_Dirty:          0 kB
> > Private_Clean:         0 kB
> > Private_Dirty:        12 kB
> > Referenced:           12 kB
> > Anonymous:            12 kB
> > KSM:                   0 kB
> > LazyFree:              0 kB
> > AnonHugePages:         0 kB
> > ShmemPmdMapped:        0 kB
> > FilePmdMapped:         0 kB
> > Shared_Hugetlb:        0 kB
> > Private_Hugetlb:       0 kB
> > Swap:                  0 kB
> > SwapPss:               0 kB
> > Locked:                0 kB
> > THPeligible:           0
> > VmFlags: rd wr mr mw me ac nh
> >
> > The "nh" flag is set.
> >
> > [1] https://lore.kernel.org/linux-mm/202312192310.56367035-oliver.sang@=
intel.com/
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Tested-by: Oliver Sang <oliver.sang@intel.com>
> > Cc: Yin Fengwei <fengwei.yin@intel.com>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Christopher Lameter <cl@linux.com>
> > Cc: Huang, Ying <ying.huang@intel.com>
> > Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>
> > ---
> >   include/linux/mman.h | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > index 40d94411d492..dc7048824be8 100644
> > --- a/include/linux/mman.h
> > +++ b/include/linux/mman.h
> > @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
> >       return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
> >              _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
> >              _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
> > +            _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
> >              arch_calc_vm_flag_bits(flags);
> >   }
> >
>

