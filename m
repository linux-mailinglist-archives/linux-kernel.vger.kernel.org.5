Return-Path: <linux-kernel+bounces-75705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952CA85EDB6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FE41C22AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09001FB2;
	Thu, 22 Feb 2024 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YjYuG5KS"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BD1869
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560670; cv=none; b=aAjYe/aa1+FLk/1nBUHedMC6zY9wJEa0qeig+yRakn7NRdUAbyiEmbltJHdv/d0l+Sxu9vbuRBo6MwNX6ulDJOo0VOYNTohCtNQGtlJmDOCtW9DhxUzGUCv/SPRshxKdyu0ySs/hN08Se/9YyW/uHhO2VxWgPXxRtTiU10wPA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560670; c=relaxed/simple;
	bh=ITimqW9g4IYnfwAk+fE46BnuZR7ucu6gikeyx4GedN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGeUsrJR5HrvURdqe1t5HOiTZgJhQbLtI89VsHcm+C3Q2HoZCDGQ843yvel4HFnmqX5/r85i0qmCHci/46NgFvRYa69ko+uDMPVyioo8QI5lDpKKc+GnhqA/M6fVWrIn/UC7U9rQEpoUbQg3uOlf73GrC9M3pLwm2LsQHhgJ+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YjYuG5KS; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc74435c428so6821263276.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708560667; x=1709165467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTXFYEa4xo6a5mwd21POLG1HLHGIr1ybDf3KHz8gaHw=;
        b=YjYuG5KSm5u2EanQe7cOHp8PgvnV9sMmurP3kNSXhmbyIq+CiQF9Z50WEQQRLIxX7W
         bQ8lJZWn3w0fmwrUsZMpAsL+Kf+9adf2iniuFdaHaggUF7eMxtYIs+LlWGvIiTnWDWHl
         fC8T/7d1hJwawwSLOeYSof0Bk9zU3JHtj6fOldzbqwGydqhIf6FiRUx5I21csL2IrFkh
         tIDp1C0uGvBuWlatwI2C0nTM6Ohi3VOIsMM49dxSAxZx+HMofBGippNbVLg4XJRh9VD5
         o/3ee/XhMScxWHsynVQwRTuymeHiycqG26qfFT+0149gsTf8OCAyCwNrvSa495/WJYKr
         jodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560667; x=1709165467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTXFYEa4xo6a5mwd21POLG1HLHGIr1ybDf3KHz8gaHw=;
        b=I3JFOZo3G4bvcAzKJX2M+w5KCLydx8XGcMRJ84gOn//maA8lBeS0Ml7F1D6+XDw++4
         RZurgrxrPjE+ImvGtDaG2kTovvizLBterPwVtb0PKT9MQ0PaVAD+SV6niR+bR3CXc2d3
         5PGrcNctiaZI+TvDR/zrCX+DDxE5fQfXV4y+IoZsZL/h3Rhkcvv4+1Lf2ADOthBrplQx
         CfBnHepHkowbaY0sfVBP20DH0AuqRxz39Xhyn5W5img621oY4RSUnyq6+VQALWv4rqu5
         dsqTbQ4rSknmsjvXh3zKHMLUbX+RmefjK+z340jMLVAISQ1pVjO9QNdFoUyjrWgz7XVc
         0u0w==
X-Forwarded-Encrypted: i=1; AJvYcCXlL1u6keTYlNyaaHLtryFLukME6Kqp6fun2cHHRPdftGz9bMB4PFMReEekk1c77oNBoxcKoGpcHYctvA9PtSRHmGFw8FF2GPpY5M6d
X-Gm-Message-State: AOJu0YwJAKOq782ykGHQMaP5lGuJmvnFmmt2ub9BZkWbQEtxDLi+5UZl
	AXtm6lswqslIpyfMe8r0AbZ2EHHXLKECsRM3jWX0SCnH8TzI/iCHKwG+DpbCNyNH1WJ8qmPTKCW
	NJYhPiZ2UmJk11ty4kfDmw3j1nP+rxnUbggN6
X-Google-Smtp-Source: AGHT+IF2DQVDzt2c0yA7a7+ahy3Q+PeWGykVKKQL85450iacajA8akbQF24P4kQxcdmNK7g3f3rkviXmnCjZy4LpHEo=
X-Received: by 2002:a25:6610:0:b0:dcf:288e:21ca with SMTP id
 a16-20020a256610000000b00dcf288e21camr729938ybc.11.1708560667179; Wed, 21 Feb
 2024 16:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130094037.76895-1-chentao@kylinos.cn> <CAHC9VhQG6XAm3R3wtgFrb0b0UHoxkSV2yziVAnUy2x7Ovun_pQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQG6XAm3R3wtgFrb0b0UHoxkSV2yziVAnUy2x7Ovun_pQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Feb 2024 19:10:56 -0500
Message-ID: <CAHC9VhRLNHT0ar2YPkZBsyha_mh6Ggf6=V2gnbFkdo7ryXmHnQ@mail.gmail.com>
Subject: Re: [PATCH] cred: Use KMEM_CACHE instead of kmem_cache_create
To: Kunwu Chan <chentao@kylinos.cn>
Cc: axboe@kernel.dk, elena.reshetova@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Tue, Jan 30, 2024 at 4:40=E2=80=AFAM Kunwu Chan <chentao@kylinos.cn> w=
rote:
> >
> > commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> > introduces a new macro.
> > Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> > to simplify the creation of SLAB caches.
> >
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > ---
> >  kernel/cred.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> This seems reasonable to me, unless I see any objections I can pull
> this via the LSM tree next week.

Actually, never mind, the original posting has some non-ASCII junk in
the patch and I'm not able to import it cleanly.

--=20
paul-moore.com

