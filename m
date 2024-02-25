Return-Path: <linux-kernel+bounces-79919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BD28628B5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B2B282259
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190FC7476;
	Sun, 25 Feb 2024 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0S1Fic+"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3963CF
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708823582; cv=none; b=MsHCEHCXwqvX2lAapTrHaYE1kuGd09n7DMomb+ei/x279ktruiw+ijNj1md1s6ocbjvSpCsAaEdpE8uLo+AtD11/TjRmDALSKQPIaotoHLUO89r+MSluESBlay0n2ujP/xhMhFJbmsndtBSzFGJNTAChkYnE632i3Z2m/4jzTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708823582; c=relaxed/simple;
	bh=3AHDSRTaZul9BsYwz9Csoa72BU7FzrFQPGDbcauFWcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2OPYE9mXWX7JfdFkjv1EOMfWT78gFKiD7HBOsoBDSz1e4AvMnyZw4RN0+RqijmLgECVDmVCN1fNi4/ghxXORJYcxMcfnkGXZoH37sWzT8mGoWlexoQNYsoSUOd/rxvxSI7H+Ec/aGWPMnXEEQRsmgpSZA+jIyqQ67xN+SSsxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0S1Fic+; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so1382881276.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 17:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708823579; x=1709428379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBmWkRHnX+rayZ1+8KolBLB9Y8UaFwH+z+kRh4M3z/U=;
        b=A0S1Fic+HntpvrsvdvAs9D8oVwCX8KIX3vgGfI2M4EtABTVEHuXtk4nQYmyJ85X5Ix
         LKae1ufkm97MQ3WBu7HseoLMnZFJQBteGgXb2HkDAUKXTjF1cCENQwE5bkKvP0DIBKg6
         iZfjLhlGzDRWQlw2WWQgtaNa3CDcGOUFamNdIeDZ5FfMkaKPTwG+0C+DM3Ks+Ik0vtCX
         OjZXbAp6XPOYT14WulM0P1IXLBIOkm9K8zhKQur/w0ITd8yQkCSBB0/oHn7XLXWEWB09
         JCbbZd5JzDvczylej3UUmmPOwNMj6qQ89DxqUGQ3bz0h7VeM+rl96qu4Z/2m1TK9pFxu
         U9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708823579; x=1709428379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBmWkRHnX+rayZ1+8KolBLB9Y8UaFwH+z+kRh4M3z/U=;
        b=HsYU0cq90EkZmWy1nGJLpsVg+27e2ODOHIpXsMODJtv+y2DSnCVKFOTSXOmJYT06Se
         a60hbmfTRiggIAYf4+6WiRjcy0GyfV91gY+PAeFa3xbrIDRVIHybxWwOdK6SGbapVBT7
         3ohxaT8O31tK8voGk2GLqQ0BbHWMalGxR8/wQ3J50P0oIALlDeUcVG5sefsAiegXPsud
         PMSpi8ruskh6+D3wcZceCDObIQhSOZFNxd8XWKu3kR7lmtGJskKpPuzycC5XWPs/3oE0
         CDZPlLXXywrHF0j0YJyFnZmwxFdus572NIZ2bsiv4y1kWWbK27zN43QPVfwYv3O+VGsF
         VDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpJIx7Ajpx0X7gOn4ZLUYdkGr2DjtrR8h1bgMWUNgSL3d6b4WnylqGj21o0kpCVtXjpzz+m4HSMEuC4A6/1YF5HQ3CDVCqc9Oj/Cgh
X-Gm-Message-State: AOJu0YxSOgUu3NqaKLl2zA2Xd+T4Ad1mmhe5Wmt6Z4BeeTdIDFrE0J7y
	Jr/juqb38qJDJTSOuBMdOMCgOn0eyxqBLskg7dokYZeLsL3VAdAzp4HmXrgmRBPodnnnVe96NQ2
	5c1lJdIMHrfEElPzDcRBKPhbQIye7uPIC3UBT
X-Google-Smtp-Source: AGHT+IGAAllR6CQecVwzwYFxQv6mTO/GWCkTuo/lW9TrmXUMPa8PaZXxJjHI7bpRL2KwGZ3IpVRA0pKkB/ekKb3d8zw=
X-Received: by 2002:a25:ae15:0:b0:dc6:16b7:7d6f with SMTP id
 a21-20020a25ae15000000b00dc616b77d6fmr2102451ybj.10.1708823579088; Sat, 24
 Feb 2024 17:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224015800.2569851-1-surenb@google.com> <c45d16c6-abab-4132-a499-c231dcedebb2@wanadoo.fr>
In-Reply-To: <c45d16c6-abab-4132-a499-c231dcedebb2@wanadoo.fr>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 25 Feb 2024 01:12:46 +0000
Message-ID: <CAJuCfpFskKqCGj4imMMLjUQJWR_8-KHuYc=xAZ4e20+57Zf5Rg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: enumerate all gfp flags
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, petr@tesarici.cz, 
	keescook@chromium.org, pasha.tatashin@soleen.com, mhocko@suse.com, 
	kernel-team@android.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 7:03=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 24/02/2024 =C3=A0 02:58, Suren Baghdasaryan a =C3=A9crit :
> > Introduce GFP bits enumeration to let compiler track the number of used
> > bits (which depends on the config options) instead of hardcoding them.
> > That simplifies __GFP_BITS_SHIFT calculation.
> >
> > Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > ---
> > Changes from v4 [1]:
> > - Split from the series [2] as a stand-alone patch, per Michal Hocko
> > - Added Reviewed-by, per Pasha Tatashin
> > - Added Acked-by, per Michal Hocko
> >
> > [1] https://lore.kernel.org/all/20240221194052.927623-7-surenb@google.c=
om/
> > [2] https://lore.kernel.org/all/20240221194052.927623-1-surenb@google.c=
om/
> >
> >   include/linux/gfp_types.h | 90 +++++++++++++++++++++++++++-----------=
-
> >   1 file changed, 62 insertions(+), 28 deletions(-)
> >
> > diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> > index 1b6053da8754..868c8fb1bbc1 100644
> > --- a/include/linux/gfp_types.h
> > +++ b/include/linux/gfp_types.h
> > @@ -21,44 +21,78 @@ typedef unsigned int __bitwise gfp_t;
> >    * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
> >    */
> >
> > +enum {
> > +     ___GFP_DMA_BIT,
> > +     ___GFP_HIGHMEM_BIT,
> > +     ___GFP_DMA32_BIT,
> > +     ___GFP_MOVABLE_BIT,
> > +     ___GFP_RECLAIMABLE_BIT,
> > +     ___GFP_HIGH_BIT,
> > +     ___GFP_IO_BIT,
> > +     ___GFP_FS_BIT,
> > +     ___GFP_ZERO_BIT,
> > +     ___GFP_UNUSED_BIT,      /* 0x200u unused */
>
> Hi,
>
> what is the need to have this ___GFP_UNUSED_BIT now?

Hi!
We can remove it but then all values will shift. That should be safe
to do now but I prefer one patch to do only one thing. We can add a
separate patch to do further cleanup of unused values.

>
> > +     ___GFP_DIRECT_RECLAIM_BIT,
> > +     ___GFP_KSWAPD_RECLAIM_BIT,
> > +     ___GFP_WRITE_BIT,
> > +     ___GFP_NOWARN_BIT,
> > +     ___GFP_RETRY_MAYFAIL_BIT,
> > +     ___GFP_NOFAIL_BIT,
> > +     ___GFP_NORETRY_BIT,
> > +     ___GFP_MEMALLOC_BIT,
> > +     ___GFP_COMP_BIT,
> > +     ___GFP_NOMEMALLOC_BIT,
> > +     ___GFP_HARDWALL_BIT,
> > +     ___GFP_THISNODE_BIT,
> > +     ___GFP_ACCOUNT_BIT,
> > +     ___GFP_ZEROTAGS_BIT,
> > +#ifdef CONFIG_KASAN_HW_TAGS
> > +     ___GFP_SKIP_ZERO_BIT,
> > +     ___GFP_SKIP_KASAN_BIT,
> > +#endif
> > +#ifdef CONFIG_LOCKDEP
> > +     ___GFP_NOLOCKDEP_BIT,
> > +#endif
> > +     ___GFP_LAST_BIT
> > +};
>
> Does it make sense to have something like:
>    BUILD_BUG_ON(___GFP_LAST_BIT > BITS_PER_LONG, "blah");

I suppose that would not hurt, except gfp_t is unsigned int, not long.
Something like this would work I think:

BUILD_BUG_ON_MSG(___GFP_LAST_BIT > BITS_PER_TYPE(gfp_t), "GFP bit overflow"=
);

except I'm not sure where to put this check. One of the __init
functions in page_alloc.c would probably work but none seem to be
appropriate. mm_core_init() perhaps? Other ideas?

> (should we need to use BIT_ULL() one day)
>
> > +
> >   /* Plain integer GFP bitmasks. Do not use this directly. */
> > -#define ___GFP_DMA           0x01u
> > -#define ___GFP_HIGHMEM               0x02u
> > -#define ___GFP_DMA32         0x04u
> > -#define ___GFP_MOVABLE               0x08u
> > -#define ___GFP_RECLAIMABLE   0x10u
> > -#define ___GFP_HIGH          0x20u
> > -#define ___GFP_IO            0x40u
> > -#define ___GFP_FS            0x80u
> > -#define ___GFP_ZERO          0x100u
> > +#define ___GFP_DMA           BIT(___GFP_DMA_BIT)
> > +#define ___GFP_HIGHMEM               BIT(___GFP_HIGHMEM_BIT)
> > +#define ___GFP_DMA32         BIT(___GFP_DMA32_BIT)
> > +#define ___GFP_MOVABLE               BIT(___GFP_MOVABLE_BIT)
> > +#define ___GFP_RECLAIMABLE   BIT(___GFP_RECLAIMABLE_BIT)
> > +#define ___GFP_HIGH          BIT(___GFP_HIGH_BIT)
> > +#define ___GFP_IO            BIT(___GFP_IO_BIT)
> > +#define ___GFP_FS            BIT(___GFP_FS_BIT)
> > +#define ___GFP_ZERO          BIT(___GFP_ZERO_BIT)
> >   /* 0x200u unused */
>
> Keeping this comment here is now useless, IMHO.

Until the cleanup I would prefer to have it here to denote the gap.
Thanks,
Suren.

>
> CJ
>
> > -#define ___GFP_DIRECT_RECLAIM        0x400u
> > -#define ___GFP_KSWAPD_RECLAIM        0x800u
> > -#define ___GFP_WRITE         0x1000u
> > -#define ___GFP_NOWARN                0x2000u
> > -#define ___GFP_RETRY_MAYFAIL 0x4000u
> > -#define ___GFP_NOFAIL                0x8000u
> > -#define ___GFP_NORETRY               0x10000u
> > -#define ___GFP_MEMALLOC              0x20000u
> > -#define ___GFP_COMP          0x40000u
> > -#define ___GFP_NOMEMALLOC    0x80000u
> > -#define ___GFP_HARDWALL              0x100000u
> > -#define ___GFP_THISNODE              0x200000u
> > -#define ___GFP_ACCOUNT               0x400000u
> > -#define ___GFP_ZEROTAGS              0x800000u
> > +#define ___GFP_DIRECT_RECLAIM        BIT(___GFP_DIRECT_RECLAIM_BIT)
> > +#define ___GFP_KSWAPD_RECLAIM        BIT(___GFP_KSWAPD_RECLAIM_BIT)
> > +#define ___GFP_WRITE         BIT(___GFP_WRITE_BIT)
> > +#define ___GFP_NOWARN                BIT(___GFP_NOWARN_BIT)
> > +#define ___GFP_RETRY_MAYFAIL BIT(___GFP_RETRY_MAYFAIL_BIT)
> > +#define ___GFP_NOFAIL                BIT(___GFP_NOFAIL_BIT)
> > +#define ___GFP_NORETRY               BIT(___GFP_NORETRY_BIT)
> > +#define ___GFP_MEMALLOC              BIT(___GFP_MEMALLOC_BIT)
> > +#define ___GFP_COMP          BIT(___GFP_COMP_BIT)
> > +#define ___GFP_NOMEMALLOC    BIT(___GFP_NOMEMALLOC_BIT)
> > +#define ___GFP_HARDWALL              BIT(___GFP_HARDWALL_BIT)
> > +#define ___GFP_THISNODE              BIT(___GFP_THISNODE_BIT)
> > +#define ___GFP_ACCOUNT               BIT(___GFP_ACCOUNT_BIT)
> > +#define ___GFP_ZEROTAGS              BIT(___GFP_ZEROTAGS_BIT)
> >   #ifdef CONFIG_KASAN_HW_TAGS
> > -#define ___GFP_SKIP_ZERO     0x1000000u
> > -#define ___GFP_SKIP_KASAN    0x2000000u
> > +#define ___GFP_SKIP_ZERO     BIT(___GFP_SKIP_ZERO_BIT)
> > +#define ___GFP_SKIP_KASAN    BIT(___GFP_SKIP_KASAN_BIT)
> >   #else
> >   #define ___GFP_SKIP_ZERO    0
> >   #define ___GFP_SKIP_KASAN   0
> >   #endif
> >   #ifdef CONFIG_LOCKDEP
> > -#define ___GFP_NOLOCKDEP     0x4000000u
> > +#define ___GFP_NOLOCKDEP     BIT(___GFP_NOLOCKDEP_BIT)
> >   #else
> >   #define ___GFP_NOLOCKDEP    0
> >   #endif
> > -/* If the above are modified, __GFP_BITS_SHIFT may need updating */
> >
> >   /*
> >    * Physical address zone modifiers (see linux/mmzone.h - low four bit=
s)
> > @@ -249,7 +283,7 @@ typedef unsigned int __bitwise gfp_t;
> >   #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> >
> >   /* Room for N __GFP_FOO bits */
> > -#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
> > +#define __GFP_BITS_SHIFT ___GFP_LAST_BIT
> >   #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1)=
)
> >
> >   /**
> >
> > base-commit: 603c04e27c3e9891ce7afa5cd6b496bfacff4206
>

