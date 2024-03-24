Return-Path: <linux-kernel+bounces-112555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4011887B7A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5309282CCE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18E28E7;
	Sun, 24 Mar 2024 02:39:58 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E919E;
	Sun, 24 Mar 2024 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711247997; cv=none; b=piiwxLpYcDM0JzZvRvsTySYzSm3/Rovtkpgl0G7PACpXjgfGGctaDnEwRUVBIM6jKscDoSJJiP+6oPTD5HxdiZ3w5lTcpZtKyDgh9WVETnnfLjwUg3PpdUWbI59iqSGy0r0uqOZXUEHgLOfPYCgLnEGNEHeOWjDGi9QawwpcLgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711247997; c=relaxed/simple;
	bh=/vmD1Hg9GT3TdhXbCTlhgCSzd6lXMUJPnovLcw2v91g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NZPfvKNKJ88nUpqDtDqvikVbNBaV6eBEDb6X4yXp7MwWvjcLsxTMLKz9TYhj9cYJDh0Bu6wImM+cydIED0IR1HnJSKjiMIuQcEyD7gg2rqdug4vAbdlRTjId/RPIMzewTwRqM3lMiPxYw8IYp3p0PBhk+JB583o39jMzxFowTmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V2KwN53PpztQWp;
	Sun, 24 Mar 2024 10:37:24 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C7CC1404F7;
	Sun, 24 Mar 2024 10:39:45 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 24 Mar 2024 10:39:44 +0800
Message-ID: <6095ba3b-ffda-4ca7-9da4-d841782006a2@huawei.com>
Date: Sun, 24 Mar 2024 10:39:43 +0800
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
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Luke Nelson
	<luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240323154652.54572-1-puranjay12@gmail.com>
 <20240323154652.54572-3-puranjay12@gmail.com>
 <3e07fb21-da08-4183-8bd4-064b519c7ddb@huawei.com>
 <mb61pjzlslwp9.fsf@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <mb61pjzlslwp9.fsf@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100009.china.huawei.com (7.221.188.135)



On 2024/3/24 0:49, Puranjay Mohan wrote:
> Pu Lehui <pulehui@huawei.com> writes:
> 
>> On 2024/3/23 23:46, Puranjay Mohan wrote:
>>> LLVM generates bpf_addr_space_cast instruction while translating
>> [snip]
>>>    
>>>    /* Convert from ninsns to bytes. */
>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>>> index f51b832eafb6..3c389e75cb96 100644
>>> --- a/arch/riscv/net/bpf_jit_comp64.c
>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>>> @@ -1083,6 +1083,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>>    	/* dst = src */
>>>    	case BPF_ALU | BPF_MOV | BPF_X:
>>>    	case BPF_ALU64 | BPF_MOV | BPF_X:
>>> +		if (BPF_CLASS(insn->code) == BPF_ALU64 && insn->off == BPF_ADDR_SPACE_CAST &&
>>> +		    insn->imm == 1U << 16) {
>>> +			emit_mv(RV_REG_T1, rs, ctx); > +			emit_zextw(RV_REG_T1, RV_REG_T1, ctx);
>> combine mv and zextw will be better
> 
> Do you suggest doing:
> 
> emit_zextw(RV_REG_T1, rs, ctx);
> 
> Will do it in next version.
> 
>>> +			emit_imm(rd, (ctx->user_vm_start >> 32) << 32, ctx);
>>> +			emit(rv_beq(RV_REG_T1, RV_REG_ZERO, 4), ctx);
>>> +			emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
>>> +			emit_mv(rd, RV_REG_T1, ctx);
>> ditto, but for or and mv
> 
> How would we combine or and mv?
> also, we have a beq above and in one case both or and mv should happen,
> but in other case only mv should happen.
> 
Okay, another branch is that t1 is zero, but not rd.

> Thanks,
> Puranjay

