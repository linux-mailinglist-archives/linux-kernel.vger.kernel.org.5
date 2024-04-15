Return-Path: <linux-kernel+bounces-145690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F0E8A598F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773F11F2312F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A85E137C41;
	Mon, 15 Apr 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iX6e8Xt0"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884EF84D24
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204421; cv=none; b=kyo4C+DlV8ygUxpLIux3HYkbs/IMTJmFKTRdufzlKYc+BDJ/6Z5//0OKwifBDZaE8woiJTQADWTnKWEAkfWlS/50Uj7hieRyV0VNKfCCqkrcaBwdq62EX/XsxcV6533ddKGLJNlomh9vtFJKz/u7+W0pIB1t9BT3HlWaypAQKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204421; c=relaxed/simple;
	bh=xj1SBpac8RAPPa4cYnNvnA8NLdzOnlNHsZUECbeclDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTys4djVRJugIRqUyfC6tW9AaG/W+/fcVSKjkfd8/RDW+/87kSlj17fK5kX7lmpZgbx7ouTearDfyeMMO7TvMVVjq8V/T4r7Tv3KBlXk+LypMwFXuUXkPI/JZuUiIj7mQSeTGi49945VeHGHzdraSrNJfAqTzuNNBKKv64V8+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iX6e8Xt0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e6723c606dso10767015ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713204420; x=1713809220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hkvNj0SDmFhhMkw0sRd1k/aPAqSYVAFYS0V+mjg1+Ys=;
        b=iX6e8Xt0Yu6OZ5FskbjoVWf5iLkystLO54c8DKnns6S/V6xNDjhly/cI6KuybJFvd4
         1OOvpoHigs9r1kvP2OV+TrW9OG2k7mXxBel27CFwiKDoYOKUAIdh7VlqOkRg2ntIWPke
         rsbGB+guFt2tTzsvDNPkd6m07blcl4iBB0tBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713204420; x=1713809220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkvNj0SDmFhhMkw0sRd1k/aPAqSYVAFYS0V+mjg1+Ys=;
        b=lq42d+z13U0uYy2XMpJV7FnUCC7IiAqx0XpUi1OjcUtqC9XKcwn7LqHjdXIRCTnHq6
         UOKIKKauzy8l/bC4jg4BQelW38nCVV9MjIKG9I+LaHmyk3jT3I2IkODjKaNOJSWA9hV/
         B289P/DTgO1hC4epm+go2iOuWHlwARcxJeOHIx0aW3xtDvAstIxtVKIZB8wxOYfLylHX
         ElvXbX+cnca74EZFAhTmwnsO88seY5qjGjyO+zuEgdjxfhPh1L4c4e84gBg2zSsUX+Jl
         898W+hpb4MMF6Hl0ITfe0HoRPsaFxTrrHxYIpZeoeQWkRJruGeRdjy1EBOBkZL7sn5kl
         PeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPBYBd52fGpyXqbORRRAHZwMQgJYyiouvVwwDFZM+WnbPPTdd1Aq1fPsmabABI7nB5FP2EzCwKrEzbrW+EWK6PbxMnThyzJWpSXN6j
X-Gm-Message-State: AOJu0Yx3Nj+NW9HQn/0uNyINj3ynPJFNfQ9lqpk4crGeeuHN77RLteAN
	BoUXErIX23JJO0UihfTvvfLPPEs4/OF/2wrWvcPN75W9Kn0YA8iYOfYsisBW7g==
X-Google-Smtp-Source: AGHT+IEoSmiqVWll+WGGtai5I1QgX+KNmvNJiMmUzgaHJwAdK89iBoCnt3jFLPWk0W0gCtqyQ9HIoQ==
X-Received: by 2002:a17:902:a3c5:b0:1e2:bd7d:5609 with SMTP id q5-20020a170902a3c500b001e2bd7d5609mr11793136plb.20.1713204419874;
        Mon, 15 Apr 2024 11:06:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b001e509d4d6ddsm8398013plk.1.2024.04.15.11.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:06:59 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:06:58 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Joe Perches <joe@perches.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v4] checkpatch: add check for snprintf to scnprintf
Message-ID: <202404151105.54B9DEABE8@keescook>
References: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>
 <48d593c1-c706-4af3-aacf-d1329a8b0d4b@wanadoo.fr>
 <1a4554d39229c790c98bebb213bc9f2423cd32de.camel@perches.com>
 <CAFhGd8rUz_wG+jkW=+17RpG2BQxaRMmZVk=g=G1FogMSeAD7jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8rUz_wG+jkW=+17RpG2BQxaRMmZVk=g=G1FogMSeAD7jA@mail.gmail.com>

On Thu, Apr 11, 2024 at 03:10:57PM -0700, Justin Stitt wrote:
> On Thu, Apr 11, 2024 at 1:56 PM Joe Perches <joe@perches.com> wrote:
> > It could.
> >
> > # {v}snprintf uses that should likely be {v}scnprintf
> >                 if ($line =~ /\b((v?)snprintf)\s*\(/) {
> >                         WARN("SNPRINTF",
> >                              "Prefer ${2}scnprintf over $1 - see: https://github.com/KSPP/linux/issues/105\n" . $herecurr);
> >                 }
> >
> >
> >
> > Though I also think it's better to use lore rather than github
> 
> I am fine with making the UX change in v5 regarding using ${2} and $1
> but I wish someone could have said something about the Github links
> earlier, we already have a pattern going with these string api
> changes:
> 
>      "Prefer strscpy over strcpy - see:
> https://github.com/KSPP/linux/issues/88\n" . $herecurr);
> }

KSPP isn't going anywhere -- we've used these links before and we can
use them here too. I don't see any good reason to duplicate stuff into
lore, etc.

-- 
Kees Cook

