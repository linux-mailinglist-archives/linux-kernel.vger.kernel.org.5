Return-Path: <linux-kernel+bounces-64613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4537E8540E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6932F1C28220
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0698801;
	Wed, 14 Feb 2024 00:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWc4O9R/"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333AD7493
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707871234; cv=none; b=s3eOjeYxxa9KJPmQ+7T9uAU09UZeNAq4GZkf42yCsgdcGdKJSgvJYGFqUTnDkdW6j/Mb/N2kwP5Na09mogA92tqz23X/vGucdpYc3qbzQnZLaa17ahBWA1zIw0gwc93hNTn7w3X4lnDCFA0+EQBZyF/yYdFtzICVwpyxgWuEsgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707871234; c=relaxed/simple;
	bh=732+Z96bjl+fssXUyJzSLJfOmRgK7uvzPvL/AgukfWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGgXApiAmLi6vY7hrralLWZ/V3R+CwKerJvuWxdUhXCntzUm1UsQdGNiLzbbxlEBHs82APC0taV96Plp3IcBv5RjseYf7LlmRcRtcEr/vmXS5nHZdEwVu4RCuqVSkelESrJ/UPnwEx8oBNVAumlTa+VfEa2h+4EqF48Rimokh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bWc4O9R/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0e521de4eso45381041fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707871230; x=1708476030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odl7g7SmrflKYLXiwuyOjEG83lRHDsTab35r8GfTGWQ=;
        b=bWc4O9R/voPkoZyTgtWKWhNbFdbpEaUnVgiW+31y2nbx+DyQ6E/3m92sM5eV6y85RY
         FjGG5P1CguMgShtGPx41XsNMB/dur98eagDrQ2n70CqMbQ1pEO744+QhUdxlQ/EDP86u
         hzspTN7E6FmicVxoyYjgIZaKkdtg47MA4fxoIjuB5G99t1mQ2c2dmYatcLMzhAruENdW
         vVmgSnHqzq1cIru7FlNvJso9lQHFvUsxqo/NxOAXMjkTdPVj8TsiD0H4weSjbx3Y75qx
         +Uxkt9GtpoDui0gqEFteYQ88DkCdbv1+u3XyBrw4fx29VvA2LtUz8TG29MveHcX+YetL
         DRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707871230; x=1708476030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odl7g7SmrflKYLXiwuyOjEG83lRHDsTab35r8GfTGWQ=;
        b=t24KsrthwOnNUrZKU0LDZxfkZFIcS7GVeRUW9Vfyy0Cp5NgyW26VIgCS5Lt6U3QU6g
         fwsyoDmOmDscUsgxTg5npMa/mUZUwNQrHKuiUQ+HsiTEZDgzMMTv30BCu4BPF0Qqzbn0
         rPPBB67bcCOx03FmNJx74UDJgXlYWSkdJYRtSI5v/+330Yqf8/55VnSbo3VQ8M/5gyoC
         8ubAwypnBAYeIjFdXJOnot3gvf8CAP5+qc+fHPN85BDUswX5l/Bs5d1HeXanrkEOpupJ
         rjaiCqjoKfLfiFVoiDV2qgI2cxBXMpiqQwPNKteSXi2qDj1BC2N0d4eR7oKuDWVhOodU
         pIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNdz3mnmjmD3Beo+pEJ0GpqYP1Sk8LcTMJP4O8OTHxKhxkmf3qADxEjnbV7x8lcht9BzxDSDOz5VyE5ZKe9GiAuCB73F7n3ZCi4mqR
X-Gm-Message-State: AOJu0YwHOXXxEafEAf2wXwa89ssj0xd3Ws23yga4OnFUnCg2c96jJ9Xi
	hELoySh2rK7V6/LBp72C8jVDVQbomHMRrZFFI8z36SVnMtQrJ2rMmnaZE3usCqqNgh2FnV+dDYX
	SNUbpJeqIUhPqcrfrI7d6uZjv+8WznekPQdmz
X-Google-Smtp-Source: AGHT+IHaUEkMIsoH9jlZggCVr/lZg/wX9gXvgpogBKJNvdQOntkz1p+0QQQ+q3X5bOtAgqrr5xeujEeC8XfnyLaucL8=
X-Received: by 2002:a2e:7c06:0:b0:2d0:e36a:6424 with SMTP id
 x6-20020a2e7c06000000b002d0e36a6424mr956016ljc.35.1707871230071; Tue, 13 Feb
 2024 16:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNARaW1V5X79BFW5_YTKY+n+OSp+_ACpRxpiw+VOJ+2hf=g@mail.gmail.com>
 <20240213022552.754830-1-andrewjballance@gmail.com>
In-Reply-To: <20240213022552.754830-1-andrewjballance@gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 13 Feb 2024 16:40:17 -0800
Message-ID: <CAFhGd8o10KWEX=H56kUN0hjY=fowijov0bn+j_kOmv6BPwJ-yw@mail.gmail.com>
Subject: Re: [PATCH v2] gen_compile_commands: fix invalid escape sequence warning
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: masahiroy@kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, nicolas@fjasle.eu, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 12, 2024 at 6:28=E2=80=AFPM Andrew Ballance
<andrewjballance@gmail.com> wrote:
>
> with python 12.1 '\#' results in this warning
>     SyntaxWarning: invalid escape sequence '\#'

Yes, since Python 3.12 escaping invalid characters will result in a
SyntaxWarning.

The complete table of supported escape codes is available here [1].

>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> ---
>  scripts/clang-tools/gen_compile_commands.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-=
tools/gen_compile_commands.py
> index 5dea4479240b..93f64095fda9 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -170,7 +170,7 @@ def process_line(root_directory, command_prefix, file=
_path):
>      # escape the pound sign '#', either as '\#' or '$(pound)' (depending=
 on the
>      # kernel version). The compile_commands.json file is not intereprete=
d
>      # by Make, so this code replaces the escaped version with '#'.
> -    prefix =3D command_prefix.replace('\#', '#').replace('$(pound)', '#'=
)
> +    prefix =3D command_prefix.replace('\\#', '#').replace('$(pound)', '#=
')

I'd personally prefer using a raw string:
-    prefix =3D command_prefix.replace('\#', '#').replace('$(pound)', '#')
+    prefix =3D command_prefix.replace(r'\#', '#').replace('$(pound)', '#')

This makes it clear that a literal backslash followed by a literal
pound sign will be replaced.

>
>      # Return the canonical path, eliminating any symbolic links encounte=
red in the path.
>      abs_path =3D os.path.realpath(os.path.join(root_directory, file_path=
))
> --
> 2.43.0
>

[1]: https://docs.python.org/3/reference/lexical_analysis.html#index-23

Thanks
Justin

