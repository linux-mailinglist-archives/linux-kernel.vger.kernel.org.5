Return-Path: <linux-kernel+bounces-108078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5225F8805A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FA7B22D17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7DA5786B;
	Tue, 19 Mar 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZbTrDy6z"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF48548F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877610; cv=none; b=HM4Mgo9A5+TmLokEA6d6vJQwylhqGkUQxUvNvC8yDpwRvm2V1qEVFS+iy2w/DVHE0+LjR9ACBYucFnFv11IJXD4GlON2nMSWMlSRSzv9mp9wQm5vjn0IrCGIkwLyJLFhFjS9OjkP1ehc9o95zeBuc0yW/I5dQ7ehfN9IAAEkBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877610; c=relaxed/simple;
	bh=uARbC43Fd5cjd7/ChKeWZqD3QYJNFx8lQiitP0+TrZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NieM4sC+ep/dPqHmcLOiWACOQo6TJhPAXjG7D2iV5MS1qMCOTBBnC9zSdJxQfg38n0+LxE9AX7uGLT7TjJv7G7MPA+qeJzUYkmcAr4nPYhYuh+qg3RgXgpv0J07H5D8fNaWRzx6cbi/2Git5SGA9uDKn80A6ZdUMPUugqhdijEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZbTrDy6z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6ade6a66aso5251369b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710877608; x=1711482408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEfqQMYpHT+mLEEWMqpipCvQSl9ONp1yIz4RNp/cJvo=;
        b=ZbTrDy6zMXZWWLIFlTSkhl+226s0Z+XIF5v80kyGhB3oIubzyO+5Lu1JJ0f3ftcZLe
         vToUIUUJ6PXXHbaT/+dR0T/aaJ0OPumH+hhZbEio8hSaXKhf+i+Av6P6Gq1gqlVNFFje
         5qDvuzeQVmEY/Vk2pbakzq33IJM5XVo9L66thn/cqN3riztAsVKSivzUji5jJxIyv+tP
         g4quBH2VlqgQWOPwdjStE0iszupVVTSBoDu67K5fT0azqjd749pWV0F4HsbmmeitTf80
         nDjYY9ah8BEZjIy7CrpaVH3rN57+xi1qKZaQlehnfehl0AjMItkEcdLp5oGYPdp/5miu
         Q/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710877608; x=1711482408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEfqQMYpHT+mLEEWMqpipCvQSl9ONp1yIz4RNp/cJvo=;
        b=KeKc9RrQ2ozXtYEfFe+qMf+iiILGjjONiQlb9ETSuMkCX/dxxLjzCe5fcbmwVOdyFy
         XBbM4yjIbyq30vF3+b+jFgQtTdepwsNxbmQRBavntqhQ/h7J+FAdhHeNTA00/U3Iy3KL
         fNZaMyiLCpiIDxgaequ1c8er7PylwHt3gztjUXXar00ToAx5h7fZxztRHzlfpt/9EYV1
         UYKWwDZnaqfdqwyFvQp9ONQXUMJ45Ugtmf1Tp5jy3ZNcFlV/D+f5av25o45IO438b62Q
         k20wGOv8nqHc3oOcKA+/Dgy2FtjxO1bJ+jX0rN2m/Vi5zqiWyri9OscepGENTeTCwfcO
         +Iug==
X-Forwarded-Encrypted: i=1; AJvYcCWcN7kVv4MoGafy4YIL8JNVM2Y+js1Kt6J0fV9mV+gW+47O0VAcl6PIzqtQGH1sWQdQcXRXHBGySik11uOS03EP+GfKt5AzsqI6E+FR
X-Gm-Message-State: AOJu0YxI8LzL9qJZVTELQTYEQsQBZ9y3fQ+PZmZdPymdzsvnCG45aMte
	6I9ZmuWTZE3ogBsi4nxQk+RwBLdTKetQAsPaoSsveZiov6Q8xZsdfezDidPXJAQ=
X-Google-Smtp-Source: AGHT+IHhNrRvQWeD27wPMAcbezsog+p7JKwlthEaikJqnF6LIE09EOJOnc2q/lrvDHUVUDG6NBVGhw==
X-Received: by 2002:a05:6a20:2042:b0:1a3:529a:9cd1 with SMTP id x2-20020a056a20204200b001a3529a9cd1mr9477350pzx.43.1710877608154;
        Tue, 19 Mar 2024 12:46:48 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::546? ([2601:647:4180:9630::546])
        by smtp.gmail.com with ESMTPSA id v14-20020aa799ce000000b006da96503d9fsm10149006pfi.109.2024.03.19.12.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 12:46:47 -0700 (PDT)
Message-ID: <37249973-fa73-401e-b5eb-7fd13fc38996@rivosinc.com>
Date: Tue, 19 Mar 2024 12:46:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: use KERN_INFO in do_trap
Content-Language: en-US
To: Andreas Schwab <schwab@suse.de>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, linux-kernel@vger.kernel.org
References: <mvmy1aegrhm.fsf@suse.de>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <mvmy1aegrhm.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 08:40, Andreas Schwab wrote:
> Print the instruction dump with info instead of emergency level.  The
> unhandled signal message is only for informational purpose.
> 
> Fixes: b8a03a634129 ("riscv: add userland instruction dump to RISC-V splats")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v2: clarify commit message
> ---
>   arch/riscv/kernel/traps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index a1b9be3c4332..142f5f5168fb 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -121,7 +121,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>   		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
>   		pr_cont("\n");
>   		__show_regs(regs);
> -		dump_instr(KERN_EMERG, regs);
> +		dump_instr(KERN_INFO, regs);
>   	}
>   
>   	force_sig_fault(signo, code, (void __user *)addr);

Reviewed-by: Atish Patra <atishp@rivosinc.com>

