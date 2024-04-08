Return-Path: <linux-kernel+bounces-135913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EABBD89CD01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED2DB219E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D51474A5;
	Mon,  8 Apr 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhlCUVlm"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57697482
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608830; cv=none; b=iEXO7ripZvrMLU0L+ZqOFDQgBJmnKYcVTR8u0vEuMOJcFGM6xTBfpRY110ZmmGXBD6Gd074lhcZi8ZXTi1QMpH/ltecP6SNGhSBgQCkkcPK5ugvXTNjduaHwuDd/QEIeC+3kbnZ0MLR8EfppjDOVuvCWlFuCrpzhTKh0cKDINrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608830; c=relaxed/simple;
	bh=/lzVzbK8GfEZQ9NiAPI6LOYjttXFw3I14FUKkVXEWbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLvcxbrx0lK09+KDTLic920OSDpPrUrAZpb9oEqWvbHr1a2ZElUshc9jHJQ6QVR4YeRNslqpdc1+thBfuCKbReKCIzhsQmcLKA1fy2LA36ScW9kgYdQ97uS+vDlUQagDbwXNO2dAINLIdTO3R5v0d9h3Gv3/QjyLf8XaL8Vab6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhlCUVlm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-345e1c64695so550749f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712608827; x=1713213627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH7O1NXdJC03aNqvzATcinYdpPQ1XTxhwnXgM4me0RQ=;
        b=EhlCUVlmUbhtFvx2FLjFMTRJAaOjGs//k9n6ku0vbawnPbLgm1/qiw2FfNVn4WOczP
         CqaYJ6pWzNoezaZf8Q3MFTTF244F9pzPqck78JRsNCzLKiHeeHm5hLf7BeJlk71BPQBa
         NA8mgoTOAZ0egfbAUYCJnDgS3UD2dxIyhYjTBrsenZlyP3dQgmbN94/LY2sezW3y+5Pw
         lYt6HoAO+k2GTsanVew5K4X5WsEH59tAbLj1P4HtXM/3tn1E2+/2A2AqqdtErtJYonuR
         kwmsi5QQ1jvTMrdYWfkqrozCi5w7zs4BN5KH0x9os9zHJ45uEU22NiQ5WaLXvfrZlE1/
         qtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712608827; x=1713213627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YH7O1NXdJC03aNqvzATcinYdpPQ1XTxhwnXgM4me0RQ=;
        b=AeDzi5FuoNeZ6f57MXUjMcU00nh8MxYvCkshz0z1+0pEX3VldHZah0xWH6VjbGfAs0
         C2ZTDmW1NMm7qcf9XDmoN9k7ZqHt8WHE13S278ESdtIOK7ZUQ89nxBsu2vd4Q8NM79Sg
         WTituTMyl3bUDKsF3RXyBFZISIMy7PQVSXc2DwwUCjXegHMmzD/A1XFVzAWa8UXLljZT
         Ayx/PH9rPK0zWcMZ5hqZ0pjKt14qrrKa+8faayyP53VILevFE+TJI0/+CfBJ+9yctxYt
         bRMLKCKbaxgFfy+8Uhsa86EGJdr3cRnps7dr/5dUPdXv+B64ZHODBlo4BgWAiKZx+X4F
         G2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXutPzDJiy/kUdSFfZkf9PXz0QKOsG5UIdQmVZDSNdqm3gp6FfLPG8C3C0Vxxnkjj2RB95I2qkTcfDN2IxY7mBVNtV2ewrNl8IIU9hd
X-Gm-Message-State: AOJu0YwO0/dbHocL3m4cJa7+Wwj5EfoBBKo7SWwK0YY/YBVBbQwJDprY
	QP30rAmaVpWmPuexdd81eh9X+dRv9/G4Zjdvz5cDhPkoIdUs0RQkYIcwqMH5/mXSjjcA6PLSxl3
	yzL0Qy1z+3EIdRK8yVxTEyGTg5ow8SgnF0TIp
X-Google-Smtp-Source: AGHT+IFxhfE/RzvX7+ulq0KbAkf7P5D6w45kxMVxgPiuAeYPn2IilZSRtVlEKwNMRCb0uRiYGJdYkTguNKiF7lfjQRE=
X-Received: by 2002:a5d:4811:0:b0:343:d06e:51cb with SMTP id
 l17-20020a5d4811000000b00343d06e51cbmr6748896wrq.19.1712608827286; Mon, 08
 Apr 2024 13:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405231920.1772199-1-peterx@redhat.com> <151c1981-f2ed-43fd-bec3-5ed63efe1c13@redhat.com>
In-Reply-To: <151c1981-f2ed-43fd-bec3-5ed63efe1c13@redhat.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Mon, 8 Apr 2024 13:39:49 -0700
Message-ID: <CAJHvVchiY9v2jkdFzbYukbiUYADCrZcAO-4pW-RwdbLetW8w7w@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: Allow hugetlb change protection upon
 poison entry
To: David Hildenbrand <david@redhat.com>
Cc: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-stable <stable@vger.kernel.org>, 
	syzbot+b07c8ac8eee3d4d8440f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks for the fix, Peter!


On Mon, Apr 8, 2024 at 11:59=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 06.04.24 01:19, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> >
> > After UFFDIO_POISON, there can be two kinds of hugetlb pte markers, eit=
her
> > the POISON one or UFFD_WP one.
> >
> > Allow change protection to run on a poisoned marker just like !hugetlb
> > cases, ignoring the marker irrelevant of the permission.
> >
> > Here the two bits are mutual exclusive. For example, when install a
> > poisoned entry it must not be UFFD_WP already (by checking pte_none()
> > before such install).  And it also means if UFFD_WP is set there must h=
ave
> > no POISON bit set.  It makes sense because UFFD_WP is a bit to reflect
> > permission, and permissions do not apply if the pte is poisoned and
> > destined to sigbus.
> >
> > So here we simply check uffd_wp bit set first, do nothing otherwise.
> >
> > Attach the Fixes to UFFDIO_POISON work, as before that it should not be
> > possible to have poison entry for hugetlb (e.g., hugetlb doesn't do swa=
p,
> > so no chance of swapin errors).
> >
> > Cc: Axel Rasmussen <axelrasmussen@google.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: linux-stable <stable@vger.kernel.org> # 6.6+
> > Link: https://lore.kernel.org/r/000000000000920d5e0615602dd1@google.com
> > Reported-by: syzbot+b07c8ac8eee3d4d8440f@syzkaller.appspotmail.com
> > Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/hugetlb.c | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 8267e221ca5d..ba7162441adf 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6960,9 +6960,13 @@ long hugetlb_change_protection(struct vm_area_st=
ruct *vma,
> >                       if (!pte_same(pte, newpte))
> >                               set_huge_pte_at(mm, address, ptep, newpte=
, psize);
> >               } else if (unlikely(is_pte_marker(pte))) {
> > -                     /* No other markers apply for now. */
> > -                     WARN_ON_ONCE(!pte_marker_uffd_wp(pte));
> > -                     if (uffd_wp_resolve)
> > +                     /*
> > +                      * Do nothing on a poison marker; page is
> > +                      * corrupted, permissons do not apply.  Here
> > +                      * pte_marker_uffd_wp()=3D=3Dtrue implies !poison
> > +                      * because they're mutual exclusive.
> > +                      */
> > +                     if (pte_marker_uffd_wp(pte) && uffd_wp_resolve)
> >                               /* Safe to modify directly (non-present->=
none). */
> >                               huge_pte_clear(mm, address, ptep, psize);
> >               } else if (!huge_pte_none(pte)) {
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

