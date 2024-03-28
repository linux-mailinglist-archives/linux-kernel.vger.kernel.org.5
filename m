Return-Path: <linux-kernel+bounces-123157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9889032D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567051C27AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBAC12FB27;
	Thu, 28 Mar 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DsewIpLf"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121E61EEFC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640209; cv=none; b=aFrNbVmbnS3bU0xfIoiKc7Yfrzybi8RicBci2PyH380pex27E4d64ijvSMUg9fp9DM08l7JncukXVdtLqiTb1yU0i/TsEVKzOpRSkfxD4F3Rx5EYwilPVe/YIf8cWMciaqG/NCHZKVfTQiXkekqXClwow+sgaDdrZPlXFncunTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640209; c=relaxed/simple;
	bh=jNozf9uaUn62BQc5Mx2KoSKHOm3OswtOuVbxNmfLA24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnrKFxH0K6jqYcutbQCnG9kZU9R6StghEyuDtEyZ3dxybiQKO7W1uRFIKAaYmINaVmegC5/vrExAlpFPGv27cO5XSqDLMoOi54CBJgwmtMtp2gVwHe2c+4CNUinjnKaFnQxOqCfhUMGqB7JXhLN8a4kV/YSkOYaixz0Oghv1+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DsewIpLf; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a66ba49dcso69476585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711640205; x=1712245005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNozf9uaUn62BQc5Mx2KoSKHOm3OswtOuVbxNmfLA24=;
        b=DsewIpLfp6Az2N9LqNhRIYkXLHot1Du0xOXIF96RyarWm1+VcG96BT6yNiGLtWov8m
         OqhU9vcTKO+P+WHCcpPKLc4kzeIVKR2U9uLfjHj3naDnlt1uk083cIwcZhPbE0H8/PW3
         3tKYuL9HClXc2IIx0GqWMyo3tKwZW2uNFlsRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711640205; x=1712245005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNozf9uaUn62BQc5Mx2KoSKHOm3OswtOuVbxNmfLA24=;
        b=TKMO8evPFa+Zweti56Vf6msICtF/TGDU+GnBsMFizW9rzb5XcFVGTOch3pzqqVi3OO
         EaGwo8DDRfW49LQzsvCJEdqtkiKsN+0I7Fgr72z0tQaeovciUHPwF3Y8C2bXZHIFV7lk
         88x7yPYM4gYlIehWxp9v7QG1x1rDy2dSpo6RlmPneThM5Oz7jgPOVAIw/SiRcxthFFq9
         ZET1jdbeqLbLBrS5mGxRcPe/qSPTZZLkVjlXfLQwaHJqZGKmh8bMPeukQZjRQMLSDkg8
         BnXEUZtVJRO7ZrzdnTvdipPg0atmZtNJdIqC5hRVZuTiak0ow/C2DDWxERaAsXzO7ljp
         eDDA==
X-Forwarded-Encrypted: i=1; AJvYcCW3zDfT6Xxy6RnMMUMEJnwuSTYA4K6tT7mp6wlLbIG9GyQYhivhkfh1eLuR7+cVt48rwEgeHO2kIgeYBKHg80ALyJ6/k9lJWXNCMlwr
X-Gm-Message-State: AOJu0Yw2nnDKHfMcdGURJJ8gsKDN/a6IoQlGcrfzgtZrfZ95G4IqwFzQ
	xtykWBKEtbMrOWMg3E5PzQPkX5dURgEn3qsmIpvDpIXIp3GykvPaWvn3b/nwKQueBAJjnjjkUnI
	=
X-Google-Smtp-Source: AGHT+IEYXWoUrUQIx22afAtX7pwUI5/Xqd+hSYpql+9ctujC431spA5yy6rneH/GjMA6iI39eOb/CQ==
X-Received: by 2002:ad4:559a:0:b0:697:2ec8:55a7 with SMTP id f26-20020ad4559a000000b006972ec855a7mr2845151qvx.65.1711640204861;
        Thu, 28 Mar 2024 08:36:44 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id 11-20020ad45b8b000000b0069895b7df25sm337612qvp.84.2024.03.28.08.36.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 08:36:43 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-428405a0205so381661cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:36:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVR2zNs0xyl+Px3XsKfW5KHp64iEz3elrI28CzlqAWANXkfx4cAbZzNhVqfbVfuCbjnewQGN+NTbKJuPOeKwGzRhV0INRPV0blpgoqS
X-Received: by 2002:a05:622a:5a0d:b0:431:74f8:8ae6 with SMTP id
 fy13-20020a05622a5a0d00b0043174f88ae6mr287854qtb.19.1711640203361; Thu, 28
 Mar 2024 08:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <CAD=FV=WgGuJLBWmXBOU5oHMvWP2M1cSMS201K8HpyXSYiBPJXQ@mail.gmail.com>
 <CAD=FV=U82H41q3sKxZK_i1ffaQuqwFo98MLiPhSo=mY8SWLJcA@mail.gmail.com> <ZgWNtmcyZOMZR1Fi@arm.com>
In-Reply-To: <ZgWNtmcyZOMZR1Fi@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 28 Mar 2024 08:36:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WaiQSbCnKz8t9VFt74vVXhOCX+L=abFn-QOV9OeQx5Aw@mail.gmail.com>
Message-ID: <CAD=FV=WaiQSbCnKz8t9VFt74vVXhOCX+L=abFn-QOV9OeQx5Aw@mail.gmail.com>
Subject: Re: [PATCH v2] regset: use kvzalloc() for regset_get_alloc()
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, 
	Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, Matthew Wilcox <willy@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 28, 2024 at 8:33=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> > I'm not trying to be a pest here, so if this is on someone's todo list
> > and they'll get to it eventually then feel free to tell me to go away
> > and I'll snooze this for another few months. I just want to make sure
> > it's not forgotten.
> >
> > I've been assuming that someone like Al Viro or Christian Brauner
> > would land this patch eventually and I know Al responded rather
> > quickly to my v1 [2]. I think all of Al's issues were resolved by Mark
> > Brown's patch [1] (which has landed in the arm64 tree) and my updating
> > of the patch description in v2. I see that Al and Christian are
> > flagged as maintainers of "fs/binfmt_elf.c" which is one of the two
> > files I'm touching, so that's mostly why I was assuming they would
> > land it.
> >
> > ...but I realize that perhaps my assumptions are wrong and this needs
> > to go through a different maintainer. In this case (if I'm reading it
> > correctly) Al and Christian are listed because the file is under "fs"
> > even though this isn't _really_ much of a filesystem-related patch.
> > Perhaps this needs to go through something like Andrew Morton's tree
> > since he often picks up patches that have nowhere else to land? If
> > someone else has suggestions, I'm all ears. I'm also happy to repost
> > this patch in case it helps with a maintainer applying it.
>
> FWIW, for this patch:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

> Yeah, normally Al or Christian would take it but with their ack we can
> also take it through the arm64 tree (or Andrew can pick it up through
> the mm tree).

OK, let's see what folks say.


> With Mark's fix, I assume this is no longer urgent, cc stable material,
> but rather something nice in the future to reduce the risk of allocation
> failure on this path.

It's not quite as urgent as before Mark's fix, which gets rid of the
order 7 allocation. ...but an unnecessary order 5 allocation is still
nothing to sneeze at. I'd let others make the decision about whether
to CC stable, but I'll at least advocate backporting it to all the
kernel trees I'm directly involved in.

-Doug

