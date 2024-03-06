Return-Path: <linux-kernel+bounces-94261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2585B873C23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F220B2428D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E33313790F;
	Wed,  6 Mar 2024 16:23:47 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75686135403;
	Wed,  6 Mar 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742226; cv=none; b=SgWr/3NrARfwFxfpmIDsxzxFPg072wB9c8EnacF2aXnqvoDtem39FJppsnrP8rv8gDr6FetfFjViy6Ix7naFnHj+hUs6VDQ6uGCdpO0Bt2oh0yeNJiIpgT1IVxg3kDUXFeuOgNa9rlJhXgif+5vS+z/bVj7q1quUnP2NmA2CbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742226; c=relaxed/simple;
	bh=n9KzasEm6N9ttGn6mpPVBfxcCLfd5JbkdxZ4Q6PxRSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvTXBaRseBX1RpNWF6TsdSN63h2U8hYb5Pg+sIKLjJwu5y9K49/qNdvABtZ5jBX7+aDPoAf6Oc8t/s4gjaNNmJX774x03qxswBaqmosGAB3FMQ3stymsIGGHaDDtxGeT1jlMZe4GakvWlFU6TjiStVm2xe4c6Xo+M2Araksmxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so6993103276.2;
        Wed, 06 Mar 2024 08:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709742222; x=1710347022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7JdIeS9zNSJ+HV+qdpk2QYV7GDhHiD75PCrvSyuiH4=;
        b=SZUYhYBo0nx1y7mnzJDmvgNS3wzApvxDVo3+Pah97Mg+DxhDyeIquoe4NzvR+FHzvG
         N6XEiDnssKjwEQfGDr1jtubtcbnHns/aXmDuAg8V6X6Eag+B9LuojEM50P4Ryn9C7rUo
         XsLqVzFpXgItgm4WJeikJ0p+/5JADxahTli/zWoNDGvnuSjVId5kqly0zIfr8JzeTcPM
         GiBwXxgS+G7AzFmwFFtWxoobrHEsx9vInEQJCXCvDHTCDmj5OD4If5GMmrGb5gdKs+ur
         0U5byAU2ZCChyBZxZlwlf+znS1Ef6uyvM17apcHwj5SsC2Wj8FB3hoD6vHQlfbTmrVDU
         nsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZx35nkFHC4N3Uta/v1GkDKiJwR7H29jByrAxfEwKmeUpaps+bMt5KgVWFqPgIymW7XE6m2Jq2fMAcha+feNq/skJmVxssW7pz03DfLPZgBvM30zgt4GOdBnzd0JLWwtahs6Iuztf9vSDFxcf/PSjv3wfSgwOUvcIptcIG86kvn07YkXwgDh+b7DTNljeD6FnqAlyT+qrzmMOZWoCwl09xpM6F4Qb2vAxijA5UgvMbU+xtsp49p+7d+45vUB3YuiyXOoE4Rdn+pj62/HQr6ShIDqSeiFGlClhfyEU2Lz7wnTyaNFmKyxOPkLIGribVUcmAtxHDvpm/C2DEnN0emw2Q4Yae6azLam1MPgGPUenuX7Ekj+al+uZY1DKLM6Su8bOG+NJx+kqgItQ9ioCFwTq7kAEm9DM6Uom9UKR8Wtv5iTB5a/pPRcGq2cyOFSvUpfE=
X-Gm-Message-State: AOJu0YwPmn93DDrOePP1DH7PUNHHQ5LZhnlMhY/mChFpSohDp2lG9eO3
	Oa1fJZWcVUAhNcppbD7ujwekqy1z7b/8pVpilB20fH83rFKzvVdRppiwNDWWHJk=
X-Google-Smtp-Source: AGHT+IGgSdhac2GHHcAzYhActpOED8YvM09CkLEZxG5iaAPw4UkWzA8BzxA7+s1R82Aaz71yF5E/qw==
X-Received: by 2002:a25:1984:0:b0:dcd:23eb:3203 with SMTP id 126-20020a251984000000b00dcd23eb3203mr12281907ybz.38.1709742222214;
        Wed, 06 Mar 2024 08:23:42 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id v15-20020a25848f000000b00dcdc3763d72sm3040524ybk.61.2024.03.06.08.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 08:23:40 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc236729a2bso6516355276.0;
        Wed, 06 Mar 2024 08:23:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBtaP6oQSknzGk2mwEqRxaHMhMn9OU5hlFSBsJ8fElS23hTc1/ScgZvvEQsDAz9ZhnMcPRTLkDNH3TMnJOyYtSRRNkbOnUEzvI1EDL2kZlKvJ5mXDwb7rCj0xjH7UMxcwhR8oHBYrk4ZkwyuPUeFRzSXRKf01p/TlJq6SJnJ8w99VKb2QWWZr2KiQbbJrcu3RsNYZrZQEDUo3z6qEjLEHLYcP7rvB1hu4VaXEEXeuVFYrI3o2N0R5vtYknYe7uPHdSgAJ3moFnR0xBmRpFFgLLzTSFq0D+FUivs45NezzRg6xx/NVcg/8F6TIJRqK1gxzCAnEy/JYPWHgcA8FnoiiZIagHum16xKvvVjOZ4tanas7rhGX8dB2N9tMVDVF5TFuuHlceJh9+NuDFtfWhPIPbDvk9jB9tGtVeaEWoH/W9mTIKAkVWixx8SW05leiCF2g=
X-Received: by 2002:a25:580b:0:b0:dcf:c7ef:e4e0 with SMTP id
 m11-20020a25580b000000b00dcfc7efe4e0mr11968959ybb.1.1709742220242; Wed, 06
 Mar 2024 08:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306141453.3900574-1-arnd@kernel.org> <20240306141453.3900574-4-arnd@kernel.org>
In-Reply-To: <20240306141453.3900574-4-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Mar 2024 17:23:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5ut09=b+5Qti6CD17XOOmsm+VtfA7TKac7qHNOBC2-A@mail.gmail.com>
Message-ID: <CAMuHMdU5ut09=b+5Qti6CD17XOOmsm+VtfA7TKac7qHNOBC2-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch: define CONFIG_PAGE_SIZE_*KB on all architectures
To: Arnd Bergmann <arnd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <keescook@chromium.org>, 
	Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, x86@kernel.org, Max Filippov <jcmvbkbc@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, 
	Stafford Horne <shorne@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 3:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most architectures only support a single hardcoded page size. In order
> to ensure that each one of these sets the corresponding Kconfig symbols,
> change over the PAGE_SHIFT definition to the common one and allow
> only the hardware page size to be selected.
>
> Acked-by: Guo Ren <guoren@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Acked-by: Stafford Horne <shorne@gmail.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> No changes from v1

>  arch/m68k/Kconfig                  | 3 +++
>  arch/m68k/Kconfig.cpu              | 2 ++
>  arch/m68k/include/asm/page.h       | 6 +-----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

