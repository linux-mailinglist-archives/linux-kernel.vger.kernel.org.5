Return-Path: <linux-kernel+bounces-132078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB5898F65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734EB287410
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0A913667D;
	Thu,  4 Apr 2024 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/N8hd30"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED588135A4B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261264; cv=none; b=MX1k+coBhYwvGrK2KptSJpqQXWPwmSTVGG/frFPiadEfTt9yZTuvlMQLuMmZZO6xSIdJsy1Rpoo3UyhhM8lDnylibns+dh7Z6jqpEEoLzoeykCjZ+/WgARppKme0ebLZfp9qi8f+zs2MiyWvZFj+kU6TwOSM+t2hCkHVOnUJxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261264; c=relaxed/simple;
	bh=GsI2IqBH7fIn1lQq7F4Uqzg6XlJeIu1rVzb2YHseZkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggXY3lilyxO7qzsEZlyhATOZ2wryM+4oOch6WJDe/9Fe6rYXfr8YxLyT3YvOx7kOEDWQa+FEn1nx6oY5s+AIrBNGUnXTNfs9UFDk+rqGv8UkgafO8j5qm1hem2C1F1PB97zUZiO1/hWfk/poH1adgdMNQpNqW/8b1wU3qK5+vqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v/N8hd30; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso835861f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712261261; x=1712866061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJQZX14pNqacP6yH0MMA3xSLOt1OyaaMR7UOhFYBuH0=;
        b=v/N8hd30l3bcSWR8MV9hhQEky3SiQhXg4mYY32qLmeZs7jFj9xtA5UT2ny+Kr6cdbs
         qG+23KBWae4IACc7nwcYZYUwBs+WDCEF6jFwhimYU7O7XOL74KkGBYlfQs0ilFg3pscn
         rD2bcY09NXZFAzhIkJf3RsU5M5VKz4nXjb1it+b7IVoZDLpy1s32bzGAke9M/ELXSMfx
         oSczmTivkzrhFAYbZ9ZY/Wo78dUxz9XRfU8r8um5IpHof8g5EPT0xpm0eF802qAlNwsy
         q+9zX1MEOgRYhKZlKIxLL8FiDkxaWCg+lR0YnbFJqHoHkUqBFke/jr7h1qJq+OrAY1Cl
         dq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261261; x=1712866061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJQZX14pNqacP6yH0MMA3xSLOt1OyaaMR7UOhFYBuH0=;
        b=uDWZKIdJeTr0FcU1UoQNPD0x0x2LSy16Bk65Ad0GYhdIjTqyZxFKgk79ShlEZavCXU
         B+PctdDg5kq7OlTuEYArNdlk630MjvTYV9ze7bqLmHRQG5XDvTbJbdnVNcfzzqBclbJX
         r2r3E6Lqzg5ve0UEpRrot4CVQkfCscK+h15Z37xrwAnDmAw9G2FKCDL5Z+y87Fzp5YQN
         8uV/eeqCwtA5NOTvjMjI9CYsh0caOEmjMs+TGOwmnqV/xRsAeRxao46HwH1miVEgrKT2
         gJuwVUvi8n1jVmf0WD2JdKwNqD2shRFmdaLdQHvXxW80xqPOHv1NN83D9M1HivyZamY8
         MX9A==
X-Forwarded-Encrypted: i=1; AJvYcCXdCHXBoUojnIarZbEx0rRXrMDcGhad8e+26UEME74IzepIeSNoMG9/ejrsnVGaZZo73E/lz4MaN9cIez1OiQ76Tnru0/jvqRNUJT/j
X-Gm-Message-State: AOJu0YxxO6s7XPSqwhKcf04E+frYZTsxkfFqfvCWfBCvSo/ONO4/ER5g
	+VlB7gxsxzkOy41l79ZFp2GLYfNGtFYhvkqBbB5/iEwgwCpQe9GvYBnClSYUWIkr7sB55tDYPx5
	F3RSdAotoWnucuwA+ma+ATw+3Rh2tvCglGNfW
X-Google-Smtp-Source: AGHT+IG+NwR0yeRIg5TBfS13eCeoTZD+OX41KhT6eVRLyMQyIDTsA4/UkFRdut2sjqIWAEzK/d6wK5JyA8vCEa0zo9k=
X-Received: by 2002:adf:f44c:0:b0:343:70bc:4578 with SMTP id
 f12-20020adff44c000000b0034370bc4578mr387872wrp.70.1712261260979; Thu, 04 Apr
 2024 13:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404171726.2302435-1-lokeshgidra@google.com> <Zg7hrt5HudXLBUn_@casper.infradead.org>
In-Reply-To: <Zg7hrt5HudXLBUn_@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Apr 2024 13:07:25 -0700
Message-ID: <CAJuCfpHvb5Jt6J1P9aHVdRWYUHmBL1edfp7QHn=jF88gJRD7RA@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
To: Matthew Wilcox <willy@infradead.org>
Cc: Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, aarcange@redhat.com, 
	peterx@redhat.com, david@redhat.com, zhengqi.arch@bytedance.com, 
	kaleshsingh@google.com, ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 10:21=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Apr 04, 2024 at 10:17:26AM -0700, Lokesh Gidra wrote:
> > -             folio_move_anon_rmap(src_folio, dst_vma);
> > -             WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, d=
st_addr));
> > -
> >               src_pmdval =3D pmdp_huge_clear_flush(src_vma, src_addr, s=
rc_pmd);
> >               /* Folio got pinned from under us. Put it back and fail t=
he move. */
> >               if (folio_maybe_dma_pinned(src_folio)) {
> > @@ -2270,6 +2267,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd, pm
> >                       goto unlock_ptls;
> >               }
> >
> > +             folio_move_anon_rmap(src_folio, dst_vma);
> > +             WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, d=
st_addr));
> > +
>
> This use of WRITE_ONCE scares me.  We hold the folio locked.  Why do
> we need to use WRITE_ONCE?  Who's looking at folio->index without
> holding the folio lock?

Indeed that seems to be unnecessary here. Both here and in
move_present_pte() we are holding folio lock while moving the page. I
must have just blindly copied that from Andrea's original patch [1].

https://gitlab.com/aarcange/aa/-/commit/2aec7aea56b10438a3881a20a411aa4b1fc=
19e92

