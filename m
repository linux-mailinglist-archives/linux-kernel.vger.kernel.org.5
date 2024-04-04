Return-Path: <linux-kernel+bounces-131739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F9E898B4A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FB01F223ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3723129E66;
	Thu,  4 Apr 2024 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djlZVFPv"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A712880A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245034; cv=none; b=fnQ64RkkwDTyVnWcLE2stgKmOetTVsEBF0Gusko8fK84/dARt38jhiNJPU63g+b+eLKyDpK+AkBGhYk7UCeLApVaaPfmaEzZ9VY/P7eHNC7esrQfgth2myHItp39W9KYGhXuNPF6zbbQrcrkJqujKUCT4t4fDwuESnJF+GVT+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245034; c=relaxed/simple;
	bh=rh308rWw6gHdzW+9iFeyJleadKTKO70kRa3tTyqNZhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7VAO00NGUmA7aPbJIYJxaicbPcXOkxMhUXbyIFOPpJCiWYeyhoHa2huTKaui4OGyKMXTx5VkVp/zOy6AH/vHGdVSEodrv8rYgmdsTHzw/JwJa5yxnP2ZLteemdo5vKAZyo53tuWAqnUaP74rwRbh86+DtXTJEzFe4YXKXckbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djlZVFPv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso2070761e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712245030; x=1712849830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trXOoAuOkYr9Ii3Fm42NBKS3Vzr34bcelX8vrPxLcjo=;
        b=djlZVFPvjVsrx+HgkdHj1YWzjok3J+9KsFLNn1zfa71JVm6ciM/rGcoIq7mWJ26nqk
         RL34JkF9bavOua77chdvtIxPw+3biGNJUIFsR7zFUznAuSUL0yEki5M25hjFuzjvsQaD
         /3ocYleBshP+LqaWo4xeiMmQmXubbFUgFhj+s16XmnX/Ktr/kkUo+DTNVKLsHZGzbcfb
         v+JaKiLGYQ4LI3N+ewOscD81asNqJZc+OPkuNydWHoKHK2QFDDvvz+YIZXcRB9joh7kv
         AGUoq82V7fHHiZwgXxJVzaLhZo6KZjlEe9Eo3kU6cw9eOJfXQtGNbxYh0+eRpRzQs1b2
         jHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712245030; x=1712849830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trXOoAuOkYr9Ii3Fm42NBKS3Vzr34bcelX8vrPxLcjo=;
        b=X2bNAeZQ8RD7n+1tJ8AbtEB9YlVFZdrs6gF6M0q2TiicbxLApcHKYhgFsmDG9zu53N
         VHkmiuSjSK8GXblbiCS10YAZmSZnHgcUArqtQYLUUEqFnQBycbg7kxG1WUwAX2Z796Rw
         lzJdeY2Kv7QfixQY+vqR08Z8JY6qShEJnnOu5i9oPL5EzLcz5QrNuJmFukScHKbl9gjM
         2CJDL2uZrykF5+YbGuneeht+aMtanapLlrpHeMFJsJCZ3dBXPKxhr/aqKg3DMUXwkD4o
         8jFqAWLOj+CgL/wZMc2h7dP5AkTKWTRVvtXMlnRnyUtYPcmFPEq9kkJQ1xeHR37ITW19
         Ac/A==
X-Forwarded-Encrypted: i=1; AJvYcCXHQjRAqOyKSJ6HeocKH7UaRlTM/IThnBwky8dDYiGRuY1hCBZDaJ57XpPtPmjQmrepkExI/kKcZHycjwZYiNXuyozVsYZyUjhSlMgy
X-Gm-Message-State: AOJu0Yzjg5cs9eo6TxO8dn9Ooit6UU4J2rdrFWllblcOod9VbHYZaQTP
	U2C107Wq4p92THLWjsCtp9K4H/CpSa6Mv/i1Bn3wda+zVNFG0w4oGinZuCM5QPQZTBt/sKGaLnF
	SmNmtzFFw+0c9e8ebpwFHDs0y+A==
X-Google-Smtp-Source: AGHT+IFS3ZqWqRBxf0vPSVpHvFZXtED8grVd+o9iAfWH2hAvI+SxYk5qkATuac73mrVjriQtp3b2n2gBO3/IqUm3lfE=
X-Received: by 2002:ac2:4950:0:b0:515:d176:dfd1 with SMTP id
 o16-20020ac24950000000b00515d176dfd1mr2477343lfi.56.1712245030150; Thu, 04
 Apr 2024 08:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401185451.6897208962d3fc47a12ffb5a@otheo.eu>
 <20240401185712.a80deeb2fddeded0ad42cc04@otheo.eu> <8ee463af-fdbf-4514-bb6e-bf2fd61fbc06@intel.com>
 <20240402192314.a9b4e05637444314f47557e4@otheo.eu> <d7e89d23-b692-4e70-baae-5df5b3984620@intel.com>
 <Zg0L/OfuQtVgFSsG@gmail.com> <CAMzpN2iK0+okEKnX_EgfmdLSg9Gze_BVO4fEG3TBuzwD-yj8bA@mail.gmail.com>
 <Zg5dRkSncIeHsP0H@gmail.com>
In-Reply-To: <Zg5dRkSncIeHsP0H@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 4 Apr 2024 11:36:58 -0400
Message-ID: <CAMzpN2hcZNewSmHn77Y-WAZjR-Pir=31dkgRHOzP+=kEa8_LdQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/mm/pae: Align up pteval_t, pmdval_t and pudval_t
 to avoid split locks
To: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Javier Pello <devel@otheo.eu>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 3:56=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > > > It's not a technical reason.  It's a practical one: I don't want
> > > > to spend time reviewing the fixes and dealing with the fallout
> > > > and regressions that the fixes might cause.
> > >
> > > Yeah, so it's an indirect technical argument: fixes *with
> > > tradeoffs* like this one have a future maintenance & robustness
> > > cost. Fixes without tradeoffs are fine of course.
> >
> > What tradeoffs are there with this patch?  This would not affect the
> > page tables, since those are already properly aligned.  Forcing
> > alignment of stack variables is only a problem if it tickles a
> > compiler bug.
>
> It creates extra constraints on stack layout that wasn't there before,
> so it can only be an invariant if the compiler can reorder variables,
> or make the stack layout worse (introducing more holes).

For the record, stack alignments are not rare.

objdump -dr vmlinux | grep "and.*,%.sp$" | wc -l

64-bit defconfig: 646
32-bit defconfig: 449


Brian Gerst

