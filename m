Return-Path: <linux-kernel+bounces-49690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91A0846E2A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641A71F2AD40
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ED513BEB6;
	Fri,  2 Feb 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DubXinFC"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87652E851
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870642; cv=none; b=sbABiXJfUfcHmNU+D6AApFwzo2wo+PBHFr9AdTwFGsZMIY3ugGrLVrohSNJS7p+eyXUdQAwxqZ7PsNuach9e6gVJlokXI34esd1eVnqmIO8bdpycYtL37m9y2bc3XjM9M6UkIEeISLjnx20zWqVD4IFH1HvNet3W1Zj8KhIpzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870642; c=relaxed/simple;
	bh=P1JikgoFSh/cNJqd+o9eE/ocoCgKnYWQsWdsIWt9SkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9SCdxX602E//mUKckndhO/uAuegJZQGBhQaNukCJan7V9zojK+cboy89+wY73awzj1XrcsOjVxCWMT/7DJmOJ0SjVzae4G/pzafj7cVwPUJhaoMKlS2/iZRRX8mFENoE83sa3liRsjjzTHqvlSsnTjDcMPlAd1BnTTxU23AULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DubXinFC; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so768827241.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706870639; x=1707475439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gJhpSyluzHV/EGytkpmOhmA4e78r9ibVURsi5TUtta0=;
        b=DubXinFCzT9sRrPghE0CHMHL3R751AcaLXskUFIsWxbOFYhL44J6xgVeQ7a5eDH2ms
         QR5U0c1DRo/WnWmOJ5wVdLIKwyDNniT69gqEzcCgpecda6x8BPefuQH7GNcVvp80ZCsq
         iWq2iqB0Gu6VRHzaZx/1Ot7bJHM68P0ajbbbvKNfxIV3el8XNNnTSIKaw1tYWWckGpdh
         9/fhpJS7z8FdPZdABcWX/Plbc9JIeNLGixZwTFlN0DdgpBzcWVwlzR2iIKep5/bZmUZP
         gS87s/Z/jqeWfVjwiox+mKFZ76hD3Nc1TKPCE39fYKBjfA3dpiteAVqpAo3ieiQzqosx
         YnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706870639; x=1707475439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJhpSyluzHV/EGytkpmOhmA4e78r9ibVURsi5TUtta0=;
        b=EbtvyV2Hn65FMutx7aqDSIyfZc7JEln46Jz6hnvDwTexAGFrsKkt8GbcoN8G2nxBqC
         vLPkcb+sKH3eGGvrgIYIZGto+NKM0CD0Olq5slC6RP3RMj4N3Q2i4x9YO1xdJf9X3V9o
         eascby1uciLC3+5ivOeKiQAcLouuOKQU2WnHtWHM5ljwFisUUjEGfbYHDXmBdhWlxPEi
         y04K82cB0w3507dQ+q+9n8LuxjPmTApPw2Jl4lQr8HICLlxg6GQ5rY5CvOwwBB62wPU7
         MpnQj46Ox+dy+hskzX/Saj4YuhEV2sxnwskI1Jf4Q9fH3MjUm6ADE4KPM486gIi+QZEK
         AuLg==
X-Gm-Message-State: AOJu0Ywk6F6rSt6kbfDlINBTwQC7APebDs3PdN9oMRaEaXlJ2w/Bq3QD
	V52rj10lEsbwZXSpmjDHX57GfU8hI6CnEzo2yYL1O4h2+5ZxDeim21BGrKSj4iICheBgl4ju54u
	xAKAbYMLt47NuHpBmNL3tTXLSdRfsrKu8Ilky
X-Google-Smtp-Source: AGHT+IGj9BfBKOsJeaDuSYFBz0YFIEl6Vwrr3vgPyIPrJpYX8NAf5a1tebSHXQtFpjfcVHCwUKn13lWiFbfkF6T+T6Y=
X-Received: by 2002:a05:6102:3654:b0:46c:f7ca:e293 with SMTP id
 s20-20020a056102365400b0046cf7cae293mr1674149vsu.8.1706870639490; Fri, 02 Feb
 2024 02:43:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202094550.work.205-kees@kernel.org> <CANpmjNMCBvdM7Ni+vWCQwtJbbVskOdjSA+gjhgh6R3dKRqjXnA@mail.gmail.com>
 <202402020239.1EEA467@keescook>
In-Reply-To: <202402020239.1EEA467@keescook>
From: Marco Elver <elver@google.com>
Date: Fri, 2 Feb 2024 11:43:21 +0100
Message-ID: <CANpmjNO6W2qDLYuwNRJs2SUCD_wquwPRWG53s65HfKfOiHztdQ@mail.gmail.com>
Subject: Re: [PATCH] ubsan: Silence W=1 warnings in self-test
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 11:41, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Feb 02, 2024 at 10:57:11AM +0100, Marco Elver wrote:
> > On Fri, 2 Feb 2024 at 10:46, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Silence a handful of W=1 warnings in the UBSan selftest, which set
> > > variables without using them. For example:
> > >
> > >    lib/test_ubsan.c:101:6: warning: variable 'val1' set but not used [-Wunused-but-set-variable]
> > >      101 |         int val1 = 10;
> > >          |             ^
> >
> > This is the shift_out_of_bounds test? It looks like the neg and wrap
> > variables are volatile but the written-to variables aren't.
> > Technically the compiler just has to emit the reads to neg and wrap,
> > and can entirely omit the writes to val1 and val2.
> >
> > Does making it volatile fix the warning?
>
> It does for some, but not all:
>
> ../lib/test_ubsan.c: In function 'test_ubsan_out_of_bounds':
> ../lib/test_ubsan.c:115:22: warning: variable 'arr' set but not used [-Wunused-but-set-variable]
>   115 |         volatile int arr[4];
>       |                      ^~~
> ../lib/test_ubsan.c:114:23: warning: variable 'above' set but not used [-Wunused-but-set-variable]
>   114 |         volatile char above[4] = { }; /* Protect surrounding memory. */
>       |                       ^~~~~
> ../lib/test_ubsan.c: In function 'test_ubsan_load_invalid_value':
> ../lib/test_ubsan.c:137:44: warning: variable 'eptr' set but not used [-Wunused-but-set-variable]
>   137 |         enum ubsan_test_enum eval, eval2, *eptr;
>       |                                            ^~~~
> ../lib/test_ubsan.c:136:26: warning: variable 'ptr' set but not used [-Wunused-but-set-variable]
>   136 |         bool val, val2, *ptr;
>       |                          ^~~

Then I'd just combine the compiler flag with switching most of these
variables to volatile so the tests keep working if the compiler
decides to optimize too much.

