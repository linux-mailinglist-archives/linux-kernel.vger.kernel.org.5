Return-Path: <linux-kernel+bounces-35401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DED839065
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBDC28CF85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F15F578;
	Tue, 23 Jan 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWDqq0Ka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5465F54F;
	Tue, 23 Jan 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017580; cv=none; b=gsdadTmappqF6OI9Pn1fOK7oAVb5X+hpaHhpo4GHdob1YOL7xz+AMyl1pDHKJ0kk61fKL8J9eoNmhUjLl//Yz9Lh2iAOdllqK4yUyoi2IAAblgDYSjzsA2f6xDyxDwVhhEZu9CbT40ZgVs2SvqyEPlTKBrG1j+oi8NIduZzIUTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017580; c=relaxed/simple;
	bh=HSbamuBevB4x3A9iN39lYXYaJn9eSzQgr6SOU7Zv/WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9SEGBXtAGJkEGRQ+NDPqE7dUxHSsqtk0TKArsWVCjwNtj5+Qz0ht5yM/L6Ml2anCIIRW5OwUtsQE7wZ23nCMn+mO3iwh6vc5mPVWsNu1doJAO3mDdSwApZE3LtDoto/Ng2L7PAftu8i82XA/Ru1PQPBxNQCNIGT5L3ioYtGdt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWDqq0Ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1758C43601;
	Tue, 23 Jan 2024 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706017579;
	bh=HSbamuBevB4x3A9iN39lYXYaJn9eSzQgr6SOU7Zv/WM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mWDqq0KaBaD1rKizM43mJuW1kUj+H3jBzBF2zu4kbtjjKUYa9ZoJsmkdyp6NTF8RL
	 xfFLo8KZVhLkJg6bJl1+uxM1Swb8np87+uWHZNBD0WFUqGCFBLNlxvyE6EZ0HCpqWk
	 DxdnfTogAgrPTnQmWaQ1yWz9k1YfItNoxVrWsxrubtu/hxPU9uZX9O2tTpvysDb7HV
	 p59VlVqcFrwhRmnT7D5boacA+AhQx9Qe7sn3RWTUa7cjYgNLbG0FVitfQuEBnqeAwa
	 yGz/43PhndOsjst9Grap296VW74/iifsN1FzDcG6dyqunA1xIyK1AFIPFsc3sosQyw
	 B4SHV/b7/lmoQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cdfa8e69b5so47671591fa.0;
        Tue, 23 Jan 2024 05:46:19 -0800 (PST)
X-Gm-Message-State: AOJu0YwkQoKwi+n2ga7reLh76KLVAG++stDiu8Hs8g3sBOEc2+5Ddx7q
	SDE/IlNDh36bk6tNqXW5hwuNfTuiOhBNF8KYXRbcF9O2otpUK8aQdDaltiUtvKID1MRTwT9H2IY
	l8UdLLYozhdtN/j/Cr/1gXLXBhI0=
X-Google-Smtp-Source: AGHT+IHoT+gSNr1Ag6oozYRDwsF7ziNbcgQw2rOUf0grBO/aQn5XX5uFNvEm9GCRceSTpXNoJpDOQvJw10wpGYOCOJQ=
X-Received: by 2002:a2e:9c42:0:b0:2cd:6c0a:1882 with SMTP id
 t2-20020a2e9c42000000b002cd6c0a1882mr1760036ljj.85.1706017578067; Tue, 23 Jan
 2024 05:46:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123011211.work.227-kees@kernel.org>
In-Reply-To: <20240123011211.work.227-kees@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 23 Jan 2024 14:46:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG3kqRy0KEvC_+f+RAgeZvcKRwHGKTbLNj34pr8rhzTdw@mail.gmail.com>
Message-ID: <CAMj1kXG3kqRy0KEvC_+f+RAgeZvcKRwHGKTbLNj34pr8rhzTdw@mail.gmail.com>
Subject: Re: [PATCH] ARM: fault: Add "cut here" line for prefetch aborts
To: Kees Cook <keescook@chromium.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Wang Kefeng <wangkefeng.wang@huawei.com>, 
	Ben Hutchings <ben@decadent.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Russell King <linux@armlinux.org.uk>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 02:12, Kees Cook <keescook@chromium.org> wrote:
>
> The common pattern in arm is to emit a "8<--- cut here ---" line for
> faults, but it was missing for do_PrefetchAbort(). Add it.
>
> Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Wang Kefeng <wangkefeng.wang@huawei.com>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/mm/fault.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index e96fb40b9cc3..e804432e905e 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -586,6 +586,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
>         if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
>                 return;
>
> +       pr_alert("8<--- cut here ---\n");
>         pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
>                 inf->name, ifsr, addr);
>
> --
> 2.34.1
>

