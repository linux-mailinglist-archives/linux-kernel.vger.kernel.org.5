Return-Path: <linux-kernel+bounces-43629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAED8416DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFF61F24357
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C015AAD9;
	Mon, 29 Jan 2024 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA99iofV"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F3953E07;
	Mon, 29 Jan 2024 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570875; cv=none; b=LgBzN4yKbMIXu09mkZWjoT4P4nYfwM0XXaYVUkzTCm2uwNL4BbukWWt7IzGOd7VnRbMh6IbfS3o/hmPLvTwis8VchfJfbdb5SSvvcVfmd1P2fWY7XeHd47ly0efM4BI9BEFGbpfsldg13pP8wza22b/927OaxgRY8NAiamrPjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570875; c=relaxed/simple;
	bh=3Pt714EDmayM4zkRpb5UifHBwFnv78h5YDgjEbc+yA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUKLZ9wIAibgivDrmA3f3cCl4OqupoC3FqGpegmxMT9qHIOJdtXA0xEuBMvIsyT4ozSPwdq0XQKboZf6/nf5GXquV/Iv/YKI8zGEUarwKdMiC/hbT/n6k2oRn5n1SaSBxAknMKomeUlf9wPLepaaDWogZ/LdNpcAvLAZPhNWDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA99iofV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso1745756a12.1;
        Mon, 29 Jan 2024 15:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706570871; x=1707175671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAI+JSpOXFqVCsrvmgOXq5QLcioKgV/OWGsLJV6sfpk=;
        b=eA99iofVubPc5ABYE8BSdQgzzhixm9C1BY2UvSvUpPXSTEYWi2ca3+uEWyNMX5XuxI
         TWTjM2zuduEIe6883yCSXU3uKATA2yUhwK/z1hmVG2Bmjn7N3PazawR6jisWADydmzg1
         IfoqOkExPsb2vIJ9t+urC59BV3eBbO+OklRA3rXZSExfaXSO72hsMFZFie1rE6zO7+r2
         naJQ4yiu8fxazWxyo40+3GDjXi7hkAO3BLnZCHjOsJP6bdP1hOBE7ogK72xVn1JpX0SZ
         KZqyMkHDUmt+P95WSONvBjKJAhYV0bv+kAsXiThMgE8hCTsoxnqOrLvgSOqe6P5vRuZW
         vLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570871; x=1707175671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAI+JSpOXFqVCsrvmgOXq5QLcioKgV/OWGsLJV6sfpk=;
        b=RsI1JSngc7YhB+7kKnXdU6bqrr8yNwVutghfE8O5zEGsxQfe211WZJu80PmbGt6zVv
         17QeKuqdR+DhQgtwmiEnvh2T4d2UIksBaZXg9HI1zwGk+TGGleItT/WJ9/g3/KWdSRIy
         fF5MGUST5X5vY1swYYkSkrlykFFxCN6OJN1W6Le8Q8U26TCKpowIbXZKCKkYSlyehf9u
         Qq9vVwvVISc01mIFS3VXtXaFE2YdYdWhJsGb0IfYPrbVOJnh8DqiKhA+1fikrGzuBKEq
         R1XqGnl4Dkaklnled3m5mrE8lOwzzBM8aKmriC7s18n0WERHTwWDMvQJXSjl9w3MhgwT
         VTpg==
X-Gm-Message-State: AOJu0Yxjg//oAceqCTKBRbfQBNId5VxZ4IQxA6eYQw1yqXfQklBHF9hC
	iG+EnSPq4DFgavHCVOk+vHy0Jpv/ZvBIdqfMlWdUxT6aUARzXXN8MfqpDJO6DoN/WaJiK57oPTt
	PwNMUZQLsPl1P/HMmWFJOtLDyHyg=
X-Google-Smtp-Source: AGHT+IFFPqMyjENNeSUz1jQ9nFYpfkJ5coLhQ0OTwVYnTDYpL7xBJaq+dz9oraLl18FWdogovYmEV6qKsbB2KHq3ryg=
X-Received: by 2002:a17:907:a4c1:b0:a35:bd6a:60bf with SMTP id
 vq1-20020a170907a4c100b00a35bd6a60bfmr44153ejc.17.1706570871376; Mon, 29 Jan
 2024 15:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129202901.work.282-kees@kernel.org> <20240129215525.4uxchtrywzzsrauc@google.com>
 <202401291357.DAA9670F3@keescook>
In-Reply-To: <202401291357.DAA9670F3@keescook>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2024 01:27:14 +0200
Message-ID: <CAHp75VfgmLoACfjphHi30hSkL0Sa1AueFeG=qGQvwnewqyjrRg@mail.gmail.com>
Subject: Re: [RFC] string: Allow 2-argument strscpy()
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Andy Shevchenko <andy@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 12:03=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
> On Mon, Jan 29, 2024 at 09:55:25PM +0000, Justin Stitt wrote:
> > On Mon, Jan 29, 2024 at 12:29:04PM -0800, Kees Cook wrote:

..

> > BTW, this hack for function overloading is insane. Never really looked =
into
> > it before.
>
> It very much is. :P Hence the RFC nature of this patch. I don't think we
> any any other API in the kernel that does this (though there are plenty
> of wild macro wrappers to do similar tricks, like the syscall wrappers).

PCI has a couple of such.

> > I like this, though, should you include documentation changes/additions=
?
>
> Yeah, though I'm not sure how to do this -- kerndoc expects a fixed
> number of arguments. :P Maybe I can just do something like add
> "optional" to @size:

Use ... See again PCI header (pci.h). One of the macros there has a
valid kernel-doc.

>  * strscpy - Copy a C-string into a sized buffer
>  * @p: Where to copy the string to
>  * @q: Where to copy the string from
>  * @size: Size of destination buffer (optional)


--=20
With Best Regards,
Andy Shevchenko

