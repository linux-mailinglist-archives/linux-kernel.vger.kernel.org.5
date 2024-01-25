Return-Path: <linux-kernel+bounces-39263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C7983CDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CA51F27385
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612381386B6;
	Thu, 25 Jan 2024 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inllMIu8"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FD135A5E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215612; cv=none; b=jUhUMiNsa6qSZmkxgDP70rr91mc+aQXzoca5nlSWnObvhM9vp32dBRROP2KiieJuIr7JDjSScVL3XP5BVy1z91UTK0UrJ/WMGgFeqBCNFM/PE6Hk9BVaTVc5xJxxJadow9JyBclQ9Khml/6mniC3smMDjQ6+ImvJ55hMOnNkLWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215612; c=relaxed/simple;
	bh=ouunYuQuL5e9JirkoCcY+XKKJDTYYnL7iTYoEB+yr0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qA8AH/y/Cl1npAcR7e0XLNg2BIETI5BNOJ6736fDyuNN7+2zSkqk62KvM7mrsmg0xlXJ73ca9XFoHMFUsfznyKcvXUT6H/3v/dvEYyBWsOvGkAHGYN/bCIK8gH3nBm6OxsWWWWcb/BlxwA2x3P3kCcP9B3bbc/b3r5E8uWDx/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inllMIu8; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4bd6a81bbe4so527255e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706215609; x=1706820409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJCIsrO2o9NvHQxNMc03LGFVf6NoDfQO8EJsLkzfJx0=;
        b=inllMIu8HFYT4M4kiZG+LNl2W7MilGUTPVhyBU+ow3xeXd7dTkh2uttcXmpIEy7cyD
         mcuadvSBymclXJTtmT5tRMTPOBcoEqP40DyuGcHa+dvOKkYny180GeRRV+qY0mIXQWje
         MPCk2v37C33/NX8KixV4OAcurcQjwIpw/huh+qeE/C2PiFlfPXhDAXBjS9aooOp75s2N
         k6LhDW7OO1pVDVsqmvqhUvKZgw4bNHkPDQh+P7DozD+RkkGScxte7OHJg5jMHRbkp8Td
         aY1J0Vo22TfabQDytuYZnXezb0JhglIzwDR9eN+VZvHTzQ6/1t+Z7x5xzPcngdTFWirO
         O4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215609; x=1706820409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJCIsrO2o9NvHQxNMc03LGFVf6NoDfQO8EJsLkzfJx0=;
        b=Y35RNdb2rCIE67IjJtJ0DkqMOqluy7RC9Fxwy30YD5wly+WZpAaZDHIZQoOeVb2GfP
         o4ocB0TRxaFXCIqUf2BvNacwk0o9Fpx9UtvkelUbgChLRuu30FEou9dz1TLP1MMZZGQw
         MDzMNf1OnJuG56Fw9fIlTi6LAXcGqCkospI+aPu8QxJGVhyJAh3COH1p/vDd79c2LhaY
         SroRKG2XJMAGlUkTL6s7LfHcj8klSuHKBcwoh/XOACNsPSmekv+29Jh/VxnSBbm+ZhxY
         XuK5zmpLp63isKomHOxJiSbkLvkeWbgW0a41KOIATJQlbTuZfK2R0gNJEmLOwLjb+VKP
         KBGw==
X-Gm-Message-State: AOJu0YxtD6CqJdjBQ7y+y36ZyadbA9yWmnexjQU+KJmxrfFyY59hqy//
	GOKIQn2b6q9xhrgukWl6JfGzZ5/ja6Y1kZN5/u4zvYhFe3Jv3KfyyhJxEg3WqrW+bv9BxJ47xEz
	cmzkUrYI2L0o2ptT/AKX2Dt7pc9328v96KaOa8eejvBTG7NV2AI17l1w=
X-Google-Smtp-Source: AGHT+IHI8Q8dDZexTdG1oWiuWwKZqI7C18nLfjSkoGLgeVlXiyjEX7qqaULmDSBIhQnv0IiiZWJY1/qCHVluRpNXcEk=
X-Received: by 2002:a05:6122:58e:b0:4b6:cde4:5217 with SMTP id
 i14-20020a056122058e00b004b6cde45217mr292246vko.29.1706215608955; Thu, 25 Jan
 2024 12:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com> <20240125112818.2016733-35-ardb+git@google.com>
In-Reply-To: <20240125112818.2016733-35-ardb+git@google.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Thu, 25 Jan 2024 12:46:38 -0800
Message-ID: <CAGdbjmLEsj1cSnxoneSrDy2J2SFenjEdoYa_zoDQQhtU1nccMA@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] x86/sev: Drop inline asm LEA instructions for
 RIP-relative references
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:33=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> The SEV code that may run early is now built with -fPIC and so there is
> no longer a need for explicit RIP-relative references in inline asm,
> given that is what the compiler will emit as well.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/mm/mem_encrypt_identity.c | 37 +++-----------------
>  1 file changed, 5 insertions(+), 32 deletions(-)

snp_cpuid_get_table() in arch/x86/kernel/sev-shared.c (a helper
function to provide the same inline assembly pattern for RIP-relative
references) would also no longer be needed, as all calls to it would
now be made in position-independent code. We can therefore eliminate
the function as part of this commit.

