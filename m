Return-Path: <linux-kernel+bounces-73156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B3C85BE43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227FCB25891
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306066BB36;
	Tue, 20 Feb 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry3Zr4Ap"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF76A8B7;
	Tue, 20 Feb 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438191; cv=none; b=bliZazsGZ7wM//FslOPH6kFVdtm2DaflvGWY9ezABz1ALTwbVCmjY0fGFMdzSg7EUE2zPbRrBZi2s8gbDhGyaBCh3pqxyS5ZJfMR3ZBBFgFDx0+o8RTbX2vT6y//dsCj+8VjIOlWj9iX/5R4ONXlXg17l9WXc8FVd0Qa+zFYfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438191; c=relaxed/simple;
	bh=UZr5OabjzFWqGwIW7vStjE8DV5p1pvPSmY1ncmhIDTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq0qnfNM4cxqJ+dlWFjz+VHirKswLfcPHghaJL3hiY+vMiD7hsOfz4HPgcRXQL6R9LAYzUWapNWoKrZyP4Dkga6GK/4X6jyq+4fyhQIT0LnVmuaAu6o+ZkEuZPENQbe7ZwH5OrPsLpi+uQMOpvIJRZMxwedb8qp1HqKXouNMeiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ry3Zr4Ap; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d23d301452so25489291fa.1;
        Tue, 20 Feb 2024 06:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708438187; x=1709042987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5ygzhg0Sp16WJIhUiXNrHEdpZ3tx3asQbWo9oNNCcI=;
        b=Ry3Zr4ApBaRKfQGBz8hP/yEg2SQ0n3+1vUNszruT65mpoZfM5ajyrMnTp4nIPWPiEK
         +uPKSU7yPGP+onLwd6R6F+FmblVtt4Sb3AGeABaMiW1fpf/1xbcNcDyEpEU+QnInjZ7Q
         STRwT/GfquxGth8rduF8bPkH8FzKYxrMefLzk/8B7/tq7fgRjWNQSp1fKTO9JLTHRWcc
         KBYlxyrkAASfzVRqcJvDQJbWSwjNOeNNTr6oHvAaFZv7dpdd3j0ibUua3DJ9/YNBJZBA
         Ox9+8ujNdYysWZ+kTC7tDRUOpp+Enp78rCzMbOOJLq9lJ7XzcCIH/6MNslWaMdWqQFAW
         pfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438187; x=1709042987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5ygzhg0Sp16WJIhUiXNrHEdpZ3tx3asQbWo9oNNCcI=;
        b=hTbNjvqXZc/J79SwXw6svF7eWPxEpKens/0NXIj0gME62BoDfpyMmwuuqzDJgh3SOw
         offbcWF3vNnkze6Yy8Ix3/H7ipAU68kdRNEPIXGp4HpZ80lPVSlM1Cap7rgg4BSYJuLu
         x0bsqv0vkX/g8eVoP8ecTeUhi3czaIBf6gK0y9tQFJ+NdY3l+pFLx7Q30RVH6IehsGZF
         TWpq6KeF38J2/pnFpT4EYgVVY8uoyiKaGBF0y7xOXnK3wF3s6zY/sptREGD7Sr9EdvwV
         FJ1iIaUTRwQIChiDnxCcXtHuEoM93Ar1V7Y+7f9nMc/1YI52gIgzLZZkk8uvMwX17sbo
         pBYw==
X-Forwarded-Encrypted: i=1; AJvYcCV8870AU7toJCo+MS3kevHTreY25e2uEbieQOWyhdcDJ/qlrsPxhUUD2hbnkCSaQ5DiucQ+jbjkdr5b39aK4RL6dWH2uUi018F3kPWg7TpfYd6u3azJjAGUuXeCM4UtHhrAUqBuchu0qjo=
X-Gm-Message-State: AOJu0YzKAiWx8EnSjO9jsLqgAto7IwKmEMjDjhtC1N+tx1xaHukV3CkQ
	eMKlqbq83pHdmJjWBeUDyyP9D6vXC+ggNWTbv52FzgzLfKTowXD3W7yRnzZZn+sXZ+qPFRisaNI
	dweO/96HQWAtJUnjFLOrTQwZgTCeG0DIOxq8kCA==
X-Google-Smtp-Source: AGHT+IEJNfoUUiWQ+3bprvylADBP1/jWjR+Wzkz/4OBZl7mhVSDLu56YSan4b9juc2tTL65lxLIu/LJM13ARjFgq/p0=
X-Received: by 2002:a05:651c:545:b0:2d2:25bf:d80a with SMTP id
 q5-20020a05651c054500b002d225bfd80amr7687442ljp.5.1708438187387; Tue, 20 Feb
 2024 06:09:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208144224.438146-1-r.smirnov@omp.ru> <5abcb44deb604258aff4cd02c3ca90a3@omp.ru>
In-Reply-To: <5abcb44deb604258aff4cd02c3ca90a3@omp.ru>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 20 Feb 2024 23:09:30 +0900
Message-ID: <CAKFNMomWkZeK+CzX6R0S+9UB0tCN2WBd9A0iiUcqJcji+LFsvg@mail.gmail.com>
Subject: Re: [PATCH 5.10/5.15/6.1 0/1] nilfs2: fix WARNING in nilfs_dat_prepare_end()
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Smirnov <r.smirnov@omp.ru>, 
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Karina Yankevich <k.yankevich@omp.ru>, Andrey Rusalin <a.rusalin@omp.ru>, Sergey Yudin <s.yudin@omp.ru>, 
	Valentin Perevozchikov <v.perevozchikov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:44=E2=80=AFPM Roman Smirnov wrote:
>
> On Thu, 8 Feb 2024 17:42:41 +0300, Roman Smirnov wrote:
> > Syzkaller reports WARNING in nilfs_dat_prepare_end() in 5.10, 5.15 and =
6.1
> > stable releases. The problem has been fixed in upstream:
> > https://syzkaller.appspot.com/bug?extid=3D5d5d25f90f195a3cfcb4
> >
> > The problem can also be fixed in versions 5.10, 5.15 and 6.1 by the
> > following patch.
> >
> > Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> >
> > Link: https://syzkaller.appspot.com/bug?extid=3D325e6b0a1e7cf9035cc0
> > Link: https://syzkaller.appspot.com/bug?extid=3Dbebf30d67ea2569f0fd3
> >
> > Ryusuke Konishi (1):
> >  nilfs2: replace WARN_ONs for invalid DAT metadata block requests
> >
> >  fs/nilfs2/dat.c | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
>
> Sorry to bother you, do you have any comments on the patch?

Hi Greg,

As a side note, this commit handles certain metadata corruptions
better if they are detected, rather than just killing WARN_ONs, and
prevents an internal error code (ENOENT) from propagating
inappropriately to userland.

So, in retrospect, I think it was worth backporting to stable trees.

I have checked the source code of each of the target stable trees, and
they are safe to apply.

Thanks,
Ryusuke Konishi

