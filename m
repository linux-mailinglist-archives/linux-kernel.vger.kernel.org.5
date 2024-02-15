Return-Path: <linux-kernel+bounces-66553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCBF855E45
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2083B1F21E88
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E76917745;
	Thu, 15 Feb 2024 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzFwUeDS"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF51643A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989637; cv=none; b=qUtmUMMzd2gazJj1Z4Fru+GyfKPMi6lHBEerwqUlG8A5q0uBZmz+JSvkkat0GTzpzAiuYSPHTll/n9lPSS/LD4mTbZRlTm9ABKnAPQIoN8jTimqoYtrwYNBNzUtgnnDGJc5RDMtgtBsRgU3YPBgdzWE33hUC0G8lG/0Jgekzrqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989637; c=relaxed/simple;
	bh=J5qD1qIcL0GtDZlsLjMP1uObwBbpaGL6EoEe3uAZyq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZZY03okNB3wGnu3EdyUTcRXbTSN050Mpd2ex4k/qcBGWhvvWMQCFmJMwkBe18UkrLOpPtPt4/O8TwUFC74IWBReWlOwyOkcYwsMBR2gnF7GkW1dZXvTj1pkVf8nhs8RrCnOVfc4evQvatRWCCsSG8XUZ6wHOn9aVsuEaOSvBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzFwUeDS; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c081a16e6dso221404e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707989635; x=1708594435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V8s0NxRvI+mjl5XkkaP3mvBN6LNvbOLcAfquE2r5eZI=;
        b=IzFwUeDSu8hXpAAGgZRa6xjIX2hIaQqafKCHblmI0E90rd/p1dJcAG75GEsL7Xw59t
         fK/I+7VGObADHVlUZPi6wh6bBtHITwg1Ow2yJhfYVG2zXZjgdF7sV8WxVY+zwFUUMFYp
         Dh15mG62vXMixsJ2wtB+IlPybK9Ka7kPYWIgmQhj3x6Jo/eHJseyRBogBwFSprbepWRi
         F15HexV6DH2Gy4RFC2xoqaVU2Nw2TYlE4qAKTDFSL9uXqobkv28LNWlLlQQ7PqzvVHN7
         ttzMeW/M3iaZsRTckhbHlgzsThGxywc7saSnwvPPrQk/3SM2Vm6gHUe9H5sYpzk3M3Fg
         uMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989635; x=1708594435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8s0NxRvI+mjl5XkkaP3mvBN6LNvbOLcAfquE2r5eZI=;
        b=IuCI+LVaiY0ztyfA+CdXAjeNAGAaKrsqhPf4Nqfn4pHyKL8IZ/DkZzKjx+VzP+bUPF
         /b0N/wHtXSzcnYR6afsvzzslnvSlWQ1t1QJufFL8Dwl8qi64jIGenQ2mYakuZ3jcmi/v
         9+cnto/SxN7s0rIgjA3rQsxey2kwXWevsxQQWQ6roKrJdOsV/4CVpLo/rwQUzVxYG1Qr
         9SPAwbEB6Yx5I2YCH9xr7UfmYRzShgCJvL7Ha5mCHp5Y2BA6yel7M6QI6Za+YMcTkxR3
         XjSs0Da4+fgCLvVj49Z+BDBMcuwY2Tz+5XDIlq6N5byk7t8QqXr6JdumQcJLNeO7OZRx
         07fg==
X-Forwarded-Encrypted: i=1; AJvYcCX7mB0qBVL7/IbJdEFUz6ENaCsbenmOfgUWLaPyEq6uyeQeEgGGle9OJ6bgyOLb1T5bqRS8s0cFX/osISUB50s3qsG/2fvVVN/Kgujb
X-Gm-Message-State: AOJu0YxxPyeD+aRAybJdklFdAGqeqe+xCf66fbARZAEH3sIuQWGBCHSu
	9az8FesadgFcTHta2XbBR4gpVfvRXRsyXl6UqFhghMOt+OynqT9bwusvuoJVKkBMPcfpNFfa/8j
	12go/A1zw5k565+fYnhiKWhQG+gKCOdl1+psh
X-Google-Smtp-Source: AGHT+IElxHBxZPPrDv/wuxMTC9HS3F+Al5XcXpij5VChL1txzlpGTpCPvZpdQ+kn1EdxDYRzRCWxa1OgWoaaU0+6Mf8=
X-Received: by 2002:a1f:6681:0:b0:4b7:19fd:9558 with SMTP id
 a123-20020a1f6681000000b004b719fd9558mr815574vkc.11.1707989634396; Thu, 15
 Feb 2024 01:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214170157.17530-1-osalvador@suse.de> <20240214170157.17530-3-osalvador@suse.de>
 <CANpmjNPypJM5icG9M5yP5-psSofbA7D35eaKx+E6NyCsHMa=qg@mail.gmail.com> <a310c3cf-049d-4067-b950-f6abf9b5b098@suse.cz>
In-Reply-To: <a310c3cf-049d-4067-b950-f6abf9b5b098@suse.cz>
From: Marco Elver <elver@google.com>
Date: Thu, 15 Feb 2024 10:33:15 +0100
Message-ID: <CANpmjNOgiqcXx1T=-W6QL6RuYsZSLOdSjGH9iLVJru_3=15Bnw@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] lib/stackdepot: Move stack_record struct
 definition into the header
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Michal Hocko <mhocko@suse.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 10:30, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/15/24 09:16, Marco Elver wrote:
> > On Wed, 14 Feb 2024 at 18:00, Oscar Salvador <osalvador@suse.de> wrote:
> >>
> >> In order to move the heavy lifting into page_owner code, this one
> >> needs to have access to the stack_record structure, which right now
> >> sits in lib/stackdepot.c.
> >> Move it to the stackdepot.h header so page_owner can access
> >> stack_record's struct fields.
> >>
> >> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> >> Reviewed-by: Marco Elver <elver@google.com>
> >> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
>
> >>  #define DEPOT_POOLS_CAP 8192
> >> -/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
> >> +/* The pool_index is offset by 1 so the first record does not have a 0 handle */
> >
> > Why this comment change? We lost the '.' -- for future reference, it'd
> > be good to ensure unnecessary changes don't creep into the diff. This
> > is just nitpicking,
>
> Agree with this part.
>
> > and I've already reviewed this change, so no need
> > to send a v+1.
>
> But confused by this remark. There is a number of nontrivial changes in the
> series from v8, and IIRC v8 was dropped from mm/ meanwhile, so a v+1 of the
> whole series is expected and not fixups. Which means including patches that
> were already reviewed. That's the usual process.

This is already v9. Of course, still need to look at rest of v9 and if
there are major changes needed then a v10 is needed.

