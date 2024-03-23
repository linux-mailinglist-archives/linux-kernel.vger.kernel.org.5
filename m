Return-Path: <linux-kernel+bounces-112410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FDA88796E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93842825B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A8747A74;
	Sat, 23 Mar 2024 16:41:12 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187014AA3;
	Sat, 23 Mar 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711212072; cv=none; b=t3l24/4WtxLKnLUtduJweuEYemEv1hoP57aweNO0tM5TKK6YyjycCtzgfpi+iqIUZJOuYBNaoenmlg8j3kNg0BxoaguEJPZWouH3bVnarnZNiM/TR4KxYCQV7cIdSWdMlXNV8OgkO5UYwC98MK6NM45Nagp9gC98mDAfbc4yfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711212072; c=relaxed/simple;
	bh=atvZrKiUAUvZM2NuYgS1vjg/ulbuXOUdayurW+vjXAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=U2N3fcye+CUPoudMd6BDvt5waqw6XlQ/gdMVW07PuqQELOnaulkzB7TYnkWRKT7a6itcWwOi/DN8vkV8nG235SdGbrz69lW3t3OitAh9Cnwe+EQdwnN4fzrFzdZtNrxIq11M4T4fBstgzEHI8xB1PqCPZeFtonkjtpRU0EbiATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V24dB1K99z1h2m2;
	Sun, 24 Mar 2024 00:38:22 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C7521A0172;
	Sun, 24 Mar 2024 00:40:58 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 24 Mar 2024 00:40:57 +0800
Message-ID: <ea7ec9fe-a2e1-4e0f-b314-de7815bfd614@huawei.com>
Date: Sun, 24 Mar 2024 00:40:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf,riscv: Implement PROBE_MEM32 pseudo
 instructions
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>
References: <20240323154652.54572-1-puranjay12@gmail.com>
 <20240323154652.54572-2-puranjay12@gmail.com>
CC: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Luke Nelson
	<luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240323154652.54572-2-puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100009.china.huawei.com (7.221.188.135)


On 2024/3/23 23:46, Puranjay Mohan wrote:
> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
[snip]
>   
>   #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
>   #define BPF_FIXUP_REG_MASK      GENMASK(31, 27)
> +#define DONT_CLEAR		16	/* RV_REG_A6 unused in BPF */

This is a bit misleading. RV_REG_A6 is actually used in riscv64. Maybe 
"RV_REG_A6 unused in pt_regmap" or change to other register will be better.

>   
>   bool ex_handler_bpf(const struct exception_table_entry *ex,
[snip]
>   
>   	stack_adjust = round_up(stack_adjust, 16);
>   	stack_adjust += bpf_stack_adjust;
> @@ -1794,6 +1974,10 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>   		emit_sd(RV_REG_SP, store_offset, RV_REG_S6, ctx);
>   		store_offset -= 8;
>   	}
> +	if (ctx->arena_vm_start) {
> +		emit_sd(RV_REG_SP, store_offset, RV_REG_S11, ctx);
> +		store_offset -= 8;
> +	}

I think it's fine to use s7 and keep the original dynamic stack code style.

>   
>   	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
>   
> @@ -1807,6 +1991,9 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>   		emit_mv(RV_REG_TCC_SAVED, RV_REG_TCC, ctx);
>   
>   	ctx->stack_size = stack_adjust;
> +
> +	if (ctx->arena_vm_start)
> +		emit_imm(RV_REG_S11, ctx->arena_vm_start, ctx);
>   }
>   
>   void bpf_jit_build_epilogue(struct rv_jit_context *ctx)
> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index 6b3acac30c06..9b6696b1290a 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -50,6 +50,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   	int pass = 0, prev_ninsns = 0, i;
>   	struct rv_jit_data *jit_data;
>   	struct rv_jit_context *ctx;
> +	u64 arena_vm_start;

unused variable

