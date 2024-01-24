Return-Path: <linux-kernel+bounces-37422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD4583B048
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2A6B2FBED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724BF12837A;
	Wed, 24 Jan 2024 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzL4GAS9"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8181AC8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117063; cv=none; b=WChaye3PubXlIWLoyS+PZK4fQEIHxF/zWTmGlk9whCTI9IEC45Visd2hOQDYJfspsy6+SeFmALU6fV0tL0iyJKPiSDUByVb8vftqyUVYuHE/VnBKl2720FvQgWfUSSm3FmOaqN9GnRWjr7Niw5pjDDZKG1396nqElFPWaC5IjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117063; c=relaxed/simple;
	bh=VSd/JJH1i3yh+OWX89PdOSwPlQ9HzM3SPMv/6AxAT9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hud0v2JEK2cGn4thZe9FTJkY2qFzZkcYNk7kO2Pz8NtP/1VcEWo9nQX4BJgpH7P+GlYNrroGQxxiGLachae/DhpRPQEJAcI3pxFn8TAqkzxuf8dAB29i1SBCqMrCg5hU+tZn2EAeex+qBW9tgcDsWOFlIhrv4ueavfdptz+FyxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gzL4GAS9; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-683cabd9763so34476046d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706117061; x=1706721861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSxEs95VFilTX9ZMn4g3/pmadRUIIAuhSiude60Z10U=;
        b=gzL4GAS9Ith+xEiYE0K4E7S8gErUc0w3cph6BHS4m5LX5tFZxEnBlzYxO9ux1mzoYH
         OEhXjeCK8Sgp8j5g79pB4Nof3rlRm3EscDsyYhl/8iy2lcAxU3kPzfUyXfT4MPZWx1He
         j0pLuehyAPcP8TmVdnBE6sGDaclfzPsC7tfO7yvIalS4sBrtQGvTzEUsMeEAMhvtBdFl
         3eecEnLRq5VB5OlnrCmnYA0viiKGwEoGDwvZWmw1pjmvELv0lC+gfSv56o08IV7JAO9Z
         1CsqqmeHi7yh910yNfWEhGjN2igQXD7OAFCQIXe9ps5asa2TGhPCf2H4BBb0ByPQPVMi
         S5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117061; x=1706721861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSxEs95VFilTX9ZMn4g3/pmadRUIIAuhSiude60Z10U=;
        b=Q+Pucjw4fMntom2hUf/OF0o3ydZvWqh6KJsAS6JAAk70lcoot423+4MHLN+pPkyvtU
         EZg17HO/oBs9iWd9fDvkrazzwjY1AnPyr8gCGFZI8VcCaGqTIr6AomLdf3LaIWAj9mEr
         TEDMDX7UB9B3TDA7aXrrXCXN4GZ5CZH7L2YWRXzONJ7xxiXPTwbgjiWcbH0FoK640T6V
         7ThUYBuhJ406dCKsT+V/0ZbTh8ujxkboJ9ztEGAY9D6sPR843C8pu7zRPTx/pRhkeQKo
         GyjDepVIVLm/l/ikSaVZK752LLa2yrxqCQD6WGdlB+mBa3b1aKdikfeHN5W9HOI/hrjz
         TGOQ==
X-Gm-Message-State: AOJu0YwczqZGrtyNi6xGWzarV5CjUCpG1bebJ6cqbAwhWV6OfPHA62k+
	aBbSbgWF/RIFmfl6n++kXa8uYkGHJ3LwzUwmnepGmKSO8bbq4zbRT91AIpxuz4hk6w8qz1llQEi
	rMjPKVvn8cCbJP5Wm5rUXc1P4gyvH+DfGE7dz
X-Google-Smtp-Source: AGHT+IGs4EAnLTqOrRz2UwlDg86+/nnU0Jr0Lj71LPz8P67AViTwza3MbkbNm73GbgmjRdC92VlVcmx1Xz9qVLmuwJQ=
X-Received: by 2002:ad4:5dc8:0:b0:685:55d:18b5 with SMTP id
 m8-20020ad45dc8000000b00685055d18b5mr3888783qvh.84.1706117061161; Wed, 24 Jan
 2024 09:24:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124164211.1141742-1-glider@google.com> <CANpmjNP-9hV_d3zEHhUSpdUYpM1BAFKmTTzWwe5o5ubtwTvQAQ@mail.gmail.com>
In-Reply-To: <CANpmjNP-9hV_d3zEHhUSpdUYpM1BAFKmTTzWwe5o5ubtwTvQAQ@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 24 Jan 2024 18:23:39 +0100
Message-ID: <CAG_fn=Uy_h6YnQYdncewoUeOd4TutsRVygbHK5-qwn+zQYCvPA@mail.gmail.com>
Subject: Re: [PATCH] mm: kmsan: remove runtime checks from kmsan_unpoison_memory()
To: Marco Elver <elver@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Nicholas Miehlbradt <nicholas@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 6:15=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Wed, 24 Jan 2024 at 17:42, 'Alexander Potapenko' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Similarly to what's been done in commit ff444efbbb9be ("kmsan: allow
> > using __msan_instrument_asm_store() inside runtime"), it should be safe
> > to call kmsan_unpoison_memory() from within the runtime, as it does not
> > allocate memory or take locks. Remove the redundant runtime checks.
> >
> > This should fix false positives seen with CONFIG_DEBUG_LIST=3Dy when
> > the non-instrumented lib/stackdepot.c failed to unpoison the memory
> > chunks later checked by the instrumented lib/list_debug.c
> >
> > Also replace the implementation of kmsan_unpoison_entry_regs() with
> > a call to kmsan_unpoison_memory().
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > Cc: Nicholas Miehlbradt <nicholas@linux.ibm.com>
>
> Tested-by: Marco Elver <elver@google.com>
>

> missing ')', probably:
>
> +       kmsan_unpoison_memory((void *)regs, sizeof(*regs));

My bad - you are right. Thanks for catching!

