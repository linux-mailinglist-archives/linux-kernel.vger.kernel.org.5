Return-Path: <linux-kernel+bounces-103534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C087C0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1713E1C21643
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF473173;
	Thu, 14 Mar 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NulDDpo"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBB1EA6F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431838; cv=none; b=hhG5VUwHcuUc3fNhkViBWmN08AjszvuJoHWnS0f1+VaU4sqe5D7BTpSovY7mUupL/be1OiVTW4gpmXCBEqLN4nxo1wjeLi/rKFhceFETO4dXPiV9BDxkeP8MKw9tdxcCms2SUtfqaqg0IzixYv4zFH5bZcLwPAelapxn7rVvo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431838; c=relaxed/simple;
	bh=7HQ3IpO13Y+q9VqOFTfv5rfBRj5NGDdKTqljlt/5bqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLA3HcXnvz3QpcGuj6y8AXrRg4fxS/VYm9OCTpsEJu254tZkMbAGukfDm0KSZP/Oa0u/MGIpnQBxBnUHouJHbv8a/43P2Pwm7WSyYaG5wl+9iW5J3rrsGhwpkeEqK64qMFPq8h/aSt3NfeRRPuNv0785YpUGiSRwiVaWc3qaHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NulDDpo; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-47348b64b56so190985137.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710431835; x=1711036635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HQ3IpO13Y+q9VqOFTfv5rfBRj5NGDdKTqljlt/5bqA=;
        b=1NulDDpo1VPwhNkjm/Z2OK/9rTPnRljRtcwunOh5AC5hj44WU6qyBMkqU6/no5du1y
         1TkgAglE0G2FYY5AwbvKWLs9AMtwRDAujXdZstsBJe3L2FxwDXKutc73IIAa+4dkUEgJ
         BfiR6Vpb046GghGKpbGqqelHqyJebNFE66IkGgMaSkyyCMexhQESwdBoQGdt4Ig8vYMg
         RFXRAuciiTamWbP9NNnUQ9OBSikgHqJL4vcJkWy1nJvF1c2J0u/Prq0xH+xBbFNubGyF
         q4hlQJDQOFaspnSFpk9ygfViCXGmibj1q+XPTxKJjQb6/jEMFAReO625gwJHlZ3zQmtj
         V8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710431835; x=1711036635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HQ3IpO13Y+q9VqOFTfv5rfBRj5NGDdKTqljlt/5bqA=;
        b=NQZyDdau/7ux0yZmFqcjCU4GXir0vQLs1d36PHMgKtTRzypzasttJGZrQNL4hJxEHl
         bJqKyoMEvvAA9m+5vcjyqCnQOsXh9nO/+W0IM5MFSI81CGx5bo/hQ8AsKh/BClzXG2tf
         bkSsMWEuqE9TCVaJfd+dz2m4T5dCOKBxaf1939jR5nZqQSdCcuCsBTgXUVxsiNZH5WKz
         HxjLibgxKy3LQpYTCeMOWu1p2URqYut/Iz2Bv7dlHbEtr7tDlRDlLSXK2QD4bSyQ879t
         m6jcaAs3MsJTQs/rjcwTLtsOa/GGaLj+eAhOfpCq3t8AGnQQjIClq1JKPYppfoLZBOIz
         gmYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3D7hBZ5piwAUYm424c+pTXwssZXPu+gAKZ4uGQnT3DdDAUXe7Tn+jZM/ysuWNWP16d90zhwsebhApa/itv8oHOAC+RbhIXXW6pDvP
X-Gm-Message-State: AOJu0YzYuGXuYdcBJiC3gZmf2A20Wb5HIopIY8swShqNXX4YPJrkpALk
	woOS3pR4ZkgfDHoyjUhHjHHVKiAu8q3bxiFpjxvlkDUw5igzjnonKMNGfU2Y+oHVFp5pGRhd865
	J57ZYvdKBssMGvnXAD8FkvwU+fPvSf2DgrCwo
X-Google-Smtp-Source: AGHT+IEOFuQHsI3D29O5MY90DhCqB2gYp03PZpY3DtGYEUDYmaQaVyOYcsrzQfrSYP+I+5eIGdBCg56AcJ4Fcw+IhwA=
X-Received: by 2002:a67:cd11:0:b0:474:acae:f3c3 with SMTP id
 u17-20020a67cd11000000b00474acaef3c3mr611837vsl.25.1710431835573; Thu, 14 Mar
 2024 08:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206223620.1833276-1-acdunlap@google.com> <168b4e3b-8076-4fc3-92bc-fcd9f2b516a8@intel.com>
 <CAMj1kXE4Yhh_5y=ybFkD7YQUZuh7+-P_Vyzv-gpvbQ=i=eRMnw@mail.gmail.com> <CAMBK9=bTMJircCK9SYHsZcKvbD0oZUByQPXcYciD6mcVqgg6=g@mail.gmail.com>
In-Reply-To: <CAMBK9=bTMJircCK9SYHsZcKvbD0oZUByQPXcYciD6mcVqgg6=g@mail.gmail.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Thu, 14 Mar 2024 08:57:04 -0700
Message-ID: <CAGdbjm+A2UwK0yYfA+AasxqjQJBfRE3k9ubpPcaVP9KJNinxHQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86/asm: Force native_apic_mem_read to use mov
To: Adam Dunlap <acdunlap@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Dave Hansen <dave.hansen@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Arjan van de Ven <arjan@linux.intel.com>, Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Jacob Xu <jacobhxu@google.com>, Alper Gun <alpergun@google.com>, 
	Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 10:20=E2=80=AFAM Adam Dunlap <acdunlap@google.com> w=
rote:
>
> On Fri, Feb 9, 2024 at 7:22=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > this seems like the kind of thing we'll want in -stable in case folks
> > are compiling stable kernels with new clangs.
>
> That makes sense. Note that there was another patch accepted recently
> that fixed another
> clang-with-SEV problem [1], so they should probably be backported to
> the same stable
> branches since neither is that useful without the other.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?i=
d=3D1c811d403afd73f04bde82b83b24c754011bd0e8

Agreed; clang builds of SEV-SNP guests will need both this patch and
[1]. If an additional patch [2] also gets merged, we may want to do
the same for [2] as well.

[2] https://lore.kernel.org/lkml/20240313121546.2964854-1-kevinloughlin@goo=
gle.com/

