Return-Path: <linux-kernel+bounces-159757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2AC8B339C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BF72870B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D1F13D500;
	Fri, 26 Apr 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="346Iz2jF"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6025605
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122589; cv=none; b=OiF25BqHQ6UAD8hvvgkD4FQLe/qJIfdlw/99Bj27LFyNVf3gfG6B9WLtcTCSnHvK3UbOia4v1FyQn7OV1Q43oxJ/ufp9d2ylAJqNdqfXEM8PuUuwpfbiS1p3NNd0MNTpDg1Dt4SHNwVjacuqz0eFQHAp3Lo70IX19UO+URA6yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122589; c=relaxed/simple;
	bh=rsKIGIgxZ5oV+PsdIG1IPFpc8yUCBe5/hXp7A/GDheQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cf4oJqLiE4vla8bKEh3LQaqWAFYp5hiIPdskeJAiDj+Tvn/RFfRyCOpg86dMOz029N767QI3AmFWH5fjIYoiQdHDqY5BzQtmh3pGT3D/7zDQSnyiOWhOOXt0cL+5e6oS0j4Wn4tcOmxeLN497g2BnpDzWEJ7yuXh45/epwM+1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=346Iz2jF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78edc3e7cd9so124645285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714122587; x=1714727387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evtA1oR8ggj4pKATUIFL+5XX/DzANvxLRH/ui3h4FJY=;
        b=346Iz2jFjOh0Jri5/YBN5Za3hXWECqGob6PZ8O0LGP6MRHseigoN1lzsflgImATpC0
         zaWtz6EFMUlvOQuGGIckA/srpPoDq37UvWtpGP7/HZienjv1OKsgam3weKTeYdCSNM/M
         Urv9WzVWddbuQblBi+F0PlMyyqlXf1hBZ1N9GWEsLIe8mssgbEBOifWPnlzBvDTE2cSJ
         Y/L7abYfBZE9lOBAJ8+xG+Vih5NRBuNuw+lKJO4E7n0VR44HBGhJdzdY6jhnYPsqX2eY
         o4eBVLdJokKYAoOSXB5YKsU3eTN9P0Tapx6iRDvczrFh44Kz4O+xe5cRPFI91AllcX9J
         dw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714122587; x=1714727387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evtA1oR8ggj4pKATUIFL+5XX/DzANvxLRH/ui3h4FJY=;
        b=UpQKbH5SPBVPlo5JtfNhrLD1KqtwJuDwg83MxEwWhNe7QUkYQ8V5UAfUiz+v6ZAb/k
         ElHEbaZ+gJxZSkSUPmM/bKvOGZkKqa+5wt5zgX7TSCVn1hrj2rkOY9VHBrdZzIwQWr6+
         Ffdmy8WB2oLQfaRG/LLEeAwoROUiLyreG9load2aFboVm/isxB11JdRKwhOSO7yToWG9
         eog3/aBfrM2ptwqwiy2nc2rTHp6o08BKS6XjVaedwJarODpL39rsGyuHgfauvyJnDhcm
         sGyZMsxHIy2OuDtulRFsCfPZakiQq5LkQPIIZhKy9n6PQD9rJ2oLAaSbmWh6dwU4xh/5
         bfHg==
X-Forwarded-Encrypted: i=1; AJvYcCWgCb/F5uDGHzbDi0xZg8QgelUHHhmOoPR/QgOaXAT6r7fvRZ8Fg/4bY6YiGfvdIeurQR2qyktxy/RPuWqp09MmHwlnfP4lw4bQmhRe
X-Gm-Message-State: AOJu0YyMRBmF/tID3VCo2c/Tfmlk4y2UZ7ZJ2DASwJE6I7ICbIg6Z8It
	gdH6wpYqyRl90V3g1fxMc/Vfgz8mzERHDMBuij6ZI3qsZmutnCBuCSToqK091T0l/4mkam6Pp4L
	bdHlD8WoeOKlacqHFKiAJrXr92ILnXjmytpxy
X-Google-Smtp-Source: AGHT+IERDkZYD463N4iRg2JtXIis/lmVdrlEpH8ltkBDFPaGG9UvEH6Km/Em9CcvAFcENWD/0u3nNaEt2Az+kKN/BBo=
X-Received: by 2002:a05:6214:5084:b0:6a0:949c:4431 with SMTP id
 kk4-20020a056214508400b006a0949c4431mr2598082qvb.8.1714122586784; Fri, 26 Apr
 2024 02:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425092859.3370297-1-glider@google.com> <20240425133121.efd1f9da094be454a6366cf2@linux-foundation.org>
In-Reply-To: <20240425133121.efd1f9da094be454a6366cf2@linux-foundation.org>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 26 Apr 2024 11:09:06 +0200
Message-ID: <CAG_fn=VumGCGWKf7M7HWU5nKDHAcksqjYeBq0hXVd_k=anmn0A@mail.gmail.com>
Subject: Re: [PATCH] kmsan: compiler_types: declare __no_sanitize_or_inline
To: Andrew Morton <akpm@linux-foundation.org>
Cc: elver@google.com, dvyukov@google.com, ojeda@kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 10:31=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 25 Apr 2024 11:28:59 +0200 Alexander Potapenko <glider@google.com=
> wrote:
>
> > It turned out that KMSAN instruments READ_ONCE_NOCHECK(), resulting in
> > false positive reports, because __no_sanitize_or_inline enforced inlini=
ng.
> >
> > Properly declare __no_sanitize_or_inline under __SANITIZE_MEMORY__,
> > so that it does not inline the annotated function.

As Marco noted above, we may want to rephrase it as:

  Properly declare __no_sanitize_or_inline under __SANITIZE_MEMORY__,
  so that it does not __always_inline the annotated function.

Let me know if I need to send a v2.

> > Reported-by: syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
>
> I'll add
>
> Link: https://lkml.kernel.org/r/000000000000826ac1061675b0e3@google.com
>
> And I think a cc:stable is justifiable.

Agreed.

> A Fixes: target would be nice?

Hmm, the introduction of READ_ONCE_NOCHECK predates KMSAN.
We could do:
  Fixes: 5de0ce85f5a4d ("kmsan: mark noinstr as __no_sanitize_memory")

, because that commit should have introduced __no_sanitize_or_inline for KM=
SAN.

