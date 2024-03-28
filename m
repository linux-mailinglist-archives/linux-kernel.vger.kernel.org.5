Return-Path: <linux-kernel+bounces-122475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8EE88F830
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8850B2934A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C834F8A0;
	Thu, 28 Mar 2024 06:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMHhdkQk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC645386
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711608892; cv=none; b=iH0iIrntTfkbuaz+tqP4vEC5YQ/92E9iwTYBqcclcMpX4fxohQXDFNZye4/+aUIh3hBv7lJbEBl4tb3KrejCvZmaVbwSmFaj9kjtRZw57E2K1iC3K5pcbltUG2pwgHAFcJLzipEF0jhgdzRaycxuDSKc7lgvzsr9bxQC5uPM5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711608892; c=relaxed/simple;
	bh=pAvs9WVpXCBSWsI517PYQnV/TaqvtCJ3AYMCColBUUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHzTi8aYOZvh8FsZ+evEXZmdaxGLOmqNtfAO8XSMXtwbNAoXhUtAjmVNTJx9kb/5AIuO9pmgshCLuc410priiI30gzc8MkqCcPz/W0KqvZ4tg8/ARFiGfISUBLJsPeZKWZoCy18JYl3y9xe4UZS6zwxtp28W08QtYnJAQfTiPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMHhdkQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CD9C433F1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711608892;
	bh=pAvs9WVpXCBSWsI517PYQnV/TaqvtCJ3AYMCColBUUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aMHhdkQkdMCK0aBH6BXUh5+AQe5wqEQCfGzfqch4Y6V8KFyfKGx8RRZ563+2FeeR3
	 PzfU6/tp2aGgHDG5DgjIhXs596OpiJL8cQ5WP2ShLt2DqZSHJ4vjSluqTYPfFe2HzE
	 boNJ9nNgWTpPKwZtv4uW91uq9IZqDMt3aR1boxop6eAiDdHHqO5Vl6NyteWB5oLmOU
	 uMBhCEm6CwZJ7veJCaC2/WK+dnRDlIivv2mslfMJGmiKNqDXZbHn3AO2S2j+3TTkZ5
	 Mnn4Wy36I7n0GDiuVfGHZ3sjReqUAmn5InfYmASwpDJhrKez/pLpIgc5N+Azvm3vE7
	 azQD4EY4QxQXw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-515a68d45faso466210e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:54:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLBoO0Xd1DAyRGMcXvrLXQggbh1bQdRfef2QW+63WgLeZ2Vqc0Nc1wGgthRn1XQu3VtYPcIGjtg1KIfOiJn7EtDZm8fLPbXMhg61+G
X-Gm-Message-State: AOJu0YzBhAkBy55EU0gstmQZFy4xC9KYRUYm995AD2FwWSzCMiE/EhV0
	mbEXrBqWGrbzFMvjW/zEQHoZLp20zKiOXgbDUlZJzGd+qPFVMmSerXSGjh4VlZBpsKtFHWLkSfo
	zHh9wjefo46tbTuwQpLKgBc04hdI=
X-Google-Smtp-Source: AGHT+IFPWibTjQ7HYu9iMUozZrafRkHq4t3zHzqCt37IN1tmUn5DaSR7BVPB0CqMAFji6pRrgEjVM4+j2oJ5rcVjNmA=
X-Received: by 2002:ac2:48a4:0:b0:515:a223:770c with SMTP id
 u4-20020ac248a4000000b00515a223770cmr902815lfg.35.1711608890760; Wed, 27 Mar
 2024 23:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403221630.2692c998-oliver.sang@intel.com> <20240324142532.GAZgA33M_u1lW_E_1n@fat_crate.local>
 <CAMj1kXE97o_T61AJ6wRAOpUvzon-45fnsT2dGB0GBP1x7bfGaw@mail.gmail.com>
 <ZgKH0LbdN0aDyvRe@xsang-OptiPlex-9020> <CAMj1kXG2D8cwtXTqjepm30B9X9KQD_q2XMDAA522mv9z-5_-ug@mail.gmail.com>
 <ZgUGtcJ1ZtQMhSHg@xsang-OptiPlex-9020>
In-Reply-To: <ZgUGtcJ1ZtQMhSHg@xsang-OptiPlex-9020>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Mar 2024 08:54:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHYur1KVumT-n-8gF0jxBN606dwSHxk6fHCsrTYE+2mrg@mail.gmail.com>
Message-ID: <CAMj1kXHYur1KVumT-n-8gF0jxBN606dwSHxk6fHCsrTYE+2mrg@mail.gmail.com>
Subject: Re: [linus:master] [x86/sme] 48204aba80: BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
To: Oliver Sang <oliver.sang@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 07:57, Oliver Sang <oliver.sang@intel.com> wrote:
>
..
> regarding this early-boot failure issue, by more tests, we double it may
> relate with 3 configs. as we shared in [1], they are set as below when the
> kernel run into early-boot failure:
>
> # CONFIG_INIT_STACK_NONE is not set
> CONFIG_INIT_STACK_ALL_ZERO=y
> CONFIG_GCC_PLUGIN_STACKLEAK=y
>
>
> the early-boot failure issue will _disappear_ by making either one of two
> changes:
>
> (1)
>  CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
> -# CONFIG_INIT_STACK_NONE is not set
> +CONFIG_INIT_STACK_NONE=y
>  # CONFIG_INIT_STACK_ALL_PATTERN is not set
> -CONFIG_INIT_STACK_ALL_ZERO=y
> +# CONFIG_INIT_STACK_ALL_ZERO is not set
>  CONFIG_GCC_PLUGIN_STACKLEAK=y
>
>
> (2)
>  CONFIG_INIT_STACK_ALL_ZERO=y
> -CONFIG_GCC_PLUGIN_STACKLEAK=y
> -# CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE is not set
> -CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
> -# CONFIG_STACKLEAK_METRICS is not set
> -# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
> +# CONFIG_GCC_PLUGIN_STACKLEAK is not set
>  CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
>

Thanks, this was very useful in narrowing it down. I sent out a fix
for the stackleak plugin.

