Return-Path: <linux-kernel+bounces-72167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D7685B041
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBD21F2275C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED05810785;
	Tue, 20 Feb 2024 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsLLgewJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D22DDB6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391533; cv=none; b=Sn93ihCqjt5p1hmyjj95O/yr+ML9FWHvhJBOxobBKyK6leZCcr7iqEDR1sg0dWMFa+a0ildIwslJASJpFloEzLyVAUQhDCrxdlqC9yymlwUjZQN6il6oh5L4s+3dUQEdZENOPB4tHEdizVLPp00ukN0HRJJ3ZIbeuu6YwYodDWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391533; c=relaxed/simple;
	bh=WSFWszHnqQ0WnZCFOLYWkT6gnqW8Ii4nog/ORGkVIAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwWWmCQAjmxqhIhCmXLtKz10Dn/q8oelff4yxDON+wauLKnjA6b1QsrZdF/YAwXoXfcxxZOKsToOR53+5W89s0w+Gb7qVd8ufW7GfEspeUYfeVqa6d2D/i9I+CRbt1zpeaqWSa8PsP5FiYbh+j9hpiYOuTOD4aQUFZmKC/jTeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsLLgewJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D56C43394
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708391532;
	bh=WSFWszHnqQ0WnZCFOLYWkT6gnqW8Ii4nog/ORGkVIAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GsLLgewJcX7xmC9iwtGWItU2wDmFuh8Qx4XbdQCp6K0ZQ/ylwFGanLVOtN4XOu/cp
	 2+TTjLwcRRwl+Y8n6WMB5SgIuqj3J3mqmMzvIE9GsSzQyh3R3jKv0XUsGuNJKywPRY
	 4SKtNynsq5XtNl28yQ3ty6AXtnfJRcndn1qzcDeuqGpsDwZ6HZLCdhweeJj3z6RTtc
	 knXXFcB706KQq8TwLwOimODMeoqf8rP9HVwugb3wVFynB+UNiTy30txUtWUfoWCxwx
	 Iv9LXf2DSp5UCrvaXpO6oGb2ARguHliFGJDqr0CeVEWwNDlljh6kvb8LlnBWIrWfMS
	 RGLwoL8+LCJ7Q==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3d01a9a9a2so473220766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:12:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWw7LhWwWuKMt93QAgbi2uaRf3Tlf0Y4XVY4pCO7fXrPVK5eVrTb5Y63uUDYVsHjapttJWj8UQVQMnhNhkmelni9dAY1H93qmixK7HL
X-Gm-Message-State: AOJu0YyeI75Lbk80V+OduUmMielcArZepEfNp7CON8yZLOZQwPjxsGfe
	+CrsxVbAyKWhHtMaNKBgX9Co4/PDJKcNjYSwNQvGU3hF0ED1pe7+R/8Zmrw9p5ksmK8sWOC3irR
	duaz1WpOepWHtPkegrsACA4hZbtE=
X-Google-Smtp-Source: AGHT+IHUVyM4dMnO6EVihhkRqtv5mZv1aY4mDLTlUemHh2d6Bgwy6CKPkDxzE3dFHXm8lgQhM9IEEFFFkPU6EacOuYI=
X-Received: by 2002:a17:906:c41:b0:a3e:96f4:492e with SMTP id
 t1-20020a1709060c4100b00a3e96f4492emr2529778ejf.31.1708391531067; Mon, 19 Feb
 2024 17:12:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_594131AD216D8DE97CCC8265DA5D8E45B808@qq.com>
In-Reply-To: <tencent_594131AD216D8DE97CCC8265DA5D8E45B808@qq.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 20 Feb 2024 09:11:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTW_bBwWAfNhiUNXpseg44fd_+=3j4NjCaqryzWN_194A@mail.gmail.com>
Message-ID: <CAJF2gTTW_bBwWAfNhiUNXpseg44fd_+=3j4NjCaqryzWN_194A@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: fix NOCACHE_THEAD does not set bit[61] correctly
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:33=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wro=
te:
>
> Previous commit dbfbda3bd6bf("riscv: mm: update T-Head memory type
> definitions") missed a `<` for bit shifting, result in bit[61] does not s=
et
> in _PAGE_NOCACHE_THEAD and leaves bit[0] set instead. This patch get this
> fixed.
>
> Link: https://lore.kernel.org/linux-riscv/20230912072510.2510-1-jszhang@k=
ernel.org/ [1]
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/include/asm/pgtable-64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm=
/pgtable-64.h
> index b42017d76924..b99bd66107a6 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -136,7 +136,7 @@ enum napot_cont_order {
>   * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareab=
le, Non-trustable
>   */
>  #define _PAGE_PMA_THEAD                ((1UL << 62) | (1UL << 61) | (1UL=
 << 60))
> -#define _PAGE_NOCACHE_THEAD    ((1UL < 61) | (1UL << 60))
> +#define _PAGE_NOCACHE_THEAD    ((1UL << 61) | (1UL << 60))
>  #define _PAGE_IO_THEAD         ((1UL << 63) | (1UL << 60))
>  #define _PAGE_MTMASK_THEAD     (_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL =
<< 59))
>
> --
> 2.43.0
>

Oh, my genius. Thank you very much.

Reviewed-by: Guo Ren <guoren@kernel.org>

It's for bufferable signal, so that is why it does not affect the hardware =
:P

--=20
Best Regards
 Guo Ren

