Return-Path: <linux-kernel+bounces-54126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5822184AB1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B291F26A16
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FCE139D;
	Tue,  6 Feb 2024 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RDRX1Rs2"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FED1373
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707179220; cv=none; b=mdI731TKdPsyEVc99pCatwexjro5w58WAkpvZDbuEI3TE3TL99B7YzCHqkYm3HEEIBEnz5w+EOeUYBeynqN5bCOQmfzX/UQg0UuRvnhEUjPTgfDAM45TIbM2dJ4DiXxkjXrZ7T7CDPnsxaa51Bw6tqpRgNAqWAFYa9Wvnf2Fxm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707179220; c=relaxed/simple;
	bh=3TwmDwJT/rL3DMMvAVgIO7o1HJINmVPwu07+FNLBODw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jecv9dtXJG86eTz65zF/SLT0kdO/fewSD2dSn+7hIhJC43J7F9U9dRNPN41GmemA3X4aPHSXdGzQ98FbC5TzvC20bd2akC76e2SKpmXPb5e9KzrNjj5LAcEa98G8oPX6k3BMNnhMeB5f3kkEA3L0TB9IZa2eKroSbyaCAMliVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RDRX1Rs2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6de2f8d6fb9so3776088b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 16:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707179217; x=1707784017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fiVjpSDFqDkt9XNvIzkLrXyeTIMkWHM8SqfmdeXNea0=;
        b=RDRX1Rs2GyzGS448zwA5HB/8kjkxBe200nVU6eeKiUN0Kcv3/NkCDYu6SdOdj7bZBp
         vfrwasNDy/Qhb6FBDGVMgUcubCqtLCGv+7b3L8vShWFIcBN2JPc9J8NLqMiGFq2b597h
         Sp2bp8HCwrKn+3t2Ur3mynLq0caXbImwDzDw9Q+WGB6kvPDmDP27JaqaRcZv9qDERfjm
         QR3RLy86sf7aPzk9K6cN/V+2NPjjjmifAN3lbISlh4MC9hwn2lOQuxrB/obsg9SJ6Ivi
         /tIjq+Ikk3xYcdwUluG0k/r33SAAOOn+qmQ6TDlzK1WT2tCfhLVnVZxes8azfpOWFjoQ
         0wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707179217; x=1707784017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiVjpSDFqDkt9XNvIzkLrXyeTIMkWHM8SqfmdeXNea0=;
        b=Bq2Hqo5wOl2ZwJtBu7m76rDHvEQnqWrpcayJcxWJ78+B2gr94YTmiwn+d8EpDjKCdQ
         JkX4L6VgKl7wTtxF9m/OLNcSJnSyGePVTj8NpshrS5UAqNbSrFp4cWWfTgMVRcpWrueH
         lMgODm5hhYEmJcuovEj1OWtfMbCzbwD0+TirTnF2CVk/v9QgGH50O5NYaoDAShKmPqxz
         QOSMBQ3ybLJLEa4NoB+52cuKll5zXecsLSpW/F37S3COqIZYIeijABg4mecttFrYM4d5
         pess0qKVVTUOOIqq7GuvZ6qRR68Y2zGFjrqqWucua6ZZb8FIbVqCZp5W5aJGKIiwCNQr
         nyZQ==
X-Gm-Message-State: AOJu0Ywx9UQhVf+6zRLp0dsJviuCOq9Cmz7iK3yfrcEiXkpnQNkvMbij
	tOsH4aUg/oTh1xAoC8pxxVWu91eqUCSddps9BAgOiPMNO78xVPkzW7w1f1eqL+g=
X-Google-Smtp-Source: AGHT+IGYCi0+X1+vaJBNc0l8Gs1SpiPv6m18ULzOlpD7Sl4SzHbj0qBqx6SGNAXHukFrXAy7Mux6kw==
X-Received: by 2002:a05:6a21:788e:b0:19e:367a:2ca9 with SMTP id bf14-20020a056a21788e00b0019e367a2ca9mr143337pzc.8.1707179217597;
        Mon, 05 Feb 2024 16:26:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXuxl7fvNMncJzVpzTszUz0jVy3RKrVSRFq9HMCATFeYqQ2K4Xs8LZ/kTazqhiy1ELGqU/PG1WZ8jG+JNbM0l2kGIOnOZBEiwfxm4NgppMD5ZTW0fvTyMOlVS5hhFI4CyWG+rrdacWNcMMTf0c9tTrq3cOSWH15M2jCROPLOO/n/A85UD4n5jVgfa9iSFhuoDUguU2inNzIHXdQmoXOF7W+sx1AYGdfYRaMd8xv
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id y32-20020a056a00182000b006d98ae070c3sm485463pfa.135.2024.02.05.16.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:26:57 -0800 (PST)
Date: Mon, 5 Feb 2024 16:26:55 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix arch_tlbbatch_flush() by clearing the
 batch cpumask
Message-ID: <ZcF8z18dwnGsw0Ix@ghost>
References: <20240130115508.105386-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130115508.105386-1-alexghiti@rivosinc.com>

On Tue, Jan 30, 2024 at 12:55:08PM +0100, Alexandre Ghiti wrote:
> We must clear the cpumask once we have flushed the batch, otherwise cpus
> get accumulated and we end sending IPIs to more cpus than needed.
> 
> Fixes: 54d7431af73e ("riscv: Add support for BATCHED_UNMAP_TLB_FLUSH")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/tlbflush.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 99c3e037f127..c8efc3f87a0f 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -240,4 +240,5 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  {
>  	__flush_tlb_range(NULL, &batch->cpumask,
>  			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +	cpumask_clear(&batch->cpumask);
>  }
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


