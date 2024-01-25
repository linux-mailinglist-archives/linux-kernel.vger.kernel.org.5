Return-Path: <linux-kernel+bounces-39039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4425C83C9FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8990297A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511112FF8A;
	Thu, 25 Jan 2024 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="avjnzVCQ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6A6EB5D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203812; cv=none; b=PsAGYlM7Wa0kHCinHveP0g+RfuR+RURY+TjoLSoXAgi3Mn++g3k6g/y1iqhRF/in3hN95rICYMZNEy8M7hZVIwJAKs/09GO3F9WSqNwTJ0L9mPBlABlmo1mUIU+ZhiP64Rj4H0hJd5n74oK//vyy0FPkerh5dKxhAX65kVMIcnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203812; c=relaxed/simple;
	bh=NzUoVt+asnVPbcKzQRM5nkKBCgKRCSdVtpYDpr1ck0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip8yEeQ1PUtxJF4whJst+mW0/8z0L1ObUMdN1gN4mqYnYZWHQ5l5Ko4ptUDLzyPQgQSx5kml/JSRlLaO5fZ9udNrKBz6tORoJK5v4etTN20hMRLPYrdM6Pyk6BK6X9VWUSBfSzwmbp3+y0aHda2+kWvn+YEROhrlHmSM/sGvGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=avjnzVCQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6da202aa138so5285166b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706203810; x=1706808610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FiMcoXLtake3SsYp4VgIXSl2ZPSDDwizQGFnhQxFN8w=;
        b=avjnzVCQnDo3FCGvxF6RtukgRL+FwLDdU+A6W/2aRhr9z6DGHmtJSZPW8Ao5ICcJio
         G4kfw7fiqQtHHXg7jHiKFMS4kalCWdDvZo4Z7f7iylV4ZOsCMtxsfssKHdtskSQVAsyT
         027mmkbo08QBI4+SYWQ8Oq8kVOtSo+l+kAqZtJf1DG99Gt7/+4fvZ4Z/mztkY+84OFbw
         udFdDQID8EE4ifWnzbOlrPmo7uL3Ud612VWxtsmy8EVb4RF54jXOjxh1hUdezHODDOa1
         +MjagOZpE2hmjZYOn3FMQPYu/nsDlSsxWnlk5jf1VJ3lDgThEoNULVA9DqUso5ebb2zr
         T3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706203810; x=1706808610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiMcoXLtake3SsYp4VgIXSl2ZPSDDwizQGFnhQxFN8w=;
        b=Obq6B7Bqsv0Ar562Ski5xds87BRuYDjRl8vw9nd3h/1795ilnHN93uOUuZaSQgU0xW
         VVgWBvBOqIyvlN8ONJ6rKrSJoB/mLhafY4c5LzZ8mimt34CQBz5BjDNaI4q+ma/1y105
         FDZ+bxADJG+rEROudE0kgHeUHqPPJBTxyOZKPZXm8zg1sLkbIPeqDN8bxTYbroEzDP+r
         nnkFvELgdVAnFKq9zva/LQlWT0O0iQ5owdV/Q2TbukcR9tUeGr7yirQb5EdYGbT/nKEC
         vEUWLlC0c1gNMF+Bjze8j5PiAH0bRmvDntASlg0N/dkYzZYwFApUtKTDAKslRtPzSqW0
         f8gw==
X-Gm-Message-State: AOJu0Yw+wDSCzARSGnJ32GNcjR/L5O/P25AhYDMS5oIeoBBEryZKPgjq
	QmbaoFBKPZEiv5egBK7t5n+prvpGvtak53vPbtEjcCnDAtzt2hYOxDX60t+wAZo=
X-Google-Smtp-Source: AGHT+IFiBmJ9bUWly4Y63SGZXbMGx4CdDV3C4ohhFPjAa5O+ssE0qkHaRA6CwOtYsFJogn6onLaUzQ==
X-Received: by 2002:aa7:8755:0:b0:6d9:be3e:19a0 with SMTP id g21-20020aa78755000000b006d9be3e19a0mr32266pfo.48.1706203809641;
        Thu, 25 Jan 2024 09:30:09 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78086000000b006dbda1b19f7sm9099781pff.159.2024.01.25.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:30:09 -0800 (PST)
Date: Thu, 25 Jan 2024 09:30:04 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Stefan O'Rear <sorear@fastmail.com>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
	"kito.cheng@sifive.com" <kito.cheng@sifive.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Jones <ajones@ventanamicro.com>, paul.walmsley@sifive.com,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor.dooley@microchip.com>, cleger@rivosinc.com,
	Atish Patra <atishp@atishpatra.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Albert Ou <aou@eecs.berkeley.edu>,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	"Eric W. Biederman" <ebiederm@xmission.com>, shuah@kernel.org,
	Christian Brauner <brauner@kernel.org>, guoren <guoren@kernel.org>,
	samitolvanen@google.com, Evan Green <evan@rivosinc.com>,
	xiao.w.wang@intel.com, Anup Patel <apatel@ventanamicro.com>,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, Heiko Stuebner <heiko@sntech.de>,
	Jisheng Zhang <jszhang@kernel.org>, shikemeng@huaweicloud.com,
	david@redhat.com, Charlie Jenkins <charlie@rivosinc.com>,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	Vincent Chen <vincent.chen@sifive.com>,
	Andy Chiu <andy.chiu@sifive.com>, Greg Ungerer <gerg@kernel.org>,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com,
	ruscur@russell.cc, bgray@linux.ibm.com, alx@kernel.org,
	baruch@tkos.co.il, zhangqing@loongson.cn,
	Catalin Marinas <catalin.marinas@arm.com>, revest@chromium.org,
	josh@joshtriplett.org, joey.gouly@arm.com, shr@devkernel.io,
	omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 07/28] riscv: kernel handling on trap entry/exit
 for user cfi
Message-ID: <ZbKanLeU7yf9aTkD@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-8-debug@rivosinc.com>
 <ab343d4b-d8b0-47fc-8040-83313a3d735e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab343d4b-d8b0-47fc-8040-83313a3d735e@app.fastmail.com>

On Thu, Jan 25, 2024 at 02:29:01AM -0500, Stefan O'Rear wrote:
>On Thu, Jan 25, 2024, at 1:21 AM, debug@rivosinc.com wrote:
>> From: Deepak Gupta <debug@rivosinc.com>
>>
>> Carves out space in arch specific thread struct for cfi status and shadow stack
>> in usermode on riscv.
>>
>> This patch does following
>> - defines a new structure cfi_status with status bit for cfi feature
>> - defines shadow stack pointer, base and size in cfi_status structure
>> - defines offsets to new member fields in thread in asm-offsets.c
>> - Saves and restore shadow stack pointer on trap entry (U --> S) and exit
>>   (S --> U)
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/processor.h   |  1 +
>>  arch/riscv/include/asm/thread_info.h |  3 +++
>>  arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
>>  arch/riscv/kernel/asm-offsets.c      |  5 ++++-
>>  arch/riscv/kernel/entry.S            | 25 +++++++++++++++++++++++++
>>  5 files changed, 57 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/riscv/include/asm/usercfi.h
>>
>> diff --git a/arch/riscv/include/asm/processor.h
>> b/arch/riscv/include/asm/processor.h
>> index ee2f51787ff8..d4dc298880fc 100644
>> --- a/arch/riscv/include/asm/processor.h
>> +++ b/arch/riscv/include/asm/processor.h
>> @@ -14,6 +14,7 @@
>>
>>  #include <asm/ptrace.h>
>>  #include <asm/hwcap.h>
>> +#include <asm/usercfi.h>
>>
>>  #ifdef CONFIG_64BIT
>>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
>> diff --git a/arch/riscv/include/asm/thread_info.h
>> b/arch/riscv/include/asm/thread_info.h
>> index 320bc899a63b..6a2acecec546 100644
>> --- a/arch/riscv/include/asm/thread_info.h
>> +++ b/arch/riscv/include/asm/thread_info.h
>> @@ -58,6 +58,9 @@ struct thread_info {
>>  	int			cpu;
>>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>>  	unsigned long envcfg;
>> +#ifdef CONFIG_RISCV_USER_CFI
>> +	struct cfi_status       user_cfi_state;
>> +#endif
>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>  	void			*scs_base;
>>  	void			*scs_sp;
>> diff --git a/arch/riscv/include/asm/usercfi.h
>> b/arch/riscv/include/asm/usercfi.h
>> new file mode 100644
>> index 000000000000..080d7077d12c
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/usercfi.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + * Copyright (C) 2023 Rivos, Inc.
>> + * Deepak Gupta <debug@rivosinc.com>
>> + */
>> +#ifndef _ASM_RISCV_USERCFI_H
>> +#define _ASM_RISCV_USERCFI_H
>> +
>> +#ifndef __ASSEMBLY__
>> +#include <linux/types.h>
>> +
>> +#ifdef CONFIG_RISCV_USER_CFI
>> +struct cfi_status {
>> +	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>> +	unsigned long rsvd : ((sizeof(unsigned long)*8) - 1);
>> +	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
>> +	unsigned long shdw_stk_base; /* Base address of shadow stack */
>> +	unsigned long shdw_stk_size; /* size of shadow stack */
>> +};
>> +
>> +#endif /* CONFIG_RISCV_USER_CFI */
>> +
>> +#endif /* __ASSEMBLY__ */
>> +
>> +#endif /* _ASM_RISCV_USERCFI_H */
>> diff --git a/arch/riscv/kernel/asm-offsets.c
>> b/arch/riscv/kernel/asm-offsets.c
>> index cdd8f095c30c..5e1f412e96ba 100644
>> --- a/arch/riscv/kernel/asm-offsets.c
>> +++ b/arch/riscv/kernel/asm-offsets.c
>> @@ -43,8 +43,11 @@ void asm_offsets(void)
>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>  	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
>>  #endif
>> -
>>  	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>> +#ifdef CONFIG_RISCV_USER_CFI
>> +	OFFSET(TASK_TI_CFI_STATUS, task_struct, thread_info.user_cfi_state);
>> +	OFFSET(TASK_TI_USER_SSP, task_struct,
>> thread_info.user_cfi_state.user_shdw_stk);
>> +#endif
>>  	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>>  	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>>  	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 63c3855ba80d..410659e2eadb 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -49,6 +49,21 @@ SYM_CODE_START(handle_exception)
>>  	REG_S x5,  PT_T0(sp)
>>  	save_from_x6_to_x31
>>
>> +#ifdef CONFIG_RISCV_USER_CFI
>> +	/*
>> +	* we need to save cfi status only when previous mode was U
>> +	*/
>> +	csrr s2, CSR_STATUS
>> +	andi s2, s2, SR_SPP
>> +	bnez s2, skip_bcfi_save
>> +	/* load cfi status word */
>> +	lw s3, TASK_TI_CFI_STATUS(tp)
>> +	andi s3, s3, 1
>> +	beqz s3, skip_bcfi_save
>> +	csrr s3, CSR_SSP
>> +	REG_S s3, TASK_TI_USER_SSP(tp) /* save user ssp in thread_info */
>> +skip_bcfi_save:
>> +#endif
>>  	/*
>>  	 * Disable user-mode memory access as it should only be set in the
>>  	 * actual user copy routines.
>> @@ -141,6 +156,16 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>>  	 * structures again.
>>  	 */
>>  	csrw CSR_SCRATCH, tp
>> +
>> +#ifdef CONFIG_RISCV_USER_CFI
>> +	lw s3, TASK_TI_CFI_STATUS(tp)
>> +	andi s3, s3, 1
>> +	beqz s3, skip_bcfi_resume
>> +	REG_L s3, TASK_TI_USER_SSP(tp) /* restore user ssp from thread struct */
>> +	csrw CSR_SSP, s3
>> +skip_bcfi_resume:
>> +#endif
>> +
>
>We shouldn't need any of this in the entry/exit code, at least as long as
>the kernel itself is not using Zicfiss.  ssp can keep its value in the
>kernel and swap it on task switches.  Our entry/exit code is rather short
>and I'd like to keep it that way.

I kept it here because sooner or later we will need to establish kernel shadow
stack. Kernel shadow stack on riscv (compared to other arches) kernel actually will
be easier to support and adopt because there is already support for shadow call stack
(SCS, [1]). Difference between existing shadow call stack (SCS) and `zicfiss` based
kernel shadow stack would be

	- In prolog instead of using `sd`, we will be inserting `sspush` to save ret addr
	- In epilog instead of using `ld` and compare, we will be inserting `sspopchk`

So a lot underlying work and functional testing for shadow kernel stack is already carried
out with SCS patches. It would be easier and faster to re-use SCS patches to support
`zicfiss` based shadow stack.

I don't have favorites here, if overwhelving opinion of community here is to take this
logic into task switching and re-work this logic back into entry.S whenever shadow stack for
kernel patches are posted, I can do that as well.

[1] - https://lore.kernel.org/all/20230828195833.756747-8-samitolvanen@google.com/

>
>-s
>
>>  1:
>>  	REG_L a0, PT_STATUS(sp)
>>  	/*
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

