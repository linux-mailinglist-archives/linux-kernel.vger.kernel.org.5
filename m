Return-Path: <linux-kernel+bounces-130782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E964897D0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A848B1F2A12E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619191FDD;
	Thu,  4 Apr 2024 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0dgeL0Pm"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801A1391
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190447; cv=none; b=hJ4HPOLQecDFfWGAjjNz3LxeQlvd/ycxbg4AbVGB2Zv8az94v+C1R8UJ48fCPLZ+6HfwMKZiGn20dybX9aU9eD/7JT/UChdAIzUVstXc4xKS0Thzunq7o9WmUe4fVsboBBtE/De3c0ciIOIh6Qd7+JW/DLGoHTyhKboyonBCgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190447; c=relaxed/simple;
	bh=j+TvKY7Bn8AoSIc99pjkGihpjD70Jl3L1uBRE0nwDj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ml2x27CjXrxiluOBxiwYUMJTUeQmz+BNl9BgjgYwPrZSBD6Pstu/e76N0kAwFf4BVQVYCxVItz/8GkpL3H+0OOFst1wLIhkXYmppTuYWUJnbKJteXZQyYnEENgMPnGJVh3CGoi2h5s2JP36RQwxCcsBxAK7x2UYRkoJiLTEwqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0dgeL0Pm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6ca2ac094so422624b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 17:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712190445; x=1712795245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulNjjnGHacupkL1wK4ADZTn/tTEYJEcOSwDzhvF8wnk=;
        b=0dgeL0Pmg5j7lwdT0Dvf9+zIuSAWk0ATNWFyFIF2I4gbfqq7o14lUePfnsOSq0WlfH
         AqWrPmH48wJ67aYqk3Afz4k+ucRiZmPevYmZhbhz8ydsEGcKwCpABJuynFaKRgtDKBi6
         11f27wWacm1AyRiklGncNcDAcuasnrHAVeEEa8eEPGi+HZ616jC3hC8/kv02eRykiBoW
         4O/S4IlxIuwujpQSLhyQW7kr/Dp/dcKPT5EBoLeJ4+Q5Zhuojo3N/lIEAEwNukBR5CIF
         DIoslT+k3QGitwPToysb6oouFIlps64H1tD+FcGQV6BTrYeUOJuKDhaVYrhq4px3Be6B
         6Tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712190445; x=1712795245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulNjjnGHacupkL1wK4ADZTn/tTEYJEcOSwDzhvF8wnk=;
        b=udGCeLIgjNymnjtdI0B1A22sKUPHq96fYNBPb4aP0TxZCoC5ZfpQ0P2+Zo+a5SuyOD
         wYiBXA6PRM6AprW6wXwAc5KPScFtbVPKW2EL7B2c0m8Yew0MhTilEPenDBp4sqgRIJto
         1t09nPHLFgfRcSHlyfSe00lbu9J+zkux1lkcLfFugtb3AU0HhsqLy3EpmcgPF2bc+px2
         qsMEzuaOysS1W/YFO++i/tAP0HtG9pLPHobrePqMaTmoNDsv8TfUwZkQ5/uz8rRIVBCh
         B56vT254/jAKzdmZ8pj9c9AbTN523jxJot+n+pme+Ba65meaTasL+JFxQVRSyXAmB91I
         Yocg==
X-Gm-Message-State: AOJu0YyAJJSR23kWYq6cgxr577aaAIFLHya7syK+wD7bnKbitgIwLNtW
	4ymJvnAcNjhhZCs2v453TDPIeBUqoZFpFSVMszJTxYT9Ceb3dlzGVNCm5qxO1bo=
X-Google-Smtp-Source: AGHT+IFHYuFf4798AwOR1iHBDx2IxXYtUAW7d845lRV4JHj0meMCcPt6hv0exjv65S7XmTxWfZPjqg==
X-Received: by 2002:a05:6a00:908d:b0:6ea:d10d:c96d with SMTP id jo13-20020a056a00908d00b006ead10dc96dmr1366514pfb.19.1712190445206;
        Wed, 03 Apr 2024 17:27:25 -0700 (PDT)
Received: from [10.0.16.165] ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7928f000000b006ea7d877191sm12440141pfa.2.2024.04.03.17.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 17:27:24 -0700 (PDT)
Message-ID: <56863fe7-4d82-4f37-a518-2acf368c3ea6@rivosinc.com>
Date: Wed, 3 Apr 2024 17:27:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: selftests: Add signal handling vector tests
To: Charlie Jenkins <charlie@rivosinc.com>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andy Chiu <andy.chiu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com>
Content-Language: en-US
From: Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 16:50, Charlie Jenkins wrote:
> Add two tests to check vector save/restore when a signal is received
> during a vector routine. One test ensures that a value is not clobbered
> during signal handling. The other verifies that vector registers
> modified in the signal handler are properly reflected when the signal
> handling is complete.

Hmm, isn't this testing two contradictory things ?

We do want V regs to be not clobbered across a handled signal, o/w V
enabled code would just not work at all.
That implies that anything done by signal handler should just be
discarded - no ?

Am I missing something.

-Vineet

>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> These tests came about to highlight the bug fixed in
> https://lore.kernel.org/lkml/20240403072638.567446-1-bjorn@kernel.org/
> and will only pass with that fix applied.
> ---
>  tools/testing/selftests/riscv/Makefile             |  2 +-
>  tools/testing/selftests/riscv/sigreturn/.gitignore |  1 +
>  tools/testing/selftests/riscv/sigreturn/Makefile   | 12 ++++
>  .../testing/selftests/riscv/sigreturn/sigreturn.c  | 82 ++++++++++++++++++++++
>  4 files changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> index 4a9ff515a3a0..7ce03d832b64 100644
> --- a/tools/testing/selftests/riscv/Makefile
> +++ b/tools/testing/selftests/riscv/Makefile
> @@ -5,7 +5,7 @@
>  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>  
>  ifneq (,$(filter $(ARCH),riscv))
> -RISCV_SUBTARGETS ?= hwprobe vector mm
> +RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
>  else
>  RISCV_SUBTARGETS :=
>  endif
> diff --git a/tools/testing/selftests/riscv/sigreturn/.gitignore b/tools/testing/selftests/riscv/sigreturn/.gitignore
> new file mode 100644
> index 000000000000..35002b8ae780
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sigreturn/.gitignore
> @@ -0,0 +1 @@
> +sigreturn
> diff --git a/tools/testing/selftests/riscv/sigreturn/Makefile b/tools/testing/selftests/riscv/sigreturn/Makefile
> new file mode 100644
> index 000000000000..eb8bac9279a8
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sigreturn/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 ARM Limited
> +# Originally tools/testing/arm64/abi/Makefile
> +
> +CFLAGS += -I$(top_srcdir)/tools/include
> +
> +TEST_GEN_PROGS := sigreturn
> +
> +include ../../lib.mk
> +
> +$(OUTPUT)/sigreturn: sigreturn.c
> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/sigreturn/sigreturn.c b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
> new file mode 100644
> index 000000000000..62397d5934f1
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <ucontext.h>
> +#include <linux/ptrace.h>
> +#include "../../kselftest_harness.h"
> +
> +#define RISCV_V_MAGIC		0x53465457
> +#define DEFAULT_VALUE		2
> +#define SIGNAL_HANDLER_OVERRIDE	3
> +
> +static void simple_handle(int sig_no, siginfo_t *info, void *vcontext)
> +{
> +	ucontext_t *context = vcontext;
> +
> +	context->uc_mcontext.__gregs[REG_PC] = context->uc_mcontext.__gregs[REG_PC] + 4;
> +}
> +
> +static void vector_override(int sig_no, siginfo_t *info, void *vcontext)
> +{
> +	ucontext_t *context = vcontext;
> +
> +	// vector state
> +	struct __riscv_extra_ext_header *ext;
> +	struct __riscv_v_ext_state *v_ext_state;
> +
> +	/* Find the vector context. */
> +	ext = (void *)(&context->uc_mcontext.__fpregs);
> +	if (ext->hdr.magic != RISCV_V_MAGIC) {
> +		fprintf(stderr, "bad vector magic: %x\n", ext->hdr.magic);
> +		abort();
> +	}
> +
> +	v_ext_state = (void *)((char *)(ext) + sizeof(*ext));
> +
> +	*(int *)v_ext_state->datap = SIGNAL_HANDLER_OVERRIDE;
> +
> +	context->uc_mcontext.__gregs[REG_PC] = context->uc_mcontext.__gregs[REG_PC] + 4;
> +}
> +
> +static int vector_sigreturn(int data, void (*handler)(int, siginfo_t *, void *))
> +{
> +	int after_sigreturn;
> +	struct sigaction sig_action = {
> +		.sa_sigaction = handler,
> +		.sa_flags = SA_SIGINFO
> +	};
> +
> +	sigaction(SIGSEGV, &sig_action, 0);
> +
> +	asm(".option push				\n\
> +		.option		arch, +v		\n\
> +		vsetivli	x0, 1, e32, ta, ma	\n\
> +		vmv.s.x		v0, %1			\n\
> +		# Generate SIGSEGV			\n\
> +		lw		a0, 0(x0)		\n\
> +		vmv.x.s		%0, v0			\n\
> +		.option pop" : "=r" (after_sigreturn) : "r" (data));
> +
> +	return after_sigreturn;
> +}
> +
> +TEST(vector_restore)
> +{
> +	int result;
> +
> +	result = vector_sigreturn(DEFAULT_VALUE, &simple_handle);
> +
> +	EXPECT_EQ(DEFAULT_VALUE, result);
> +}
> +
> +TEST(vector_restore_signal_handler_override)
> +{
> +	int result;
> +
> +	result = vector_sigreturn(DEFAULT_VALUE, &vector_override);
> +
> +	EXPECT_EQ(SIGNAL_HANDLER_OVERRIDE, result);
> +}
> +
> +TEST_HARNESS_MAIN
>
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240403-vector_sigreturn_tests-8118f0ac54fa


