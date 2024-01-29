Return-Path: <linux-kernel+bounces-42117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D629F83FC95
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7681B1F2115F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA76EFBEB;
	Mon, 29 Jan 2024 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y697E+sw"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DCFBE5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497630; cv=none; b=m/wUcgSxzzVfzqvYjTAmyYJGkliggqgl3nkCkn5GqQcep+9dfStIhwUSPPAE8KW2KZ2dgDWv15LRc0iwmpTNbRWbRq7snycvlQ6+IcTEMQG2rJ86SolxJi/VqJnJXd13wfXPKDtdS3OvtA5+fkk0tixw4Qk2wat2dcAxEomtUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497630; c=relaxed/simple;
	bh=7tR76fG0CtwOXKVJW2uJ4Evju11jpczw9YfBchqS8q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYY/2KICyrVM6HSxeY2+WOcpVTZcGwA2WCV3Po9kMOgUkv4AaN87QaT2Yusq9axNCzCQdcD2c3XufIBbzIXZaHQ4SOKAL+t1W8nuNPibDGUtK3Cmc77jbq5qGRYNUJgA09+qlftAegDMRgFPXBJ4BegPUjzTa7IpbIJhcw4Bb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y697E+sw; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21499c9650cso547883fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 19:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706497627; x=1707102427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VmEsB3BrVhcksANfHb/8QboZcv6m1DkmrrBxCJMlos=;
        b=Y697E+swwpbTKD1pk9AwE0rEHdpXL2VPmkNtheebgqvjyFbwj/+N69Mr25CfKSutdj
         dajG9OKN7KIVq1o1ENO52dLMyZfKCw8qXZ3jQnogB+YHnkGR0xN+ZRdwM3YFe7TFrV51
         R6FI7WnCsWefO49j6xEwBlHrQB6NgkVY/3NdKm3pLoreJEZL8Qo5sUFcbWHD4WpyOX9u
         SinlZ8weZVEOpuabbfOWDMjkp3KUja2mw0zsfq4ki2x6KnNePplQPbnB347vPYCkIudH
         G5x8/JFI4B0louE8oJPHNJLNCN3Ts2Vo0xMAuTQTPr3CQQ7Rwjnoj2PYlXuAiU4N84aR
         2cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706497627; x=1707102427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VmEsB3BrVhcksANfHb/8QboZcv6m1DkmrrBxCJMlos=;
        b=qtMdq9wo7JUaH1EkkHE9//HEunmKk3MKM6JHb9W/A2ZZzADJ1BwkPRQ6n9Q+YWJqTP
         arR8MYZ/B3U3RkweBT9McHT7yTxlqfsi/ZRPzX0OQE8GrXkJ9JVr/rIOKyWfGSbEhd8j
         vlEKzlKR2H+0f/i9Kn2uE6f7aYKFFXr2sWaec/4IfRHisX63sqO9VCWcThm7lzRTzPH+
         gHWOQMO0JFHBxZOdCiP2LXBMeBNIDevlJlR8CS065SdVvXwNuJoPQPGV6ZZ1qXXQBdO2
         7nGwP5XVG9mgGCpiA2lvahaE+0p/7bV82ouPPffpmZ3MIHULTWeCkSKMuJt0anhOU8yk
         3TXg==
X-Gm-Message-State: AOJu0Yy9FxOUkyec8Mxobxa3A3cKnwHN5AzSeydNjgWNZy/lUIZLH4uq
	oMWliEA8kTqFeHFjL49WuTxoACKOfQ5rJKbsvxEiyk9h8D/cv7E5dA2ypwhbbwk2GwsB0JxXlTb
	c8hqIq33bsppnYGqhXeSf3/T+Gdv/Vx/7kbf0yA==
X-Google-Smtp-Source: AGHT+IEWlpSCuURK2908qpVhjPZ38PveXtCpdAx9PaagZ0ywJkZb7DWA1aHVXgttgRYK55tCSUygd093guftonqGw1g=
X-Received: by 2002:a05:6870:b401:b0:214:fc3f:3471 with SMTP id
 x1-20020a056870b40100b00214fc3f3471mr1192447oap.40.1706497627335; Sun, 28 Jan
 2024 19:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128120405.25876-1-alexghiti@rivosinc.com>
In-Reply-To: <20240128120405.25876-1-alexghiti@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 29 Jan 2024 11:06:56 +0800
Message-ID: <CAEEQ3wmXvnqdvv39JZhkfUsoLbJr4B2WwdgWnGY=aHgE8A-+0g@mail.gmail.com>
Subject: Re: [External] [PATCH -fixes] riscv: Flush the tlb when a page
 directory is freed
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Sun, Jan 28, 2024 at 8:04=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
com> wrote:
>
> The riscv privileged specification mandates to flush the TLB whenever a
> page directory is modified, so add that to tlb_flush().
>
> Fixes: c5e9b2c2ae82 ("riscv: Improve tlb_flush()")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/tlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
> index 1eb5682b2af6..50b63b5c15bd 100644
> --- a/arch/riscv/include/asm/tlb.h
> +++ b/arch/riscv/include/asm/tlb.h
> @@ -16,7 +16,7 @@ static void tlb_flush(struct mmu_gather *tlb);
>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
>  #ifdef CONFIG_MMU
> -       if (tlb->fullmm || tlb->need_flush_all)
> +       if (tlb->fullmm || tlb->need_flush_all || tlb->freed_tables)
>                 flush_tlb_mm(tlb->mm);

Why is it necessary to flush all TLB entries of the process?

Thanks,
Yunhui

