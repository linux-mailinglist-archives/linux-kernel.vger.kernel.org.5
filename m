Return-Path: <linux-kernel+bounces-149133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C88A8C48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947351C21DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E332D796;
	Wed, 17 Apr 2024 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="SEJIbiTA"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B61928DC1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713383108; cv=none; b=EPzq/GD4rXzBsXXMUcdWX0IxraN8S6t8VWSmpF6bDmv3uudK5Y3hU/KmaPQUq7wr9uKpvzwvhJtsIMDUCP0LlkjZ5r+v18ZZ8LnnQHGm4UODlpFo3tA4mLSl03bCAcF7HE1MZbuhSrwLvJU1sF4mmuvYRsbduYnuQhYmJQdpA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713383108; c=relaxed/simple;
	bh=7u08jegWMdOFzwLjq+sHYvgxUf6Fi+Kz13JQ9NhzYLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7B5T0F+8ARjvB/fPa018uJ8EjQSlJq2zllwK7ikfsp9vYEiOyk9xEafG7dAkf2hO4hUbZ2zhTw/bKrKCAzwGCV4AFgzF8M/7OFoKpsJaMgpL/TrX3OyOx7xcZw6/MwAOFfRAOHdcdZmIpbInyw7/5cvnaa76sqsJKlRa7cOXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=SEJIbiTA; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-436f1a770bdso1632561cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1713383106; x=1713987906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kEFUbyjFnPYj78HJaBv20WJ3deP8o9MXIlptLFC9gA=;
        b=SEJIbiTA12ey+ebsurnfbyIV/6eWYp5cy/NJMVlXOCDFfcHeW3luHfDRIp3ILS7erY
         TSonMpo2oESr4Y6mGSeOU51Yx9S0ognD2HIB1VQLV7npZ8RuWJIENEmYYwMd+jiZYopM
         qnrnIK1byrfqhEIsBEPvS1n30EQMjc2tmndBqkYNsDZMGFB7qwQqYALcwVvrEFbk4IOB
         laM8sIKqPKNRuKakv3iSTB3SLHnIHoOCBeNyVajFezau7Y2MhHcjnF3MSq22lQw15qRV
         9g1AEt5i85eHvwlywUl43AiS3AdRcLQDaCiPj7K4O5WY0uY8nHIXvnwCV2CCm9FK5cyz
         kFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713383106; x=1713987906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kEFUbyjFnPYj78HJaBv20WJ3deP8o9MXIlptLFC9gA=;
        b=UWPKXdRaM7/AObRsx/sd0vvgZ1CmiZzJna7Wq8BOtnM0mfA3tord9Wd3vtroFotmpB
         XnQvWMjyON4I+uhX3ph9YfXfo2HpqJvPStXK0UAqHuJ89LJzS6WJm4QlO7xjhs2Ey40n
         49YVm+Ng9wA5EIzP0aGueiN3ime9wf2DTExdlBnpdqWEqlh/dM8plNzFDGsqIfpbvA0Y
         WT5Qdm2FoiLlT5fc2S7Ta1cL/g8ywsRo/b983UsSC+RhtrofszgcVteNDvLOSiWOn8xe
         Z9uqR4sPDrpqzIFghluOE51ZwdJ25dRTwcgem8p9C8c7rpQzSlo3uRgXIfseD5xyNtxM
         t8dQ==
X-Gm-Message-State: AOJu0YzEDrpYyrTambQ9DJ1MW6OL894KgIrCBl0y1Gmqzo6/ht2qP5s5
	MMKWKLqV6Y9sBjqTjoJUZFtRpvBreO339nnss2S6cvyunIE5d/SD2pZFnmo14IdVCfRUL02QmGo
	7qNEexMbXzA4Cr9DFkt4BjTsa0GNwgmhcrXkRAg==
X-Google-Smtp-Source: AGHT+IF9BhHzehlb5Ie9FDkZYWNsAe4CGi4O39HYr6ZO33yCJ0uRwYckXrJ406izlSTAs1xJqgFG25ohOhGQZVFSDzY=
X-Received: by 2002:ac8:7dcf:0:b0:434:6ff9:266c with SMTP id
 c15-20020ac87dcf000000b004346ff9266cmr199512qte.8.1713383106156; Wed, 17 Apr
 2024 12:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417192643.2671335-1-peterx@redhat.com>
In-Reply-To: <20240417192643.2671335-1-peterx@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 17 Apr 2024 15:44:29 -0400
Message-ID: <CA+CK2bALaCPW-=vRxY=7por9qEi4Ap7arOkYgAzee6_mzTyizQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/page_table_check: Support userfault wr-protect entries
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Nadav Amit <nadav.amit@gmail.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 3:26=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Allow page_table_check hooks to check over userfaultfd wr-protect criteri=
a
> upon pgtable updates.  The rule is no co-existance allowed for any writab=
le
> flag against userfault wr-protect flag.
>
> This should be better than c2da319c2e, where we used to only sanitize suc=
h
> issues during a pgtable walk, but when hitting such issue we don't have a
> good chance to know where does that writable bit came from [1], so that
> even the pgtable walk exposes a kernel bug (which is still helpful on
> triaging) but not easy to track and debug.
>
> Now we switch to track the source.  It's much easier too with the recent
> introduction of page table check.
>
> There are some limitations with using the page table check here for
> userfaultfd wr-protect purpose:
>
>   - It is only enabled with explicit enablement of page table check confi=
gs
>   and/or boot parameters, but should be good enough to track at least
>   syzbot issues, as syzbot should enable PAGE_TABLE_CHECK[_ENFORCED] for
>   x86 [1].  We used to have DEBUG_VM but it's now off for most distros,
>   while distros also normally not enable PAGE_TABLE_CHECK[_ENFORCED], whi=
ch
>   is similar.
>
>   - It conditionally works with the ptep_modify_prot API.  It will be
>   bypassed when e.g. XEN PV is enabled, however still work for most of th=
e
>   rest scenarios, which should be the common cases so should be good
>   enough.
>
>   - Hugetlb check is a bit hairy, as the page table check cannot identify
>   hugetlb pte or normal pte via trapping at set_pte_at(), because of the
>   current design where hugetlb maps every layers to pte_t... For example,
>   the default set_huge_pte_at() can invoke set_pte_at() directly and lose
>   the hugetlb context, treating it the same as a normal pte_t. So far it'=
s
>   fine because we have huge_pte_uffd_wp() always equals to pte_uffd_wp() =
as
>   long as supported (x86 only).  It'll be a bigger problem when we'll
>   define _PAGE_UFFD_WP differently at various pgtable levels, because the=
n
>   one huge_pte_uffd_wp() per-arch will stop making sense first.. as of no=
w
>   we can leave this for later too.
>
> This patch also removes commit c2da319c2e altogether, as we have somethin=
g
> better now.
>
> [1] https://lore.kernel.org/all/000000000000dce0530615c89210@google.com/
>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - Rename __page_table_check_pxx() to page_table_check_pxx_flags(),
>   meanwhile move the pte check out of the loop [Pasha]
> - Fix build issues reported from the bot, also added SWP_DEVICE_WRITE whi=
ch
>   was overlooked before
> v3:
> - Add missing doc update [Pasha]
> ---
>  Documentation/mm/page_table_check.rst |  9 ++++++-
>  arch/x86/include/asm/pgtable.h        | 18 +------------
>  mm/page_table_check.c                 | 39 +++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/pag=
e_table_check.rst
> index c12838ce6b8d..5bd1d987d76d 100644
> --- a/Documentation/mm/page_table_check.rst
> +++ b/Documentation/mm/page_table_check.rst
> @@ -14,7 +14,7 @@ Page table check performs extra verifications at the ti=
me when new pages become
>  accessible from the userspace by getting their page table entries (PTEs =
PMDs
>  etc.) added into the table.
>
> -In case of detected corruption, the kernel is crashed. There is a small
> +In case of most detected corruption, the kernel is crashed. There is a s=
mall
>  performance and memory overhead associated with the page table check. Th=
erefore,
>  it is disabled by default, but can be optionally enabled on systems wher=
e the
>  extra hardening outweighs the performance costs. Also, because page tabl=
e check
> @@ -22,6 +22,13 @@ is synchronous, it can help with debugging double map =
memory corruption issues,
>  by crashing kernel at the time wrong mapping occurs instead of later whi=
ch is
>  often the case with memory corruptions bugs.
>
> +It can also be used to do page table entry checks over various flags, du=
mp
> +warnings when illegal combinations of entry flags are detected.  Current=
ly,
> +userfaultfd is the only user of such to sanity check wr-protect bit agai=
nst
> +any writable flags.  Illegal flag combinations will not directly cause d=
ata
> +corruption in this case immediately, but that will cause read-only data =
to
> +be writable, causing data corrupt when the page content is later modifie=
d.

I would replace: "causing data corrupt ..." to "leading to corruption ..."

> +
>  Double mapping detection logic
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtabl=
e.h
> index 273f7557218c..65b8e5bb902c 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -388,23 +388,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>  static inline int pte_uffd_wp(pte_t pte)
>  {
> -       bool wp =3D pte_flags(pte) & _PAGE_UFFD_WP;
> -
> -#ifdef CONFIG_DEBUG_VM
> -       /*
> -        * Having write bit for wr-protect-marked present ptes is fatal,
> -        * because it means the uffd-wp bit will be ignored and write wil=
l
> -        * just go through.
> -        *
> -        * Use any chance of pgtable walking to verify this (e.g., when
> -        * page swapped out or being migrated for all purposes). It means
> -        * something is already wrong.  Tell the admin even before the
> -        * process crashes. We also nail it with wrong pgtable setup.
> -        */
> -       WARN_ON_ONCE(wp && pte_write(pte));
> -#endif
> -
> -       return wp;
> +       return pte_flags(pte) & _PAGE_UFFD_WP;
>  }
>
>  static inline pte_t pte_mkuffd_wp(pte_t pte)
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index af69c3c8f7c2..388bcf60d8b5 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -7,6 +7,8 @@
>  #include <linux/kstrtox.h>
>  #include <linux/mm.h>
>  #include <linux/page_table_check.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
>
>  #undef pr_fmt
>  #define pr_fmt(fmt)    "page_table_check: " fmt
> @@ -182,6 +184,31 @@ void __page_table_check_pud_clear(struct mm_struct *=
mm, pud_t pud)
>  }
>  EXPORT_SYMBOL(__page_table_check_pud_clear);
>
> +/* Whether the swap entry cached writable information */
> +static inline bool swap_cached_writable(swp_entry_t entry)
> +{
> +       unsigned type =3D swp_type(entry);
> +
> +#ifdef CONFIG_DEVICE_PRIVATE
> +       if (type =3D=3D SWP_DEVICE_EXCLUSIVE_WRITE || type =3D=3D SWP_DEV=
ICE_WRITE)
> +               return true;
> +#endif
> +#ifdef CONFIG_MIGRATION
> +       if (type =3D=3D SWP_MIGRATION_WRITE)
> +               return true;
> +#endif
> +
> +       return false;
> +}

This should be re-written like this:

static inline bool swap_cached_writable(swp_entry_t entry)
{
        return is_writable_device_exclusive_entry(entry) ||
                is_writable_device_private_entry(entry) ||
                is_writable_migration_entry(entry);
}

Otherwise the patch looks good.

Pasha

