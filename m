Return-Path: <linux-kernel+bounces-12777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF9A81F9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8781C22C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F74F514;
	Thu, 28 Dec 2023 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCBJpB99"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2EF4EC;
	Thu, 28 Dec 2023 16:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5878EC433C7;
	Thu, 28 Dec 2023 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703781183;
	bh=A+mzjJV1MkOOSr8necrae1hjEHXB1nVIyk8vFPzU0nA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SCBJpB99wRNQ+/edSWU3WqaeGIEYBYXUSOq7sxS+Zg7b/jxPNOa6LK168C7z5bL1+
	 9+1ueqsEiK/JBTEaJ0fqJbQjKwXa9JSuraS0AJKnGFzc9Ft2crt/YurjmbL53M0/4W
	 yHireEXNLJ2YeBHk50vy7GmBsdLHArTXi2VgYx41h9X9gi1jhfgbhdAADG5ryf+HiC
	 liAtXO65YNBnp+mYZVxgBMrYyELjEH3wet97JxrvpQVZLeQ10TFeWZXN+2eEQJTGYH
	 tuSdJ6waitWR9KHaSQDn5x0VtJanNgdNuuH9sjpPBnHvp2BfDBrQOFZ2PNUxBYBTyW
	 b28BH5pjodTrw==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bb53e20a43so4998768b6e.1;
        Thu, 28 Dec 2023 08:33:03 -0800 (PST)
X-Gm-Message-State: AOJu0YyQBMT/1LG1T5bmCpMoDIGsZ6REv2GW/x+XK/a4xtw5qKGHzzbp
	cglCMc5aP1MXVKNvkRd6DIuydFKZLcUqc9I9/5Y=
X-Google-Smtp-Source: AGHT+IEwVAqEAY2zVVKUCNFM2uKjg3iPJqET6eMA57hGwnm7iBUSRA4nRqkzc0VdUepNe7mQr/WBrZTr1xOAACRYgHY=
X-Received: by 2002:a05:6870:c112:b0:204:20cb:8cd7 with SMTP id
 f18-20020a056870c11200b0020420cb8cd7mr12469373oad.103.1703781182663; Thu, 28
 Dec 2023 08:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZY1Pk61PP5HvLDag@p100>
In-Reply-To: <ZY1Pk61PP5HvLDag@p100>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 29 Dec 2023 01:32:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmQSB-ZhQf6FyhK0Y7y6J91pVGN5NF2=FjUE9vJLkDCg@mail.gmail.com>
Message-ID: <CAK7LNATmQSB-ZhQf6FyhK0Y7y6J91pVGN5NF2=FjUE9vJLkDCg@mail.gmail.com>
Subject: Re: [PATCH] linux/export: Ensure natural alignment of kcrctab array
To: Helge Deller <deller@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 7:36=E2=80=AFPM Helge Deller <deller@kernel.org> wr=
ote:
>
> The ___kcrctab section holds an array of 32-bit CRC values.
> Add a .balign 4 to tell the linker the correct memory alignment.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: f3304ecd7f06 ("linux/export: use inline assembler to populate symb=
ol CRCs")
> Link: https://lore.kernel.org/r/CAK7LNAT5gyn0C9EJhh1EeFT7gF0rOudWcdqAVN=
=3D+C4jR42W90w@mail.gmail.com/



Applied to linux-kbuild/fixes.
Thanks!





> diff --git a/include/linux/export-internal.h b/include/linux/export-inter=
nal.h
> index 69501e0ec239..51b8cf3f60ef 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -61,6 +61,7 @@
>
>  #define SYMBOL_CRC(sym, crc, sec)   \
>         asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""     "\n" \
> +           ".balign 4"                                         "\n" \
>             "__crc_" #sym ":"                                   "\n" \
>             ".long " #crc                                       "\n" \
>             ".previous"                                         "\n")



--=20
Best Regards
Masahiro Yamada

