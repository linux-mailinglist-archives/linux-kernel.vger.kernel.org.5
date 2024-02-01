Return-Path: <linux-kernel+bounces-48803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD628461C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B377BB231F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EEE8562B;
	Thu,  1 Feb 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SBo4/l3M"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42748528B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818000; cv=none; b=j/VaeaRgfcIgg9+GuyLZ36eyFnvTRvI8dkCrCj16gigLAZstDhd/uSjkyeGRufmE/D6fUaPehoLChYCGVo1m7mEp5fqQfmaWJCPS12Lnwb1x/8eZJYifQ1odU8IjJhGCi0JfI99ncOf0iepuVLcstuiuyQfILkGGu/5NbZt1lVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818000; c=relaxed/simple;
	bh=oA7/NspYB65l8rTsetujkWO2pCTj/tsZobfNjYRmfKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fihiKy8NplNNJn8Ki6gZBtTMbIdzJ2HMgPKBLS981+wnVzjvpI2p7QkW72D8KUsgIA0MkBdDWCKOgZodktg0ByZqS4OCpBJIDVLDw77xxGOnu3wzUPakVXqkOxRGEofsCnXZBBmYClN4+EEVxTgd2WTLIoQMBSWuZeVz7mx6HZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SBo4/l3M; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so1913942a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 12:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706817996; x=1707422796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kP3MIyg6XgOfzN8W5NDTvSQr/3wxGR91YVPW2iDkboc=;
        b=SBo4/l3MwuUmebhLknMVjJiuyErNiSKGUuEVap6fg8rpef0Lac34Oy150IEMpc9U0U
         z8JyU6SsIBo9pv+zEQ4w4iWvqYaDwnRoUDo8C8KhbYMLdXKoyhvHHIfF6wjFuBdpu7Te
         UmAs0o5N15W56AOruvzKjtvJwUhebCMI9QYZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706817996; x=1707422796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kP3MIyg6XgOfzN8W5NDTvSQr/3wxGR91YVPW2iDkboc=;
        b=hDEeFTH+FiMeW5nUYw+WHKmW7lmD4hcKVrqPKRRMTPqsUGJQVi7bF5N8iySwri2Z8w
         qkEu0xIhc92qKXsyduhWFp+QOCgfxOxevydMSb5qLgqpqyJERArL66OHrUUlK9tpeAsj
         SoN6tthGas4WsbTiMz7dqX5u2tkUIrtz5lXCKjwmt7Qjxx0L6Ddz2WVzGHoifkb7IN8y
         ykFHGmmNabirxsvtxKxfEJZ+z3ZlrTojUyKkbCWHKJ4cyyvKoWRhi4jXVU2PZVlymnkw
         kspZUK+qW/PfrrLjIIpKGerCVDFgLg2wdudl6mxpBEPwiWzKLhiu2MKo+YOHFmxqx5WV
         dNUQ==
X-Gm-Message-State: AOJu0YyV+QCvTnTji2rM1maeEgmn5rWmDR0Vy06/NAPTWF7Onz56igvV
	/xLJPYwoa5NAxtSCJf3hu4ZegLWDJNaqDAzcSBQLg0wJhXAch4A5IXpyu1S2U85D8ZwdFhcZJhW
	kEUsAlg==
X-Google-Smtp-Source: AGHT+IF+cjIwTpzrw+QPoq7Qe7koyovnkS4wGHWandUfUZEneOUqjfE/3ne304cPvkkW4WD2jfCKMw==
X-Received: by 2002:a05:6402:3588:b0:55f:11cf:ee53 with SMTP id y8-20020a056402358800b0055f11cfee53mr6384947edc.31.1706817996531;
        Thu, 01 Feb 2024 12:06:36 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c387000000b0055fbc52457fsm139614edq.30.2024.02.01.12.06.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 12:06:36 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so2044533a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 12:06:35 -0800 (PST)
X-Received: by 2002:a05:6402:509:b0:55f:43af:19d7 with SMTP id
 m9-20020a056402050900b0055f43af19d7mr4668961edv.34.1706817995577; Thu, 01 Feb
 2024 12:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNASGqfMkTuzP28qydpYCC0ct3cAgMpbPpmgHuQHZbtLhbA@mail.gmail.com>
In-Reply-To: <CAK7LNASGqfMkTuzP28qydpYCC0ct3cAgMpbPpmgHuQHZbtLhbA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 12:06:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJKZNZWsa-VNDKafS_VfY4a5dAjG-r8BZgWk_a-xSepw@mail.gmail.com>
Message-ID: <CAHk-=whJKZNZWsa-VNDKafS_VfY4a5dAjG-r8BZgWk_a-xSepw@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild fixes for v6.8-rc3
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 05:40, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>  - Replace tabs with spaces when followed by conditionals for
>    future GNU Make versions

This is horrid.

Now, the whole "whitespace type matters" is broken in Make anyway, so
clearly this is a fundamental make problem, but this commit makes
things worse by making the tab replacement use eight spaces, so it
really visually is entirely indistinguishable.

Don't make a 'make' problem worse by not visually distinguishing tabs
from spaces.

IOW, those "that can't be a tab" cases should have used pretty much
_anything_ but 8 spaces. Yes on indentation of nested 'if' statements,
but no on then using something that visually makes no sense.

IOW, those nested if-statements should use perhaps just 2-4 spaces
instead. That tends to match what we sometimes see in C files too, and
it is visually very clearly not a tab with the kernel coding rules
(yes, yes, some people set tabstops to smaller values, that's _their_
problem).

I've pulled this, but please fix it, and don't make an insane Makefile
whitespace situation worse.

                Linus

