Return-Path: <linux-kernel+bounces-77310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDB386039B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823651C23CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E9E6E5F4;
	Thu, 22 Feb 2024 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="l7QyR5HW"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1D14B815
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633373; cv=none; b=ufdCZijtvWxts2xcU0N0NqnLm89APtSy9wpDjthc8D/nNFzHC40MRwmtAvf2EqxU8dTKFwIdlR8NwGSOWqVXG1bLbu5KND0mku5LCe1em5ETgJhKR903BS9sOC8/8HGYjoMeXJ1yxx9uxCjkTum4tck/puxEPudv/2xJ4C90WB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633373; c=relaxed/simple;
	bh=MhysHirwrzZgOmT/JmKn7W+RQzCr8QuKyzQeL5Lz9o0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=tcP/LrXnUZhO9tHGRbRKO7yLN9oDqK/siaJ0Z/nE+ZXelnUOFnMu2VTe27bMgXE9qjPVpOnNJdteH05evLveLClddkLvV4/Z/oBm8d3HBj3iyxr6UojtJxRWpDsAvg5Pt1FbUnD+IuWy2Lji5J+Qmp5u+yVimkcRDbEFQHSNOS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=l7QyR5HW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-299b818d63aso182843a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1708633370; x=1709238170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpShOmtkkj9GEApYdcwx7cn/mMGxpGuhSoDbV1XUNXc=;
        b=l7QyR5HWjp/Sx7yDSFmwCrFtkop7xMvxUckydkfpyTdxk6adsvQoFfX3RDQy7fP5Wz
         kd2C4tDS6Ufsc6VhViLFPJSIJuseGZPy8qbC3YfYVacbgnZcYTf4pIzTo7yRXlf5B3Px
         Ej7y9YB6xT5hJQX5FnhEKrtT3xAkm/WDGSht0N1+6Jgyy7uAvHDbSH5wdwcg+06Tpb3M
         cQlXnFzzFy6ijIxoelWoRSpiOc5XSVMNVeWiw/YZjDK8ykg2SK4Wv1tjAdeQ3tSCj+u3
         f2zAm+3IThbEKJmD3bSGxsOvJjl3R86+apf7dPZGKpIo4SuiZeYbKBn9/XvLQLLmuJHS
         6qeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633370; x=1709238170;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpShOmtkkj9GEApYdcwx7cn/mMGxpGuhSoDbV1XUNXc=;
        b=KwzBIeKPioR0eY3gN8xbDRJcMjfgvDcIj8D/L3e5w2gV+ahmdTT5gem2iFyfEOTWCN
         LZyHKOnTPjhtH0PLok7CjqTn54I/kgztbZ1YxA1v6CvIGjcgmXEG18VkwKm45ug5+kGN
         VBzLi834vEDytX8N5DDQB0WnkjM7z4ixQTAo+sDn8FVK6h73Tms/lfVM2me62v/2a9PX
         ZG21LETJwhZtIRaQlN9o8zcNSdI3GnFUlq8c35REFZmjMGTMdcWADX4R9rpXX0iYFxVo
         CrLHj9nEP/x6ZW5ro+0MsnkKqnflKPrpu5F3tf2X5Eaq9PlyYujtUoJBoZOVFNJD2hnu
         IwOw==
X-Forwarded-Encrypted: i=1; AJvYcCXptcL0Jk0B+LuZaVZSKWIM9z4LDmKMT9ztMrgMtMpJ2OQAHa9X+mMDdjJjMdZ9kVtZ9D0pW4QA36PfFKdn8wqUZqUna2iRrIyS1LHq
X-Gm-Message-State: AOJu0YwVwQiO/bvUR8tjAATxST7ogrb9uwi4zV8mE/7EI6Tur82LeB0r
	PYJF3lrGkBN/OmWatDjS610YXoLiNohUhNvG6JD+IO4Pt88tD5L0rzqXG2yasso=
X-Google-Smtp-Source: AGHT+IHqzp5vBlh891WfzJCO4hseA3vx6/FnlCk5TJbweZ6XQhH5Ogc5C8SekyxUIOEcqD7DZP99Dg==
X-Received: by 2002:a17:90a:d3d0:b0:298:b25d:127c with SMTP id d16-20020a17090ad3d000b00298b25d127cmr5033001pjw.23.1708633370408;
        Thu, 22 Feb 2024 12:22:50 -0800 (PST)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id ta4-20020a17090b4ec400b00298b3e058fcsm4424899pjb.57.2024.02.22.12.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:22:49 -0800 (PST)
Date: Thu, 22 Feb 2024 12:22:49 -0800 (PST)
X-Google-Original-Date: Thu, 22 Feb 2024 12:21:05 PST (-0800)
Subject:     Re: [PATCH v2] riscv: add CALLER_ADDRx support
In-Reply-To: <20240202015102.26251-1-zong.li@sifive.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, alex@ghiti.fr,
  Conor Dooley <conor.dooley@microchip.com>, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, zong.li@sifive.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: zong.li@sifive.com
Message-ID: <mhng-ce04b525-e138-44ba-874f-97b0f6d5e2e7@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 01 Feb 2024 17:51:02 PST (-0800), zong.li@sifive.com wrote:
> CALLER_ADDRx returns caller's address at specified level, they are used
> for several tracers. These macros eventually use
> __builtin_return_address(n) to get the caller's address if arch doesn't
> define their own implementation.
>
> In RISC-V, __builtin_return_address(n) only works when n == 0, we need
> to walk the stack frame to get the caller's address at specified level.
>
> data.level started from 'level + 3' due to the call flow of getting
> caller's address in RISC-V implementation. If we don't have additional
> three iteration, the level is corresponding to follows:
>
> callsite -> return_address -> arch_stack_walk -> walk_stackframe
> |           |                 |                  |
> level 3     level 2           level 1            level 0
>
> Fixes: 10626c32e382 ("riscv/ftrace: Add basic support")

You've got a spurious newline here.  I've got this queued up for 
testing with that cleaned up, it should show up on fixes soon (assuming 
it passes the tests and such).

>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>
> Changed in v2:
> - Rebase to v6.8-rc2
> - Add noinline attribute for return_address()
> - Add a fixes tag
>
>  arch/riscv/include/asm/ftrace.h    |  5 ++++
>  arch/riscv/kernel/Makefile         |  2 ++
>  arch/riscv/kernel/return_address.c | 48 ++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+)
>  create mode 100644 arch/riscv/kernel/return_address.c
>
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index 329172122952..15055f9df4da 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -25,6 +25,11 @@
>
>  #define ARCH_SUPPORTS_FTRACE_OPS 1
>  #ifndef __ASSEMBLY__
> +
> +extern void *return_address(unsigned int level);
> +
> +#define ftrace_return_address(n) return_address(n)
> +
>  void MCOUNT_NAME(void);
>  static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  {
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f71910718053..604d6bf7e476 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
>  CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_return_address.o	= $(CC_FLAGS_FTRACE)
>  endif
>  CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
>  CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
> @@ -46,6 +47,7 @@ obj-y	+= irq.o
>  obj-y	+= process.o
>  obj-y	+= ptrace.o
>  obj-y	+= reset.o
> +obj-y	+= return_address.o
>  obj-y	+= setup.o
>  obj-y	+= signal.o
>  obj-y	+= syscall_table.o
> diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/return_address.c
> new file mode 100644
> index 000000000000..c8115ec8fb30
> --- /dev/null
> +++ b/arch/riscv/kernel/return_address.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This code come from arch/arm64/kernel/return_address.c
> + *
> + * Copyright (C) 2023 SiFive.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/kprobes.h>
> +#include <linux/stacktrace.h>
> +
> +struct return_address_data {
> +	unsigned int level;
> +	void *addr;
> +};
> +
> +static bool save_return_addr(void *d, unsigned long pc)
> +{
> +	struct return_address_data *data = d;
> +
> +	if (!data->level) {
> +		data->addr = (void *)pc;
> +		return false;
> +	}
> +
> +	--data->level;
> +
> +	return true;
> +}
> +NOKPROBE_SYMBOL(save_return_addr);
> +
> +noinline void *return_address(unsigned int level)
> +{
> +	struct return_address_data data;
> +
> +	data.level = level + 3;
> +	data.addr = NULL;
> +
> +	arch_stack_walk(save_return_addr, &data, current, NULL);
> +
> +	if (!data.level)
> +		return data.addr;
> +	else
> +		return NULL;
> +
> +}
> +EXPORT_SYMBOL_GPL(return_address);
> +NOKPROBE_SYMBOL(return_address);

