Return-Path: <linux-kernel+bounces-83557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687A8869B61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45BF285AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51317146910;
	Tue, 27 Feb 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbtFR3yS"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D51468F1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049425; cv=none; b=UNAxh3FQ1YLY4kMpI/DOvPRO832Jbhc5iIIwUi8h4HRT7gBs2xDzSYuoU0v3229piUnwumP6tYccHqOzlfy0UK06Yx0eVa2hrVD3hMVEbSoFusdeB1kZ/KDaRz0uMCsTrlxX717UwoGykccIQuTF3bQuiJf6JshbeZIdL2Sp6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049425; c=relaxed/simple;
	bh=T8GmRBHe54nbmuaPkv00EKb3E1ieTIbnwEGf8I18sXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NA6M0setqe50vrvCzgIXMAVPOCnlIwGv8jy5VyB1ndFRwanFQ2QIHF2Ky2IvWRz3TE7LY1rK0Yjdepe5f9PKl5/02TrGKa1tK8hmgMebRM3giz/4/1i5uOaaC/RssASsFqgsxEwJerDuZ4oTvLXBy7/bt54aTzY6Aw8UpydKkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbtFR3yS; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47048ea1b17so536413137.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709049423; x=1709654223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zz63I5jGJam9ziTsehsBfrmLZXVDff45p8Sdh7Rb40k=;
        b=jbtFR3ySdR2r1CYCDZrNEI1eSFVDrOtIVvMc+mFCzmBcA42twZojGMt6JqTBIYO46R
         ythFyksTfqlHsfx6rkSf/NadLNff2gvVeJMLHPuJN+9y04c6OmWtbPAWiJJyOz+lZZmy
         ZQ4Svi5lkV7blL1xJUWpuBEmhSEqqzRXhr8UAJ58SCmcoM/DuHGr+1FWRfb8D6upyhHe
         3Qoyz7BGeZJYPmA/mSj5y8ZSIanwrwZ2MULJWm2vGxECIpwtGpsbLpSFiCZ7w1DeyOiO
         t9BuODeTeLALNY8YmO8r74/9TC0ajRsy4F3vFCfbacBEln0Zl71gWMQfC75RwCFF6gra
         Qkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049423; x=1709654223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz63I5jGJam9ziTsehsBfrmLZXVDff45p8Sdh7Rb40k=;
        b=PKAqmejEoN3lslorUAc9ewKnkJA5sHhJpA0TX4II0tsctIiHODUV3whIOKkZiKldTB
         csWWGgFc9MDgGQrqLNYZDxQOGko9l7ZRkxgf5L/8xMfamk298r/7+EBC9XB9ZH3CuYyA
         ewMZMNwQW6nuJk7Xc4CjfKZn8tWDPSaY+oMuEFKiMU9Rpko0KU/nEqf7pkxz0Qk6tDeR
         Eb2Onv/ypqt0eWiXU+T6DrqQw4J5quNqpxEhXDafjLRTiXtFjgWUf5hIhV7UN79jQ3fA
         fuc2kGBj+V/AsmOItc91PBwsYq4HxCu6PiUiumEeaFz4gH/nmPOx7s2y0+J6FgkRwKHA
         5FPA==
X-Forwarded-Encrypted: i=1; AJvYcCXr4PekP5qucQzMyANZ1QalMhoGzoWAicdgrFA8alMNyqqbTouGlxFsdiMUamU7W6teYZR8mhNT2/tT/JZll2Bnasp/3fIXiO6qg09k
X-Gm-Message-State: AOJu0YzfsxqnASuMX29SCPNJ6k8hKSwCfaNKpDThmdtxKK23zsEoTcDJ
	etzWHy710z/9Y2GAH87arncgAtnSHZV2k+9BeOSNUn6dyGe4z9d4j41aPDjVxMtsFW17kyBFEgv
	/5KYpxW78q43+CPLU/evKFnm6CscPQ4rZM4ac
X-Google-Smtp-Source: AGHT+IGb864B0KCLFtT9j0TGLsO0nGGyrgue73owoa/PB+tubylZra+Dcxo08UFSc/HUH0+ETPHEEz5iBt94o4W0Cnk=
X-Received: by 2002:a05:6102:f12:b0:470:3eff:e755 with SMTP id
 v18-20020a0561020f1200b004703effe755mr9887738vss.24.1709049422611; Tue, 27
 Feb 2024 07:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
 <20240208-alice-mm-v2-4-d821250204a6@google.com> <Zd4Bp6ohjb7H9poA@casper.infradead.org>
In-Reply-To: <Zd4Bp6ohjb7H9poA@casper.infradead.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 27 Feb 2024 16:56:51 +0100
Message-ID: <CAH5fLggmaemG8EJamSy6oEDneZAWhJWJ7OrcbG52rdrdukyaxA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rust: add abstraction for `struct page`
To: Matthew Wilcox <willy@infradead.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:37=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Feb 08, 2024 at 03:47:54PM +0000, Alice Ryhl wrote:
> > +impl Page {
> > +    /// Allocates a new page.
> > +    pub fn new() -> Result<Self, AllocError> {
> > +        // SAFETY: These are the correct arguments to allocate a singl=
e page.
> > +        let page =3D unsafe {
> > +            bindings::alloc_pages(
> > +                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings=
::__GFP_HIGHMEM,
>
> I thought I raised this last time, but this is over-specialised for
> Binder's purposes.  Many places that want to allocate a page want
> different GFP flags from this; they shouldn't even be the default flags.
> So either what you're defining here is a BinderPage, or new() needs
> to take GFP flags.

Ah, yeah, sorry. I never got around to figuring that out.

I can change it to take GFP flags.

Thank you for taking another look!
Alice

