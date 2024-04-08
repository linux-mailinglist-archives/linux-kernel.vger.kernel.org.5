Return-Path: <linux-kernel+bounces-135817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B63289CBBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A33283353
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEAF1DFF2;
	Mon,  8 Apr 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h2Ch8rFB"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A91847B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601162; cv=none; b=mVX/gvVNB8YaPBQefhGsK/kinaB0GwRfU90Ls4BLJ5euyJusmaqEGZnfgRxg1PSCkPtD6D924rBBfjGktHVnOKCtgmyRbjV3ir94LjTwudeoHNX/OeWZSKbEeBkNDO3VkhJH3oLrkV4/MGAl6XGRUWXUrvxw3nArPoiJ1vbL2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601162; c=relaxed/simple;
	bh=nPGyLyJlX2fCnsHunHmkY7pU0JlkSGSco0okv+kNh4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEngpF3wUpAU3qu6tUbEYKmF8STHc/ng0KQLP5HfqdbC9fEki4BMbekGl65wBMgrN3sTGMa0gnfWhH+22CUsUitccrc86JUmuShUbqLRaTCBMdho6QvkHT6xvhypKtR4iET4eTKis5lQbsdaUbsAe11PUppZk4/5AD1LdbZfiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h2Ch8rFB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d6c1e238so3459540e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712601158; x=1713205958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbEhSspiiQkOhO4cKWHaWHB2yUMq+x8uxq8aQa3Mn54=;
        b=h2Ch8rFBtSM+lGVbyrpODaxDHdduEKxxNlHazXd4GpQ/KeoHuVyicpCbYlGcziowRt
         WNrzPhnazdjdCXJ0XiM48sNAWQjqi9xCUbFh1RXof1hzRj3KzWiEvZP4R8SxBdG46Zt/
         w1cpMlGkAXNIvEJ/Cs30IHRXaaiazRFkLkkag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712601158; x=1713205958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbEhSspiiQkOhO4cKWHaWHB2yUMq+x8uxq8aQa3Mn54=;
        b=HeEOlEHvOuhubKBw3FuWQ8ahg6xrvWyUpWIGxPhqB0b4LUnzI3I0l/h+sxjeKnoHY0
         gCJIw+pcvX+j1HUdNea8m1MHcNUmuGFKnRorEbI42AaFfg/XEZ/cmiIyXJXQ2jPRiXF+
         eOU+Rz1zlq5RFaEjrGSOzHQeNeJ/nH4iApG9HDxOBIcQ0ja+ZHT4M6k+sZfe+xlB4JDt
         EIxJOqVc1YvzFh3nQcG5x0hTjhJja1Q78qimBLoxXsKIf6kaWzuAlEOZkStlNKcZpaxq
         B23OTdbdoUw50QId8rb6c6tVNOYzX+nb/v4Fvce4cwUxGUvyF5IcFgo0rH2LYu1Vw94v
         uZDw==
X-Forwarded-Encrypted: i=1; AJvYcCUzXwTcCTHHI7aTt5Gyy3bNgR2bjq86hTMOABQ02KDHIRaFQvUueeCTwBeNY/IDqDX71RZPT+raIpU52kYSIjLbmpnOaEIOHC7fA/t4
X-Gm-Message-State: AOJu0YwKmt7TLLeNHqs50FSVSs7FHh7iw1fYP0qhcmfBlnDux2hV5Ny2
	vzlQJ77SlbWnkR183cUqga4TLasM6EG+ARCsXfMFYKwFS44xaPfrl36bLdi6xbDGBLo1nE6MG3O
	ioX6/jg==
X-Google-Smtp-Source: AGHT+IFzteOfXe6YrFBoQCe8+G65qPkt/XfnbaLLUlRz3y3K8fvcon2idlwDwxt6SamGKByaioG/Zg==
X-Received: by 2002:a05:6512:2348:b0:515:9479:a997 with SMTP id p8-20020a056512234800b005159479a997mr8146560lfu.10.1712601158039;
        Mon, 08 Apr 2024 11:32:38 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a24-20020a50c318000000b0056e347954f6sm4099217edb.31.2024.04.08.11.32.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 11:32:37 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51d3193e54so167480866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 11:32:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvJ9Zn43o6G4HJZtgf26VRTuC2jCAXguHJXBs3m+oYZg/AsbKQYfzLdVEUJMg5utULjvISYBaAOV2k6RQs+QzTthoKYdvzSF5KDVBu
X-Received: by 2002:a17:906:eb4c:b0:a51:970c:acd7 with SMTP id
 mc12-20020a170906eb4c00b00a51970cacd7mr6011573ejb.21.1712601156851; Mon, 08
 Apr 2024 11:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
 <20240408084934.GC21904@noisy.programming.kicks-ass.net>
In-Reply-To: <20240408084934.GC21904@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Apr 2024 11:32:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=witEwVvJ6Wh4xdP-sUkLQSwcRTtg_NSuGMMgvYmcs3teQ@mail.gmail.com>
Message-ID: <CAHk-=witEwVvJ6Wh4xdP-sUkLQSwcRTtg_NSuGMMgvYmcs3teQ@mail.gmail.com>
Subject: Re: More annoying code generation by clang
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Apr 2024 at 01:49, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Should this not carry a comment about the "ir" constraint wanting to be
> "g" except for clang being daft?

Yeah. Except I think I'll do something like

  /* Clang messes up "g" as an asm source */
  #define ASM_SOURCE_G "ir"

in <linux/compiler-clang.h>, and

  #ifndef ASM_SOURCE_G
    #define ASM_SOURCE_G "g"
  #endif

in linux/compiler.h.

> (I really wish clang would go fix this, it keeps coming up time and
> again).

It's been reported long ago, it seems to be hard to fix.

I suspect the issue is that the inline asm format is fairly closely
related to the gcc machine descriptions (look at the machine
descriptor files in gcc, and if you can ignore the horrid LISP-style
syntax you see how close they are).

And clang has a different model and needs to "translate" things, and
that one doesn't translate.

It's not like we don't have workarounds for gcc bugs in this area too
(eg "asm_goto_output()", n=C3=A9e "asm_volatile_goto()").

There was another bug in my patch, though: the output mask should
always be "unsigned long", not tied to the input type.

              Linus

