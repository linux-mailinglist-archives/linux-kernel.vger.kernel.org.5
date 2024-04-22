Return-Path: <linux-kernel+bounces-153993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7B8AD5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5454D281667
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B341155723;
	Mon, 22 Apr 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="0+lxSkgM"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7315380B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817161; cv=none; b=bYYA1o1kX8vIAnXGiESV7lj5QcA0o11YcgYz9gKc7iU+OrTyMsM5IAJXmGu3bBBR9mvDZT6/3S/jqGDIxXpfJ3SlryDrR68TnJoopOg9M+GgL2HWmw5nTx4fShLFqk/K5VRvj+1UHtRTr1+qwtdfG9BQG+tUO/pVBPGU3I/HHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817161; c=relaxed/simple;
	bh=zNWuH8R4KlmVwCmfi87OiHprzOdNZb+4awWRJihIuP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hhv8h1HS3fpsWcude2Zqvu24dQeQbdNNit5nlqhPWC0zxSKQBCbjr6lpGg4NoXN7OZxquXV4NDJe9g57/LWNCP3Lm2ariNRM+Ied3rdlNwKNtPhK7xf+OAeB48FWkE58y4AuALXqg+J+KVY+ZQ2+1Yq9rmh5JpfY4RkuLTN4RLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+lxSkgM; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so3670412276.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713817159; x=1714421959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNWuH8R4KlmVwCmfi87OiHprzOdNZb+4awWRJihIuP4=;
        b=0+lxSkgMkJOJq5QAImEZFUkLEkkGASKEcH8LE3i83xosqnxMcvTL8gTY6mCpQNZTRD
         IOnWppuSF/o9P09RsF9DHlm66IIb6/5ZMid3rrysH09Ul6luBHiDle6uUpZSX1PVJ5js
         hr2NmcxeT8GY2748+lPy2ORReX+GEgIlFj55MKOzwn7byi4rXdK/EKorytIZzYP8WeqY
         X4fPP22upv1V+w/o+CD3LZcojDBd+UTl2JiCswRVwWpiw+2ye/UHtf1q4nITg730cLS3
         e1vXtQrAhDvenpeuMOZBH/TsplSzWSsfKomia7iyBDyMP2wrxrEb9xjNBbe3msIHh4ja
         h1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713817159; x=1714421959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNWuH8R4KlmVwCmfi87OiHprzOdNZb+4awWRJihIuP4=;
        b=t3H9z5ax69cUiVnujb0hdS9kAJptCXZj6i3zb8AMoMsejkGQuO34Cq0oghLI6ji5PP
         +2r2qkJ6ru/hQlxJGXjcijCG2sEHAvtd7UlYtrN5on2f9QbPvB9cqiV5dpGBinwq4AIU
         CF0Es/bo1eCzi7tkJvTt1skB0u/0VauxtzmFrGZhMlygVRvZ7A0omnqOhFhM1EGOJ1q9
         J8x/Z+Ukb1/hantfUXQVcMTSX0ySJpZAIl9Ga4SRDnX7mEfaU17no3QCEOmzKwa5QpUd
         AC6ZrEmVRggcG5yysCbJIEM0ixUU7OSa8HmWPZWRaN9j74IE68MMAOH6dw2cXmxOhT9L
         vvEA==
X-Forwarded-Encrypted: i=1; AJvYcCXBHOTEhax2q/UGLpzoxgXI5r1bEcbpDOMy+/o8vIfi3hjzzA712uLU8sTDMkBeP6U7giWr8oExT5RvgSYC5l8+DczGSv77BkIayZjQ
X-Gm-Message-State: AOJu0Yx5lNtGXMDwbG+ujouCJQvPAro+pCVGGxc/7Gd5uaroDg8DAqCI
	zrKm6LHHTYRf/SFOs+DYIONW/aFoddMvDCkumMeztqtfPrNYYuhLv/3oGsqWBNfGELMjGrbkJyr
	/Pyt6jBSsjcJVdELHetJcCqERV7UIwEqym9XL
X-Google-Smtp-Source: AGHT+IFDf/KV08uUrm9iSVoHnb88dMjYX5diuW8U2bZNhzrCeCsD/JyIMFVC8xCr1jkbtwis9euVnDQlC8QaQtgXjxA=
X-Received: by 2002:a25:8691:0:b0:de4:5c34:b8d6 with SMTP id
 z17-20020a258691000000b00de45c34b8d6mr719194ybk.8.1713817158654; Mon, 22 Apr
 2024 13:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326073750.726636-1-surenb@google.com> <95819052.15033.1713816660761.JavaMail.zimbra@nod.at>
In-Reply-To: <95819052.15033.1713816660761.JavaMail.zimbra@nod.at>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Apr 2024 13:19:05 -0700
Message-ID: <CAJuCfpHnM6L-7s8cd90XKiawhw9LZaRfMfeDm54OshLQdV5YmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
To: Richard Weinberger <richard@nod.at>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	kent overstreet <kent.overstreet@linux.dev>, SeongJae Park <sj@kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm <linux-mm@kvack.org>, linux-um <linux-um@lists.infradead.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 1:11=E2=80=AFPM Richard Weinberger <richard@nod.at>=
 wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Suren Baghdasaryan" <surenb@google.com>
> > Betreff: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
>
> > Patch [1] replaced vmalloc() function with a new definition but it did
> > not adjust the forward declaration used in UML architecture. Change it
> > to act as before.
> > Note that this prevents the vmalloc() allocations in __wrap_malloc()
> > from being accounted. If accounting here is critical, we will have
> > to remove this forward declaration and include vmalloc.h, however
> > that would pull in more dependencies and would require introducing more
> > architecture-specific headers, like asm/bug.h, asm/rwonce.h, etc.
> > This is likely the reason why this forward declaration was introduced
> > in the first place.
> >
> > [1] https://lore.kernel.org/all/20240321163705.3067592-31-surenb@google=
com/
> >
> > Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profiling")
>
> This commit id is not in Linus tree.
> Do I miss something?

It's in mm-unstable under dc26c7e79daf2fc11169b23c150862f0e878ee5a. I
think it just didn't reach Linus' tree yet.

>
> Thanks,
> //richard

