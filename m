Return-Path: <linux-kernel+bounces-64611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5DF8540DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B7DB25D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709175398;
	Wed, 14 Feb 2024 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRJlIXXf"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4954683
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870720; cv=none; b=uhi8x5i7nC5cV2AIYr9F+2bjoy1gwkrkC38B1H5gOlJHx98XatB7rLnBUYzSjg1Zm5GWr86xyOqav5jgHxtRzeTH2Ywf5wIv6GaoOLY5RPDaSYMY0szluJiOvKiLiE5ABw8FNu0J9bjTkf7FYAOsAN1dA2LRRaEe273VsvFjWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870720; c=relaxed/simple;
	bh=QOITHjTga42hAflI40Ipbts+6T7yutOW1a81G6BTQgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/4Gp9gDNrnRmpYWw/L5NPvOH+jgM84G6vh7gtjpnzKrqnue7Cxf4yhBxdplAbcP5Opa2FidjFapD5Me0WODCa8a5Hl8qwXs5yxsHkOZY1mgX/n8kcMNKiu/ilooIQ9hc4DJu5BCaJ1EAyrzxO8NlFm3p7JNOxZUA3qOwZhu03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRJlIXXf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so7849729a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707870716; x=1708475516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTLJH4nKUhzssrfYYFDWlc0Q3VkrPFVldyClGOqfMTE=;
        b=SRJlIXXf/Uj1C1NQiizJ+lTzl63+/AVQ95vJ0U21y5bAEkD95fd9AVFcvIoqBLHoxO
         /KD54Pc0wZ1pjyHX/4U+vCDuMXtrUXagm+7tpQxwcSms8fCOlbUWR+6sjLkvw+G7DSBr
         JYNWIoULnqgUD1YwhBgAheUCI7ZLX/rVPvU8H5v3GHn0+9thoZiudqyTGzsX3TTF7xhX
         cAWtNo9oS7Dp0gtrR1NFwloTvG/IW4WQLNR3Ri380IVxTWaI6xdaUFXy7Z2Wb6fSEy7q
         Fk+G4ioIT8K53VIqDhRquk2x3yeRa4eoFiKukWe5j8GdmEfIvBweEY8LbbWURe5Yu1hg
         /3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707870716; x=1708475516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTLJH4nKUhzssrfYYFDWlc0Q3VkrPFVldyClGOqfMTE=;
        b=MSHhFjhobRhvsJmXipOqRAs7uplhGMoxp4c2Ym6SL5MvRNwyfNl6xAo27Kvk0M+FBX
         ypUIuVKBreFUKMDlp87zgp9snx5LI8Mwi+ioxYjSAXSyWtzuy2D8IC1VUpjjUmU0pc3w
         cIM/zU8jfpJA0thkM2jGGbWRrLI1sRbhhxrYcJKfVsFQhpj41a5Vs+d8eDnpuz7ksG71
         yJ3OegTjRVMzQQteoAkcKXiSldcDMJAjipBSVlJm5FPJArxvvPwNwEJBmxMwuIgU6kyZ
         Fyle6xqmkgjFJKB8AmF5ucVEypdzRNRpkSsX/idcapbF+2yV46roUdewB6M0TXc8ktYG
         yYjg==
X-Forwarded-Encrypted: i=1; AJvYcCXxvm1b1vx0i48O0Rojahtzvr+pwxqDGfG4nId0WmA/dEoBxxITNt9z9/eyrx1gT9Wt8Ml21HZ+hnISW7KmnWxDhSTu4hmETC8wrA8u
X-Gm-Message-State: AOJu0YxzpsvZlRdkkj4wUVzpd8q6weC8UW19MPkvsxzFWjH9W3k2M8uH
	T7dtB6FVZ64mdAmemLLrhmNS/L4h46Y86SkWFMofP6Jz1nQ+F6t+VPrM2Zrn79TgpcvH6A5HfXT
	4oK6uBXc1Qfp5C87VnIcy7NjrIEqn4wnYK7OM
X-Google-Smtp-Source: AGHT+IEtxrlAsAa9Q4ABaPzKYYZ7PeY703iUnusW6WDgntH1FFpPpJ1MY7i6BNKNdf7i4Duf3v/vA4f6NUFZRLDsZTM=
X-Received: by 2002:aa7:d3c9:0:b0:561:123f:a98f with SMTP id
 o9-20020aa7d3c9000000b00561123fa98fmr694626edr.24.1707870715624; Tue, 13 Feb
 2024 16:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNARaW1V5X79BFW5_YTKY+n+OSp+_ACpRxpiw+VOJ+2hf=g@mail.gmail.com>
 <20240213022552.754830-1-andrewjballance@gmail.com> <ZcvKQ3SpLNR9RfIe@bergen.fjasle.eu>
In-Reply-To: <ZcvKQ3SpLNR9RfIe@bergen.fjasle.eu>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 13 Feb 2024 16:31:42 -0800
Message-ID: <CAFhGd8pvhzehMGh1XEHBct7CGEQuF0CZeneMH3D6cKSRj5UdHQ@mail.gmail.com>
Subject: Re: [PATCH v2] gen_compile_commands: fix invalid escape sequence warning
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: Andrew Ballance <andrewjballance@gmail.com>, masahiroy@kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, morbo@google.com, 
	nathan@kernel.org, ndesaulniers@google.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:00=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu>=
 wrote:
>
> On Mon 12 Feb 2024 20:25:52 GMT, Andrew Ballance wrote:
> > with python 12.1 '\#' results in this warning
>
> funny typo: it's Python 3.12 :)

They probably meant Python 3.12.1 and forgot the "3." (or had a vim
moment resulting in its unfortunate removal)

>
> Kind regards,
> Nicolas
>
>
> >     SyntaxWarning: invalid escape sequence '\#'
> >
> > Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> > ---
> >  scripts/clang-tools/gen_compile_commands.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clan=
g-tools/gen_compile_commands.py
> > index 5dea4479240b..93f64095fda9 100755
> > --- a/scripts/clang-tools/gen_compile_commands.py
> > +++ b/scripts/clang-tools/gen_compile_commands.py
> > @@ -170,7 +170,7 @@ def process_line(root_directory, command_prefix, fi=
le_path):
> >      # escape the pound sign '#', either as '\#' or '$(pound)' (dependi=
ng on the
> >      # kernel version). The compile_commands.json file is not interepre=
ted
> >      # by Make, so this code replaces the escaped version with '#'.
> > -    prefix =3D command_prefix.replace('\#', '#').replace('$(pound)', '=
#')
> > +    prefix =3D command_prefix.replace('\\#', '#').replace('$(pound)', =
'#')
> >
> >      # Return the canonical path, eliminating any symbolic links encoun=
tered in the path.
> >      abs_path =3D os.path.realpath(os.path.join(root_directory, file_pa=
th))
> > --
> > 2.43.0
> >
>
> --
> Nicolas Schier
>
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --

