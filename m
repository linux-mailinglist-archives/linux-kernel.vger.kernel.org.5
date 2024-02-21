Return-Path: <linux-kernel+bounces-75593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8E485EBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7C31C22899
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41759128808;
	Wed, 21 Feb 2024 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CC42Iebv"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293F12837C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553609; cv=none; b=NJkxPMAHHS9y9P2uC9LOlT0QkwoiK6vJIkA4ATfirM3PKpnIxYCp66EVMm8XDIJVKRDZuZWtu/p+7XC/qn+DSssLKG5c9L2H+aZw0HHnQX4q4NCwhA1HVqSmfln0NIdDIRHSyeWnGPsGUp/N3Uye6XXFhnhqhg/0LnwAAe7Vupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553609; c=relaxed/simple;
	bh=9hg4ljWhbMxM26mrW5JK2oxtbOcxNnG3OBsmEApOFmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPF4XKkM7BbC/qy2laqeRktzh0f6ypLf1EphB+bpSDQk8iyHUWkuu/fgG0kTm/AUbNAbdMB0LxbEdnR1s6S+KlP1lPGg/gfao+9ZLUIqOQt0qnUwnwo4csVoZGSbaMT4T69uz07TBjM8LXLMJFS2WrQ77pXMrUFGj5PlqB3WRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CC42Iebv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso1382175a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708553601; x=1709158401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfbuRjkNALu/kNaGNH8dl3lJtOSzdqqz7XS1RFNencY=;
        b=CC42Iebv6OKRbec5mCmp5OTeDu+rMvMIafBW8H7dPV4AJA9q2WaJI/z24J8KTlZap5
         pGWoAGjoCJVq8BaWy/ZDXKmHNO5SRrFh3/KNV4jOlBB2CBAz1mUtAJk2cGfaQFpaw8qJ
         +jKdZQHTwMvU//Ai57v3jGUB0QDTb3IQaJCX41/w1bkTlWBJ45/mOnoBco/1wijupyG1
         ZWKKTPeXSeAbztE/ABVwTUVgZpqAufd8zmPo5xI5L80r0xv0iGRU1GRd602DbL+jA8O8
         WMmDI6e+84e9ta5lRMKY0ahmXzSf/pn+9POMINr2uGxutrjA5HSil9qRbu/+quvbwbkq
         DEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553601; x=1709158401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfbuRjkNALu/kNaGNH8dl3lJtOSzdqqz7XS1RFNencY=;
        b=EaHjxIDnfHOxRz7ydnKspSsN+LF23cvJmwlfLMGsVyT0qM8vmaOjx/FFnKn4HNPwj5
         N9Zy0CzS6eGITLfcni0ifioW9tw2u1nX2NdNWYm+J+MjQHbI02aJ490zW60FHFWG/v41
         IjCsUcR6BKur50Rp2G30UcIzX/1qqw7KsD+leNHL1w1x3f9xHQoK8pUhsLRwokWpAVE1
         NSG7rV7ovKLbhqX4DypTfLvdv955h0AiPVUd6YWqfGLRvSflVymJhSzcroW9mH9EgJwG
         qfgpWWUH2SPm5asMmiBfaWFBzzQmmtPwGBJ/HhmWl46j2tysQmqVZ3dNMHC8kC5rCtdG
         rA2A==
X-Gm-Message-State: AOJu0YyRPNYkH3+K/4abdygMkOEHjWuZiLX3BhLzUNnU6lzxaQksmuEv
	nK4LwlGHLmtB7lsoAKvuv8kcd7R1EZQ5/sG/4P12B3WbdfbQP2BZJoBHeIg9dzc9SZU24XewnbU
	VSqJ+apyVoAKYHsynknw+DBU4gdrs5RMmPR1f
X-Google-Smtp-Source: AGHT+IHtCDTQuwKXVaaVB+TFF0/BgLTDic3wf3VHQMwJmIRqqIFanvbjSRQRreYPOw/KbmNXqNEAJoY29b/oG7qQuYU=
X-Received: by 2002:aa7:ccda:0:b0:565:25c5:5d91 with SMTP id
 y26-20020aa7ccda000000b0056525c55d91mr421910edt.4.1708553601064; Wed, 21 Feb
 2024 14:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com>
In-Reply-To: <20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 21 Feb 2024 14:13:08 -0800
Message-ID: <CAFhGd8qU_xvo6kwxzmHXz=Sx4rFQWaXY5XNDbMqfbHjmbtKK5w@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add check for snprintf to scnprintf
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:05=E2=80=AFPM Justin Stitt <justinstitt@google.co=
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
> From a discussion here [1].
>
> [1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@lin=
ux-m68k.org/
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..bb4e99c818a9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7012,6 +7012,12 @@ sub process {
>                              "Prefer strscpy, strscpy_pad, or __nonstring=
 over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr=
);
>                 }
>
> +# snprintf uses that should likely be {v}scnprintf
> +               if ($line =3D~ /\snprintf\s*\(\s*/) {
> +                               WARN("SNPRINTF",
> +                                    "Prefer scnprintf over snprintf\n" .=
 $herecurr);

Whoops, I dropped the \b with some poor vim skills.

v2 is up.

[v2]: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v2-1-9baeb59da=
e30@google.com

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

