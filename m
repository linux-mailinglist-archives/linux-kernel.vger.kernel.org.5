Return-Path: <linux-kernel+bounces-34633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2477838572
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896A429181E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5714F567F;
	Tue, 23 Jan 2024 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn/MxDQm"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3C1FB2;
	Tue, 23 Jan 2024 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705976668; cv=none; b=pUdOP4gioeQl51+f5AVZavcyVuU/jF6HAhL2Nl5S/LOBgsHbnRYbTOX3zhpuyJ8y6PrEEzmzKr9ptLPETWVKqyX4GSasWoW/NSESZ6z0U071zhhS4jG31lX0BPh0iD9BgV/KK8eHv9mxQ0mLrmfgkO4TczJc4yj5I1/iNnZiNSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705976668; c=relaxed/simple;
	bh=JpLyWnNjAbZijVmS7FvtjpdHKaRYNF4q3guoZRuW/3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxOcdFrceNuyckzD3UYzrnwgqRkCR63qiSZTHd0sSeHfAeLBZ7rsaedqdDU4IVYrF2QRrYmMMRMWwuLALvr7cTFd6cLTo+akvjr3uz4yT+zKvwFbjn3AmZ9tvB3b/kwX7N0ngJ7pUYqjKT+Lte17YoDaH+GL5umwgewdWEt6eTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn/MxDQm; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ffb528dc8dso18199857b3.1;
        Mon, 22 Jan 2024 18:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705976666; x=1706581466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfZDEtG54xzX28Ty/2ZvVAS2C5pIV77WvIG0X10672I=;
        b=Tn/MxDQmDkO7WI/j8EThySlHELdBDaOol/kZv//wPlqtsqfYCKWApY2hZhSlMtxezQ
         wgkJiwMHbQlA+DbGN9Rm5buNbYBE+bDoitalW/O3Yczca8fWk/aGPviECvV9PG5NTOa5
         Q8zlJbLmqm5nophVM2HnkVPWck1PMw8KKgvPtv/tfrC2grZmWImMjYJwNqSJj268ozjM
         0n2lcLh+D4NZrReqpR4LCiCKUzO9wnAstBdwlOrDqNruGBo071c+0LO6kIYCuyTp/FOM
         MZPCQpxspTuqG7iWgFMPe39N763IWpv4cpZtx7XmuHBpSWETtFnKae3++B9NTHMxKK8Z
         zgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705976666; x=1706581466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfZDEtG54xzX28Ty/2ZvVAS2C5pIV77WvIG0X10672I=;
        b=Ipct87Vqz3n3m0iqtsnTOzUgwExVWzwsLOSKdqd7tbN5dUVdENPlDNbLLC9TeXcmOd
         N835tIJrpU1sE8zRu8IuX4kSUL87k+ZsWrh7O8fosbnyiGUNk5UMS5DoRPLOV1tRkWg8
         4wTp6mNZNFy9QLWf/s/gJicJVtOclsDqxFuPH2gf3pQNRqYlsqK9a1K+r9Vo+ydU0BI9
         1ed/cMpAwpxJv7u4xh30NuvcwR+RkDOTKoR36TGyCYiOk3sEqk8pSzfgn/xXMUSPWB0q
         ZyNgWDp40TfN5YCiCM7+tEoIRIKsXSimGp1n/zZbpmPOjNeAwhU/0N72OMEtzqciAdez
         BevA==
X-Gm-Message-State: AOJu0YzUYcOXzrp8OyGneLWb2UCODLxTHopNJyvvYPThA2uCuvwabYOy
	igkvBp6u4U6TKdMC78e7T4krAuPoS9LhdYaPrrQD6ppITCd7ua+qdMLDd2RFVzTCy5PIgY9RC5p
	KmFNtm3muGGJDzF2jx3RlEo/ahXg=
X-Google-Smtp-Source: AGHT+IFNDeZ5OtHCmzud+kwQ0qkVIFCuFaequeVZSLn+rX2vchnjBOJxVdccTfZhI8NPlfSFCpHmxhYrDfAKzVqxmaI=
X-Received: by 2002:a81:8a45:0:b0:5ff:96b6:a14c with SMTP id
 a66-20020a818a45000000b005ff96b6a14cmr4205779ywg.17.1705976666206; Mon, 22
 Jan 2024 18:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-6-keescook@chromium.org>
In-Reply-To: <20240123002814.1396804-6-keescook@chromium.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Jan 2024 03:24:14 +0100
Message-ID: <CANiq72kWTu_1YcmSP=1sB6CmrdbQcksxFvLci6VC2u8_Bb-Exw@mail.gmail.com>
Subject: Re: [PATCH 06/82] overflow: Reintroduce signed and unsigned overflow sanitizers
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Marco Elver <elver@google.com>, Hao Luo <haoluo@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 1:28=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> Because the kernel is built with -fno-strict-overflow, signed and pointer
> arithmetic is defined to always wrap around instead of "overflowing"
> (which would either be elided due to being undefined behavior or would
> wrap around, which led to very weird bugs in the kernel).

By elided I guess you also mean assumed to not happen and thus the
usual chain-of-logic magic?

> So, the config options are added back as CONFIG_UBSAN_SIGNED_WRAP and
> CONFIG_UBSAN_UNSIGNED_WRAP. Since the kernel has several places that
> explicitly depend on wrap-around behavior (e.g. counters, atomics, etc),
> also introduce the __signed_wrap and __unsigned_wrap function attributes
> for annotating functions where wrapping is expected and should not
> be caught. This will allow us to distinguish in the kernel between
> intentional and unintentional cases of arithmetic wrap-around.

Sounds good -- it seems to go in the direction of Rust, i.e. to have a
way to mark expected wrap-arounds so that we can start catching the
unintended ones.

> +       depends on !COMPILE_TEST
> +       depends on $(cc-option,-fsanitize=3Dsigned-integer-overflow)

Maybe this line goes above the other, to be consistent with the
unsigned case? (or the other way around)

> +       depends on !X86_32 # avoid excessive stack usage on x86-32/clang
> +       depends on !COMPILE_TEST
> +       help
> +         This option enables -fsanitize=3Dunsigned-integer-overflow whic=
h checks
> +         for wrap-around of any arithmetic operations with unsigned inte=
gers. This
> +         currently causes x86 to fail to boot.

Is it related to the excessive stack usage? In that case, users would
not reach the point to see this description, right? If so, I guess it
could be removed from the `help` and moved into the comment above or
similar.

> +static void test_ubsan_sub_overflow(void)
> +{
> +       volatile int val =3D INT_MIN;
> +       volatile unsigned int uval =3D 0;
> +       volatile int val2 =3D 2;

In the other tests you use a constant instead of `val2`, I am curious
if there is a reason for it?

Thanks!

Cheers,
Miguel

