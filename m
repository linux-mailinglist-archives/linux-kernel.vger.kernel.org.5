Return-Path: <linux-kernel+bounces-54815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9674584B405
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3BD2874E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF13131E2F;
	Tue,  6 Feb 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j2h3juMt"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D1131734
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219313; cv=none; b=gqhzMBDOF7nKMs946nIwbcQe+tF2YiBY+Eh4+G1MPPGmG9iDUXELzw82puzIxcma4YzYpJACcpZ99Ly/LERy9XSxBHtY1ce3CacGqxQvJb2nUiNDQ/Mc9HklHie1nt1lQcDm2fzgChHhmzvTst6r6MZLCcYFZeX6a8Y/mVhdRM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219313; c=relaxed/simple;
	bh=lMuVwqT6Yqxx65gjRWAsF+EhieMFDPtXh3GlqRjPYKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ctg/Zr/crAW0JmwipKIXlHwWZO9EcXomamksKYVlCrTh60heagZFqY4GjnFMNzArnrudc2r9CAMUjGc3Hlq++L0yNJvpcsIWQINjULkyBShhgEWCQTFDCVyl5X8XfnxolpSxEkCXCSef53+sgwUR27Ng9mK758N9DHE3SUz4qSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=j2h3juMt; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60406f4e1d0so48321747b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1707219310; x=1707824110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipIFPiuOZlL03JscPcnqfUuXdCqKvtPZ/moGeh3312s=;
        b=j2h3juMtbfaN4OcIC4NdUaksHDKjKc/FjNqyJn1K5ppCDX+tjixVO8y+kuq4LVMvmu
         SQ5IJLP03itlEPuKIhS4k2ZUsg6CKt1H3XuiRbJyLyG9X2n5RA/bTB7aV6yLDez24ZFN
         J404lG1Zwlon5I+XgAnEmRCLM26wB2gu7Gpv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707219310; x=1707824110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipIFPiuOZlL03JscPcnqfUuXdCqKvtPZ/moGeh3312s=;
        b=k5fNqnWnDHDQguIzCFTZnLXJ/diYUmEXhKkWf0BugGpA67o85goTuUETc2qZ0+F51h
         GfSQqAn2txP+LrJvy2clg2BCPdXY2uOdvQ/2VLqA+SMEpUMuXphwH3zQ5dSUFHdaiO/q
         s52L+KiRmltdPgVgKryJTiIC0bgD2tsa+FZp5VcfADXXMJhYhgcDFuADAy0Ryh/FhNzE
         +qdKkTknf89Kmk1Mnl40+wXN6XGXHKoJJQzMFzvYkofLsCOOCTClxcn0le3lRj3cibfz
         aJrN4JzYWnRuZrcXrGniB8wxk69fT+XVfbuVnEbnIZSBg3x8FqQzEkXyikK8CnvyIM5Y
         dDzA==
X-Gm-Message-State: AOJu0YzLdONgJ3DEOSJKDG3Ga1ZlluTmqyDx3rzOnmjcZBKna0M75mXZ
	wsleVu+Jzt6cn42TePDdijU4PrVDh8QZ88nLuyiSFpyhva+YeE1M2V3Juz2damYMSV9/wdWBsrv
	jsb3oTY5Kq6rpCpGl6AmyGBq/qOpqiZlS+Nu6TQ==
X-Google-Smtp-Source: AGHT+IFs9N+MMWXICUW8m7zjdBDfxfxKrJHf8SDeiP+oYRkgDorOT5XmQOl5gAjCH+qk4NmEovj7aTrJBhpDMGxfG60=
X-Received: by 2002:a25:824f:0:b0:dbd:b081:9663 with SMTP id
 d15-20020a25824f000000b00dbdb0819663mr1120369ybn.41.1707219310352; Tue, 06
 Feb 2024 03:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206115956.4570e9b1@canb.auug.org.au> <20240206120643.1d30764c@canb.auug.org.au>
 <fe0b21360178348543e662e9d620af9c@kernel.org>
In-Reply-To: <fe0b21360178348543e662e9d620af9c@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 6 Feb 2024 12:34:59 +0100
Message-ID: <CABGWkvpuukHq_qcdjAyczaSxVyG_dUda0SATuS9VoSzmQgdjPA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm-misc tree with Linus' tree
To: Michael Walle <mwalle@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>, 
	Inki Dae <inki.dae@samsung.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Michael Trimarchi <michael@amarulasolutions.com>, Robert Foss <rfoss@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, Feb 6, 2024 at 12:29=E2=80=AFPM Michael Walle <mwalle@kernel.org> w=
rote:
>
> Hi Stephen and all,
>
> >> Today's linux-next merge of the drm-misc tree got a conflict in:
> >>
> >>   drivers/gpu/drm/bridge/samsung-dsim.c
> >>
> >> between commit:
> >>
> >>   ff3d5d04db07 ("drm: bridge: samsung-dsim: Don't use
> >> FORCE_STOP_STATE")
> >>
> >> from Linus' tree and commit:
> >>
> >>   b2fe2292624a ("drm: bridge: samsung-dsim: enter display mode in the
> >> enable() callback")
> >>
> >> from the drm-misc tree.
> >>
> >> I fixed it up (see below, please check) and can carry the fix as
> >> necessary. This is now fixed as far as linux-next is concerned, but
> >> any
> >> non trivial conflicts should be mentioned to your upstream maintainer
> >> when your tree is submitted for merging.  You may also want to
> >> consider
> >> cooperating with the maintainer of the conflicting tree to minimise
> >> any
> >> particularly complex conflicts.
> >
> > I changed my mind and just used the latter version of this file.
>
> Bug wise, this is the wrong solution. Because it will reintroduce the
> faulty FORCE_STOP_STATE. Also keep in mind, my fixes commit is/was
> already
> backported to the stable series.
>
> See also the discussion at [1]. Unfortunately, there was no conculusion
> yet.
> I think [2] is the proper resolution, at least for the commit
> b2fe2292624a
> ("drm: bridge: samsung-dsim: enter display mode in the enable()
> callback")
> I'm not sure in what state the drm-misc tree is.
>
> -michael
>
> [1]
> https://lore.kernel.org/dri-devel/CAPM=3D9tytMB9frxNeD08hu1qsusY=3DwEE3bJ=
OFmUgA1rSpabwDpg@mail.gmail.com/
> [2]
> https://lore.kernel.org/dri-devel/31e1a38a1d012a32d6f7bc8372b6360e@kernel=
org/


Unfortunately, in this recent period, I have been very busy and have
not been able to run tests on this matter.
As soon as I am able to do so, I will.

Thanks and regards,
Dario

--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

