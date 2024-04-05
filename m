Return-Path: <linux-kernel+bounces-132577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9394C8996C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA422833DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349F13D272;
	Fri,  5 Apr 2024 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okUN6yzJ"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E613CFBF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303062; cv=none; b=IqFwF7ZUwqjquVstBP54wtN8xeUlsBB57E/0prlJHrCHgjg20nGu8OeVVMGAY/sFqpPeS6+kOLomb1CFlyob4tQE/N0CGG4oyNb6O8y3PPwNev4wyEy/LTeOcq+9rrM07XUphm15Oi+esvEP3P7ujtMvu6IlES2F12XQniy8QeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303062; c=relaxed/simple;
	bh=SHGbtYE78WACdauHUN0T3sz6l7y4v0ZFIs1aCPJUAfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcmJJvvufslToR1XXF+7Hy6pTCsva8FCDICyEAq50+bhfeNcJS73Du3PrPZvVOJm3YW4Qhiha7jvz8wWg8uvTafSyfINUY0k7NAAlnI4Zaw9AhWwveXw3K6YIqrO7UNptZ1l3ad6TWE24IVSbgA/Eg1Rn9V7DLz/jqJO8/FwXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okUN6yzJ; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7e3e522d803so1235523241.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712303059; x=1712907859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHGbtYE78WACdauHUN0T3sz6l7y4v0ZFIs1aCPJUAfs=;
        b=okUN6yzJEqwBDFZGJZL0LcADDUilMBNKJN8H7jWZR05NbtB4cpOanmzpMjHANSONZV
         99U6ofHCD42rVReWS4zc6lFac32qpV0ihfRwWZSZQLTKqiSDg9DEL10UKYMMrWzPGeK3
         EeauzsP/2fK3E7GeMPc1E+qRrnLULQ4XRqUPaPTvrKlw48pac09Mn9K75w7k4z61uKoV
         TsOWZo2DND3gVyfh50eMzslQXDWlLaXrEAhA12adDuRbzCiU5aaQ9jFE9RkX8Q8dt7CV
         eY4Iy7ZAm/LpmJz4w2mZuePUZbVwFSgmhyeMGh2RixH5ki2R7qlfUBhkuHHVTJws9j+N
         B+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712303059; x=1712907859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHGbtYE78WACdauHUN0T3sz6l7y4v0ZFIs1aCPJUAfs=;
        b=h3xtLYNrqGVioKrgAlnYXoOiF/hN/J+xjtiIrwE2V2aDAZ9WB6y/GrB5yI7wD2LcA/
         2sujNKFQ7kXFeH6wEHrg685iWwBPpygp6aAV6SR39CTa0vADbF3gOfaXYB9hLshTjuQn
         Tbrou5CMWJezxpzUu2F6ox428TZ9DdJcxdleVluyzu+a+wp+tcotKljBKgojK/nhpLoD
         0PEOs2myI6Jj7TsJEqgQITFnn/GqYd1Alt+et7rgvq9daBFctJ0CSjozV6Mj4+Lo3GVO
         D2FBPXg6akf4MaqItQ7/9wxXEmfTsUivdisqanfnoxuFABxSnl8G6IJYUvK64Je4EZun
         ujow==
X-Forwarded-Encrypted: i=1; AJvYcCXTLLBfx+eXgb/hjFSl41i4xEPS0O1G/VxBMoNt4Kvttx4OzUFJ297xyciWDts6tvd4POw52KO9/LiU8fhClxxhQadiACgQ+xWEJwxV
X-Gm-Message-State: AOJu0YyT3pxjz5pZp6uen14drKZfPNZTbqi+oHlv2AqlNau9AT9xUBY8
	UpQPzD/Ire113GMcBMfiDF0jfojt/a0pHTfBIGl4W8ly1MqrhD7/0PWQuQhjrJLPIQXYXINYL89
	gA51GMp7HsQkIFEI5JzFUab2H6xASZVMDJ5bC
X-Google-Smtp-Source: AGHT+IGMeMqrXZ0hb7q26iSJbPXd6dY3rpQtcLC3/bDQAURqKv3BShFGpUtYoVqS9r2ldERtJ0iVFeg0BVc9I60Wl/c=
X-Received: by 2002:a05:6102:512c:b0:479:c401:824 with SMTP id
 bm44-20020a056102512c00b00479c4010824mr1516533vsb.6.1712303059454; Fri, 05
 Apr 2024 00:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-alice-mm-v4-0-49a84242cf02@google.com>
 <20240404-alice-mm-v4-4-49a84242cf02@google.com> <a48b2347-b58b-432e-bdb8-d5449016ab57@proton.me>
In-Reply-To: <a48b2347-b58b-432e-bdb8-d5449016ab57@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 5 Apr 2024 09:44:06 +0200
Message-ID: <CAH5fLgg3wpcDE+n6nd0CGtDzyXSrD2nLhY8RxdTHjAD8hQ9VDQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] rust: add abstraction for `struct page`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 12:33=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 04.04.24 14:31, Alice Ryhl wrote:
> > +/// A bitwise shift for the page size.
> > +#[allow(clippy::unnecessary_cast)]
>
> Why can't you remove the cast?

Bindgen could decide to use a different type in the future or on
different platforms.

Alice

