Return-Path: <linux-kernel+bounces-66180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA485855832
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D691F22CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40952A50;
	Thu, 15 Feb 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E0q6o9GK"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D7738D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955888; cv=none; b=J0NEg4vsG/bqHMX61QhfqSuewfQ8t5a8ybdh9nzh+wOh+Jgo4hIwG66GxBirIXxxEkTPLaeLEH/4yq8kAGvcTQJRCzvtwvgHhm+nKZy7AXJtu8wXOnvu+Z9yV/3hI1RJdJVQVZjiMEjdI/r1WPx2WqkqW6LMsw3GLr8Gf5p29SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955888; c=relaxed/simple;
	bh=hRCP7gBFnl/HDed1cL/TYrjYSDbAQpiyFpJfDJmsQfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAW86RI0ESWZazGvsKITbX55VhnWAn/9nOQdQ/j87XGWBqhBxdQSVTllA2aQ7OovvDNYnMkKcu3VpKRrE/7epIS8gONzL2JhIqmrO8+yRayXRjBmtAXGrMCK7B48R/HXJTfwhorlPAOXIJp2gOgUXfSSGPmM6Ik38n3/jtMXIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E0q6o9GK; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d1025717c7so3087481fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707955884; x=1708560684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KiWMSqa1rWu/QozNlk3ifbqgQzvZnPWJ/ZDgt8vzqpE=;
        b=E0q6o9GKZS31CAXfMcntajwTJeInpeJRfWDa69K2CmwPJls709NFSsIOPODUyR51rV
         2nZ7bv9Ak2xP0f59PpaGVk2B+d2gs5V9QanHmPF9JZ71PxrnIKcWS7rClWClURASi7wB
         lahSP2JN0E5+eYRVnpeIoegiFGY4DMdFra55k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955884; x=1708560684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiWMSqa1rWu/QozNlk3ifbqgQzvZnPWJ/ZDgt8vzqpE=;
        b=JADFVzcAKh1r3qNAJYOnHHsDvDTNsZZDk9GRJS2rt3P4C7JBzX/f4LgQwIiOKNf/JD
         xFwq77zaqLzy0UEsibOQAju93PS7kefUWsDhrM8PGdHXaG71jywbKQBsJssRq9lTCtMq
         snbzABIlmyfOfo0J6ZomBCo1Yn/NU6QLchL60HVszNykQOEbybZztmLgZSxoF6ekThtQ
         A2xBthL+exJAgvG1CRgIu5h7FCOGCdyxDAYiJkoxQZv1SZgtcngFPkJlscyY8og+G10T
         5W/otgyvKfIegyEmM4i/KoJXuLskzdrXiy3sPUFEmJOH6nnZP1ddXGSV/gfQr/jLlRWF
         hK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBdKua7KidLDysk8GJVSFsguDNBfm+v5mgscRA38SF3wWOkw1lBpcC3xRxsL4FlXiPjlp9M/sXcmQhBEI8IwmDXVYw9RCRSoO+1uBF
X-Gm-Message-State: AOJu0YyGKca3BK7bKzthey1eKM8gNUXYSXzCI65m6rR2rZNmvJ6UKPtk
	xMMueCAb2cI3yu6blqE6dnmionARL2OTq3wplgaVW4wUdogp65PQrCiTL6Tr7VjFhOWYhMpCeDU
	zZGajzQ==
X-Google-Smtp-Source: AGHT+IFMB3zox22G8JYsG99wnTkRbXhpQy5WT1g59GlCSNLXImUURBNx57eI4KSe7ManDs+5aSEZVA==
X-Received: by 2002:a05:651c:50a:b0:2d2:943:d5a3 with SMTP id o10-20020a05651c050a00b002d20943d5a3mr71486ljp.9.1707955884398;
        Wed, 14 Feb 2024 16:11:24 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id x13-20020a2e9c8d000000b002d0d945e729sm32103lji.98.2024.02.14.16.11.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 16:11:24 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d107900457so4162571fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:11:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUblEV8Lww0/pFYomeu0CnN9tltJ3nD7T6wmNEgOotoy1SmPVGOgimA9uq7cezTyXA9xG2cbyx+hlTVcuv24lXGgvcapPkLCTOkgZpY
X-Received: by 2002:a05:651c:1545:b0:2d1:1e3c:5736 with SMTP id
 y5-20020a05651c154500b002d11e3c5736mr128925ljp.32.1707955882632; Wed, 14 Feb
 2024 16:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208220604.140859-1-seanjc@google.com> <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
 <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
 <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com>
 <ZcZyWrawr1NUCiQZ@google.com> <CAKwvOdmKaYYxf7vjvPf2vbn-Ly+4=JZ_zf+OcjYOkWCkgyU_kA@mail.gmail.com>
 <CAHk-=wgEABCwu7HkJufpWC=K7u_say8k6Tp9eHvAXFa4DNXgzQ@mail.gmail.com>
 <CAHk-=wgBt9SsYjyHWn1ZH5V0Q7P6thqv_urVCTYqyWNUWSJ6_g@mail.gmail.com>
 <CAFULd4ZUa56KDLXSoYjoQkX0BcJwaipy3ZrEW+0tbi_Lz3FYAw@mail.gmail.com> <CAHk-=wiRQKkgUSRsLHNkgi3M4M-mwPq+9-RST=neGibMR=ubUw@mail.gmail.com>
In-Reply-To: <CAHk-=wiRQKkgUSRsLHNkgi3M4M-mwPq+9-RST=neGibMR=ubUw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2024 16:11:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh2LQtWKNpV-+0+saW0+6zvQdK6vd+5k1yOEp_H_HWxzQ@mail.gmail.com>
Message-ID: <CAHk-=wh2LQtWKNpV-+0+saW0+6zvQdK6vd+5k1yOEp_H_HWxzQ@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Jakub Jelinek <jakub@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 10:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Based on the current state of
>
>     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
>
> I would suggest this attached kernel patch [...]

Well, that "current state" didn't last long, and it looks like Jakub
found the real issue and posted a suggested fix.

Anyway, the end result is that the current kernel situation - that
adds the workaround for all gcc versions - is the best that we can do
for now.

             Linus

