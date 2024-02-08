Return-Path: <linux-kernel+bounces-58296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC4484E42C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6942D28D842
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040D87C6EF;
	Thu,  8 Feb 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xj7Fog8K"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F47C0A9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406926; cv=none; b=CJfZGinl46l+k8+nJJ9i0Vq+6nYaAukiXoBvFZ4Qb9HlKKuHq00YieO5MaPRfDlRuDPfb8mLgAfDW4OmApfTDhGsYaKkvUjbfz+b+zG12fVzPljFkqzH+xxgiEkRKGiuq02hlxCswexfRepSuxqB1v6inwpYv1iu9eueWllub4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406926; c=relaxed/simple;
	bh=v6RY+HoEygcidTXsOrNnjWIcKG3qK9XPgGRFowXNBO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UK1I1iRGiRyDu1Dak6SXLVOGdx0QP8DbeFnp+mX4++c6C+ng7IDkrfznYsB4hKBDINcPAftP+rmPtMDNdCD5HaaFNMAD8Heua0/7pf2cyPvPI9ZqWK4oplGETMtnuWllqJtPxbr3mRtnCdmABF6L84CLYL9iTwEt7Rp3eKVIMe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xj7Fog8K; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5c25267deso662853241.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707406923; x=1708011723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKbb7p+kOEnvs7kyPggNgED1EnVbkGfw9/eZmIaWcyE=;
        b=Xj7Fog8KLhAkpp4/Wc0oFlzrFGiLSRpvC2L/Qe6bPM6ziqFhO7ZUPgIMdKTMkHD22q
         meEcowHCsedGQRnNLzcTCQl0e1Iqu6O2fmeWikOTxnTqo//rRMpaA7F9D3lvoxPn6ENH
         M5YnbTQH1fzwtWayIaG4W6znLb1h5KRLrMLyFQASLVN4ubmpGIStkDi0rYoyNPR+jHXM
         AOTvQcw/lR2TKGjkbOQShpuBHjRMunSSVII356dXolVKu3/YcC9zUGfpUYFl6sEI9c6O
         wAZa9mmR5IbNJd3ytw7BUhmqicN+tleXvmcSInJfCuD7/B1DldCA5WTgS1MMvTzpNcEd
         ZY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707406923; x=1708011723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKbb7p+kOEnvs7kyPggNgED1EnVbkGfw9/eZmIaWcyE=;
        b=lRiTp7A/ltyNwqMt5R3EN6UZL3S37takR9/JvCou2MQkvn115R+za8RlCqHwzyN5Ep
         RuJfToHotEd2gxih7u0LvNmnjj2HacgN6fcBo7HhPCjYYuTjmayIVb+d7kFVFztjxSFq
         uNF7IO7RT8GZCZG7EuyPdW+yqqHsco7D6dqC5zNGDrl+QeiWhbcZqVIT1P6MHPF9KMih
         TyXJIx7WeYNUqjUMrKQZ7kJUnucC67QlLIyObPfHs4Sm06Dcxh53Qgw89Ah+uYqocz55
         K2cOmd76v5IfrQFXAVi2s+55PvS2lB4ChDkuXHPec6xwT9Vz11bjcM9E6q6JgTOzZNaD
         jQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCWgs6jYtRIFM5D7gF6wxEfHyUUTHEjPPJ3ofLmM6GVahZn+fl5sOLHIpdI6z9I0FS7VAdLjxGiX04sUPxYd27W+rZ3MwyxenbPkLtOK
X-Gm-Message-State: AOJu0YzCAj2qDJEwNmvOLHnXbrkaPX/gJTA+TIw3PJCvS23nWjTgtBlP
	SVd6kuDJpV3LR+ZdmdhZihZcGN6xssumsSw0I0JZLY5BriI4iRuqva5YEe3+gxZnBlGZD+b2JnN
	dULTnaJU2oh5a3ZJL0at0qgyZmxjjg/FHkDBv
X-Google-Smtp-Source: AGHT+IFDyVSM20AAZOqwIyb4b9dBSIPLnDvdeUdFq1ivHCsKm3z9RezCwd1Tr99hv7eVqI+4NfGUBzCublWFJ7MsYRg=
X-Received: by 2002:a67:bd07:0:b0:46d:20a8:cb4e with SMTP id
 y7-20020a67bd07000000b0046d20a8cb4emr5871603vsq.26.1707406923533; Thu, 08 Feb
 2024 07:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-1-d1abcec83c44@google.com> <CALNs47uDaD05oD8TtZoSqUBc4SaRig80u2_1P0qMCXtE3H9_Vw@mail.gmail.com>
 <CAH5fLggdwWoq4wKv7VxZ-_VbWMV_Ui03rGOCMPbWn8=ewznmvA@mail.gmail.com> <2024020859-lusty-ladylike-29d4@gregkh>
In-Reply-To: <2024020859-lusty-ladylike-29d4@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 8 Feb 2024 16:41:52 +0100
Message-ID: <CAH5fLgikdGGdjEUxyMWjkfHbRmvtMavwHFDwRC+4GVt46qmHWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: add userspace pointers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 4:35=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 08, 2024 at 01:53:20PM +0100, Alice Ryhl wrote:
> > > Is some sort of `Debug` implementation useful?
> >
> > Leaking pointer addresses in logs is frowned upon in the kernel, so I
> > don't think we should include that.
>
> s/frowned upon/forbidden/ :)

:)

> Along those lines, you all are tieing in the "I want to print a pointer,
> so hash it properly before I do so" logic from rust like we have in c,
> right?  Ideally you'd use the same logic if at all possible.
>
> If not, that probably needs to be done so that you don't accidentally
> start leaking things.

I don't know what the status of this is. For anything I've added, I've
just made it entirely impossible to print addresses, hashed or not.

Alice

