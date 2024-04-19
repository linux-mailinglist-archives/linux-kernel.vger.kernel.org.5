Return-Path: <linux-kernel+bounces-151500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A368AAFAE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58D51C21410
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4EE12C819;
	Fri, 19 Apr 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuKAH9fo"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027FA59;
	Fri, 19 Apr 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534469; cv=none; b=Mf9cHlVgTophYblGBhMjGMKxG7uPUZeEx3Y7iRFYsPK4k0ycXEEDCNvjXpM+Mp6MHSlrFSglbkxnp7zxADYvYmRW+jAbKk6jsXiLtIX5ZL46hvKDkStlm8a56dVjOcxHjHnlucpcXgio8QhOjvounS82BhtAOE1MUm9xFMjr76A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534469; c=relaxed/simple;
	bh=7t/9G7xb4CIJYOZHsfANKwbLN6ZfLsMJCoRjLg+TNgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ul2TEAq3o1E6QlT4GfBQCYMU3IU33e65YZzewY0ZuXQCnaauY443+/92aZ8N5pURsM8gZYeSkLo4RLL5t+mJT7v6jCU9HcYId5iGCNwZaxA/dZajNMBNOrBeXpcAo7jKHxfewtXtrm9BDjOMIFR+pHH1uFqQoIlk09rGLUHl6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuKAH9fo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a55323f2ef9so247929066b.1;
        Fri, 19 Apr 2024 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713534465; x=1714139265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw+LAbHXzENBty9Qv/cdMIi07xjBtDcGEnhBj5qMQZ0=;
        b=JuKAH9foLW0Qeu8EQU1ArbZ4o+objD6VHHtGiwy3zPw/83bhyZk8paWnr8SScyd2Nd
         hyTX6+q/nDmUhv1G2EydSzCpz9ZnUp8PRlzfc3esvYo9hQndRRGWBn63ztfVNSEhOfU+
         xuoTztc5CFXIHNJPFTQd5WI2HNIy4iQXgQPPZrA1ZF5Kid+AjiCpa91V9N2/7SVyvUXP
         fil92W2BuPkq2OBkZORcqvUF1RhHWh53hgmkuLwoYOkzgv9vzvZjVSIqXByJ6gW3Xdp4
         Itq79U2NtfbkTBVLz131IGNV8aTN4aBqC7H9aPMTquE7ykx9B+4rc7KgCDfrb7EzDxc6
         pvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534465; x=1714139265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw+LAbHXzENBty9Qv/cdMIi07xjBtDcGEnhBj5qMQZ0=;
        b=WcjhpuAYqPVeincgXtCGISCc9+NWHZANdbpeqvMPZ3LFBEYuRnYBlHlcdqhCttGUZA
         om9chYmKmIvoSe5eM/7NRM486G3jAh6k4y1M8rJQjQKovXFU4IPnqcZywR0EvbRAlMWu
         Ey6HfX7BSdpXIL7tyJcP4evBBQWOX9G5lnpbGiVHIrYscp6J7vPx0SbgcKJ3Gvn8ULjg
         tIeNZwZ0a3G8D5MjYgeyz+xxoLT4xE8iiHGE3Jjld/BGamGVvx+q8OyfrWO2F05sjXbt
         K0dxBOCN2jcE1/AAY0TufgRH5/56Rcgo6WM8gB8Qa6tKcevgoeToARPTvSo9WR0q4dWa
         IQuA==
X-Forwarded-Encrypted: i=1; AJvYcCWixtyI0jZSTj9UBj6/IIOcVKSVr7EFXuCuuRpKbpaKe3bhTdR7yf5/VmpednEIxtewtMLR5qOEIODgSO6yNCayV4GhbdVCioQOmdGJTJdSwh4smqLUCcx0gU8qyH16moKXcw/yGmu15b3ZUWqgrGSnzLqye1j6k9mQlHUndQ6m+Q8sRLn6NQ==
X-Gm-Message-State: AOJu0YwEgUwdqg5Od9gV2pRhb8o6rQLgR/JIlCRTkvB5TMExC6G5qSUR
	lmlIjdifHwK7sHGv80pDYYoJGG7wtHEwgcYVPUG2AVs12dGRW3f1wPnz2b9OdXYzRpPaPoW2+T6
	sxtjc8+YDzLoJXn2pAiIGFGJFJKg=
X-Google-Smtp-Source: AGHT+IF4BaBHnNRPBwlqtjlPr2pi8ZujC09NvQVWslSb3woGPjhNvKFBX5YAr0MZ4IQsJo5Cq65T2/CkExfx+ICn38g=
X-Received: by 2002:a17:907:3e1a:b0:a55:8c0b:bc00 with SMTP id
 hp26-20020a1709073e1a00b00a558c0bbc00mr1118441ejc.62.1713534465533; Fri, 19
 Apr 2024 06:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419124506.1531035-1-rilian.la.te@ya.ru> <20240419124506.1531035-3-rilian.la.te@ya.ru>
 <7fc1a557-205e-481c-a1c6-3e0a37f7a7bc@kernel.org>
In-Reply-To: <7fc1a557-205e-481c-a1c6-3e0a37f7a7bc@kernel.org>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Fri, 19 Apr 2024 16:49:50 +0300
Message-ID: <CAF1WSuxUZCQNMAdjWUyhG=RV2a8t48NSm9ryoSpd=NTZ3rEEmA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, Vladimir Zapolskiy <vz@mleia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:32=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/04/2024 14:45, Konstantin Pugin wrote:
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > Add EXAR XR20M1172 UART compatible line into devicetree documentation.
> >
> > Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> > Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.ya
>
> This is fourth change, no cover letter, no changelog. Patch is trivial
> but you do not make it easier to understand what is happening here.
>
> Please provide proper changelog under ---.
>
> (If you wrote changelog somewhere else and then decided not to send it
> to us, it is like there was no changelog. I literally do not have it in
> my inbox).
>
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>
> ---
>
> This is an automated instruction, just in case, because many review tags
> are being ignored. If you know the process, you can skip it (please do
> not feel offended by me posting it here - no bad intentions intended).
> If you do not know the process, here is a short explanation:
>
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/su=
bmitting-patches.rst#L577
>
> Best regards,
> Krzysztof
>

I am sorry, I used git send-email, and send all 3 patches and cover
letter. I do not know why it was not ended up in your mailbox.
Link to all patches (version 4)
https://lore.kernel.org/linux-serial/20240419124506.1531035-1-rilian.la.te@=
ya.ru/.

Here is a git send-email log for cover letter:

```
$ git send-email v4*.patch --cc-cmd=3D'./scripts/get_maintainer.pl
--norolestats v4-0001-serial-sc16is7xx-announce-support-of-SER_RS485_RT.pat=
ch'
v4-0000-cover-letter.patch
v4-0001-serial-sc16is7xx-announce-support-of-SER_RS485_RT.patch
v4-0002-dt-bindings-sc16is7xx-Add-compatible-line-for-XR2.patch
v4-0003-serial-sc16is7xx-add-support-for-EXAR-XR20M1172-U.patch
To whom should the emails be sent (if anyone)?
Message-ID to be used as In-Reply-To for the first email (if any)?
(mbox) Adding cc: Konstantin Pugin <ria.freelander@gmail.com> from
line 'From: Konstantin Pugin <ria.freelander@gmail.com>'
/scripts/get_maintainer.pl: file 'v4-0000-cover-letter.patch' doesn't
appear to be a patch.  Add -f to options?
(cc-cmd) Adding cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
from: './scripts/get_maintainer.pl --norolestats
v4-0001-serial-sc16is7xx-announce-support-of-SER_RS485_RT.patch'
(cc-cmd) Adding cc: Jiri Slaby <jirislaby@kernel.org> from:
'./scripts/get_maintainer.pl --norolestats
v4-0001-serial-sc16is7xx-announce-support-of-SER_RS485_RT.patch'
(cc-cmd) Adding cc: Hugo Villeneuve <hvilleneuve@dimonoff.com> from:
'./scripts/get_maintainer.pl --norolestats
v4-0001-serial-sc16is7xx-announce-support-of-SER_RS485_RT.patch'
(cc-cmd) Adding cc: Andy Shevchenko
<andriy.shevchenko@linux.intel.com> from: './scripts/get_maintainer.pl
--norolestats v4-0001-serial-sc16is7xx-announce-support-of-SER_RS485_RT.pat=
ch'
(cc-cmd) Adding cc: Lech Perczak <lech.perczak@camlingroup.com> from:
'./scripts/get_maintainer.pl --norolestats
v4-0001-serial-sc16is7xx-announce-support-of-SER_RS485_RT.patch'
(cc-cmd) Adding cc: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D
<ilpo.jarvinen@linux.intel.com> from: './scripts/get_maintainer.pl
--norolestats v4-0001-serial-sc16is7xx-announce-support-of-SER_RS485_RT.pat=
ch'
(cc-cmd) Adding cc: Thomas Gleixner <tglx@linutronix.de> from:
'./scripts/get_maintainer.pl --norolestats
v4-0001-serial-sc16is7xx-announce-support-of-SER_RS485_RT.patch'
(cc-cmd) Adding cc: linux-kernel@vger.kernel.org from:
'./scripts/get_maintainer.pl --norolestats
v4-0001-serial-sc16is7xx-announce-support-of-SER_RS485_RT.patch'
(cc-cmd) Adding cc: linux-serial@vger.kernel.org from:
'./scripts/get_maintainer.pl --norolestats
v4-0001-serial-sc16is7xx-announce-support-of-SER_RS485_RT.patch'

From: Konstantin Pugin <rilian.la.te@ya.ru>
To:
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
       Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
       Jiri Slaby <jirislaby@kernel.org>,
       Hugo Villeneuve <hvilleneuve@dimonoff.com>,
       Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
       Lech Perczak <lech.perczak@camlingroup.com>,
       =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.inte=
l.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: [PATCH v4 0/3] add support for EXAR XR20M1172 UART
Date: Fri, 19 Apr 2024 15:45:00 +0300
Message-Id: <20240419124506.1531035-1-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

   The Cc list above has been expanded by additional
   addresses found in the patch commit message. By default
   send-email prompts before sending whenever this occurs.
   This behavior is controlled by the sendemail.confirm
   configuration setting.

   For additional information, run 'git send-email --help'.
   To retain the current behavior, but squelch this message,
   run 'git config --global sendemail.confirm auto'.

Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll):
OK. Log says:
Server: smtp.yandex.ru
MAIL FROM:<rilian.la.te@ya.ru>
RCPT TO:<ria.freelander@gmail.com>
RCPT TO:<gregkh@linuxfoundation.org>
RCPT TO:<jirislaby@kernel.org>
RCPT TO:<hvilleneuve@dimonoff.com>
RCPT TO:<andriy.shevchenko@linux.intel.com>
RCPT TO:<lech.perczak@camlingroup.com>
RCPT TO:<ilpo.jarvinen@linux.intel.com>
RCPT TO:<tglx@linutronix.de>
RCPT TO:<linux-kernel@vger.kernel.org>
RCPT TO:<linux-serial@vger.kernel.org>
From: Konstantin Pugin <rilian.la.te@ya.ru>
To:
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
       Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
       Jiri Slaby <jirislaby@kernel.org>,
       Hugo Villeneuve <hvilleneuve@dimonoff.com>,
       Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
       Lech Perczak <lech.perczak@camlingroup.com>,
       =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.inte=
l.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: [PATCH v4 0/3] add support for EXAR XR20M1172 UART
Date: Fri, 19 Apr 2024 15:45:00 +0300
Message-Id: <20240419124506.1531035-1-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: 250

```

