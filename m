Return-Path: <linux-kernel+bounces-45803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161BC843664
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6809288534
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8D63EA91;
	Wed, 31 Jan 2024 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m6lBlcBT"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B63EA8C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680957; cv=none; b=C/i3tYL6GZv2fUBh4Jb045/+iHwmwf9KSRg25UvtmMOuI+yTUAQXyWpQ2KSyxHoKcg70i1fQMZFkVgqSXlkKncZwNRMFymxJcxBUP7HPFAvQnLIZEK2MeJL1jQwGUBL1wWzj+6aZzmPvt5L14DJ3cmeNc/n+FFUkg3oy8ffC7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680957; c=relaxed/simple;
	bh=lKwlwJBXHA24Mb8B6jxhjFA4T95beAgylJJGBuM9BFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK5y4NmAA4B6Zb8bEJT7PnBmyXwiXLOno4eO7N+1QCze19J3iLWmKVVkStMUrEfWwNLpqWJepNeKQlSBGR7hOuG401QB1eyhji2u1Eac2yaFXd9ugAXCBEJiN4glPDdUj4joLo49w6v1+zPSOT4oRUp+RBDNzXinEVt2PQm7Lso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m6lBlcBT; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso2954502a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706680955; x=1707285755; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tNwTaEMyBe8WlJMtub0WYIoY7SynAzeHiccTsbFvqBI=;
        b=m6lBlcBTTOFfNEOPT2ZHmm95lOGxnBCBxcFMpb2ObixNyikK1DnLUrX8b8V3mspxIB
         MAX2xzO5bgDKbpOqv6mIQGI5U7952HzrKk38skP2/OG4XuJrHpJTmoirpIeAkJlIJfeO
         I7/i3Jdx6+kLIuBHeLUjlJ4VoppD+zQVPRn/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706680955; x=1707285755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNwTaEMyBe8WlJMtub0WYIoY7SynAzeHiccTsbFvqBI=;
        b=oiegY93Ozwe7Ep3zvG1ibXzD3z9gGe0CtzrvazfFJMVB4I149CWf+HcVAY8Vpu5Eiy
         CZqtvNzPIfHTXnlCNuf5t+CMD8ynnsdBYYYvpjIfaXoI17M/Goy5Kgbjnf9/FHmiwzHC
         cPoywW65OP/c/Gr9OBrJkKHkGrTcvQWMO2UOR6x6xaTw2vfsO079Cso2V6DeyeikLfgC
         Yt61WYHsLgQ5YlxFWbMch1l4jfMFDa/QgR08eorCdYqw1UGbQnc09/f8t2vtkmPtBcrD
         WkpSiy3s7fP4v9hlruHmV55Yn5tY07ZnX69LLXt4BTQgRWPH5x81IbfzYRTaJI+4s4oa
         G7TA==
X-Gm-Message-State: AOJu0YzdrOfYGkM0UhYUJ5yyd0GUMm4gsxz42RCnHuBSKhQGYBRjpJ9i
	9/Vc97oqRVcl0AuST+zRSbUauX9zV03d+TK1Cs85h51gTrtQjDeDC9CAJw50Pw==
X-Google-Smtp-Source: AGHT+IF7JBcrDdNgOyeSTq+d2O7R9BPejyoaAnWp01PnHjSbScjucfcUz3CQSfqu0zak8BxD4jvWMw==
X-Received: by 2002:a17:903:124b:b0:1d8:cbcf:2150 with SMTP id u11-20020a170903124b00b001d8cbcf2150mr697047plh.81.1706680955032;
        Tue, 30 Jan 2024 22:02:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVNb5Uos7W7Cej8vwaR1UGfU1m+Z4K4N7N5pI88MGgC1xAC5xjdxcmV8EsqKMw6wAqllWe4suy+E0nCSe1SERAvVeOjV96PhtDsNn+Pa3mCeElAEO4mCZgG8PtmbZVRciq2zPcdKKAmxvYoqbi6H4XylG2setwZ0uKuyMpP+Av8
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a2e0600b00295d781cb1bsm498706pjd.12.2024.01.30.22.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 22:02:34 -0800 (PST)
Date: Tue, 30 Jan 2024 22:02:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add UBSAN section
Message-ID: <202401302201.E6D71CF@keescook>
References: <20240130234634.work.003-kees@kernel.org>
 <CA+fCnZeDWQsd8xJdDhZbZBuyUaS6_WkFgZo5B4Pfjtkom_w1QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZeDWQsd8xJdDhZbZBuyUaS6_WkFgZo5B4Pfjtkom_w1QQ@mail.gmail.com>

On Wed, Jan 31, 2024 at 02:41:16AM +0100, Andrey Konovalov wrote:
> On Wed, Jan 31, 2024 at 12:46 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > The kernel hardening efforts have continued to depend more and more
> > heavily on UBSAN, so make an actual MAINTAINERS entry for it.
> >
> > Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Hi! I figured since I've been carrying UBSAN changes more and more lately,
> > I would just make an actual entry in MAINTAINERS. Are you all interested
> > in being listed as reviewers? Or would you want to be M: instead?
> > ---
> >  MAINTAINERS | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8d1052fa6a69..19b8802b2f12 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22471,6 +22471,22 @@ F:     Documentation/block/ublk.rst
> >  F:     drivers/block/ublk_drv.c
> >  F:     include/uapi/linux/ublk_cmd.h
> >
> > +UBSAN
> > +M:     Kees Cook <keescook@chromium.org>
> > +R:     Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > +R:     Marco Elver <elver@google.com>
> > +R:     Andrey Konovalov <andreyknvl@gmail.com>
> > +L:     linux-hardening@vger.kernel.org
> > +S:     Supported
> > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
> > +F:     Documentation/dev-tools/ubsan.rst
> > +F:     include/linux/ubsan.h
> > +F:     lib/Kconfig.ubsan
> > +F:     lib/test_ubsan.c
> > +F:     lib/ubsan.c
> > +F:     scripts/Makefile.ubsan
> > +K:     \bARCH_HAS_UBSAN\b
> > +
> >  UCLINUX (M68KNOMMU AND COLDFIRE)
> >  M:     Greg Ungerer <gerg@linux-m68k.org>
> >  L:     linux-m68k@lists.linux-m68k.org
> > --
> > 2.34.1
> >
> 
> Hi Kees,
> 
> Perhaps, it also makes sense to add the kasan-dev@googlegroups.com
> list. It's used for all other Sanitizers.

Okay, sure, I can add that. If it gets too noisy, we can always remove
it. :)

> 
> Otherwise, looks good to me:
> 
> Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!

-- 
Kees Cook

