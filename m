Return-Path: <linux-kernel+bounces-104871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C94487D4D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D41B21E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0F5535B9;
	Fri, 15 Mar 2024 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQdUdC0S"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B4E1F19A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710533674; cv=none; b=jFWVqTENdM1o04jbd95B4odhRNL7qDDnG0Z31rFnEHBJV25XAb5y1HWgTQ8ePoug3uYcbNIorApFA+53XZMmpzpm38Eq15tc1mBEqAWAfIBrf0Q5D7F/6wV+aFyeX1l6im94uScC7C5jbrqRYLsH8CIe5umAhdXpY4ZHe9JHzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710533674; c=relaxed/simple;
	bh=y1BTYZXLc0pjmzbXa+mfMIir4aip9V/TivPImo1c/VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KotUsqweK6ACWcx45OE3uThqq6qTDDZjOJRk4zOT6uz1SuNsGIfjeky+b+jZ0ks+OCi53z1Xw0kgWWbICPGQ1/q0hRGXuPov07Wz7t5ML+RkrpurWj93fcc2vz/E3VshV3JrtNURjZyfbpBB3uXfwioFMi1EkFYDW1pwiBy6NgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jQdUdC0S; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so334a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710533669; x=1711138469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjN4sGS750eWboC8w29xo5TO2+i7icdu7hvgKDpNx8w=;
        b=jQdUdC0S63hFWMsCr5Bdb+9d1tN5IavTXrXROqWRDxoZsh3UsmvJkVzrGhhEXCl46f
         myxdFAG0FpUBlv4aLpSPJs5irOMnOvQu5q8dqtQ9EdrfqwhGBADe+vhbagbMtdHbHtxE
         MtUXlOIWWfvf3qRD8yXXKt7G51eij1Gsn2VecIhU4rbGVwlPN6iVIn6/62sdExvwdGmH
         GCA94t9CsTYkl1O5lQKsgKWOglLy1xcLboTL8RPpBwpgXNamld5SikMoK3HjHIUS0SNg
         T/v3uF1QcIcFfYVMtuhet65bQeePGpT2DKmfuFRomFHy+WJNK5ia5DzV7Y3ksUfdt3YF
         L4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710533669; x=1711138469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjN4sGS750eWboC8w29xo5TO2+i7icdu7hvgKDpNx8w=;
        b=kiAB+jsfE1OyMtLgOh9hfqLbMDUrExTQhSHbDT7wuNkt3GpUwdbxHanp3RYuXaGQAw
         HRC/1fGOc52z9b9WMgM4IRIcCS6ZBFyiW5QVx9YyoFBDGoL66+BenANNM3LM+MDfORyN
         Fkmrs4YCtgXZdf+ON1jsECgJlsVQLI7bmVINtJQaTcLZsXwHjav4zIqSRxiebNGsxR6s
         vw7DFhbGZa6t2mj00ZGzFArC5g45k+15fna2u/z1DyfO27muOjMFit31FuC+EqTWWyax
         LoUDarPjehS0tynQg0tslmar+hequp86Dn2YgtrjGcVNowRpZZTTeLVMLK7UbRh2YvKz
         i7KA==
X-Forwarded-Encrypted: i=1; AJvYcCVarxxecYI1R/cz9CIBSB16/jHuvnTNUiY3aZqyh/OQg1WmENc3LkwPMmQMA5GhbLX7Odg9wuNvz3CgHI5V5TPoZpxOxxGTnHz4Etx/
X-Gm-Message-State: AOJu0YxKf8H2FRUBFCIblmyqsnhOAz2k6nTteOz5vFyd8ef0tyF2kKoR
	giDUexstHgpa1mS3xDAGTqD0doKZ/YiprHZxRhTWV3HdBdhmrT87JB5fu35hiss1FI1OSVmAY4H
	r5TU87xUqRkk6gDob6ngaAPQ6aqkJkZlWURU=
X-Google-Smtp-Source: AGHT+IE/YLoz0wFB/AdPNemdkai2WeDZkSxuMDauynHrgL3l4ZXHXI17FWnDpmKh+BBz03z+kIqLGQUpWDojUT8GUEY=
X-Received: by 2002:aa7:d74c:0:b0:568:b6de:4904 with SMTP id
 a12-20020aa7d74c000000b00568b6de4904mr144849eds.5.1710533669330; Fri, 15 Mar
 2024 13:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-snprintf-checkpatch-v3-1-a451e7664306@google.com>
In-Reply-To: <20240315-snprintf-checkpatch-v3-1-a451e7664306@google.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 15 Mar 2024 13:14:11 -0700
Message-ID: <CAGG=3QUKdEB9nw=Gxppewww1tzC=hcry1UnZ-j28=RU1KWFm7A@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add check for snprintf to scnprintf
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 1:09=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> I am going to quote Lee Jones who has been doing some snprintf ->
> scnprintf refactorings:
>
> "There is a general misunderstanding amongst engineers that
> {v}snprintf() returns the length of the data *actually* encoded into the
> destination array.  However, as per the C99 standard {v}snprintf()
> really returns the length of the data that *would have been* written if
> there were enough space for it.  This misunderstanding has led to
> buffer-overruns in the past.  It's generally considered safer to use the
> {v}scnprintf() variants in their place (or even sprintf() in simple
> cases).  So let's do that."
>
> To help prevent new instances of snprintf() from popping up, let's add a
> check to checkpatch.pl.
>
> Suggested-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v3:
> - fix indentation
> - add reference link (https://github.com/KSPP/linux/issues/105) (thanks J=
oe)
> - Link to v2: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v2-1=
-9baeb59dae30@google.com
>
> Changes in v2:
> - Had a vim moment and deleted a character before sending the patch.
> - Replaced the character :)
> - Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1-1=
-3ac5025b5961@google.com
> ---
> From a discussion here [1].
>
> [1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@lin=
ux-m68k.org/
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..69dfb7412014 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7012,6 +7012,12 @@ sub process {
>                              "Prefer strscpy, strscpy_pad, or __nonstring=
 over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr=
);
>                 }
>
> +# snprintf uses that should likely be {v}scnprintf
> +               if ($line =3D~ /\bsnprintf\s*\(\s*/) {

Should this check for the 'vsnprintf' variant as well?

-bw

> +                       WARN("SNPRINTF",
> +                            "Prefer scnprintf over snprintf - see: https=
://github.com/KSPP/linux/issues/105\n" . $herecurr);
> +               }
> +
>  # ethtool_sprintf uses that should likely be ethtool_puts
>                 if ($line =3D~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$=
FuncArg\s*\)/) {
>                         if (WARN("PREFER_ETHTOOL_PUTS",
>
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240221-snprintf-checkpatch-a864ed67ebd0
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
>

