Return-Path: <linux-kernel+bounces-112411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 509F2887970
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84CC1F21A15
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39D47F7A;
	Sat, 23 Mar 2024 16:43:50 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5557483;
	Sat, 23 Mar 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711212229; cv=none; b=nD7WKWfeW8CoWzKu/EaOqW0V0TXjaPR7vgtN6Q9kEuPriuZF/eFALrk/RLgPU//9MhBjXWwN2U3lkvEZJ1CC7niiU6PcJKO/gFlz3/15oiuZuTGQM/mg3UDcAyIvbY5EmS9xh4Ho8Y72ZqMkkw4LHAZA//DDBem4fIES0atdeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711212229; c=relaxed/simple;
	bh=ILndtPVVRX8gDHNgqvEeObtv64F5TztKoHFIV9p/3oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=tc1iXGOrOIKzqS+1/5kkoolt6fgUWUqIwJzDSui4BLo1888VQvZhlaotQN1KKtQFX78kKw5jl0KokRaokIEiHdjGMOLJlY3ZMYqWyHFWh0DeU2o5yvYMbt7sVd/5XLg/Q+xfi6sQsEJfmX+sZdPH+rlHeHX5vAij4ThYa1AxL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V24hG5Fmtz2BhGd;
	Sun, 24 Mar 2024 00:41:02 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id F3E161A0172;
	Sun, 24 Mar 2024 00:43:38 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 24 Mar 2024 00:43:38 +0800
Message-ID: <3e07fb21-da08-4183-8bd4-064b519c7ddb@huawei.com>
Date: Sun, 24 Mar 2024 00:43:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] bpf,riscv: Implement bpf_addr_space_cast
 instruction
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>
References: <20240323154652.54572-1-puranjay12@gmail.com>
 <20240323154652.54572-3-puranjay12@gmail.com>
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
In-Reply-To: <20240323154652.54572-3-puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100009.china.huawei.com (7.221.188.135)


On 2024/3/23 23:46, Puranjay Mohan wrote:
> LLVM generates bpf_addr_space_cast instruction while translating
[snip]
>   
>   /* Convert from ninsns to bytes. */
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index f51b832eafb6..3c389e75cb96 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1083,6 +1083,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   	/* dst = src */
>   	case BPF_ALU | BPF_MOV | BPF_X:
>   	case BPF_ALU64 | BPF_MOV | BPF_X:
> +		if (BPF_CLASS(insn->code) == BPF_ALU64 && insn->off == BPF_ADDR_SPACE_CAST &&
> +		    insn->imm == 1U << 16) {
> +			emit_mv(RV_REG_T1, rs, ctx); > +			emit_zextw(RV_REG_T1, RV_REG_T1, ctx);
combine mv and zextw will be better
> +			emit_imm(rd, (ctx->user_vm_start >> 32) << 32, ctx);
> +			emit(rv_beq(RV_REG_T1, RV_REG_ZERO, 4), ctx);
> +			emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
> +			emit_mv(rd, RV_REG_T1, ctx);
ditto, but for or and mv

