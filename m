Return-Path: <linux-kernel+bounces-50130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8789C8474A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1DBDB27BC7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9261482F4;
	Fri,  2 Feb 2024 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDPgpbrP"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591E1474BF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891080; cv=none; b=JkAXiDvXzWtE7y3Kw6eYQQRNZyhif/ZO5krt6PXke+gmPRkrdGEH/FuUi8uS8/+t68AwyhpIB3c2po9USKwlafR9h/+WMrR+dHlr2geSYdjn51DD6I0qk2gOm5cFT6k2dDyIstscR35FrOo7W+3d0Y2waYhdxatNEN5WBakfyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891080; c=relaxed/simple;
	bh=OWKrqSZ7x1a/wVUnOc2GqZECW2DrOBKub+iqKARk7Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrbDaSCElHNFR6r68wzek0VDqmazbs/njX2EkanFT7QGcEzeXfaV2c3K+KcJGPokCkn8LAbXl5d36ouo175qjmbGhkPz+Jq6MwiQyRorQ9LaEG9B1LhYoACRju2gaFRb6G56cIRF8OfbknQVryvaGSKlY0y/WK62h9wfJL4O/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YDPgpbrP; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf42ca9bb2so25004371fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706891075; x=1707495875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHbpeNpyu3wqI87Qy7h1gmd0YJLbzF1zOL2R+Rngvbk=;
        b=YDPgpbrPHpGBjCHCuZL8588PoKlBR/jCq6Lrqek00cQGIKhpvHAt/2uGqNsTi+67c7
         Wka9GLTXMOOuXBrLxT3VHljsfI6SmtlWCu41MVmUHVO4ulcXz3S53eFRcA9q6PXgZhTM
         sql0jfdM3dH0wlqmle13eUg+yNVAUN61LYUA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891075; x=1707495875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHbpeNpyu3wqI87Qy7h1gmd0YJLbzF1zOL2R+Rngvbk=;
        b=NBTdyQMbOyfIXZ/VYxU7sBOZiLF+/myiHb0bVm6kk/OwHnDyJpsbEz5PVhr/lvxCwh
         6jMGk9Ury+NnjL7bJJCXe/U2kddE0TYEIsKculHR1sNGuPWmOR0zArIlVmq+zkKAv/mR
         +AWj1T/xTsOi0rBEVOjmZAOxEkTrCiA4JwTleXHiXzrSRRP+WGNXqttgkmGC3Ujt3rOz
         tA4gbMzMyUH8NJJUxeed+WSV/F2sfwrTkMgoso2XgmlJBjlFX03BVfZQyBI3TFco5EmL
         bzqOgZCeKqYYyPeabFuG8m2aYMzyKuzJKBsObxq3MIig2w8XrquYOrGJBlRUJsZtObWA
         d/BA==
X-Gm-Message-State: AOJu0YwKUPNKMKrXed5UsidQCmlI8K9VjW2eC0zeWxxnD3/+D3Z5uhLl
	Z4qMYdB1tHh2DHha5fkKMKTs1sMzEmHRHiwbMfIYnvPwUL+IFp8CIscryQtCcsIei8p6yiWDJKt
	pRjQZ
X-Google-Smtp-Source: AGHT+IF9ntwXi4/RvarH+oBb/UCrr7c8wsnWMAY4J5Sv3NNWUafUPdNLgtr8vZ36GPalz5hXPEgHMA==
X-Received: by 2002:ac2:41c4:0:b0:511:1b3b:c45 with SMTP id d4-20020ac241c4000000b005111b3b0c45mr1522431lfi.1.1706891075099;
        Fri, 02 Feb 2024 08:24:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUd+0ACGORKcnM2BtkcCfnqrSDGNf6qv4xfYFjgNlhNkEPbDSh8K0y7kTeDLS5lozelLSgEwEgKRTxxh4N8H/J6z8DdE5m8mn+FNqpW
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id a2-20020a056512200200b00510179dfd8asm342008lfb.293.2024.02.02.08.24.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 08:24:34 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40f00adacfeso49735e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:24:34 -0800 (PST)
X-Received: by 2002:a05:600c:1e1c:b0:40e:f5c6:738a with SMTP id
 ay28-20020a05600c1e1c00b0040ef5c6738amr8421wmb.0.1706891073620; Fri, 02 Feb
 2024 08:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV> <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV> <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV> <20240202040503.GX2087318@ZenIV>
In-Reply-To: <20240202040503.GX2087318@ZenIV>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Feb 2024 08:24:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
Message-ID: <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 1, 2024 at 8:05=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Fri, Feb 02, 2024 at 03:49:25AM +0000, Al Viro wrote:
> > On Thu, Feb 01, 2024 at 07:15:48PM -0800, Doug Anderson wrote:
> > > >
> > > > Well, the next step would be to see which regset it is - if you
> > > > see that kind of allocation, print regset->n, regset->size and
> > > > regset->core_note_type.
> > >
> > > Of course! Here are the big ones:
> > >
> > > [   45.875574] DOUG: Allocating 279584 bytes, n=3D17474, size=3D16,
> > > core_note_type=3D1029
> >
> > 0x405, NT_ARM_SVE
> >         [REGSET_SVE] =3D { /* Scalable Vector Extension */
> >                 .core_note_type =3D NT_ARM_SVE,
> >                 .n =3D DIV_ROUND_UP(SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS=
_SVE),
> >                                   SVE_VQ_BYTES),
> >                 .size =3D SVE_VQ_BYTES,
> >
> > IDGI.  Wasn't SVE up to 32 * 2Kbit, i.e. 8Kbyte max?  Any ARM folks aro=
und?
> > Sure, I understand that it's variable-sized and we want to allocate eno=
ugh
> > for the worst case, but can we really get about 280Kb there?  Context s=
witches
> > would be really unpleasant on such boxen...
>
> FWIW, this apparently intends to be "variable, up to SVE_PT_SIZE(...) byt=
es";
> no idea if SVE_PT_SIZE is the right thing to use here.

+folks from `./scripts/get_maintainer.pl -f arch/arm64/kernel/ptrace.c`

Trying to follow the macros to see where "n" comes from is a maze of
twisty little passages, all alike. Hopefully someone from the ARM
world can help tell if the value of 17474 for n here is correct or if
something is wonky.

