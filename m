Return-Path: <linux-kernel+bounces-36352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC5839F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1C51F2D9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F06E54C;
	Wed, 24 Jan 2024 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZCmIym+K"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2398DDC8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064266; cv=none; b=KPKgkgxO/uH6f+T0yOy0kwyMGeBZzUWvRHArySt24nux9WyPA/y2vdY1SrcDeHPRaFADL0nqe5FcEYKKzCmN+Ef092lHB4MkRQr8SqV22NrrkRBjgwht9zYSjq8SrZNs1vkOdgGWvFqKRUiDubr57h4Qu4sTf0KYz+rxM+lY2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064266; c=relaxed/simple;
	bh=rNUR1SYxqrRvZRyxRd5ftK3ZDd51xT67VN8gmDWwmW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGbUaYLeffBx3i4igj3gaICt9MFQVa6aSVY4KntkSbX0anohxwMBnO7fWkHF9l2z5zBAzTeSPCn3NCGBD4b3vhUFVVUxjEh26xeFqfju/hkttDzmC0jqXZ5AHqsf4CtWyfI3xG14pg5SESe9VVpZW8trkCVGaMQXwOJxZX06Qk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZCmIym+K; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbc649c275so1854362b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706064264; x=1706669064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLStPRDEUuipPewqlBuPtKmABGx0U3Grm+aWQKSFKf8=;
        b=ZCmIym+KXmUdERZzh55UIFilSVESharYMAFSnpe1Kj4e9l4psgpGcF3rd7cvlvFjDF
         rDUIwe+6rFGx8mCZ3TBa7FbT+5hjAz8i46EX4FobnTOZIyH75ftyMZs3BoJM+B5ndf0c
         HELQ3Opl2rQD5m64Lv8boI7eMc3UxRLXuKmnVjJkinS5HTyHJEXpAUP3Dm6ai3v11MQw
         3ERruIW8gTWOF6ZBeV9xD95RoUzjkyICq8AThOpQa2WfkNFjKwf4W5cZX2QCQwPWKO8r
         rME/cD42JYflYWKpUrJ6yn+suRXyn/h2uTzDXOEfZvnKjvw4ogSjmIyW6gjuCIrLRUWe
         HkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706064264; x=1706669064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLStPRDEUuipPewqlBuPtKmABGx0U3Grm+aWQKSFKf8=;
        b=G6OKwhN3gLASQh1gRZmE5gWuxjdYmzXAZs9ghqm1gH8H9y57GMWD98WxmgmXlxnA/D
         R3J92AueCQwKnYhZn430kX7Q0cH93Suvl66zaFAvs8jI13USgcy8imIG4kGUnxeC2jTY
         tIEXMDDCHtoVR2Kbfu0iToUZPbAWuV7bMM+0dE5F6RMdNwgXVdIiC4oCmalBgqeOYVt/
         HgSlvkxG7lY9+MibQrOtiU0NM5CJjQkpDJW44oPLEuhWEU1X8iAEGUfkZztQ4AtGixY3
         WvZWrDJYBteVe9Qd7OpF5QjioH/4VyDpo4fd53Tgskztji6v0Hg9TtVDz/47OGjnifyt
         WEtQ==
X-Gm-Message-State: AOJu0YwIz33IEeU2AGMMxlInnUgTZsGE8PAMfhcCNeKiMQUmXOa4pM3l
	fRL+hzgbmwayVLMkjr9D31+oU44rcVmdTuKIo4vV1gueNcgjb+IKZLmSaLrDjGlZZvpsr23Wpc2
	abZ2goFurwMmFle5NjoOeDtBD0Qrb31aFtRHuOA==
X-Google-Smtp-Source: AGHT+IFqvahBMjknexU3UQEvvfPE6ZUeOFepSNYttsSFqeDVjZXoJr47EtHe5S11okcMDhN0dF7pfISUrhdsjk24sFQ=
X-Received: by 2002:a05:6870:a90c:b0:206:c95d:fcc5 with SMTP id
 eq12-20020a056870a90c00b00206c95dfcc5mr2297811oab.108.1706064263853; Tue, 23
 Jan 2024 18:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123132730.2297719-1-alexghiti@rivosinc.com>
In-Reply-To: <20240123132730.2297719-1-alexghiti@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 24 Jan 2024 10:44:12 +0800
Message-ID: <CAEEQ3wk5edUFTuE3H3KDGkCXj0+=i7Z1BM2M+6X-Tk9_m8X_iQ@mail.gmail.com>
Subject: Re: [External] [PATCH] riscv: Fix wrong size passed to local_flush_tlb_range_asid()
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dennis Zhou <dennis@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Tue, Jan 23, 2024 at 9:31=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
com> wrote:
>
> local_flush_tlb_range_asid() takes the size as argument, not the end of
> the range to flush, so fix this by computing the size from the end and
> the start of the range.
>
> Fixes: 7a92fc8b4d20 ("mm: Introduce flush_cache_vmap_early()")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/tlbflush.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 8d12b26f5ac3..9619965f6501 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -68,7 +68,7 @@ static inline void local_flush_tlb_range_asid(unsigned =
long start,
>
>  void local_flush_tlb_kernel_range(unsigned long start, unsigned long end=
)
>  {
> -       local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_AS=
ID);
> +       local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_T=
LB_NO_ASID);
>  }

What makes me curious is that this patch has not been tested?
BTW, It is best to keep the parameter order of all functions in
tlbflush.c consistent: cpumask, start, size, stride, asid.

Thanks,
Yunhui

