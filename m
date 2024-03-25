Return-Path: <linux-kernel+bounces-116657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847F188A200
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C5A1C389E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7210812BEAC;
	Mon, 25 Mar 2024 10:21:15 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44012C7F6;
	Mon, 25 Mar 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352542; cv=none; b=IgSWFp9LQY5JSlHKImbNnDoMe+tWR+Wavbj5OEsvtzMJYUU54VkKxDNwJ9l5RwpZwbhAxgEw0hDkjb+uCfMhb2VQZ4GRJp+vX2vtobxbVf1TZbmwmhLUjLJrA9tPCx5J8iqPwJdcnpJFNV84dnjkyG22BDbG0EiYOrrAQOTeX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352542; c=relaxed/simple;
	bh=vdFoUSbKw87TFfNziH/t3xIKevtSzdAVn2OVLXmGMNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFMjppBbjAVK5Srr2vcvH7lmUZgPyfkKTNFhWI6AJLYB6MY0XGf3ll0uECvjKagL1fuubXkTQdQWtuRpikseHfpcaCDPw/RCkOaLPdKZLnkejZk8/9T1xcSohvUle6WcyUR3OXHXOLZ5IsE8VuDnlvExjNvrIBJ0DJg2rAXy+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E80040002;
	Mon, 25 Mar 2024 07:42:17 +0000 (UTC)
Message-ID: <dc1e2be5-73e1-409b-85bd-6c216a8b76bd@ghiti.fr>
Date: Mon, 25 Mar 2024 08:42:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix spurious errors from __get/put_kernel_nofault
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240312022030.320789-1-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240312022030.320789-1-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 12/03/2024 03:19, Samuel Holland wrote:
> These macros did not initialize __kr_err, so they could fail even if
> the access did not fault.
>
> Cc: stable@vger.kernel.org
> Fixes: d464118cdc41 ("riscv: implement __get_kernel_nofault and __put_user_nofault")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> Found while testing the unaligned access speed series[1]. The observed
> behavior was that with RISCV_EFFICIENT_UNALIGNED_ACCESS=y, the
> copy_from_kernel_nofault() in prepend_copy() failed every time when
> filling out /proc/self/mounts, so all of the mount points were "xxx".
>
> I'm surprised this hasn't been seen before. For reference, I'm compiling
> with clang 18.
>
> [1]: https://lore.kernel.org/linux-riscv/20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com/
>
>   arch/riscv/include/asm/uaccess.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index ec0cab9fbddd..72ec1d9bd3f3 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -319,7 +319,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
>   
>   #define __get_kernel_nofault(dst, src, type, err_label)			\
>   do {									\
> -	long __kr_err;							\
> +	long __kr_err = 0;						\
>   									\
>   	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
>   	if (unlikely(__kr_err))						\
> @@ -328,7 +328,7 @@ do {									\
>   
>   #define __put_kernel_nofault(dst, src, type, err_label)			\
>   do {									\
> -	long __kr_err;							\
> +	long __kr_err = 0;						\
>   									\
>   	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
>   	if (unlikely(__kr_err))						\


That's a good a catch! Surprising indeed that we did not find this 
before, that's the second bug in the uaccess routines in the last 3 (or 
4) releases, maybe we should improve our coverage here, I'll see what we 
can do.

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


